program Sample;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {FrmMainForm},
  CowORM.Commons in '..\..\src\CowORM.Commons.pas',
  CowORM.Constants in '..\..\src\CowORM.Constants.pas',
  CowORM.Core.Configurations in '..\..\src\CowORM.Core.Configurations.pas',
  CowORM.Core.Connection in '..\..\src\CowORM.Core.Connection.pas',
  CowORM.Core.ORMObject in '..\..\src\CowORM.Core.ORMObject.pas',
  CowORM.Core.Param in '..\..\src\CowORM.Core.Param.pas',
  CowORM.Core.Result in '..\..\src\CowORM.Core.Result.pas',
  CowORM.Core.Tables in '..\..\src\CowORM.Core.Tables.pas',
  CowORM.Helpers in '..\..\src\CowORM.Helpers.pas',
  CowORM.Interfaces in '..\..\src\CowORM.Interfaces.pas',
  CowORM in '..\..\src\CowORM.pas',
  Vcl.Themes,
  Vcl.Styles,
  Customer in 'models\Customer.pas',
  Invoice in 'models\Invoice.pas',
  InvoiceLine in 'models\InvoiceLine.pas',
  Product in 'models\Product.pas',
  Webrole in 'models\Webrole.pas',
  Webuser in 'models\Webuser.pas',
  Webuserinrole in 'models\Webuserinrole.pas',
  Connection in 'Connection.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Light');
  Application.CreateForm(TFrmMainForm, FrmMainForm);
  Application.Run;
end.
