unit InvoiceLine;

interface

uses CowORM, PigQuery, Invoice, Product;

type
  [TTable('INVOICE_LINE')]
  [TPrimaryKey('INVOICE_LINE_ID')]
  TInvoiceLine = class(TORMObject)
  private
    FInvoiceLineId: Int32;
    FQuantity: Double;
    FSalePrice: Double;
    FFkInvoiceLineInvoice: TInvoice;
    FFkInvoiceLineProduct: TProduct;
    procedure WriteInvoiceLineId(Value: Int32);
    function ReadInvoiceLineId: Int32;
    procedure WriteQuantity(Value: Double);
    function ReadQuantity: Double;
    procedure WriteSalePrice(Value: Double);
    function ReadSalePrice: Double;
    procedure WriteFkInvoiceLineInvoice(Value: TInvoice);
    function ReadFkInvoiceLineInvoice: TInvoice;
    procedure WriteFkInvoiceLineProduct(Value: TProduct);
    function ReadFkInvoiceLineProduct: TProduct;
  public
    [TIntegerColumn('invoice_line_id', True)]
    property InvoiceLineId: Int32 read ReadInvoiceLineId write WriteInvoiceLineId;
    [TNumericColumn('quantity', 15, 0, False)]
    property Quantity: Double read ReadQuantity write WriteQuantity;
    [TNumericColumn('sale_price', 15, 2, True)]
    property SalePrice: Double read ReadSalePrice write WriteSalePrice;
    [TIntegerColumn('invoice_id', True)]
    property FkInvoiceLineProduct: TProduct read ReadFkInvoiceLineProduct write WriteFkInvoiceLineProduct;
  end;

implementation

procedure TInvoiceLine.WriteInvoiceLineId(Value: Int32);
begin
  inherited CheckLazy;
  Self.FInvoiceLineId := Value;
end;

function TInvoiceLine.ReadInvoiceLineId: Int32;
begin
  inherited CheckLazy;
  Result := Self.FInvoiceLineId;
end;

procedure TInvoiceLine.WriteQuantity(Value: Double);
begin
  inherited CheckLazy;
  Self.FQuantity := Value;
end;

function TInvoiceLine.ReadQuantity: Double;
begin
  inherited CheckLazy;
  Result := Self.FQuantity;
end;

procedure TInvoiceLine.WriteSalePrice(Value: Double);
begin
  inherited CheckLazy;
  Self.FSalePrice := Value;
end;

function TInvoiceLine.ReadSalePrice: Double;
begin
  inherited CheckLazy;
  Result := Self.FSalePrice;
end;

procedure TInvoiceLine.WriteFkInvoiceLineInvoice(Value: TInvoice);
begin
  inherited CheckLazy;
  Self.FFkInvoiceLineInvoice := Value;
end;

function TInvoiceLine.ReadFkInvoiceLineInvoice: TInvoice;
begin
  inherited CheckLazy;
  Result := Self.FFkInvoiceLineInvoice;
end;

procedure TInvoiceLine.WriteFkInvoiceLineProduct(Value: TProduct);
begin
  inherited CheckLazy;
  Self.FFkInvoiceLineProduct := Value;
end;

function TInvoiceLine.ReadFkInvoiceLineProduct: TProduct;
begin
  inherited CheckLazy;
  Result := Self.FFkInvoiceLineProduct;
end;


end.
