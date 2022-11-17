unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, IOUtils, FileCtrl, CowORM,
  CowORM.Helpers, FireDAC.Comp.Client, StrUtils, Types, Diagnostics, TimeSpan,
  Rtti, ComCtrls;

type
  TfMainForm = class(TForm)
    edtDatabase: TEdit;
    lblDBLocation: TLabel;
    lblDBLocation1: TLabel;
    edtModels: TEdit;
    btnSearchDBLocation: TButton;
    btnSearchFolder: TButton;
    btnGenerateModels: TButton;
    grpParams: TGroupBox;
    lblDBLocation2: TLabel;
    edtParamIP: TEdit;
    edtParamPort: TEdit;
    lblDBLocation3: TLabel;
    lblDBLocation4: TLabel;
    edtParamUsername: TEdit;
    edtParamPassword: TEdit;
    lblDBLocation5: TLabel;
    pbProgress: TProgressBar;
    lblStatus: TLabel;
    lblColunas: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSearchDBLocationClick(Sender: TObject);
    procedure btnSearchFolderClick(Sender: TObject);
    procedure btnGenerateModelsClick(Sender: TObject);
  private
    { Private declarations }
    function FormatTableName(pTableName: string): string;
    function GetColumnClass(pQuery: TFDQuery): string;
    function GetFieldType(pType: string): string;
  public
    { Public declarations }
  end;

var
  fMainForm: TfMainForm;

implementation

{$R *.dfm}

procedure TfMainForm.btnGenerateModelsClick(Sender: TObject);
var
  Config : TConfigs;
  Conn   : TConnection;
  Select : TSelectQuery;
  Tables : TQueryResult;
  Columns: TQueryResult;
  PK, FK : TArray<string>;
  Content: TStringList;
  ClassN : string;
  FKUses : string;
  PKAttr : string;
  FileN  : string;
  Count  : Integer;
  CountC : Integer;
  SW     : TStopwatch;
  Elapsed: TTimeSpan;
  Seconds: Double;
