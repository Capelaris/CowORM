unit CowORM.Constants;

interface

uses
  CowORM.Commons, CowORM.Core.Configurations, CowORM.Core.Connection, SysUtils,
  Rtti, Variants;

const
  COWORM_VERSION = '1.0.0';
  NULL_VAL       = Null;

var
  DefaultConfig: TConfigs;
  DefaultConn  : TConnection;

implementation

initialization
  DefaultConfig := TConfigs.Create(ctFB, 'localhost', 3050, 'SYSDBA', 'MASTERKEY',
      ExpandFileName('../../database/examples.fdb'));
  DefaultConn   := TConnection.Create(DefaultConfig);

end.
