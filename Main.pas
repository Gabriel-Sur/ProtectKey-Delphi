unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniButton, uniBitBtn,
  UniSFButton, uniGUIBaseClasses, uniPanel, ufrmListCategorias, ufrmListCredencial,
  uniImage, uniLabel, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, ufrmLogin;

type
  TMainForm = class(TUniForm)
    UniPanel1: TUniPanel;
    UniPanel2: TUniPanel;
    btnCategorias: TUniSFButton;
    btnCredenciais: TUniSFButton;
    btnSair: TUniSFButton;
    UniPanel3: TUniPanel;
    UniImage1: TUniImage;
    lblUsername: TUniLabel;
    UniImage2: TUniImage;
    procedure btnCredenciaisClick(Sender: TObject);
    procedure btnCategoriasClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.btnCategoriasClick(Sender: TObject);
var frmListCategorias: TfrmListCategorias;
begin
  frmListCategorias := TfrmListCategorias.Create(UniApplication);
  frmListCategorias.ShowModal();
end;

procedure TMainForm.btnCredenciaisClick(Sender: TObject);
var frmListCredencial: TfrmListCredencial;
begin
  frmListCredencial := TfrmListCredencial.Create(UniApplication);
  frmListCredencial.ShowModal();
end;

procedure TMainForm.btnSairClick(Sender: TObject);
begin
  UniApplication.Terminate();
  RemoveCookies(Sender);
end;

procedure TMainForm.UniFormCreate(Sender: TObject);
var frmLogin: TfrmLogin;
begin
  frmLogin := TfrmLogin.Create(UniApplication);
  frmLogin.ShowModal;
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
