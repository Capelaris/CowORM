unit CowORM.Core.QueryParam;

interface

uses
  CowORM.Core.Columns, CowORM.Interfaces, Rtti, JSON;

type
  TQueryParam = class(TInterfacedObject, IQueryParam, ISerializable)
  private
    sFieldName: string;
    sParamName: string;
    oValue    : TValue;

    procedure SetFieldName(Value: string);
    function GetFieldName: string;
    procedure SetParamName(Value: string);
    function GetParamName: string;
    procedure SetValue(Value: TValue);
    function GetValue: TValue;
  public
    constructor Create(pFieldName, pParamName: string; pValue: TValue); overload;
    constructor Create(pFieldName: string; pValue: TValue); overload;
    constructor Create(pColumn: TColumn; pValue: TValue); overload;
    constructor Create(pColumn: TColumn; pParamName: string; pValue: TValue); overload;
    function Serialize: TJSONObject;

    property FieldName: string read GetFieldName write SetFieldName;
    property ParamName: string read GetParamName write SetParamName;
    property Value    : TValue read GetValue     write SetValue;
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
  Create(pFieldName, pFieldName, pValue);
end;

constructor TQueryParam.Create(pColumn: TColumn; pValue: TValue);
begin
  Create(pColumn.Name, pColumn.Name, pValue);
end;

constructor TQueryParam.Create(pColumn: TColumn; pParamName: string;
  pValue: TValue);
begin
  Create(pColumn.Name, pParamName, pValue);
end;

function TQueryParam.GetFieldName: string;
begin
  Result := Self.sFieldName;
end;

function TQueryParam.GetParamName: string;
begin
  Result := Self.sParamName;
end;

function TQueryParam.GetValue: TValue;
begin
  Result := Self.oValue;
end;

function TQueryParam.Serialize: TJSONObject;
begin
  Result := TJSONObject.Create;
  With Result do
  begin
    AddPair(TJSONPair.Create('FieldName', Self.sFieldName));
    AddPair(TJSONPair.Create('ParamName', Self.sParamName));
    AddPair(TJSONPair.Create('Value', Self.oValue.AsString));
  end;
end;

procedure TQueryParam.SetFieldName(Value: string);
begin
  Self.sFieldName := Value;
end;

procedure TQueryParam.SetParamName(Value: string);
begin
  Self.sParamName := Value;
end;

procedure TQueryParam.SetValue(Value: TValue);
begin
  Self.oValue := Value;
end;

end.
