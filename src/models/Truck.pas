unit Truck;

interface

uses Machine, MachineKind, Movable;

type TTruck = class(TMachine, IMovable)
  public
    constructor Create(const ABrand: string; const AModel: string; const AVIN: string); overload;
    constructor Create(AID: Integer; const ABrand: string; const AModel: string; const AVIN: string); overload;

    function Move: string;
end;

implementation

constructor TTruck.Create(const ABrand: string; const AModel: string; const AVIN: string);
begin
  inherited Create(ABrand, AModel, AVIN, mkTruck);
end;

constructor TTruck.Create(AID: Integer; const ABrand: string; const AModel: string; const AVIN: string);
begin
  inherited Create(AID, ABrand, AModel, AVIN, mkTruck);
end;

function TTruck.Move: string;
begin
  Result := 'Das Fahrzeug kann schnell bewegen';
end;

end.
