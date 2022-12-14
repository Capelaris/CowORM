program AutoCreateModels;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {fMainForm},
  CowORM.Commons in '..\..\src\CowORM.Commons.pas',
  CowORM.Constants in '..\..\src\CowORM.Constants.pas',
  CowORM.Core.Configurations in '..\..\src\CowORM.Core.Configurations.pas',
  CowORM.Core.Connection in '..\..\src\CowORM.Core.Connection.pas',
  CowORM.Core.ORMObject in '..\..\src\CowORM.Core.ORMObject.pas',
  CowORM.Core.Param in '..\..\src\CowORM.Core.Param.pas',
  CowORM.Core.Result in '..\..\src\CowORM.Core.Result.pas',
  CowORM.Helpers in '..\..\src\CowORM.Helpers.pas',
  CowORM in '..\..\src\CowORM.pas',
  Vcl.Themes,
  Vcl.Styles,
  CowORM.Interfaces in '..\..\src\CowORM.Interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Light');
  Application.CreateForm(TfMainForm, fMainForm);
  Application.Run;
end.
