unit Users;

interface

uses CowORM;

type
  [TTable('users')]
  [TPrimaryKey('id')]
  TUsers = class(TORMObject)
  private
    FId: Int32;
    FName: string;
    FEmail: string;
    FPassword: string;
    FRememberToken: string;
    FCreatedAt: TDateTime;
    FUpdatedAt: TDateTime;
  public
    [TIntegerColumn('id', True)]
    property Id: Int32 read FId write FId;
    [TVarcharColumn('name', 255, True, 'UTF8', 'UTF8')]
    property Name: string read FName write FName;
    [TVarcharColumn('email', 255, True, 'UTF8', 'UTF8')]
    property Email: string read FEmail write FEmail;
    [TVarcharColumn('password', 255, True, 'UTF8', 'UTF8')]
    property Password: string read FPassword write FPassword;
    [TVarcharColumn('remember_token', 100, False, 'UTF8', 'UTF8')]
    property RememberToken: string read FRememberToken write FRememberToken;
    [TTimeStampColumn('created_at', False)]
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    [TTimeStampColumn('updated_at', False)]
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
  end;

implementation
end.
