unit CowORM.Constants;

interface

uses
  CowORM.Commons, CowORM.Core.Configurations, CowORM.Core.Connection, SysUtils,
  Rtti, IOUtils;

const
  COWORM_VERSION = '1.0.0';

var
  DefaultConfig: TConfigs;
  DefaultConn  : TConnection;

implementation

initialization
  DefaultConfig := TConfigs.Create(ctFB, 'localhost', 3050, 'sysdba', 'masterkey',
      TPath.GetFullPath('../../../../database/examples.fdb'), True);
  DefaultConn   := TConnection.Create(DefaultConfig);

end.
