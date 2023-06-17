unit untPedidosController;

interface

uses
  IBX.IBQuery,
  System.SysUtils,
  System.UITypes,
  Vcl.Dialogs,

  untConnection,
  untPedidosModel,
  untPedidosModelInterface,
  untPedidosControllerInterface,
  untPedidosItensModel,
  untPedidosItensModelInterface,
  untPedidosItensController,
  untPedidosItensControllerInterface;

type
  TPedidosController = class(TInterfacedObject, IPedidosController)
  private
    class function getId(): Integer;
  public
    function Inserir(oPedidos: IPedidos): Integer;
    function Alterar(oPedidos: IPedidos): Boolean;
    function Excluir(aID: Integer): Boolean;
    function Carregar(aID: Integer): IPedidos;

    class function Listar(): TIBQuery; static;
    class function RetornaPedido(aIDPedido: Integer): TIBQuery; static;
    class function RetornaPedidoCompleto(aIDPedido: Integer): TIBQuery; static;
    class function New():TPedidosController; static;
  end;

implementation

class function TPedidosController.getId: Integer;
var
  qAux: TIBQuery;
begin
  Result := 0;

  qAux := TConnection.NewQuery('SELECT MAX(ID) AS ID_ATUAL FROM PEDIDOS');

  try
    try
      qAux.Open;

      if not (qAux.IsEmpty) then
        Result := qAux.FieldByName('ID_ATUAL').AsInteger + 1
      else
        Result := 1;

    except on E:Exception do
      MessageDlg('Erro ao pesquisar a chave do pedido!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAux);
  end;
end;

function TPedidosController.Inserir(oPedidos: IPedidos): Integer;
var
  qAux: TIBQuery;
  vId, I: Integer;
begin
  Result := 0;

  vId := Self.getId();

  if (vId > 0) then
  begin

    qAux := TConnection.NewQuery('INSERT INTO PEDIDOS (ID, ID_CLIENTE, VALOR_TOTAL, DATA_HORA) '+
                                 'VALUES (:ID, :ID_CLIENTE, :VALOR_TOTAL, :DATA_HORA)');

    try
      try
        qAux.ParamByName('ID').AsInteger := vId;
        qAux.ParamByName('ID_CLIENTE').AsInteger := oPedidos.GetIdCliente();
        qAux.ParamByName('VALOR_TOTAL').AsFloat := oPedidos.GetValorTotal();
        qAux.ParamByName('DATA_HORA').AsDateTime := oPedidos.GetDataHora();
        qAux.ExecSQL;

        for I := 0 to pred(oPedidos.GetPedidosItens.Count) do
        begin
          oPedidos.GetPedidosItens[I].SetIdPedido(vId);

          if (oPedidos.GetPedidosItens[I].GetId > 0) then
            TPedidosItensController.New.Alterar(oPedidos.GetPedidosItens[I])
          else
            TPedidosItensController.New.Inserir(oPedidos.GetPedidosItens[I]);
        end;

        Result := vId;
      except on E:Exception do
        MessageDlg('Erro ao inserir o pedido!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
      end;
    finally
      FreeAndNil(qAux);
    end;
  end;
end;

function TPedidosController.Alterar(oPedidos: IPedidos): Boolean;
var
  qAux: TIBQuery;
  I: Integer;
begin
  Result := False;

  qAux := TConnection.NewQuery('UPDATE PEDIDOS '+
                               '   SET ID_CLIENTE = :ID_CLIENTE, '+
                               '       VALOR_TOTAL = :VALOR_TOTAL, '+
                               '       DATA_HORA = :DATA_HORA '+
                               ' WHERE ID = :ID');

  try
    try
      qAux.ParamByName('ID').AsInteger := oPedidos.GetID();
      qAux.ParamByName('ID_CLIENTE').AsInteger := oPedidos.GetIdCliente();
      qAux.ParamByName('VALOR_TOTAL').AsFloat := oPedidos.GetValorTotal();
      qAux.ParamByName('DATA_HORA').AsDateTime := oPedidos.GetDataHora();
      qAux.ExecSQL;

      for I := 0 to pred(oPedidos.GetPedidosItens.Count) do
      begin
        oPedidos.GetPedidosItens[I].SetIdPedido(oPedidos.GetId);

        if (oPedidos.GetPedidosItens[I].GetId > 0) then
          TPedidosItensController.New.Alterar(oPedidos.GetPedidosItens[I])
        else
          TPedidosItensController.New.Inserir(oPedidos.GetPedidosItens[I]);
      end;

      Result := True;
    except on E:Exception do
      MessageDlg('Erro ao alterar o pedido!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAux);
  end;
end;

function TPedidosController.Excluir(aID: Integer): Boolean;
var
  qAux: TIBQuery;
begin
  Result := False;

  qAux := TConnection.NewQuery('DELETE FROM PEDIDOS WHERE ID = :ID');

  try
    try
      TPedidosItensController.New.Excluir(aID);

      qAux.ParamByName('ID').AsInteger := aID;
      qAux.ExecSQL;

      Result := True;
    except on E:Exception do
      MessageDlg('Erro ao excluir o pedido!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAux);
  end;
end;

function TPedidosController.Carregar(aID: Integer): IPedidos;
var
  qAux:  TIBQuery;
  qAuxI: TIBQuery;
begin
  Result := TPedidos.New();

  qAux  := TConnection.NewQuery('SELECT * FROM PEDIDOS WHERE ID = :ID');
  qAuxI := TPedidosItensController.Listar(aID);

  try
    try
      qAux.ParamByName('ID').AsInteger := aID;
      qAux.Open;

      if not qAux.IsEmpty then
      begin
        if Assigned(qAux.FindField('ID')) then
          Result.SetID(qAux.FieldByName('ID').AsInteger);
        if Assigned(qAux.FindField('ID_CLIENTE')) then
          Result.SetIDCliente(qAux.FieldByName('ID_CLIENTE').AsInteger);
        if Assigned(qAux.FindField('VALOR_TOTAL')) then
          Result.SetValorTotal(qAux.FieldByName('VALOR_TOTAL').AsFloat);
        if Assigned(qAux.FindField('DATA_HORA')) then
          Result.SetDataHora(qAux.FieldByName('DATA_HORA').AsDateTime);

        qAuxI.First;
        while not qAuxI.Eof do
        begin
          Result.GetPedidosItens.Add(TPedidosItens.New(qAuxI.FieldByName('ID').AsInteger,
                                                       qAuxI.FieldByName('ID_PEDIDO').AsInteger,
                                                       qAuxI.FieldByName('ID_PRODUTO').AsInteger,
                                                       qAuxI.FieldByName('QUANTIDADE').AsInteger,
                                                       qAuxI.FieldByName('PRECO').AsFloat));
          qAuxI.Next;
        end;
      end;

    except on E:Exception do
      MessageDlg('Erro ao carregar o pedido!' + #13 + #13 + E.Message, mtError, [mbOk], 0, mbOk);
    end;
  finally
    FreeAndNil(qAuxI);
    FreeAndNil(qAux);
  end;
end;

class function TPedidosController.New: TPedidosController;
begin
  Result := TPedidosController.Create;
end;

class function TPedidosController.Listar: TIBQuery;
begin
  Result := TConnection.NewQuery('SELECT ID, ID_CLIENTE, VALOR_TOTAL, DATA_HORA '+
                                 '  FROM PEDIDOS');
end;

class function TPedidosController.RetornaPedido(aIDPedido: Integer): TIBQuery;
begin
  Result := TConnection.NewQuery('SELECT ID, ID_CLIENTE, VALOR_TOTAL, DATA_HORA '+
                                 '  FROM PEDIDOS '+
                                 ' WHERE P.ID = :ID_PEDIDO');
  Result.ParamByName('ID_PEDIDO').AsInteger := aIDPedido;
  Result.Open;
end;

class function TPedidosController.RetornaPedidoCompleto(aIDPedido: Integer): TIBQuery;
begin
  Result := TConnection.NewQuery('SELECT P.ID AS ID_PED, P.ID_CLIENTE, P.VALOR_TOTAL, P.DATA_HORA, '+
                                 '       I.ID AS ID_ITE, I.ID_PRODUTO, I.QUANTIDADE, I.PRECO '+
                                 '  FROM PEDIDOS AS P '+
                                 '  JOIN PEDIDOS_ITENS AS I '+
                                 '    ON P.ID = I.ID_PEDIDO '+
                                 ' WHERE P.ID = :ID_PEDIDO');
  Result.ParamByName('ID_PEDIDO').AsInteger := aIDPedido;
  Result.Open;
end;


end.
