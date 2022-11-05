unit CowORM.Core.Tables;

interface

uses
  CowORM.Commons, CowORM.Helpers, CowORM.Interfaces, System.Rtti;

type
  TTable = class(TCustomAttribute, ITable)
  private
    sName : string;
    sAlias: string;
  protected
    FRefCount: Integer;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    constructor Create(pName, pAlias: string); overload;
    constructor Create(pName: string); overload;

    property RefCount: Integer read FRefCount;
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

function TTable.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TTable._AddRef: Integer;
begin
  Result := -1;
end;

function TTable._Release: Integer;
begin
  Result := -1;
end;

end.
