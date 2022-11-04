program VCL;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {FMainForm},
  CowORM.Commons in '..\..\src\CowORM.Commons.pas',
  CowORM.Core.QueryBuilder in '..\..\src\CowORM.Core.QueryBuilder.pas',
  CowORM.Interfaces in '..\..\src\CowORM.Interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMainForm, FMainForm);
  Application.Run;
end.
