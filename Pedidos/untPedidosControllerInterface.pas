unit untPedidosControllerInterface;

interface

uses
  untPedidosModelInterface;

type
  IPedidosController = interface
    ['{B39C5C0F-D364-4CB7-B382-537F08CCF01C}']

    function Inserir(oPedidos: IPedidos): Integer;
    function Alterar(oPedidos: IPedidos): Boolean;
    function Excluir(aID: Integer): Boolean;
    function Carregar(aID: Integer): IPedidos;

  end;

implementation

end.
