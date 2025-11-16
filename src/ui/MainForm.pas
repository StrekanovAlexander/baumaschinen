unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.Generics.Collections,
  System.UITypes, System.Net.HttpClientComponent, System.JSON,
  DataModule, Machine, MachineKind, Truck, Excavator, Crane, Helicopter,
  Movable, Liftable, Diggable, Flyable, MachineFactory, Weather;

type
  TFormMain = class(TForm)
    PanelLeft: TPanel;
    PanelDetails: TPanel;
    PanelMachines: TPanel;
    ListBoxMachines: TListBox;
    PanelMachinesButtons: TPanel;
    ButtonAdd: TButton;
    ButtonEdit: TButton;
    ButtonDelete: TButton;
    PanelWeather: TPanel;
    SplitterPanels: TSplitter;
    PanelWeatherButtons: TPanel;
    ButtonRefresh: TButton;
    MemoWeather: TMemo;
    procedure ButtonAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBoxMachinesClick(Sender: TObject);
    procedure ButtonEditClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonRefreshClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Weather: TWeather;
    procedure UpdateMachinesButtonsState;
    procedure ShowMachineDetails(AMachine: TMachine);
  public
    { Public declarations }
  end;

const
  URL = 'https://api.open-meteo.com/v1/forecast?latitude=52.5200&longitude=13.4050&current_weather=true';

var
  FormMain: TFormMain;

implementation
  uses MachineEditForm;


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
        ListBoxMachines.Items.AddObject(NewMachine.KindText + ' ' + NewMachine.Brand + ' ' + NewMachine.Model, NewMachine);
      end;
  finally
    FormCreateMachine.Free;
  end;

end;

procedure TFormMain.ButtonDeleteClick(Sender: TObject);
var Machine: TMachine;
begin
  if ListBoxMachines.ItemIndex = -1 then
    Exit;

  Machine := TMachine(ListBoxMachines.Items.Objects[ListBoxMachines.ItemIndex]);

  if MessageDlg('Möchten Sie die Maschine "' + Machine.Brand + ' ' + Machine.Model + '" löschen?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  DM.DeleteMachine(Machine.ID);
  Machine.Free;

  ListBoxMachines.Items.Delete(ListBoxMachines.ItemIndex);

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
        Machine.KindText + ' ' + Machine.Brand + ' ' + Machine.Model;
      end;
  finally
    FormCreateMachine.Free;
  end;

end;

procedure TFormMain.ButtonRefreshClick(Sender: TObject);
begin
  MemoWeather.Lines.Clear;
  if Assigned(Weather) then
    Weather.Free;
  Weather := TWeather.Create(URL);
  MemoWeather.Lines.Add(Weather.ToBreakString);
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
        Machine.KindText + ': ' + Machine.Brand + ' ' + Machine.Model, Machine);
  finally
    Machines.Free;
  end;
  UpdateMachinesButtonsState;

  Weather := TWeather.Create(URL);
  MemoWeather.Lines.Add(Weather.ToBreakString);

end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  Weather.Free;
end;

procedure TFormMain.ListBoxMachinesClick(Sender: TObject);
var Machine: TMachine;
begin
  UpdateMachinesButtonsState;

  if ListBoxMachines.ItemIndex = -1 then Exit;

  Machine := TMachine(ListBoxMachines.Items.Objects[ListBoxMachines.ItemIndex]);

  if Assigned(Machine) then
    ShowMachineDetails(Machine);
end;

procedure TFormMain.ShowMachineDetails(AMachine: TMachine);
var Memo: TMemo;
    Machine: TMachine;
    Movable: IMovable;
    Diggable: IDiggable;
    Liftable: ILiftable;
    Flyable: IFlyable;
begin
  PanelDetails.DestroyComponents;
  Machine := TMachineFactory.CreateCopy(AMachine);

  Memo := TMemo.Create(PanelDetails);
  Memo.Parent := PanelDetails;
  Memo.Align := alTop;

  Memo.ReadOnly := True;
  Memo.Font.Name := 'Consolas';
  Memo.Height := 125;

  Memo.Lines.Add(Machine.KindText);
  Memo.Lines.Add('Brand:' + #9 + Machine.Brand);
  Memo.Lines.Add('Model:' + #9 + Machine.Model);
  Memo.Lines.Add('VIN:' + #9 + Machine.VIN);

  if Supports(Machine, IMovable, Movable) then
    Memo.Lines.Add(Movable.Move);

  if Supports(Machine, IDiggable, Diggable) then
    Memo.Lines.Add(Diggable.Dig);

  if Supports(Machine, ILiftable, Liftable) then
    Memo.Lines.Add(Liftable.Lift);

  if Supports(Machine, IFlyable, Flyable) then
    Memo.Lines.Add(Flyable.Fly);

end;

end.
