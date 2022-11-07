unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, CowORM.Core.QueryBuilder;

type
  TFMainForm = class(TForm)
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMainForm: TFMainForm;

implementation

{$R *.dfm}

procedure TFMainForm.btn1Click(Sender: TObject);
var
  qry: TSelectQuery;
begin
  qry := TSelectQuery.Create('teste');
  qry.
end;

end.
