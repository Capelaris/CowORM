unit Webrole;

interface

uses CowORM;

type
  [TTable('WEBROLE')]
  [TPrimaryKey('WEBROLE_ID')]
  TWebrole = class(TORMObject)
  private
    FWebroleId: Int32;
    FName: string;
  public
    [TIntegerColumn('webrole_id', True)]
    property WebroleId: Int32 read FWebroleId write FWebroleId;
    [TVarcharColumn('name', 63, True, 'UTF8', '')]
    property Name: string read FName write FName;
  end;

implementation
end.
