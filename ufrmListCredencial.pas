unit ufrmListCredencial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniButton, uniBitBtn,
  UniSFButton, uniMultiItem, uniComboBox, uniEdit, uniBasicGrid, uniDBGrid,
  uniLabel, ufrmCadCredencial, UniSFiGrowl, UniFSConfirm;

type
  TfrmListCredencial = class(TUniForm)
    pnCrud: TUniPanel;
    pnPesquisa: TUniPanel;
    btnDelete: TUniSFButton;
    btnEditar: TUniSFButton;
    btnInserir: TUniSFButton;
    edtPalavraChave: TUniEdit;
    cbxStatus: TUniComboBox;
    btnPesquisar: TUniSFButton;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    dbgRegistros: TUniDBGrid;
    GrowlMessage: TUniSFiGrowl;
    Confirm: TUniFSConfirm;
    btnProximo: TUniSFButton;
    btnAnterior: TUniSFButton;
    btnDesativar: TUniSFButton;
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure dbgRegistrosDblClick(Sender: TObject);
    procedure dbgRegistrosKeyPress(Sender: TObject; var Key: Char);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure btnDesativarClick(Sender: TObject);
    procedure UniFormClick(Sender: TObject);
    procedure edtPalavraChaveKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

function frmListCredencial: TfrmListCredencial;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function frmListCredencial: TfrmListCredencial;
begin
  Result := TfrmListCredencial(UniMainModule.GetFormInstance(TfrmListCredencial));
end;

//Movimenta o grid
procedure TfrmListCredencial.btnAnteriorClick(Sender: TObject);
begin
  if (UniMainModule.sqlCredencial.Active = True) and
     (UniMainModule.sqlCredencial.RecordCount > 0) then
  begin
  UniMainModule.dsCredencial.DataSet.Prior;
  end else
  begin
    GrowlMessage.Warning('ATENÇÃO!', 'Nenhum registro foi selecionado para movimentar!', 1000);
  end;
end;

//Exclui os registros
procedure TfrmListCredencial.btnDeleteClick(Sender: TObject);
begin
  if (UniMainModule.sqlCredencial.Active = True) and
     (UniMainModule.sqlCredencial.RecordCount > 0) then
  begin
    Confirm.Question('Pergunta', 'Confirma a exclusão do registro?', 'fa fa-question-circle', TTypeColor.red, TTheme.light,
    procedure(Button: TConfirmButton)
    begin
      if Button = Yes then
      begin
        UniMainModule.sqlCredencial.Delete;
        UniMainModule.sqlCredencial.ApplyUpdates(0);

        GrowlMessage.Success('SUCESSO!', 'Registro excluído com sucesso!', 1000);
      end;
      if Button = No then
      begin
        Abort;
      end;
    end );
  end else
  begin
    GrowlMessage.Warning('ATENÇÃO!', 'Nenhum registro foi encontrado para excluir!', 1000);
  end;
end;

//Desativa e ativa as credenciais
procedure TfrmListCredencial.btnDesativarClick(Sender: TObject);
begin
  with UniMainModule.sqlCredencial do
  begin
    if (UniMainModule.sqlCredencial.Active = True) and
       (UniMainModule.sqlCredencial.RecordCount > 0) then
    begin
    if FieldByName('STATUS').Text = 'Ativo' then
    begin
      Open;
      Edit;
      FieldByName('STATUS').Text := 'Inativo';
      Post;
      ApplyUpdates;
      Close;
    end else
    begin
      Open;
      Edit;
      FieldByName('STATUS').Text := 'Ativo';
      Post;
      ApplyUpdates;
      Close;
    end;
    end else
    begin
      GrowlMessage.Warning('ATENÇÃO!', 'Nenhum registro foi selecionado para ativar ou desativar!', 1000);
    end;
  end;
end;

