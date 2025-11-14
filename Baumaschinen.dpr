program Baumaschinen;

uses
  Vcl.Forms,
  MainForm in 'src\ui\MainForm.pas' {FormMain},
  Machine in 'src\models\Machine.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
