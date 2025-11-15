unit Truck;

interface

uses Machine, MachineKind, Movable;

type TTruck = class(TMachine, IMovable)
  public
    constructor Create(const ABrand: string; const AModel: string; const AVIN: string);
    function Move: string;
end;

implementation

constructor TTruck.Create(const ABrand: string; const AModel: string; const AVIN: string);
begin
  inherited Create(ABrand, AModel, AVIN, mkTruck);
end;

function TTruck.Move: string;
begin
  Result := 'Track: ' + Brand + ' ' + Model + ' is moving';
end;

end.
