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
    [TIntegerColumn('id', True)]
    property Id: Int32 read ReadId write WriteId;
    [TIntegerColumn('webrole_id', True)]
    property FkWebuserinroleUser: TWebuser read ReadFkWebuserinroleUser write WriteFkWebuserinroleUser;
  end;

implementation

procedure TWebuserinrole.WriteId(Value: Int32);
begin
  inherited CheckLazy;
  Self.FId := Value;
end;

function TWebuserinrole.ReadId: Int32;
begin
  inherited CheckLazy;
  Result := Self.FId;
end;

procedure TWebuserinrole.WriteFkWebuserinroleRole(Value: TWebrole);
begin
  inherited CheckLazy;
  Self.FFkWebuserinroleRole := Value;
end;

function TWebuserinrole.ReadFkWebuserinroleRole: TWebrole;
begin
  inherited CheckLazy;
  Result := Self.FFkWebuserinroleRole;
end;

procedure TWebuserinrole.WriteFkWebuserinroleUser(Value: TWebuser);
begin
  inherited CheckLazy;
  Self.FFkWebuserinroleUser := Value;
end;

function TWebuserinrole.ReadFkWebuserinroleUser: TWebuser;
begin
  inherited CheckLazy;
  Result := Self.FFkWebuserinroleUser;
end;


end.
