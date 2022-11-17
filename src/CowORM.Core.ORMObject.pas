unit CowORM.Core.ORMObject;

interface

uses
  CowORM.Helpers, CowORM.Constants, CowORM.Commons, CowORM.Core.Configurations,
  CowORM.Core.Connection, CowORM.Core.QueryBuilder, CowORM.Core.Columns,
  CowORM.Core.QueryParam, CowORM.Core.Tables, CowORM.Core.QueryResult,
  Rtti, SysUtils, Dialogs, Data.DB, JSON;

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
    isLoaded  : Boolean;
    //procedure AddOldValue(Name: string; Value: TValue);
    //function IsDiff(Col: TColumn; Value: TValue): Boolean;
  public
    { Public Declarations }
    // Create Function
    //procedure Insert;
    // Read Functions
    class function Find<T: class>(Id: Integer): T; overload;
    class function Find<T: class>(Id: Integer; Configs: TConfigs): T; overload;
    class function Find<T: class>(Id: Integer; Conn: TConnection): T; overload;
    class function FindAll<T: class>: TArray<T>; overload;
    class function FindAll<T: class>(Configs: TConfigs): TArray<T>; overload;
    class function FindAll<T: class>(Conn: TConnection): TArray<T>; overload;
    function Serialize: TJSONObject;
    function SerializeProp: TJSONObject;
    function SerializeField: TJSONObject;
    // Update Function
    //procedure Save;
    // Delete Function
    //procedure Delete;

    constructor Create; overload;
    constructor UnlazyCreate(Id: Integer);
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
  Self.isLoaded   := False;
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

                  try
                    if (not PrTP.IsOrdinal) and (PrTP.IsInstance) and
                        (PrTP.BaseType.ToString = 'TORMObject') then
                      if pResult.Lazy then
                        Value := PrTP.GetMethod('Find').Invoke(
                            PrTP.AsInstance.MetaclassType, [Field.AsInteger]).AsObject
                      else
                        Value := PrTP.GetMethod('UnlazyCreate').Invoke(
                            PrTP.AsInstance.MetaclassType, [Field.AsInteger]).AsObject;

                    Prop.SetValue(TORMObject(Obj), Value);
                  except
                    on E: Exception do
                      raise Exception.Create('Error In PopulateFromResult: ' + E.Message);
                  end;
                end;
              end;
            end;
          end;

          TORMObject(Obj).isInserted := True;
          TORMObject(Obj).isLoaded   := True;
          TArrayUtils<T>.Append(Result, Obj);
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

function TORMObject.Serialize: TJSONObject;
begin
  Result := Self.SerializeProp;
end;

function TORMObject.SerializeField: TJSONObject;
var
  Ctx  : TRttiContext;
  Tp   : TRttiType;
  Prop : TRttiProperty;
  Attr : TCustomAttribute;
  PrTP : TRttiInstanceType;
begin
  Result := TJSONObject.Create;
  Ctx    := TRttiContext.Create;

  try
    Tp := Ctx.GetType(Self.ClassType);

    for Prop in Tp.GetProperties do
    begin
      for Attr in Prop.GetAttributes do
      begin
        if (Attr is TColumn) then
        begin
          PrTP := TRttiInstanceType(Prop.PropertyType);
          if (not PrTP.IsOrdinal) and (PrTP.IsInstance) and
            (PrTP.BaseType.ToString = 'TORMObject') then
            Result.AddPair(TJSONPair.Create((Attr as TColumn).Name,
                TORMObject(Prop.GetValue(Self).AsObject).SerializeField))
          else
            Result.AddPair(TJSONPair.Create((Attr as TColumn).Name, Prop.GetValue(Self).ToString));
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

function TORMObject.SerializeProp: TJSONObject;
var
  Ctx  : TRttiContext;
  Tp   : TRttiType;
  Prop : TRttiProperty;
  PrTP : TRttiInstanceType;
begin
  Result := TJSONObject.Create;
  Ctx    := TRttiContext.Create;

  try
    Tp := Ctx.GetType(Self.ClassType);

    for Prop in Tp.GetProperties do
    begin
      PrTP := TRttiInstanceType(Prop.PropertyType);
      if (not PrTP.IsOrdinal) and (PrTP.IsInstance) and
        (PrTP.BaseType.ToString = 'TORMObject') then
        Result.AddPair(TJSONPair.Create(Prop.Name,
            TORMObject(Prop.GetValue(Self).AsObject).SerializeField))
      else
        Result.AddPair(TJSONPair.Create(Prop.Name, Prop.GetValue(Self).ToString));
    end;
  finally
    Ctx.Free;
  end;
end;

constructor TORMObject.UnlazyCreate(Id: Integer);
var
  Ctx  : TRttiContext;
  Tp   : TRttiType;
  Attr : TCustomAttribute;
  Prop : TRttiProperty;
  PK   : TPrimaryKey;
begin
  inherited Create;
  Self.isInserted := True;
  Self.isLoaded   := False;

  Ctx := TRttiContext.Create;
  PK  := nil;
  try
    Tp := Ctx.GetType(Self.ClassType);

    for Attr in Tp.GetAttributes do
      if (Attr is TPrimaryKey) then
        PK := (Attr as TPrimaryKey);

    if PK = nil then
      raise Exception.Create('Error to get PrimaryKey on Create with ID');

    for Prop in Tp.GetProperties do
    begin
      for Attr in Prop.GetAttributes do
      begin
        if Attr is TColumn then
        begin
          if PK.IsKey((Attr as TColumn).Name) then
          begin
            Prop.SetValue(Self, TValue.From(Id));
          end;
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

class function TORMObject.Find<T>(Id: Integer): T;
begin
  Result := TORMObject.Find<T>(Id, DefaultConn);
end;

class function TORMObject.Find<T>(Id: Integer; Configs: TConfigs): T;
begin
  Result := TORMObject.Find<T>(Id, TConnection.Create(Configs));
end;

class function TORMObject.Find<T>(Id: Integer; Conn: TConnection): T;
var
  Ctx        : TRttiContext;
  Tp         : TRttiType;
  Attr       : TCustomAttribute;
  PK         : TPrimaryKey;
  Key        : string;
  Select     : TSelectQuery;
  QueryResult: TQueryResult;
  Params     : TArray<TQueryParam>;
begin
  Result := nil;

  Ctx := TRttiContext.Create;
  try
    Tp := Ctx.GetType(T);

    for Attr in Tp.GetAttributes do
      if (Attr is TPrimaryKey) then
        PK := (Attr as TPrimaryKey);

    if PK = nil then
      raise Exception.Create('Error to get PrimaryKey on Find with ID');

    Select := TORMObject.PrepareSelect<T>;
    for Key in PK.Keys do
      Select.Where(Key, ':id');

    TArrayUtils<TQueryParam>.Append(Params, TQueryParam.Create('id', TValue.From(Id)));

    QueryResult := Conn.Select(Select.GetSQL, Params);

    Result := TORMObject.PopulateFromResult<T>(QueryResult)[0];
  except
    on E: Exception do
      raise Exception.Create('Error in Find: ' + E.Message);
  end;
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
