unit MachineFactory;

interface

uses System.SysUtils, Machine, MachineKind, Truck, Crane, Excavator, Helicopter;

type TMachineFactory = class
  class function Make(const AMachine: string; const ABrand: string;
                      const AModel: string; const AVIN: string): TMachine;
end;

implementation

class function TMachineFactory.Make(const AMachine: string; const ABrand: string;
                                    const AModel: string; const AVIN: string): TMachine;
begin
  if SameText(AMachine, 'LKW') then
    Result := TTruck.Create(ABrand, AModel, AVIN)
  else if SameText(AMachine, 'Kran') then
    Result := TCrane.Create(ABrand, AModel, AVIN)
  else if SameText(AMachine, 'Bagger') then
    Result := TExcavator.Create(ABrand, AModel, AVIN)
  else if SameText(AMachine, 'Hubschrauber') then
    Result := THelicopter.Create(ABrand, AModel, AVIN)
  else
    raise Exception.Create('Error!');
end;

end.
