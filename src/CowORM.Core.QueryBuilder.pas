unit CowORM.Core.QueryBuilder;

interface

uses
  CowORM.Helpers, CowORM.Commons, CowORM.Core.Tables, CowORM.Core.Columns,
  CowORM.Core.QueryJoin, CowORM.Core.QueryCondition;

type
  TQuery = class(TObject)
  private
    tQueryType: TQueryType;
    oTable    : TTable;
    aWhere    : TArray<TQueryCondition>;
    procedure AddWhere(pCondition: TQueryCondition);
  public
    constructor Create(pTable: string); overload;
    constructor Create(pTable: TTable); overload;

    function Where(pCond: string): TQuery; overload;
    function Where(pLeftField, pRightField: string): TQuery; overload;
    function Where(pLeftField, pCond, pRightField: string): TQuery; overload;
    function Where(pLeftField, pCond: string; pValues: TArray<string>): TQuery; overload;
    function Where(pLeftField, pRightField: TColumn): TQuery; overload;
    function Where(pLeftField: TColumn; pCond: string; pRightField: TColumn): TQuery; overload;
    function Where(pLeftField: TColumn; pCond: string; pValues: TArray<string>): TQuery; overload;
    function WhereIn(pLeftField: string; pValues: TArray<string>): TQuery; overload;
    function WhereIn(pLeftField: TColumn; pValues: TArray<string>): TQuery; overload;
    function WhereNotIn(pLeftField: string; pValues: TArray<string>): TQuery; overload;
    function WhereNotIn(pLeftField: TColumn; pValues: TArray<string>): TQuery; overload;

    function OrWhere(pCond: string): TQuery; overload;
    function OrWhere(pLeftField, pRightField: string): TQuery; overload;
    function OrWhere(pLeftField, pCond, pRightField: string): TQuery; overload;
    function OrWhere(pLeftField, pCond: string; pValues: TArray<string>): TQuery; overload;
    function OrWhere(pLeftField, pRightField: TColumn): TQuery; overload;
    function OrWhere(pLeftField: TColumn; pCond: string; pRightField: TColumn): TQuery; overload;
    function OrWhere(pLeftField: TColumn; pCond: string; pValues: TArray<string>): TQuery; overload;
    function OrWhereIn(pLeftField: string; pValues: TArray<string>): TQuery; overload;
    function OrWhereIn(pLeftField: TColumn; pValues: TArray<string>): TQuery; overload;
    function OrWhereNotIn(pLeftField: string; pValues: TArray<string>): TQuery; overload;
    function OrWhereNotIn(pLeftField: TColumn; pValues: TArray<string>): TQuery; overload;

    property QueryType: TQueryType read tQueryType write tQueryType;
    property Table    : TTable     read oTable     write oTable;
  end;

  TSelectQuery = class(TQuery)
  private
    aColumns  : TArray<TColumn>;
    aJoins    : TArray<TQueryJoin>;
    aOrderBy  : TArray<TColumn>;

    procedure AddJoin(pJoin: TQueryJoin);
  public
    constructor Create(pTable: string); overload;
    constructor Create(pTable: TTable); overload;

    function Join(pJoinType: TJoinType; pTable: TTable; pConditions: TArray<TQueryCondition>): TSelectQuery; overload;
    function Join(pJoinType: TJoinType; pTable: string; pConditions: TArray<TQueryCondition>): TSelectQuery; overload;
    function Join(pTable: TTable; pConditions: TArray<TQueryCondition>): TSelectQuery; overload;
    function Join(pTable: string; pConditions: TArray<TQueryCondition>): TSelectQuery; overload;
    function InnerJoin(pTable: TTable; pConditions: TArray<TQueryCondition>): TSelectQuery; overload;
    function InnerJoin(pTable: string; pConditions: TArray<TQueryCondition>): TSelectQuery; overload;
    function LeftJoin(pTable: TTable; pConditions: TArray<TQueryCondition>): TSelectQuery; overload;
    function LeftJoin(pTable: string; pConditions: TArray<TQueryCondition>): TSelectQuery; overload;
    function RightJoin(pTable: TTable; pConditions: TArray<TQueryCondition>): TSelectQuery; overload;
    function RightJoin(pTable: string; pConditions: TArray<TQueryCondition>): TSelectQuery; overload;
    function OuterJoin(pTable: TTable; pConditions: TArray<TQueryCondition>): TSelectQuery; overload;
    function OuterJoin(pTable: string; pConditions: TArray<TQueryCondition>): TSelectQuery; overload;

    property QueryType;
    property Table;
  end;

implementation

{ TQuery }

procedure TQuery.AddWhere(pCondition: TQueryCondition);
begin
  TArrayUtils<TQueryCondition>.Append(Self.aWhere, pCondition);
end;

constructor TQuery.Create(pTable: string);
begin
  Create(TTable.Create(pTable, 'a'));
end;

constructor TQuery.Create(pTable: TTable);
begin
  inherited Create;
  Self.oTable := pTable;
end;

function TQuery.Where(pLeftField, pRightField: string): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, '=', pRightField).setLeftCondition('and'));
end;

function TQuery.Where(pCond: string): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pCond).setLeftCondition('and'));
end;

