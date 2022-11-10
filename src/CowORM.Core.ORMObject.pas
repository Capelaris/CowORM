unit CowORM.Core.ORMObject;

interface

uses
  CowORM.Helpers, CowORM.Constants, CowORM.Commons, CowORM.Core.Configurations,
  CowORM.Core.Connection, CowORM.Core.QueryBuilder, CowORM.Core.Columns,
  CowORM.Core.Tables, CowORM.Core.QueryResult, Rtti, SysUtils, Dialogs,
  Data.DB;

type
  TOldValue = class
    Name : string;
    Value: TValue;
  public
    { Public Declarations }
    constructor Create(pName: string; pValue: TValue); overload;
  end;

  TORMObject = class(TObject)
  private
    { Private Declarations }
    aOldValues: TArray<TOldValue>;
    {function ChangedColumns: TColumns; }

    class function GetColumns<T: class>: TArray<TColumn>;
    class function GetTable<T: class>: TTable;
    class function PrepareSelect<T: class>: TSelectQuery;
    class function PopulateFromResult<T: class>(pResult: TQueryResult): TArray<T>;
    procedure AddOldValue(pName: string; pValue: TValue);
  protected
    isInserted: Boolean;
    //procedure AddOldValue(Name: string; Value: TValue);
    //function IsDiff(Col: TColumn; Value: TValue): Boolean;
  public
    { Public Declarations }
    // Create Function
    //procedure Insert;
    // Read Functions
    //class function Find(Id: Integer): T; overload;
    //class function Find(Id: Integer; Configs: TConfigurations): T; overload;
    class function FindAll<T: class>: TArray<T>; overload;
    class function FindAll<T: class>(Configs: TConfigs): TArray<T>; overload;
    class function FindAll<T: class>(Conn: TConnection): TArray<T>; overload;
    // Update Function
    //procedure Save;
    // Delete Function
    //procedure Delete;

    constructor Create;
  end;

implementation

{ TORMObject }

procedure TORMObject.AddOldValue(pName: string; pValue: TValue);
begin
  TArrayUtils<TOldValue>.Append(Self.aOldValues, TOldValue.Create(pName, pValue));
end;

constructor TORMObject.Create;
begin
  inherited Create;
  Self.isInserted := False;
end;

class function TORMObject.FindAll<T>: TArray<T>;
begin
  Result := TORMObject.FindAll<T>(DefaultConn);
end;

class function TORMObject.FindAll<T>(Configs: TConfigs): TArray<T>;
begin
  Result := TORMObject.FindAll<T>(TConnection.Create(Configs));
end;

class function TORMObject.GetColumns<T>: TArray<TColumn>;
var
  Ctx : TRttiContext;
  Tp  : TRttiType;
  Attr: TCustomAttribute;
  Prop: TRttiProperty;
begin
  Result := TArray<TColumn>.Create();

  Ctx := TRttiContext.Create;
  try
    Tp := Ctx.GetType(T);

    for Prop in Tp.GetProperties do
      for Attr in Prop.GetAttributes do
        if Attr is TColumn then
          TArrayUtils<TColumn>.Append(Result, TColumn.Copy(Attr as TColumn));
  finally
    Ctx.Free;
  end;
end;

class function TORMObject.GetTable<T>: TTable;
var
  Ctx : TRttiContext;
  Tp  : TRttiType;
  Attr: TCustomAttribute;
begin
  Result := nil;

  Ctx := TRttiContext.Create;
  try
    Tp := Ctx.GetType(T);

    for Attr in Tp.GetAttributes do
      if Attr is TTable then
        Result := TTable.Copy(Attr as TTable);
  finally
    Ctx.Free;
  end;
end;

class function TORMObject.PopulateFromResult<T>(
  pResult: TQueryResult): TArray<T>;
var
  Ctx  : TRttiContext;
  Tp   : TRttiType;
  Prop : TRttiProperty;
  PrTP : TRttiInstanceType;
  Attr : TCustomAttribute;
  Field: TField;
  Obj  : T;
  Value: TValue;
begin
  Result := TArray<T>.Create();
  Ctx    := TRttiContext.Create;

  try
    Tp := Ctx.GetType(T);

    with pResult.Query do
    begin
      First;
      while not Eof do
      begin
        try
          Obj := T(Tp.GetMethod('Create').Invoke(Tp.AsInstance.MetaclassType,
              []).AsObject);

          for Prop in Tp.GetProperties do
          begin
            for Attr in Prop.GetAttributes do
            begin
              if (Attr is TColumn) then
              begin
                Field := FieldByName((Attr as TColumn).Name);
                if Field <> nil then
                begin
                  Value := (Attr as TColumn).GetValue(Field);

                  TORMObject(Obj).AddOldValue((Attr as TColumn).Name, Value);

                  PrTP := TRttiInstanceType(Prop.PropertyType);
                  if PrTP.BaseType.Name.StartsWith('TORMObject') then
                  begin
                    {Val := PropType.BaseType.GetMethod('Find').Invoke(
                        PropType.BaseType.AsInstance.MetaclassType, [Field.AsInteger]);}
                  end
                  else
                  begin
                    Prop.SetValue(TORMObject(Obj), Value);
                  end;
                end;
              end;
            end;
          end;
        except
          on E: Exception do
            raise Exception.Create('Error in PopulateFromResult: ' + E.Message);
        end;

        Next;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

class function TORMObject.PrepareSelect<T>: TSelectQuery;
begin
  Result := TSelectQuery.Create(TORMObject.GetTable<T>);
  Result.SetColumns(TORMObject.GetColumns<T>);
end;

class function TORMObject.FindAll<T>(Conn: TConnection): TArray<T>;
var
  QueryResult: TQueryResult;
begin
  Result := TArray<T>.Create();
  try
    QueryResult := Conn.Select(TORMObject.PrepareSelect<T>.GetSQL);

    Result := TORMObject.PopulateFromResult<T>(QueryResult);
  except
    on E: Exception do
      raise Exception.Create('Error in FindAll: ' + E.Message);
  end;
end;

{ TOldValue }

constructor TOldValue.Create(pName: string; pValue: TValue);
begin
  inherited Create;
  Self.Name  := pName;
  Self.Value := pValue;
end;

end.
