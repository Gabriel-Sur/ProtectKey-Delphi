object UniMainModule: TUniMainModule
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Height = 345
  Width = 586
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=C:\NovoApp\Dados\KEYPROTECT.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 40
  end
  object dsCredencial: TDataSource
    DataSet = sqlCredencial
    Left = 312
    Top = 96
  end
  object sqlCredencial: TFDQuery
    CachedUpdates = True
    Connection = Conexao
    UpdateOptions.UpdateTableName = 'TB_CREDENCIAL'
    SQL.Strings = (
      'SELECT'
      '    CRE.*'
      'FROM TB_CREDENCIAL CRE'
      'WHERE'
      '    CRE.DESCRICAO like :DESCRICAO'
      '    AND CRE.ID < 0')
    Left = 312
    Top = 40
    ParamData = <
      item
        Name = 'DESCRICAO'
        DataType = ftString
        ParamType = ptInput
        Size = 100
        Value = Null
      end>
    object sqlCredencialID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object sqlCredencialDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 100
    end
    object sqlCredencialSTATUS: TStringField
      DisplayLabel = 'Status'
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Size = 10
    end
    object sqlCredencialID_CATEGORIA: TIntegerField
      DisplayLabel = 'Categoria'
      FieldName = 'ID_CATEGORIA'
      Origin = 'ID_CATEGORIA'
      Required = True
    end
    object sqlCredencialSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 50
    end
    object sqlCredencialLOGIN: TStringField
      DisplayLabel = 'Login'
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      Size = 50
    end
    object sqlCredencialURL: TStringField
      FieldName = 'URL'
      Origin = 'URL'
      Size = 500
    end
  end
  object sqlExecutaGen: TFDQuery
    CachedUpdates = True
    Connection = Conexao
    SQL.Strings = (
      
        'SELECT GEN_ID(GEN_TB_CREDENCIAL_ID, 1) AS NEW_ID FROM RDB$DATABA' +
        'SE')
    Left = 400
    Top = 40
    object sqlExecutaGenNEW_ID: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'NEW_ID'
      Origin = 'NEW_ID'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object sqlGenCategoria: TFDQuery
    CachedUpdates = True
    Connection = Conexao
    SQL.Strings = (
      'SELECT GEN_ID(GEN_TB_CATEGORIA_ID, 1)AS NEW_ID FROM RDB$DATABASE')
    Left = 400
    Top = 104
    object sqlGenCategoriaNEW_ID: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'NEW_ID'
      Origin = 'NEW_ID'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object sqlCategoriaTeste: TFDQuery
    CachedUpdates = True
    Connection = Conexao
    SQL.Strings = (
      'SELECT * FROM TB_CATEGORIA WHERE ID > 0')
    Left = 232
    Top = 40
    object sqlCategoriaTesteID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object sqlCategoriaTesteDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 100
    end
    object sqlCategoriaTesteSTATUS: TStringField
      DisplayLabel = 'Status'
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Size = 10
    end
  end
  object dsCategoriaTeste: TDataSource
    DataSet = sqlCategoriaTeste
    Left = 232
    Top = 96
  end
  object sqlLogin: TFDQuery
    CachedUpdates = True
    Connection = Conexao
    SQL.Strings = (
      'SELECT * FROM TB_LOGIN')
    Left = 144
    Top = 40
    object sqlLoginNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 100
    end
    object sqlLoginID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object sqlLoginSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 50
    end
  end
  object dsLogin: TDataSource
    DataSet = sqlLogin
    Left = 144
    Top = 104
  end
  object sqlGenIDLogin: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'SELECT GEN_ID(GEN_TB_LOGIN_ID, 1) AS NEW_ID FROM RDB$DATABASE')
    Left = 400
    Top = 160
    object sqlGenIDLoginNEW_ID: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'NEW_ID'
      Origin = 'NEW_ID'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object sqlAuxiliar: TFDQuery
    Connection = Conexao
    Left = 88
    Top = 40
  end
end
