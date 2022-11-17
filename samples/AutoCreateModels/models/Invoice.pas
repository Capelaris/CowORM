unit Invoice;

interface

uses CowORM, Customer;

type
  [TTable('INVOICE')]
  [TPrimaryKey('INVOICE_ID')]
  TInvoice = class(TORMObject)
  private
    FInvoiceId: Int32;
    FCustomer: TCustomer;
    FInvoiceDate: TDateTime;
    FTotalSale: Double;
    FPaid: Int16;
  public
    [TIntegerColumn('invoice_id', True)]
    property InvoiceId: Int32 read FInvoiceId write FInvoiceId;
    [TIntegerColumn('customer_id', True)]
    property Customer: TCustomer read FCustomer write FCustomer;
    [TTimeStampColumn('invoice_date', False)]
    property InvoiceDate: TDateTime read FInvoiceDate write FInvoiceDate;
    [TNumericColumn('total_sale', 15, 2, False)]
    property TotalSale: Double read FTotalSale write FTotalSale;
    [TSmallIntColumn('paid', True)]
    property Paid: Int16 read FPaid write FPaid;
  end;

implementation
end.
