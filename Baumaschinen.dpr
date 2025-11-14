program Baumaschinen;

uses
  Vcl.Forms,
  MainForm in 'src\ui\MainForm.pas' {FormMain},
  Machine in 'src\models\Machine.pas',
  Movable in 'src\interfaces\Movable.pas',
  Liftable in 'src\interfaces\Liftable.pas',
  Flyable in 'src\interfaces\Flyable.pas',
  Diggable in 'src\interfaces\Diggable.pas',
  Track in 'src\models\Track.pas',
  MachineBase in 'src\interfaces\MachineBase.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
