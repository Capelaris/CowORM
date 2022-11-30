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
    class function Find(Id: Integer; Configs: IConfigs): TProduct; overload;
    class function Find(Id: Integer; Conn: IConnection): TProduct; overload;
    class function FindAll(Configs: IConfigs): TArray<TProduct>; overload;  
    class function FindAll(Conn: IConnection): TArray<TProduct>; overload;  

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

class function TProduct.Find(Id: Integer; Configs: IConfigs): TProduct;
begin
  Result := TProduct.Find<TProduct>(Id, Configs);
end;

class function TProduct.Find(Id: Integer; Conn: IConnection): TProduct;
begin
  Result := TProduct.Find<TProduct>(Id, Conn);
end;

class function TProduct.FindAll(Configs: IConfigs): TArray<TProduct>;  
begin
  Result := TProduct.FindAll<TProduct>(Configs);
end;

class function TProduct.FindAll(Conn: IConnection): TArray<TProduct>;  
begin
  Result := TProduct.FindAll<TProduct>(Conn);
end;

procedure TProduct.WriteProductId(Value: Int32);
begin
  Self.FProductId := Value;
end;

function TProduct.ReadProductId: Int32;
begin
  inherited CheckLazy;
  Result := Self.FProductId;
end;

procedure TProduct.WriteName(Value: string);
begin
  Self.FName := Value;
end;

function TProduct.ReadName: string;
begin
  inherited CheckLazy;
  Result := Self.FName;
end;

procedure TProduct.WritePrice(Value: Double);
begin
  Self.FPrice := Value;
end;

function TProduct.ReadPrice: Double;
begin
  inherited CheckLazy;
  Result := Self.FPrice;
end;

procedure TProduct.WriteDescription(Value: string);
begin
  Self.FDescription := Value;
end;

function TProduct.ReadDescription: string;
begin
  inherited CheckLazy;
  Result := Self.FDescription;
end;


end.
