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
    object PanelMachines: TPanel
      Left = 9
      Top = 9
      Width = 255
      Height = 416
      Align = alTop
      TabOrder = 0
      object ListBoxMachines: TListBox
        Left = 1
        Top = 1
        Width = 253
        Height = 360
        Align = alTop
        ItemHeight = 15
        TabOrder = 0
        OnClick = ListBoxMachinesClick
      end
      object ButtonAdd: TButton
        Left = 9
        Top = 376
        Width = 75
        Height = 25
        Caption = 'Erstellen'
        TabOrder = 1
        OnClick = ButtonAddClick
      end
      object ButtonEdit: TButton
        Left = 90
        Top = 376
        Width = 75
        Height = 25
        Caption = 'Bearbeiten'
        TabOrder = 2
        OnClick = ButtonEditClick
      end
      object ButtonDelete: TButton
        Left = 171
        Top = 376
        Width = 75
        Height = 25
        Caption = 'L'#246'schen'
        TabOrder = 3
        OnClick = ButtonDeleteClick
      end
    end
  end
  object PanelDetails: TPanel
    Left = 273
    Top = 0
    Width = 511
    Height = 561
    Align = alClient
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    Padding.Bottom = 8
    TabOrder = 1
  end
end
