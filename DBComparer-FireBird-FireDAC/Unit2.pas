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
  dbcIBSQLExec, dbcDBComparer;

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
    edtMasterDbName: TEdit;
    edtMasterUser: TEdit;
    edtMasterPassword: TEdit;
    edtTargetDbName: TEdit;
    edtTargetUser: TEdit;
    edtTargetPassword: TEdit;
    edtClientLibrary: TEdit;
    Label10: TLabel;
    cbSqlServerVersion: TComboBox;
    btnExtract: TButton;
    btnCompare: TButton;
    btnUpdate: TButton;
    memLog: TMemo;
    memResult: TMemo;
    DBCConnection1: TDBCConnectionFireDAC;
    IBDBExtract1: TIBDBExtract;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDConnection1: TFDConnection;
    DBStructure1: TDBStructure;
    FDConnection2: TFDConnection;
    DBStructure2: TDBStructure;
    IBDBExtract2: TIBDBExtract;
    DBCConnection2: TDBCConnectionFireDAC;
    DBComparer1: TDBComparer;
    IBSQLExec: TIBSQLExec;
    procedure btnExtractClick(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure DBCConnection2BeforeConnect(Sender: TObject);
    procedure AddLogMessage(Sender: TObject; ErrText: string);
    procedure FormCreate(Sender: TObject);
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

  DBComparer1.CompareDatabases();
  memResult.Lines.BeginUpdate();
  DBComparer1.SQLExec.GetScript(memResult.Lines);
  memLog.Lines.Add('<Compare Finished>');
  memResult.Lines.EndUpdate();
end;

procedure TForm2.btnExtractClick(Sender: TObject);
begin
  memLog.Clear();
  memResult.Clear();

  DBCConnection1.Connected := True;
  DBCConnection2.Connected := True;
  try
    DBStructure1.Clear();
    DBStructure2.Clear();
    IBDBExtract1.ExtractDatabase();
    IBDBExtract2.ExtractDatabase();
    DBStructure1.Metadata.ExtractMetadata(memResult.Lines);
    DBStructure2.Metadata.ExtractMetadata(memResult.Lines);
  finally
    DBCConnection1.Connected := False;
    DBCConnection2.Connected := False;
  end;
end;

procedure TForm2.btnUpdateClick(Sender: TObject);
begin
  IBSQLExec.ExecuteScript();
end;

procedure TForm2.DBCConnection2BeforeConnect(Sender: TObject);
begin
  FDPhysFBDriverLink1.VendorLib := edtClientLibrary.Text;

  FDConnection1.Params.Clear();
  FDConnection1.DriverName := 'FB';
  FDConnection1.Params.Add('Database=' + edtMasterDbName.Text);
  FDConnection1.Params.Add('User_Name=' + edtMasterUser.Text);
  FDConnection1.Params.Add('Password=' + edtMasterPassword.Text);

  FDConnection2.Params.Clear();
  FDConnection2.DriverName := 'FB';
  FDConnection2.Params.Add('Database=' + edtTargetDbName.Text);
  FDConnection2.Params.Add('User_Name=' + edtTargetUser.Text);
  FDConnection2.Params.Add('Password=' + edtTargetPassword.Text);

  DBStructure1.IBServerOptions.SQLServerVersion :=
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
