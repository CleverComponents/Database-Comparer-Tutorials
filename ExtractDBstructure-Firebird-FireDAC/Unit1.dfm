object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Extract Interbase / Firebird'
  ClientHeight = 421
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 6
    Width = 75
    Height = 13
    Caption = 'Database name'
  end
  object LabelUserM: TLabel
    Left = 8
    Top = 65
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object LabelPswdM: TLabel
    Left = 8
    Top = 92
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label1: TLabel
    Left = 394
    Top = 38
    Width = 92
    Height = 13
    Caption = 'SQL Server Version'
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 63
    Height = 13
    Caption = 'Client Library'
  end
  object edtDatabaseName: TEdit
    Left = 89
    Top = 8
    Width = 528
    Height = 21
    TabOrder = 0
  end
  object edtPassword: TEdit
    Left = 89
    Top = 89
    Width = 152
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
    Text = 'masterkey'
  end
  object edtUser: TEdit
    Left = 89
    Top = 62
    Width = 152
    Height = 21
    TabOrder = 2
    Text = 'SYSDBA'
  end
  object btnExtract: TBitBtn
    Left = 456
    Top = 62
    Width = 161
    Height = 51
    Caption = 'Extract database'
    TabOrder = 5
    OnClick = btnExtractClick
  end
  object memLog: TMemo
    Left = 8
    Top = 132
    Width = 609
    Height = 89
    Lines.Strings = (
      '<Log>')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object memResult: TMemo
    Left = 8
    Top = 227
    Width = 609
    Height = 186
    Lines.Strings = (
      '<Result SQL>')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 7
  end
  object cbSqlServerVersion: TComboBox
    Left = 496
    Top = 35
    Width = 121
    Height = 21
    Style = csDropDownList
    TabOrder = 4
  end
  object edtClientLibrary: TEdit
    Left = 89
    Top = 35
    Width = 272
    Height = 21
    TabOrder = 1
  end
  object DBStructure1: TDBStructure
    IBServerOptions.SQLServerVersion = st_Firebird_30
    Left = 136
    Top = 288
  end
  object IBDBExtract1: TIBDBExtract
    DBCConnection = DBCConnection1
    DBStructure = DBStructure1
    OnLogNextLine = AddLogMessage
    OnErrorMessage = AddLogMessage
    Left = 136
    Top = 232
  end
  object FDConnection1: TFDConnection
    LoginPrompt = False
    Left = 56
    Top = 296
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 56
    Top = 232
  end
  object DBCConnection1: TDBCConnectionFireDAC
    Database = FDConnection1
    OnBeforeConnect = DBCConnection1BeforeConnect
    OnErrorMessage = AddLogMessage
    Left = 200
    Top = 232
  end
end