function TQuery.Where(pLeftField, pCond, pRightField: string): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, pCond, pRightField).setLeftCondition('and'));
end;

function TQuery.Where(pLeftField: TColumn; pCond: string;
  pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, pCond, pValues).setLeftCondition('and'));
end;

function TQuery.Where(pLeftField: TColumn; pCond: string;
  pRightField: TColumn): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, pCond, pRightField).setLeftCondition('and'));
end;

function TQuery.Where(pLeftField, pCond: string;
  pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, pCond, pValues).setLeftCondition('and'));
end;

function TQuery.Where(pLeftField, pRightField: TColumn): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, '=', pRightField).setLeftCondition('and'));
end;

function TQuery.WhereIn(pLeftField: string; pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, 'in', pValues).setLeftCondition('and'));
end;

function TQuery.WhereIn(pLeftField: TColumn; pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, 'in', pValues).setLeftCondition('and'));
end;

function TQuery.WhereNotIn(pLeftField: string; pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, 'not in', pValues).setLeftCondition('and'));
end;

function TQuery.WhereNotIn(pLeftField: TColumn;
  pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, 'not in', pValues).setLeftCondition('and'));
end;

function TQuery.OrWhere(pLeftField, pRightField: string): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, '=', pRightField).setLeftCondition('or'));
end;

function TQuery.OrWhere(pCond: string): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pCond).setLeftCondition('or'));
end;

function TQuery.OrWhere(pLeftField, pCond, pRightField: string): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, pCond, pRightField).setLeftCondition('or'));
end;

function TQuery.OrWhere(pLeftField: TColumn; pCond: string;
  pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, pCond, pValues).setLeftCondition('or'));
end;

function TQuery.OrWhere(pLeftField: TColumn; pCond: string;
  pRightField: TColumn): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, pCond, pRightField).setLeftCondition('or'));
end;

function TQuery.OrWhere(pLeftField, pCond: string;
  pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, pCond, pValues).setLeftCondition('or'));
end;

function TQuery.OrWhere(pLeftField, pRightField: TColumn): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, '=', pRightField).setLeftCondition('or'));
end;

function TQuery.OrWhereIn(pLeftField: string; pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, 'in', pValues).setLeftCondition('or'));
end;

function TQuery.OrWhereIn(pLeftField: TColumn; pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, 'in', pValues).setLeftCondition('or'));
end;

function TQuery.OrWhereNotIn(pLeftField: string; pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, 'not in', pValues).setLeftCondition('or'));
end;

function TQuery.OrWhereNotIn(pLeftField: TColumn;
  pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TQueryCondition.Create(pLeftField, 'not in', pValues).setLeftCondition('or'));
end;

{ TSelectQuery }

constructor TSelectQuery.Create(pTable: string);
begin
  inherited Create(pTable);
  Self.QueryType := qtSelect;
end;

procedure TSelectQuery.AddJoin(pJoin: TQueryJoin);
begin
  TArrayUtils<TQueryJoin>.Append(Self.aJoins, pJoin);
end;

constructor TSelectQuery.Create(pTable: TTable);
begin
  inherited Create(pTable);
  Self.QueryType := qtSelect;
end;

function TSelectQuery.InnerJoin(pTable: string;
  pConditions: TArray<TQueryCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TQueryJoin.Create(jtInner, pTable, pConditions));
end;

function TSelectQuery.InnerJoin(pTable: TTable;
  pConditions: TArray<TQueryCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TQueryJoin.Create(jtInner, pTable, pConditions));
end;

function TSelectQuery.Join(pJoinType: TJoinType; pTable: string;
  pConditions: TArray<TQueryCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TQueryJoin.Create(pJoinType, pTable, pConditions));
end;

function TSelectQuery.Join(pJoinType: TJoinType; pTable: TTable;
  pConditions: TArray<TQueryCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TQueryJoin.Create(pJoinType, pTable, pConditions));
end;

function TSelectQuery.Join(pTable: string;
  pConditions: TArray<TQueryCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TQueryJoin.Create(jtNone, pTable, pConditions));
end;

function TSelectQuery.Join(pTable: TTable;
  pConditions: TArray<TQueryCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TQueryJoin.Create(jtNone, pTable, pConditions));
end;

function TSelectQuery.LeftJoin(pTable: TTable;
  pConditions: TArray<TQueryCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TQueryJoin.Create(jtLeft, pTable, pConditions));
end;

function TSelectQuery.LeftJoin(pTable: string;
  pConditions: TArray<TQueryCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TQueryJoin.Create(jtLeft, pTable, pConditions));
end;

function TSelectQuery.OuterJoin(pTable: TTable;
  pConditions: TArray<TQueryCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TQueryJoin.Create(jtOuter, pTable, pConditions));
end;

function TSelectQuery.OuterJoin(pTable: string;
  pConditions: TArray<TQueryCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TQueryJoin.Create(jtOuter, pTable, pConditions));
end;

function TSelectQuery.RightJoin(pTable: TTable;
  pConditions: TArray<TQueryCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TQueryJoin.Create(jtRight, pTable, pConditions));
end;

function TSelectQuery.RightJoin(pTable: string;
  pConditions: TArray<TQueryCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TQueryJoin.Create(jtRight, pTable, pConditions));
end;

end.
