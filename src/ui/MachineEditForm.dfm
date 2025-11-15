object FormMachineEdit: TFormMachineEdit
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Machine Edit'
  ClientHeight = 211
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object LabelBrand: TLabel
    Left = 12
    Top = 19
    Width = 33
    Height = 15
    Caption = 'Marke'
  end
  object LabelModel: TLabel
    Left = 11
    Top = 50
    Width = 37
    Height = 15
    Caption = 'Modell'
  end
  object LabelVIN: TLabel
    Left = 11
    Top = 81
    Width = 19
    Height = 15
    Caption = 'VIN'
  end
  object LabelMachineKind: TLabel
    Left = 11
    Top = 112
    Width = 18
    Height = 15
    Caption = 'Typ'
  end
  object EditBrand: TEdit
    Left = 63
    Top = 16
    Width = 300
    Height = 23
    TabOrder = 0
    Text = 'Volkswagen'
  end
  object EditModel: TEdit
    Left = 62
    Top = 47
    Width = 300
    Height = 23
    TabOrder = 1
    Text = 'VW-12345'
  end
  object EditVIN: TEdit
    Left = 62
    Top = 78
    Width = 300
    Height = 23
    TabOrder = 2
    Text = '12345678901234567'
  end
  object ComboBoxMachineKind: TComboBox
    Left = 63
    Top = 109
    Width = 300
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 3
    Text = '--- Ausw'#228'hlen ---'
    Items.Strings = (
      '--- Ausw'#228'hlen ---'
      'LKW'
      'Kran'
      'Bagger'
      'Hubschrauber')
  end
  object ButtonOk: TButton
    Left = 192
    Top = 160
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 4
    OnClick = ButtonOkClick
  end
  object ButtonCancel: TButton
    Left = 287
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    TabOrder = 5
    OnClick = ButtonCancelClick
  end
end
