unit Crane;

interface

uses Machine, MachineKind, Liftable;

type TCrane = class(TMachine, ILiftable)
  public
    constructor Create(const ABrand: string; const AModel: string; const AVIN: string);
    function Lift: string;
end;

implementation

constructor TCrane.Create(const ABrand: string; const AModel: string; const AVIN: string);
begin
  inherited Create(ABrand, AModel, AVIN, mkCrane);
end;

function TCrane.Lift: string;
begin
  Result := 'Crane: ' + Brand + ' ' + Model + ' lifing...';
end;

end.
