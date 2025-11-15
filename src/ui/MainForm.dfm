object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Baumaschinen'
  ClientHeight = 561
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object PanelLeft: TPanel
    Left = 0
    Top = 0
    Width = 273
    Height = 561
    Align = alLeft
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    Padding.Bottom = 8
    TabOrder = 0
    object ListBoxMachines: TListBox
      Left = 9
      Top = 9
      Width = 255
      Height = 496
      Align = alTop
      ItemHeight = 15
      TabOrder = 0
    end
    object ButtonAdd: TButton
      Left = 9
      Top = 520
      Width = 75
      Height = 25
      Caption = 'Erstellen'
      TabOrder = 1
      OnClick = ButtonAddClick
    end
    object ButtonEdit: TButton
      Left = 98
      Top = 520
      Width = 75
      Height = 25
      Caption = 'Bearbeiten'
      TabOrder = 2
    end
    object ButtonDelete: TButton
      Left = 187
      Top = 520
      Width = 75
      Height = 25
      Caption = 'L'#246'schen'
      TabOrder = 3
    end
  end
end
