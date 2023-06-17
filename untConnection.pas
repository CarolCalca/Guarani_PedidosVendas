unit untConnection;

interface

uses
  System.SysUtils,
  IBX.IBDatabase,
  IBX.IBQuery,
  Vcl.Dialogs,
  Vcl.Forms;

type
  TConnection = class
    private
      class var oConnection : TIBDatabase;
      class var oTransaction : TIBTransaction;
      class procedure Config();
      class procedure Connect();
   //   class procedure TransacaoAutomatica(aAtivar: Boolean);
    public
      class function getConnection():TIBDatabase;
      class function NewQuery(aSQL:String):TIBQuery;
      class function getTransaction():TIBTransaction;
      class procedure StartTransaction(); static;
      class procedure Rollback(); static;
      class procedure Commit(); static;
  end;

const
  cstDB_User: String = 'SYSDBA';
  cstDB_Pass: String = 'masterkey';
  cstDB_Database: String = 'localhost:E:\Projects\Delphi\Guarani_PedidosVenda\DB\DBPEDIDOS.FDB';
  cstDB_ctype: String = 'WIN1252';

implementation

class function TConnection.getConnection(): TIBDatabase;
begin
  Result := nil;

  try
    TConnection.Connect();
    Result := oConnection;
  except
    on E:Exception do
    begin
      ShowMessage('Não foi possível conectar ao banco de dados.' + #13 + E.Message);
      Application.Terminate;
    end;
  end;
end;

class procedure TConnection.Connect();
begin
  TConnection.Config();
  if not oConnection.Connected then
    oConnection.Connected := True;
end;

class procedure TConnection.Config();
begin
  if not Assigned(oConnection) then
  begin
    oConnection := TIBDatabase.Create(nil);
    oConnection.DatabaseName := cstDB_Database;
    oConnection.Params.Add('user_name='+cstDB_User);
    oConnection.Params.Add('password='+cstDB_Pass);
    oConnection.Params.Add('lc_ctype='+cstDB_ctype);
    oConnection.LoginPrompt := False;
    oConnection.DefaultTransaction := getTransaction();
  end;
end;

class function TConnection.NewQuery(aSQL: String): TIBQuery;
begin
  Result := TIBQuery.Create(nil);
  Result.Database := TConnection.getConnection();
  Result.Transaction := TConnection.getTransaction();
  Result.SQL.Add(aSQL);
end;

class function TConnection.getTransaction(): TIBTransaction;
begin
  Result := nil;

  try
    if not Assigned(oTransaction) then
    begin
      oTransaction := TIBTransaction.Create(nil);
      oTransaction.DefaultDatabase := getConnection();
    end;
    Result := oTransaction;
  except
    on E:Exception do
    begin
      ShowMessage('Não foi possível abrir a transação.' + #13 + E.Message);
      Application.Terminate;
    end;
  end;
end;

class procedure TConnection.StartTransaction;
begin
  TConnection.GetTransaction().StartTransaction;
end;

class procedure TConnection.Rollback;
begin
  if TConnection.GetTransaction().InTransaction then
    TConnection.GetTransaction().Rollback;
end;

class procedure TConnection.Commit;
begin
  if TConnection.GetTransaction().InTransaction then
    TConnection.GetTransaction().Commit;
end;

end.
