program VCL;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {FMainForm},
  CowORM.Commons in '..\..\src\CowORM.Commons.pas',
  CowORM.Core.QueryBuilder in '..\..\src\CowORM.Core.QueryBuilder.pas',
  CowORM.Core.Columns in '..\..\src\CowORM.Core.Columns.pas',
  CowORM.Constants in '..\..\src\CowORM.Constants.pas',
  CowORM.Core.Tables in '..\..\src\CowORM.Core.Tables.pas',
  CowORM.Helpers in '..\..\src\CowORM.Helpers.pas',
  CowORM.Core.QueryCondition in '..\..\src\CowORM.Core.QueryCondition.pas',
  CowORM.Core.QueryJoin in '..\..\src\CowORM.Core.QueryJoin.pas',
  CowORM.Core.ORMObject in '..\..\src\CowORM.Core.ORMObject.pas',
  CowORM.Core.Connection in '..\..\src\CowORM.Core.Connection.pas',
  CowORM.Core.QueryParam in '..\..\src\CowORM.Core.QueryParam.pas',
  CowORM.Core.Configurations in '..\..\src\CowORM.Core.Configurations.pas',
  CowORM.Core.QueryResult in '..\..\src\CowORM.Core.QueryResult.pas',
  Customer in 'models\Customer.pas',
  CowORM in '..\..\src\CowORM.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMainForm, FMainForm);
  Application.Run;
end.
