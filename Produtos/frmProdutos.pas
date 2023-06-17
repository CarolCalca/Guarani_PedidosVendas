unit frmProdutos;

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

  untConnection,
  untUtils,
  untProdutosModel,
  untProdutosModelInterface,
  untProdutosController,
  untProdutosControllerInterface;

type
  TfProdutos = class(TForm)
    pnlControle: TPanel;
    pnlCampos: TPanel;
    pnlLista: TPanel;
    btNovo: TBitBtn;
    btAlterar: TBitBtn;
    btExcluir: TBitBtn;
    pnlConfirmar: TPanel;
    btCancelar: TBitBtn;
    btConfirmar: TBitBtn;
    dbgLista: TDBGrid;
    lblID: TLabel;
    lblDescricao: TLabel;
    lblMarca: TLabel;
    lblPreco: TLabel;
    edtID: TEdit;
    edtDescricao: TEdit;
    edtMarca: TEdit;
    edtPreco: TEdit;
    procedure btCancelarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtPrecoExit(Sender: TObject);
  private
    const cstModo_Leitura:  Integer = 0;
    const cstModo_Edicao:   Integer = 1;
    const cstModo_Exclusao: Integer = 2;

    var dsLista:  TDataSource;
    var qryLista: TIBQuery;

    function Conectar: Boolean;
    function Refresh: Boolean;
    procedure Incluir;
    procedure Alterar;
    procedure Excluir;
    procedure Carregar;
    procedure Cancelar;
    procedure Confirmar;
    procedure Limpar;
    procedure ControleTela(aModo: Integer);
    procedure Gravar;
    function ValidaGravar(): Boolean;
    procedure dsListaDataChange(Sender: TObject; Field: TField);
    procedure MontaGrid;
  public
    class procedure AbreCadastro(); static;
  end;

var
  fProdutos: TfProdutos;

implementation

{$R *.dfm}

class procedure TfProdutos.AbreCadastro();
var
  oForm: TfProdutos;
begin
  oForm := TfProdutos.Create(nil);
  try
    oForm.ShowModal;
  finally
    FreeAndNil(oForm);
  end;
end;

procedure TfProdutos.Alterar;
begin
  if (qryLista.FieldByName('ID').AsInteger > 0) then
    ControleTela(cstModo_Edicao);
end;

procedure TfProdutos.btAlterarClick(Sender: TObject);
begin
  Alterar;
end;

procedure TfProdutos.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfProdutos.btConfirmarClick(Sender: TObject);
begin
  Confirmar;
end;

procedure TfProdutos.btExcluirClick(Sender: TObject);
begin
  Excluir;
end;

procedure TfProdutos.btNovoClick(Sender: TObject);
begin
  Incluir;
end;

procedure TfProdutos.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_up then
    if dbgLista.Enabled then
      dbgLista.Datasource.Dataset.Prior;

  if Key = vk_down then
    if dbgLista.Enabled then
      dbgLista.Datasource.Dataset.Next;

  if Key = vk_delete then
    if btExcluir.Enabled then
      Excluir;

  if Key = vk_return then
    if btAlterar.Enabled then
      Alterar;

  if Key = vk_insert then
    if btNovo.Enabled then
      Incluir;

  if Key = vk_escape then
    if btCancelar.Enabled then
      Cancelar
    else
      Self.Close;

  if Key = vk_F12 then
    if btConfirmar.Enabled then
      Confirmar;
end;

procedure TfProdutos.FormShow(Sender: TObject);
begin
  Conectar;
  Refresh;
  ControleTela(cstModo_Leitura);
end;

procedure TfProdutos.Gravar;
var
  oProdutos: IProdutos;
