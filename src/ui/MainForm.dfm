object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'FormMain'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object PanelLeft: TPanel
    Left = 0
    Top = 0
    Width = 250
    Height = 441
    Align = alLeft
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    Padding.Bottom = 8
    TabOrder = 0
    object ListBoxMachines: TListBox
      Left = 9
      Top = 9
      Width = 232
      Height = 423
      Align = alClient
      ItemHeight = 15
      TabOrder = 0
      ExplicitLeft = 112
      ExplicitTop = 192
      ExplicitWidth = 121
      ExplicitHeight = 97
    end
  end
end
