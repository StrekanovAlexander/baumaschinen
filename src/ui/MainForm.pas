unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.Generics.Collections;

type
  TFormMain = class(TForm)
    PanelLeft: TPanel;
    ListBoxMachines: TListBox;
    ButtonAdd: TButton;
    ButtonEdit: TButton;
    ButtonDelete: TButton;
    procedure ButtonAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation
  uses DataModule, Machine, MachineEditForm;

{$R *.dfm}

procedure TFormMain.ButtonAddClick(Sender: TObject);
var
  FormCreateMachine: TFormMachineEdit;
  NewMachine: TMachine;
begin
  FormCreateMachine := TFormMachineEdit.Create(Self, nil);

  try
    if FormCreateMachine.ShowModal = mrOk then
      begin
        NewMachine := FormCreateMachine.Machine;
        DM.InsertMachine(NewMachine);
        ListBoxMachines.Items.Add(NewMachine.Brand + ' ' + NewMachine.Model + ' ' + NewMachine.VIN);
      end;
  finally
    FormCreateMachine.Free;
  end;

end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  Machines: TList<TMachine>;
  Machine: TMachine;
begin
  Machines := DM.GetMachines;
  try
    ListBoxMachines.Items.Clear;
    for Machine in Machines do
      ListBoxMachines.Items.Add(Machine.Brand + ' ' + Machine.Model + ' ' + Machine.VIN);
  finally
    Machines.Free;
  end;

end;

end.
