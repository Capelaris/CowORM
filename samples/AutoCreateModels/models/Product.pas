unit Product;

interface

uses CowORM, PigQuery;

type
  [TTable('PRODUCT')]
  [TPrimaryKey('PRODUCT_ID')]
  TProduct = class(TORMObject)
  private
    FProductId: Int32;
    FName: string;
    FPrice: Double;
    FDescription: string;
    procedure WriteProductId(Value: Int32);
    function ReadProductId: Int32;
    procedure WriteName(Value: string);
    function ReadName: string;
    procedure WritePrice(Value: Double);
    function ReadPrice: Double;
    procedure WriteDescription(Value: string);
    function ReadDescription: string;
  public
    [TIntegerColumn('product_id', True)]
    property ProductId: Int32 read ReadProductId write WriteProductId;
    [TVarcharColumn('name', 100, True, 'UTF8', '')]
    property Name: string read ReadName write WriteName;
    [TNumericColumn('price', 15, 2, True)]
    property Price: Double read ReadPrice write WritePrice;
    [TBlobTextColumn('description', 0, False, 'UTF8', '')]
    property Description: string read ReadDescription write WriteDescription;
  end;

implementation

procedure TProduct.WriteProductId(Value: Int32);
begin
  inherited CheckLazy;
  Self.FProductId := Value;
end;

function TProduct.ReadProductId: Int32;
begin
  inherited CheckLazy;
  Result := Self.FProductId;
end;

procedure TProduct.WriteName(Value: string);
begin
  inherited CheckLazy;
  Self.FName := Value;
end;

function TProduct.ReadName: string;
begin
  inherited CheckLazy;
  Result := Self.FName;
end;

procedure TProduct.WritePrice(Value: Double);
begin
  inherited CheckLazy;
  Self.FPrice := Value;
end;

function TProduct.ReadPrice: Double;
begin
  inherited CheckLazy;
  Result := Self.FPrice;
end;

procedure TProduct.WriteDescription(Value: string);
begin
  inherited CheckLazy;
  Self.FDescription := Value;
end;

function TProduct.ReadDescription: string;
begin
  inherited CheckLazy;
  Result := Self.FDescription;
end;


end.
