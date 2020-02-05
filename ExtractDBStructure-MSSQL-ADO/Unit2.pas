unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dbcDBEngine,
  Data.DB, FireDAC.Comp.Client, dbcClasses,
  dbcDBStructure, Vcl.StdCtrls, Vcl.Buttons,
  dbcConnection_ADO, dbcMSSQLDatabaseExtract, Data.Win.ADODB,
  dbcDBOptions;

type
  TForm2 = class(TForm)
    Label3: TLabel;
    LabelUserM: TLabel;
    LabelPswdM: TLabel;
    Label1: TLabel;
    edtDatabaseName: TEdit;
    edtPassword: TEdit;
    edtUser: TEdit;
    btnExtract: TBitBtn;
    memLog: TMemo;
    memResult: TMemo;
    cbSqlServerVersion: TComboBox;
    cbAuthM: TCheckBox;
    edtServer: TEdit;
    Label2: TLabel;
    MSSQLDBExtract1: TMSSQLDBExtract;
    DBCConnectionADO1: TDBCConnectionADO;
    ADOConnection1: TADOConnection;
    DBStructure1: TDBStructure;
    procedure FormCreate(Sender: TObject);
    procedure DBCConnectionADO1BeforeConnect(Sender: TObject);
    procedure btnExtractClick(Sender: TObject);
    procedure DBCConnectionADO1ErrorMessage(Sender: TObject; ErrText: string);
  private
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

function AdoConnectString(WinAuth: Boolean;
                          HostName, DbName, UserName, Password: String): String;
begin
    Result := 'Provider=SQLOLEDB;' +
                        'Initial Catalog='+DbName+';';
    if HostName <> '' then Result := Result +
                        'Data Source='+HostName+';';
    if WinAuth then
    begin
      Result := Result + 'Integrated Security=SSPI;' +
                         'Persist Security Info=False;';
    end else
    begin
      Result := Result + 'Persist Security Info=True;';
      if UserName <> '' then
        Result := Result + 'User ID=' + UserName + ';';
      if Password <> '' then
        Result := Result + 'Password=' + Password + ';';
    end;
end;

procedure TForm2.btnExtractClick(Sender: TObject);
begin
  memLog.Clear();
  memResult.Clear();

  DBCConnectionADO1.Connected := True;
  try
    DBStructure1.Clear();
    MSSQLDBExtract1.ExtractDatabase();
    DBStructure1.Metadata.ExtractMetadata(memResult.Lines);
  finally
    DBCConnectionADO1.Connected := False;
  end;

end;

procedure TForm2.DBCConnectionADO1BeforeConnect(Sender: TObject);
begin
  ADOConnection1.ConnectionString :=
    AdoConnectString(cbAuthM.Checked, edtServer.Text, edtDatabaseName.Text,
    edtUser.Text, edtPassword.Text);

  DBStructure1.Objs.MSSQLServerOptions.SQLServerVersion :=
    TMSSQLServerVersionType(cbSqlServerVersion.Items.Objects[cbSqlServerVersion.ItemIndex]);
end;

procedure TForm2.DBCConnectionADO1ErrorMessage(Sender: TObject;
  ErrText: string);
begin
  memLog.Lines.Add(ErrText);
  memLog.Perform(EM_SCROLLCARET, 0, 0);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  cbSqlServerVersion.Items.Clear();

  cbSqlServerVersion.Items.AddObject('MSSQL 2000', TObject(st_MSSQL2000));
  cbSqlServerVersion.Items.AddObject('MSSQL 2005', TObject(st_MSSQL2005));
  cbSqlServerVersion.Items.AddObject('MSSQL 2008', TObject(st_MSSQL2008));
  cbSqlServerVersion.Items.AddObject('MSSQL 2012', TObject(st_MSSQL2012));
  cbSqlServerVersion.Items.AddObject('MSSQL 2014', TObject(st_MSSQL2014));
  cbSqlServerVersion.Items.AddObject('MSSQL 2016', TObject(st_MSSQL2016));
  cbSqlServerVersion.Items.AddObject('MSSQL 2017', TObject(st_MSSQL2017));

  cbSqlServerVersion.ItemIndex := cbSqlServerVersion.Items.Count - 2;
end;

end.
