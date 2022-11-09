unit CowORM.Core.QueryParams;

interface

uses
  CowORM.Core.Columns, Rtti;

type
  TQueryParam = class
  private
    sFieldName: string;
    sParamName: string;
    oValue    : TValue;
  public
    constructor Create(pFieldName, pParamName: string; pValue: TValue); overload;
    constructor Create(pFieldName: string; pValue: TValue); overload;
    constructor Create(pColumn: TColumn; pValue: TValue); overload;
    constructor Create(pColumn: TColumn; pParamName: string; pValue: TValue); overload;

    property FieldName: string read sFieldName write sFieldName;
    property ParamName: string read sParamName write sParamName;
    property Value    : TValue read oValue     write oValue;
  end;

implementation

{ TQueryParam }

constructor TQueryParam.Create(pFieldName, pParamName: string; pValue: TValue);
begin
  inherited Create;

  with Self do
  begin
    sFieldName := FieldName;
    sParamName := pParamName;
    oValue     := pValue;
  end;
end;

constructor TQueryParam.Create(pFieldName: string; pValue: TValue);
begin
  inherited Create(pFieldName, pFieldName, pValue);
end;

constructor TQueryParam.Create(pColumn: TColumn; pValue: TValue);
begin
  inherited Create(pColumn.Name, pColumn.Name, pValue);
end;

constructor TQueryParam.Create(pColumn: TColumn; pParamName: string;
  pValue: TValue);
begin
  inherited Create(pColumn.Name, pParamName, pValue);
end;

end.
