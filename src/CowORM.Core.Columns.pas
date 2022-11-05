unit CowORM.Core.Columns;

interface

uses
  CowORM.Commons, CowORM.Interfaces, System.Rtti;

type
  TColumn = class(TCustomAttribute, IColumn)
  private
    sName      : string;
    iSize      : Integer;
    iScale     : Integer;
    bNotNull   : Boolean;
    oFieldType : TColumnType;
    sCharset   : string;
    sCollate   : string;
    oDefaultVal: TValue;
  protected
    FRefCount: Integer;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    constructor Create(pName: string; pType: TColumnType; pSize, pScale: Integer;
      pNotNull: Boolean; pCharset, pCollate: string; pDefaultVal: TValue);

    property RefCount  : Integer     read FRefCount;
    property Name      : string      read sName       write sName;
    property Size      : Integer     read iSize       write iSize;
    property Scale     : Integer     read iScale      write iScale;
    property NotNull   : Boolean     read bNotNull    write bNotNull;
    property FieldType : TColumnType read oFieldType;
    property Charset   : string      read sCharset    write sCharset;
    property Collate   : string      read sCollate    write sCollate;
    property DefaultVal: TValue      read oDefaultVal write oDefaultVal;
  end;

  TSmallIntColumn = class(TColumn, IColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean; pDefaultVal: TValue);

    property RefCount;
    property Name;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TIntegerColumn = class(TColumn, IColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean; pDefaultVal: TValue);

    property RefCount;
    property Name;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TBigIntColumn = class(TColumn, IColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean; pDefaultVal: TValue);

    property RefCount;
    property Name;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TDecimalColumn = class(TColumn, IColumn)
  public
    constructor Create(pName: string; pSize, pScale: Integer; pNotNull: Boolean;
        pDefaultVal: TValue);

    property RefCount;
    property Name;
    property Size;
    property Scale;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TNumericColumn = class(TColumn, IColumn)
  public
    constructor Create(pName: string; pSize, pScale: Integer; pNotNull: Boolean;
        pDefaultVal: TValue);

    property RefCount;
    property Name;
    property Size;
    property Scale;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TFloatColumn = class(TColumn, IColumn)
  public
    constructor Create(pName: string; pSize, pScale: Integer; pNotNull: Boolean;
        pDefaultVal: TValue);

    property RefCount;
    property Name;
    property Size;
    property Scale;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TDoublePrecisionColumn = class(TColumn, IColumn)
  public
    constructor Create(pName: string; pSize: Integer; pNotNull: Boolean;
        pDefaultVal: TValue);

    property RefCount;
    property Name;
    property Size;
    property Scale;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TDateColumn = class(TColumn, IColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean; pDefaultVal: TValue);

    property RefCount;
    property Name;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TTimeColumn = class(TColumn, IColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean; pDefaultVal: TValue);

    property RefCount;
    property Name;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TTimeStampColumn = class(TColumn, IColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean; pDefaultVal: TValue);

    property RefCount;
    property Name;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TCharColumn = class(TColumn, IColumn)
  public
    constructor Create(pName: string; pType: TColumnType; pNotNull: Boolean;
      pCharset, pCollate: string; pDefaultVal: TValue);

    property RefCount;
    property Name;
    property Size;
    property NotNull;
    property FieldType;
    property Charset;
    property Collate;
    property DefaultVal;
  end;

  TVarcharColumn = class(TColumn, IColumn)
  public
    constructor Create(pName: string; pType: TColumnType; pSize: Integer;
      pNotNull: Boolean; pCharset, pCollate: string; pDefaultVal: TValue);

    property RefCount;
    property Name;
    property Size;
    property NotNull;
    property FieldType;
    property Charset;
    property Collate;
    property DefaultVal;
  end;

  TBlobBinaryColumn = class(TColumn, IColumn)
  public
    constructor Create(pName: string; pType: TColumnType; pSize: Integer;
      pNotNull: Boolean; pDefaultVal: TValue);

    property RefCount;
    property Name;
    property Size;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TBlobTextColumn = class(TColumn, IColumn)
  public
    constructor Create(pName: string; pType: TColumnType; pSize: Integer;
      pNotNull: Boolean; pCharset, pCollate: string; pDefaultVal: TValue);

    property RefCount;
    property Name;
    property Size;
    property NotNull;
    property FieldType;
    property Charset;
    property Collate;
    property DefaultVal;
  end;

implementation

