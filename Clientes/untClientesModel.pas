unit untClientesModel;

interface

uses
  System.SysUtils,

  untClientesModelInterface;

type
  TClientes = class(TInterfacedObject, IClientes)
  private
    var
      FId           : Integer;
      FNomeFantasia : String;
      FRazaoSocial  : String;
      FCNPJ         : String;
      FEndereco     : String;
      FTelefone     : String;
  public
    constructor Create();

    procedure Clear();

    procedure SetId(const aValue: Integer);
    procedure SetNomeFantasia(const aValue: String);
    procedure SetRazaoSocial(const aValue: String);
    procedure SetCNPJ(const aValue: String);
    procedure SetEndereco(const aValue: String);
    procedure SetTelefone(const aValue: String);

    function GetId:Integer;
    function GetNomeFantasia:String;
    function GetRazaoSocial:String;
    function GetCNPJ:String;
    function GetEndereco:String;
    function GetTelefone:String;

    class function New():IClientes; overload; static;
    class function New(aID: Integer; aNomeFantasia, aRazaoSocial, aCNPJ, aEndereco, aTelefone: String):IClientes; overload; static;
  end;

implementation

procedure TClientes.Clear;
begin
  Self.FId           := 0;
  Self.FNomeFantasia := EmptyStr;
  Self.FRazaoSocial  := EmptyStr;
  Self.FCNPJ         := EmptyStr;
  Self.FEndereco     := EmptyStr;
  Self.FTelefone     := EmptyStr;
end;

constructor TClientes.Create;
begin
  Self.Clear;
end;

function TClientes.GetId: Integer;
begin
  Result := fId;
end;

function TClientes.GetNomeFantasia: String;
begin
  Result := fNomeFantasia;
end;

function TClientes.GetRazaoSocial: String;
begin
  Result := fRazaoSocial;
end;

function TClientes.GetCNPJ: String;
begin
  Result := fCNPJ;
end;

function TClientes.GetEndereco: String;
begin
  Result := fEndereco;
end;

function TClientes.GetTelefone: String;
begin
  Result := fTelefone;
end;

procedure TClientes.SetId(const aValue: Integer);
begin
  FId := aValue;
end;

procedure TClientes.SetNomeFantasia(const aValue: String);
begin
  FNomeFantasia := aValue;
end;

procedure TClientes.SetRazaoSocial(const aValue: String);
begin
  FRazaoSocial := aValue;
end;

procedure TClientes.SetCNPJ(const aValue: String);
begin
  FCNPJ := aValue;
end;

procedure TClientes.SetEndereco(const aValue: String);
begin
  FEndereco := aValue;
end;

procedure TClientes.SetTelefone(const aValue: String);
begin
  FTelefone := aValue;
end;

class function TClientes.New: IClientes;
begin
  Result := TClientes.Create;
end;

class function TClientes.New(aID: Integer; aNomeFantasia, aRazaoSocial, aCNPJ, aEndereco, aTelefone: String): IClientes;
begin
  Result := TClientes.New;

  Result.SetID(aID);
  Result.SetNomeFantasia(aNomeFantasia);
  Result.SetRazaoSocial(aRazaoSocial);
  Result.SetCNPJ(aCNPJ);
  Result.SetEndereco(aEndereco);
  Result.SetTelefone(aTelefone);
end;

end.
