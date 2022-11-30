unit CowORM.Core.ORMObject;

interface

uses
  Data.DB, CowORM.Helpers, CowORM.Constants, CowORM.Commons, CowORM.Core.Configurations,
  CowORM.Core.Connection, CowORM.Core.Param, CowORM.Core.Result, CowORM.Interfaces,
  Rtti, SysUtils, Dialogs, JSON, PigQuery;

type
  TOldValue = class
    Name : string;
    Value: TValue;
  public
    { Public Declarations }
    constructor Create(pName: string; pValue: TValue); overload;
  end;

  TORMObject = class(TInterfacedObject, ISerializable)
  private
    { Private Declarations }
    aOldValues: TArray<TOldValue>;
    oLastConn : IConnection;
    aColumns  : TArray<TColumn>;
    oTable    : TTable;
    {function ChangedColumns: TColumns; }

    class function GetColumns<T: class>: TArray<TColumn>; overload;
    class function GetTable<T: class>: TTable; overload;
    class function PrepareSelect<T: class>: TSelectQuery; overload;
    class function PopulateFromResult<T: class>(pResult: IResult): TArray<T>; overload;

    function GetColumns: TArray<TColumn>; overload;
    function GetTable: TTable; overload;
    function PrepareSelect: TSelectQuery; overload;
    procedure PopulateFromResult(pResult: IResult); overload;

    function GetPrimaryKeyValue: Integer;
    procedure AddOldValue(pName: string; pValue: TValue);
  protected
    isInserted: Boolean;
    isLoaded  : Boolean;
    isLoading : Boolean;
    //function IsDiff(Col: TColumn; Value: TValue): Boolean;
    procedure CheckLazy;
  public
    { Public Declarations }
    // Create Function
    constructor Create; overload;
    constructor UnlazyCreate(Id: Integer; Lazy: Boolean; LastConn: IConnection);
    // Read Functions
    class function Find<T: class>(Id: Integer): T; overload;
    class function Find<T: class>(Id: Integer; Configs: IConfigs): T; overload;
    class function Find<T: class>(Id: Integer; Conn: IConnection): T; overload;
    class function FindAll<T: class>: TArray<T>; overload;
    class function FindAll<T: class>(Configs: IConfigs): TArray<T>; overload;
    class function FindAll<T: class>(Conn: IConnection): TArray<T>; overload;
    function Serialize: TJSONObject;
    function SerializeProp: TJSONObject;
    function SerializeField: TJSONObject;
    // Update Function
    procedure Save;
    // Delete Function
    procedure Delete;
  end;

implementation

{ TORMObject }

procedure TORMObject.AddOldValue(pName: string; pValue: TValue);
begin
  TArrayUtils<TOldValue>.Append(Self.aOldValues, TOldValue.Create(pName, pValue));
end;

procedure TORMObject.CheckLazy;
var
  Ctx        : TRttiContext;
  Tp         : TRttiType;
  Attr       : TCustomAttribute;
  PK         : TPrimaryKey;
  Key        : string;
  Select     : TSelectQuery;
  QueryResult: IResult;
  Params     : TArray<IParam>;
begin
  if (not Self.isLoaded) and (not Self.isLoading) and (Self.isInserted) then
  begin
    PK := nil;
    Self.isLoaded := True;
    Ctx := TRttiContext.Create;
    try
      if Self.oLastConn <> nil then
      begin
        Tp := Ctx.GetType(Self.ClassType);

        for Attr in Tp.GetAttributes do
          if (Attr is TPrimaryKey) then
            PK := (Attr as TPrimaryKey);

        if PK = nil then
          raise Exception.Create('Error to get PrimaryKey on Find with ID');

        Select := Self.PrepareSelect;
        for Key in PK.Keys do
          Select.Where(Key, ':id');

        TArrayUtils<IParam>.Append(Params, TParam.Create('id', TValue.From(Self.GetPrimaryKeyValue)));
        QueryResult := Self.oLastConn.Select(Select.GetSQL, Params);
        Self.PopulateFromResult(QueryResult);
      end;
    except
      on E: Exception do
      begin
        Self.isLoaded := False;
        raise Exception.Create('CheckLazy->' + E.Message);
      end;
    end;
  end;
