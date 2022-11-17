object fMainForm: TfMainForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Main Form'
  ClientHeight = 210
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Reference Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lblDBLocation: TLabel
    Left = 8
    Top = 12
    Width = 105
    Height = 15
    Caption = 'Database Location'
  end
  object lblDBLocation1: TLabel
    Left = 8
    Top = 41
    Width = 78
    Height = 15
    Caption = 'Models Folder'
  end
  object lblStatus: TLabel
    Left = 8
    Top = 159
    Width = 72
    Height = 15
    Caption = 'Tabelas: 0/0'
  end
  object lblColunas: TLabel
    Left = 260
    Top = 159
    Width = 62
    Height = 15
    BiDiMode = bdRightToLeft
    Caption = 'Colunas: 0'
    ParentBiDiMode = False
  end
  object edtDatabase: TEdit
    Left = 119
    Top = 8
    Width = 290
    Height = 23
    TabOrder = 0
  end
  object edtModels: TEdit
    Left = 119
    Top = 37
    Width = 290
    Height = 23
    TabOrder = 2
  end
  object btnSearchDBLocation: TButton
    Left = 415
    Top = 6
    Width = 34
    Height = 25
    Caption = '...'
    TabOrder = 1
    OnClick = btnSearchDBLocationClick
  end
  object btnSearchFolder: TButton
    Left = 415
    Top = 35
    Width = 34
    Height = 25
    Caption = '...'
    TabOrder = 3
    OnClick = btnSearchFolderClick
  end
  object btnGenerateModels: TButton
    Left = 328
    Top = 159
    Width = 121
    Height = 43
    Caption = 'Generate Models'
    TabOrder = 5
    OnClick = btnGenerateModelsClick
  end
  object grpParams: TGroupBox
    Left = 8
    Top = 66
    Width = 441
    Height = 87
    Caption = 'Params to Connect'
    TabOrder = 4
    object lblDBLocation2: TLabel
      Left = 6
      Top = 23
      Width = 62
      Height = 15
      Caption = 'IP Address'
    end
    object lblDBLocation3: TLabel
      Left = 223
      Top = 23
      Width = 23
      Height = 15
      Caption = 'Port'
    end
    object lblDBLocation4: TLabel
      Left = 6
      Top = 52
      Width = 58
      Height = 15
      Caption = 'Username'
    end
    object lblDBLocation5: TLabel
      Left = 223
      Top = 52
      Width = 54
      Height = 15
      Caption = 'Password'
    end
    object edtParamIP: TEdit
      Left = 74
      Top = 19
      Width = 143
      Height = 23
      TabOrder = 0
      Text = 'localhost'
    end
    object edtParamPort: TEdit
      Left = 283
      Top = 19
      Width = 85
      Height = 23
      NumbersOnly = True
      TabOrder = 1
      Text = '3050'
    end
    object edtParamUsername: TEdit
      Left = 74
      Top = 48
      Width = 143
      Height = 23
      TabOrder = 2
      Text = 'sysdba'
    end
    object edtParamPassword: TEdit
      Left = 283
      Top = 48
      Width = 143
      Height = 23
      PasswordChar = '*'
      TabOrder = 3
      Text = 'masterkey'
    end
  end
  object pbProgress: TProgressBar
    Left = 8
    Top = 180
    Width = 314
    Height = 22
    TabOrder = 6
  end
end
