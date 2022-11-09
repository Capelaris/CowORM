unit Customer;

interface

uses
  CowORM, Rtti;

type
  [TTable('customer')]
  //[TPrimaryKey('customer_id', 11, True)]
  TCustomer = class(TORMObject)
  private
    FId     : Integer;
    FName   : string;
    FAddress: string;
    FZipCode: string;
    FPhone  : string;
  public
    [TIntegerColumn('customer_id', True, NullVal)]
    property Id: Integer read FId write FId;
    [TVarcharColumn('name', 60, False, '', '', NullVal)]
    property Name: string read FName write FName;
    [TVarcharColumn('address', 250, False, '', '', NullVal)]
    property Address: string read FAddress write FAddress;
    [TVarcharColumn('zipcode', 10, False, '', '', NullVal)]
    property ZipCode: string read FZipCode write FZipCode;
    [TVarcharColumn('phone', 14, False, '', '', NullVal)]
    property Phone: string read FPhone write FPhone;
  end;

implementation

end.
