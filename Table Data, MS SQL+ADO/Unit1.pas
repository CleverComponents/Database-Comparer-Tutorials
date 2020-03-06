unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dbcClasses, dbcDBComparer, dbcSQL_Exec,
  dbcMSSQLExec, dbcMSSQLDatabaseExtract, dbcDBEngine, dbcConnection_ADO,
  dbcDBStructure, Data.DB, Data.Win.ADODB, Vcl.StdCtrls, Vcl.Buttons,
  dbcTableDataComparer, dbcDBOptions;

type
  TForm1 = class(TForm)
    Label3: TLabel;
    LabelUserM: TLabel;
    LabelPswdM: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtMasterDatabaseName: TEdit;
    edtMasterPassword: TEdit;
    edtMasterUser: TEdit;
    memLog: TMemo;
    memResult: TMemo;
    cbSqlServerVersion: TComboBox;
    cbAuthM: TCheckBox;
    edtMasterServer: TEdit;
    edtTargetDatabaseName: TEdit;
    edtTargetPassword: TEdit;
    edtTargetUser: TEdit;
    edtTargetServer: TEdit;
    btnCompare: TButton;
    btnUpdate: TButton;
    cbAuthT: TCheckBox;
    ADOConnectionMaster: TADOConnection;
    ADOConnectionTarget: TADOConnection;
    ConnectionMaster: TDBCConnectionADO;
    ConnectionTarget: TDBCConnectionADO;
    MSSQLExec1: TMSSQLExec;
    TableDataComparer1: TTableDataComparer;
    Label10: TLabel;
    Label11: TLabel;
    edtTableNameM: TEdit;
    edtTableNameT: TEdit;
    procedure ConnectionMasterBeforeConnect(Sender: TObject);
    procedure ConnectionTargetBeforeConnect(Sender: TObject);
    procedure AddLogMessage(Sender: TObject; ErrText: string);
    procedure FormCreate(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

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


procedure TForm1.AddLogMessage(Sender: TObject; ErrText: string);
begin
  memLog.Lines.Add(ErrText);
  memLog.Perform(EM_SCROLLCARET, 0, 0);
end;

procedure TForm1.btnCompareClick(Sender: TObject);
begin
  memLog.Clear();
  memResult.Clear();

  MSSQLExec1.MSSQLServerOptions.Assign(TableDataComparer1.MSSQLServerOptions);
  MSSQLExec1.MSSQLServerOptions.Assign(TableDataComparer1.MSSQLServerOptions);

  TableDataComparer1.TableNameMaster := edtTableNameM.Text;
  TableDataComparer1.TableNameTarget := edtTableNameT.Text;

  ConnectionMaster.Connected := True;
  ConnectionTarget.Connected := True;
  try
    if TableDataComparer1.CompareData() then
    begin
    memResult.Lines.BeginUpdate;
    MSSQLExec1.GetScript(memResult.Lines);
    memResult.Lines.EndUpdate;    
    end;
    
  memLog.Lines.Add('<Comparing finished.>');
  
  finally
  ConnectionTarget.Connected := False;
  ConnectionMaster.Connected := False;
  end;
end;

procedure TForm1.btnUpdateClick(Sender: TObject);
begin
  TableDataComparer1.SQLExec.ExecuteScript();
end;

procedure TForm1.ConnectionMasterBeforeConnect(Sender: TObject);
begin
  ADOConnectionMaster.ConnectionString :=
    AdoConnectString(cbAuthM.Checked, edtMasterServer.Text, edtMasterDatabaseName.Text,
    edtMasterUser.Text, edtMasterPassword.Text);

  MSSQLExec1.MSSQLServerOptions.SQLServerVersion :=
    TMSSQLServerVersionType(cbSqlServerVersion.Items.Objects[cbSqlServerVersion.ItemIndex]);
end;

procedure TForm1.ConnectionTargetBeforeConnect(Sender: TObject);
begin
  ADOConnectionTarget.ConnectionString :=
    AdoConnectString(cbAuthT.Checked, edtTargetServer.Text, edtTargetDatabaseName.Text,
    edtTargetUser.Text, edtTargetPassword.Text);

  MSSQLExec1.MSSQLServerOptions.SQLServerVersion :=
    TMSSQLServerVersionType(cbSqlServerVersion.Items.Objects[cbSqlServerVersion.ItemIndex]);
end;

procedure TForm1.FormCreate(Sender: TObject);
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
