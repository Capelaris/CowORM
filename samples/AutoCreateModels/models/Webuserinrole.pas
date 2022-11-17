unit Webuserinrole;

interface

uses CowORM, Webuser, Webrole;

type
  [TTable('WEBUSERINROLE')]
  [TPrimaryKey('ID')]
  TWebuserinrole = class(TORMObject)
  private
    FId: Int32;
    FWebuser: TWebuser;
    FWebrole: TWebrole;
  public
    [TIntegerColumn('id', True)]
    property Id: Int32 read FId write FId;
    [TIntegerColumn('webuser_id', True)]
    property Webuser: TWebuser read FWebuser write FWebuser;
    [TIntegerColumn('webrole_id', True)]
    property Webrole: TWebrole read FWebrole write FWebrole;
  end;

implementation
end.
