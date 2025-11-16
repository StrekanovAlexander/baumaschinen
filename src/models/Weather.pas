unit Weather;

interface

uses System.SysUtils, System.Net.HttpClientComponent, System.JSON;

type TWeather = class
  private
    FTime: string;
    FTemperature: Double;
    FWindSpeed: Double;
    FWindDirection: Double;
    procedure ParseAndAssign(const JSONText: string);
  public
    constructor Create(const URL: string);
    property Time: string read FTime write FTime;
    property Temperature: Double read FTemperature write FTemperature;
    property WindSpeed: Double read FWindSpeed write FWindSpeed;
    property WindDirection: Double read FWindDirection write FWindDirection;

    function ToBreakString: string;
end;

implementation

constructor TWeather.Create(const URL: string);
var HttpClient: TNetHTTPClient;
    Response: string;
begin
  HttpClient := TNetHTTPClient.Create(nil);
  try
    Response := HttpClient.Get(URL).ContentAsString;
    ParseAndAssign(Response);
  finally
    HttpClient.Free;
  end;
end;

procedure TWeather.ParseAndAssign(const JSONText: string);
var
  JSONObj, CurrentWeather: TJSONObject;
begin
  JSONObj := TJSONObject.ParseJSONValue(JSONText) as TJSONObject;
  if Assigned(JSONObj) then
    try
      CurrentWeather := JSONObj.GetValue('current_weather') as TJSONObject;
      if Assigned(CurrentWeather) then
        begin
          FTime := CurrentWeather.GetValue<string>('time');
          FTemperature := CurrentWeather.GetValue<Double>('temperature');
          FWindSpeed := CurrentWeather.GetValue<Double>('windspeed');
          FWindDirection := CurrentWeather.GetValue<Double>('winddirection');
        end;
    finally
      JSONObj.Free;
    end;
end;

function TWeather.ToBreakString: string;
begin
  Result := 'Wetterdaten:' + sLineBreak +
            'Zeit: ' + Time + sLineBreak +
            'Temperatur: ' + Temperature.ToString + ' °C' + sLineBreak +
            'Wind: ' + WindSpeed.ToString + ' m/s, ' + WindDirection.ToString + '°';
end;

end.
