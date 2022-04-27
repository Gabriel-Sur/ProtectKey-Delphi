unit ufrmCadastro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel, uniEdit,
  uniButton, uniCheckBox, uniDBEdit, UniSFiGrowl;

type
  TfrmCadastro = class(TUniForm)
    UniPanel1: TUniPanel;
    UniPanel2: TUniPanel;
    UniPanel3: TUniPanel;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    UniLabel4: TUniLabel;
    checkBox: TUniCheckBox;
    btnRegistrar: TUniButton;
    edtLogin: TUniDBEdit;
    edtSenha: TUniDBEdit;
    edtConfSenha: TUniEdit;
    GrowlMessage: TUniSFiGrowl;
    procedure btnRegistrarClick(Sender: TObject);
    procedure UniFormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  const Chave = 5;

function frmCadastro: TfrmCadastro;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uCrypto;

function frmCadastro: TfrmCadastro;
begin
  Result := TfrmCadastro(UniMainModule.GetFormInstance(TfrmCadastro));
end;

//Validações
procedure TfrmCadastro.btnRegistrarClick(Sender: TObject);
begin
  if edtLogin.Text = '' then
  begin
    GrowlMessage.Error('OPSS!', 'O campo Login não pode ser nulo!', 1000);
    Abort;
  end;
  if edtSenha.Text = '' then
  begin
    GrowlMessage.Error('OPSS!', 'O campo Senha não pode ser nulo!', 1000);
    Abort;
  end;
  if edtConfSenha.Text = '' then
  begin
    GrowlMessage.Error('Opss!', 'O campo Confirme não pode estar nulo!', 1000);
    Abort;
  end;
  if checkBox.Checked = False then
  begin
    GrowlMessage.Error('Opss!', 'Por favor, Concorde com os termos de acordo!', 1000);
    Abort
  end;

  //Conferindo as senhas e tratando caso já exista o cadastro
  if (checkBox.Checked = True) and (edtConfSenha.Text = edtSenha.Text) then
  begin
    UniMainModule.sqlAuxiliar.Close;
    UniMainModule.sqlAuxiliar.SQL.ADD('SELECT * FROM TB_LOGIN');
    UniMainModule.sqlAuxiliar.Open;
    if UniMainModule.sqlAuxiliar.Locate('NOME', edtLogin.Text, []) then
    begin
      GrowlMessage.Error('Opss!', 'Usuário já registrado!', 1000);
      abort;
    end else
    begin
    UniMainModule.sqlLogin.FieldByName('SENHA').AsString := Enc(Trim(edtSenha.Text), Chave);
    UniMainModule.sqlLogin.Post;
    UniMainModule.sqlLogin.ApplyUpdates;
    GrowlMessage.Success('Sucesso!', 'Registro confirmado!', 1000);
    UniMainModule.sqlLogin.Close;
    Close;
    end;
  end else
  begin
    GrowlMessage.Error('Opss!', 'Os dados não conferem!', 1000);
  end;
end;

procedure TfrmCadastro.UniFormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    btnRegistrar.OnClick(Sender);
  end;
end;

end.
