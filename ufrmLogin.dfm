object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  ClientHeight = 452
  ClientWidth = 374
  Caption = 'Login'
  OldCreateOrder = False
  OnKeyPress = UniFormKeyPress
  BorderIcons = []
  KeyPreview = True
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniPanel1: TUniPanel
    Left = 0
    Top = 0
    Width = 374
    Height = 97
    Hint = ''
    Align = alTop
    TabOrder = 0
    Caption = ''
    object UniLabel1: TUniLabel
      Left = 136
      Top = 24
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
    object btnEntrar: TUniButton
      Left = 72
      Top = 32
      Width = 233
      Height = 41
      Hint = ''
      Caption = 'Entrar'
      ParentFont = False
      Font.Height = -16
      TabOrder = 1
      OnClick = btnEntrarClick
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
    object UniLabel2: TUniLabel
      Left = 16
      Top = 32
      Width = 45
      Height = 19
      Hint = ''
      Caption = 'Login:'
      ParentFont = False
      Font.Height = -16
      TabOrder = 1
    end
    object UniLabel3: TUniLabel
      Left = 16
      Top = 88
      Width = 49
      Height = 19
      Hint = ''
      Caption = 'Senha:'
      ParentFont = False
      Font.Height = -16
      TabOrder = 2
    end
    object ckbCookies: TUniCheckBox
      Left = 16
      Top = 144
      Width = 169
      Height = 17
      Hint = ''
      Caption = 'Lembre-se de mim'
      ParentFont = False
      Font.Height = -16
      TabOrder = 3
    end
    object edtLogin: TUniEdit
      Left = 80
      Top = 32
      Width = 233
      Hint = ''
      Text = ''
      TabOrder = 4
    end
    object edtSenha: TUniEdit
      Left = 80
      Top = 85
      Width = 233
      Hint = ''
      PasswordChar = '*'
      Text = ''
      TabOrder = 5
    end
    object btnCadastrar: TUniButton
      Left = 72
      Top = 194
      Width = 241
      Height = 25
      Hint = ''
      Caption = 'N'#227'o possuo uma conta'
      ParentFont = False
      Font.Height = -13
      TabOrder = 6
      OnClick = btnCadastrarClick
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
