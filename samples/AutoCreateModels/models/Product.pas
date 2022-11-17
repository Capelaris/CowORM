unit Product;

interface

uses CowORM;

type
  [TTable('PRODUCT')]
  [TPrimaryKey('PRODUCT_ID')]
  TProduct = class(TORMObject)
  private
    FProductId: Int32;
    FName: string;
    FPrice: Double;
    FDescription: string;
  public
    [TIntegerColumn('product_id', True)]
    property ProductId: Int32 read FProductId write FProductId;
    [TVarcharColumn('name', 100, True, 'UTF8', '')]
    property Name: string read FName write FName;
    [TNumericColumn('price', 15, 2, True)]
    property Price: Double read FPrice write FPrice;
    [TBlobTextColumn('description', 0, False, 'UTF8', '')]
    property Description: string read FDescription write FDescription;
  end;

implementation
end.
