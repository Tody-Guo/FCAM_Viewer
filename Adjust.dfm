object AdjustForm: TAdjustForm
  Left = 292
  Top = 137
  Width = 570
  Height = 238
  Caption = 'Video Adjust'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 537
    Height = 145
    BorderStyle = bsSingle
    Caption = 'Panel1'
    TabOrder = 0
    object Label1: TLabel
      Left = 34
      Top = 16
      Width = 57
      Height = 13
      AutoSize = False
      Caption = 'Pack Size:'
      Visible = False
    end
    object Label2: TLabel
      Left = 24
      Top = 48
      Width = 73
      Height = 13
      Caption = 'Exposure Time:'
    end
    object Label3: TLabel
      Left = 24
      Top = 80
      Width = 52
      Height = 13
      Caption = 'Brightness:'
    end
    object Label4: TLabel
      Left = 24
      Top = 112
      Width = 25
      Height = 13
      Caption = 'Gain:'
    end
    object Label5: TLabel
      Left = 168
      Top = 15
      Width = 32
      Height = 13
      Caption = 'Max'#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object PacketMax: TLabel
      Left = 216
      Top = 15
      Width = 54
      Height = 13
      Caption = 'PacketMax'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label6: TLabel
      Left = 88
      Top = 15
      Width = 29
      Height = 13
      Caption = 'Min'#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object PacketMin: TLabel
      Left = 136
      Top = 15
      Width = 51
      Height = 13
      Caption = 'PacketMin'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object TrackBarShutter: TTrackBar
      Left = 104
      Top = 40
      Width = 185
      Height = 33
      Max = 100
      TabOrder = 0
      OnChange = TrackBarShutterChange
    end
    object EditPacket: TEdit
      Left = 264
      Top = 8
      Width = 56
      Height = 21
      TabOrder = 1
      Text = 'EditPacket'
      Visible = False
    end
    object CheckBoxShutter: TCheckBox
      Left = 4
      Top = 48
      Width = 17
      Height = 17
      TabOrder = 2
      OnClick = CheckBoxShutterClick
    end
    object EditShutter: TEdit
      Left = 288
      Top = 40
      Width = 56
      Height = 21
      ReadOnly = True
      TabOrder = 3
      Text = 'EditShutter'
    end
    object CheckBoxBright: TCheckBox
      Left = 4
      Top = 80
      Width = 17
      Height = 17
      TabOrder = 4
      OnClick = CheckBoxBrightClick
    end
    object TrackBarBright: TTrackBar
      Left = 104
      Top = 72
      Width = 185
      Height = 33
      Max = 100
      TabOrder = 5
      OnChange = TrackBarBrightChange
    end
    object EditBright: TEdit
      Left = 288
      Top = 72
      Width = 56
      Height = 21
      ReadOnly = True
      TabOrder = 6
      Text = 'EditShutter'
    end
    object CheckBoxGain: TCheckBox
      Left = 4
      Top = 112
      Width = 17
      Height = 17
      TabOrder = 7
      OnClick = CheckBoxGainClick
    end
    object TrackBarGain: TTrackBar
      Left = 104
      Top = 104
      Width = 185
      Height = 33
      Max = 100
      TabOrder = 8
      OnChange = TrackBarGainChange
    end
    object EditGain: TEdit
      Left = 288
      Top = 104
      Width = 56
      Height = 21
      ReadOnly = True
      TabOrder = 9
      Text = 'EditShutter'
    end
    object Panel2: TPanel
      Left = 348
      Top = 38
      Width = 173
      Height = 25
      BorderStyle = bsSingle
      TabOrder = 10
      object RadioButtonSManual: TRadioButton
        Left = 4
        Top = 4
        Width = 61
        Height = 17
        Caption = 'Manual'
        TabOrder = 0
        OnClick = RadioButtonSManualClick
      end
      object RadioButtonSAuto: TRadioButton
        Left = 64
        Top = 4
        Width = 49
        Height = 17
        Caption = 'Auto'
        TabOrder = 1
        OnClick = RadioButtonSAutoClick
      end
      object RadioButtonSOnePush: TRadioButton
        Left = 112
        Top = 4
        Width = 49
        Height = 17
        Caption = 'Once'
        TabOrder = 2
        OnClick = RadioButtonSOnePushClick
      end
    end
    object Panel3: TPanel
      Left = 348
      Top = 70
      Width = 173
      Height = 25
      BorderStyle = bsSingle
      TabOrder = 11
      object RadioButtonBM: TRadioButton
        Left = 4
        Top = 4
        Width = 53
        Height = 17
        Caption = 'Manual'
        TabOrder = 0
        OnClick = RadioButtonBMClick
      end
      object RadioButtonBA: TRadioButton
        Left = 64
        Top = 4
        Width = 49
        Height = 17
        Caption = 'Auto'
        TabOrder = 1
        OnClick = RadioButtonBAClick
      end
      object RadioButtonBO: TRadioButton
        Left = 112
        Top = 4
        Width = 49
        Height = 17
        Caption = 'Once'
        TabOrder = 2
        OnClick = RadioButtonBOClick
      end
    end
    object Panel4: TPanel
      Left = 348
      Top = 103
      Width = 173
      Height = 25
      BorderStyle = bsSingle
      TabOrder = 12
      object RadioButtonGS: TRadioButton
        Left = 4
        Top = 4
        Width = 53
        Height = 17
        Caption = 'Manual'
        TabOrder = 0
        OnClick = RadioButtonGSClick
      end
      object RadioButtonGA: TRadioButton
        Left = 64
        Top = 4
        Width = 49
        Height = 17
        Caption = 'Auto'
        TabOrder = 1
        OnClick = RadioButtonGAClick
      end
      object RadioButtonGO: TRadioButton
        Left = 112
        Top = 4
        Width = 49
        Height = 17
        Caption = 'Once'
        TabOrder = 2
        OnClick = RadioButtonGOClick
      end
    end
    object ButtonPacketSet: TButton
      Left = 328
      Top = 6
      Width = 73
      Height = 25
      Caption = 'Set Pack'
      TabOrder = 13
      Visible = False
      OnClick = ButtonPacketSetClick
    end
  end
  object Button1: TButton
    Left = 232
    Top = 168
    Width = 75
    Height = 25
    Caption = '&Ok'
    ModalResult = 1
    TabOrder = 1
  end
end
