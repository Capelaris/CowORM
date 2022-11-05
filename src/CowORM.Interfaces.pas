unit CowORM.Interfaces;

interface

uses
  CowORM.Commons;

type
  IConfigurations = interface
    ['{8b8dac43-371a-4d80-b8db-33893a0b506a}']
  end;

  IColumn = interface
    ['{c2cb9633-e8b7-4cb7-b2e6-44ed28a805c5}']
  end;

  ITable = interface
    ['{6c2efb6a-36d4-4f24-9b6d-7fa071df56e3}']
  end;

  IQueryJoin = interface
    ['{732a1281-8ff4-4aca-a8d2-84dbd5e1ce23}']
  end;

  IQueryCondition = interface
    ['{69b45f5d-c285-457c-bf2f-a3d05165f242}']
  end;

  IQuery = interface
    ['{97cc129b-22c2-4f1d-86c4-24fd97d80d72}']
    {constructor Create(pTable: string); overload;
    constructor Create(pTable: ITable); overload;

    property QueryType: TQueryType;
    property Table    : ITable;    }
  end;

  IDBConnection = interface
    ['{191409e0-fa89-4d12-a887-6670b07d6872}']
    {constructor Create; overload;
    constructor Create(pConfigs: IConfigurations); overload;
    constructor Create(pConn: TFDConnection);
    function ReturnRecords<T: class>(pSQL: string): TArray<T>; overload;
    function ReturnRecords<T: class>(pQueryBuilder: IQuery): TArray<T>; overload;
    procedure ExecuteSQL(pSQL: string); overload;
    procedure ExecuteSQL(pQueryBuilder: IQuery); overload;  }
  end;

implementation

end.
