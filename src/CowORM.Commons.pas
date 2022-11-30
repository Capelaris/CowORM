unit CowORM.Commons;

interface

type
  TConnectionType = (ctFB, ctMYSQL);

  TConnectionTypeHelper = record helper for TConnectionType
    function ToString: string;
    function Drivername: string;
    function DriverID: string;
  end;

implementation

{ TConnectionTypeHelper }

function TConnectionTypeHelper.DriverID: string;
begin
  case Self of
    ctFB:    Result := 'FB';
    ctMYSQL: Result := 'MYSQL';
  end;
end;

function TConnectionTypeHelper.Drivername: string;
begin
  case Self of
    ctFB:    Result := 'FB';
    ctMYSQL: Result := 'MYSQL';
  end;
end;

function TConnectionTypeHelper.ToString: string;
begin
  case Self of
    ctFB:    Result := 'FireBird';
    ctMYSQL: Result := 'MySQL';
  end;
end;

end.
