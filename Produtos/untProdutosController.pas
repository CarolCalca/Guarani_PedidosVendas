unit untProdutosController;

interface

uses
  IBX.IBQuery,
  System.SysUtils,
  System.UITypes,
  Vcl.Dialogs,

  untConnection,
  untProdutosModel,
  untProdutosModelInterface,
  untProdutosControllerInterface;

type
  TProdutosController = class(TInterfacedObject, IProdutosController)
  private
    class function getId(): Integer;
  public
    function Inserir(oProdutos: IProdutos): Boolean;
    function Alterar(oProdutos: IProdutos): Boolean;
    function Excluir(aID: Integer): Boolean;
    function Carregar(aID: Integer): IProdutos;

    class function Listar(): TIBQuery; static;
    class function New():TProdutosController; static;
  end;

implementation

class function TProdutosController.getId: Integer;
var
  qAux: TIBQuery;
begin
  Result := 0;

  qAux := TConnection.NewQuery('SELECT MAX(ID) AS ID_ATUAL FROM PRODUTOS');

  try
    try
      qAux.Open;

      if not (qAux.IsEmpty) then
        Result := qAux.FieldByName('ID_ATUAL').AsInteger + 1
      else
        Result := 1;

    except on E:Exception do
      MessageDlg('Erro ao pesquisar a chave do Produto!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAux);
  end;
end;

function TProdutosController.Inserir(oProdutos: IProdutos): Boolean;
var
  qAux: TIBQuery;
  vId: Integer;
begin
  Result := False;

  vId := Self.getId();

  if (vId > 0) then
  begin

    qAux := TConnection.NewQuery('INSERT INTO PRODUTOS (ID, DESCRICAO, MARCA, PRECO) '+
                                 'VALUES (:ID, :DESCRICAO, :MARCA, :PRECO)');

    try
      try
        qAux.ParamByName('ID').AsInteger := vId;
        qAux.ParamByName('DESCRICAO').AsString := oProdutos.GetDescricao();
        qAux.ParamByName('MARCA').AsString := oProdutos.GetMarca();
        qAux.ParamByName('PRECO').AsFloat := oProdutos.GetPreco();
        qAux.ExecSQL;

        Result := True;
      except on E:Exception do
        MessageDlg('Erro ao inserir o Produto!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
      end;
    finally
      FreeAndNil(qAux);
    end;
  end;
end;

function TProdutosController.Alterar(oProdutos: IProdutos): Boolean;
var
  qAux: TIBQuery;
  I: Integer;
begin
  Result := False;

  qAux := TConnection.NewQuery('UPDATE PRODUTOS '+
                               '   SET DESCRICAO = :DESCRICAO, '+
                               '       MARCA = :MARCA, '+
                               '       PRECO = :PRECO '+
                               ' WHERE ID = :ID');

  try
    try
      qAux.ParamByName('ID').AsInteger := oProdutos.GetID();
      qAux.ParamByName('DESCRICAO').AsString := oProdutos.GetDescricao();
      qAux.ParamByName('MARCA').AsString := oProdutos.GetMarca();
      qAux.ParamByName('PRECO').AsFloat := oProdutos.GetPreco();
      qAux.ExecSQL;

      Result := True;
    except on E:Exception do
      MessageDlg('Erro ao alterar o Produto!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAux);
  end;
end;

function TProdutosController.Excluir(aID: Integer): Boolean;
var
  qAux: TIBQuery;
begin
  Result := False;

  qAux := TConnection.NewQuery('DELETE FROM PRODUTOS WHERE ID = :ID');

  try
    try
      qAux.ParamByName('ID').AsInteger := aID;
      qAux.ExecSQL;

      Result := True;
    except on E:Exception do
      MessageDlg('Erro ao excluir o Produto!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAux);
  end;
end;

function TProdutosController.Carregar(aID: Integer): IProdutos;
var
  qAux: TIBQuery;
begin
  Result := TProdutos.New();

  qAux := TConnection.NewQuery('SELECT * FROM PRODUTOS WHERE ID = :ID');

  try
    try
      qAux.ParamByName('ID').AsInteger := aID;
      qAux.Open;

      if not qAux.IsEmpty then
      begin
        if Assigned(qAux.FindField('ID')) then
          Result.SetID(qAux.FieldByName('ID').AsInteger);
        if Assigned(qAux.FindField('DESCRICAO')) then
          Result.SetDescricao(qAux.FieldByName('DESCRICAO').AsString);
        if Assigned(qAux.FindField('MARCA')) then
          Result.SetMarca(qAux.FieldByName('MARCA').AsString);
        if Assigned(qAux.FindField('PRECO')) then
          Result.SetPreco(qAux.FieldByName('PRECO').AsFloat);
      end;

    except on E:Exception do
      MessageDlg('Erro ao carregar o Produto!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAux);
  end;
end;

class function TProdutosController.New: TProdutosController;
begin
  Result := TProdutosController.Create;
end;

class function TProdutosController.Listar: TIBQuery;
begin
  Result := TConnection.NewQuery('SELECT ID, DESCRICAO, MARCA, PRECO '+
                                 '  FROM PRODUTOS');
end;


end.
