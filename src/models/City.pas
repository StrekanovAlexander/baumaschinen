unit City;

interface

uses System.SysUtils;

type TCity = class
  private
    FID: Integer;
    FCity: string;
    FLatitude: Double;
    FLongitude: Double;
  public
    constructor Create(AID: Integer; const ACity: string; ALatitude: Double; ALongitude: Double);
    function ToString: string; override;
    property ID: Integer read FID;
    property City: string read FCity;
    property Latitude: Double read FLatitude;
    property Longitude: Double read FLongitude;
end;

implementation

constructor TCity.Create(AID: Integer; const ACity: string; ALatitude: Double; ALongitude: Double);
begin
  inherited Create;
  FID := AID;
  FCity := ACity;
  FLatitude := ALatitude;
  FLongitude := ALongitude;
end;

function TCity.ToString: string;
begin
  Result := Format('%s (%.4f, %.4f)', [FCity, FLatitude, FLongitude]);
end;

end.
