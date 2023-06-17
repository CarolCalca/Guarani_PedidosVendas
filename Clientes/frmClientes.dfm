object fClientes: TfClientes
  Left = 0
  Top = 0
  Caption = 'Cadastro de Clientes'
  ClientHeight = 524
  ClientWidth = 707
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object pnlControle: TPanel
    Left = 0
    Top = 0
    Width = 707
    Height = 34
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 703
    object btNovo: TBitBtn
      Left = 7
      Top = 5
      Width = 25
      Height = 25
      Hint = 'Novo registro [INS]'
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
      TabOrder = 0
      TabStop = False
      OnClick = btNovoClick
    end
    object btAlterar: TBitBtn
      Left = 38
      Top = 5
      Width = 25
      Height = 25
      Hint = 'Alterar registro [ENTER]'
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
        6666666666666666666666660000666666666666666666666666666666666666
        0000666666666666666666666666666666666666000066666666666666666666
        6666666666666666000066666666666666666666666666666666666600006666
        6666666666666666666666666666666600006666FFFFFFFFFFF6666666FFFFFF
        FFFFF666000066684444444444F66666688888888888F6660000666844444444
        44F66666688888888888F66600006666844444444F66666666888888888F6666
        0000666668444444F66666666668888888F66666000066666684444F66666666
        666688888F66666600006666666844F66666666666666888F666666600006666
        6666886666666666666666886666666600006666666666666666666666666666
        6666666600006666666666666666666666666666666666660000666666666666
        6666666666666666666666660000666666666666666666666666666666666666
        0000}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
      OnClick = btAlterarClick
    end
    object btExcluir: TBitBtn
      Left = 69
      Top = 5
      Width = 25
      Height = 25
      Hint = 'Excluir registro [DEL]'
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
      TabOrder = 2
      TabStop = False
      OnClick = btExcluirClick
    end
  end
  object pnlCampos: TPanel
    Left = 0
    Top = 393
    Width = 707
    Height = 97
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 392
    ExplicitWidth = 703
    DesignSize = (
      707
      97)
    object lblID: TLabel
      Left = 11
      Top = 6
      Width = 11
      Height = 15
      Caption = 'ID'
      Enabled = False
    end
    object lblNomeFantasia: TLabel
      Left = 100
      Top = 6
      Width = 79
      Height = 15
      Caption = 'Nome Fantasia'
      Enabled = False
    end
    object lblRazaoSocial: TLabel
      Left = 367
      Top = 6
      Width = 65
      Height = 15
      Anchors = [akTop, akRight]
      Caption = 'Raz'#227'o Social'
      Enabled = False
      ExplicitLeft = 375
    end
    object lblCNPJ: TLabel
      Left = 11
      Top = 50
      Width = 27
      Height = 15
      Caption = 'CNPJ'
      Enabled = False
    end
    object lblEndereco: TLabel
      Left = 127
      Top = 50
      Width = 49
      Height = 15
      Caption = 'Endere'#231'o'
      Enabled = False
    end
    object lblTelefone: TLabel
      Left = 601
      Top = 50
      Width = 44
      Height = 15
      Anchors = [akTop, akRight]
      Caption = 'Telefone'
      Enabled = False
      ExplicitLeft = 609
    end
    object edtID: TEdit
      Left = 11
      Top = 21
      Width = 83
      Height = 23
      Enabled = False
      NumbersOnly = True
      TabOrder = 0
    end
    object edtNomeFantasia: TEdit
      Left = 100
      Top = 21
      Width = 261
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      MaxLength = 150
      TabOrder = 1
      ExplicitWidth = 257
    end
    object edtRazaoSocial: TEdit
      Left = 367
      Top = 21
      Width = 323
      Height = 23
      Anchors = [akTop, akRight]
      Enabled = False
      MaxLength = 150
      TabOrder = 2
      ExplicitLeft = 363
    end
    object edtEndereco: TEdit
      Left = 127
      Top = 65
      Width = 468
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      MaxLength = 300
      TabOrder = 4
      ExplicitWidth = 464
    end
    object mskCNPJ: TMaskEdit
      Left = 11
      Top = 65
      Width = 106
      Height = 23
      Enabled = False
      EditMask = '99.999.999/9999-99;0;_'
      MaxLength = 18
      TabOrder = 3
      Text = ''
    end
    object mskTelefone: TMaskEdit
      Left = 601
      Top = 65
      Width = 85
      Height = 23
      Anchors = [akTop, akRight]
      Enabled = False
      EditMask = '(99)99999-9999;0;_'
      MaxLength = 14
      TabOrder = 5
      Text = ''
      ExplicitLeft = 597
    end
  end
  object pnlLista: TPanel
    Left = 0
    Top = 34
    Width = 707
    Height = 359
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 703
    ExplicitHeight = 358
    object dbgLista: TDBGrid
      Left = 1
      Top = 1
      Width = 705
      Height = 357
      Align = alClient
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
    Top = 490
    Width = 707
    Height = 34
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 489
    ExplicitWidth = 703
    DesignSize = (
      707
      34)
    object btCancelar: TBitBtn
      Left = 630
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
      ExplicitLeft = 626
    end
    object btConfirmar: TBitBtn
      Left = 661
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
      ExplicitLeft = 657
    end
  end
end
