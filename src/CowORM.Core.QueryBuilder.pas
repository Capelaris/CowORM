unit CowORM.Core.QueryBuilder;

interface

uses
  CowORM.Helpers, CowORM.Commons, CowORM.Core.Tables, CowORM.Core.Columns,
  CowORM.Core.QueryJoin, CowORM.Core.QueryCondition, Rtti, Variants, SysUtils;

type
  TQuery = class(TObject)
  private
    tQueryType: TQueryType;
    oTable    : TTable;
    aWhere    : TArray<TQueryCondition>;
    procedure AddWhere(pCondition: TQueryCondition);
    function GenerateSQL: string; virtual; abstract;
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
    sSQL      : string;

    procedure AddJoin(pJoin: TQueryJoin);
    function GenerateSQL: string; override;
  public
    constructor Create(pTable: string); overload;
    constructor Create(pTable: TTable); overload;

    function SetColumns(pColumns: TArray<TColumn>): TSelectQuery;

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

    function Where(pCond: string): TSelectQuery; overload;
    function Where(pLeftField, pRightField: string): TSelectQuery; overload;
    function Where(pLeftField, pCond, pRightField: string): TSelectQuery; overload;
    function Where(pLeftField, pCond: string; pValues: TArray<string>): TSelectQuery; overload;
    function Where(pLeftField, pRightField: TColumn): TSelectQuery; overload;
    function Where(pLeftField: TColumn; pCond: string; pRightField: TColumn): TSelectQuery; overload;
    function Where(pLeftField: TColumn; pCond: string; pValues: TArray<string>): TSelectQuery; overload;
    function WhereIn(pLeftField: string; pValues: TArray<string>): TSelectQuery; overload;
    function WhereIn(pLeftField: TColumn; pValues: TArray<string>): TSelectQuery; overload;
    function WhereNotIn(pLeftField: string; pValues: TArray<string>): TSelectQuery; overload;
    function WhereNotIn(pLeftField: TColumn; pValues: TArray<string>): TSelectQuery; overload;

    function OrWhere(pCond: string): TSelectQuery; overload;
    function OrWhere(pLeftField, pRightField: string): TSelectQuery; overload;
    function OrWhere(pLeftField, pCond, pRightField: string): TSelectQuery; overload;
    function OrWhere(pLeftField, pCond: string; pValues: TArray<string>): TSelectQuery; overload;
    function OrWhere(pLeftField, pRightField: TColumn): TSelectQuery; overload;
    function OrWhere(pLeftField: TColumn; pCond: string; pRightField: TColumn): TSelectQuery; overload;
    function OrWhere(pLeftField: TColumn; pCond: string; pValues: TArray<string>): TSelectQuery; overload;
    function OrWhereIn(pLeftField: string; pValues: TArray<string>): TSelectQuery; overload;
    function OrWhereIn(pLeftField: TColumn; pValues: TArray<string>): TSelectQuery; overload;
    function OrWhereNotIn(pLeftField: string; pValues: TArray<string>): TSelectQuery; overload;
    function OrWhereNotIn(pLeftField: TColumn; pValues: TArray<string>): TSelectQuery; overload;

    function OrderBy(pColumn: TColumn): TSelectQuery; overload;
    function OrderBy(pColumn: string): TSelectQuery; overload;
    function OrderBy(pColumns: TArray<TColumn>): TSelectQuery; overload;
    function OrderBy(pColumns: TArray<string>): TSelectQuery; overload;

    function GetSQL: string; overload;
    function GetSQL(pColumns: TArray<TColumn>): string; overload;
    function GetSQL(pColumns: TArray<string>): string; overload;

    property QueryType;
    property Table;
  end;

  TDeleteQuery = class(TQuery)
  private
    sSQL: string;
    function GenerateSQL: string; override;
  public
    function GetSQL: string;
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

function TSelectQuery.GenerateSQL: string;
var
  i: Integer;
