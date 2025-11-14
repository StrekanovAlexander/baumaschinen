unit MachineBase;

interface

type IMachine = interface
  ['{91BD3E05-1CD8-4E7A-B0AD-CB4B91FB1128}']
  procedure SetBrand(const ABrand: string);
  procedure SetModel(const AModel: string);
  procedure SetVIN(const AVIN: string);
end;

implementation

end.
