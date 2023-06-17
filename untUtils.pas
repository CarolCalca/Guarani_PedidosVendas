unit untUtils;

interface

uses
  System.SysUtils,
  Vcl.Dialogs;

type
  TUtils = class
  private

  public
    const cVlrMask: String = '###,###,###,###,##0.00';

    class function validarCNPJ(aCNPJ: String):Boolean;
    class function validarTelefone(aTelefone: String):Boolean;

    class function formatarPreco(aPreco: String):String; Overload;
    class function formatarPreco(aPreco: Double):String; Overload;
  end;

implementation

{ TUtils }

class function TUtils.formatarPreco(aPreco: String): String;
var
  vPreco: String;
begin
  Result := EmptyStr;

  vPreco := EmptyStr;

  if aPreco <> EmptyStr then
  begin
    vPreco := StringReplace(aPreco, '.', EmptyStr, [rfReplaceAll]);
    vPreco := StringReplace(aPreco, ',', EmptyStr, [rfReplaceAll]);

    if (Length(vPreco) = 1) then
      vPreco := '0,0' + vPreco
    else if (Length(vPreco) = 2) then
      vPreco := '0,' + vPreco
    else
      vPreco := Copy(vPreco, 1, Length(vPreco)-2) + ',' + Copy(vPreco, Length(vPreco)-1, 2);

    vPreco := FormatFloat(cVlrMask, StrToFloat(vPreco));
  end
  else
    vPreco := '0,00';

  Result := vPreco;
end;

class function TUtils.formatarPreco(aPreco: Double): String;
begin
  Result := FormatFloat(cVlrMask, aPreco);
end;

class function TUtils.validarCNPJ(aCNPJ: String): Boolean;
var
  dig13: String;
  dig14: String;
  sm: Integer;
  i: Integer;
  r: Integer;
  peso: Integer;
begin
  Result := False;

  if not ((aCNPJ = '00000000000000') or (aCNPJ = '11111111111111') or
          (aCNPJ = '22222222222222') or (aCNPJ = '33333333333333') or
          (aCNPJ = '44444444444444') or (aCNPJ = '55555555555555') or
          (aCNPJ = '66666666666666') or (aCNPJ = '77777777777777') or
          (aCNPJ = '88888888888888') or (aCNPJ = '99999999999999') or
          (length(aCNPJ) <> 14)) then
  begin
    try
  // Cálculo do 1o. digito verificador
      sm := 0;
      peso := 2;
      for i := 12 downto 1 do
      begin
        sm := sm + (StrToInt(aCNPJ[i]) * peso);
        peso := peso + 1;
        if (peso = 10) then
          peso := 2;
      end;
      r := sm mod 11;
      if ((r = 0) or (r = 1)) then
        dig13 := '0'
      else
        str((11-r):1, dig13);

  // Cálculo do 2o. dígito verificador
      sm := 0;
      peso := 2;
      for i := 13 downto 1 do
      begin
        sm := sm + (StrToInt(aCNPJ[i]) * peso);
        peso := peso + 1;
        if (peso = 10) then
          peso := 2;
      end;
      r := sm mod 11;
      if ((r = 0) or (r = 1)) then
        dig14 := '0'
      else
        str((11-r):1, dig14);

  // Verifica se os dígitos calculados conferem com os dígitos informados. }
      if ((dig13 = aCNPJ[13]) and (dig14 = aCNPJ[14])) then
        Result := True;
    except
      on E:Exception do
        ShowMessage('Não foi possível validar o CNPJ.' + #13 + E.Message);
    end;
  end;
end;

class function TUtils.validarTelefone(aTelefone: String): Boolean;
begin
  Result := False;

  if (Length(aTelefone) = 10) or (Length(aTelefone) = 11) then
    Result := True;
end;

end.
