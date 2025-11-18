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
  OnDestroy = FormDestroy
  TextHeight = 15
  object PanelLeft: TPanel
    Left = 0
    Top = 0
    Width = 273
    Height = 561
    Align = alLeft
    BorderWidth = 1
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    Padding.Bottom = 8
    TabOrder = 0
    object SplitterPanels: TSplitter
      Left = 10
      Top = 360
      Width = 253
      Height = 3
      Cursor = crVSplit
      Align = alTop
      Beveled = True
      ExplicitLeft = 9
      ExplicitTop = 281
      ExplicitWidth = 271
    end
    object PanelMachines: TPanel
      Left = 10
      Top = 10
      Width = 253
      Height = 350
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object ListBoxMachines: TListBox
        Left = 0
        Top = 0
        Width = 253
        Height = 309
        Align = alClient
        ItemHeight = 15
        TabOrder = 0
        OnClick = ListBoxMachinesClick
      end
      object PanelMachinesButtons: TPanel
        Left = 0
        Top = 309
        Width = 253
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object ButtonAdd: TButton
          Left = 4
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Erstellen'
          TabOrder = 0
          OnClick = ButtonAddClick
        end
        object ButtonEdit: TButton
          Left = 90
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Bearbeiten'
          TabOrder = 1
          OnClick = ButtonEditClick
        end
        object ButtonDelete: TButton
          Left = 176
          Top = 8
          Width = 75
          Height = 25
          Caption = 'L'#246'schen'
          TabOrder = 2
          OnClick = ButtonDeleteClick
        end
      end
    end
    object PanelWeather: TPanel
      Left = 10
      Top = 363
      Width = 253
      Height = 188
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object MemoWeather: TMemo
        Left = 0
        Top = 41
        Width = 253
        Height = 147
        Align = alClient
        ReadOnly = True
        TabOrder = 0
        ExplicitTop = 104
        ExplicitHeight = 84
      end
      object PanelCity: TPanel
        Left = 0
        Top = 0
        Width = 253
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitLeft = 40
        ExplicitTop = 16
        ExplicitWidth = 185
        object ComboBoxCities: TComboBox
          Left = 4
          Top = 9
          Width = 245
          Height = 23
          Style = csDropDownList
          TabOrder = 0
          OnChange = ComboBoxCitiesChange
        end
      end
    end
  end
  object PanelDetails: TPanel
    Left = 273
    Top = 0
    Width = 511
    Height = 561
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    Padding.Bottom = 8
    TabOrder = 1
  end
end
