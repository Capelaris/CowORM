unit Customer;

interface

uses CowORM;

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
  public
    [TIntegerColumn('customer_id', True)]
    property CustomerId: Int32 read FCustomerId write FCustomerId;
    [TVarcharColumn('name', 60, True, 'UTF8', '')]
    property Name: string read FName write FName;
    [TVarcharColumn('address', 250, False, 'UTF8', '')]
    property Address: string read FAddress write FAddress;
    [TCharColumn('zipcode', False, 'UTF8', 'UTF8')]
    property Zipcode: string read FZipcode write FZipcode;
    [TVarcharColumn('phone', 14, False, 'UTF8', '')]
    property Phone: string read FPhone write FPhone;
  end;

implementation
end.
