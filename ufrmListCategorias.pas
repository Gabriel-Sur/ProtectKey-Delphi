unit ufrmListCategorias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniMultiItem, uniComboBox, uniLabel, uniEdit,
  uniButton, uniBitBtn, UniSFButton, uniGUIBaseClasses, uniPanel, uniBasicGrid,
  uniDBGrid, UniSFiGrowl, UniFSConfirm, ufrmCadCategorias;

type
  TfrmListCategorias = class(TUniForm)
    pnCrud: TUniPanel;
    btnDelete: TUniSFButton;
    btnInserir: TUniSFButton;
    btnEditar: TUniSFButton;
    pnPesquisa: TUniPanel;
    edtPalavraChave: TUniEdit;
    UniLabel1: TUniLabel;
    cbxStatus: TUniComboBox;
    UniLabel2: TUniLabel;
    btnPesquisar: TUniSFButton;
    dbgRegistros: TUniDBGrid;
    GrowlMessage: TUniSFiGrowl;
    Confirm: TUniFSConfirm;
    btnAnterior: TUniSFButton;
    btnProximo: TUniSFButton;
    btnDesativar: TUniSFButton;
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure dbgRegistrosDblClick(Sender: TObject);
    procedure dbgRegistrosKeyPress(Sender: TObject; var Key: Char);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnProximoClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure btnDesativarClick(Sender: TObject);
    procedure UniFormClick(Sender: TObject);
    procedure edtPalavraChaveKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmListCategorias: TfrmListCategorias;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function frmListCategorias: TfrmListCategorias;
begin
  Result := TfrmListCategorias(UniMainModule.GetFormInstance(TfrmListCategorias));
end;

//Movimenta o grid
procedure TfrmListCategorias.btnAnteriorClick(Sender: TObject);
begin
  if (UniMainModule.sqlCategoriaTeste.Active = True) and
     (UniMainModule.sqlCategoriaTeste.RecordCount > 0) then
  begin
    UniMainModule.dsCategoriaTeste.DataSet.Prior;
  end else
  begin
    GrowlMessage.Warning('ATENÇÃO!', 'Nenhum registro foi selecionado para movimentar!', 1000);
  end;
end;


procedure TfrmListCategorias.btnDeleteClick(Sender: TObject);
begin
  if (UniMainModule.sqlCategoriaTeste.Active = True) and
     (UniMainModule.sqlCategoriaTeste.RecordCount > 0) then

  //Verifica se a categoria está sendo utilizada, caso sim, pede ao usuário para desativar ou não
  begin
    UniMainModule.sqlCredencial.Close;
    UniMainModule.sqlCredencial.SQL.Clear;
    UniMainModule.sqlCredencial.SQL.Add('SELECT CRE.* FROM TB_CREDENCIAL AS CRE WHERE CRE.ID_CATEGORIA = :ID_CATEGORIA');
    UniMainModule.sqlCredencial.ParamByName('ID_CATEGORIA').Value := UniMainModule.sqlCategoriaTeste.FieldByName('ID').Value;
    UniMainModule.sqlCredencial.Open;

    if UniMainModule.sqlCredencial.RecordCount > 0 then
    begin
      Confirm.Question('Categoria Utilizada!', 'Deseja desativa-la?', 'fa fa-question-circle', TTypeColor.red, TTheme.light,
      procedure(Button: TconfirmButton)
      begin
        if Button = Yes then
        begin
          with UniMainModule.sqlCategoriaTeste do
          begin
            Open;
            Edit;
            FieldByName('STATUS').Text := 'Inativo';
            Post;
            ApplyUpdates;
            Close;
            GrowlMessage.Success('Sucesso!', 'Registro desativado com sucesso!', 1000);
          end;
        end;
        if Button = No then
        begin
          Abort;
        end;
      end );
    end else

    //Exclusão caso não esteja sendo utilizada
    begin
      Confirm.Question('Pergunta', 'Confirma a exclusão do registro?', 'fa fa-question-circle', TTypeColor.red, TTheme.light,
      procedure(Button: TConfirmButton)
      begin
        if Button = Yes then
        begin
          UniMainModule.sqlCategoriaTeste.Delete;
          UniMainModule.sqlCategoriaTeste.ApplyUpdates(0);

          GrowlMessage.Success('SUCESSO!', 'Registro excluído com sucesso!', 1000);
        end;
        if Button = No then
        begin
          Abort;
        end;
      end );
    end;
    end else
    begin
      GrowlMessage.Warning('ATENÇÃO!', 'Nenhum registro foi encontrado para excluir!', 1000);
    end;
