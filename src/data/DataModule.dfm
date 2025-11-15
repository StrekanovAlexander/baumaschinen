object DM: TDM
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      'LockingMode=Normal'
      'OpenMode=ReadWrite'
      'Synchronous=Full'
      
        'Database=D:\dev\delphi\delphi13\Training\Baumas'#1089'hinen\Win32\Debu' +
        'g\data.db')
    Left = 40
    Top = 16
  end
  object FDQueryExec: TFDQuery
    Connection = FDConnection1
    Left = 40
    Top = 72
  end
  object FDQuerySelect: TFDQuery
    Connection = FDConnection1
    Left = 40
    Top = 136
  end
end
