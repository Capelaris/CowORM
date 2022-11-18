unit CowORM.Core.Columns;

interface

uses
  CowORM.Commons, CowORM.Helpers, Rtti, Variants, Data.DB, SysUtils;

type
  TPrimaryKey = class(TCustomAttribute)
  private
    aKeys: TArray<string>;
  public
    constructor Create(pKeys: TArray<string>); overload;
    constructor Create(pKey: string); overload;

    function IsKey(pColumnName: string): Boolean;
    property Keys: TArray<string> read aKeys write aKeys;
  end;

  TColumn = class(TCustomAttribute)
  private
    sName      : string;
    sTableLabel: string;
    iSize      : Integer;
    iScale     : Integer;
    bNotNull   : Boolean;
    tFieldType : TColumnType;
    sCharset   : string;
    sCollate   : string;
    oDefaultVal: TValue;
  public
    constructor Create(pName: string; pType: TColumnType; pSize, pScale: Integer;
      pNotNull: Boolean; pCharset, pCollate: string; pDefaultVal: TValue;
      pTableLabel: string = '');

    function GetValue(pField: TField): TValue; virtual;
    class function Copy(pObject: TColumn): TColumn;

    property Name      : string      read sName       write sName;
    property TableLabel: string      read sTableLabel write sTableLabel;
    property Size      : Integer     read iSize       write iSize;
    property Scale     : Integer     read iScale      write iScale;
    property NotNull   : Boolean     read bNotNull    write bNotNull;
    property FieldType : TColumnType read tFieldType;
    property Charset   : string      read sCharset    write sCharset;
    property Collate   : string      read sCollate    write sCollate;
    property DefaultVal: TValue      read oDefaultVal write oDefaultVal;
  end;

  TSmallIntColumn = class(TColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean = False;
      pDefaultVal: Int16 = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TIntegerColumn = class(TColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean = False;
      pDefaultVal: Int32 = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TBigIntColumn = class(TColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean = False;
      pDefaultVal: Int64 = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TDecimalColumn = class(TColumn)
  public
    constructor Create(pName: string; pSize, pScale: Integer;
      pNotNull: Boolean = False; pDefaultVal: Double = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property Size;
    property Scale;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TNumericColumn = class(TColumn)
  public
    constructor Create(pName: string; pSize, pScale: Integer;
      pNotNull: Boolean = False; pDefaultVal: Double = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property Size;
    property Scale;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TFloatColumn = class(TColumn)
  public
    constructor Create(pName: string; pSize, pScale: Integer;
      pNotNull: Boolean = False; pDefaultVal: Double = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property Size;
    property Scale;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TDoublePrecisionColumn = class(TColumn)
  public
    constructor Create(pName: string; pSize: Integer; pNotNull: Boolean = False;
      pDefaultVal: Double = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property Size;
    property Scale;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TDateColumn = class(TColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean = False;
      pDefaultVal: TDate = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TTimeColumn = class(TColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean = False;
      pDefaultVal: TTime = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TTimeStampColumn = class(TColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean = False;
      pDefaultVal: TDateTime = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TCharColumn = class(TColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean = False;
      pCharset: string = ''; pCollate: string = ''; pDefaultVal: Char = #0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property Size;
    property NotNull;
    property FieldType;
    property Charset;
    property Collate;
    property DefaultVal;
  end;

  TVarcharColumn = class(TColumn)
  public
    constructor Create(pName: string; pSize: Integer; pNotNull: Boolean = False;
      pCharset: string = ''; pCollate: string = ''; pDefaultVal: string = '');
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property Size;
    property NotNull;
    property FieldType;
    property Charset;
    property Collate;
    property DefaultVal;
  end;

  TBlobBinaryColumn = class(TColumn)
  public
    constructor Create(pName: string; pSize: Integer; pNotNull: Boolean;
      pDefaultVal: string = '');
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property Size;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TBlobTextColumn = class(TColumn)
  public
    constructor Create(pName: string; pSize: Integer; pNotNull: Boolean = False;
      pCharset: string = ''; pCollate: string = ''; pDefaultVal: string = '');
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property Size;
    property NotNull;
    property FieldType;
    property Charset;
    property Collate;
    property DefaultVal;
  end;

implementation

{ TColumn }

class function TColumn.Copy(pObject: TColumn): TColumn;
begin
  Result := TColumn.Create(pObject.sName, pObject.tFieldType, pObject.iSize,
      pObject.iScale, pObject.bNotNull, pObject.sCharset, pObject.sCollate,
      pObject.oDefaultVal, pObject.sTableLabel);
end;

constructor TColumn.Create(pName: string; pType: TColumnType; pSize,
  pScale: Integer; pNotNull: Boolean; pCharset, pCollate: string;
  pDefaultVal: TValue; pTableLabel: string);
begin
  inherited Create;

  with Self do
  begin
    sName       := pName;
    sTableLabel := pTableLabel;
    tFieldType  := pType;
    iSize       := pSize;
    iScale      := pScale;
    bNotNull    := pNotNull;
    sCharset    := pCharset;
    sCollate    := pCollate;
    oDefaultVal := pDefaultVal;
  end;
end;

function TColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := TValue.FromVariant(pField.AsVariant);
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + ')->' + E.Message);
  end;
end;

{ TSmallIntColumn }

constructor TSmallIntColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: Int16);
begin
  inherited Create(pName, ctSmallInt, -1, -1, pNotNull, '', '', pDefaultVal);
end;

function TSmallIntColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsInteger;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TIntegerColumn }

constructor TIntegerColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: Int32);
begin
  inherited Create(pName, ctInteger, -1, -1, pNotNull, '', '', pDefaultVal);
end;

function TIntegerColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsInteger;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TBigIntColumn }

constructor TBigIntColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: Int64);
begin
  inherited Create(pName, ctBigInt, -1, -1, pNotNull, '', '', pDefaultVal);
end;

function TBigIntColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsLargeInt;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TDecimalColumn }

constructor TDecimalColumn.Create(pName: string; pSize, pScale: Integer;
  pNotNull: Boolean; pDefaultVal: Double);
begin
  inherited Create(pName, ctDecimal, pSize, pScale, pNotNull, '', '', pDefaultVal);
end;

function TDecimalColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsFloat;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TNumericColumn }

constructor TNumericColumn.Create(pName: string; pSize, pScale: Integer;
  pNotNull: Boolean; pDefaultVal: Double);
begin
  inherited Create(pName, ctNumeric, pSize, pScale, pNotNull, '', '', pDefaultVal);
end;

function TNumericColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsFloat;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TFloatColumn }

constructor TFloatColumn.Create(pName: string; pSize, pScale: Integer;
  pNotNull: Boolean; pDefaultVal: Double);
begin
  inherited Create(pName, ctNumeric, pSize, pScale, pNotNull, '', '', pDefaultVal);
end;

function TFloatColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsFloat;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TDoublePrecisionColumn }

constructor TDoublePrecisionColumn.Create(pName: string; pSize: Integer;
  pNotNull: Boolean; pDefaultVal: Double);
begin
  inherited Create(pName, ctNumeric, pSize, -1, pNotNull, '', '', pDefaultVal);
end;

function TDoublePrecisionColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsFloat;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TDateColumn }

