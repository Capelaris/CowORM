unit CowORM;

interface

uses
  Rtti,
  CowORM.Commons,
  CowORM.Constants,
  CowORM.Interfaces,
  CowORM.Core.Configurations,
  CowORM.Core.Connection,
  CowORM.Core.ORMObject,
  CowORM.Core.Param,
  CowORM.Core.Result;

type
  { Commons }
  TConnectionType = CowORM.Commons.TConnectionType;

  { Interfaces }
  IConfigs    = CowORM.Interfaces.IConfigs;
  IParam      = CowORM.Interfaces.IParam;
  IResult     = CowORM.Interfaces.IResult;
  IConnection = CowORM.Interfaces.IConnection;

  { QueryUtils }
  TParam  = CowORM.Core.Param.TParam;
  TResult = CowORM.Core.Result.TResult;

  { Connection }
  TConfigs    = CowORM.Core.Configurations.TConfigs;
  TConnection = CowORM.Core.Connection.TConnection;

  { ORMObject }
  TORMObject = CowORM.Core.ORMObject.TORMObject;

const
  { Commons }
  ctFB    = CowORM.Commons.TConnectionType.ctFB;
  ctMYSQL = CowORM.Commons.TConnectionType.ctMYSQL;

implementation

end.
