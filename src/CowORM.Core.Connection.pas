unit CowORM.Core.Connection;

interface

uses
  CowORM.Commons, CowORM.Helpers, CowORM.Core.QueryParam, CowORM.Core.Configurations, 
  CowORM.Core.QueryResult, SysUtils,
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
    oFDCon        : TFDConnection;
    oFDTrans      : TFDTransaction;
    oFDTransUpdate: TFDTransaction;
    oFDWaitCursor : TFDGUIxWaitCursor;
    oFDQuery      : TFDQuery;
  public
    constructor Create; overload;
    constructor Create(Configs: TConfigs); overload;
    function Select(pSQL: string; pParams: TArray<TQueryParam>): TQueryResult; overload;
    function Select(pSQL: string): TQueryResult; overload;
    procedure ExecuteSQL(pSQL: string; pParams: TArray<TQueryParam>); overload;
    procedure ExecuteSQL(pSQL: string); overload;
    procedure CommitTransactions;
  end;

implementation

{ TConnection }

procedure TConnection.CommitTransactions;
begin
  with Self.oFDCon do
    begin
    try
      if not InTransaction then
        StartTransaction;
      Commit;
    except
      on E: Exception do
      begin
        Rollback;
        raise Exception.Create('Error in ConnectionCommit: ' + E.Message);
      end;
    end;
  end;
end;

constructor TConnection.Create(Configs: TConfigs);
begin
  Create;

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
    SQL.Text := pSQL;

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

    try
      ExecSQL;
    except
      on E: Exception do
      begin
        raise Exception.Create('Error in ExecSQL: ' + E.Message);
      end;
    end;

    CommitTransactions;
  end;
end;

procedure TConnection.ExecuteSQL(pSQL: string);
begin
  ExecuteSQL(pSQL, []);
end;

function TConnection.Select(pSQL: string): TQueryResult;
begin
  Result := TQueryResult.Create(Self.oFDCon);
  Result.Select(pSQL);
end;

function TConnection.Select(pSQL: string;
  pParams: TArray<TQueryParam>): TQueryResult;
begin
  Result := TQueryResult.Create(Self.oFDCon);
  Result.Select(pSQL, pParams);
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