begin
  qryLista.DisableControls;

  try
    try
      oProdutos := untProdutosModel.TProdutos.New(StrToInt(edtID.Text),
                                                  edtDescricao.Text,
                                                  edtMarca.Text,
                                                  StrToFloatDef(edtPreco.Text, 0));

      if (oProdutos.GetId > 0) then
        TProdutosController.New.Alterar(oProdutos)
      else
        TProdutosController.New.Inserir(oProdutos);

      TConnection.Commit;

      Refresh;
      Carregar;
      ControleTela(cstModo_Leitura);
    except
      on E:Exception do
      begin
        ShowMessage('Não foi possível atualizar os dados.' + #13 + E.Message);
        Self.Close;
      end;
    end;
  finally
    qryLista.EnableControls;
  end;
end;

procedure TfProdutos.Incluir;
begin
  Limpar;
  edtID.Text := '0';
  ControleTela(cstModo_Edicao);
end;

procedure TfProdutos.Limpar;
begin
  edtID.Clear;
  edtDescricao.Clear;
  edtMarca.Clear;
  edtPreco.Text := '0,00';
end;

procedure TfProdutos.MontaGrid;
begin
  if Assigned(qryLista) then
  begin
    qryLista.FieldByName('ID').DisplayLabel := 'ID';
    qryLista.FieldByName('ID').DisplayWidth := 15;

    qryLista.FieldByName('DESCRICAO').DisplayLabel := 'Descrição';
    qryLista.FieldByName('DESCRICAO').DisplayWidth := 45;

    qryLista.FieldByName('MARCA').DisplayLabel := 'Marca';
    qryLista.FieldByName('MARCA').DisplayWidth := 25;

    qryLista.FieldByName('PRECO').DisplayLabel := 'Preço';
    qryLista.FieldByName('PRECO').DisplayWidth := 15;
  end;
end;

procedure TfProdutos.Cancelar;
begin
  Refresh;
  ControleTela(cstModo_Leitura);
end;

procedure TfProdutos.Carregar;
begin
  Limpar;

  if (qryLista.FieldByName('ID').AsInteger > 0) then
  begin
    edtID.Text := qryLista.FieldByName('ID').AsString;
    edtDescricao.Text := qryLista.FieldByName('DESCRICAO').AsString;
    edtMarca.Text := qryLista.FieldByName('MARCA').AsString;
    edtPreco.Text := TUtils.formatarPreco(qryLista.FieldByName('PRECO').AsFloat);
  end;
end;

function TfProdutos.Conectar: Boolean;
begin
  Result := False;

  try
    qryLista := TProdutosController.Listar();

    dsLista := TDataSource.Create(nil);
    dsLista.DataSet := qryLista;
    dsLista.OnDataChange := dsListaDataChange;

    dbgLista.DataSource := dsLista;

    Result := True;
  except
    on E:Exception do
    begin
      ShowMessage('Não foi possível carregar os dados.' + #13 + E.Message);
      Self.Close;
    end;
  end;
end;

procedure TfProdutos.Confirmar;
begin
  if ValidaGravar then
    Gravar;
end;

procedure TfProdutos.ControleTela(aModo: Integer);
begin
  if (aModo = cstModo_Leitura) then
  begin
    btNovo.Enabled := True;
    btAlterar.Enabled := (qryLista.FieldByName('ID').AsInteger > 0);
    btExcluir.Enabled := (qryLista.FieldByName('ID').AsInteger > 0);

    dbgLista.Enabled := True;

    btCancelar.Enabled  := False;
    btConfirmar.Enabled := False;

    lblDescricao.Enabled := False;
    lblMarca.Enabled     := False;
    lblPreco.Enabled     := False;

    edtDescricao.Enabled := False;
    edtMarca.Enabled     := False;
    edtPreco.Enabled     := False;

    dbgLista.SetFocus;
  end
  else if (aModo = cstModo_Edicao) then
  begin
    btNovo.Enabled := False;
    btAlterar.Enabled := False;
    btExcluir.Enabled := False;

    dbgLista.Enabled := False;

    btCancelar.Enabled  := True;
    btConfirmar.Enabled := True;

    lblDescricao.Enabled := True;
    lblMarca.Enabled     := True;
    lblPreco.Enabled     := True;

    edtDescricao.Enabled := True;
    edtMarca.Enabled     := True;
    edtPreco.Enabled     := True;

    edtDescricao.SetFocus;
  end
  else if (aModo = cstModo_Exclusao) then
  begin
    btNovo.Enabled := False;
    btAlterar.Enabled := False;
    btExcluir.Enabled := False;

    dbgLista.Enabled := False;

    btCancelar.Enabled  := False;
    btConfirmar.Enabled := False;

    lblDescricao.Enabled := False;
    lblMarca.Enabled     := False;
    lblPreco.Enabled     := False;

    edtDescricao.Enabled := False;
    edtMarca.Enabled     := False;
    edtPreco.Enabled     := False;
  end;
end;

procedure TfProdutos.dsListaDataChange(Sender: TObject; Field: TField);
begin
  Carregar;
end;

procedure TfProdutos.edtPrecoExit(Sender: TObject);
begin
  edtPreco.Text := TUtils.formatarPreco(edtPreco.Text);
end;

procedure TfProdutos.Excluir;
begin
  if (qryLista.FieldByName('ID').AsInteger > 0) then
  begin
    ControleTela(cstModo_Exclusao);

    if MessageDlg('Deseja excluir o Produto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      TProdutosController.New.Excluir(qryLista.FieldByName('ID').AsInteger);
      Refresh;
    end;

    ControleTela(cstModo_Leitura);
  end;
end;

function TfProdutos.Refresh: Boolean;
begin
  Result := False;

  qryLista.DisableControls;

  try
    try
      qryLista.Close;
      qryLista.Open;
      qryLista.First;

      Carregar;
      MontaGrid;

      Result := True;
    except
      on E:Exception do
      begin
        ShowMessage('Não foi possível atualizar os dados.' + #13 + E.Message);
        Self.Close;
      end;
    end;
  finally
    qryLista.EnableControls;
  end;
end;

function TfProdutos.ValidaGravar: Boolean;
begin
  Result := False;

  if (edtDescricao.Text = EmptyStr) then
  begin
    MessageDlg('Por favor, preencha a descrição.', mtWarning, [mbOk], 0, mbOk);
    edtDescricao.SetFocus;
  end
  else if (edtMarca.Text = EmptyStr) then
  begin
    MessageDlg('Por favor, preencha a marca.', mtWarning, [mbOk], 0, mbOk);
    edtMarca.SetFocus;
  end
  else if (StrToFloatDef(edtPreco.Text, 0) = 0) then
  begin
    MessageDlg('Por favor, preencha o preço.', mtWarning, [mbOk], 0, mbOk);
    edtPreco.SetFocus;
  end
  else
    Result := True;
end;

end.
