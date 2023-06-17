unit untPedidosModelInterface;

interface

uses
  untPedidosItensModel;

type
  IPedidos = interface
    ['{B7977129-AC5F-47CD-83C0-D2F01CB7760E}']

    procedure Clear();

    procedure SetId(const aValue: Integer);
    procedure SetIdCliente(const aValue: Integer);
    procedure SetValorTotal(const aValue: Double);
    procedure SetDataHora(const aValue: TDateTime);
    procedure SetPedidosItens(const Value: TPedidosItensList);

    function GetId:Integer;
    function GetIdCliente:Integer;
    function GetValorTotal:Double;
    function GetDataHora:TDateTime;
    function GetPedidosItens:TPedidosItensList;
  end;

implementation

end.