end;

constructor TORMObject.Create;
begin
  inherited Create;
  Self.isInserted := False;
  Self.isLoaded   := False;
  Self.isLoading  := False;
end;

procedure TORMObject.Delete;
var
  Ctx   : TRttiContext;
  Tp    : TRttiType;
  Attr  : TCustomAttribute;
  Prop  : TRttiProperty;
  PK    : TPrimaryKey;
  Params: TArray<IParam>;
  Query : TDeleteQuery;
begin
  if (Self.isInserted) then
  begin
    PK  := nil;
    Ctx := TRttiContext.Create;

    try
      Tp := Ctx.GetType(Self.ClassType);

      for Attr in Tp.GetAttributes do
        if (Attr is TPrimaryKey) then
          PK := (Attr as TPrimaryKey);

      if PK = nil then
        raise Exception.Create('Error to get PrimaryKey on Find with ID');

      TArrayUtils<IParam>.Append(Params, TParam.Create('id', TValue.From(Self.GetPrimaryKeyValue)));
      Query := TDeleteQuery.Create(Self.GetTable);
      Query.Where(PK.Keys[0], '=', ':id');
      try
        Self.oLastConn.ExecuteSQL(Query.GetSQL, Params);
      except
        on E: Exception do
        begin
          if E.Message.ToLower.Contains('violation of foreign key') then
            raise Exception.Create('Delete: Error to delete, Object is referenced in foreign key');
        end;
      end;
    finally
      Ctx.Free;
    end;
  end;
end;

class function TORMObject.FindAll<T>: TArray<T>;
begin
  Result := TORMObject.FindAll<T>(DefaultConn);
end;

class function TORMObject.FindAll<T>(Configs: IConfigs): TArray<T>;
begin
  Result := TORMObject.FindAll<T>(TConnection.Create(Configs));
end;

function TORMObject.GetColumns: TArray<TColumn>;
var
  Ctx : TRttiContext;
  Tp  : TRttiType;
  Attr: TCustomAttribute;
  Prop: TRttiProperty;
  PK  : TPrimaryKey;
begin
  Result := TArray<TColumn>.Create();

  Ctx := TRttiContext.Create;
  try
    Tp := Ctx.GetType(Self.ClassType);

    for Prop in Tp.GetProperties do
      for Attr in Prop.GetAttributes do
        if Attr is TColumn then
          TArrayUtils<TColumn>.Append(Result, TColumn.Copy(Attr as TColumn));
  finally
    Ctx.Free;
  end;
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

function TORMObject.GetPrimaryKeyValue: Integer;
var
  Ctx : TRttiContext;
  Tp  : TRttiType;
  Attr: TCustomAttribute;
  PK  : TPrimaryKey;
  Prop: TRttiProperty;
begin
  Result := -1;

  Ctx := TRttiContext.Create;
  try
    PK := nil;
    Tp := Ctx.GetType(Self.ClassType);

    for Attr in Tp.GetAttributes do
      if Attr is TPrimaryKey then
        PK := (Attr as TPrimaryKey);

    for Prop in Tp.GetProperties do
      for Attr in Prop.GetAttributes do
        if Attr is TColumn then
          if PK.IsKey((Attr as TColumn).Name) then
            Result := Prop.GetValue(Self).AsInteger;
  finally
    Ctx.Free;
  end;
end;

function TORMObject.GetTable: TTable;
var
  Ctx : TRttiContext;
  Tp  : TRttiType;
  Attr: TCustomAttribute;
begin
  Result := nil;

  Ctx := TRttiContext.Create;
  try
    Tp := Ctx.GetType(Self.ClassType);

    for Attr in Tp.GetAttributes do
      if Attr is TTable then
        Result := TTable.Copy(Attr as TTable);
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

