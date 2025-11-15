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
    procedure ListBoxMachinesClick(Sender: TObject);
    procedure ButtonEditClick(Sender: TObject);
  private
    procedure UpdateMachinesButtonsState;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation
  uses DataModule, Machine, MachineEditForm;

{$R *.dfm}

procedure TFormMain.UpdateMachinesButtonsState;
var i: Integer;
begin
  i := ListBoxMachines.ItemIndex;
  ButtonEdit.Enabled := i <> -1;
  ButtonDelete.Enabled := i <> -1;
end;

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
        ListBoxMachines.Items.AddObject(
          NewMachine.Brand + ' ' + NewMachine.Model + ' ' + NewMachine.VIN, NewMachine
        );
        ShowMessage(IntToStr(NewMachine.ID));
      end;
  finally
    FormCreateMachine.Free;
  end;

end;

procedure TFormMain.ButtonEditClick(Sender: TObject);
var
  FormCreateMachine: TFormMachineEdit;
  Machine: TMachine;
begin
  if ListBoxMachines.ItemIndex = -1 then
    Exit;

  Machine := TMachine(ListBoxMachines.Items.Objects[ListBoxMachines.ItemIndex]);
  FormCreateMachine := TFormMachineEdit.Create(Self, Machine);

  try
    if FormCreateMachine.ShowModal = mrOk then
      begin
        DM.UpdateMachine(Machine);
        ListBoxMachines.Items[ListBoxMachines.ItemIndex] :=
          Machine.Brand + ' ' + Machine.Model + ' ' + Machine.VIN;
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
      ListBoxMachines.Items.AddObject(
        Machine.Brand + ' ' + Machine.Model + ' ' + Machine.VIN,
        Machine
      );
  finally
    Machines.Free;
  end;
  UpdateMachinesButtonsState;
end;

procedure TFormMain.ListBoxMachinesClick(Sender: TObject);
begin
  UpdateMachinesButtonsState;
end;

end.
