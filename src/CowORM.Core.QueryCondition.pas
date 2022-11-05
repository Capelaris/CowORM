unit CowORM.Core.QueryCondition;

interface

uses
  CowORM.Commons, CowORM.Interfaces;

type
  TQueryCondition = class(TObject, IQueryCondition)
  protected
    FRefCount: Integer;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    property RefCount: Integer read FRefCount;
  end;

implementation

{ TQueryCondition }

function TQueryCondition.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TQueryCondition._AddRef: Integer;
begin
  Result := -1;
end;

function TQueryCondition._Release: Integer;
begin
  Result := -1;
end;

end.
