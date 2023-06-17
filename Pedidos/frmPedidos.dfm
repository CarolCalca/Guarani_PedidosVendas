object fPedidos: TfPedidos
  Left = 0
  Top = 0
  Caption = 'Pedidos de Venda'
  ClientHeight = 522
  ClientWidth = 511
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object pnlControle: TPanel
    Left = 0
    Top = 0
    Width = 511
    Height = 34
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 507
    DesignSize = (
      511
      34)
    object btCarregarPedido: TBitBtn
      Left = 431
      Top = 5
      Width = 25
      Height = 25
      Hint = 'Carregar pedido [F1]'
      Anchors = [akTop, akRight]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777FFFFFFFFFFF000077777700000000000777777788888888888F
        00007777778777777777077777778F777777778F00007777778FFFFFFFF70777
        77778F7FFFFFF78F00007777718F777777F707777778FF888888778F00007777
        711FFFFFFFF7077777F88F7FFFFFF78F000077711111777777F70777F8888888
        8888778F00007887711FFFFFFFF7077787788F7FFFFFF78F00007177718F7777
        77F70778F7788F888888778F00007177778FFFFFFFF70778F7778F7FFFFFF78F
        00007177778F777777F70778F7778F888888778F00007887778FFFFFFFF70778
        7F778F7FFFF7778F00007717778F7777FFF7077787F78F888877FF8F00007771
        778FFFFFF000077778778F777778888700007777778FFFFFF7F8777777778F77
        7778F87700007777778FFFFFF787777777778FFFFFF887770000777777888888
        8877777777778888888877770000777777777777777777777777777777777777
        0000}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = btCarregarPedidoClick
      ExplicitLeft = 427
    end
    object btExcluirPedido: TBitBtn
      Left = 462
      Top = 5
      Width = 25
      Height = 25
      Hint = 'Excluir pedido [F2]'
      Anchors = [akTop, akRight]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
        6666666666666666666666660000666668666666666666666666666666666666
        0000666608866666666666666686666666666666000066691086666688666666
        6888666666666666000066691088666008866666688866666886666600006669
        1108869110866666688886668888666600006666911089111066666666888868
        8888666600006666911191110666666666888888888666660000666669111110
        6666666666688888886666660000666666911108866666666666888886666666
        0000666666911110866666666666888888666666000066666911011088666666
        6668888888666666000066666910691108866666666888688886666600006666
        9106669110886666668886668888666600006666910666691108666666888666
        6888866600006666696666669106666666686666668886660000666666666666
        6966666666666666666866660000666666666666666666666666666666666666
        0000}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
      OnClick = btExcluirPedidoClick
      ExplicitLeft = 458
    end
  end
  object pnlCampos: TPanel
    Left = 0
    Top = 34
    Width = 511
    Height = 127
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 507
    DesignSize = (
      511
      127)
    object Label2: TLabel
      Left = 41
      Top = 22
      Width = 39
      Height = 15
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 34
      Top = 58
      Width = 46
      Height = 15
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 15
      Top = 93
      Width = 65
      Height = 15
      Caption = 'Quantidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 216
      Top = 93
      Width = 73
      Height = 15
      Caption = 'Valor unit'#225'rio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object btExcluirItem: TBitBtn
      Left = 458
      Top = 84
      Width = 25
      Height = 25
      Hint = 'Excluir produto [DEL]'
      Anchors = [akTop, akRight]
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
        6666666666666666666666660000666666666666666666666666666666666666
        0000666666666666666666666666666666666666000066666666666666666666
        6666666666666666000066666666666666666666666666666666666600006666
        6666666666666666666666666666666600006666666666666666666666666666
        6666666600006666FFFFFFFFFFF6666666FFFFFFFFFFF6660000666811111111
        11F66666687777777777F666000066681111111111F66666687777777777F666
        0000666888888888886666666888888888886666000066666666666666666666
        6666666666666666000066666666666666666666666666666666666600006666
        6666666666666666666666666666666600006666666666666666666666666666
        6666666600006666666666666666666666666666666666660000666666666666
        6666666666666666666666660000666666666666666666666666666666666666
        0000}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = btExcluirItemClick
      ExplicitLeft = 454
    end
    object edtIdCliente: TEdit
      Left = 82
      Top = 14
      Width = 61
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 1
      OnChange = edtIdClienteChange
      OnExit = edtIdClienteExit
    end
    object edtIdProduto: TEdit
      Left = 82
      Top = 50
      Width = 61
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 2
      OnChange = edtIdProdutoChange
      OnExit = edtIdProdutoExit
    end
    object edtQtd: TEdit
      Left = 82
      Top = 85
      Width = 115
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 3
      Text = '0'
      OnExit = edtQtdExit
    end
    object edtValor: TEdit
      Left = 291
      Top = 85
      Width = 118
      Height = 23
      Hint = 'Preencha apenas com n'#250'meros.'
      Alignment = taRightJustify
      MaxLength = 17
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Text = '0,00'
      OnExit = edtValorExit
    end
    object edtNomeCliente: TEdit
      Left = 149
      Top = 14
      Width = 334
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      Color = cl3DLight
      Enabled = False
      TabOrder = 5
      ExplicitWidth = 330
    end
    object edtDescProduto: TEdit
      Left = 149
      Top = 50
      Width = 334
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      Color = cl3DLight
      Enabled = False
      TabOrder = 6
      ExplicitWidth = 330
    end
    object btAdicionarItem: TBitBtn
      Left = 427
      Top = 84
      Width = 25
      Height = 25
      Hint = 'Adicionar produto [INS]'
      Anchors = [akTop, akRight]
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
        6666666666666666666666660000666666666666666666666666666666666666
        0000666666666666666666666666666666666666000066666666FFF666666666
        666666FFF666666600006666666822F66666666666666877F666666600006666
        666822F66666666666666877F666666600006666666822F66666666666666877
        F666666600006666FFF622FFFFF6666666FFF777FFFFF6660000666822222222
        22F66666687777777777F666000066682222222222F66666687777777777F666
        000066688888226888666666688888777888666600006666666822F666666666
        66666877F666666600006666666822F66666666666666877F666666600006666
        666822F66666666666666877F666666600006666666888666666666666666888
        6666666600006666666666666666666666666666666666660000666666666666
        6666666666666666666666660000666666666666666666666666666666666666
        0000}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      TabStop = False
      OnClick = btAdicionarItemClick
      ExplicitLeft = 423
    end
  end
  object pnlLista: TPanel
    Left = 0
    Top = 161
    Width = 511
    Height = 327
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 507
    ExplicitHeight = 326
    object dbgLista: TDBGrid
      Left = 1
      Top = 1
      Width = 509
      Height = 325
      Align = alClient
      DataSource = dsProdutos
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
  object pnlConfirmar: TPanel
    Left = 0
    Top = 488
    Width = 511
    Height = 34
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 487
    ExplicitWidth = 507
    DesignSize = (
      511
      34)
    object lblTotal: TLabel
      Left = 125
      Top = 8
      Width = 49
      Height = 19
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 15
      Top = 8
      Width = 104
      Height = 19
      Caption = 'Total do Pedido:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object btCancelar: TBitBtn
      Left = 431
      Top = 5
      Width = 25
      Height = 25
      Hint = 'Cancelar inclus'#227'o/altera'#231#227'o [ESC]'
      Anchors = [akRight, akBottom]
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
        6666666666666666666666660000666668666666666666666666666666666666
        0000666608866666666666666686666666666666000066691086666688666666
        6888666666666666000066691088666008866666688866666886666600006669
        1108869110866666688886668888666600006666911089111066666666888868
        8888666600006666911191110666666666888888888666660000666669111110
        6666666666688888886666660000666666911108866666666666888886666666
        0000666666911110866666666666888888666666000066666911011088666666
        6668888888666666000066666910691108866666666888688886666600006666
        9106669110886666668886668888666600006666910666691108666666888666
        6888866600006666696666669106666666686666668886660000666666666666
        6966666666666666666866660000666666666666666666666666666666666666
        0000}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = btCancelarClick
      ExplicitLeft = 427
    end
    object btConfirmar: TBitBtn
      Left = 462
      Top = 5
      Width = 25
      Height = 25
      Hint = 'Confirmar inclus'#227'o/altera'#231#227'o [F12]'
      Anchors = [akRight, akBottom]
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
        6666666666666666666666660000666666666666666666666666666666666666
        0000666666886666666666666666666666666666000066666CC8866666666666
        666888666666666600006666C22C88666666666666888886666666660000666A
        2222C886666666666888888866666666000066A222222C886666666668888888
        86666666000066A222A222C8866666666888688888666666000066A22C8A222C
        866666666888868888866666000066A22C86A22C886666666888866888866666
        0000666A2C666A22C8866666668866668888666600006666AA6666A22C886666
        6666666668888666000066666666666A22C88666666666666688886600006666
        66666666A22C8666666666666668888600006666666666666A2C866666666666
        66668886000066666666666666AC666666666666666668660000666666666666
        6666666666666666666666660000666666666666666666666666666666666666
        0000}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
      OnClick = btConfirmarClick
      ExplicitLeft = 458
    end
  end
  object dsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 40
    Top = 217
  end
  object cdsProdutos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 120
    Top = 217
    object cdsProdutosID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object cdsProdutosID_PEDIDO: TIntegerField
      FieldName = 'ID_PEDIDO'
      Visible = False
    end
    object cdsProdutosID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
      Visible = False
    end
    object cdsProdutosPRODUTO_DESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 40
      FieldName = 'PRODUTO_DESCRICAO'
      Size = 100
    end
    object cdsProdutosQUANTIDADE: TIntegerField
      DisplayLabel = 'Quantidade'
      DisplayWidth = 12
      FieldName = 'QUANTIDADE'
    end
    object cdsProdutosPRECO: TFloatField
      DisplayLabel = 'Pre'#231'o'
      DisplayWidth = 12
      FieldName = 'PRECO'
      DisplayFormat = '###,###,###,###,##0.00'
    end
    object cdsProdutosVALOR_TOTAL: TFloatField
      DisplayLabel = 'Total'
      DisplayWidth = 12
      FieldName = 'VALOR_TOTAL'
      DisplayFormat = '###,###,###,###,##0.00'
    end
  end
  object cdsProdDel: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 120
    Top = 273
    object cdsProdDelID: TIntegerField
      FieldName = 'ID'
    end
  end
  object relPedido: TfrxReport
    Version = '2023.2.1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45093.937510775460000000
    ReportOptions.LastChange = 45093.945575671300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 72
    Top = 385
    Datasets = <
      item
        DataSet = dsRelPedido
        DataSetName = 'dsRelPedido'
      end
      item
        DataSet = dsRelItens
        DataSetName = 'dsRelItens'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      HGuides.Strings = (
        '366,61')
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 56.692950000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Top = 11.338590000000000000
          Width = 718.110715990000000000
          Height = 30.236239770000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Pedidos de Vendas')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 34.015770000000000000
        Top = 136.063080000000000000
        Width = 718.110700000000000000
        DataSet = dsRelPedido
        DataSetName = 'dsRelPedido'
        RowCount = 0
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 11.338590190000000000
          Top = 7.559058940000000000
          Width = 672.756338830000000000
          Height = 18.897644040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'N'#250'mero do Pedido: ')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 374.173470000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 642.520100000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 120.944960000000000000
        Top = 192.756030000000000000
        Width = 718.110700000000000000
        DataSet = dsRelItens
        DataSetName = 'dsRelItens'
        RowCount = 0
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 37.795299530000000000
          Top = 7.559056320000000000
          Width = 94.488254550000000000
          Height = 18.897659300000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Item 1')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 37.795300000000000000
          Top = 30.236240000000000000
          Width = 94.488254550000000000
          Height = 18.897659300000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Item 2')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 37.795300000000000000
          Top = 52.913420000000000000
          Width = 94.488254550000000000
          Height = 18.897659300000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Item 3')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 37.795300000000000000
          Top = 75.590600000000000000
          Width = 94.488254550000000000
          Height = 18.897659300000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Item 4')
          ParentFont = False
        end
      end
    end
  end
  object dsRelPedido: TfrxDBDataset
    UserName = 'dsRelPedido'
    CloseDataSource = False
    BCDToCurrency = False
    DataSetOptions = []
    Left = 144
    Top = 385
  end
  object dsRelItens: TfrxDBDataset
    UserName = 'dsRelItens'
    CloseDataSource = False
    BCDToCurrency = False
    DataSetOptions = []
    Left = 216
    Top = 385
  end
end
