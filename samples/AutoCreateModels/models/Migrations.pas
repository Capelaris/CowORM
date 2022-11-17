unit Migrations;

interface

uses CowORM;

type
  [TTable('migrations')]
  TMigrations = class(TORMObject)
  private
    FMigration: string;
    FBatch: Int32;
  public
    [TVarcharColumn('migration', 255, True, 'UTF8', 'UTF8')]
    property Migration: string read FMigration write FMigration;
    [TIntegerColumn('batch', True)]
    property Batch: Int32 read FBatch write FBatch;
  end;

implementation
end.
