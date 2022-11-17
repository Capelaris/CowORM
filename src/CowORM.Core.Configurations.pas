unit CowORM.Core.Configurations;

interface

uses
  CowORM.Commons;

type
  TConfigs = class
  private
    tType    : TConnectionType;
    sDatabase: string;
    sHostname: string;
    iPort    : Integer;
    sUserName: string;
    sPassword: string;
    bLazy    : Boolean;
  public
    { Public Declarations }
    constructor Create(pType: TConnectionType; pHostname: string; pPort: Integer;
      pUsername, pPassword, pDatabase: string; pLazy: Boolean = False);
    property ConnType: TConnectionType read tType;
    property Database: string  read sDatabase;
    property Hostname: string  read sHostname;
    property Port    : Integer read iPort;
    property UserName: string  read sUserName;
    property Password: string  read sPassword;
    property Lazy    : Boolean read bLazy;
  end;

implementation

{ TConfigs }

constructor TConfigs.Create(pType: TConnectionType; pHostname: string;
  pPort: Integer; pUsername, pPassword, pDatabase: string; pLazy: Boolean);
begin
  inherited Create;
  with Self do
  begin
    tType     := pType;
    sHostname := pHostname;
    iPort     := pPort;
    sUserName := pUsername;
    sPassword := pPassword;
    sDatabase := pDatabase;
    bLazy     := pLazy;
  end;
end;

end.
