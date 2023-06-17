unit frmMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Menus,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,

  untConnection,
  frmClientes,
  frmProdutos,
  frmPedidos;

type
  TfMain = class(TForm)
    pnlMain: TPanel;
    MainMenu: TMainMenu;
    miCadastros: TMenuItem;
    miClientes: TMenuItem;
    miProdutos: TMenuItem;
    miOperacoes: TMenuItem;
    miPedidosVenda: TMenuItem;
    miRelatorios: TMenuItem;
    miRelPedidosVenda: TMenuItem;
    miRelProdutosMaisVendidos: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure miClientesClick(Sender: TObject);
    procedure miProdutosClick(Sender: TObject);
    procedure miPedidosVendaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

procedure TfMain.FormCreate(Sender: TObject);
begin
  TConnection.getConnection();
end;

procedure TfMain.miClientesClick(Sender: TObject);
begin
  TfClientes.AbreCadastro();
end;

procedure TfMain.miPedidosVendaClick(Sender: TObject);
begin
  TfPedidos.AbreCadastro();
end;

procedure TfMain.miProdutosClick(Sender: TObject);
begin
  TfProdutos.AbreCadastro();
end;

end.
