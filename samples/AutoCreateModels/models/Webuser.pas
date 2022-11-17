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
  public
    [TIntegerColumn('webuser_id', True)]
    property WebuserId: Int32 read FWebuserId write FWebuserId;
    [TVarcharColumn('email', 63, True, 'UTF8', 'UTF8')]
    property Email: string read FEmail write FEmail;
    [TVarcharColumn('passwd', 63, True, 'UTF8', 'UTF8')]
    property Passwd: string read FPasswd write FPasswd;
  end;

implementation
end.
