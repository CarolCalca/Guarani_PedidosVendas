program PedidosVenda;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {fMain},
  untConnection in 'untConnection.pas',
  frmClientes in 'Clientes\frmClientes.pas' {fClientes},
  untClientesModel in 'Clientes\untClientesModel.pas',
  untClientesModelInterface in 'Clientes\untClientesModelInterface.pas',
  untClientesController in 'Clientes\untClientesController.pas',
  untClientesControllerInterface in 'Clientes\untClientesControllerInterface.pas',
  untUtils in 'untUtils.pas',
  frmProdutos in 'Produtos\frmProdutos.pas' {fProdutos},
  untProdutosController in 'Produtos\untProdutosController.pas',
  untProdutosControllerInterface in 'Produtos\untProdutosControllerInterface.pas',
  untProdutosModel in 'Produtos\untProdutosModel.pas',
  untProdutosModelInterface in 'Produtos\untProdutosModelInterface.pas',
  frmPedidos in 'Pedidos\frmPedidos.pas' {fPedidos},
  untPedidosController in 'Pedidos\untPedidosController.pas',
  untPedidosControllerInterface in 'Pedidos\untPedidosControllerInterface.pas',
  untPedidosModel in 'Pedidos\untPedidosModel.pas',
  untPedidosModelInterface in 'Pedidos\untPedidosModelInterface.pas',
  untPedidosItensController in 'PedidosItens\untPedidosItensController.pas',
  untPedidosItensControllerInterface in 'PedidosItens\untPedidosItensControllerInterface.pas',
  untPedidosItensModel in 'PedidosItens\untPedidosItensModel.pas',
  untPedidosItensModelInterface in 'PedidosItens\untPedidosItensModelInterface.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
