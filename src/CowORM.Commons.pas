unit CowORM.Commons;

interface

type
  TConnectionType = (ctFB, ctMYSQL);

  TConnectionTypeHelper = record helper for TConnectionType
    function ToString: string;
  end;

implementation

{ TConnectionTypeHelper }

function TConnectionTypeHelper.ToString: string;
begin
  case Self of
    ctFB:    Result := 'FireBird';
    ctMYSQL: Result := 'MySQL';
  end;
end;

end.