begin
  try
    Self.sSQL := 'select ';
    for i := 0 to (Length(Self.aColumns) - 1) do
    begin
      if i <> 0 then
        Self.sSQL := Self.sSQL + Spaces(7);

      Self.sSQL := Self.sSQL + Coalesce([Self.aColumns[i].TableLabel, GetTableLabel(1)]) +
          '.' + Self.aColumns[i].Name + ',' + #13#10;
    end;

    SetLength(Self.sSQL, Length(Self.sSQL) - Length(',' + #13#10));

    Self.sSQL := Self.sSQL + #13#10 + 'from ' + Self.oTable.Name + ' ' + Coalesce([Self.oTable.Alias, GetTableLabel(1)]);

    if Length(Self.aJoins) > 0 then
    begin
      for i := 0 to (Length(Self.aJoins) - 1) do
        Self.sSQL := Self.sSQL + #13#10 + Self.aJoins[i].GenerateSQL(0, GetTableLabel(i + 2));
    end;

    if Length(Self.aWhere) > 0 then
    begin
      Self.sSQL := Self.sSQL + #13#10 + 'where ';
      for i := 0 to (Length(Self.aWhere) - 1) do
        Self.sSQL := Self.sSQL + Self.aWhere[i].GenerateSQL(6, (i <> 0));
    end;

    if Length(Self.aOrderBy) > 0 then
    begin
      Self.sSQL := Self.sSQL + #13#10 + 'order by ';
      for i := 0 to (Length(Self.aOrderBy) - 1) do
      begin
        if i <> 0 then
          Self.sSQL := Self.sSQL + Spaces(9);

        Self.sSQL := Self.sSQL + Coalesce([Self.aOrderBy[i].TableLabel, oTable.Alias]) +
            '.' + Self.aOrderBy[i].Name + ',' + #13#10;
      end;

      SetLength(Self.sSQL, Length(Self.sSQL) - Length(',' + #13#10));
    end;
  except
    on E: Exception do
    begin
      Self.sSQL := '';
      raise Exception.Create('Erro ao gerar SelectSQL: ' + E.Message);
    end;
  end;

  Result := Self.sSQL;
end;

function TSelectQuery.GetSQL: string;
begin
  Result := GenerateSQL;
end;

function TSelectQuery.GetSQL(pColumns: TArray<TColumn>): string;
begin
  Self.SetColumns(pColumns);
  Result := GetSQL;
end;

function TSelectQuery.GetSQL(pColumns: TArray<string>): string;
var
  Columns: TArray<TColumn>;
  Column : string;
begin
  for Column in pColumns do
    TArrayUtils<TColumn>.Append(Columns, TColumn.Create(Column, ctUnknown, -1, -1, False, '', '', TValue.From<Variant>(Null)));
  Result := GetSQL(Columns);
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

function TSelectQuery.OrderBy(pColumn: TColumn): TSelectQuery;
begin
  Result := OrderBy([pColumn]);
end;

function TSelectQuery.OrderBy(pColumn: string): TSelectQuery;
begin
  Result := OrderBy(TColumn.Create(pColumn, ctUnknown, -1, -1, False, '', '', TValue.From<Variant>(Null)));
end;

function TSelectQuery.OrderBy(pColumns: TArray<TColumn>): TSelectQuery;
begin
  Result := Self;
  TArrayUtils<TColumn>.Append(aOrderBy, pColumns);
end;

function TSelectQuery.OrderBy(pColumns: TArray<string>): TSelectQuery;
var
  Columns: TArray<TColumn>;
  Column : string;
begin
  for Column in pColumns do
    TArrayUtils<TColumn>.Append(Columns, TColumn.Create(Column, ctUnknown, -1, -1, False, '', '', TValue.From<Variant>(Null)));
  Result := OrderBy(Columns);
end;

function TSelectQuery.OrWhere(pLeftField, pCond,
  pRightField: string): TSelectQuery;
begin
  inherited OrWhere(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TSelectQuery.OrWhere(pLeftField, pRightField: string): TSelectQuery;
begin
  inherited OrWhere(pLeftField, pRightField);
  Result := Self;
end;

function TSelectQuery.OrWhere(pCond: string): TSelectQuery;
begin
  inherited OrWhere(pCond);
  Result := Self;
end;

function TSelectQuery.OrWhere(pLeftField, pCond: string;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited OrWhere(pLeftField, pCond, pValues);
  Result := Self;
end;

function TSelectQuery.OrWhere(pLeftField: TColumn; pCond: string;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited OrWhere(pLeftField, pCond, pValues);
  Result := Self;
end;

function TSelectQuery.OrWhere(pLeftField: TColumn; pCond: string;
  pRightField: TColumn): TSelectQuery;
begin
  inherited OrWhere(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TSelectQuery.OrWhere(pLeftField, pRightField: TColumn): TSelectQuery;
begin
  inherited OrWhere(pLeftField, pRightField);
  Result := Self;
end;

function TSelectQuery.OrWhereIn(pLeftField: string;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited OrWhereIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.OrWhereIn(pLeftField: TColumn;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited OrWhereIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.OrWhereNotIn(pLeftField: TColumn;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited OrWhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.OrWhereNotIn(pLeftField: string;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited OrWhereNotIn(pLeftField, pValues);
  Result := Self;
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

function TSelectQuery.SetColumns(pColumns: TArray<TColumn>): TSelectQuery;
begin
  aColumns := pColumns;
  Result   := Self;
end;

function TSelectQuery.Where(pLeftField, pRightField: string): TSelectQuery;
begin
  inherited Where(pLeftField, pRightField);
  Result := Self;
end;

function TSelectQuery.Where(pCond: string): TSelectQuery;
begin
  inherited Where(pCond);
  Result := Self;
end;

function TSelectQuery.Where(pLeftField, pCond,
  pRightField: string): TSelectQuery;
begin
  inherited Where(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TSelectQuery.Where(pLeftField: TColumn; pCond: string;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited Where(pLeftField, pCond, pValues);
  Result := Self;
end;

function TSelectQuery.Where(pLeftField: TColumn; pCond: string;
  pRightField: TColumn): TSelectQuery;
begin
  inherited Where(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TSelectQuery.Where(pLeftField, pCond: string;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited Where(pLeftField, pCond, pValues);
  Result := Self;
end;

function TSelectQuery.Where(pLeftField, pRightField: TColumn): TSelectQuery;
begin
  inherited Where(pLeftField, pRightField);
  Result := Self;
end;

function TSelectQuery.WhereIn(pLeftField: string;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited WhereIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.WhereIn(pLeftField: TColumn;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited WhereIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.WhereNotIn(pLeftField: string;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited WhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.WhereNotIn(pLeftField: TColumn;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited WhereNotIn(pLeftField, pValues);
  Result := Self;
end;

{ TDeleteQuery }

function TDeleteQuery.GenerateSQL: string;
var
  i: Integer;
begin
  try
    sSQL := 'delete from ' + oTable.Name + ' ' + oTable.Alias;

    if Length(aWhere) > 0 then
    begin
      sSQL := sSQL + #13#10 + 'where ';
      for i := 0 to (Length(aWhere) - 1) do
        sSQL := sSQL + aWhere[i].GenerateSQL(6, (i <> 0));
    end;
  except
    on E: Exception do
    begin
      sSQL := '';
      raise Exception.Create('Erro ao gerar DeleteSQL: ' + E.Message);
    end;
  end;

  Result := sSQL;
end;

function TDeleteQuery.GetSQL: string;
begin
  Result := GenerateSQL;
end;

end.
