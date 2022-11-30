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
    class function Find(Id: Integer): TWebrole; overload;                   
    class function Find(Id: Integer; Configs: IConfigs): TWebrole; overload;
    class function Find(Id: Integer; Conn: IConnection): TWebrole; overload;
    class function FindAll: TArray<TWebrole>; overload;                     
    class function FindAll(Configs: IConfigs): TArray<TWebrole>; overload;  
    class function FindAll(Conn: IConnection): TArray<TWebrole>; overload;  

    [TIntegerColumn('webrole_id', True)]
    property WebroleId: Int32 read ReadWebroleId write WriteWebroleId;
    [TVarcharColumn('name', 63, True, 'UTF8', '')]
    property Name: string read ReadName write WriteName;
  end;

implementation

class function TWebrole.Find(Id: Integer): TWebrole;                   
begin
  Result := TWebrole.Find<TWebrole>(Id);
end;

class function TWebrole.Find(Id: Integer; Configs: IConfigs): TWebrole;
begin
  Result := TWebrole.Find<TWebrole>(Id, Configs);
end;

class function TWebrole.Find(Id: Integer; Conn: IConnection): TWebrole;
begin
  Result := TWebrole.Find<TWebrole>(Id, Conn);
end;

class function TWebrole.FindAll: TArray<TWebrole>;                     
begin
  Result := TWebrole.FindAll<TWebrole>;
end;

class function TWebrole.FindAll(Configs: IConfigs): TArray<TWebrole>;  
begin
  Result := TWebrole.FindAll<TWebrole>(Configs);
end;

class function TWebrole.FindAll(Conn: IConnection): TArray<TWebrole>;  
begin
  Result := TWebrole.FindAll<TWebrole>(Conn);
end;

procedure TWebrole.WriteWebroleId(Value: Int32);
begin
  Self.FWebroleId := Value;
end;

function TWebrole.ReadWebroleId: Int32;
begin
  inherited CheckLazy;
  Result := Self.FWebroleId;
end;

procedure TWebrole.WriteName(Value: string);
begin
  Self.FName := Value;
end;

function TWebrole.ReadName: string;
begin
  inherited CheckLazy;
  Result := Self.FName;
end;


end.
