unit ufrmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniEdit, uniCheckBox, uniLabel,
  uniGUIBaseClasses, uniPanel, UniSFiGrowl;

type
  TfrmLogin = class(TUniForm)
    UniPanel1: TUniPanel;
    UniPanel2: TUniPanel;
    UniPanel3: TUniPanel;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    ckbCookies: TUniCheckBox;
    edtLogin: TUniEdit;
    edtSenha: TUniEdit;
    btnCadastrar: TUniButton;
    btnEntrar: TUniButton;
    GrowlMessage: TUniSFiGrowl;
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnEntrarClick(Sender: TObject);
    procedure UniFormKeyPress(Sender: TObject; var Key: Char);
    procedure UniFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations  }
  end;

  const Chave = 5;

function frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, ufrmCadastro, uCrypto;

function frmLogin: TfrmLogin;
begin
  Result := TfrmLogin(UniMainModule.GetFormInstance(TfrmLogin));
end;

procedure TfrmLogin.btnCadastrarClick(Sender: TObject);
var frmCadastro: TfrmCadastro;
begin
  UniMainModule.sqlLogin.Open;
  UniMainModule.sqlGenIDLogin.Close;
  UniMainModule.sqlGenIDLogin.Open;
  UniMainModule.sqlLogin.insert;
  UniMainModule.sqlLogin.FieldByName('ID').Value     := UniMainModule.sqlGenIDLogin.FieldByName('NEW_ID').Value;
  frmCadastro := TfrmCadastro.Create(UniApplication);
  frmCadastro.ShowModal;
end;

procedure TfrmLogin.UniFormCreate(Sender: TObject);
begin
   if PegaCookies('CookieUser', Sender) = EmptyStr then
   begin
     GrowlMessage.Simple('Olá', 'Bem-Vindo!', 1000);
   end else
   begin
     edtLogin.Text := PegaCookies('CookieUser', Sender);
     //edtSenha.Text := PegaCookies('CookiePass', Sender);
     edtSenha.Text := Dec(PegaCookies('CookiePass', Sender), Chave);
     ckbCookies.Checked := True;
   end;
end;

procedure TfrmLogin.UniFormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    btnEntrar.OnClick(Sender);
  end;
end;

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
begin
  UniMainModule.sqlLogin.Close;
  UniMainModule.sqlLogin.Open;
  if edtLogin.Text = '' then
  begin
    GrowlMessage.Error('OPSS!', 'O campo Login não pode ser nulo!', 1000);
  end;
  if edtSenha.Text = '' then
  begin
    GrowlMessage.Error('OPSS!', 'O campo Senha não pode ser nulo!', 1000);
  end;

  edtSenha.Text := Enc(Trim(edtSenha.Text), Chave);

  //Localizando no banco de dados o cadastro
  if UniMainModule.sqlLogin.Locate('NOME', edtLogin.Text , []) and UniMainModule.sqlLogin.Locate('SENHA', edtSenha.Text, []) then
  begin
    GrowlMessage.Success('Sucesso!', 'Login correto!', 1000);
    if ckbCookies.Checked then
    begin
     RegistraCookies(edtLogin.Text, edtSenha.Text, Sender);
    end;
    Close;
    UniMainModule.sqlLogin.Close;
  end else
  begin
    GrowlMessage.Error('Opss!', 'Os campos não conferem!', 1000);
  end;
end;

end.
