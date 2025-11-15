unit MachineEditForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Machine, MachineFactory;

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
  private
    FMachine: TMachine;
  public
    constructor Create(AOwner: TComponent; AMachine: TMachine); reintroduce;
    property Machine: TMachine read FMachine;
  end;

implementation

{$R *.dfm}

constructor TFormMachineEdit.Create(AOwner: TComponent; AMachine: TMachine);
begin
  inherited Create(AOwner);
  FMachine := AMachine;
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

  FMachine := TMachineFactory.Make(ComboboxMachineKind.Text, EditBrand.Text,
                                    EditModel.Text, EditVIN.Text);

  ModalResult := mrOk;
//  ShowMessage(FMachine.Brand);

end;

end.
