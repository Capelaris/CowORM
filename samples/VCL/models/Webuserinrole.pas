unit Webuserinrole;

interface

uses CowORM, PigQuery, Webrole, Webuser;

type
  [TTable('WEBUSERINROLE')]
  [TPrimaryKey('ID')]
  TWebuserinrole = class(TORMObject)
  private
    FId: Int32;
    FFkWebuserinroleRole: TWebrole;
    FFkWebuserinroleUser: TWebuser;
    procedure WriteId(Value: Int32);
    function ReadId: Int32;
    procedure WriteFkWebuserinroleRole(Value: TWebrole);
    function ReadFkWebuserinroleRole: TWebrole;
    procedure WriteFkWebuserinroleUser(Value: TWebuser);
    function ReadFkWebuserinroleUser: TWebuser;
  public
    class function Find(Id: Integer; Configs: IConfigs): TWebuserinrole; overload;
    class function Find(Id: Integer; Conn: IConnection): TWebuserinrole; overload;
    class function FindAll(Configs: IConfigs): TArray<TWebuserinrole>; overload;  
    class function FindAll(Conn: IConnection): TArray<TWebuserinrole>; overload;  

    [TIntegerColumn('id', True)]
    property Id: Int32 read ReadId write WriteId;
    [TIntegerColumn('webrole_id', True)]
    property FkWebuserinroleUser: TWebuser read ReadFkWebuserinroleUser write WriteFkWebuserinroleUser;
  end;

implementation

class function TWebuserinrole.Find(Id: Integer; Configs: IConfigs): TWebuserinrole;
begin
  Result := TWebuserinrole.Find<TWebuserinrole>(Id, Configs);
end;

class function TWebuserinrole.Find(Id: Integer; Conn: IConnection): TWebuserinrole;
begin
  Result := TWebuserinrole.Find<TWebuserinrole>(Id, Conn);
end;

class function TWebuserinrole.FindAll(Configs: IConfigs): TArray<TWebuserinrole>;  
begin
  Result := TWebuserinrole.FindAll<TWebuserinrole>(Configs);
end;

class function TWebuserinrole.FindAll(Conn: IConnection): TArray<TWebuserinrole>;  
begin
  Result := TWebuserinrole.FindAll<TWebuserinrole>(Conn);
end;

procedure TWebuserinrole.WriteId(Value: Int32);
begin
  Self.FId := Value;
end;

function TWebuserinrole.ReadId: Int32;
begin
  inherited CheckLazy;
  Result := Self.FId;
end;

procedure TWebuserinrole.WriteFkWebuserinroleRole(Value: TWebrole);
begin
  Self.FFkWebuserinroleRole := Value;
end;

function TWebuserinrole.ReadFkWebuserinroleRole: TWebrole;
begin
  inherited CheckLazy;
  Result := Self.FFkWebuserinroleRole;
end;

procedure TWebuserinrole.WriteFkWebuserinroleUser(Value: TWebuser);
begin
  Self.FFkWebuserinroleUser := Value;
end;

function TWebuserinrole.ReadFkWebuserinroleUser: TWebuser;
begin
  inherited CheckLazy;
  Result := Self.FFkWebuserinroleUser;
end;


end.
