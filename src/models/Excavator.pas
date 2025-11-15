unit Excavator;

interface

uses Machine, MachineKind, Diggable, Movable;

type TExcavator = class(TMachine, IDiggable, IMovable)
  public
    constructor Create(const ABrand: string; const AModel: string; const AVIN: string);
    function Dig: string;
    function Move: string;
end;

implementation

constructor TExcavator.Create(const ABrand: string; const AModel: string; const AVIN: string);
begin
  inherited Create(ABrand, AModel, AVIN, mkExcavator);
end;

function TExcavator.Dig: string;
begin
  Result := 'Excavator: ' + Brand + ' ' + Model + ' is digging...';
end;

function TExcavator.Move: string;
begin
  Result := 'Excavator: ' + Brand + ' ' + Model + ' is moving...';
end;

end.
