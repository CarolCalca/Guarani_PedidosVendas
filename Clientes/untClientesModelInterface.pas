unit untClientesModelInterface;

interface

type
  IClientes = interface
    ['{3DA3D966-929B-4AD9-8B58-8B3D30DF7097}']

    procedure Clear();

    procedure SetId(const aValue: Integer);
    procedure SetNomeFantasia(const aValue: String);
    procedure SetRazaoSocial(const aValue: String);
    procedure SetCNPJ(const aValue: String);
    procedure SetEndereco(const aValue: String);
    procedure SetTelefone(const aValue: String);

    function GetId:Integer;
    function GetNomeFantasia:String;
    function GetRazaoSocial:String;
    function GetCNPJ:String;
    function GetEndereco:String;
    function GetTelefone:String;
  end;

implementation

end.
