unit untProdutosModelInterface;

interface

type
  IProdutos = interface
    ['{6342E601-832F-44E0-B026-9A1ED16034C8}']

    procedure Clear();

    procedure SetId(const aValue: Integer);
    procedure SetDescricao(const aValue: String);
    procedure SetMarca(const aValue: String);
    procedure SetPreco(const aValue: Double);

    function GetId:Integer;
    function GetDescricao:String;
    function GetMarca:String;
    function GetPreco:Double;
  end;

implementation

end.
