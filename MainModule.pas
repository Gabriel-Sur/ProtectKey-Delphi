unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TUniMainModule = class(TUniGUIMainModule)
    Conexao: TFDConnection;
    dsCredencial: TDataSource;
    sqlCredencial: TFDQuery;
    sqlExecutaGen: TFDQuery;
    sqlExecutaGenNEW_ID: TLargeintField;
    sqlGenCategoria: TFDQuery;
    sqlCategoriaTeste: TFDQuery;
    dsCategoriaTeste: TDataSource;
    sqlCategoriaTesteID: TIntegerField;
    sqlCategoriaTesteDESCRICAO: TStringField;
    sqlCategoriaTesteSTATUS: TStringField;
    sqlGenCategoriaNEW_ID: TLargeintField;
    sqlCredencialID: TIntegerField;
    sqlCredencialDESCRICAO: TStringField;
    sqlCredencialSTATUS: TStringField;
    sqlCredencialID_CATEGORIA: TIntegerField;
    sqlCredencialSENHA: TStringField;
    sqlCredencialLOGIN: TStringField;
    sqlCredencialURL: TStringField;
    sqlLogin: TFDQuery;
    dsLogin: TDataSource;
    sqlLoginNOME: TStringField;
    sqlLoginID: TIntegerField;
    sqlLoginSENHA: TStringField;
    sqlGenIDLogin: TFDQuery;
    sqlGenIDLoginNEW_ID: TLargeintField;
    sqlAuxiliar: TFDQuery;
  private
    { Private declarations }

  public
    { Public declarations }
    function CheckCookies(Sender: TObject): Boolean;
  end;
    function PegaCookies(Cookie: String; Sender: TObject): String;
    procedure RegistraCookies(User, Pass: string; Sender: TObject);
    procedure RemoveCookies(Sender: TObject);

var CookieUser, CookiePass: String;

const Days: Real = 15.0;
      UserBD: String = '';
      PassBD: String = '';      // Substituir por uma consulta ao banco

function UniMainModule: TUniMainModule;

implementation

{$R *.dfm}

uses
  UniGUIVars, ServerModule, uniGUIApplication;

function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule)
end;

{ TUniMainModule }

function TUniMainModule.CheckCookies(Sender: TObject): Boolean;
begin
  CookieUser := PegaCookies('CookieUser', Sender);
  CookiePass := PegaCookies('CookiePass', Sender);

  Result := (CookieUser = UserBd) and (CookiePass = PassBD);
end;

function PegaCookies(cookie: String; Sender: TObject): String;
begin
  Result := UniApplication.Cookies.Values[cookie];
end;

procedure RegistraCookies(User, Pass: string; Sender: TObject);
begin
  UniApplication.Cookies.SetCookie('CookieUser', User, Now + Days);
  UniApplication.Cookies.SetCookie('CookiePass', Pass, Now + Days);
end;

procedure RemoveCookies(Sender: TObject);
begin
  UniApplication.Cookies.SetCookie('CookieUser', CookieUser, Now - 1);
  UniApplication.Cookies.SetCookie('CookiePass', CookiePass, Now - 1);
  UniApplication.Restart;
end;

initialization
  RegisterMainModuleClass(TUniMainModule);
end.
