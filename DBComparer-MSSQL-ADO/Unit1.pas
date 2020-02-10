unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dbcDBEngine,
  Data.DB, FireDAC.Comp.Client, dbcClasses,
  dbcDBStructure, Vcl.StdCtrls, Vcl.Buttons,
  dbcConnection_ADO, dbcMSSQLDatabaseExtract, Data.Win.ADODB,
  dbcDBOptions, dbcDBComparer, dbcSQL_Exec, dbcMSSQLExec;


type
  TForm2 = class(TForm)
    Label3: TLabel;
    LabelUserM: TLabel;
    LabelPswdM: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtMasterDatabaseName: TEdit;
    edtMasterPassword: TEdit;
    edtMasterUser: TEdit;
    btnExtract: TBitBtn;
    memLog: TMemo;
    memResult: TMemo;
    cbSqlServerVersion: TComboBox;
    cbAuthM: TCheckBox;
    edtMasterServer: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtTargetDatabaseName: TEdit;
    edtTargetPassword: TEdit;
    edtTargetUser: TEdit;
    edtTargetServer: TEdit;
    btnCompare: TButton;
    ADOConnection1: TADOConnection;
    ADOConnection2: TADOConnection;
    DBStructure1: TDBStructure;
    DBStructure2: TDBStructure;
    DBCConnectionADO1: TDBCConnectionADO;
    DBCConnectionADO2: TDBCConnectionADO;
    MSSQLDBExtract1: TMSSQLDBExtract;
    MSSQLDBExtract2: TMSSQLDBExtract;
    MSSQLExec1: TMSSQLExec;
    DBComparer1: TDBComparer;
    procedure DBCConnectionADO1BeforeConnect(Sender: TObject);
    procedure AddErrorMessage(Sender: TObject; ErrText: string);
    procedure FormCreate(Sender: TObject);
    procedure btnExtractClick(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ExtractMasterDatabase();
    procedure ExtractTargetDatabase();
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

procedure TForm2.AddErrorMessage(Sender: TObject; ErrText: string);
begin
  memLog.Lines.Add(ErrText);
  memLog.Perform(EM_SCROLLCARET, 0, 0);
end;

procedure TForm2.ExtractMasterDatabase;
begin
  DBCConnectionADO1.Connected := True;
  try
    DBStructure1.Clear();
    memLog.Lines.Add('Open ' + edtMasterDatabaseName.Text + ' DataBase');
    MSSQLDBExtract1.ExtractDatabase();
    DBStructure1.Metadata.ExtractMetadata(memResult.Lines);
  finally
    DBCConnectionADO1.Connected := False;
  end;
end;

procedure TForm2.ExtractTargetDatabase;
begin
  DBCConnectionADO2.Connected := True;
  try
    DBStructure2.Clear();
    memLog.Lines.Add('Open ' + edtTargetDatabaseName.Text + ' DataBase');
    MSSQLDBExtract2.ExtractDatabase();
    DBStructure2.Metadata.ExtractMetadata(memResult.Lines);
  finally
    DBCConnectionADO2.Connected := False;
  end;
end;

procedure TForm2.btnCompareClick(Sender: TObject);
begin
  memResult.Clear();

  DBComparer1.CompareDatabases;
  memResult.Lines.BeginUpdate;
  DBComparer1.SQLExec.GetScript(memResult.Lines);
  memResult.Lines.EndUpdate;

  memLog.Lines.Add('<Comparing finished.>');
end;

procedure TForm2.btnExtractClick(Sender: TObject);
begin
  memLog.Clear();
  memResult.Clear();

  DBStructure1.Objs.MSSQLServerOptions.Assign(DBComparer1.MSSQLServerOptions);
  DBStructure2.Objs.MSSQLServerOptions.Assign(DBComparer1.MSSQLServerOptions);

  ExtractMasterDatabase();
  ExtractTargetDatabase();
  memLog.Lines.Add('<Extract Finished.>')
end;

procedure TForm2.DBCConnectionADO1BeforeConnect(Sender: TObject);
begin
  ADOConnection1.ConnectionString :=
    AdoConnectString(cbAuthM.Checked, edtMasterServer.Text, edtMasterDatabaseName.Text,
    edtMasterUser.Text, edtMasterPassword.Text);

  ADOConnection2.ConnectionString :=
    AdoConnectString(cbAuthM.Checked, edtTargetServer.Text, edtTargetDatabaseName.Text,
    edtTargetUser.Text, edtTargetPassword.Text);

  DBStructure1.Objs.MSSQLServerOptions.SQLServerVersion :=
    TMSSQLServerVersionType(cbSqlServerVersion.Items.Objects[cbSqlServerVersion.ItemIndex]);
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
