unit untPedidosItensControllerInterface;

interface

uses
  untPedidosItensModelInterface;

type
  IPedidosItensController = interface
    ['{78B50E1C-7DA2-469D-B351-527591726C1E}']

    function Inserir(oPedidosItens: IPedidosItens): Boolean;
    function Alterar(oPedidosItens: IPedidosItens): Boolean;
    function Excluir(aID: Integer): Boolean;
    function ExcluirTodos(aIDPedido: Integer): Boolean;
    function Carregar(aID: Integer): IPedidosItens;
  end;

implementation

end.