begin
  Config := TConfigs.Create(TConnectionType.ctFB, edtParamIP.Text,
      StrToInt(edtParamPort.Text), edtParamUsername.Text, edtParamPassword.Text,
      edtDatabase.Text);
  Conn := TConnection.Create(Config);

  SysUtils.ForceDirectories(edtModels.Text);

  for FileN in TDirectory.GetFiles(edtModels.Text, '.*') do 
    TFile.Delete(FileN);

  Select := TSelectQuery.Create('RDB$RELATIONS');
  Tables := Conn.Select(
      Select
          .Where('COALESCE(RDB$SYSTEM_FLAG, 0)', '0')
          .Where('RDB$RELATION_TYPE', '0')
          .GetSQL(['RDB$RELATION_NAME']));
  Count  := 0;
  CountC := 0;
  pbProgress.Min := 0;
  pbProgress.Max := Tables.Query.RecordCount;
  pbProgress.Position := Count;
  lblStatus.Caption   := 'Tabelas: ' + IntTostr(Count) + '/' + IntTostr(Tables.Query.RecordCount);
  lblColunas.Caption  := 'Colunas: ' + IntTostr(CountC);
  SW        := TStopwatch.StartNew;

  Tables.Query.First;
  while not Tables.Query.Eof do
  begin
    Columns := Conn.Select(
        'with                                                                             ' + #13#10 +
        'fk as (                                                                          ' + #13#10 +
        '    select PK.RDB$RELATION_NAME as PKTABLE_NAME,                                 ' + #13#10 +
        '           ISP.RDB$FIELD_NAME as PKCOLUMN_NAME,                                  ' + #13#10 +
        '           FK.RDB$RELATION_NAME as FKTABLE_NAME,                                 ' + #13#10 +
        '           ISF.RDB$FIELD_NAME as FKCOLUMN_NAME,                                  ' + #13#10 +
        '           (ISP.RDB$FIELD_POSITION + 1) as KEY_SEQ,                              ' + #13#10 +
        '           RC.RDB$UPDATE_RULE as UPDATE_RULE,                                    ' + #13#10 +
        '           RC.RDB$DELETE_RULE as DELETE_RULE,                                    ' + #13#10 +
        '           PK.RDB$CONSTRAINT_NAME as PK_NAME,                                    ' + #13#10 +
        '           FK.RDB$CONSTRAINT_NAME as FK_NAME                                     ' + #13#10 +
        '    from RDB$RELATION_CONSTRAINTS PK,                                            ' + #13#10 +
        '         RDB$RELATION_CONSTRAINTS FK,                                            ' + #13#10 +
        '         RDB$REF_CONSTRAINTS RC,                                                 ' + #13#10 +
        '         RDB$INDEX_SEGMENTS ISP,                                                 ' + #13#10 +
        '         RDB$INDEX_SEGMENTS ISF                                                  ' + #13#10 +
        '    WHERE FK.RDB$CONSTRAINT_NAME = RC.RDB$CONSTRAINT_NAME and                    ' + #13#10 +
        '          PK.RDB$CONSTRAINT_NAME = RC.RDB$CONST_NAME_UQ and                      ' + #13#10 +
        '          ISP.RDB$INDEX_NAME = PK.RDB$INDEX_NAME and                             ' + #13#10 +
        '          ISF.RDB$INDEX_NAME = FK.RDB$INDEX_NAME and                             ' + #13#10 +
        '          ISP.RDB$FIELD_POSITION = ISF.RDB$FIELD_POSITION                        ' + #13#10 +
        '    order by 1, 5                                                                ' + #13#10 +
        ')                                                                                ' + #13#10 +
        '                                                                                 ' + #13#10 +
        'SELECT RF.RDB$FIELD_NAME FIELD_NAME,                                             ' + #13#10 +
        '       (CASE F.RDB$FIELD_TYPE                                                    ' + #13#10 +
        '            WHEN 7 THEN                                                          ' + #13#10 +
        '                CASE F.RDB$FIELD_SUB_TYPE                                        ' + #13#10 +
        '                    WHEN 0 THEN ''SMALLINT''                                     ' + #13#10 +
        '                    WHEN 1 THEN ''NUMERIC''                                      ' + #13#10 +
        '                    WHEN 2 THEN ''DECIMAL''                                      ' + #13#10 +
        '                END                                                              ' + #13#10 +
        '            WHEN 8 THEN                                                          ' + #13#10 +
        '                CASE F.RDB$FIELD_SUB_TYPE                                        ' + #13#10 +
        '                    WHEN 0 THEN ''INTEGER''                                      ' + #13#10 +
        '                    WHEN 1 THEN ''NUMERIC''                                      ' + #13#10 +
        '                    WHEN 2 THEN ''DECIMAL''                                      ' + #13#10 +
        '                END                                                              ' + #13#10 +
        '            WHEN 9 THEN ''QUAD''                                                 ' + #13#10 +
        '            WHEN 10 THEN ''FLOAT''                                               ' + #13#10 +
        '            WHEN 12 THEN ''DATE''                                                ' + #13#10 +
        '            WHEN 13 THEN ''TIME''                                                ' + #13#10 +
        '            WHEN 14 THEN ''CHAR''                                                ' + #13#10 +
        '            WHEN 16 THEN                                                         ' + #13#10 +
        '                CASE F.RDB$FIELD_SUB_TYPE                                        ' + #13#10 +
        '                    WHEN 0 THEN ''BIGINT''                                       ' + #13#10 +
        '                    WHEN 1 THEN ''NUMERIC''                                      ' + #13#10 +
        '                    WHEN 2 THEN ''DECIMAL''                                      ' + #13#10 +
        '                END                                                              ' + #13#10 +
        '            WHEN 27 THEN ''DOUBLE''                                              ' + #13#10 +
        '            WHEN 35 THEN ''TIMESTAMP''                                           ' + #13#10 +
        '            WHEN 37 THEN ''VARCHAR''                                             ' + #13#10 +
        '            WHEN 40 THEN ''CSTRING''                                             ' + #13#10 +
        '            WHEN 45 THEN ''BLOB_ID''                                             ' + #13#10 +
        '            WHEN 261 THEN ''BLOB SUB_TYPE '' || F.RDB$FIELD_SUB_TYPE             ' + #13#10 +
        '            ELSE ''RDB$FIELD_TYPE: '' || F.RDB$FIELD_TYPE || ''?''               ' + #13#10 +
        '        END) FIELD_TYPE,                                                         ' + #13#10 +
        '        (CASE F.RDB$FIELD_TYPE                                                   ' + #13#10 +
        '            WHEN 7 THEN                                                          ' + #13#10 +
        '                CASE F.RDB$FIELD_SUB_TYPE WHEN 1 THEN F.RDB$FIELD_PRECISION END  ' + #13#10 +
        '            WHEN 8 THEN                                                          ' + #13#10 +
        '                CASE F.RDB$FIELD_SUB_TYPE WHEN 1 THEN F.RDB$FIELD_PRECISION END  ' + #13#10 +
        '            WHEN 16 THEN                                                         ' + #13#10 +
        '                CASE F.RDB$FIELD_SUB_TYPE WHEN 1 THEN F.RDB$FIELD_PRECISION END  ' + #13#10 +
        '            WHEN 37 THEN (TRUNC(F.RDB$FIELD_LENGTH / CH.RDB$BYTES_PER_CHARACTER))' + #13#10 +
        '            WHEN 40 THEN (TRUNC(F.RDB$FIELD_LENGTH / CH.RDB$BYTES_PER_CHARACTER))' + #13#10 +
        '            ELSE NULL                                                            ' + #13#10 +
        '        END) FIELD_SIZE,                                                         ' + #13#10 +
        '        (CASE F.RDB$FIELD_TYPE                                                   ' + #13#10 +
        '            WHEN 7 THEN                                                          ' + #13#10 +
        '                CASE F.RDB$FIELD_SUB_TYPE WHEN 1 THEN (-F.RDB$FIELD_SCALE) END   ' + #13#10 +
        '            WHEN 8 THEN                                                          ' + #13#10 +
        '                CASE F.RDB$FIELD_SUB_TYPE WHEN 1 THEN (-F.RDB$FIELD_SCALE) END   ' + #13#10 +
        '            WHEN 16 THEN                                                         ' + #13#10 +
        '                CASE F.RDB$FIELD_SUB_TYPE WHEN 1 THEN (-F.RDB$FIELD_SCALE) END   ' + #13#10 +
        '            ELSE NULL                                                            ' + #13#10 +
        '        END) FIELD_PRECISION,                                                    ' + #13#10 +
        '        IIF(COALESCE(RF.RDB$NULL_FLAG, 0) = 0, NULL, ''NOT NULL'') FIELD_NULL,   ' + #13#10 +
        '        CH.RDB$CHARACTER_SET_NAME FIELD_CHARSET,                                 ' + #13#10 +
        '        DCO.RDB$COLLATION_NAME FIELD_COLLATION,                                  ' + #13#10 +
        '        COALESCE(RF.RDB$DEFAULT_SOURCE, F.RDB$DEFAULT_SOURCE) FIELD_DEFAULT,     ' + #13#10 +
        '        (case when sg.rdb$field_name is not null then ''True''                   ' + #13#10 +
        '        else ''False''                                                           ' + #13#10 +
        '        end) as PRIMARY_KEY,                                                     ' + #13#10 +
        '        fk.PKTABLE_NAME                                                          ' + #13#10 +
        'FROM RDB$RELATION_FIELDS RF                                                      ' + #13#10 +
        'JOIN RDB$FIELDS F ON                                                             ' + #13#10 +
        'F.RDB$FIELD_NAME = RF.RDB$FIELD_SOURCE                                           ' + #13#10 +
        'LEFT OUTER JOIN RDB$CHARACTER_SETS CH ON                                         ' + #13#10 +
        'CH.RDB$CHARACTER_SET_ID = F.RDB$CHARACTER_SET_ID                                 ' + #13#10 +
        'LEFT OUTER JOIN RDB$COLLATIONS DCO ON                                            ' + #13#10 +
        'DCO.RDB$COLLATION_ID = F.RDB$COLLATION_ID AND                                    ' + #13#10 +
        'DCO.RDB$CHARACTER_SET_ID = F.RDB$CHARACTER_SET_ID                                ' + #13#10 +
        'left join rdb$relation_constraints rc on                                         ' + #13#10 +
        'rc.rdb$relation_name = RF.RDB$RELATION_NAME AND                                  ' + #13#10 +
        'rc.rdb$constraint_type = ''PRIMARY KEY''                                         ' + #13#10 +
        'left join rdb$index_segments sg on                                               ' + #13#10 +
        'sg.rdb$index_name = rc.rdb$index_name and                                        ' + #13#10 +
        'sg.rdb$field_name = RF.RDB$FIELD_NAME                                            ' + #13#10 +
        'left join fk on                                                                  ' + #13#10 +
        'fk.FKTABLE_NAME = RF.RDB$RELATION_NAME and                                       ' + #13#10 +
        'fk.FKCOLUMN_NAME = RF.RDB$FIELD_NAME                                             ' + #13#10 +
        'WHERE (UPPER(RF.RDB$RELATION_NAME) = upper(:TABLE_NAME)) AND                     ' + #13#10 +
        '      (COALESCE(RF.RDB$SYSTEM_FLAG, 0) = 0)                                      ' + #13#10 +
        'ORDER BY RF.RDB$FIELD_POSITION                                                   ',
        [TQueryParam.Create('table_name', TValue.From(Tables.Query.FieldByName('rdb$relation_name').AsString))]);

    PK := [];
    FK := [];
    with Columns.Query do
    begin
      First;
      while not Eof do
      begin
        if FieldByName('PRIMARY_KEY').AsString = 'True' then
          TArrayUtils<string>.Append(PK, FieldByName('FIELD_NAME').AsString);
        if FieldByName('PKTABLE_NAME').AsString <> '' then
          TArrayUtils<string>.Append(FK, FormatTableName(FieldByName('PKTABLE_NAME').AsString));
        Next;
      end;

      FKUses := string.Join(', ', FK);
      if FKUses <> '' then
        FKUses := ', ' + FKUses;

      PKAttr := '';
      if Length(PK) = 1 then
        PKAttr := #13#10 + '  [TPrimaryKey(''' + string.Join(''', ''', PK) + ''')]';

      ClassN := FormatTableName(Tables.Query.FieldByName('rdb$relation_name').AsString);
      Content := TStringList.Create;
      Content.Add('unit ' + ClassN + ';' + #13#10);
      Content.Add('interface' + #13#10);
      Content.Add('uses CowORM' + FKUses + ';' + #13#10);
      Content.Add('type');
      Content.Add('  [TTable(' + QuotedStr(Tables.Query.FieldByName('rdb$relation_name').AsString) + ')]' + PKAttr);
      Content.Add('  T' + ClassN + ' = class(TORMObject)');
      Content.Add('  private');

      First;
      while not Eof do
      begin
        if FieldByName('PKTABLE_NAME').AsString <> '' then
          Content.Add('    F' + FormatTableName(FieldByName('PKTABLE_NAME').AsString) + ': T' +
              FormatTableName(FieldByName('PKTABLE_NAME').AsString) + ';')
        else
          Content.Add('    F' + FormatTableName(FieldByName('FIELD_NAME').AsString) + ': ' +
              GetFieldType(FieldByName('FIELD_TYPE').AsString) + ';');

        Next;
      end;
      
      Content.Add('  public');

      First;
      while not Eof do
      begin
        Content.Add('    [' + GetColumnClass(Columns.Query) + ']');
        if FieldByName('PKTABLE_NAME').AsString <> '' then
          Content.Add('    property ' + FormatTableName(FieldByName('PKTABLE_NAME').AsString) + ': T' +
              FormatTableName(FieldByName('PKTABLE_NAME').AsString) + ' read F' + 
              FormatTableName(FieldByName('PKTABLE_NAME').AsString) + ' write F' +
              FormatTableName(FieldByName('PKTABLE_NAME').AsString) + ';')
        else
          Content.Add('    property ' + FormatTableName(FieldByName('FIELD_NAME').AsString) + ': ' +
              GetFieldType(FieldByName('FIELD_TYPE').AsString) + ' read F' +
              FormatTableName(FieldByName('FIELD_NAME').AsString) + ' write F' +
              FormatTableName(FieldByName('FIELD_NAME').AsString) + ';');

        CountC := CountC + 1;
        lblColunas.Caption  := 'Colunas: ' + IntTostr(CountC);

        Next;
      end;
      
      Content.Add('  end;' + #13#10);
      Content.Add('implementation' + #13#10 + 'end.');

      Content.SaveToFile(edtModels.Text + '/' + ClassN + '.pas');
    end;

    Count := Count + 1;
    pbProgress.Max := Tables.Query.RecordCount;
    pbProgress.Position := Count;
    lblStatus.Caption   := 'Tabelas: ' + IntTostr(Count) + '/' + IntTostr(Tables.Query.RecordCount);
    Application.ProcessMessages;

    Tables.Query.Next;
  end;
  Elapsed := SW.Elapsed;
  Seconds := (Elapsed.TotalMilliseconds / 1000);
  ShowMessage('Task Completed in : ' + FormatFloat('###,###,###,##0.0000', Seconds) + 's');
end;

procedure TfMainForm.btnSearchDBLocationClick(Sender: TObject);
var
  Dialog: TOpenDialog;
begin
  Dialog := TOpenDialog.Create(Self);
  Dialog.Options := [ofFileMustExist, ofPathMustExist];
  Dialog.Filter  := 'Firebird Databases (*.fdb, *.gdb)|*.FDB;*.GDB';
  if Dialog.Execute then
  begin
    edtDatabase.Text := Dialog.FileName;
  end;
end;

procedure TfMainForm.btnSearchFolderClick(Sender: TObject);
var
  Dir: string;
begin
  Dir := edtModels.Text;
  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt], 1000) then
    edtModels.Text := Dir;
end;

function TfMainForm.FormatTableName(pTableName: string): string;
var
  Name: string;
begin
  Result := '';
  for Name in (pTableName.Split(['_'])) do
    Result := Result + Uppercase(Copy(Name, 1, 1)) + Lowercase(Copy(Name, 2, Length(Name)));  
end;

procedure TfMainForm.FormCreate(Sender: TObject);
begin
  edtDatabase.Text := TPath.GetFullPath('../../../../database/examples.fdb');
  edtModels.Text   := TPath.GetFullPath('../../models');
end;

function TfMainForm.GetColumnClass(pQuery: TFDQuery): string;
var
  ClassN: string;
  Props : string;
begin
  with pQuery do
  begin
    Props := '';
    if Trim(FieldByName('field_type').AsString) = 'SMALLINT' then
      ClassN := 'TSmallIntColumn('
    else if Trim(FieldByName('field_type').AsString) = 'NUMERIC' then
      ClassN := 'TNumericColumn('
    else if Trim(FieldByName('field_type').AsString) = 'DECIMAL' then
      ClassN := 'TDecimalColumn('   
    else if Trim(FieldByName('field_type').AsString) = 'INTEGER' then
      ClassN := 'TIntegerColumn('   
    else if Trim(FieldByName('field_type').AsString) = 'BIGINT' then
      ClassN := 'TBigIntColumn('
    else if Trim(FieldByName('field_type').AsString) = 'FLOAT' then
      ClassN := 'TFloatColumn('   
    else if Trim(FieldByName('field_type').AsString) = 'DOUBLE' then
      ClassN := 'TDoublePrecisionColumn('   
    else if Trim(FieldByName('field_type').AsString) = 'DATE' then
      ClassN := 'TDateColumn('   
    else if Trim(FieldByName('field_type').AsString) = 'TIME' then
      ClassN := 'TTimeColumn('   
    else if Trim(FieldByName('field_type').AsString) = 'TIMESTAMP' then
      ClassN := 'TTimeStampColumn('   
    else if Trim(FieldByName('field_type').AsString) = 'CHAR' then
      ClassN := 'TCharColumn('   
    else if Trim(FieldByName('field_type').AsString) = 'VARCHAR' then
      ClassN := 'TVarcharColumn('   
    else if Trim(FieldByName('field_type').AsString) = 'BLOB SUB_TYPE 1' then
      ClassN := 'TBlobTextColumn('
    else if Trim(FieldByName('field_type').AsString) = 'BLOB SUB_TYPE 0' then
      ClassN := 'TBlobBinaryColumn(';

    Props := QuotedStr(FieldByName('field_name').AsString.ToLower);

    if MatchStr(FieldByName('field_type').AsString, ['NUMERIC', 'DECIMAL', 
        'FLOAT', 'DOUBLE', 'VARCHAR', 'BLOB SUB_TYPE 1', 'BLOB SUB_TYPE 0']) then
    begin
      Props := Props + ', ' + IntToStr(FieldByName('field_size').AsInteger);
    end;

    if MatchStr(FieldByName('field_type').AsString, ['NUMERIC', 'DECIMAL', 
        'FLOAT']) then
    begin  
      Props := Props + ', ' + IntToStr(FieldByName('field_precision').AsInteger);
    end;
      
    if FieldByName('field_null').AsString <> 'NOT NULL' then
      Props := Props + ', False'
    else
      Props := Props + ', True';

    if MatchStr(FieldByName('field_type').AsString, ['CHAR', 'VARCHAR', 
        'BLOB SUB_TYPE 1']) then
    begin
      Props := Props + ', ' + QuotedStr(FieldByName('field_charset').AsString);
      Props := Props + ', ' + QuotedStr(FieldByName('field_collation').AsString);
    end;

    Result := ClassN + Props + ')';
  end;
end;

function TfMainForm.GetFieldType(pType: string): string;
begin
  Result := '';
  if Trim(pType) = 'SMALLINT' then
    Result := 'Int16'
  else if Trim(pType) = 'NUMERIC' then
    Result := 'Double'
  else if Trim(pType) = 'DECIMAL' then
    Result := 'Double'
  else if Trim(pType) = 'INTEGER' then
    Result := 'Int32'   
  else if Trim(pType) = 'BIGINT' then
    Result := 'Int64'   
  else if Trim(pType) = 'FLOAT' then
    Result := 'Double'   
  else if Trim(pType) = 'DOUBLE' then
    Result := 'Double'   
  else if Trim(pType) = 'DATE' then
    Result := 'TDateTime'   
  else if Trim(pType) = 'TIME' then
    Result := 'TDateTime'   
  else if Trim(pType) = 'TIMESTAMP' then
    Result := 'TDateTime'   
  else if Trim(pType) = 'CHAR' then
    Result := 'string'
  else if Trim(pType) = 'VARCHAR' then
    Result := 'string'   
  else if Trim(pType) = 'BLOB SUB_TYPE 1' then
    Result := 'string'    
  else if Trim(pType) = 'BLOB SUB_TYPE 0' then
    Result := 'string';
end;

end.