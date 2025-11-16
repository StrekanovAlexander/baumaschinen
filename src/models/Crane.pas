unit Crane;

interface

uses Machine, MachineKind, Liftable;

type TCrane = class(TMachine, ILiftable)
  public
    constructor Create(const ABrand: string; const AModel: string; const AVIN: string); overload;
    constructor Create(AID: Integer; const ABrand: string; const AModel: string; const AVIN: string); overload;
    function Lift: string;
end;

implementation

constructor TCrane.Create(const ABrand: string; const AModel: string; const AVIN: string);
begin
  inherited Create(ABrand, AModel, AVIN, mkCrane);
end;

constructor TCrane.Create(AID: Integer; const ABrand: string; const AModel: string; const AVIN: string);
begin
  inherited Create(AID, ABrand, AModel, AVIN, mkCrane);
end;

function TCrane.Lift: string;
begin
  Result := 'Das Fahrzeug kann schwere Lasten heben';
end;

end.
