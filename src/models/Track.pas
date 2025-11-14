unit Track;

interface

uses Machine, Movable;

type TTrack = class(TMachine, IMovable)
  public
    function Move: string;

end;

implementation

function TTrack.Move: string;
begin
  Result := 'Track: ' + Brand + ' ' + Model + ' is moving';
end;

end.
