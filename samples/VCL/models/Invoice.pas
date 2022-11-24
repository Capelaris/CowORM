unit Invoice;

interface

uses CowORM, PigQuery, Customer;

type
  [TTable('INVOICE')]
  [TPrimaryKey('INVOICE_ID')]
  TInvoice = class(TORMObject)
  private
    FInvoiceId: Int32;
    FInvoiceDate: TDateTime;
    FTotalSale: Double;
    FPaid: Int16;
    FFkInvoceCustomer: TCustomer;
    procedure WriteInvoiceId(Value: Int32);
    function ReadInvoiceId: Int32;
    procedure WriteInvoiceDate(Value: TDateTime);
    function ReadInvoiceDate: TDateTime;
    procedure WriteTotalSale(Value: Double);
    function ReadTotalSale: Double;
    procedure WritePaid(Value: Int16);
    function ReadPaid: Int16;
    procedure WriteFkInvoceCustomer(Value: TCustomer);
    function ReadFkInvoceCustomer: TCustomer;
  public
    [TIntegerColumn('invoice_id', True)]
    property InvoiceId: Int32 read ReadInvoiceId write WriteInvoiceId;
    [TTimeStampColumn('invoice_date', False)]
    property InvoiceDate: TDateTime read ReadInvoiceDate write WriteInvoiceDate;
    [TNumericColumn('total_sale', 15, 2, False)]
    property TotalSale: Double read ReadTotalSale write WriteTotalSale;
    [TSmallIntColumn('paid', True)]
    property Paid: Int16 read ReadPaid write WritePaid;
    [TIntegerColumn('customer_id', True)]
    property FkInvoceCustomer: TCustomer read ReadFkInvoceCustomer write WriteFkInvoceCustomer;
  end;

implementation

procedure TInvoice.WriteInvoiceId(Value: Int32);
begin
  inherited CheckLazy;
  Self.FInvoiceId := Value;
end;

function TInvoice.ReadInvoiceId: Int32;
begin
  inherited CheckLazy;
  Result := Self.FInvoiceId;
end;

procedure TInvoice.WriteInvoiceDate(Value: TDateTime);
begin
  inherited CheckLazy;
  Self.FInvoiceDate := Value;
end;

function TInvoice.ReadInvoiceDate: TDateTime;
begin
  inherited CheckLazy;
  Result := Self.FInvoiceDate;
end;

procedure TInvoice.WriteTotalSale(Value: Double);
begin
  inherited CheckLazy;
  Self.FTotalSale := Value;
end;

function TInvoice.ReadTotalSale: Double;
begin
  inherited CheckLazy;
  Result := Self.FTotalSale;
end;

procedure TInvoice.WritePaid(Value: Int16);
begin
  inherited CheckLazy;
  Self.FPaid := Value;
end;

function TInvoice.ReadPaid: Int16;
begin
  inherited CheckLazy;
  Result := Self.FPaid;
end;

procedure TInvoice.WriteFkInvoceCustomer(Value: TCustomer);
begin
  inherited CheckLazy;
  Self.FFkInvoceCustomer := Value;
end;

function TInvoice.ReadFkInvoceCustomer: TCustomer;
begin
  inherited CheckLazy;
  Result := Self.FFkInvoceCustomer;
end;


end.
