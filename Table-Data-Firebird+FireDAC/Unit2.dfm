object Form2: TForm2
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'Table Data Comparer FireBird + FireDAC'
  ClientHeight = 367
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 45
    Height = 13
    Caption = 'Master...'
  end
  object Label2: TLabel
    Left = 0
    Top = 19
    Width = 76
    Height = 13
    Caption = 'Database Name'
  end
  object Label3: TLabel
    Left = 0
    Top = 125
    Width = 63
    Height = 13
    Caption = 'Client Library'
  end
  object Label4: TLabel
    Left = 0
    Top = 44
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object Label5: TLabel
    Left = 0
    Top = 71
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label6: TLabel
    Left = 352
    Top = 0
    Width = 44
    Height = 13
    Caption = 'Target...'
  end
  object Label7: TLabel
    Left = 352
    Top = 19
    Width = 76
    Height = 13
    Caption = 'Database Name'
  end
  object Label8: TLabel
    Left = 352
    Top = 44
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object Label9: TLabel
    Left = 352
    Top = 71
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label10: TLabel
    Left = 0
    Top = 152
    Width = 92
    Height = 13
    Caption = 'SQL Server Version'
  end
  object Label11: TLabel
    Left = 0
    Top = 98
    Width = 56
    Height = 13
    Caption = 'Table Name'
  end
  object Label12: TLabel
    Left = 352
    Top = 98
    Width = 56
    Height = 13
    Caption = 'Table Name'
  end
  object edtMasterDbName: TEdit
    Left = 104
    Top = 16
    Width = 233
    Height = 21
    TabOrder = 0
  end
  object edtMasterUser: TEdit
    Left = 104
    Top = 41
    Width = 129
    Height = 21
    TabOrder = 1
    Text = 'SYSDBA'
  end
  object edtMasterPassword: TEdit
    Left = 104
    Top = 68
    Width = 129
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    Text = 'masterkey'
  end
  object edtTargetDbName: TEdit
    Left = 455
    Top = 16
    Width = 233
    Height = 21
    TabOrder = 3
  end
  object edtTargetUser: TEdit
    Left = 455
    Top = 41
    Width = 129
    Height = 21
    TabOrder = 4
    Text = 'SYSDBA'
  end
  object edtTargetPassword: TEdit
    Left = 455
    Top = 68
    Width = 129
    Height = 21
    PasswordChar = '*'
    TabOrder = 5
    Text = 'masterkey'
  end
  object edtClientLibrary: TEdit
    Left = 104
    Top = 122
    Width = 584
    Height = 21
    TabOrder = 6
  end
  object cbSqlServerVersion: TComboBox
    Left = 104
    Top = 149
    Width = 129
    Height = 21
    Style = csDropDownList
    TabOrder = 7
  end
  object btnCompare: TButton
    Left = 239
    Top = 149
    Width = 98
    Height = 23
    Caption = 'Compare...'
    TabOrder = 8
    OnClick = btnCompareClick
  end
  object btnUpdate: TButton
    Left = 343
    Top = 149
    Width = 98
    Height = 23
    Caption = 'Update...'
    TabOrder = 9
    OnClick = btnUpdateClick
  end
  object memLog: TMemo
    Left = 0
    Top = 178
    Width = 234
    Height = 189
    Lines.Strings = (
      '<Log>')
    TabOrder = 10
  end
  object memResult: TMemo
    Left = 240
    Top = 178
    Width = 448
    Height = 189
    Lines.Strings = (
      '<Result Script>')
    TabOrder = 11
  end
  object edtTableNameM: TEdit
    Left = 104
    Top = 95
    Width = 129
    Height = 21
    TabOrder = 12
  end
  object edtTableNameT: TEdit
    Left = 455
    Top = 95
    Width = 129
    Height = 21
    TabOrder = 13
  end
  object FDConnection1: TFDConnection
    Left = 280
    Top = 304
  end
  object FDConnection2: TFDConnection
    Left = 368
    Top = 304
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 128
    Top = 248
  end
  object DBCConnectionM: TDBCConnectionFireDAC
    Database = FDConnection1
    OnBeforeConnect = DBCConnectionMBeforeConnect
    OnErrorMessage = AddLogMessage
    Left = 280
    Top = 224
  end
  object DBCConnectionT: TDBCConnectionFireDAC
    Database = FDConnection2
    OnBeforeConnect = DBCConnectionTBeforeConnect
    OnErrorMessage = AddLogMessage
    Left = 368
    Top = 224
  end
  object IBSQLExec1: TIBSQLExec
    DBCConnection = DBCConnectionT
    OnLogNextLine = AddLogMessage
    OnErrorMessage = AddLogMessage
    Left = 128
    Top = 304
  end
  object TableDataComparer1: TTableDataComparer
    DBCConnectionMaster = DBCConnectionM
    DBCConnectionTarget = DBCConnectionT
    ScriptFileName = 'Result.SQL'
    BlobFileName = 'Result.LOB'
    SQLExec = IBSQLExec1
    OnLogNextLine = AddLogMessage
    OnErrorMessage = AddLogMessage
    Left = 128
    Top = 192
  end
end
