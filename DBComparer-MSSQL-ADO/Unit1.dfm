object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Comparer MSSql-ADO'
  ClientHeight = 507
  ClientWidth = 594
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
    Top = 22
    Width = 75
    Height = 13
    Caption = 'Database name'
  end
  object LabelUserM: TLabel
    Left = 8
    Top = 80
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object LabelPswdM: TLabel
    Left = 8
    Top = 108
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label1: TLabel
    Left = 7
    Top = 158
    Width = 92
    Height = 13
    Caption = 'SQL Server Version'
  end
  object Label2: TLabel
    Left = 8
    Top = 52
    Width = 32
    Height = 13
    Caption = 'Server'
  end
  object Label4: TLabel
    Left = 8
    Top = 3
    Width = 45
    Height = 13
    Caption = 'Master...'
  end
  object Label5: TLabel
    Left = 296
    Top = 3
    Width = 44
    Height = 13
    Caption = 'Target...'
  end
  object Label6: TLabel
    Left = 296
    Top = 22
    Width = 75
    Height = 13
    Caption = 'Database name'
  end
  object Label7: TLabel
    Left = 296
    Top = 80
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object Label8: TLabel
    Left = 296
    Top = 108
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label9: TLabel
    Left = 296
    Top = 52
    Width = 32
    Height = 13
    Caption = 'Server'
  end
  object edtMasterDatabaseName: TEdit
    Left = 105
    Top = 24
    Width = 176
    Height = 21
    TabOrder = 0
  end
  object edtMasterPassword: TEdit
    Left = 105
    Top = 105
    Width = 120
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object edtMasterUser: TEdit
    Left = 105
    Top = 78
    Width = 120
    Height = 21
    TabOrder = 2
  end
  object btnExtract: TBitBtn
    Left = 8
    Top = 182
    Width = 121
    Height = 27
    Caption = 'Extract database'
    TabOrder = 3
    OnClick = btnExtractClick
  end
  object memLog: TMemo
    Left = 9
    Top = 215
    Width = 577
    Height = 89
    Lines.Strings = (
      '<Log>')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object memResult: TMemo
    Left = 8
    Top = 310
    Width = 577
    Height = 186
    Lines.Strings = (
      '<Result SQL>')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 5
  end
  object cbSqlServerVersion: TComboBox
    Left = 105
    Top = 155
    Width = 121
    Height = 21
    Style = csDropDownList
    TabOrder = 6
  end
  object cbAuthM: TCheckBox
    Left = 8
    Top = 132
    Width = 141
    Height = 17
    Caption = 'Windows authentication'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object edtMasterServer: TEdit
    Left = 105
    Top = 51
    Width = 176
    Height = 21
    TabOrder = 8
  end
  object edtTargetDatabaseName: TEdit
    Left = 392
    Top = 24
    Width = 193
    Height = 21
    TabOrder = 9
  end
  object edtTargetPassword: TEdit
    Left = 393
    Top = 105
    Width = 120
    Height = 21
    PasswordChar = '*'
    TabOrder = 10
  end
  object edtTargetUser: TEdit
    Left = 393
    Top = 78
    Width = 120
    Height = 21
    TabOrder = 11
  end
  object edtTargetServer: TEdit
    Left = 393
    Top = 51
    Width = 192
    Height = 21
    TabOrder = 12
  end
  object btnCompare: TButton
    Left = 135
    Top = 182
    Width = 121
    Height = 27
    Caption = 'Compare database'
    TabOrder = 13
    OnClick = btnCompareClick
  end
  object btnUpdate: TButton
    Left = 262
    Top = 182
    Width = 121
    Height = 27
    Caption = 'Update database'
    TabOrder = 14
    OnClick = btnUpdateClick
  end
  object cbAuthT: TCheckBox
    Left = 296
    Top = 132
    Width = 141
    Height = 17
    Caption = 'Windows authentication'
    Checked = True
    State = cbChecked
    TabOrder = 15
  end
  object ADOConnection1: TADOConnection
    Left = 24
    Top = 336
  end
  object ADOConnection2: TADOConnection
    Left = 312
    Top = 328
  end
  object DBStructure1: TDBStructure
    Left = 32
    Top = 408
  end
  object DBStructure2: TDBStructure
    Left = 312
    Top = 400
  end
  object DBCConnectionADO1: TDBCConnectionADO
    Connection = ADOConnection1
    OnBeforeConnect = DBCConnectionADO1BeforeConnect
    OnErrorMessage = AddErrorMessage
    OnLogNextLine = AddErrorMessage
    Left = 104
    Top = 352
  end
  object DBCConnectionADO2: TDBCConnectionADO
    Connection = ADOConnection2
    OnBeforeConnect = DBCConnectionADO2BeforeConnect
    OnErrorMessage = AddErrorMessage
    OnLogNextLine = AddErrorMessage
    Left = 392
    Top = 344
  end
  object MSSQLDBExtract1: TMSSQLDBExtract
    DBCConnection = DBCConnectionADO1
    DBStructure = DBStructure1
    OnLogNextLine = AddErrorMessage
    Left = 104
    Top = 424
  end
  object MSSQLDBExtract2: TMSSQLDBExtract
    DBCConnection = DBCConnectionADO2
    DBStructure = DBStructure2
    OnLogNextLine = AddErrorMessage
    Left = 384
    Top = 416
  end
  object MSSQLExec1: TMSSQLExec
    DBCConnection = DBCConnectionADO2
    MSSQLServerOptions.SQLServerVersion = st_MSSQL2016
    MSSQLServerOptions.MSSQLCompareOptions.CaseSensitiveIdentifiers = True
    OnLogNextLine = AddErrorMessage
    OnErrorMessage = AddErrorMessage
    Left = 456
    Top = 248
  end
  object DBComparer1: TDBComparer
    DatabaseType = dbMSSQL
    DBStructureMaster = DBStructure1
    DBStructureTarget = DBStructure2
    SQLExec = MSSQLExec1
    MSSQLServerOptions.SQLServerVersion = st_MSSQL2016
    MSSQLServerOptions.MSSQLCompareOptions.CaseSensitiveIdentifiers = True
    OnLogNextLine = AddErrorMessage
    OnErrorMessage = AddErrorMessage
    Left = 272
    Top = 248
  end
end
