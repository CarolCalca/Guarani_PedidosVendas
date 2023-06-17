object fMain: TfMain
  Left = 0
  Top = 0
  Caption = 'Menu Principal'
  ClientHeight = 526
  ClientWidth = 837
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 837
    Height = 526
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 833
    ExplicitHeight = 525
  end
  object MainMenu: TMainMenu
    Left = 40
    Top = 24
    object miCadastros: TMenuItem
      Caption = 'Cadastros'
      object miClientes: TMenuItem
        Caption = 'Clientes'
        OnClick = miClientesClick
      end
      object miProdutos: TMenuItem
        Caption = 'Produtos'
        OnClick = miProdutosClick
      end
    end
    object miOperacoes: TMenuItem
      Caption = 'Opera'#231#245'es'
      object miPedidosVenda: TMenuItem
        Caption = 'Pedidos de Venda'
        OnClick = miPedidosVendaClick
      end
    end
    object miRelatorios: TMenuItem
      Caption = 'Relat'#243'rios'
      object miRelPedidosVenda: TMenuItem
        Caption = 'Pedidos de Venda'
      end
      object miRelProdutosMaisVendidos: TMenuItem
        Caption = 'Produtos Mais Vendidos'
      end
    end
  end
end
