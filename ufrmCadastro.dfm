object frmCadastro: TfrmCadastro
  Left = 0
  Top = 0
  ClientHeight = 452
  ClientWidth = 374
  Caption = 'Cadastro'
  OldCreateOrder = False
  OnKeyPress = UniFormKeyPress
  BorderIcons = []
  KeyPreview = True
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object UniPanel1: TUniPanel
    Left = 0
    Top = 0
    Width = 374
    Height = 97
    Hint = ''
    Align = alTop
    ParentFont = False
    Font.Height = -16
    TabOrder = 0
    Caption = ''
    object UniLabel4: TUniLabel
      Left = 136
      Top = 28
      Width = 95
      Height = 19
      Hint = ''
      Caption = 'Protect Key'
      ParentFont = False
      Font.Height = -16
      Font.Style = [fsBold]
      TabOrder = 1
    end
  end
  object UniPanel2: TUniPanel
    Left = 0
    Top = 346
    Width = 374
    Height = 106
    Hint = ''
    Align = alBottom
    TabOrder = 1
    Caption = ''
    object btnRegistrar: TUniButton
      Left = 88
      Top = 32
      Width = 209
      Height = 41
      Hint = ''
      Caption = 'Entrar'
      Align = alCustom
      ParentFont = False
      Font.Height = -16
      TabOrder = 1
      OnClick = btnRegistrarClick
    end
  end
  object UniPanel3: TUniPanel
    Left = 0
    Top = 97
    Width = 374
    Height = 249
    Hint = ''
    Align = alClient
    TabOrder = 2
    Caption = ''
    object UniLabel1: TUniLabel
      Left = 24
      Top = 32
      Width = 45
      Height = 19
      Hint = ''
      Caption = 'Login:'
      ParentFont = False
      Font.Height = -16
      TabOrder = 1
    end
    object UniLabel2: TUniLabel
      Left = 24
      Top = 80
      Width = 49
      Height = 19
      Hint = ''
      Caption = 'Senha:'
      ParentFont = False
      Font.Height = -16
      TabOrder = 2
    end
    object UniLabel3: TUniLabel
      Left = 24
      Top = 128
      Width = 63
      Height = 18
      Hint = ''
      Caption = 'Confirme:'
      ParentFont = False
      Font.Height = -15
      TabOrder = 3
    end
    object checkBox: TUniCheckBox
      Left = 24
      Top = 184
      Width = 233
      Height = 17
      Hint = ''
      Caption = 'Concordo com os termos de acordo'
      ParentFont = False
      Font.Height = -13
      TabOrder = 4
    end
    object edtLogin: TUniDBEdit
      Left = 109
      Top = 32
      Width = 224
      Height = 22
      Hint = ''
      DataField = 'NOME'
      DataSource = UniMainModule.dsLogin
      TabOrder = 5
    end
    object edtSenha: TUniDBEdit
      Left = 109
      Top = 80
      Width = 224
      Height = 22
      Hint = ''
      DataField = 'SENHA'
      DataSource = UniMainModule.dsLogin
      TabOrder = 6
    end
    object edtConfSenha: TUniEdit
      Left = 109
      Top = 128
      Width = 224
      Hint = ''
      PasswordChar = '*'
      Text = ''
      TabOrder = 7
    end
  end
  object GrowlMessage: TUniSFiGrowl
    Spacing = 4
    AlertSize = as_Regular
    FAIcon.Icon = fa_info_circle
    FAIcon.Size = fs_32
    FAIcon.Color = fc_white
    iType = it_info
    AnimationEnable = True
    PlacementX = px_left
    ImageIndex = 0
    Left = 24
    Top = 40
  end
end
