unit CowORM.Core.QueryResult;

interface

uses
  CowORM.Commons, CowORM.Helpers, CowORM.Core.QueryParam, Rtti, SysUtils,
  FireDAC.Comp.Client;

type
  TQueryResult = class
  private
    oFDQuery: TFDQuery;
  public
    constructor Create; overload;
    constructor Create(Conn: TFDConnection); overload;

    function Select(pSQL: string; pParams: TArray<TQueryParam>): TQueryResult; overload;
    function Select(pSQL: string): TQueryResult; overload;

    property Query: TFDQuery read oFDQuery;
  end;

implementation

{ TQueryResult }

constructor TQueryResult.Create(Conn: TFDConnection);
begin
  Self.Create;
  Self.oFDQuery.Connection := Conn;
end;

function TQueryResult.Select(pSQL: string): TQueryResult;
begin
  Select(pSQL, []);
end;

function TQueryResult.Select(pSQL: string;
  pParams: TArray<TQueryParam>): TQueryResult;
var
  Param: TQueryParam;
begin
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
  end;
end;

constructor TQueryResult.Create;
begin
  inherited Create;
  Self.oFDQuery := TFDQuery.Create(nil);
end;

end.
