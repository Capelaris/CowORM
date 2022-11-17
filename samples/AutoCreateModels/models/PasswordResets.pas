unit PasswordResets;

interface

uses CowORM;

type
  [TTable('password_resets')]
  TPasswordResets = class(TORMObject)
  private
    FEmail: string;
    FToken: string;
    FCreatedAt: TDateTime;
  public
    [TVarcharColumn('email', 255, True, 'UTF8', 'UTF8')]
    property Email: string read FEmail write FEmail;
    [TVarcharColumn('token', 255, True, 'UTF8', 'UTF8')]
    property Token: string read FToken write FToken;
    [TTimeStampColumn('created_at', False)]
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
  end;

implementation
end.
