unit Customer;

interface

uses CowORM, PigQuery;

type
  [TTable('CUSTOMER')]
  [TPrimaryKey('CUSTOMER_ID')]
  TCustomer = class(TORMObject)
  private
    FCustomerId: Int32;
    FName: string;
    FAddress: string;
    FZipcode: string;
    FPhone: string;
    procedure WriteCustomerId(Value: Int32);
    function ReadCustomerId: Int32;
    procedure WriteName(Value: string);
    function ReadName: string;
    procedure WriteAddress(Value: string);
    function ReadAddress: string;
    procedure WriteZipcode(Value: string);
    function ReadZipcode: string;
    procedure WritePhone(Value: string);
    function ReadPhone: string;
  public
    [TIntegerColumn('customer_id', True)]
    property CustomerId: Int32 read ReadCustomerId write WriteCustomerId;
    [TVarcharColumn('name', 60, True, 'UTF8', '')]
    property Name: string read ReadName write WriteName;
    [TVarcharColumn('address', 250, False, 'UTF8', '')]
    property Address: string read ReadAddress write WriteAddress;
    [TCharColumn('zipcode', False, 'UTF8', 'UTF8')]
    property Zipcode: string read ReadZipcode write WriteZipcode;
    [TVarcharColumn('phone', 14, False, 'UTF8', '')]
    property Phone: string read ReadPhone write WritePhone;
  end;

implementation

procedure TCustomer.WriteCustomerId(Value: Int32);
begin
  inherited CheckLazy;
  Self.FCustomerId := Value;
end;

function TCustomer.ReadCustomerId: Int32;
begin
  inherited CheckLazy;
  Result := Self.FCustomerId;
end;

procedure TCustomer.WriteName(Value: string);
begin
  inherited CheckLazy;
  Self.FName := Value;
end;

function TCustomer.ReadName: string;
begin
  inherited CheckLazy;
  Result := Self.FName;
end;

procedure TCustomer.WriteAddress(Value: string);
begin
  inherited CheckLazy;
  Self.FAddress := Value;
end;

function TCustomer.ReadAddress: string;
begin
  inherited CheckLazy;
  Result := Self.FAddress;
end;

procedure TCustomer.WriteZipcode(Value: string);
begin
  inherited CheckLazy;
  Self.FZipcode := Value;
end;

function TCustomer.ReadZipcode: string;
begin
  inherited CheckLazy;
  Result := Self.FZipcode;
end;

procedure TCustomer.WritePhone(Value: string);
begin
  inherited CheckLazy;
  Self.FPhone := Value;
end;

function TCustomer.ReadPhone: string;
begin
  inherited CheckLazy;
  Result := Self.FPhone;
end;


end.
