unit CowORM.Core.Tables;

interface

uses
  CowORM.Commons, CowORM.Helpers, System.Rtti;

type
  TTable = class(TCustomAttribute)
  private
    sName : string;
    sAlias: string;
  public
    constructor Create(pName, pAlias: string); overload;
    constructor Create(pName: string); overload;

    property Name    : string  read sName  write sName;
    property Alias   : string  read sAlias write sAlias;
  end;

implementation

{ TTable }

constructor TTable.Create(pName: string);
var
  ArrStr: TArray<string>;
begin
  ArrStr := GetWords(pName);

  if Length(ArrStr) > 1 then
    Self.Create(ArrStr[0], ArrStr[1])
  else
    Self.Create(ArrStr[0], '');
end;

constructor TTable.Create(pName, pAlias: string);
begin
  inherited Create;

  with Self do
  begin
    sName  := pName;
    sAlias := pAlias;
  end;
end;

end.
