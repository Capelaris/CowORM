unit CowORM.Core.QueryResult;

interface

uses
  CowORM.Commons, CowORM.Helpers, CowORM.Core.QueryParam, CowORM.Core.Connection,
  Rtti, SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TQueryResult = class
  private
    oFDQuery   : TFDQuery;
    oConnection: TConnection;
    bLazy      : Boolean;
  public
    constructor Create; overload;
    constructor Create(pConn: TConnection; pLazy: Boolean = False); overload;

    function Select(pSQL: string; pParams: TArray<TQueryParam>): TQueryResult; overload;
    function Select(pSQL: string): TQueryResult; overload;

    property Query: TFDQuery    read oFDQuery;
    property Lazy : Boolean     read bLazy;
    property Conn : TConnection read oConnection;
  end;

implementation

{ TQueryResult }

constructor TQueryResult.Create(pConn: TConnection; pLazy: Boolean);
begin
  Self.Create;
  Self.oFDQuery.Connection := pConn.Conn;
  Self.bLazy               := pLazy;
  Self.oConnection         := pConn;
end;

function TQueryResult.Select(pSQL: string): TQueryResult;
begin
  Result := Select(pSQL, []);
end;

function TQueryResult.Select(pSQL: string;
  pParams: TArray<TQueryParam>): TQueryResult;
var
  Param: TQueryParam;
begin
  Result := Self;
  with Self.oFDQuery do
  begin
    SQL.Text := pSQL;

    for Param in pParams do
    begin
      try
        ParamByName(Param.ParamName).Value := Param.Value.AsVariant;
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
