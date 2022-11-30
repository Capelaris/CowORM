unit MainForm;

interface

uses
  Connection, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

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
  FrmMainForm: TFrmMainForm;

implementation

{$R *.dfm}

uses
  Customer;

procedure TFrmMainForm.btnFindAllClick(Sender: TObject);
var
  Customers: TCustomer;
begin
  Customers := TCustomer.Create;
  Customers.Name := 'Weslley Capelari';
  Customers.Address := 'Balsamo';
  Customers.Zipcode := '15000-000';
  Customers.Phone   := '996024649';
  Customers.CustomerId := 9999;
  Customers.Save;
  {Customers := TCustomer.Find(15, Conn);
  Customers.Delete;
  ShowMessage(Customers.Serialize.ToJSON);  }
end;

end.
