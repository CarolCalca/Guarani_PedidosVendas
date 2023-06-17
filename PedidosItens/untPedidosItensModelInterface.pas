unit untPedidosItensModelInterface;

interface

type
  IPedidosItens = interface
    ['{96424CB2-39A8-4808-9CB0-B313FB421F08}']

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
  end;

implementation

end.