{ TColumn }

constructor TColumn.Create(pName: string; pType: TColumnType; pSize,
  pScale: Integer; pNotNull: Boolean; pCharset, pCollate: string;
  pDefaultVal: TValue);
begin
  inherited Create;

  with Self do
  begin
    sName       := pName;
    oFieldType  := pType;
    iSize       := pSize;
    iScale      := pScale;
    bNotNull    := pNotNull;
    sCharset    := pCharset;
    sCollate    := pCollate;
    oDefaultVal := pDefaultVal;
  end;
end;

function TColumn.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TColumn._AddRef: Integer;
begin
  Result := -1;
end;

function TColumn._Release: Integer;
begin
  Result := -1;
end;

{ TSmallIntColumn }

constructor TSmallIntColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: TValue);
begin
  inherited Create(pName, ctSmallInt, -1, -1, pNotNull, '', '', pDefaultVal);
end;

{ TIntegerColumn }

constructor TIntegerColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: TValue);
begin
  inherited Create(pName, ctInteger, -1, -1, pNotNull, '', '', pDefaultVal);
end;

{ TBigIntColumn }

constructor TBigIntColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: TValue);
begin
  inherited Create(pName, ctBigInt, -1, -1, pNotNull, '', '', pDefaultVal);
end;

{ TDecimalColumn }

constructor TDecimalColumn.Create(pName: string; pSize, pScale: Integer;
  pNotNull: Boolean; pDefaultVal: TValue);
begin
  inherited Create(pName, ctDecimal, pSize, pScale, pNotNull, '', '', pDefaultVal);
end;

{ TNumericColumn }

constructor TNumericColumn.Create(pName: string; pSize, pScale: Integer;
  pNotNull: Boolean; pDefaultVal: TValue);
begin
  inherited Create(pName, ctNumeric, pSize, pScale, pNotNull, '', '', pDefaultVal);
end;

{ TFloatColumn }

constructor TFloatColumn.Create(pName: string; pSize, pScale: Integer;
  pNotNull: Boolean; pDefaultVal: TValue);
begin
  inherited Create(pName, ctNumeric, pSize, pScale, pNotNull, '', '', pDefaultVal);
end;

{ TDoublePrecisionColumn }

constructor TDoublePrecisionColumn.Create(pName: string; pSize: Integer;
  pNotNull: Boolean; pDefaultVal: TValue);
begin
  inherited Create(pName, ctNumeric, pSize, -1, pNotNull, '', '', pDefaultVal);
end;

{ TDateColumn }

constructor TDateColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: TValue);
begin
  inherited Create(pName, ctDate, -1, -1, pNotNull, '', '', pDefaultVal);
end;

{ TTimeColumn }

constructor TTimeColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: TValue);
begin
  inherited Create(pName, ctTime, -1, -1, pNotNull, '', '', pDefaultVal);
end;

{ TTimeStampColumn }

constructor TTimeStampColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: TValue);
begin
  inherited Create(pName, ctTimeStamp, -1, -1, pNotNull, '', '', pDefaultVal);
end;

{ TCharColumn }

constructor TCharColumn.Create(pName: string; pType: TColumnType;
  pNotNull: Boolean; pCharset, pCollate: string; pDefaultVal: TValue);
begin
  inherited Create(pName, ctChar, 1, -1, pNotNull, pCharset, pCollate, pDefaultVal);
end;

{ TVarcharColumn }

constructor TVarcharColumn.Create(pName: string; pType: TColumnType;
  pSize: Integer; pNotNull: Boolean; pCharset, pCollate: string;
  pDefaultVal: TValue);
begin
  inherited Create(pName, ctVarchar, pSize, -1, pNotNull, pCharset, pCollate, pDefaultVal);
end;

{ TBlobBinaryColumn }

constructor TBlobBinaryColumn.Create(pName: string; pType: TColumnType;
  pSize: Integer; pNotNull: Boolean; pDefaultVal: TValue);
begin
  inherited Create(pName, ctVarchar, pSize, -1, pNotNull, '', '', pDefaultVal);
end;

{ TBlobTextColumn }

constructor TBlobTextColumn.Create(pName: string; pType: TColumnType;
  pSize: Integer; pNotNull: Boolean; pCharset, pCollate: string;
  pDefaultVal: TValue);
begin
  inherited Create(pName, ctVarchar, pSize, -1, pNotNull, pCharset, pCollate, pDefaultVal);
end;

end.
