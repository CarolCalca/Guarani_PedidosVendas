unit untPedidosItensController;

interface

uses
  IBX.IBQuery,
  System.SysUtils,
  System.UITypes,
  Vcl.Dialogs,

  untConnection,
  untPedidosItensModel,
  untPedidosItensModelInterface,
  untPedidosItensControllerInterface;

type
  TPedidosItensController = class(TInterfacedObject, IPedidosItensController)
  private
    class function getId(): Integer;
  public
    function Inserir(oPedidosItens: IPedidosItens): Boolean;
    function Alterar(oPedidosItens: IPedidosItens): Boolean;
    function Excluir(aID: Integer): Boolean;
    function ExcluirTodos(aIDPedido: Integer): Boolean;
    function Carregar(aID: Integer): IPedidosItens;

    class function Listar(): TIBQuery; overload; static;
    class function Listar(aIDPedido: Integer): TIBQuery; overload; static;
    class function New():TPedidosItensController; static;
  end;

implementation

class function TPedidosItensController.getId: Integer;
var
  qAux: TIBQuery;
begin
  Result := 0;

  qAux := TConnection.NewQuery('SELECT MAX(ID) AS ID_ATUAL FROM PEDIDOS_ITENS');

  try
    try
      qAux.Open;

      if not (qAux.IsEmpty) then
        Result := qAux.FieldByName('ID_ATUAL').AsInteger + 1
      else
        Result := 1;

    except on E:Exception do
      MessageDlg('Erro ao pesquisar a chave do item do pedido!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAux);
  end;
end;

function TPedidosItensController.Inserir(oPedidosItens: IPedidosItens): Boolean;
var
  qAux: TIBQuery;
  vId: Integer;
begin
  Result := False;

  vId := Self.getId();

  if (vId > 0) then
  begin

    qAux := TConnection.NewQuery('INSERT INTO PEDIDOS_ITENS (ID, ID_PEDIDO, ID_PRODUTO, QUANTIDADE, PRECO) '+
                                 'VALUES (:ID, :ID_PEDIDO, :ID_PRODUTO, :QUANTIDADE, :PRECO)');

    try
      try
        qAux.ParamByName('ID').AsInteger := vId;
        qAux.ParamByName('ID_PEDIDO').AsInteger := oPedidosItens.GetIdPedido();
        qAux.ParamByName('ID_PRODUTO').AsInteger := oPedidosItens.GetIdProduto();
        qAux.ParamByName('QUANTIDADE').AsInteger := oPedidosItens.GetQuantidade();
        qAux.ParamByName('PRECO').AsFloat := oPedidosItens.GetPreco();
        qAux.ExecSQL;

        Result := True;
      except on E:Exception do
        MessageDlg('Erro ao inserir o item do pedido!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
      end;
    finally
      FreeAndNil(qAux);
    end;
  end;
end;

function TPedidosItensController.Alterar(oPedidosItens: IPedidosItens): Boolean;
var
  qAux: TIBQuery;
  I: Integer;
begin
  Result := False;

  qAux := TConnection.NewQuery('UPDATE PEDIDOS_ITENS '+
                               '   SET QUANTIDADE = :QUANTIDADE, '+
                               '       PRECO = :PRECO '+
                               ' WHERE ID = :ID');

  try
    try
      qAux.ParamByName('ID').AsInteger := oPedidosItens.GetID();
      qAux.ParamByName('QUANTIDADE').AsInteger := oPedidosItens.GetQuantidade();
      qAux.ParamByName('PRECO').AsFloat := oPedidosItens.GetPreco();
      qAux.ExecSQL;

      Result := True;
    except on E:Exception do
      MessageDlg('Erro ao alterar o item do pedido!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAux);
  end;
end;

function TPedidosItensController.Excluir(aID: Integer): Boolean;
var
  qAux: TIBQuery;
begin
  Result := False;

  qAux := TConnection.NewQuery('DELETE FROM PEDIDOS_ITENS WHERE ID = :ID');

  try
    try
      qAux.ParamByName('ID').AsInteger := aID;
      qAux.ExecSQL;

      Result := True;
    except on E:Exception do
      MessageDlg('Erro ao excluir o item do pedido!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAux);
  end;
end;

function TPedidosItensController.ExcluirTodos(aIDPedido: Integer): Boolean;
var
  qAux: TIBQuery;
begin
  Result := False;

  qAux := TConnection.NewQuery('DELETE FROM PEDIDOS_ITENS WHERE ID_PEDIDO = :ID_PEDIDO');

  try
    try
      qAux.ParamByName('ID_PEDIDO').AsInteger := aIDPedido;
      qAux.ExecSQL;

      Result := True;
    except on E:Exception do
      MessageDlg('Erro ao excluir os itens do pedido!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAux);
  end;
end;

function TPedidosItensController.Carregar(aID: Integer): IPedidosItens;
var
  qAux: TIBQuery;
begin
  Result := TPedidosItens.New();

  qAux := TConnection.NewQuery('SELECT * FROM PEDIDOS_ITENS WHERE ID = :ID');

  try
    try
      qAux.ParamByName('ID').AsInteger := aID;
      qAux.Open;

      if not qAux.IsEmpty then
      begin
        if Assigned(qAux.FindField('ID')) then
          Result.SetID(qAux.FieldByName('ID').AsInteger);
        if Assigned(qAux.FindField('ID_PEDIDO')) then
          Result.SetIDPedido(qAux.FieldByName('ID_PEDIDO').AsInteger);
        if Assigned(qAux.FindField('ID_PRODUTO')) then
          Result.SetIDProduto(qAux.FieldByName('ID_PRODUTO').AsInteger);
        if Assigned(qAux.FindField('QUANTIDADE')) then
          Result.SetQuantidade(qAux.FieldByName('QUANTIDADE').AsInteger);
        if Assigned(qAux.FindField('PRECO')) then
          Result.SetPreco(qAux.FieldByName('PRECO').AsFloat);
      end;

    except on E:Exception do
      MessageDlg('Erro ao carregar o item do pedido!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAux);
  end;
end;

class function TPedidosItensController.New: TPedidosItensController;
begin
  Result := TPedidosItensController.Create;
end;

class function TPedidosItensController.Listar: TIBQuery;
begin
  Result := TConnection.NewQuery('SELECT ID, ID_PEDIDO, ID_PRODUTO, QUANTIDADE, PRECO '+
                                 '  FROM PEDIDOS_ITENS');
end;

class function TPedidosItensController.Listar(aIDPedido: Integer): TIBQuery;
begin
  Result := TConnection.NewQuery('SELECT ID, ID_PEDIDO, ID_PRODUTO, QUANTIDADE, PRECO '+
                                 '  FROM PEDIDOS_ITENS'+
                                 ' WHERE ID_PEDIDO = :ID_PEDIDO');
  Result.ParamByName('ID_PEDIDO').AsInteger := aIDPedido;
  Result.Open;
end;


end.
