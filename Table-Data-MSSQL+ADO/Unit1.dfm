object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 531
  ClientWidth = 592
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
    Top = 185
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
  object Label10: TLabel
    Left = 8
    Top = 136
    Width = 56
    Height = 13
    Caption = 'Table Name'
  end
  object Label11: TLabel
    Left = 296
    Top = 136
    Width = 56
    Height = 13
    Caption = 'Table Name'
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
  object memLog: TMemo
    Left = 7
    Top = 242
    Width = 577
    Height = 89
    Lines.Strings = (
      '<Log>')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object memResult: TMemo
    Left = 7
    Top = 337
    Width = 577
    Height = 186
    Lines.Strings = (
      '<Result SQL>')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 4
  end
  object cbSqlServerVersion: TComboBox
    Left = 105
    Top = 182
    Width = 121
    Height = 21
    Style = csDropDownList
    TabOrder = 5
  end
  object cbAuthM: TCheckBox
    Left = 8
    Top = 159
    Width = 141
    Height = 17
    Caption = 'Windows authentication'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object edtMasterServer: TEdit
    Left = 105
    Top = 51
    Width = 176
    Height = 21
    TabOrder = 7
  end
  object edtTargetDatabaseName: TEdit
    Left = 392
    Top = 24
    Width = 193
    Height = 21
    TabOrder = 8
  end
  object edtTargetPassword: TEdit
    Left = 393
    Top = 105
    Width = 120
    Height = 21
    PasswordChar = '*'
    TabOrder = 9
  end
  object edtTargetUser: TEdit
    Left = 393
    Top = 78
    Width = 120
    Height = 21
    TabOrder = 10
  end
  object edtTargetServer: TEdit
    Left = 393
    Top = 51
    Width = 192
    Height = 21
    TabOrder = 11
  end
  object btnCompare: TButton
    Left = 7
    Top = 209
    Width = 121
    Height = 27
    Caption = 'Compare database'
    TabOrder = 12
    OnClick = btnCompareClick
  end
  object btnUpdate: TButton
    Left = 141
    Top = 209
    Width = 121
    Height = 27
    Caption = 'Update database'
    TabOrder = 13
    OnClick = btnUpdateClick
  end
  object cbAuthT: TCheckBox
    Left = 296
    Top = 159
    Width = 141
    Height = 17
    Caption = 'Windows authentication'
    Checked = True
    State = cbChecked
    TabOrder = 14
  end
  object edtTableNameM: TEdit
    Left = 105
    Top = 132
    Width = 121
    Height = 21
    TabOrder = 15
  end
  object edtTableNameT: TEdit
    Left = 393
    Top = 132
    Width = 121
    Height = 21
    TabOrder = 16
  end
  object ADOConnectionMaster: TADOConnection
    Left = 63
    Top = 432
  end
  object ADOConnectionTarget: TADOConnection
    Left = 207
    Top = 432
  end
  object ConnectionMaster: TDBCConnectionADO
    Connection = ADOConnectionMaster
    OnBeforeConnect = ConnectionMasterBeforeConnect
    OnErrorMessage = AddLogMessage
    OnLogNextLine = AddLogMessage
    Left = 63
    Top = 368
  end
  object ConnectionTarget: TDBCConnectionADO
    Connection = ADOConnectionTarget
    OnBeforeConnect = ConnectionTargetBeforeConnect
    OnErrorMessage = AddLogMessage
    OnLogNextLine = AddLogMessage
    Left = 207
    Top = 360
  end
  object MSSQLExec1: TMSSQLExec
    DBCConnection = ConnectionTarget
    MSSQLServerOptions.SQLServerVersion = st_MSSQL2016
    MSSQLServerOptions.MSSQLCompareOptions.CaseSensitiveIdentifiers = True
    OnLogNextLine = AddLogMessage
    Left = 383
    Top = 384
  end
  object TableDataComparer1: TTableDataComparer
    DBCConnectionMaster = ConnectionMaster
    DBCConnectionTarget = ConnectionTarget
    ScriptFileName = 'Result.SQL'
    BlobFileName = 'C:\Program Files (x86)\Embarcadero\Studio\20.0\bin\Result.LOB'
    SQLExec = MSSQLExec1
    OnLogNextLine = AddLogMessage
    OnErrorMessage = AddLogMessage
    Left = 311
    Top = 256
  end
end
