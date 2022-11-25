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
  Invoice;

procedure TFrmMainForm.btnFindAllClick(Sender: TObject);
var
  Invoices: TArray<TInvoice>;
begin
  Invoices := TInvoice.FindAll<TInvoice>(Conn);
  ShowMessage(Invoices[0].Serialize.ToJSON);
end;

end.
