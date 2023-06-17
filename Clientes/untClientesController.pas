unit untClientesController;

interface

uses
  IBX.IBQuery,
  System.SysUtils,
  System.UITypes,
  Vcl.Dialogs,

  untConnection,
  untClientesModel,
  untClientesModelInterface,
  untClientesControllerInterface;

type
  TClientesController = class(TInterfacedObject, IClientesController)
  private
    class function getId(): Integer;
  public
    function Inserir(oClientes: IClientes): Boolean;
    function Alterar(oClientes: IClientes): Boolean;
    function Excluir(aID: Integer): Boolean;
    function Carregar(aID: Integer): IClientes;

    class function Listar(): TIBQuery; static;
    class function New():TClientesController; static;
  end;

implementation

class function TClientesController.getId: Integer;
var
  qAux: TIBQuery;
begin
  Result := 0;

  qAux := TConnection.NewQuery('SELECT MAX(ID) AS ID_ATUAL FROM CLIENTES');

  try
    try
      qAux.Open;

      if not (qAux.IsEmpty) then
        Result := qAux.FieldByName('ID_ATUAL').AsInteger + 1
      else
        Result := 1;

    except on E:Exception do
      MessageDlg('Erro ao pesquisar a chave do cliente!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAux);
  end;
end;

function TClientesController.Inserir(oClientes: IClientes): Boolean;
var
  qAux: TIBQuery;
  vId: Integer;
begin
  Result := False;

  vId := Self.getId();

  if (vId > 0) then
  begin

    qAux := TConnection.NewQuery('INSERT INTO CLIENTES (ID, NOME_FANTASIA, RAZAO_SOCIAL, CNPJ, ENDERECO, TELEFONE) '+
                                 'VALUES (:ID, :NOME_FANTASIA, :RAZAO_SOCIAL, :CNPJ, :ENDERECO, :TELEFONE)');

    try
      try
        qAux.ParamByName('ID').AsInteger := vId;
        qAux.ParamByName('NOME_FANTASIA').AsString := oClientes.GetNomeFantasia();
        qAux.ParamByName('RAZAO_SOCIAL').AsString := oClientes.GetRazaoSocial();
        qAux.ParamByName('CNPJ').AsString := oClientes.GetCNPJ();
        qAux.ParamByName('ENDERECO').AsString := oClientes.GetEndereco();
        qAux.ParamByName('TELEFONE').AsString := oClientes.GetTelefone();
        qAux.ExecSQL;

        Result := True;
      except on E:Exception do
        MessageDlg('Erro ao inserir o Cliente!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
      end;
    finally
      FreeAndNil(qAux);
    end;
  end;
end;

function TClientesController.Alterar(oClientes: IClientes): Boolean;
var
  qAux: TIBQuery;
  I: Integer;
begin
  Result := False;

  qAux := TConnection.NewQuery('UPDATE CLIENTES '+
                               '   SET NOME_FANTASIA = :NOME_FANTASIA, '+
                               '       RAZAO_SOCIAL = :RAZAO_SOCIAL, '+
                               '       CNPJ = :CNPJ, '+
                               '       ENDERECO = :ENDERECO,'+
                               '       TELEFONE = :TELEFONE '+
                               ' WHERE ID = :ID');

  try
    try
      qAux.ParamByName('ID').AsInteger := oClientes.GetID();
      qAux.ParamByName('NOME_FANTASIA').AsString := oClientes.GetNomeFantasia();
      qAux.ParamByName('RAZAO_SOCIAL').AsString := oClientes.GetRazaoSocial();
      qAux.ParamByName('CNPJ').AsString := oClientes.GetCNPJ();
      qAux.ParamByName('ENDERECO').AsString := oClientes.GetEndereco();
      qAux.ParamByName('TELEFONE').AsString := oClientes.GetTelefone();
      qAux.ExecSQL;

      Result := True;
    except on E:Exception do
      MessageDlg('Erro ao alterar o Cliente!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAux);
  end;
end;

function TClientesController.Excluir(aID: Integer): Boolean;
var
  qAux: TIBQuery;
begin
  Result := False;

  qAux := TConnection.NewQuery('DELETE FROM CLIENTES WHERE ID = :ID');

  try
    try
      qAux.ParamByName('ID').AsInteger := aID;
      qAux.ExecSQL;

      Result := True;
    except on E:Exception do
      MessageDlg('Erro ao excluir o Cliente!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAux);
  end;
end;

function TClientesController.Carregar(aID: Integer): IClientes;
var
  qAux: TIBQuery;
begin
  Result := TClientes.New();

  qAux := TConnection.NewQuery('SELECT * FROM CLIENTES WHERE ID = :ID');

  try
    try
      qAux.ParamByName('ID').AsInteger := aID;
      qAux.Open;

      if not qAux.IsEmpty then
      begin
        if Assigned(qAux.FindField('ID')) then
          Result.SetID(qAux.FieldByName('ID').AsInteger);
        if Assigned(qAux.FindField('NOME_FANTASIA')) then
          Result.SetNomeFantasia(qAux.FieldByName('NOME_FANTASIA').AsString);
        if Assigned(qAux.FindField('RAZAO_SOCIAL')) then
          Result.SetRazaoSocial(qAux.FieldByName('RAZAO_SOCIAL').AsString);
        if Assigned(qAux.FindField('CNPJ')) then
          Result.SetCNPJ(qAux.FieldByName('CNPJ').AsString);
        if Assigned(qAux.FindField('ENDERECO')) then
          Result.SetEndereco(qAux.FieldByName('ENDERECO').AsString);
        if Assigned(qAux.FindField('TELEFONE')) then
          Result.SetTelefone(qAux.FieldByName('TELEFONE').AsString);
      end;

    except on E:Exception do
      MessageDlg('Erro ao carregar o Cliente!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAux);
  end;
end;

class function TClientesController.New: TClientesController;
begin
  Result := TClientesController.Create;
end;

class function TClientesController.Listar: TIBQuery;
begin
  Result := TConnection.NewQuery('SELECT ID, NOME_FANTASIA, RAZAO_SOCIAL, '+
                                     '       CNPJ, ENDERECO, TELEFONE '+
                                     '  FROM CLIENTES');
end;


end.
