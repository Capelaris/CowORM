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

    procedure SetConnType(Value: TConnectionType);
    function GetConnType: TConnectionType;
    procedure SetDatabase(Value: string);
    function GetDatabase: string;
    procedure SetHostname(Value: string);
    function GetHostname: string;
    procedure SetPort(Value: Integer);
    function GetPort: Integer;
    procedure SetUserName(Value: string);
    function GetUserName: string;
    procedure SetPassword(Value: string);
    function GetPassword: string;
    procedure SetLazy(Value: Boolean);
    function GetLazy: Boolean;
  public
    { Public Declarations }
    constructor Create(pType: TConnectionType; pHostname: string; pPort: Integer;
      pUsername, pPassword, pDatabase: string; pLazy: Boolean = False);
    property ConnType: TConnectionType read GetConnType;
    property Database: string          read GetDatabase;
    property Hostname: string          read GetHostname;
    property Port    : Integer         read GetPort;
    property UserName: string          read GetUserName;
    property Password: string          read GetPassword;
    property Lazy    : Boolean         read GetLazy;
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

function TConfigs.GetConnType: TConnectionType;
begin
  Result := Self.tType;
end;

function TConfigs.GetDatabase: string;
begin
  Result := Self.sDatabase;
end;

function TConfigs.GetHostname: string;
begin
  Result := Self.sHostname;
end;

function TConfigs.GetLazy: Boolean;
begin
  Result := Self.bLazy;
end;

function TConfigs.GetPassword: string;
begin
  Result := Self.sPassword;
end;

function TConfigs.GetPort: Integer;
begin
  Result := Self.iPort;
end;

function TConfigs.GetUserName: string;
begin
  Result := Self.sUserName;
end;

procedure TConfigs.SetConnType(Value: TConnectionType);
begin
  Self.tType := Value;
end;

procedure TConfigs.SetDatabase(Value: string);
begin
  Self.sDatabase := Value;
end;

procedure TConfigs.SetHostname(Value: string);
begin
  Self.sHostname := Value;
end;

procedure TConfigs.SetLazy(Value: Boolean);
begin
  Self.bLazy := Value;
end;

procedure TConfigs.SetPassword(Value: string);
begin
  Self.sPassword := Value;
end;

procedure TConfigs.SetPort(Value: Integer);
begin
  Self.iPort := Value;
end;

procedure TConfigs.SetUserName(Value: string);
begin
  Self.sUserName := Value;
end;

end.
