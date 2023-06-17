unit untProdutosModel;

interface

uses
  System.SysUtils,

  untProdutosModelInterface;

type
  TProdutos = class(TInterfacedObject, IProdutos)
  private
    var
      FId        : Integer;
      FDescricao : String;
      FMarca     : String;
      FPreco     : Double;
  public
    constructor Create();

    procedure Clear();

    procedure SetId(const aValue: Integer);
    procedure SetDescricao(const aValue: String);
    procedure SetMarca(const aValue: String);
    procedure SetPreco(const aValue: Double);

    function GetId:Integer;
    function GetDescricao:String;
    function GetMarca:String;
    function GetPreco:Double;

    class function New():IProdutos; overload; static;
    class function New(aID: Integer; aDescricao, aMarca: String; aPreco: Double):IProdutos; overload; static;
  end;

implementation

procedure TProdutos.Clear;
begin
  Self.FId        := 0;
  Self.FDescricao := EmptyStr;
  Self.FMarca     := EmptyStr;
  Self.FPreco     := 0;
end;

constructor TProdutos.Create;
begin
  Self.Clear;
end;

function TProdutos.GetId: Integer;
begin
  Result := fId;
end;

function TProdutos.GetDescricao: String;
begin
  Result := FDescricao;
end;

function TProdutos.GetMarca: String;
begin
  Result := FMarca;
end;

function TProdutos.GetPreco: Double;
begin
  Result := FPreco;
end;

procedure TProdutos.SetId(const aValue: Integer);
begin
  FId := aValue;
end;

procedure TProdutos.SetDescricao(const aValue: String);
begin
  FDescricao := aValue;
end;

procedure TProdutos.SetMarca(const aValue: String);
begin
  FMarca := aValue;
end;

procedure TProdutos.SetPreco(const aValue: Double);
begin
  FPreco := aValue;
end;

class function TProdutos.New: IProdutos;
begin
  Result := TProdutos.Create;
end;

class function TProdutos.New(aID: Integer; aDescricao, aMarca: String; aPreco: Double): IProdutos;
begin
  Result := TProdutos.New;

  Result.SetID(aID);
  Result.SetDescricao(aDescricao);
  Result.SetMarca(aMarca);
  Result.SetPreco(aPreco);
end;

end.
