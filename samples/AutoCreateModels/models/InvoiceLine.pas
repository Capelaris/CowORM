unit InvoiceLine;

interface

uses CowORM, Invoice, Product;

type
  [TTable('INVOICE_LINE')]
  [TPrimaryKey('INVOICE_LINE_ID')]
  TInvoiceLine = class(TORMObject)
  private
    FInvoiceLineId: Int32;
    FInvoice: TInvoice;
    FProduct: TProduct;
    FQuantity: Double;
    FSalePrice: Double;
  public
    [TIntegerColumn('invoice_line_id', True)]
    property InvoiceLineId: Int32 read FInvoiceLineId write FInvoiceLineId;
    [TIntegerColumn('invoice_id', True)]
    property Invoice: TInvoice read FInvoice write FInvoice;
    [TIntegerColumn('product_id', True)]
    property Product: TProduct read FProduct write FProduct;
    [TNumericColumn('quantity', 15, 0, False)]
    property Quantity: Double read FQuantity write FQuantity;
    [TNumericColumn('sale_price', 15, 2, True)]
    property SalePrice: Double read FSalePrice write FSalePrice;
  end;

implementation
end.