end;

//Desativa ou ativa o registro
procedure TfrmListCategorias.btnDesativarClick(Sender: TObject);
begin
  with UniMainModule.sqlCategoriaTeste do
  begin
    if (UniMainModule.sqlCategoriaTeste.Active = True) and
       (UniMainModule.sqlCategoriaTeste.RecordCount > 0) then
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
procedure TfrmListCategorias.btnEditarClick(Sender: TObject);
var frmCadCategorias: TfrmCadCategorias;
begin
  if (UniMainModule.sqlCategoriaTeste.Active = True) and
     (UniMainModule.sqlCategoriaTeste.RecordCount > 0) then
  begin
    UniMainModule.sqlCategoriaTeste.Edit;

    frmCadCategorias := TfrmCadCategorias.Create(UniApplication);
    frmCadCategorias.ShowModal();
  end else
  begin
    GrowlMessage.Warning('ATENÇÃO!', 'Nenhum registro foi selecionado para editar!', 1000);
  end;
end;

//Insert
procedure TfrmListCategorias.btnInserirClick(Sender: TObject);
var frmCadCategorias : TfrmCadCategorias;
begin
  UniMainModule.sqlGenCategoria.Close;
  UniMainModule.sqlGenCategoria.Open;
  UniMainModule.sqlCategoriaTeste.Insert;
  UniMainModule.sqlCategoriaTeste.FieldByName('ID').Value     := UniMainModule.sqlGenCategoria.FieldByName('NEW_ID').Value;
  UniMainModule.sqlCategoriaTeste.FieldByName('STATUS').Value := 'Ativo';

  frmCadCategorias := TfrmCadCategorias.Create(UniApplication);
  frmCadCategorias.ShowModal();
end;

//Show no grid
procedure TfrmListCategorias.btnPesquisarClick(Sender: TObject);
begin
  UniMainModule.sqlCategoriaTeste.Close;
  UniMainModule.sqlCategoriaTeste.SQL.Clear;
  UniMainModule.sqlCategoriaTeste.SQL.Add('SELECT * FROM TB_CATEGORIA WHERE DESCRICAO like :DESCRICAO');
  UniMainModule.sqlCategoriaTeste.ParamByName('DESCRICAO').AsString := edtPalavraChave.Text + '%';
  if cbxStatus.Text <> 'Todos' then
  begin
    UniMainModule.sqlCategoriaTeste.SQL.Add('and STATUS like :STATUS');
    UniMainModule.sqlCategoriaTeste.ParamByName('STATUS').AsString := cbxStatus.Text;
  end;
  UniMainModule.sqlCategoriaTeste.Open();
end;

//Movimenta o grid
procedure TfrmListCategorias.btnProximoClick(Sender: TObject);
begin
  if (UniMainModule.sqlCategoriaTeste.Active = True) and
     (UniMainModule.sqlCategoriaTeste.RecordCount > 0) then
  begin
  UniMainModule.dsCategoriaTeste.DataSet.Next;
  end else
  begin
    GrowlMessage.Warning('ATENÇÃO!', 'Nenhum registro foi selecionado para editar!', 1000);
  end;
end;

procedure TfrmListCategorias.dbgRegistrosDblClick(Sender: TObject);
begin
  if (UniMainModule.sqlCategoriaTeste.Active = True) and
     (UniMainModule.sqlCategoriaTeste.RecordCount > 0) then
  begin
    btnEditar.OnClick(Sender);
  end else
  begin
    GrowlMessage.Warning('ATENÇÃO!', 'Nenhum registro foi selecionado para editar!', 1000);
  end;

end;

procedure TfrmListCategorias.dbgRegistrosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    btnEditar.OnClick(Sender);
end;

procedure TfrmListCategorias.edtPalavraChaveKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    btnPesquisar.OnClick(Sender);
  end;
end;

//Verifica se o registro está ativo ou inativo e conforme for, muda o caption do botão
procedure TfrmListCategorias.UniFormClick(Sender: TObject);
begin
  if UniMainModule.dsCategoriaTeste.DataSet.FieldByName('STATUS').Value = 'Ativo' then
  begin
    btnDesativar.Caption := 'Desativar';
  end else
  begin
    btnDesativar.Caption := 'Ativar';
  end;
end;

procedure TfrmListCategorias.UniFormCreate(Sender: TObject);
begin
  btnPesquisar.OnClick(Sender);
end;

procedure TfrmListCategorias.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
  if Key = VK_DELETE then
    btnDelete.OnClick(Sender);
end;

end.
