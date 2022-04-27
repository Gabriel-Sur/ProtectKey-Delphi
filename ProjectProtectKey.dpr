program ProjectProtectKey;

uses
  Forms,
  ServerModule in 'ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'MainModule.pas' {UniMainModule: TUniGUIMainModule},
  Main in 'Main.pas' {MainForm: TUniForm},
  ufrmListCategorias in 'ufrmListCategorias.pas' {frmListCategorias: TUniForm},
  ufrmListCredencial in 'ufrmListCredencial.pas' {frmListCredencial: TUniForm},
  ufrmCadCredencial in 'ufrmCadCredencial.pas' {frmCadCredencial: TUniForm},
  ufrmCadCategorias in 'ufrmCadCategorias.pas' {frmCadCategorias: TUniForm},
  ufrmLogin in 'ufrmLogin.pas' {frmLogin: TUniForm},
  ufrmCadastro in 'ufrmCadastro.pas' {frmCadastro: TUniForm},
  uCrypto in 'uCrypto.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
end.
