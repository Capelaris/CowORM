unit CowORM.Core.Connection;

interface

uses
  CowORM.Commons, CowORM.Helpers, CowORM.Core.QueryParams, CowORM.Core.Configurations, 
  SysUtils,
  //Default FireDAC units
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Stan.Def, FireDAC.DApt,
  FireDAC.Stan.Async, FireDAC.Phys,
  //FireBird
  FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  //MySQL
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  TConnection = class
  private
    { Private Declarations }
    oFDCon        : TFDConnection;
    oFDTrans      : TFDTransaction;
    oFDTransUpdate: TFDTransaction;
    oFDWaitCursor : TFDGUIxWaitCursor;
    oFDQuery      : TFDQuery;
  public
    { Public Declarations }
    constructor Create; overload;
    constructor Create(Configs: TConfigs); overload;
    function Select(pSQL: string; pParams: TArray<TQueryParam>): TConnection; overload;
    function Select(pSQL: string): TConnection; overload;
    procedure ExecuteSQL(pSQL: string; pParams: TArray<TQueryParam>); overload;
    procedure ExecuteSQL(pSQL: string); overload;
  end;

implementation

{ TConnection }

constructor TConnection.Create(Configs: TConfigs);
begin
  inherited Self.Create;

  with Self.oFDCon do
  begin
    DriverName  := GetDriverName(Configs.ConnType);
    with TFDPhysMySQLConnectionDefParams(Params) do
    begin
      DriverID := GetDriverID(Configs.ConnType);
      Database := Configs.Database;
      Server   := Configs.Hostname;
      Port     := Configs.Port;
      UserName := Configs.UserName;
      Password := Configs.Password;
    end;
  end;
end;

procedure TConnection.ExecuteSQL(pSQL: string; pParams: TArray<TQueryParam>);
var
  Param: TQueryParam;
begin
  with Self.oFDQuery do
  begin
    SQL := pSQL;

    for Param in pParams do
    begin
      try
        ParamByName(Param.ParamName).Value := Param.Value.AsVariant;
      except
        on E: Exception do
        begin
          raise Exception.Create('Error in ExecSQLParam: ' + E.Message);
        end;
      end;
    end;  
  end;
end;

procedure TConnection.ExecuteSQL(pSQL: string);
begin
  inherited ExecuteSQL(pSQL, []);
end;

constructor TConnection.Create;
begin
  inherited Create;
  with Self do
  begin
    oFDTrans       := TFDTransaction.Create(nil);
    oFDTransUpdate := TFDTransaction.Create(nil);
    oFDWaitCursor  := TFDGUIxWaitCursor.Create(nil);
    oFDCon         := TFDConnection.Create(nil);
    oFDQuery       := TFDQuery.Create(nil);

    oFDQuery.Connection := oFDCon;

    with oFDCon do
    begin
      Transaction       := oFDTrans;
      UpdateTransaction := oFDTransUpdate;
      LoginPrompt       := False;
    end;
  end;
end;

end.
