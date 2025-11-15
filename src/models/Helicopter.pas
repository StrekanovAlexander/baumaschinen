unit Helicopter;

interface

uses Machine, MachineKind, Flyable;

type THelicopter = class(TMachine, IFlyable)
  public
    constructor Create(const ABrand: string; const AModel: string; const AVIN: string);
    function Fly: string;
end;

implementation

constructor THelicopter.Create(const ABrand: string; const AModel: string; const AVIN: string);
begin
  inherited Create(ABrand, AModel, AVIN, mkHelicopter);
end;

function THelicopter.Fly: string;
begin
  Result := 'Helicopter: ' + Brand + ' ' + Model + ' flying...';
end;

end.
