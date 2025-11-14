unit Machine;

interface

uses System.SysUtils, MachineBase, MachineKind;

type TMachine = class abstract (TInterfacedObject, IMachine)
  private
    FBrand: string;
    FModel: string;
    FVIN: string;
    FMachineKind: TMachineKind;
    procedure SetBrand(const ABrand: string);
    procedure SetModel(const AModel: string);
    procedure SetVIN(const AVIN: string);
    function Correct(const AValue: string): string;
  public
    constructor Create(const ABrand: string; const AModel: string; const AVIN: string; AMachineKind: TMachineKind);
    property Brand: string read FBrand write SetBrand;
    property Model: string read FModel write SetModel;
    property VIN: string read FVIN write SetVIN;
    property MachineKind: TMachineKind read FMachineKind;

end;

implementation

constructor TMachine.Create(const ABrand: string; const AModel: string; const AVIN: string; AMachineKind: TMachineKind);
begin
  FBrand := Correct(ABrand);
  FModel := Correct(AModel);
  FVIN := Correct(AVIN);
  FMachineKind := AMachineKind;
end;

function TMachine.Correct(const AValue: string): string;
var s: string;
begin
  s := Trim(AValue);
  if s = '' then
    Result := 'unbekannt'
  else
    Result := s;
end;

procedure TMachine.SetBrand(const ABrand: string);
begin
  FBrand := Correct(ABrand);
end;

procedure TMachine.SetModel(const AModel: string);
begin
  FModel := Correct(AModel);
end;

procedure TMachine.SetVIN(const AVIN: string);
begin
  FVIN := Correct(AVIN);
end;

end.
