unit MainForm;

interface

uses
  Connection, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, CowORM, IOUtils;

type
  TFrmMainForm = class(TForm)
    dbgrdMain: TDBGrid;
    pnlButtons: TPanel;
    btnFindAll: TButton;
    dsMain: TDataSource;
    mmtblMain: TFDMemTable;
    procedure btnFindAllClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMainForm  : TFrmMainForm;
  DefaultConfig: TConfigs;
  DefaultConn  : TConnection;

implementation

{$R *.dfm}

uses
  Customer;

procedure TFrmMainForm.btnFindAllClick(Sender: TObject);
var
  Customer: TCustomer;
begin
  //Insert
  Customer := TCustomer.Create;
  Customer.Name := 'Weslley Capelari';
  Customer.Address := 'Balsamo';
  Customer.Zipcode := 'null';
  Customer.Phone   := '996024649';
  Customer.CustomerId := 9999;
  Customer.Save(DefaultConn);

  ShowMessage(Customer.Serialize.ToJSON);

  //Find/Update
  Customer := TCustomer.Find(9999, DefaultConn);
  Customer.Name := 'Vinicius Batista';
  Customer.Save;

  ShowMessage(Customer.Serialize.ToJSON);

  //Delete
  Customer := TCustomer.Find(9999, DefaultConn);
  Customer.Delete;
end;

initialization
  DefaultConfig := TConfigs.Create(ctFB, 'localhost', 3050, 'sysdba', 'masterkey',
      TPath.GetFullPath('../../../../database/examples.fdb'));
  DefaultConn   := TConnection.Create(DefaultConfig);

end.
