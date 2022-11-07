unit CowORM.Core.QueryCondition;

interface

uses
  CowORM.Commons, CowORM.Core.Columns, SysUtils;

type
  TQueryCondition = class(TObject)
  private
    sCondition    : string;
    sLeftCondition: string;
  public
    constructor Create(Cond: string); overload;
    constructor Create(LeftField, RightField: string); overload;
    constructor Create(LeftField, Cond, RightField: string); overload;
    constructor Create(LeftField: string; Values: TArray<string>); overload;
    constructor Create(LeftField, Cond: string; Values: TArray<string>); overload;
    constructor Create(LeftField, RightField: TColumn); overload;
    constructor Create(LeftField: TColumn; Cond: string; RightField: TColumn); overload;
    constructor Create(LeftField: TColumn; Values: TArray<string>); overload;
    constructor Create(LeftField: TColumn; Cond: string; Values: TArray<string>); overload;

    function setLeftCondition(pCond: string): TQueryCondition;

    property Condition    : string read sCondition;
    property LeftCondition: string read sLeftCondition write sLeftCondition;
  end;

implementation

{ TQueryCondition }

constructor TQueryCondition.Create(Cond: string);
begin
  inherited Create;
  sLeftCondition := 'and';
  sCondition     := Cond;
end;

constructor TQueryCondition.Create(LeftField, RightField: string);
begin
  Create(LeftField, '=', RightField);
end;

constructor TQueryCondition.Create(LeftField, Cond, RightField: string);
begin
  Create(LeftField + ' ' + Cond + ' ' + RightField);
end;

constructor TQueryCondition.Create(LeftField: string; Values: TArray<string>);
begin
  Create(LeftField, 'in', Values);
end;

constructor TQueryCondition.Create(LeftField, Cond: string;
  Values: TArray<string>);
var
  ValueStr: string;
  i: Integer;
begin
  ValueStr := '(';
  for I := 0 to (Length(Values) - 1) do
    ValueStr := ValueStr + QuotedStr(Values[i]) + ', ';
  SetLength(ValueStr, Length(ValueStr) - Length(', '));
  ValueStr := ValueStr + ')';
  Create(LeftField + ' ' + Cond + ' ' + ValueStr);
end;

constructor TQueryCondition.Create(LeftField: TColumn; Cond: string;
  RightField: TColumn);
begin
  Create(LeftField.Name, Cond, RightField.Name);
end;

constructor TQueryCondition.Create(LeftField, RightField: TColumn);
begin
  Create(LeftField.Name, RightField.Name);
end;

function TQueryCondition.setLeftCondition(pCond: string): TQueryCondition;
begin
  Result := Self;
  Self.sLeftCondition := pCond;
end;

constructor TQueryCondition.Create(LeftField: TColumn; Cond: string;
  Values: TArray<string>);
begin
  Create(LeftField.Name, Cond, Values);
end;

constructor TQueryCondition.Create(LeftField: TColumn; Values: TArray<string>);
begin
  Create(LeftField.Name, Values);
end;

end.