procedure TORMObject.PopulateFromResult(pResult: IResult);
var
  Ctx  : TRttiContext;
  Tp   : TRttiType;
  Prop : TRttiProperty;
  PrTP : TRttiInstanceType;
  Attr : TCustomAttribute;
  Field: TField;
  Value: TValue;
begin
  Ctx := TRttiContext.Create;

  try
    Tp := Ctx.GetType(Self.ClassType);

    with pResult.GetQuery do
    begin
      First;
      while not Eof do
      begin
        try
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

                  Self.AddOldValue((Attr as TColumn).Name, Value);

                  PrTP := TRttiInstanceType(Prop.PropertyType);

                  try
                    if (not PrTP.IsOrdinal) and (PrTP.IsInstance) and
                        (PrTP.BaseType.ToString = 'TORMObject') then
                    begin
                      Value := PrTP.GetMethod('UnlazyCreate').Invoke(
                          PrTP.AsInstance.MetaclassType,
                          [Field.AsInteger, pResult.GetLazy, TValue.From(TResult(pResult).Conn)]).AsObject;
                    end;

                    Self.oLastConn := TResult(pResult).Conn;
                    Prop.SetValue(Self, Value);
                  except
                    on E: Exception do
                      raise Exception.Create('PopulateFromResult->' + E.Message);
                  end;
                end;
              end;
            end;
          end;

          Self.isInserted := True;
        except
          on E: Exception do
            raise Exception.Create('PopulateFromResult->' + E.Message);
        end;

        Next;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

class function TORMObject.PopulateFromResult<T>(pResult: IResult): TArray<T>;
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

    with pResult.GetQuery do
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
                    begin
                      Value := PrTP.GetMethod('UnlazyCreate').Invoke(
                          PrTP.AsInstance.MetaclassType,
                          [Field.AsInteger, pResult.GetLazy, TValue.From(TResult(pResult).Conn)]).AsObject;
                    end;

                    TORMObject(obj).oLastConn := TResult(pResult).Conn;
                    Prop.SetValue(TORMObject(Obj), Value);
                  except
                    on E: Exception do
                      raise Exception.Create('PopulateFromResult->' + E.Message);
                  end;
                end;
              end;
            end;
          end;

          TORMObject(Obj).isInserted := True;
          TArrayUtils<T>.Append(Result, Obj);
        except
          on E: Exception do
            raise Exception.Create('PopulateFromResult->' + E.Message);
        end;

        Next;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

function TORMObject.PrepareSelect: TSelectQuery;
var
  Arr : TArray<TColumn>;
begin
  Result := TSelectQuery.Create(Self.GetTable);
  Arr    := Self.GetColumns;
  Result.SetColumns(Arr);
end;

class function TORMObject.PrepareSelect<T>: TSelectQuery;
var
  Arr : TArray<TColumn>;
begin
  Result := TSelectQuery.Create(TORMObject.GetTable<T>);
  Arr    := TORMObject.GetColumns<T>;
  Result.SetColumns(Arr);
end;

procedure TORMObject.Save;
var
  InsertQ: TInsertQuery;
  UpdateQ: TUpdateQuery;
  Cols   : TArray<TColumn>;
  Ctx    : TRttiContext;
  Tp     : TRttiType;
  Prop   : TRttiProperty;
  Attr   : TCustomAttribute;
begin
  Ctx := TRttiContext.Create;
  try
    Tp := Ctx.GetType(Self.ClassType);

    if (Self.isInserted) then
    begin
      Cols    := Self.GetColumns;
      InsertQ := TInsertQuery.Create(Self.GetTable);
      for Prop in Tp.GetProperties do
      begin
        for Attr in Prop.GetAttributes do
        begin
          if (Attr is TColumn) then
          begin
            InsertQ.SetPair((Attr as TColumn).Name, Prop.GetValue(Self));
          end;
        end;
      end;

      try
        Self.oLastConn.ExecuteSQL(InsertQ.GetSQL);
      except
        on E: Exception do
        begin
          raise Exception.Create(E.Message);
        end;
      end;
    end
    else
    begin

    end;
  finally
    Ctx.Free;
  end;
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
  Obj  : TORMObject;
