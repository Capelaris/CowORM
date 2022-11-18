unit Webuser;

interface

uses CowORM;

type
  [TTable('WEBUSER')]
  [TPrimaryKey('WEBUSER_ID')]
  TWebuser = class(TORMObject)
  private
    FWebuserId: Int32;
    FEmail: string;
    FPasswd: string;
    procedure WriteWebuserId(Value: Int32);
    function ReadWebuserId: Int32;
    procedure WriteEmail(Value: string);
    function ReadEmail: string;
    procedure WritePasswd(Value: string);
    function ReadPasswd: string;
  public
    [TIntegerColumn('webuser_id', True)]
    property WebuserId: Int32 read ReadWebuserId write WriteWebuserId;
    [TVarcharColumn('email', 63, True, 'UTF8', '')]
    property Email: string read ReadEmail write WriteEmail;
    [TVarcharColumn('passwd', 63, True, 'UTF8', '')]
    property Passwd: string read ReadPasswd write WritePasswd;
  end;

implementation

procedure TWebuser.WriteWebuserId(Value: Int32);
begin
  inherited CheckLazy;
  Self.FWebuserId := Value;
end;

function TWebuser.ReadWebuserId: Int32;
begin
  inherited CheckLazy;
  Result := Self.FWebuserId;
end;

procedure TWebuser.WriteEmail(Value: string);
begin
  inherited CheckLazy;
  Self.FEmail := Value;
end;

function TWebuser.ReadEmail: string;
begin
  inherited CheckLazy;
  Result := Self.FEmail;
end;

procedure TWebuser.WritePasswd(Value: string);
begin
  inherited CheckLazy;
  Self.FPasswd := Value;
end;

function TWebuser.ReadPasswd: string;
begin
  inherited CheckLazy;
  Result := Self.FPasswd;
end;


end.
