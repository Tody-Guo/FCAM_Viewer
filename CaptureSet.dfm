object CapSet: TCapSet
  Left = 483
  Top = 239
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Capture Settings'
  ClientHeight = 296
  ClientWidth = 410
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
    Left = 24
    Top = 16
    Width = 53
    Height = 13
    Caption = 'Save Path:'
  end
  object Edit1: TEdit
    Left = 88
    Top = 16
    Width = 249
    Height = 21
    TabOrder = 0
    Text = 'D:\'
  end
  object Button1: TButton
    Left = 344
    Top = 16
    Width = 41
    Height = 25
    Caption = '...'
    TabOrder = 1
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 48
    Width = 361
    Height = 57
    Caption = 'File Save Type:'
    TabOrder = 2
    object RadioButton1: TRadioButton
      Left = 8
      Top = 24
      Width = 57
      Height = 17
      Caption = '.bmp'
      Enabled = False
      TabOrder = 0
    end
    object RadioButton2: TRadioButton
      Left = 96
      Top = 24
      Width = 49
      Height = 17
      Caption = '.jpeg'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object RadioButton3: TRadioButton
      Left = 184
      Top = 24
      Width = 49
      Height = 17
      Caption = '.raw'
      Enabled = False
      TabOrder = 2
    end
    object RadioButton4: TRadioButton
      Left = 272
      Top = 24
      Width = 49
      Height = 17
      Caption = '.avi'
      Enabled = False
      TabOrder = 3
    end
  end
  object GroupBox2: TGroupBox
    Left = 24
    Top = 112
    Width = 361
    Height = 57
    Caption = 'AVI Option'
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 24
      Width = 51
      Height = 13
      Caption = 'AVI Name:'
    end
    object Label3: TLabel
      Left = 240
      Top = 24
      Width = 32
      Height = 13
      Caption = 'Frame:'
    end
    object Edit2: TEdit
      Left = 64
      Top = 24
      Width = 137
      Height = 21
      Enabled = False
      TabOrder = 0
      Text = 'myAvi'
    end
    object Edit3: TEdit
      Left = 280
      Top = 24
      Width = 57
      Height = 21
      Enabled = False
      TabOrder = 1
      Text = '5'
    end
  end
  object Button2: TButton
    Left = 96
    Top = 248
    Width = 73
    Height = 33
    Caption = '&Ok'
    ModalResult = 1
    TabOrder = 4
  end
  object Button3: TButton
    Left = 240
    Top = 248
    Width = 73
    Height = 33
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object GroupBox3: TGroupBox
    Left = 24
    Top = 176
    Width = 361
    Height = 57
    Caption = 'Timer Setting'
    TabOrder = 6
    object Label4: TLabel
      Left = 16
      Top = 24
      Width = 32
      Height = 13
      Caption = 'Timer: '
    end
    object Label5: TLabel
      Left = 128
      Top = 32
      Width = 13
      Height = 13
      Caption = 'ms'
    end
    object TimerEditTime: TEdit
      Left = 48
      Top = 24
      Width = 73
      Height = 21
      TabOrder = 0
      Text = 'TimerEditTime'
    end
  end
end
