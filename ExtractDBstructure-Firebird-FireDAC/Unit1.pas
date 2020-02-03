unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, Data.DB, FireDAC.Comp.Client, dbcClasses,
  dbcIBDatabaseExtract, dbcDBStructure, dbcTypes,
  dbcConnection_FireDAC, dbcDBEngine, dbcDBOptions, FireDAC.DApt;

type
  TForm1 = class(TForm)
    edtDatabaseName: TEdit;
    Label3: TLabel;
    LabelUserM: TLabel;
    edtPassword: TEdit;
    LabelPswdM: TLabel;
    edtUser: TEdit;
    btnExtract: TBitBtn;
    memLog: TMemo;
    memResult: TMemo;
    DBStructure1: TDBStructure;
    IBDBExtract1: TIBDBExtract;
    FDConnection1: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    DBCConnection1: TDBCConnectionFireDAC;
    cbSqlServerVersion: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    edtClientLibrary: TEdit;
    procedure btnExtractClick(Sender: TObject);
    procedure AddLogMessage(Sender: TObject; ErrText: string);
    procedure FormCreate(Sender: TObject);
    procedure DBCConnection1BeforeConnect(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnExtractClick(Sender: TObject);
begin
  memLog.Clear();
  memResult.Clear();

  DBCConnection1.Connected := True;
  try
    DBStructure1.Clear();
    IBDBExtract1.ExtractDatabase();
    DBStructure1.Metadata.ExtractMetadata(memResult.Lines);
  finally
    DBCConnection1.Connected := False;
  end;
end;

procedure TForm1.DBCConnection1BeforeConnect(Sender: TObject);
begin
  FDPhysFBDriverLink1.VendorLib := edtClientLibrary.Text;

  FDConnection1.Params.Clear();
  FDConnection1.DriverName := 'FB';
  FDConnection1.Params.Add('Database=' + edtDatabaseName.Text);
  FDConnection1.Params.Add('User_Name=' + edtUser.Text);
  FDConnection1.Params.Add('Password=' + edtPassword.Text);

  DBStructure1.IBServerOptions.SQLServerVersion :=
    TIBSQLServerVersionType(cbSqlServerVersion.Items.Objects[cbSqlServerVersion.ItemIndex]);
end;

procedure TForm1.AddLogMessage(Sender: TObject; ErrText: string);
begin
  memLog.Lines.Add(ErrText);
  memLog.Perform(EM_SCROLLCARET, 0, 0);
end;

procedure TForm1.FormCreate(Sender: TObject);
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
