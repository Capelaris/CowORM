object FrmMainForm: TFrmMainForm
  Left = 0
  Top = 0
  Caption = 'Main Form'
  ClientHeight = 513
  ClientWidth = 737
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object dbgrdMain: TDBGrid
    Left = 0
    Top = 0
    Width = 737
    Height = 482
    Align = alClient
    DataSource = dsMain
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 482
    Width = 737
    Height = 31
    Align = alBottom
    TabOrder = 1
    object btnFindAll: TButton
      AlignWithMargins = True
      Left = 648
      Top = 4
      Width = 85
      Height = 23
      Align = alRight
      Caption = 'Find all'
      TabOrder = 0
      OnClick = btnFindAllClick
    end
  end
  object dsMain: TDataSource
    DataSet = mmtblMain
    Left = 520
    Top = 272
  end
  object mmtblMain: TFDMemTable
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 568
    Top = 272
  end
end
