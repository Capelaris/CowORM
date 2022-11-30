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
    class function Find(Id: Integer): TInvoice; overload;                   
    class function Find(Id: Integer; Configs: IConfigs): TInvoice; overload;
    class function Find(Id: Integer; Conn: IConnection): TInvoice; overload;
    class function FindAll: TArray<TInvoice>; overload;                     
    class function FindAll(Configs: IConfigs): TArray<TInvoice>; overload;  
    class function FindAll(Conn: IConnection): TArray<TInvoice>; overload;  

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

class function TInvoice.Find(Id: Integer): TInvoice;                   
begin
  Result := TInvoice.Find<TInvoice>(Id);
end;

class function TInvoice.Find(Id: Integer; Configs: IConfigs): TInvoice;
begin
  Result := TInvoice.Find<TInvoice>(Id, Configs);
end;

class function TInvoice.Find(Id: Integer; Conn: IConnection): TInvoice;
begin
  Result := TInvoice.Find<TInvoice>(Id, Conn);
end;

class function TInvoice.FindAll: TArray<TInvoice>;                     
begin
  Result := TInvoice.FindAll<TInvoice>;
end;

class function TInvoice.FindAll(Configs: IConfigs): TArray<TInvoice>;  
begin
  Result := TInvoice.FindAll<TInvoice>(Configs);
end;

class function TInvoice.FindAll(Conn: IConnection): TArray<TInvoice>;  
begin
  Result := TInvoice.FindAll<TInvoice>(Conn);
end;

procedure TInvoice.WriteInvoiceId(Value: Int32);
begin
  Self.FInvoiceId := Value;
end;

function TInvoice.ReadInvoiceId: Int32;
begin
  inherited CheckLazy;
  Result := Self.FInvoiceId;
end;

procedure TInvoice.WriteInvoiceDate(Value: TDateTime);
begin
  Self.FInvoiceDate := Value;
end;

function TInvoice.ReadInvoiceDate: TDateTime;
begin
  inherited CheckLazy;
  Result := Self.FInvoiceDate;
end;

procedure TInvoice.WriteTotalSale(Value: Double);
begin
  Self.FTotalSale := Value;
end;

function TInvoice.ReadTotalSale: Double;
begin
  inherited CheckLazy;
  Result := Self.FTotalSale;
end;

procedure TInvoice.WritePaid(Value: Int16);
begin
  Self.FPaid := Value;
end;

function TInvoice.ReadPaid: Int16;
begin
  inherited CheckLazy;
  Result := Self.FPaid;
end;

procedure TInvoice.WriteFkInvoceCustomer(Value: TCustomer);
begin
  Self.FFkInvoceCustomer := Value;
end;

function TInvoice.ReadFkInvoceCustomer: TCustomer;
begin
  inherited CheckLazy;
  Result := Self.FFkInvoceCustomer;
end;


end.
