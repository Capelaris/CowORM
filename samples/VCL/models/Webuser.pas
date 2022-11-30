unit Webuser;

interface

uses CowORM, PigQuery;

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
    class function Find(Id: Integer; Configs: IConfigs): TWebuser; overload;
    class function Find(Id: Integer; Conn: IConnection): TWebuser; overload;
    class function FindAll(Configs: IConfigs): TArray<TWebuser>; overload;  
    class function FindAll(Conn: IConnection): TArray<TWebuser>; overload;  

    [TIntegerColumn('webuser_id', True)]
    property WebuserId: Int32 read ReadWebuserId write WriteWebuserId;
    [TVarcharColumn('email', 63, True, 'UTF8', '')]
    property Email: string read ReadEmail write WriteEmail;
    [TVarcharColumn('passwd', 63, True, 'UTF8', '')]
    property Passwd: string read ReadPasswd write WritePasswd;
  end;

implementation

class function TWebuser.Find(Id: Integer; Configs: IConfigs): TWebuser;
begin
  Result := TWebuser.Find<TWebuser>(Id, Configs);
end;

class function TWebuser.Find(Id: Integer; Conn: IConnection): TWebuser;
begin
  Result := TWebuser.Find<TWebuser>(Id, Conn);
end;

class function TWebuser.FindAll(Configs: IConfigs): TArray<TWebuser>;  
begin
  Result := TWebuser.FindAll<TWebuser>(Configs);
end;

class function TWebuser.FindAll(Conn: IConnection): TArray<TWebuser>;  
begin
  Result := TWebuser.FindAll<TWebuser>(Conn);
end;

procedure TWebuser.WriteWebuserId(Value: Int32);
begin
  Self.FWebuserId := Value;
end;

function TWebuser.ReadWebuserId: Int32;
begin
  inherited CheckLazy;
  Result := Self.FWebuserId;
end;

procedure TWebuser.WriteEmail(Value: string);
begin
  Self.FEmail := Value;
end;

function TWebuser.ReadEmail: string;
begin
  inherited CheckLazy;
  Result := Self.FEmail;
end;

procedure TWebuser.WritePasswd(Value: string);
begin
  Self.FPasswd := Value;
end;

function TWebuser.ReadPasswd: string;
begin
  inherited CheckLazy;
  Result := Self.FPasswd;
end;


end.
