unit DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, Vcl.Forms, System.IOUtils;

type
  TDM = class(TDataModule)
    FDConnection1: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure InitializeDatabase;
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.InitializeDatabase;
begin
  FDConnection1.Open;
  FDConnection1.ExecSQL(
    'CREATE TABLE IF NOT EXISTS machines (' +
    'id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
    'brand TEXT NOT NULL, ' +
    'model TEXT NOT NULL, ' +
    'vin TEXT NOT NULL, ' +
    'machine_kind INTEGER NOT NULL)'
  );
  FDConnection1.Close;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
var
  DBPath: string;
begin
  DBPath := ExtractFilePath(Application.ExeName) + 'data.db';
  if not FileExists(DBPath) then
    TFile.Create(DBPath).Free;

  with FDConnection1 do
    begin
      DriverName := 'SQLite';
      Params.Values['Database'] := ExtractFilePath(Application.ExeName) + 'data.db';
      Params.Values['LockingMode'] := 'Normal';
      Params.Values['OpenMode'] := 'ReadWrite';
      Params.Values['Synchronous'] := 'Full';
      LoginPrompt := False;
    end;

  InitializeDatabase;
end;

end.
