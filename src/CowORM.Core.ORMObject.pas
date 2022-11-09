unit CowORM.Core.ORMObject;

interface

uses
  CowORM.Helpers, CowORM.Commons;

type
  TORMObject = class(TObject)
  private
    { Private Declarations }
    {OldValues: array of TOldValue;
    function ChangedColumns: TColumns; }

    //function CreateObject: T;
    //class function MountSelect(Id: Integer = -1): string;
    //function MountUpdate: string;
    //function MountInsert: string;
    //function MountDelete: string;
  protected
    isInserted: Boolean;
    //procedure AddOldValue(Name: string; Value: TValue);
    //function IsDiff(Col: TColumn; Value: TValue): Boolean;
  public
    { Public Declarations }
    // Create Function
    //procedure Insert;
    // Read Functions
    //class function Find(Id: Integer): T; overload;
    //class function Find(Id: Integer; Configs: TConfigurations): T; overload;
    class function FindAll: TArray<TORMObject>;// overload;
    //class function FindAll(Configs: TConfigurations): TArray<T>; overload;
    // Update Function
    //procedure Save;
    // Delete Function
    //procedure Delete;

    constructor Create;
  end;

implementation

{ TORMObject<T> }

constructor TORMObject.Create;
begin
  inherited Create;
  Self.isInserted := False;
end;

class function TORMObject.FindAll: TArray<TORMObject>;
begin
  Result := TArray<TORMObject>.Create();

  try
    //Result := DBConnection.ReturnRecord<T>(SQL);
  except
    //Writeln('Error in Query');
  end;
end;

end.
