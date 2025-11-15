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
  System.Generics.Collections, Machine, MachineKind, Truck, Crane, Excavator, Helicopter;

type
  TDM = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQueryExec: TFDQuery;
    FDQuerySelect: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure InitializeDatabase;
  public
    procedure InsertMachine(AMachine: TMachine);
    procedure UpdateMachine(AMachine: TMachine);
    function GetMachines: TList<TMachine>;
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

end.
