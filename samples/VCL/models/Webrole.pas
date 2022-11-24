unit Webrole;

interface

uses CowORM, PigQuery;

type
  [TTable('WEBROLE')]
  [TPrimaryKey('WEBROLE_ID')]
  TWebrole = class(TORMObject)
  private
    FWebroleId: Int32;
    FName: string;
    procedure WriteWebroleId(Value: Int32);
    function ReadWebroleId: Int32;
    procedure WriteName(Value: string);
    function ReadName: string;
  public
    [TIntegerColumn('webrole_id', True)]
    property WebroleId: Int32 read ReadWebroleId write WriteWebroleId;
    [TVarcharColumn('name', 63, True, 'UTF8', '')]
    property Name: string read ReadName write WriteName;
  end;

implementation

procedure TWebrole.WriteWebroleId(Value: Int32);
begin
  inherited CheckLazy;
  Self.FWebroleId := Value;
end;

function TWebrole.ReadWebroleId: Int32;
begin
  inherited CheckLazy;
  Result := Self.FWebroleId;
end;

procedure TWebrole.WriteName(Value: string);
begin
  inherited CheckLazy;
  Self.FName := Value;
end;

function TWebrole.ReadName: string;
begin
  inherited CheckLazy;
  Result := Self.FName;
end;


end.
