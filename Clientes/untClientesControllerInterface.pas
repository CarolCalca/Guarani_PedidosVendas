unit untClientesControllerInterface;

interface

uses
  untClientesModelInterface;

type
  IClientesController = interface
    ['{C3A6EC7D-0935-440B-ADB5-CA7E41B3BCFF}']

    function Inserir(oCliente: IClientes): Boolean;
    function Alterar(oCliente: IClientes): Boolean;
    function Excluir(aIdCliente: Integer): Boolean;
    function Carregar(aIdCliente: Integer): IClientes;
  end;

implementation

end.
