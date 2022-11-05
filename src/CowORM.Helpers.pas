unit CowORM.Helpers;

interface

uses
  System.StrUtils;

function GetWords(Text: string): TArray<string>;

implementation

function GetWords(Text: string): TArray<string>;
begin
  Result := TArray<string>(SplitString(Text, ' '));
end;

end.