begin
  Self.CheckLazy;
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
          begin
            Obj := TORMObject(Prop.GetValue(Self).AsObject);
            if Obj <> nil then
            begin
              Obj.CheckLazy;
              Prop.SetValue(Self, TValue.From(Obj));
              Result.AddPair(TJSONPair.Create((Attr as TColumn).Name,
                  Obj.SerializeField));
            end
            else
              Result.AddPair(TJSONPair.Create(Prop.Name, TJSONNull.Create));
          end
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
  Ctx : TRttiContext;
  Tp  : TRttiType;
  Prop: TRttiProperty;
  PrTP: TRttiInstanceType;
  Obj : TORMObject;
begin
  Self.CheckLazy;
  Result := TJSONObject.Create;
  Ctx    := TRttiContext.Create;

  try
    Tp := Ctx.GetType(Self.ClassType);

    for Prop in Tp.GetProperties do
    begin
      PrTP := TRttiInstanceType(Prop.PropertyType);
      if (not PrTP.IsOrdinal) and (PrTP.IsInstance) and
        (PrTP.BaseType.ToString = 'TORMObject') then
      begin
        Obj := TORMObject(Prop.GetValue(Self).AsObject);
        if Obj <> nil then
        begin
          Obj.CheckLazy;
          Prop.SetValue(Self, TValue.From(Obj));
          Result.AddPair(TJSONPair.Create(Prop.Name,
              Obj.SerializeField));
        end
        else
          Result.AddPair(TJSONPair.Create(Prop.Name, TJSONNull.Create));
      end
      else
        Result.AddPair(TJSONPair.Create(Prop.Name, Prop.GetValue(Self).ToString));
    end;
  finally
    Ctx.Free;
  end;
end;

constructor TORMObject.UnlazyCreate(Id: Integer; Lazy: Boolean;
  LastConn: IConnection);
var
  Ctx  : TRttiContext;
  Tp   : TRttiType;
  Attr : TCustomAttribute;
  Prop : TRttiProperty;
  PK   : TPrimaryKey;
begin
  inherited Create;
  Self.isInserted := True;
  Self.isLoading  := True;
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
            Prop.SetValue(Self, Id);
          end;
        end;
      end;
    end;

    Self.oLastConn := LastConn.Duplicate;

    Self.isLoading := False;

    if not Lazy then
      Self.CheckLazy;
  finally
    Ctx.Free;
  end;
end;

class function TORMObject.Find<T>(Id: Integer): T;
begin
  Result := TORMObject.Find<T>(Id, DefaultConn);
end;

class function TORMObject.Find<T>(Id: Integer; Configs: IConfigs): T;
begin
  Result := TORMObject.Find<T>(Id, TConnection.Create(Configs));
end;

class function TORMObject.Find<T>(Id: Integer; Conn: IConnection): T;
var
  Ctx        : TRttiContext;
  Tp         : TRttiType;
  Attr       : TCustomAttribute;
  PK         : TPrimaryKey;
  Key        : string;
  Select     : TSelectQuery;
  QueryResult: IResult;
  Params     : TArray<IParam>;
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

    TArrayUtils<IParam>.Append(Params, TParam.Create('id', TValue.From(Id)));

    QueryResult := Conn.Select(Select.GetSQL, Params);

    Result := TORMObject.PopulateFromResult<T>(QueryResult)[0];
  except
    on E: Exception do
      raise Exception.Create('Find->' + E.Message);
  end;
end;

class function TORMObject.FindAll<T>(Conn: IConnection): TArray<T>;
var
  QueryResult: IResult;
begin
  Result := TArray<T>.Create();
  try
    QueryResult := Conn.Select(TORMObject.PrepareSelect<T>.GetSQL);

    Result := TORMObject.PopulateFromResult<T>(QueryResult);
  except
    on E: Exception do
      raise Exception.Create('FindAll->' + E.Message);
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
