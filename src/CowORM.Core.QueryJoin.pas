unit CowORM.Core.QueryJoin;

interface

uses
  CowORM.Commons, CowORM.Core.QueryCondition, CowORM.Core.Tables;

type
  TQueryJoin = class(TObject)
  private
    tJoinType  : TJoinType;
    oTable     : TTable;
    aConditions: TArray<TQueryCondition>;
  public
    constructor Create(pJoinType: TJoinType; pTable: TTable;
      pConditions: TArray<TQueryCondition>); overload;
    constructor Create(pJoinType: TJoinType; pTable: string;
      pConditions: TArray<TQueryCondition>); overload;
    constructor Create(pTable: TTable; pConditions: TArray<TQueryCondition>); overload;
    constructor Create(pTable: string; pConditions: TArray<TQueryCondition>); overload;

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

end.
