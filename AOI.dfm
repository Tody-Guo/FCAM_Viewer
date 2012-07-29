object AOIForm: TAOIForm
  Left = 441
  Top = 265
  Width = 267
  Height = 126
  Caption = 'Window Adjust'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 48
    Height = 13
    AutoSize = False
    Caption = 'Start Row:'
  end
  object Label2: TLabel
    Left = 120
    Top = 8
    Width = 36
    Height = 13
    AutoSize = False
    Caption = 'Width:'
  end
  object Label3: TLabel
    Left = 8
    Top = 32
    Width = 48
    Height = 13
    AutoSize = False
    Caption = 'Start Line:'
  end
  object Label4: TLabel
    Left = 120
    Top = 32
    Width = 36
    Height = 13
    AutoSize = False
    Caption = 'Height:'
  end
  object Edit_Left: TEdit
    Left = 64
    Top = 0
    Width = 49
    Height = 21
    TabOrder = 0
    Text = 'Edit_Left'
  end
  object Edit_Top: TEdit
    Left = 64
    Top = 32
    Width = 49
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit_Width: TEdit
    Left = 176
    Top = 0
    Width = 49
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Edit_Height: TEdit
    Left = 176
    Top = 32
    Width = 49
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 40
    Top = 64
    Width = 49
    Height = 25
    Caption = '&Ok'
    ModalResult = 1
    TabOrder = 4
  end
  object Button2: TButton
    Left = 120
    Top = 64
    Width = 49
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 5
  end
end
