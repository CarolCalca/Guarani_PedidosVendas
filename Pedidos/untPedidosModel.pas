unit untPedidosModel;

interface

uses
  System.SysUtils,

  untPedidosModelInterface,
  untPedidosItensModel;

type
  TPedidos = class(TInterfacedObject, IPedidos)
  private
    var
      FId           : Integer;
      FIdCliente    : Integer;
      FValorTotal   : Double;
      FDataHora     : TDateTime;
      oPedidosItens : TPedidosItensList;
  public
    constructor Create();

    destructor Destroy(); override;

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

    class function New():IPedidos; overload; static;
    class function New(aID, aIdCliente: Integer; aValorTotal: Double; aDataHora: TDateTime; aPedidosItens: TPedidosItensList):IPedidos; overload; static;
  end;

implementation

procedure TPedidos.Clear;
begin
  Self.FId         := 0;
  Self.FIdCliente  := 0;
  Self.FValorTotal := 0;
  Self.FDataHora   := 0;

  oPedidosItens.Clear;
end;

constructor TPedidos.Create;
begin
  oPedidosItens := TPedidosItensList.Create();

  Self.Clear;
end;

destructor TPedidos.Destroy;
begin

  FreeAndNil(oPedidosItens);

  inherited;
end;

function TPedidos.GetId: Integer;
begin
  Result := fId;
end;

function TPedidos.GetIdCliente: Integer;
begin
  Result := fIdCliente;
end;

function TPedidos.GetValorTotal: Double;
begin
  Result := fValorTotal;
end;

function TPedidos.GetDataHora: TDateTime;
begin
  Result := fDataHora;
end;

function TPedidos.GetPedidosItens: TPedidosItensList;
begin
  Result := oPedidosItens;
end;

procedure TPedidos.SetId(const aValue: Integer);
begin
  FId := aValue;
end;

procedure TPedidos.SetIdCliente(const aValue: Integer);
begin
  FIdCliente := aValue;
end;

procedure TPedidos.SetValorTotal(const aValue: Double);
begin
  FValorTotal := aValue;
end;

procedure TPedidos.SetDataHora(const aValue: TDateTime);
begin
  FDataHora := aValue;
end;

procedure TPedidos.SetPedidosItens(const Value: TPedidosItensList);
begin
  oPedidosItens := Value;
end;

class function TPedidos.New: IPedidos;
begin
  Result := TPedidos.Create;
end;

class function TPedidos.New(aID, aIdCliente: Integer; aValorTotal: Double; aDataHora: TDateTime; aPedidosItens: TPedidosItensList): IPedidos;
begin
  Result := TPedidos.New;

  Result.SetID(aID);
  Result.SetIDCliente(aIdCliente);
  Result.SetValorTotal(aValorTotal);
  Result.SetDataHora(aDataHora);
  Result.SetPedidosItens(aPedidosItens);
end;

end.
