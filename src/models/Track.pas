unit Track;

interface

uses Machine, MachineKind, Movable;

type TTrack = class(TMachine, IMovable)
  public
    constructor Create(const ABrand: string; const AModel: string; const AVIN: string);
    function Move: string;

end;

implementation

constructor TTrack.Create(const ABrand: string; const AModel: string; const AVIN: string);
begin
  inherited Create(ABrand, AModel, AVIN, mkTrack);
end;

function TTrack.Move: string;
begin
  Result := 'Track: ' + Brand + ' ' + Model + ' is moving';
end;

end.
