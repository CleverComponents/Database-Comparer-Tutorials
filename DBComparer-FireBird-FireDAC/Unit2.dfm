object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'DBComparerFireDAC'
  ClientHeight = 452
  ClientWidth = 707
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
  object Label1: TLabel
    Left = 8
    Top = 2
    Width = 45
    Height = 13
    Caption = 'Master...'
  end
  object Label2: TLabel
    Left = 8
    Top = 27
    Width = 76
    Height = 13
    Caption = 'Database Name'
  end
  object Label3: TLabel
    Left = 8
    Top = 108
    Width = 63
    Height = 16
    Caption = 'Client Library'
  end
  object Label4: TLabel
    Left = 8
    Top = 54
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object Label5: TLabel
    Left = 8
    Top = 81
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label6: TLabel
    Left = 360
    Top = 2
    Width = 44
    Height = 13
    Caption = 'Target...'
  end
  object Label7: TLabel
    Left = 360
    Top = 24
    Width = 76
    Height = 13
    Caption = 'Database Name'
  end
  object Label8: TLabel
    Left = 360
    Top = 51
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object Label9: TLabel
    Left = 360
    Top = 78
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label10: TLabel
    Left = 360
    Top = 108
    Width = 92
    Height = 13
    Caption = 'SQL Server Version'
  end
  object edtMasterDbName: TEdit
    Left = 112
    Top = 24
    Width = 233
    Height = 21
    TabOrder = 0
  end
  object edtMasterUser: TEdit
    Left = 112
    Top = 51
    Width = 129
    Height = 21
    TabOrder = 1
    Text = 'SYSDBA'
  end
  object edtMasterPassword: TEdit
    Left = 112
    Top = 78
    Width = 129
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    Text = 'masterkey'
  end
  object edtTargetDbName: TEdit
    Left = 464
    Top = 24
    Width = 233
    Height = 21
    TabOrder = 3
  end
  object edtTargetUser: TEdit
    Left = 464
    Top = 51
    Width = 129
    Height = 21
    TabOrder = 4
    Text = 'SYSDBA'
  end
  object edtTargetPassword: TEdit
    Left = 464
    Top = 78
    Width = 129
    Height = 21
    PasswordChar = '*'
    TabOrder = 5
    Text = 'masterkey'
  end
  object edtClientLibrary: TEdit
    Left = 112
    Top = 105
    Width = 233
    Height = 21
    TabOrder = 6
  end
  object cbSqlServerVersion: TComboBox
    Left = 464
    Top = 105
    Width = 129
    Height = 21
    Style = csDropDownList
    TabOrder = 7
  end
  object btnExtract: TButton
    Left = 8
    Top = 132
    Width = 98
    Height = 37
    Caption = 'Extract...'
    TabOrder = 8
    OnClick = btnExtractClick
  end
  object btnCompare: TButton
    Left = 112
    Top = 132
    Width = 122
    Height = 37
    Caption = 'Compare...'
    TabOrder = 9
    OnClick = btnCompareClick
  end
  object btnUpdate: TButton
    Left = 240
    Top = 132
    Width = 105
    Height = 37
    Caption = 'Update'
    TabOrder = 10
    OnClick = btnUpdateClick
  end
  object memLog: TMemo
    Left = 8
    Top = 175
    Width = 689
    Height = 82
    Lines.Strings = (
      '<Log>')
    ScrollBars = ssBoth
    TabOrder = 11
  end
  object memResult: TMemo
    Left = 8
    Top = 263
    Width = 689
    Height = 181
    Lines.Strings = (
      '<Result Script>')
    ScrollBars = ssBoth
    TabOrder = 12
  end
  object DBCConnection1: TDBCConnectionFireDAC
    Database = FDConnection1
    OnBeforeConnect = DBCConnection2BeforeConnect
    OnErrorMessage = AddLogMessage
    Left = 224
    Top = 304
  end
  object IBDBExtract1: TIBDBExtract
    DBCConnection = DBCConnection1
    DBStructure = DBStructure1
    OnLogNextLine = AddLogMessage
    OnErrorMessage = AddLogMessage
    Left = 144
    Top = 304
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 56
    Top = 304
  end
  object FDConnection1: TFDConnection
    LoginPrompt = False
    Left = 56
    Top = 368
  end
  object DBStructure1: TDBStructure
    IBServerOptions.SQLServerVersion = st_Firebird_30
    Left = 136
    Top = 360
  end
  object FDConnection2: TFDConnection
    LoginPrompt = False
    Left = 384
    Top = 360
  end
  object DBStructure2: TDBStructure
    IBServerOptions.SQLServerVersion = st_Firebird_30
    Left = 480
    Top = 352
  end
  object IBDBExtract2: TIBDBExtract
    DBCConnection = DBCConnection2
    DBStructure = DBStructure2
    OnLogNextLine = AddLogMessage
    OnErrorMessage = AddLogMessage
    Left = 384
    Top = 312
  end
  object DBCConnection2: TDBCConnectionFireDAC
    Database = FDConnection2
    OnBeforeConnect = DBCConnection2BeforeConnect
    OnErrorMessage = AddLogMessage
    Left = 480
    Top = 304
  end
  object DBComparer1: TDBComparer
    DatabaseType = dbInterBase
    DBStructureMaster = DBStructure1
    DBStructureTarget = DBStructure2
    SQLExec = IBSQLExec
    IBServerOptions.SQLServerVersion = st_Firebird_30
    OnLogNextLine = AddLogMessage
    OnErrorMessage = AddLogMessage
    Left = 320
    Top = 200
  end
  object IBSQLExec: TIBSQLExec
    IBServerOptions.SQLServerVersion = st_Firebird_30
    DBCConnection = DBCConnection2
    OnLogNextLine = AddLogMessage
    OnErrorMessage = AddLogMessage
    Left = 496
    Top = 200
  end
end
