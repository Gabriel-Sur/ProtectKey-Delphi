unit ufrmCadCredencial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn, UniSFButton,
  uniGUIBaseClasses, uniPanel, UniSFiGrowl, uniMultiItem, uniComboBox,
  uniDBComboBox, uniDBLookupComboBox, uniEdit, uniDBEdit, uniLabel, uniCheckBox;

type
  TfrmCadCredencial = class(TUniForm)
    pnBotoes: TUniPanel;
    btnConfirmar: TUniSFButton;
    Cancelar: TUniSFButton;
    GrowlMessage: TUniSFiGrowl;
    edtId: TUniDBEdit;
    edtDescricao: TUniDBEdit;
    edtLogin: TUniDBEdit;
    edtSenha: TUniDBEdit;
    edtUrl: TUniDBEdit;
    cbxStatus: TUniDBComboBox;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    UniLabel6: TUniLabel;
    UniLabel7: TUniLabel;
    cbxLookupCategoria: TUniDBLookupComboBox;
    cbCrypto: TUniCheckBox;
    procedure btnConfirmarClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniFormShow(Sender: TObject);
    procedure cbxLookupCategoriaEnter(Sender: TObject);
    procedure UniFormKeyPress(Sender: TObject; var Key: Char);
    procedure cbCryptoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Const Chave = 5;

function frmCadCredencial: TfrmCadCredencial;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uCrypto;

function frmCadCredencial: TfrmCadCredencial;
begin
  Result := TfrmCadCredencial(UniMainModule.GetFormInstance(TfrmCadCredencial));
end;

//Validações de campos vazios
procedure TfrmCadCredencial.btnConfirmarClick(Sender: TObject);
begin
  if edtDescricao.Text = '' then
  begin
    GrowlMessage.Error('OPSS!', 'O campo Descrição não pode ser nulo!', 1000);
    Abort;
  end;
  if cbxStatus.ItemIndex < 0 then
  begin
    GrowlMessage.Error('OPSS!', 'O campo Status não pode ser nulo!', 1000);
    Abort;
  end;
  if cbxLookupCategoria.Text = '' then
  begin
    GrowlMessage.Error('Opss!', 'O campo Categoria não pode estar nulo!', 1000);
    Abort;
  end;
  UniMainModule.sqlCredencial.FieldByName('LOGIN').AsString :=  Enc(Trim(edtLogin.Text), Chave);
  UniMainModule.sqlCredencial.FieldByName('SENHA').AsString :=  Enc(Trim(edtSenha.Text), Chave);
  UniMainModule.sqlCredencial.Post;
  UniMainModule.sqlCredencial.ApplyUpdates;

  GrowlMessage.Success('Sucesso!', 'Registro confirmado!', 1000);

  Close;
end;

procedure TfrmCadCredencial.CancelarClick(Sender: TObject);
begin
  Close;
end;

//mostra a senha descriptografada
procedure TfrmCadCredencial.cbCryptoClick(Sender: TObject);
begin
  if cbCrypto.Checked = True then
  begin
    edtLogin.Text := Dec(UniMainModule.sqlCredencial.FieldByName('LOGIN').AsString, Chave);
    edtSenha.Text := Dec(UniMainModule.sqlCredencial.FieldByName('SENHA').AsString, Chave);
  end else
  begin
    UniMainModule.sqlCredencial.FieldByName('LOGIN').AsString := Enc(Trim(edtLogin.Text), Chave);
    UniMainModule.sqlCredencial.FieldByName('SENHA').AsString := Enc(Trim(edtSenha.Text), Chave);
  end;

end;

procedure TfrmCadCredencial.cbxLookupCategoriaEnter(Sender: TObject);
begin
  UniMainModule.sqlCategoriaTeste.Open();
end;

procedure TfrmCadCredencial.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  UniMainModule.sqlCredencial.Cancel;
end;

procedure TfrmCadCredencial.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    edtDescricao.Clear;
    Close;
  end;
end;

procedure TfrmCadCredencial.UniFormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    btnConfirmar.OnClick(Sender);
  end;
end;

procedure TfrmCadCredencial.UniFormShow(Sender: TObject);
begin
  if edtDescricao.CanFocus then
     edtDescricao.SetFocus;
end;

end.
