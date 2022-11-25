unit Connection;

interface

uses
  CowORM, IOUtils;

var
  Conn: TConnection;

implementation

initialization
  Conn := TConnection.Create(
      TConfigs.Create(
          ctFB,
          'localhost',
          3050,
          'sysdba',
          'masterkey',
          TPath.GetFullPath('../../../../database/examples.fdb'),
          True
      )
  );

end.
