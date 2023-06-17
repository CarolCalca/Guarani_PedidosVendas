unit frmClientes;

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
  untClientesModel,
  untClientesModelInterface,
  untClientesController,
  untClientesControllerInterface;

type
  TfClientes = class(TForm)
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
    lblNomeFantasia: TLabel;
    lblRazaoSocial: TLabel;
    lblCNPJ: TLabel;
    lblEndereco: TLabel;
    lblTelefone: TLabel;
    edtID: TEdit;
    edtNomeFantasia: TEdit;
    edtRazaoSocial: TEdit;
    edtEndereco: TEdit;
    mskCNPJ: TMaskEdit;
    mskTelefone: TMaskEdit;
    procedure btCancelarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
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
  fClientes: TfClientes;

implementation

{$R *.dfm}

class procedure TfClientes.AbreCadastro();
var
  oForm: TfClientes;
begin
  oForm := TfClientes.Create(nil);
  try
    oForm.ShowModal;
  finally
    FreeAndNil(oForm);
  end;
end;

procedure TfClientes.Alterar;
begin
  if (qryLista.FieldByName('ID').AsInteger > 0) then
    ControleTela(cstModo_Edicao);
end;

procedure TfClientes.btAlterarClick(Sender: TObject);
begin
  Alterar;
end;

procedure TfClientes.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfClientes.btConfirmarClick(Sender: TObject);
begin
  Confirmar;
end;

procedure TfClientes.btExcluirClick(Sender: TObject);
begin
  Excluir;
end;

procedure TfClientes.btNovoClick(Sender: TObject);
begin
  Incluir;
end;

procedure TfClientes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TfClientes.FormShow(Sender: TObject);
begin
  Conectar;
  Refresh;
  ControleTela(cstModo_Leitura);
end;

procedure TfClientes.Gravar;
var
  oClientes: IClientes;
begin
  qryLista.DisableControls;

  try
    try
      oClientes := untClientesModel.TClientes.New(StrToInt(edtID.Text),
                                                  edtNomeFantasia.Text,
                                                  edtRazaoSocial.Text,
                                                  mskCNPJ.Text,
                                                  edtEndereco.Text,
                                                  mskTelefone.Text);

      if (oClientes.GetId > 0) then
        TClientesController.New.Alterar(oClientes)
      else
        TClientesController.New.Inserir(oClientes);

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

procedure TfClientes.Incluir;
begin
  Limpar;
  edtID.Text := '0';
  ControleTela(cstModo_Edicao);
end;

procedure TfClientes.Limpar;
begin
  edtID.Clear;
  edtNomeFantasia.Clear;
  edtRazaoSocial.Clear;
  mskCNPJ.Clear;
  edtEndereco.Clear;
  mskTelefone.Clear;
end;

procedure TfClientes.MontaGrid;
begin
  if Assigned(qryLista) then
  begin
    qryLista.FieldByName('ID').DisplayLabel := 'ID';
    qryLista.FieldByName('ID').DisplayWidth := 15;

    qryLista.FieldByName('NOME_FANTASIA').DisplayLabel := 'Nome Fantasia';
    qryLista.FieldByName('NOME_FANTASIA').DisplayWidth := 40;

    qryLista.FieldByName('RAZAO_SOCIAL').DisplayLabel := 'Razão Social';
    qryLista.FieldByName('RAZAO_SOCIAL').DisplayWidth := 40;

    qryLista.FieldByName('CNPJ').DisplayLabel := 'CNPJ';
    qryLista.FieldByName('CNPJ').DisplayWidth := 15;

    qryLista.FieldByName('ENDERECO').DisplayLabel := 'Endereço';
    qryLista.FieldByName('ENDERECO').DisplayWidth := 60;

    qryLista.FieldByName('TELEFONE').DisplayLabel := 'Telefone';
    qryLista.FieldByName('TELEFONE').DisplayWidth := 15;
  end;
end;

procedure TfClientes.Cancelar;
begin
  Refresh;
  ControleTela(cstModo_Leitura);
end;

procedure TfClientes.Carregar;
begin
  Limpar;

  if (qryLista.FieldByName('ID').AsInteger > 0) then
  begin
    edtID.Text := qryLista.FieldByName('ID').AsString;
    edtNomeFantasia.Text := qryLista.FieldByName('NOME_FANTASIA').AsString;
    edtRazaoSocial.Text := qryLista.FieldByName('RAZAO_SOCIAL').AsString;
    mskCNPJ.Text := qryLista.FieldByName('CNPJ').AsString;
    edtEndereco.Text := qryLista.FieldByName('ENDERECO').AsString;
    mskTelefone.Text := qryLista.FieldByName('TELEFONE').AsString;
  end;
end;

