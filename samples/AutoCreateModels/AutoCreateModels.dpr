program AutoCreateModels;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {fMainForm},
  CowORM.Commons in '..\..\src\CowORM.Commons.pas',
  CowORM.Constants in '..\..\src\CowORM.Constants.pas',
  CowORM.Core.Columns in '..\..\src\CowORM.Core.Columns.pas',
  CowORM.Core.Configurations in '..\..\src\CowORM.Core.Configurations.pas',
  CowORM.Core.Connection in '..\..\src\CowORM.Core.Connection.pas',
  CowORM.Core.ORMObject in '..\..\src\CowORM.Core.ORMObject.pas',
  CowORM.Core.QueryBuilder in '..\..\src\CowORM.Core.QueryBuilder.pas',
  CowORM.Core.QueryCondition in '..\..\src\CowORM.Core.QueryCondition.pas',
  CowORM.Core.QueryJoin in '..\..\src\CowORM.Core.QueryJoin.pas',
  CowORM.Core.QueryParam in '..\..\src\CowORM.Core.QueryParam.pas',
  CowORM.Core.QueryResult in '..\..\src\CowORM.Core.QueryResult.pas',
  CowORM.Core.Tables in '..\..\src\CowORM.Core.Tables.pas',
  CowORM.Helpers in '..\..\src\CowORM.Helpers.pas',
  CowORM in '..\..\src\CowORM.pas',
  Vcl.Themes,
  Vcl.Styles,
  Customer in 'models\Customer.pas',
  Invoice in 'models\Invoice.pas',
  InvoiceLine in 'models\InvoiceLine.pas',
  Product in 'models\Product.pas',
  Webrole in 'models\Webrole.pas',
  Webuser in 'models\Webuser.pas',
  Webuserinrole in 'models\Webuserinrole.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Light');
  Application.CreateForm(TfMainForm, fMainForm);
  Application.Run;
end.
