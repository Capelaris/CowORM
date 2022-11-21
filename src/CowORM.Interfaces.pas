unit CowORM.Interfaces;

interface

uses
  CowORM.Commons, FireDAC.Comp.Client, Rtti, JSON;

type
  ISerializable = interface(IUnknown)
  ['{BE9401AD-8D61-4A93-9779-754D3A2A5117}']
    function Serialize: TJSONObject;
  end;

  IConfigs = interface(ISerializable)
  ['{fbeee245-47d7-4e2d-8c48-bc05c0b64af8}']
    procedure SetConnType(Value: TConnectionType);
    function GetConnType: TConnectionType;
    procedure SetDatabase(Value: string);
    function GetDatabase: string;
    procedure SetHostname(Value: string);
    function GetHostname: string;
    procedure SetPort(Value: Integer);
    function GetPort: Integer;
    procedure SetUserName(Value: string);
    function GetUserName: string;
    procedure SetPassword(Value: string);
    function GetPassword: string;
    procedure SetLazy(Value: Boolean);
    function GetLazy: Boolean;
  end;

  IQueryParam = interface(ISerializable)
  ['{3f08b78f-a5b7-4683-86ce-a06f1d939c63}']
    procedure SetFieldName(Value: string);
    function GetFieldName: string;
    procedure SetParamName(Value: string);
    function GetParamName: string;
    procedure SetValue(Value: TValue);
    function GetValue: TValue;
  end;

  IQueryResult = interface(ISerializable)
  ['{2f91b205-2329-4c48-8067-f2c9d0081c08}']
    function Select(pSQL: string; pParams: TArray<IQueryParam>): IQueryResult; overload;
    function Select(pSQL: string): IQueryResult; overload;

    procedure SetQuery(Value: TFDQuery);
    function GetQuery: TFDQuery;
    procedure SetLazy(Value: Boolean);
    function GetLazy: Boolean;
  end;

  IConnection = interface(ISerializable)
  ['{3ef71496-f774-4df7-97d8-6f018ce9abe4}']
    function Select(pSQL: string; pParams: TArray<IQueryParam>): IQueryResult; overload;
    function Select(pSQL: string): IQueryResult; overload;
    procedure ExecuteSQL(pSQL: string; pParams: TArray<IQueryParam>); overload;
    procedure ExecuteSQL(pSQL: string); overload;
    procedure CommitTransactions;
    function Duplicate: IConnection;

    procedure SetLazy(Value: Boolean);
    function GetLazy: Boolean;
    procedure SetConn(Value: TFDConnection);
    function GetConn: TFDConnection;
  end;

implementation

end.
