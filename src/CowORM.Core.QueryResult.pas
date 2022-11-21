unit CowORM.Core.QueryResult;

interface

uses
  CowORM.Commons, CowORM.Helpers, CowORM.Core.QueryParam, CowORM.Interfaces,
  Rtti, SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param, JSON;

type
  TQueryResult = class(TInterfacedObject, IQueryResult, ISerializable)
  private
    oFDQuery   : TFDQuery;
    oConnection: IConnection;
    bLazy      : Boolean;

    procedure SetQuery(Value: TFDQuery);
    function GetQuery: TFDQuery;
    procedure SetLazy(Value: Boolean);
    function GetLazy: Boolean;
    procedure SetConnection(Value: IConnection);
    function GetConnection: IConnection;
  public
    constructor Create; overload;
    constructor Create(pConn: IConnection; pLazy: Boolean = False); overload;

    function Select(pSQL: string; pParams: TArray<IQueryParam>): IQueryResult; overload;
    function Select(pSQL: string): IQueryResult; overload;
    function Serialize: TJSONObject;
    function GetConnectionCopy: IConnection;

    property Query: TFDQuery    read GetQuery;
    property Lazy : Boolean     read GetLazy;
    property Conn : IConnection read GetConnection;
  end;

implementation

{ TQueryResult }

constructor TQueryResult.Create(pConn: IConnection; pLazy: Boolean);
begin
  Self.Create;
  Self.oFDQuery.Connection := pConn.GetConn;
  Self.bLazy               := pLazy;
  Self.oConnection         := pConn;
end;

function TQueryResult.GetConnection: IConnection;
begin
  Result := Self.oConnection;
end;

function TQueryResult.GetConnectionCopy: IConnection;
begin
  Result := Self.oConnection.Duplicate;
end;

function TQueryResult.GetLazy: Boolean;
begin
  Result := Self.bLazy;
end;

function TQueryResult.GetQuery: TFDQuery;
begin
  Result := Self.oFDQuery;
end;

function TQueryResult.Select(pSQL: string): IQueryResult;
begin
  Result := Select(pSQL, []);
end;

function TQueryResult.Serialize: TJSONObject;
begin
  Result := TJSONObject.Create;
  With Result do
  begin
    if Self.oFDQuery <> nil then
      AddPair(TJSONPair.Create('Query', Self.oFDQuery.ClassName))
    else
      AddPair(TJSONPair.Create('Query', TJSONNull.Create));

    if Self.oConnection <> nil then
      AddPair(TJSONPair.Create('Connection', Self.oConnection.Serialize))
    else
      AddPair(TJSONPair.Create('Connection', TJSONNull.Create));

    AddPair(TJSONPair.Create('Lazy', TJSONBool.Create(Self.bLazy)));
  end;
end;

procedure TQueryResult.SetConnection(Value: IConnection);
begin
  Self.oConnection := Value;
end;

procedure TQueryResult.SetLazy(Value: Boolean);
begin
  Self.bLazy := Value;
end;

procedure TQueryResult.SetQuery(Value: TFDQuery);
begin
  Self.oFDQuery := Value;
end;

function TQueryResult.Select(pSQL: string;
  pParams: TArray<IQueryParam>): IQueryResult;
var
  Param: IQueryParam;
begin
  Result := Self;
  with Self.oFDQuery do
  begin
    SQL.Text := pSQL;

    for Param in pParams do
    begin
      try
        ParamByName(Param.GetParamName).Value := Param.GetValue.AsVariant;
      except
        on E: Exception do
        begin
          raise Exception.Create('SelectSQLParam->' + E.Message);
        end;
      end;
    end;

    try
      Open;
    except
      on E: Exception do
      begin
        raise Exception.Create('SelectSQL->' + E.Message);
      end;
    end;
  end;
end;

constructor TQueryResult.Create;
begin
  inherited Create;
  Self.oFDQuery := TFDQuery.Create(nil);
end;

end.
