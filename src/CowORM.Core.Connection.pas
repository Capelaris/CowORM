unit CowORM.Core.Connection;

interface

uses
  CowORM.Commons, CowORM.Helpers, CowORM.Core.Param,
  CowORM.Core.Result, CowORM.Interfaces, SysUtils, JSON,
  //Default FireDAC units
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Stan.Def, FireDAC.DApt,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Stan.Param,
  //FireBird
  FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  //MySQL
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  TConnection = class(TInterfacedObject, IConnection)
  private
    oFDCon        : TFDConnection;
    oFDTrans      : TFDTransaction;
    oFDTransUpdate: TFDTransaction;
    oFDWaitCursor : TFDGUIxWaitCursor;
    oFDQuery      : TFDQuery;
    bLazyResults  : Boolean;
    oConfigs      : IConfigs;

    procedure SetLazy(Value: Boolean);
    function GetLazy: Boolean;
    procedure SetConn(Value: TFDConnection);
    function GetConn: TFDConnection;
  public
    constructor Create; overload;
    constructor Create(Configs: IConfigs); overload;
    function Select(pSQL: string; pParams: TArray<IParam>): IResult; overload;
    function Select(pSQL: string): IResult; overload;
    procedure ExecuteSQL(pSQL: string; pParams: TArray<IParam>); overload;
    procedure ExecuteSQL(pSQL: string); overload;
    procedure CommitTransactions;
    function Serialize: TJSONObject;
    function Duplicate: IConnection;

    property Lazy: Boolean       read bLazyResults write bLazyResults;
    property Conn: TFDConnection read oFDCon       write oFDCon;
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
        raise Exception.Create('ConnectionCommit->' + E.Message);
      end;
    end;
  end;
end;

constructor TConnection.Create(Configs: IConfigs);
begin
  Create;

  Self.bLazyResults := Configs.GetLazy;
  Self.oConfigs     := Configs;
  with Self.oFDCon do
  begin
    DriverName := GetDriverName(Configs.GetConnType);
    with TFDPhysMySQLConnectionDefParams(Params) do
    begin
      DriverID := GetDriverID(Configs.GetConnType);
      Database := Configs.GetDatabase;
      Server   := Configs.GetHostname;
      Port     := Configs.GetPort;
      UserName := Configs.GetUserName;
      Password := Configs.GetPassword;
    end;

    try
      Connected := True;
    except
      on E: Exception do
        raise Exception.Create('Database Connection->' + E.Message);
    end;
  end;
end;

function TConnection.Duplicate: IConnection;
begin
  Result := TConnection.Create(Self.oConfigs);
end;

procedure TConnection.ExecuteSQL(pSQL: string; pParams: TArray<IParam>);
var
  Param: IParam;
begin
  with Self.oFDQuery do
  begin
    SQL.Text := pSQL;

    for Param in pParams do
    begin
      try
        ParamByName(Param.GetParamName).Value := Param.GetValue.AsVariant;
      except
        on E: Exception do
        begin
          raise Exception.Create('ExecSQLParam->' + E.Message);
        end;
      end;
    end;  

    try
      ExecSQL;
    except
      on E: Exception do
      begin
        raise Exception.Create('ExecSQL->' + E.Message);
      end;
    end;

    CommitTransactions;
  end;
end;

procedure TConnection.ExecuteSQL(pSQL: string);
begin
  ExecuteSQL(pSQL, []);
end;

function TConnection.GetConn: TFDConnection;
begin
  Result := Self.oFDCon;
end;

function TConnection.GetLazy: Boolean;
begin
  Result := Self.bLazyResults;
end;

function TConnection.Select(pSQL: string): IResult;
begin
  Result := TResult.Create(Self, Self.bLazyResults);
  Result.Select(pSQL);
end;

function TConnection.Serialize: TJSONObject;
begin
  Result := TJSONObject.Create;
  With Result do
  begin
    if Self.oFDCon <> nil then
      AddPair(TJSONPair.Create('FDConn', Self.oFDCon.ClassName))
    else
      AddPair(TJSONPair.Create('FDConn', TJSONNull.Create));

    if Self.oFDTrans <> nil then
      AddPair(TJSONPair.Create('FDTrans', Self.oFDTrans.ClassName))
    else
      AddPair(TJSONPair.Create('FDTrans', TJSONNull.Create));

    if Self.oFDTransUpdate <> nil then
      AddPair(TJSONPair.Create('FDTransUpdate', Self.oFDTransUpdate.ClassName))
    else
      AddPair(TJSONPair.Create('FDTransUpdate', TJSONNull.Create));

    if Self.oFDWaitCursor <> nil then
      AddPair(TJSONPair.Create('FDWaitCursor', Self.oFDWaitCursor.ClassName))
    else
      AddPair(TJSONPair.Create('FDWaitCursor', TJSONNull.Create));

    if Self.oFDQuery <> nil then
      AddPair(TJSONPair.Create('FDQuery', Self.oFDQuery.ClassName))
    else
      AddPair(TJSONPair.Create('FDQuery', TJSONNull.Create));

    AddPair(TJSONPair.Create('Lazy', TJSONBool.Create(Self.bLazyResults)));
  end;
end;

procedure TConnection.SetConn(Value: TFDConnection);
begin
  Self.oFDCon := Value;
end;

procedure TConnection.SetLazy(Value: Boolean);
begin
  Self.bLazyResults := Value;
end;

function TConnection.Select(pSQL: string;
  pParams: TArray<IParam>): IResult;
begin
  Result := TResult.Create(Self, Self.bLazyResults);
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
