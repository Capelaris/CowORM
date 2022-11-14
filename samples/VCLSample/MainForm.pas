unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, CowORM, Customer;

type
  TFMainForm = class(TForm)
    btnSelectQuery: TButton;
    mmoQuery: TMemo;
    procedure btnSelectQueryClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMainForm: TFMainForm;

implementation

{$R *.dfm}

procedure TFMainForm.btnSelectQueryClick(Sender: TObject);
var
  qry: TSelectQuery;
  Arr: TArray<TCustomer>;
begin
  Arr := TCustomer.FindAll<TCustomer>;
  //mmoQuery.Lines.Text := Arr[0].Name;
  {qry := TSelectQuery.Create('tabela1')
      .Where('a.col1 = b.col1')
      .Where('a.col2', 'b.col2')
      .OrWhere('a.col3', '<>', 'b.col3')
      .LeftJoin('tabela2',[
          TQueryCondition.Create('b.col1', ['teste1', 'teste2'])
      ]);
  mmoQuery.Lines.Text := qry.GetSQL(['col1', 'col2', 'col3']);  }

end;

end.
