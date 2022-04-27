unit ufrmCadCategorias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniLabel, uniMultiItem, uniComboBox, uniDBComboBox,
  uniEdit, uniDBEdit, uniGUIBaseClasses, uniPanel, uniButton, uniBitBtn,
  UniSFButton, UniSFiGrowl;

type
  TfrmCadCategorias = class(TUniForm)
    pnBotoes: TUniPanel;
    edtId: TUniDBEdit;
    edtDescricao: TUniDBEdit;
    cbxStatus: TUniDBComboBox;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    btnConfirmar: TUniSFButton;
    btnCancelar: TUniSFButton;
    GrowlMessage: TUniSFiGrowl;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniFormShow(Sender: TObject);
    procedure UniFormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmCadCategorias: TfrmCadCategorias;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function frmCadCategorias: TfrmCadCategorias;
begin
  Result := TfrmCadCategorias(UniMainModule.GetFormInstance(TfrmCadCategorias));
end;

procedure TfrmCadCategorias.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

//Validações de campos vazios
procedure TfrmCadCategorias.btnConfirmarClick(Sender: TObject);
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
  UniMainModule.sqlCategoriaTeste.Post;
  UniMainModule.sqlCategoriaTeste.ApplyUpdates;

  GrowlMessage.Success('Sucesso!', 'Registro confirmado!', 1000);

  Close;
end;

procedure TfrmCadCategorias.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  UniMainModule.sqlCategoriaTeste.Cancel;
end;

procedure TfrmCadCategorias.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
     Close;
end;

procedure TfrmCadCategorias.UniFormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    btnConfirmar.OnClick(Sender);
  end;
end;

procedure TfrmCadCategorias.UniFormShow(Sender: TObject);
begin
  if edtDescricao.CanFocus then
     edtDescricao.SetFocus;
end;

end.
