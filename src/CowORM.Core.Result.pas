unit CowORM.Core.Result;

interface

uses
  CowORM.Commons, CowORM.Helpers, CowORM.Interfaces,
  Rtti, SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param, JSON;

type
  TResult = class(TInterfacedObject, IResult)
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

    function Select(pSQL: string; pParams: TArray<IParam>): IResult; overload;
    function Select(pSQL: string): IResult; overload;
    function Serialize: TJSONObject;
    function GetConnectionCopy: IConnection;

    property Query: TFDQuery    read GetQuery;
    property Lazy : Boolean     read GetLazy;
    property Conn : IConnection read GetConnection;
  end;

implementation

{ TResult }

constructor TResult.Create(pConn: IConnection; pLazy: Boolean);
begin
  Self.Create;
  Self.oFDQuery.Connection := pConn.GetConn;
  Self.bLazy               := pLazy;
  Self.oConnection         := pConn;
end;

function TResult.GetConnection: IConnection;
begin
  Result := Self.oConnection;
end;

function TResult.GetConnectionCopy: IConnection;
begin
  Result := Self.oConnection.Duplicate;
end;

function TResult.GetLazy: Boolean;
begin
  Result := Self.bLazy;
end;

function TResult.GetQuery: TFDQuery;
begin
  Result := Self.oFDQuery;
end;

function TResult.Select(pSQL: string): IResult;
begin
  Result := Select(pSQL, []);
end;

function TResult.Serialize: TJSONObject;
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

procedure TResult.SetConnection(Value: IConnection);
begin
  Self.oConnection := Value;
end;

procedure TResult.SetLazy(Value: Boolean);
begin
  Self.bLazy := Value;
end;

procedure TResult.SetQuery(Value: TFDQuery);
begin
  Self.oFDQuery := Value;
end;

function TResult.Select(pSQL: string;
  pParams: TArray<IParam>): IResult;
var
  Param: IParam;
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

constructor TResult.Create;
begin
  inherited Create;
  Self.oFDQuery := TFDQuery.Create(nil);
end;

end.