//Edit
procedure TfrmListCredencial.btnEditarClick(Sender: TObject);
var frmCadCredencial: TfrmCadCredencial;
begin
  if (UniMainModule.sqlCredencial.Active = True) and
     (UniMainModule.sqlCredencial.RecordCount > 0) then
  begin
    UniMainModule.sqlCredencial.Edit;

    frmCadCredencial := TfrmCadCredencial.Create(UniApplication);
    frmCadCredencial.ShowModal();
  end else
  begin
    GrowlMessage.Warning('ATENÇÃO!', 'Nenhum registro foi selecionado para editar!', 1000);
  end;
end;

//insert
procedure TfrmListCredencial.btnInserirClick(Sender: TObject);
var frmCadCredencial : TfrmCadCredencial;
begin

  //verifica se possui categoria criada
  if UniMainModule.sqlCategoriaTeste.RecordCount <= 0  then
  begin
    GrowlMessage.Info('Opss!', 'Crie uma categiria para vincular a credencial!', 1000);
    abort;
  end;

  //Incrementa o id
  with UniMainModule.sqlExecutaGen do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT GEN_ID(GEN_TB_CREDENCIAL_ID, 1) AS NEW_ID FROM RDB$DATABASE');
    Open;
  end;

  UniMainModule.sqlCredencial.Insert;
  UniMainModule.sqlCredencial.FieldByName('ID').Value     := UniMainModule.sqlExecutaGen.FieldByName('NEW_ID').Value;
  UniMainModule.sqlCredencial.FieldByName('STATUS').Value := 'Ativo';

  frmCadCredencial := TfrmCadCredencial.Create(UniApplication);
  frmCadCredencial.ShowModal();
end;

//Filtra e mostra no grid
procedure TfrmListCredencial.btnPesquisarClick(Sender: TObject);
begin
  UniMainModule.sqlCredencial.Close;
  UniMainModule.sqlCredencial.SQL.Clear;
  UniMainModule.sqlCredencial.SQL.Add('SELECT CRE.*, CAT.DESCRICAO AS CATEGORIA FROM TB_CREDENCIAL CRE left join TB_CATEGORIA CAT on (CAT.ID = CRE.ID_CATEGORIA) WHERE CRE.DESCRICAO like :DESCRICAO');
  UniMainModule.sqlCredencial.ParamByName('DESCRICAO').AsString := edtPalavraChave.Text + '%';
  if cbxStatus.Text <> 'Todos' then
  begin
    UniMainModule.sqlCredencial.SQL.Add('and CRE.STATUS like :STATUS');
    UniMainModule.sqlCredencial.ParamByName('STATUS').AsString := cbxStatus.Text;
  end;
  UniMainModule.sqlCredencial.Open();
end;

//Movimenta o grid
procedure TfrmListCredencial.btnProximoClick(Sender: TObject);
begin
  if (UniMainModule.sqlCredencial.Active = True) and
     (UniMainModule.sqlCredencial.RecordCount > 0) then
  begin
    UniMainModule.dsCredencial.DataSet.Next;
  end else
  begin
    GrowlMessage.Warning('ATENÇÃO!', 'Nenhum registro foi selecionado para editar!', 1000);
  end;
end;

procedure TfrmListCredencial.dbgRegistrosDblClick(Sender: TObject);
begin
  btnEditar.OnClick(Sender);
end;

procedure TfrmListCredencial.dbgRegistrosKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnEditar.OnClick(Sender);
end;

procedure TfrmListCredencial.edtPalavraChaveKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    btnPesquisar.OnClick(Sender);
  end;
end;

//Verifica se o registro está ativo ou inativo e conforme for muda o caption do botão
procedure TfrmListCredencial.UniFormClick(Sender: TObject);
begin
  if UniMainModule.dsCredencial.DataSet.FieldByName('STATUS').Value = 'Ativo' then
  begin
    btnDesativar.Caption := 'Desativar';
  end else
  begin
    btnDesativar.Caption := 'Ativar';
  end;
end;

procedure TfrmListCredencial.UniFormCreate(Sender: TObject);
begin
  btnPesquisar.OnClick(Sender);
end;

procedure TfrmListCredencial.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
     Close;
  if Key = VK_DELETE then
     btnDelete.OnClick(Sender);
end;

end.
