unit MachineFactory;

interface

uses System.SysUtils, Machine, MachineKind, Truck, Crane, Excavator, Helicopter;

type TMachineFactory = class
  class function Make(const AMachine: string; const ABrand: string;
                      const AModel: string; const AVIN: string): TMachine;

  class function CreateCopy(AMachine: TMachine): TMachine;
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


class function TMachineFactory.CreateCopy(AMachine: TMachine): TMachine;
begin
  case AMachine.MachineKind of
    mkTruck:
      Result := TTruck.Create(AMachine.Brand, AMachine.Model, AMachine.VIN);
    mkExcavator:
      Result := TExcavator.Create(AMachine.Brand, AMachine.Model, AMachine.VIN);
    mkCrane:
      Result := TCrane.Create(AMachine.Brand, AMachine.Model, AMachine.VIN);
    mkHelicopter:
      Result := THelicopter.Create(AMachine.Brand, AMachine.Model, AMachine.VIN);
  end;
end;

end.
