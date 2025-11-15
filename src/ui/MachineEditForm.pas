unit MachineEditForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Machine, MachineKind, MachineFactory;

type
  TFormMachineEdit = class(TForm)
    LabelBrand: TLabel;
    EditBrand: TEdit;
    LabelModel: TLabel;
    EditModel: TEdit;
    LabelVIN: TLabel;
    EditVIN: TEdit;
    LabelMachineKind: TLabel;
    ComboBoxMachineKind: TComboBox;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FMachine: TMachine;
  public
    constructor Create(AOwner: TComponent; AMachine: TMachine); reintroduce;
    property Machine: TMachine read FMachine write FMachine;
  end;

implementation

{$R *.dfm}

constructor TFormMachineEdit.Create(AOwner: TComponent; AMachine: TMachine);
begin
  inherited Create(AOwner);
  FMachine := AMachine;
end;

procedure TFormMachineEdit.FormCreate(Sender: TObject);
begin
  if Assigned(FMachine) then
    begin
      EditBrand.Text := FMachine.Brand;
      EditModel.Text := FMachine.Model;
      EditVIN.Text := FMachine.VIN;
      ComboBoxMachineKind.ItemIndex := Ord(FMachine.MachineKind) + 1;
    end
end;

procedure TFormMachineEdit.ButtonCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFormMachineEdit.ButtonOkClick(Sender: TObject);
begin

  if (EditBrand.Text = '') or (EditModel.Text = '') or
     (EditVIN.Text = '') or (ComboboxMachineKind.ItemIndex < 1) then
     Exit;

  if FMachine = nil then
    FMachine := TMachineFactory.Make(
      ComboboxMachineKind.Text, EditBrand.Text, EditModel.Text, EditVIN.Text)
  else
    begin
      FMachine.Brand := EditBrand.Text;
      FMachine.Model := EditModel.Text;
      FMachine.VIN := EditVIN.Text;
      FMachine.MachineKind := TMachineKind(ComboBoxMachineKind.ItemIndex - 1);
    end;

  ModalResult := mrOk;
end;

end.
