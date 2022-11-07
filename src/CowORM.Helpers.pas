unit CowORM.Helpers;

interface

uses
  System.StrUtils;

type
  TArrayUtils<T> = class
    class procedure Append(var Arr: TArray<T>; Value: T);
  end;

function GetWords(Text: string): TArray<string>;
function Spaces(Number: Integer = 0): string;

implementation

function GetWords(Text: string): TArray<string>;
begin
  Result := TArray<string>(SplitString(Text, ' '));
end;

function Spaces(Number: Integer = 0): string;
begin
  Result := '';

  while Number > 0 do
  begin
    Result := Result + ' ';
    Number := Number - 1;
  end;
end;

{ TArrayUtils<T> }

class procedure TArrayUtils<T>.Append(var Arr: TArray<T>; Value: T);
begin
  SetLength(Arr, Length(Arr)+1);
  Arr[High(Arr)] := Value;
end;

end.
