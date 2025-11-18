unit DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, Vcl.Forms, System.IOUtils, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  System.Generics.Collections, Machine, MachineBase, MachineKind, Truck, Crane,
  Excavator, Helicopter, City;

type
  TDM = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQueryExec: TFDQuery;
    FDQuerySelect: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    function GetCitiesCount: Integer;
  private
    procedure InitializeDatabase;
  public
    procedure InsertMachine(AMachine: TMachine);
    procedure UpdateMachine(AMachine: TMachine);
    procedure DeleteMachine(AID: Integer);
    function GetMachines: TList<TMachine>;
    function GetCities: TList<TCity>;
  end;

const SQLInitMachines =
  'CREATE TABLE IF NOT EXISTS machines (' +
  'id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
  'brand TEXT NOT NULL, ' +
  'model TEXT NOT NULL, ' +
  'vin TEXT NOT NULL, ' +
  'machine_kind INTEGER NOT NULL);';

const SQLInitCities =
  'CREATE TABLE IF NOT EXISTS cities (' +
  'id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
  'city TEXT NOT NULL, ' +
  'latitude REAL NOT NULL, ' +
  'longitude REAL NOT NULL);';

const SQLInsertCities =
  'INSERT INTO cities (city, latitude, longitude) VALUES ' +
  '("Stuttgart", 48.7758, 9.1829),' +
  '("München", 48.1351, 11.5820),' +
  '("Berlin", 52.5200, 13.4050),' +
  '("Potsdam", 52.3906, 13.0645),' +
  '("Bremen", 53.0793, 8.8017),' +
  '("Hamburg", 53.5511, 9.9937),' +
  '("Wiesbaden", 50.0826, 8.2400),' +
  '("Schwerin", 53.6294, 11.4132),' +
  '("Hannover", 52.3759, 9.7320),' +
  '("Düsseldorf", 51.2277, 6.7735),' +
  '("Mainz", 49.9929, 8.2473),' +
  '("Saarbrücken", 49.2402, 6.9969),' +
  '("Dresden", 51.0504, 13.7373),' +
  '("Magdeburg", 52.1205, 11.6276),' +
  '("Kiel", 54.3233, 10.1228),' +
  '("Erfurt", 50.9848, 11.0299);';

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TDM.GetCitiesCount: Integer;
begin
  Result := FDConnection1.ExecSQLScalar('SELECT COUNT(*) FROM cities');
end;

procedure TDM.InitializeDatabase;
const SQLInitTables = SQLInitMachines + SQLInitCities;
begin
  FDConnection1.Open;
  try
    FDConnection1.ExecSQL(SQLInitTables);
    if GetCitiesCount = 0 then
      FDConnection1.ExecSQL(SQLInsertCities);
  finally
    FDConnection1.Close;
  end;
end;

procedure TDM.InsertMachine(AMachine: TMachine);
begin
  with FDQueryExec do
  begin
    FDQueryExec.Close;
    FDQueryExec.SQL.Text :=
      'INSERT INTO machines (brand, model, vin, machine_kind) ' +
      'VALUES (:brand, :model, :vin, :machine_kind) ' +
      'RETURNING id';

    FDQueryExec.ParamByName('brand').AsString := AMachine.Brand;
    FDQueryExec.ParamByName('model').AsString := AMachine.Model;
    FDQueryExec.ParamByName('vin').AsString := AMachine.VIN;
    FDQueryExec.ParamByName('machine_kind').AsInteger := Ord(AMachine.MachineKind);
    FDQueryExec.Open;

    AMachine.ID := FDQueryExec.FieldByName('id').AsInteger;
  end;
end;

procedure TDM.UpdateMachine(AMachine: TMachine);
begin
  with FDQueryExec do
    begin
      Close;
      SQL.Text :=
        'UPDATE machines SET ' +
        'brand = :brand, ' +
        'model = :model, ' +
        'vin = :vin, ' +
        'machine_kind = :machine_kind ' +
        'WHERE id = :id';

        ParamByName('id').AsInteger := AMachine.ID;
        ParamByName('brand').AsString := AMachine.Brand;
        ParamByName('model').AsString := AMachine.Model;
        ParamByName('vin').AsString := AMachine.VIN;
        ParamByName('machine_kind').AsInteger := Ord(AMachine.MachineKind);
        ExecSQL;
    end;
end;

function TDM.GetCities: TList<TCity>;
var Cities: TList<TCity>;
begin
  Cities := TList<TCity>.Create;
  FDQuerySelect.Close;
  FDQuerySelect.SQL.Text := 'SELECT id, city, latitude, longitude FROM cities ORDER BY city';
  FDQuerySelect.Open;
  while not FDQuerySelect.Eof do
    begin
      Cities.Add(TCity.Create(
        FDQuerySelect.FieldByName('id').AsInteger,
        FDQuerySelect.FieldByName('city').AsString,
        FDQuerySelect.FieldByName('latitude').AsFloat,
        FDQuerySelect.FieldByName('longitude').AsFloat
      ));
      FDQuerySelect.Next;
    end;
  Result := Cities;
end;

function TDM.GetMachines: TList<TMachine>;
var
  MachineKind: TMachineKind;
  Machines: TList<TMachine>;
begin
  Machines := TList<TMachine>.Create;
  FDQuerySelect.Close;
  FDQuerySelect.SQL.Text := 'SELECT id, brand, model, vin, machine_kind FROM machines';
  FDQuerySelect.Open;

  while not FDQuerySelect.Eof do
    begin
      MachineKind := TMachineKind(FDQuerySelect.FieldByName('machine_kind').AsInteger);

      case MachineKind of
        mkTruck:
          Machines.Add(TTruck.Create(
            FDQuerySelect.FieldByName('id').AsInteger,
            FDQuerySelect.FieldByName('brand').AsString,
            FDQuerySelect.FieldByName('model').AsString,
            FDQuerySelect.FieldByName('vin').AsString
          ));

        mkCrane:
          Machines.Add(TCrane.Create(
            FDQuerySelect.FieldByName('id').AsInteger,
            FDQuerySelect.FieldByName('brand').AsString,
            FDQuerySelect.FieldByName('model').AsString,
            FDQuerySelect.FieldByName('vin').AsString
          ));

        mkExcavator:
          Machines.Add(TExcavator.Create(
            FDQuerySelect.FieldByName('id').AsInteger,
            FDQuerySelect.FieldByName('brand').AsString,
            FDQuerySelect.FieldByName('model').AsString,
            FDQuerySelect.FieldByName('vin').AsString
          ));

        mkHelicopter:
          Machines.Add(THelicopter.Create(
            FDQuerySelect.FieldByName('id').AsInteger,
            FDQuerySelect.FieldByName('brand').AsString,
            FDQuerySelect.FieldByName('model').AsString,
            FDQuerySelect.FieldByName('vin').AsString
          ));
      end;

      FDQuerySelect.Next;
    end;

  Result := Machines;
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

procedure TDM.DeleteMachine(AID: Integer);
begin
  with FDQueryExec do
    begin
      Close;
      SQL.Text := 'DELETE FROM machines WHERE id = :id';
      ParamByName('id').AsInteger := AID;
      ExecSQL;
    end;
end;

end.
