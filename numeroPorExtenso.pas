unit numeroPorExtenso;

interface

type
  TNumeroPorExtenso = class
  private
    FsNumero: string;
    function getNumeroPorExtenso: string;
    procedure setNumero(const Value: string);
  protected
    function IncluirLetraE(sNumeroAnt, sNumeroPost: string): string;
  public
    property sNumero: string read FsNumero write setNumero;
    property sNumeroPorExtenso: string read getNumeroPorExtenso;
  end;

implementation

Uses
  SysUtils;

{ TNumeroPorExtenso }

const
  unidade: array[0..19] of string = ('', 'um', 'dois', 'três', 'quatro', 'cinco', 'seis', 'sete', 'oito', 'nove',
    'dez', 'onze', 'doze', 'treze', 'quatorze', 'quinze', 'dezesseis', 'dezessete', 'dezoito', 'dezenove');

  dezena: array [0..9] of string = ('', 'dez', 'vinte', 'trinta', 'quarenta', 'cinquenta', 'sessenta', 'setenta', 'oitenta', 'noventa');

  centena: array[0..9] of string = ('', 'cem', 'duzentos', 'trezentos', 'quatrocentos', 'quinhentos', 'seiscentos', 'setecentos', 'oitocentos', 'novecentos');

  milhagem: array[0..4] of string = ('', 'mil', 'milhão', 'bilhão', 'trilhão');

  milhagens: array[0..4] of string = ('', 'mil', 'milhões', 'bilhões', 'trilhões');

function TNumeroPorExtenso.getNumeroPorExtenso: string;
var
  sNumero, sExtenso: string;
  nParteNum, nMilhagem, nCent, nDez, nUnid: Integer;
  sMenos: string;
begin
  Result := '';
  sExtenso := '';
  if Trim(FsNumero) = '' then
    exit;

  sNumero := FsNumero;
  if (sNumero[1] = '-') then
  begin
    sNumero := Copy(sNumero, 2, Length(sNumero));
    sMenos := 'menos ';
  end
  else
    sMenos := '';

  nMilhagem := 0;
  while sNumero <> '' do
  begin
    nParteNum := StrToInt(Copy(sNumero, Length(sNumero) - 2, 3));
    nCent := (nParteNum div 100);// (765 div 100) = 7
    nDez := (nParteNum mod 100); // (765 mod 100) = 65
    if (9 < nDez) and (nDez < 20) then
    begin
      if nCent = 1 then
        sExtenso := 'cento'
      else
        sExtenso := centena[nCent];
      sExtenso := sExtenso + IncluirLetraE(centena[nCent], unidade[nDez]) + unidade[nDez];
    end
    else
    begin
      nDez := nDez div 10;                 // 65 div 10 = 6
      nUnid := (nParteNum mod 100) mod 10; // (765 mod 100) = 65 mod 10 = 5
      if (nCent = 1) and ((dezena[nDez] + unidade[nUnid]) <> '') then
        sExtenso := 'cento'
      else
        sExtenso := centena[nCent];
      sExtenso := sExtenso + IncluirLetraE(centena[nCent], dezena[nDez] + unidade[nUnid]) + dezena[nDez] +
        IncluirLetraE(dezena[nDez], unidade[nUnid]) + unidade[nUnid];
    end;
    if nParteNum = 1 then
      sExtenso := sExtenso + ' ' + milhagem[nMilhagem]
    else if nParteNum > 1 then
      sExtenso := sExtenso + ' ' + milhagens[nMilhagem]
    else
      sExtenso := '';
    Result := sExtenso + IncluirLetraE(sExtenso, Result) + Result;
    Inc(nMilhagem);
    sNumero := Copy(sNumero, 1, Length(sNumero) - 3);
  end;
  Result := sMenos + Trim(Result);
end;

function TNumeroPorExtenso.IncluirLetraE(sNumeroAnt, sNumeroPost: string): string;
begin
  if sNumeroAnt = '' then
    Result := ''
  else if sNumeroPost <> '' then
    Result := ' e '
  else
    Result := '';
end;

procedure TNumeroPorExtenso.setNumero(const Value: string);
begin
  if (Trim(Value) <> '') and (Value[1] = '/') then
    FsNumero := Copy(Value, 2, Length(Value))
  else
    FsNumero := Value;
end;

end.
