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
    class function Find(Id: Integer): TInvoiceLine; overload;                   
    class function Find(Id: Integer; Configs: IConfigs): TInvoiceLine; overload;
    class function Find(Id: Integer; Conn: IConnection): TInvoiceLine; overload;
    class function FindAll: TArray<TInvoiceLine>; overload;                     
    class function FindAll(Configs: IConfigs): TArray<TInvoiceLine>; overload;  
    class function FindAll(Conn: IConnection): TArray<TInvoiceLine>; overload;  

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

class function TInvoiceLine.Find(Id: Integer): TInvoiceLine;                   
begin
  Result := TInvoiceLine.Find<TInvoiceLine>(Id);
end;

class function TInvoiceLine.Find(Id: Integer; Configs: IConfigs): TInvoiceLine;
begin
  Result := TInvoiceLine.Find<TInvoiceLine>(Id, Configs);
end;

class function TInvoiceLine.Find(Id: Integer; Conn: IConnection): TInvoiceLine;
begin
  Result := TInvoiceLine.Find<TInvoiceLine>(Id, Conn);
end;

class function TInvoiceLine.FindAll: TArray<TInvoiceLine>;                     
begin
  Result := TInvoiceLine.FindAll<TInvoiceLine>;
end;

class function TInvoiceLine.FindAll(Configs: IConfigs): TArray<TInvoiceLine>;  
begin
  Result := TInvoiceLine.FindAll<TInvoiceLine>(Configs);
end;

class function TInvoiceLine.FindAll(Conn: IConnection): TArray<TInvoiceLine>;  
begin
  Result := TInvoiceLine.FindAll<TInvoiceLine>(Conn);
end;

procedure TInvoiceLine.WriteInvoiceLineId(Value: Int32);
begin
  Self.FInvoiceLineId := Value;
end;

function TInvoiceLine.ReadInvoiceLineId: Int32;
begin
  inherited CheckLazy;
  Result := Self.FInvoiceLineId;
end;

procedure TInvoiceLine.WriteQuantity(Value: Double);
begin
  Self.FQuantity := Value;
end;

function TInvoiceLine.ReadQuantity: Double;
begin
  inherited CheckLazy;
  Result := Self.FQuantity;
end;

procedure TInvoiceLine.WriteSalePrice(Value: Double);
begin
  Self.FSalePrice := Value;
end;

function TInvoiceLine.ReadSalePrice: Double;
begin
  inherited CheckLazy;
  Result := Self.FSalePrice;
end;

procedure TInvoiceLine.WriteFkInvoiceLineInvoice(Value: TInvoice);
begin
  Self.FFkInvoiceLineInvoice := Value;
end;

function TInvoiceLine.ReadFkInvoiceLineInvoice: TInvoice;
begin
  inherited CheckLazy;
  Result := Self.FFkInvoiceLineInvoice;
end;

procedure TInvoiceLine.WriteFkInvoiceLineProduct(Value: TProduct);
begin
  Self.FFkInvoiceLineProduct := Value;
end;

function TInvoiceLine.ReadFkInvoiceLineProduct: TProduct;
begin
  inherited CheckLazy;
  Result := Self.FFkInvoiceLineProduct;
end;


end.
