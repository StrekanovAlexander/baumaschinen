unit Helicopter;

interface

uses Machine, MachineKind, Flyable;

type THelicopter = class(TMachine, IFlyable)
  public
    constructor Create(const ABrand: string; const AModel: string; const AVIN: string); overload;
    constructor Create(AID: Integer; const ABrand: string; const AModel: string; const AVIN: string); overload;
    function Fly: string;
end;

implementation

constructor THelicopter.Create(const ABrand: string; const AModel: string; const AVIN: string);
begin
  inherited Create(ABrand, AModel, AVIN, mkHelicopter);
end;

constructor THelicopter.Create(AID: Integer; const ABrand: string; const AModel: string; const AVIN: string);
begin
  inherited Create(AID, ABrand, AModel, AVIN, mkHelicopter);
end;

function THelicopter.Fly: string;
begin
  Result := 'Das Fahrzeug kann fliegen.';
end;

end.
