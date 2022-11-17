unit CowORM;

interface

uses
  Rtti,
  CowORM.Commons,
  CowORM.Constants,
  CowORM.Core.Columns,
  CowORM.Core.Configurations,
  CowORM.Core.Connection,
  CowORM.Core.ORMObject,
  CowORM.Core.QueryBuilder,
  CowORM.Core.QueryCondition,
  CowORM.Core.QueryJoin,
  CowORM.Core.QueryParam,
  CowORM.Core.QueryResult,
  CowORM.Core.Tables;

type
  //Commons
  TColumnType     = CowORM.Commons.TColumnType;
  TJoinType       = CowORM.Commons.TJoinType;
  TQueryType      = CowORM.Commons.TQueryType;
  TConnectionType = CowORM.Commons.TConnectionType;

  //Columns
  TPrimaryKey            = CowORM.Core.Columns.TPrimaryKey;
  TColumn                = CowORM.Core.Columns.TColumn;
  TSmallIntColumn        = CowORM.Core.Columns.TSmallIntColumn;
  TIntegerColumn         = CowORM.Core.Columns.TIntegerColumn;
  TBigIntColumn          = CowORM.Core.Columns.TBigIntColumn;
  TDecimalColumn         = CowORM.Core.Columns.TDecimalColumn;
  TNumericColumn         = CowORM.Core.Columns.TNumericColumn;
  TFloatColumn           = CowORM.Core.Columns.TFloatColumn;
  TDoublePrecisionColumn = CowORM.Core.Columns.TDoublePrecisionColumn;
  TDateColumn            = CowORM.Core.Columns.TDateColumn;
  TTimeColumn            = CowORM.Core.Columns.TTimeColumn;
  TTimeStampColumn       = CowORM.Core.Columns.TTimeStampColumn;
  TCharColumn            = CowORM.Core.Columns.TCharColumn;
  TVarcharColumn         = CowORM.Core.Columns.TVarcharColumn;
  TBlobBinaryColumn      = CowORM.Core.Columns.TBlobBinaryColumn;
  TBlobTextColumn        = CowORM.Core.Columns.TBlobTextColumn;

  //QueryBuilder
  TTable          = CowORM.Core.Tables.TTable;
  TQueryCondition = CowORM.Core.QueryCondition.TQueryCondition;
  TQueryJoin      = CowORM.Core.QueryJoin.TQueryJoin;
  TQueryParam     = CowORM.Core.QueryParam.TQueryParam;
  TQueryResult    = CowORM.Core.QueryResult.TQueryResult;
  TSelectQuery    = CowORM.Core.QueryBuilder.TSelectQuery;
  TDeleteQuery    = CowORM.Core.QueryBuilder.TDeleteQuery;

  //Connection
  TConfigs    = CowORM.Core.Configurations.TConfigs;
  TConnection = CowORM.Core.Connection.TConnection;

  //ORMObject
  TORMObject = CowORM.Core.ORMObject.TORMObject;

implementation

end.
