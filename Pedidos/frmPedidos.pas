unit frmPedidos;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.Mask,
  IBX.IBCustomDataSet,
  IBX.IBQuery,
  IBX.IBDatabase,
  IBX.IBTable,

  untConnection,
  untUtils,

  untClientesModel,
  untClientesModelInterface,
  untClientesController,
  untClientesControllerInterface,

  untProdutosModel,
  untProdutosModelInterface,
  untProdutosController,
  untProdutosControllerInterface,

  untPedidosModel,
  untPedidosModelInterface,
  untPedidosController,
  untPedidosControllerInterface,

  untPedidosItensModel,
  untPedidosItensModelInterface,
  untPedidosItensController,
  untPedidosItensControllerInterface, Datasnap.DBClient, frxClass, frxDBSet,
  frCoreClasses;

type
  TfPedidos = class(TForm)
    pnlControle: TPanel;
    pnlCampos: TPanel;
    pnlLista: TPanel;
    btCarregarPedido: TBitBtn;
    btExcluirPedido: TBitBtn;
    pnlConfirmar: TPanel;
    btCancelar: TBitBtn;
    btConfirmar: TBitBtn;
    dbgLista: TDBGrid;
    btExcluirItem: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtIdCliente: TEdit;
    edtIdProduto: TEdit;
    edtQtd: TEdit;
    edtValor: TEdit;
    edtNomeCliente: TEdit;
    edtDescProduto: TEdit;
    lblTotal: TLabel;
    Label6: TLabel;
    btAdicionarItem: TBitBtn;
    dsProdutos: TDataSource;
    cdsProdutos: TClientDataSet;
    cdsProdDel: TClientDataSet;
    cdsProdDelID: TIntegerField;
    cdsProdutosID: TIntegerField;
    cdsProdutosID_PEDIDO: TIntegerField;
    cdsProdutosID_PRODUTO: TIntegerField;
    cdsProdutosPRODUTO_DESCRICAO: TStringField;
    cdsProdutosQUANTIDADE: TIntegerField;
    cdsProdutosPRECO: TFloatField;
    cdsProdutosVALOR_TOTAL: TFloatField;
    relPedido: TfrxReport;
    dsRelPedido: TfrxDBDataset;
    dsRelItens: TfrxDBDataset;
    procedure btCancelarClick(Sender: TObject);
    procedure btExcluirItemClick(Sender: TObject);
    procedure btCarregarPedidoClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure btExcluirPedidoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtIdClienteExit(Sender: TObject);
    procedure edtIdProdutoExit(Sender: TObject);
    procedure edtIdProdutoChange(Sender: TObject);
    procedure edtIdClienteChange(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
    procedure edtQtdExit(Sender: TObject);
    procedure btAdicionarItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    const cstModo_Leitura:  Integer = 0;
    const cstModo_Edicao:   Integer = 1;
    const cstModo_Exclusao: Integer = 2;

    var dsLista:  TDataSource;
    var qryLista: TIBQuery;

    procedure ExcluirPedido;
    procedure IncluirItem;
    function ValidaItem(): Boolean;
    procedure ExcluirItem;
    procedure Carregar;
    procedure Cancelar;
    procedure Confirmar;
    procedure Limpar;
    procedure Imprimir(aIdPedido: Integer);
    procedure ControleTela(aModo: Integer);
    procedure Gravar;
    function ValidaGravar(): Boolean;
    function CalcVlrTotal: Double;
    function RetornaCliente(aId: String): String;
    function RetornaProduto(aId: String): String;
    function RetornaPreco(aId: String): Double;
  public
    class procedure AbreCadastro(); static;
  end;

var
  fPedidos: TfPedidos;

implementation

{$R *.dfm}

class procedure TfPedidos.AbreCadastro();
var
  oForm: TfPedidos;
begin
  oForm := TfPedidos.Create(nil);
  try
    oForm.ShowModal;
  finally
    FreeAndNil(oForm);
  end;
end;

procedure TfPedidos.btCarregarPedidoClick(Sender: TObject);
begin
  Carregar;
end;

procedure TfPedidos.btAdicionarItemClick(Sender: TObject);
begin
  IncluirItem;
end;

procedure TfPedidos.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfPedidos.btConfirmarClick(Sender: TObject);
begin
  Confirmar;
end;

procedure TfPedidos.btExcluirPedidoClick(Sender: TObject);
begin
  ExcluirPedido;
end;

procedure TfPedidos.btExcluirItemClick(Sender: TObject);
begin
  ExcluirItem;
end;

procedure TfPedidos.FormCreate(Sender: TObject);
begin
  cdsProdutos.CreateDataSet;
  cdsProdDel.CreateDataSet;
end;

procedure TfPedidos.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_up then
    if dbgLista.Enabled then
      dbgLista.Datasource.Dataset.Prior;

  if Key = vk_down then
    if dbgLista.Enabled then
      dbgLista.Datasource.Dataset.Next;

  if Key = vk_F1 then
    if btCarregarPedido.Enabled then
      Carregar;

  if Key = vk_F2 then
    if btExcluirPedido.Enabled then
      ExcluirPedido;

  if Key = vk_insert then
    if btAdicionarItem.Enabled then
      IncluirItem;

  if Key = vk_delete then
    if btExcluirItem.Enabled then
      ExcluirItem;

  if Key = vk_escape then
    if btCancelar.Enabled then
      Cancelar
    else
      Self.Close;

  if Key = vk_F12 then
    if btConfirmar.Enabled then
      Confirmar;
end;

procedure TfPedidos.FormShow(Sender: TObject);
begin
  Limpar;
end;

procedure TfPedidos.Gravar;
var
  oPedidosItens: IPedidosItens;
  oPedido: IPedidos;
  vIdPedido: Integer;
begin

  cdsProdutos.DisableControls;
  cdsProdDel.DisableControls;

  try
    try
      cdsProdDel.First;
      while not cdsProdDel.Eof do
      begin
        TPedidosItensController.New.Excluir(cdsProdDel.FieldByName('ID').AsInteger);
        cdsProdDel.Next;
      end;

      cdsProdutos.First;
      vIdPedido := cdsProdutos.FieldByName('ID_PEDIDO').AsInteger;

      oPedido := TPedidos.New;

      while not cdsProdutos.Eof do
      begin
        oPedidosItens := TPedidosItens.New(cdsProdutos.FieldByName('ID').AsInteger,
                                           cdsProdutos.FieldByName('ID_PEDIDO').AsInteger,
                                           cdsProdutos.FieldByName('ID_PRODUTO').AsInteger,
                                           cdsProdutos.FieldByName('QUANTIDADE').AsInteger,
                                           cdsProdutos.FieldByName('PRECO').AsFloat);

        oPedido.GetPedidosItens.Add(oPedidosItens);

        cdsProdutos.Next;
      end;

      oPedido.SetId(vIdPedido);
      oPedido.SetIdCliente(StrToInt(edtIdCliente.Text));
      oPedido.SetValorTotal(CalcVlrTotal);
      oPedido.SetDataHora(Now());

      if (vIdPedido > 0) then
        TPedidosController.New.Alterar(oPedido)
      else
        vIdPedido := TPedidosController.New.Inserir(oPedido);

      TConnection.Commit;

      Imprimir(vIdPedido);

      Limpar;
    except on E:Exception do
      begin
        TConnection.Rollback;
        MessageDlg('Erro ao gravar o pedido!', mtError, [mbOk], 0, mbOk);
      end;
    end;
  finally
    cdsProdutos.EnableControls;
    cdsProdDel.EnableControls;
  end;
end;

procedure TfPedidos.Imprimir(aIdPedido: Integer);
begin
  dsRelPedido.DataSet := TPedidosController.RetornaPedido(aIdPedido);
  dsRelItens.DataSet  := TPedidosItensController.Listar(aIdPedido);
  relPedido.previ
end;

procedure TfPedidos.IncluirItem;
begin
  if ValidaItem then
  begin
    cdsProdutos.DisableControls;

    try
      try
        if not (cdsProdutos.State in [dsEdit]) then
        begin
          cdsProdutos.Append;
          cdsProdutos.FieldByName('ID').AsInteger := 0;
          cdsProdutos.FieldByName('ID_PEDIDO').AsInteger := 0;
          cdsProdutos.FieldByName('ID_PRODUTO').AsInteger := StrToInt(edtIdProduto.Text);
          cdsProdutos.FieldByName('PRODUTO_DESCRICAO').AsString := edtDescProduto.Text;
        end;

        cdsProdutos.FieldByName('QUANTIDADE').AsInteger := StrToInt(edtQtd.Text);
        cdsProdutos.FieldByName('PRECO').AsFloat := StrToFloat(edtValor.Text);
        cdsProdutos.FieldByName('VALOR_TOTAL').AsString := TUtils.formatarPreco((StrToFloat(edtValor.Text) * StrToInt(edtQtd.Text)));
        cdsProdutos.Post;

        CalcVlrTotal;

        edtIdProduto.SetFocus;

      except on E:Exception do
        begin
          MessageDlg('Erro ao incluir/alterar o produto!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
          edtIdProduto.SetFocus;
        end;
      end;
    finally
      cdsProdutos.EnableControls;
    end;
  end;
end;

procedure TfPedidos.Limpar;
begin
  edtIdCliente.Text := EmptyStr;
  edtIdClienteExit(nil);
  edtIdProduto.Text := EmptyStr;
  edtIdProdutoExit(nil);
  edtQtd.Text := '0';
  edtValor.Text := '0,00';
  cdsProdutos.EmptyDataSet;
  cdsProdDel.EmptyDataSet;

  CalcVlrTotal;

  edtIdCliente.SetFocus;
end;

function TfPedidos.CalcVlrTotal: Double;
begin
  Result := 0;

  cdsProdutos.DisableControls;

  try
    cdsProdutos.First;
    while not cdsProdutos.Eof do
    begin
      Result := Result + cdsProdutos.FieldByName('VALOR_TOTAL').AsFloat;

      cdsProdutos.Next;
    end;

    lblTotal.Caption := 'R$ ' + FormatFloat(TUtils.cVlrMask, Result);
  finally
    cdsProdutos.EnableControls;
  end;
end;

procedure TfPedidos.Cancelar;
begin
  Limpar;
end;

procedure TfPedidos.Carregar;
var
  I, vId: Integer;
  oPedido: IPedidos;
begin
  Limpar;

  try
    vId := StrToInt(InputBox('Carregar pedido', 'Digite o número do pedido que deseja carregar:', '0'));

    if (vId > 0) then
    begin
      oPedido := TPedidosController.New.Carregar(vId);

      if (oPedido.GetId > 0) then
      begin
        edtIdCliente.Text := IntToStr(oPedido.GetIdCliente);
        edtIdClienteExit(edtIdCliente);

        for I := 0 to pred(oPedido.GetPedidosItens.Count) do
        begin
          cdsProdutos.Append;
          cdsProdutos.FieldByName('ID').AsInteger := oPedido.GetPedidosItens[I].GetId;
          cdsProdutos.FieldByName('ID_PEDIDO').AsInteger := oPedido.GetPedidosItens[I].GetIdPedido;
          cdsProdutos.FieldByName('ID_PRODUTO').AsInteger := oPedido.GetPedidosItens[I].GetIdProduto;
          cdsProdutos.FieldByName('PRODUTO_DESCRICAO').AsString := RetornaProduto(IntToStr(oPedido.GetPedidosItens[I].GetIdProduto));
          cdsProdutos.FieldByName('QUANTIDADE').AsInteger := oPedido.GetPedidosItens[I].GetQuantidade;
          cdsProdutos.FieldByName('PRECO').AsFloat := oPedido.GetPedidosItens[I].GetPreco;
          cdsProdutos.FieldByName('VALOR_TOTAL').AsFloat := (oPedido.GetPedidosItens[I].GetQuantidade * oPedido.GetPedidosItens[I].GetPreco);
          cdsProdutos.Post;
        end;

        CalcVlrTotal;
      end
      else
        MessageDlg('Pedido não encontrado!', mtInformation, [mbOk], 0, mbOk);
    end;

  except on E:Exception do
    MessageDlg('Número de pedido inválido!', mtError, [mbOk], 0, mbOk);
  end;
end;

procedure TfPedidos.Confirmar;
begin
  if ValidaGravar then
    Gravar;
end;

procedure TfPedidos.ControleTela(aModo: Integer);
begin

end;

procedure TfPedidos.edtIdClienteChange(Sender: TObject);
begin
  btCarregarPedido.Enabled := (edtIdCliente.Text = EmptyStr);
  btExcluirPedido.Enabled := (edtIdCliente.Text = EmptyStr);

  edtNomeCliente.Text := EmptyStr;
end;

procedure TfPedidos.edtIdClienteExit(Sender: TObject);
begin
  edtNomeCliente.Text := RetornaCliente(edtIdCliente.Text);

  if (edtNomeCliente.Text = EmptyStr) then
    edtIdCliente.Text := EmptyStr;

  btAdicionarItem.Enabled := (edtNomeCliente.Text <> EmptyStr);
  btExcluirItem.Enabled := (edtNomeCliente.Text <> EmptyStr);
  btCancelar.Enabled := (edtNomeCliente.Text <> EmptyStr);
  btConfirmar.Enabled := (edtNomeCliente.Text <> EmptyStr);
end;

procedure TfPedidos.edtIdProdutoChange(Sender: TObject);
begin
  edtDescProduto.Text := EmptyStr;
  edtQtd.Text := '0';
  edtValor.Text := '0,00';
end;

procedure TfPedidos.edtIdProdutoExit(Sender: TObject);
begin
  edtDescProduto.Text := RetornaProduto(edtIdProduto.Text);
  edtValor.Text := FormatFloat(TUtils.cVlrMask, RetornaPreco(edtIdProduto.Text));

  if (edtDescProduto.Text = EmptyStr) then
    edtIdProduto.Text := EmptyStr;
end;

procedure TfPedidos.edtQtdExit(Sender: TObject);
begin
  if (edtQtd.Text = EmptyStr) then
    edtQtd.Text := '0';
end;

procedure TfPedidos.edtValorExit(Sender: TObject);
begin
  edtValor.Text := TUtils.formatarPreco(edtValor.Text);
end;

procedure TfPedidos.ExcluirItem;
begin
  if (cdsProdutos.FieldByName('ID').AsInteger > 0) then
  begin
      if MessageDlg('Deseja excluir o item do pedido?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        // adiciona em outro dataset, para excluir apenas ao gravar
        if (cdsProdutos.FieldByName('ID').AsInteger > 0) then
        begin
          cdsProdDel.Append;
          cdsProdDel.FieldByName('ID').AsInteger := cdsProdutos.FieldByName('ID').AsInteger;
          cdsProdDel.Post;
        end;

        cdsProdutos.Delete;
      end;
    end;
end;

procedure TfPedidos.ExcluirPedido;
var
  vId: Integer;
begin

  try
    vId := StrToInt(InputBox('Excluir pedido', 'Digite o número do pedido que deseja excluir:', '0'));

    if (vId > 0) then
      if TPedidosController.New.Excluir(vId) then
        MessageDlg('Pedido excluído com sucesso!', mtInformation, [mbOk], 0, mbOk);

  except on E:Exception do
    MessageDlg('Número de pedido inválido!', mtError, [mbOk], 0, mbOk);
  end;
end;

function TfPedidos.RetornaCliente(aId: String): String;
var
  oCliente: IClientes;
begin
  Result := EmptyStr;

  if (aId = EmptyStr) then
    aId := '0';

  if (aId <> '0') then
  begin
    oCliente := TClientesController.New.Carregar(StrToInt(aId));

    if (oCliente.GetId() > 0) then
      Result := oCliente.GetNomeFantasia;
  end;
end;

function TfPedidos.RetornaProduto(aId: String): String;
var
  oProduto: IProdutos;
begin
  Result := EmptyStr;

  if (aId = EmptyStr) then
    aId := '0';

  if (aId > '0') then
  begin
    oProduto := TProdutosController.New.Carregar(StrToInt(aId));

    if (oProduto.GetId() > 0) then
      Result := oProduto.GetDescricao;
  end;
end;

function TfPedidos.RetornaPreco(aId: String): Double;
var
  oProduto: IProdutos;
begin
  Result := 0;

  if (aId = EmptyStr) then
    aId := '0';

  if (aId > '0') then
  begin
    oProduto := TProdutosController.New.Carregar(StrToInt(aId));

    if (oProduto.GetId() > 0) then
      Result := oProduto.GetPreco;
  end;
end;

function TfPedidos.ValidaGravar: Boolean;
begin
  Result := False;

  if (edtIdCliente.Text = EmptyStr) then
  begin
    MessageDlg('Por favor, preencha o cliente.', mtWarning, [mbOk], 0, mbOk);
    edtIdCliente.SetFocus;
  end
  else if (cdsProdutos.IsEmpty) then
  begin
    MessageDlg('Por favor, adicione produtos ao pedido.', mtWarning, [mbOk], 0, mbOk);
    edtIdProduto.SetFocus;
  end
  else
    Result := True;
end;

function TfPedidos.ValidaItem: Boolean;
begin
  Result := False;

  if (edtIdProduto.Text = EmptyStr) then
  begin
    MessageDlg('Por favor, preencha o produto.', mtWarning, [mbOk], 0, mbOk);
    edtIdProduto.SetFocus;
  end
  else if (StrToIntDef(edtQtd.Text, 0) = 0) then
  begin
    MessageDlg('Por favor, preencha a quantidade.', mtWarning, [mbOk], 0, mbOk);
    edtQtd.SetFocus;
  end
  else if (StrToFloatDef(edtValor.Text, 0) = 0) then
  begin
    MessageDlg('Por favor, preencha o valor unitário.', mtWarning, [mbOk], 0, mbOk);
    edtValor.SetFocus;
  end
  else
    Result := True;
end;

end.
