unit CowORM.Helpers;

interface

uses
  System.StrUtils, System.Generics.Defaults, System.Math, CowORM.Commons;

type
  TArrayUtils<T> = class
    class procedure Append(var Arr: TArray<T>; Value: T); overload;
    class procedure Append(var Arr: TArray<T>; Values: TArray<T>); overload;
    class function Contains(const anArray: array of T; const x: T) : Boolean;
    class function Count(const anArray: array of T; const x: T) : Integer;
  end;

function GetWords(Text: string): TArray<string>;
function Spaces(Number: Integer = 0): string;
function Coalesce(Values: TArray<string>): string;
function GetTableLabel(Index: Integer): string;
function GetDriverName(pType: TConnectionType): string;
function GetDriverID(pType: TConnectionType): string;

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

function Coalesce(Values: TArray<string>): string;
var
  Value: string;
begin
  Result := '';

  for Value in Values do
  begin
    if Value <> '' then
    begin
      Result := Value;
      Exit;
    end;
  end;
end;

function GetTableLabel(Index: Integer): string;
const
  Alphabet: string = 'abcdfghijklmnopqrstuvwxyz';
var
  Value: Integer;
begin
  Result := '';

  if Index >= Length(Alphabet) then
  begin
    while Index >= Length(Alphabet) do
    begin
      Value := Floor(Index / Length(Alphabet));
      Index := Index - (Value * Length(Alphabet));

      Result := Result + Alphabet[Value];
    end;
  end;

  Result := Result + Alphabet[Index];
end;

function GetDriverName(pType: TConnectionType): string;
begin
  Result := '';

  if pType = ctFB then
    Result := 'FB'
  else if pType = ctMYSQL then
    Result := 'MYSQL'
end;

function GetDriverID(pType: TConnectionType): string;
begin
  Result := '';

  if pType = ctFB then
    Result := 'FB'
  else if pType = ctMYSQL then
    Result := 'MYSQL'
end;

{ TArrayUtils<T> }

class procedure TArrayUtils<T>.Append(var Arr: TArray<T>; Value: T);
begin
  SetLength(Arr, Length(Arr)+1);
  Arr[High(Arr)] := Value;
end;

class procedure TArrayUtils<T>.Append(var Arr: TArray<T>; Values: TArray<T>);
var
  Obj: T;
begin
  for Obj in Values do
    TArrayUtils<T>.Append(Arr, Obj);
end;

class function TArrayUtils<T>.Contains(const anArray: array of T;
  const x: T): Boolean;
var
  y : T;
  lComparer: IEqualityComparer<T>;
begin
  lComparer := TEqualityComparer<T>.Default;
  for y in anArray do
  begin
    if lComparer.Equals(x, y) then
      Exit(True);
  end;
  Exit(False);
end;


class function TArrayUtils<T>.Count(const anArray: array of T;
  const x: T): Integer;
var
  y : T;
  lComparer: IEqualityComparer<T>;
begin
  Result := 0;
  lComparer := TEqualityComparer<T>.Default;
  for y in anArray do
  begin
    if lComparer.Equals(x, y) then
      Result := Result + 1;
  end;
end;

end.
