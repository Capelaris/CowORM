program VCL;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {FMainForm},
  CowORM.Commons in '..\..\src\CowORM.Commons.pas',
  CowORM.Core.QueryBuilder in '..\..\src\CowORM.Core.QueryBuilder.pas',
  CowORM.Interfaces in '..\..\src\CowORM.Interfaces.pas',
  CowORM.Core.Columns in '..\..\src\CowORM.Core.Columns.pas',
  CowORM.Constants in '..\..\src\CowORM.Constants.pas',
  CowORM.Core.Tables in '..\..\src\CowORM.Core.Tables.pas',
  CowORM.Helpers in '..\..\src\CowORM.Helpers.pas',
  CowORM.Core.QueryCondition in '..\..\src\CowORM.Core.QueryCondition.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMainForm, FMainForm);
  Application.Run;
end.