constructor TDateColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: TDate);
begin
  inherited Create(pName, ctDate, -1, -1, pNotNull, '', '', pDefaultVal);
end;

function TDateColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsDateTime;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TTimeColumn }

constructor TTimeColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: TTime);
begin
  inherited Create(pName, ctTime, -1, -1, pNotNull, '', '', pDefaultVal);
end;

function TTimeColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsDateTime;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TTimeStampColumn }

constructor TTimeStampColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: TDateTime);
begin
  inherited Create(pName, ctTimeStamp, -1, -1, pNotNull, '', '', pDefaultVal);
end;

function TTimeStampColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsDateTime;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TCharColumn }

constructor TCharColumn.Create(pName: string; pNotNull: Boolean;
  pCharset, pCollate: string; pDefaultVal: Char);
begin
  inherited Create(pName, ctChar, 1, -1, pNotNull, pCharset, pCollate, pDefaultVal);
end;

function TCharColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsString;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TVarcharColumn }

constructor TVarcharColumn.Create(pName: string; pSize: Integer;
  pNotNull: Boolean; pCharset, pCollate: string; pDefaultVal: string);
begin
  inherited Create(pName, ctVarchar, pSize, -1, pNotNull, pCharset, pCollate, pDefaultVal);
end;

function TVarcharColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsString;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TBlobBinaryColumn }

constructor TBlobBinaryColumn.Create(pName: string; pSize: Integer;
  pNotNull: Boolean; pDefaultVal: string);
begin
  inherited Create(pName, ctVarchar, pSize, -1, pNotNull, '', '', pDefaultVal);
end;

function TBlobBinaryColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsString;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TBlobTextColumn }

constructor TBlobTextColumn.Create(pName: string; pSize: Integer;
  pNotNull: Boolean; pCharset, pCollate: string; pDefaultVal: string);
begin
  inherited Create(pName, ctVarchar, pSize, -1, pNotNull, pCharset, pCollate, pDefaultVal);
end;

function TBlobTextColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsString;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + ')->' + E.Message);
  end;
end;

{ TPrimaryKey }

constructor TPrimaryKey.Create(pKeys: TArray<string>);
begin
  inherited Create;
  Self.aKeys := pKeys;
end;

constructor TPrimaryKey.Create(pKey: string);
begin
  inherited Create();
  Self.aKeys := [pKey];
end;

function TPrimaryKey.IsKey(pColumnName: string): Boolean;
var
  ArrVal: string;
begin
  for ArrVal in Self.aKeys do
  begin
    if pColumnName.ToLower = ArrVal.ToLower then
      Exit(True);
  end;
  Exit(False);
end;

end.
