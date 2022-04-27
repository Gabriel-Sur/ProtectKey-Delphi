unit uCrypto;

interface
Function Enc(texto: String; chave: Integer): String;
Function Dec(texto: String; chave: Integer): String;

implementation

function AsciiToInt(Caracter: Char): Integer;
var i: Integer;
begin
  i := 32;
  while i< 255 do
  begin
    if Chr(i) = Caracter then
      Break;
    i := i +1;
  end;
  Result := i;
end;

Function Enc(texto: String; chave:integer):String;
var cont:integer; retorno: string;
begin
  if(texto = '') or (chave = 0) then
  begin
    result := texto;
  end else
  begin
    retorno := '';
  end;
  for cont := 1 to length(texto) do
  begin
    retorno := retorno + chr(asciitoint(texto[cont]) + chave);
  end;
  result := retorno;
end;

Function Dec(texto: string; chave: integer): String;
var cont: integer; retorno: string;
begin
  if(texto = '') or (chave = 0) then
  begin
    result := texto;
  end else
  begin
    retorno := '';
    for cont := 1 to length(texto) do
    begin
      retorno := retorno + chr(asciitoint(texto[cont]) - chave);
    end;
    result := retorno;
  end;
end;

end.
