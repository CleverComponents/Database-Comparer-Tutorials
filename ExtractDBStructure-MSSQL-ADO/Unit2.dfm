object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'MS SQL Extractor'
  ClientHeight = 419
  ClientWidth = 627
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
    Left = 400
    Top = 38
    Width = 92
    Height = 13
    Caption = 'SQL Server Version'
  end
  object Label2: TLabel
    Left = 8
    Top = 36
    Width = 32
    Height = 13
    Caption = 'Server'
  end
  object edtDatabaseName: TEdit
    Left = 89
    Top = 8
    Width = 530
    Height = 21
    TabOrder = 0
  end
  object edtPassword: TEdit
    Left = 89
    Top = 89
    Width = 152
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object edtUser: TEdit
    Left = 89
    Top = 62
    Width = 152
    Height = 21
    TabOrder = 2
  end
  object btnExtract: TBitBtn
    Left = 458
    Top = 62
    Width = 161
    Height = 51
    Caption = 'Extract database'
    TabOrder = 3
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
    TabOrder = 4
  end
  object memResult: TMemo
    Left = 8
    Top = 225
    Width = 609
    Height = 186
    Lines.Strings = (
      '<Result SQL>')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 5
  end
  object cbSqlServerVersion: TComboBox
    Left = 498
    Top = 35
    Width = 121
    Height = 21
    Style = csDropDownList
    TabOrder = 6
  end
  object cbAuthM: TCheckBox
    Left = 253
    Top = 37
    Width = 141
    Height = 17
    Caption = 'Windows authentication'
    TabOrder = 7
  end
  object edtServer: TEdit
    Left = 89
    Top = 35
    Width = 152
    Height = 21
    TabOrder = 8
  end
  object MSSQLDBExtract1: TMSSQLDBExtract
    DBCConnection = DBCConnectionADO1
    DBStructure = DBStructure1
    OnLogNextLine = DBCConnectionADO1ErrorMessage
    Left = 136
    Top = 272
  end
  object DBCConnectionADO1: TDBCConnectionADO
    Connection = ADOConnection1
    OnBeforeConnect = DBCConnectionADO1BeforeConnect
    OnErrorMessage = DBCConnectionADO1ErrorMessage
    OnLogNextLine = DBCConnectionADO1ErrorMessage
    Left = 232
    Top = 272
  end
  object ADOConnection1: TADOConnection
    Provider = 'SQLOLEDB'
    Left = 48
    Top = 272
  end
  object DBStructure1: TDBStructure
    Left = 320
    Top = 272
  end
end
