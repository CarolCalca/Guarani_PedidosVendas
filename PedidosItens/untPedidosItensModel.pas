unit untPedidosItensModel;

interface

uses
  System.SysUtils,
  System.Generics.Collections,

  untPedidosItensModelInterface;

type
  TPedidosItens = class(TInterfacedObject, IPedidosItens)
  private
    var
      FId         : Integer;
      FIdPedido   : Integer;
      FIdProduto  : Integer;
      FQuantidade : Integer;
      FPreco      : Double;
  public
    constructor Create();

    procedure Clear();

    procedure SetId(const aValue: Integer);
    procedure SetIdPedido(const aValue: Integer);
    procedure SetIdProduto(const aValue: Integer);
    procedure SetQuantidade(const aValue: Integer);
    procedure SetPreco(const aValue: Double);

    function GetId:Integer;
    function GetIdPedido:Integer;
    function GetIdProduto:Integer;
    function GetQuantidade:Integer;
    function GetPreco:Double;

    class function New():IPedidosItens; overload; static;
    class function New(aID, aIDPedido, aIDProduto, aQuantidade: Integer; aPreco: Double):IPedidosItens; overload; static;
  end;

 type
   TPedidosItensList = class(TList<IPedidosItens>)
  end;

implementation

procedure TPedidosItens.Clear;
begin
  Self.FId         := 0;
  Self.FIdPedido   := 0;
  Self.FIdProduto  := 0;
  Self.FQuantidade := 0;
  Self.FPreco      := 0;
end;

constructor TPedidosItens.Create;
begin
  Self.Clear;
end;

function TPedidosItens.GetId: Integer;
begin
  Result := fId;
end;

function TPedidosItens.GetIdPedido: Integer;
begin
  Result := fIdPedido;
end;

function TPedidosItens.GetIdProduto: Integer;
begin
  Result := fIdProduto;
end;

function TPedidosItens.GetQuantidade: Integer;
begin
  Result := fQuantidade;
end;

function TPedidosItens.GetPreco: Double;
begin
  Result := FPreco;
end;

procedure TPedidosItens.SetId(const aValue: Integer);
begin
  FId := aValue;
end;

procedure TPedidosItens.SetIdPedido(const aValue: Integer);
begin
  FIdPedido := aValue;
end;

procedure TPedidosItens.SetIdProduto(const aValue: Integer);
begin
  FIdProduto := aValue;
end;

procedure TPedidosItens.SetQuantidade(const aValue: Integer);
begin
  FQuantidade := aValue;
end;

procedure TPedidosItens.SetPreco(const aValue: Double);
begin
  FPreco := aValue;
end;

class function TPedidosItens.New: IPedidosItens;
begin
  Result := TPedidosItens.Create;
end;

class function TPedidosItens.New(aID, aIDPedido, aIDProduto, aQuantidade: Integer; aPreco: Double): IPedidosItens;
begin
  Result := TPedidosItens.New;

  Result.SetID(aID);
  Result.SetIDPedido(aIDPedido);
  Result.SetIDProduto(aIDProduto);
  Result.SetQuantidade(aQuantidade);
  Result.SetPreco(aPreco);
end;

end.
