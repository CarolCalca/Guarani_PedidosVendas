unit untProdutosControllerInterface;

interface

uses
  untProdutosModelInterface;

type
  IProdutosController = interface
    ['{A1E34966-2910-4A0C-ABC9-B8A9EB2DE1D0}']

    function Inserir(oProduto: IProdutos): Boolean;
    function Alterar(oProduto: IProdutos): Boolean;
    function Excluir(aIdProduto: Integer): Boolean;
    function Carregar(aIdProduto: Integer): IProdutos;
  end;

implementation

end.
