unit CowORM.Core.QueryResult;

interface

uses
  CowORM.Commons, CowORM.Helpers, CowORM.Core.QueryParam, Rtti, SysUtils,
  FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TQueryResult = class
  private
    oFDQuery: TFDQuery;
    bLazy   : Boolean;
  public
    constructor Create; overload;
    constructor Create(pConn: TFDConnection; pLazy: Boolean = False); overload;

    function Select(pSQL: string; pParams: TArray<TQueryParam>): TQueryResult; overload;
    function Select(pSQL: string): TQueryResult; overload;

    property Query: TFDQuery read oFDQuery;
    property Lazy : Boolean  read bLazy;
  end;

implementation

{ TQueryResult }

constructor TQueryResult.Create(pConn: TFDConnection; pLazy: Boolean);
begin
  Self.Create;
  Self.oFDQuery.Connection := pConn;
  Self.bLazy               := pLazy;
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
          raise Exception.Create('Error in SelectSQLParam: ' + E.Message);
        end;
      end;
    end;

    try
      Open;
    except
      on E: Exception do
      begin
        raise Exception.Create('Error in SelectSQL: ' + E.Message);
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