function TfClientes.Conectar: Boolean;
begin
  Result := False;

  try
    qryLista := TClientesController.Listar();

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

procedure TfClientes.Confirmar;
begin
  if ValidaGravar then
    Gravar;
end;

procedure TfClientes.ControleTela(aModo: Integer);
begin
  if (aModo = cstModo_Leitura) then
  begin
    btNovo.Enabled := True;
    btAlterar.Enabled := (qryLista.FieldByName('ID').AsInteger > 0);
    btExcluir.Enabled := (qryLista.FieldByName('ID').AsInteger > 0);

    dbgLista.Enabled := True;

    btCancelar.Enabled  := False;
    btConfirmar.Enabled := False;

    lblNomeFantasia.Enabled := False;
    lblRazaoSocial.Enabled  := False;
    lblCNPJ.Enabled         := False;
    lblEndereco.Enabled     := False;
    lblTelefone.Enabled     := False;

    edtNomeFantasia.Enabled := False;
    edtRazaoSocial.Enabled  := False;
    mskCNPJ.Enabled         := False;
    edtEndereco.Enabled     := False;
    mskTelefone.Enabled     := False;

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

    lblNomeFantasia.Enabled := True;
    lblRazaoSocial.Enabled  := True;
    lblCNPJ.Enabled         := True;
    lblEndereco.Enabled     := True;
    lblTelefone.Enabled     := True;

    edtNomeFantasia.Enabled := True;
    edtRazaoSocial.Enabled  := True;
    mskCNPJ.Enabled         := True;
    edtEndereco.Enabled     := True;
    mskTelefone.Enabled     := True;

    edtNomeFantasia.SetFocus;
  end
  else if (aModo = cstModo_Exclusao) then
  begin
    btNovo.Enabled := False;
    btAlterar.Enabled := False;
    btExcluir.Enabled := False;

    dbgLista.Enabled := False;

    btCancelar.Enabled  := False;
    btConfirmar.Enabled := False;

    lblNomeFantasia.Enabled := False;
    lblRazaoSocial.Enabled  := False;
    lblCNPJ.Enabled         := False;
    lblEndereco.Enabled     := False;
    lblTelefone.Enabled     := False;

    edtNomeFantasia.Enabled := False;
    edtRazaoSocial.Enabled  := False;
    mskCNPJ.Enabled         := False;
    edtEndereco.Enabled     := False;
    mskTelefone.Enabled     := False;
  end;
end;

procedure TfClientes.dsListaDataChange(Sender: TObject; Field: TField);
begin
  Carregar;
end;

procedure TfClientes.Excluir;
begin
  if (qryLista.FieldByName('ID').AsInteger > 0) then
  begin
    ControleTela(cstModo_Exclusao);

    if MessageDlg('Deseja excluir o Cliente?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      TClientesController.New.Excluir(qryLista.FieldByName('ID').AsInteger);
      Refresh;
    end;

    ControleTela(cstModo_Leitura);
  end;
end;

function TfClientes.Refresh: Boolean;
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

function TfClientes.ValidaGravar: Boolean;
begin
  Result := False;

  if (edtNomeFantasia.Text = EmptyStr) then
  begin
    MessageDlg('Por favor, preencha o nome fantasia.', mtWarning, [mbOk], 0, mbOk);
    edtNomeFantasia.SetFocus;
  end
  else if (edtRazaoSocial.Text = EmptyStr) then
  begin
    MessageDlg('Por favor, preencha a razão social.', mtWarning, [mbOk], 0, mbOk);
    edtRazaoSocial.SetFocus;
  end
  else if (mskCNPJ.Text = EmptyStr) then
  begin
    MessageDlg('Por favor, preencha o CNPJ.', mtWarning, [mbOk], 0, mbOk);
    mskCNPJ.SetFocus;
  end
  else if not TUtils.validarCNPJ(mskCNPJ.Text) then
  begin
    MessageDlg('Por favor, preencha um CNPJ válido.', mtWarning, [mbOk], 0, mbOk);
    mskCNPJ.SetFocus;
  end
  else if (edtEndereco.Text = EmptyStr) then
  begin
    MessageDlg('Por favor, preencha o endereço.', mtWarning, [mbOk], 0, mbOk);
    edtEndereco.SetFocus;
  end
  else if (mskTelefone.Text = EmptyStr) then
  begin
    MessageDlg('Por favor, preencha o telefone.', mtWarning, [mbOk], 0, mbOk);
    mskTelefone.SetFocus;
  end
  else if not TUtils.validarTelefone(mskTelefone.Text) then
  begin
    MessageDlg('Por favor, preencha um telefone válido.', mtWarning, [mbOk], 0, mbOk);
    mskTelefone.SetFocus;
  end
  else
    Result := True;
end;

end.
