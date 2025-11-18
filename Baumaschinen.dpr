program Baumaschinen;

uses
  Vcl.Forms,
  MainForm in 'src\ui\MainForm.pas' {FormMain},
  Machine in 'src\models\Machine.pas',
  Movable in 'src\interfaces\Movable.pas',
  Liftable in 'src\interfaces\Liftable.pas',
  Flyable in 'src\interfaces\Flyable.pas',
  Diggable in 'src\interfaces\Diggable.pas',
  Truck in 'src\models\Truck.pas',
  MachineBase in 'src\interfaces\MachineBase.pas',
  MachineKind in 'src\models\MachineKind.pas',
  DataModule in 'src\data\DataModule.pas' {DM: TDataModule},
  MachineEditForm in 'src\ui\MachineEditForm.pas' {FormMachineEdit},
  Crane in 'src\models\Crane.pas',
  Excavator in 'src\models\Excavator.pas',
  Helicopter in 'src\models\Helicopter.pas',
  MachineFactory in 'src\factories\MachineFactory.pas',
  Weather in 'src\models\Weather.pas',
  City in 'src\models\City.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
