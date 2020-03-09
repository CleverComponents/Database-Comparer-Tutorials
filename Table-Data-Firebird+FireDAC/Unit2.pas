unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, Data.DB, FireDAC.Comp.Client, dbcClasses,
  dbcIBDatabaseExtract, dbcDBStructure, dbcTypes,
  dbcConnection_FireDAC, dbcDBEngine, dbcDBOptions, FireDAC.DApt, dbcSQL_Exec,
  dbcIBSQLExec, dbcDBComparer, dbcTableDataComparer;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtMasterDbName: TEdit;
    edtMasterUser: TEdit;
    edtMasterPassword: TEdit;
    edtTargetDbName: TEdit;
    edtTargetUser: TEdit;
    edtTargetPassword: TEdit;
    edtClientLibrary: TEdit;
    cbSqlServerVersion: TComboBox;
    btnCompare: TButton;
    btnUpdate: TButton;
    memLog: TMemo;
    memResult: TMemo;
    FDConnection1: TFDConnection;
    FDConnection2: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    DBCConnectionM: TDBCConnectionFireDAC;
    DBCConnectionT: TDBCConnectionFireDAC;
    IBSQLExec1: TIBSQLExec;
    TableDataComparer1: TTableDataComparer;
    Label11: TLabel;
    Label12: TLabel;
    edtTableNameM: TEdit;
    edtTableNameT: TEdit;
    procedure DBCConnectionMBeforeConnect(Sender: TObject);
    procedure DBCConnectionTBeforeConnect(Sender: TObject);
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
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.AddLogMessage(Sender: TObject; ErrText: string);
begin
  memLog.Lines.Add(ErrText);
  memLog.Perform(EM_SCROLLCARET, 0, 0);
end;

procedure TForm2.btnCompareClick(Sender: TObject);
begin
  memResult.Lines.Clear;

  TableDataComparer1.TableNameMaster := edtTableNameM.Text;
  TableDataComparer1.TableNameTarget := edtTableNameT.Text;

  DBCConnectionM.Connected := True;
  DBCConnectionT.Connected := True;
  try
    if TableDataComparer1.CompareData() then
    begin
      memResult.Lines.BeginUpdate();
      IBSQLExec1.GetScript(memResult.Lines);
      memResult.Lines.EndUpdate();
    end;
  finally
  DBCConnectionT.Connected := False;
  DBCConnectionM.Connected := False;
  end;

  memLog.Lines.Add('<Compare Finished>');
end;

procedure TForm2.btnUpdateClick(Sender: TObject);
begin
  TableDataComparer1.SQLExec.ExecuteScript();
end;

procedure TForm2.DBCConnectionMBeforeConnect(Sender: TObject);
begin
  FDPhysFBDriverLink1.VendorLib := edtClientLibrary.Text;

  FDConnection1.Params.Clear();
  FDConnection1.DriverName := 'FB';
  FDConnection1.Params.Add('Database=' + edtMasterDbName.Text);
  FDConnection1.Params.Add('TableNameM=' + edtTableNameM.Text);
  FDConnection1.Params.Add('User_Name=' + edtMasterUser.Text);
  FDConnection1.Params.Add('Password=' + edtMasterPassword.Text);

  IBSQLExec1.IBServerOptions.SQLServerVersion :=
    TIBSQLServerVersionType(cbSqlServerVersion.Items.Objects[cbSqlServerVersion.ItemIndex]);
end;

procedure TForm2.DBCConnectionTBeforeConnect(Sender: TObject);
begin
  FDPhysFBDriverLink1.VendorLib := edtClientLibrary.Text;

  FDConnection2.Params.Clear();
  FDConnection2.DriverName := 'FB';
  FDConnection2.Params.Add('Database=' + edtTargetDbName.Text);
  FDConnection2.Params.Add('TableNameT=' + edtTableNameT.Text);
  FDConnection2.Params.Add('User_Name=' + edtTargetUser.Text);
  FDConnection2.Params.Add('Password=' + edtTargetPassword.Text);

  IBSQLExec1.IBServerOptions.SQLServerVersion :=
    TIBSQLServerVersionType(cbSqlServerVersion.Items.Objects[cbSqlServerVersion.ItemIndex]);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  cbSqlServerVersion.Items.Clear();

  cbSqlServerVersion.Items.AddObject('Firebird 1.5', TObject(st_FireBird_15));
  cbSqlServerVersion.Items.AddObject('Firebird 2.0', TObject(st_FireBird_20));
  cbSqlServerVersion.Items.AddObject('Firebird 2.1', TObject(st_FireBird_21));
  cbSqlServerVersion.Items.AddObject('Firebird 2.5', TObject(st_FireBird_25));
  cbSqlServerVersion.Items.AddObject('Firebird 3.0', TObject(st_FireBird_30));

  cbSqlServerVersion.ItemIndex := cbSqlServerVersion.Items.Count - 1;
end;

end.
