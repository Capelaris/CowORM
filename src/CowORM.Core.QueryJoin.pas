unit CowORM.Core.QueryJoin;

interface

uses
  CowORM.Commons, CowORM.Helpers, CowORM.Core.QueryCondition, CowORM.Core.Tables;

type
  TQueryJoin = class(TObject)
  private
    tJoinType  : TJoinType;
    oTable     : TTable;
    aConditions: TArray<TQueryCondition>;

    function GetType: string;
  public
    constructor Create(pJoinType: TJoinType; pTable: TTable;
      pConditions: TArray<TQueryCondition>); overload;
    constructor Create(pJoinType: TJoinType; pTable: string;
      pConditions: TArray<TQueryCondition>); overload;
    constructor Create(pTable: TTable; pConditions: TArray<TQueryCondition>); overload;
    constructor Create(pTable: string; pConditions: TArray<TQueryCondition>); overload;

    function GenerateSQL(pSpaces: Integer = 0; pTableLabel: string = ''): string;

    property JoinType  : TJoinType               read tJoinType   write tJoinType;
    property Table     : TTable                  read oTable      write oTable;
    property Conditions: TArray<TQueryCondition> read aConditions write aConditions;
  end;

implementation

{ TQueryJoin }

constructor TQueryJoin.Create(pJoinType: TJoinType; pTable: TTable;
  pConditions: TArray<TQueryCondition>);
begin
  inherited Create;
  tJoinType   := pJoinType;
  oTable      := pTable;
  aConditions := pConditions;
end;

constructor TQueryJoin.Create(pJoinType: TJoinType; pTable: string;
  pConditions: TArray<TQueryCondition>);
begin
  Create(pJoinType, TTable.Create(pTable), pConditions);
end;

constructor TQueryJoin.Create(pTable: TTable;
  pConditions: TArray<TQueryCondition>);
begin
  Create(jtNone, pTable, pConditions);
end;

constructor TQueryJoin.Create(pTable: string;
  pConditions: TArray<TQueryCondition>);
begin
  Create(jtNone, TTable.Create(pTable), pConditions);
end;

function TQueryJoin.GenerateSQL(pSpaces: Integer; pTableLabel: string): string;
var
  i: Integer;
begin
  Result := Spaces(pSpaces) + GetType + oTable.Name + ' ' +
      Coalesce([pTableLabel, oTable.Alias]) + ' on';

  for i := 0 to (Length(aConditions) - 1) do
    Result := Result + #13#10 + aConditions[i].GenerateSQL(pSpaces, (i <> 0));
end;

function TQueryJoin.GetType: string;
begin
  Result := '';
  if tJoinType = jtInner then
    Result := 'inner '
  else if tJoinType = jtLeft then
    Result := 'left '
  else if tJoinType = jtRight then
    Result := 'right '
  else if tJoinType = jtOuter then
    Result := 'outer ';
end;

end.
