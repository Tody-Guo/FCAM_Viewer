unit Adjust;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, FCAM, FCAM_Def, Math;

type
  TAdjustForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    TrackBarShutter: TTrackBar;
    EditPacket: TEdit;
    CheckBoxShutter: TCheckBox;
    EditShutter: TEdit;
    CheckBoxBright: TCheckBox;
    TrackBarBright: TTrackBar;
    EditBright: TEdit;
    CheckBoxGain: TCheckBox;
    TrackBarGain: TTrackBar;
    EditGain: TEdit;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel2: TPanel;
    RadioButtonSManual: TRadioButton;
    RadioButtonSAuto: TRadioButton;
    RadioButtonSOnePush: TRadioButton;
    Panel3: TPanel;
    RadioButtonBM: TRadioButton;
    RadioButtonBA: TRadioButton;
    RadioButtonBO: TRadioButton;
    Panel4: TPanel;
    RadioButtonGS: TRadioButton;
    RadioButtonGA: TRadioButton;
    RadioButtonGO: TRadioButton;
    Label5: TLabel;
    PacketMax: TLabel;
    Label6: TLabel;
    PacketMin: TLabel;
    ButtonPacketSet: TButton;
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxShutterClick(Sender: TObject);
    procedure CheckBoxBrightClick(Sender: TObject);
    procedure CheckBoxGainClick(Sender: TObject);
    procedure RadioButtonSManualClick(Sender: TObject);
    procedure RadioButtonSAutoClick(Sender: TObject);
    procedure RadioButtonSOnePushClick(Sender: TObject);
    procedure RadioButtonBMClick(Sender: TObject);
    procedure RadioButtonBAClick(Sender: TObject);
    procedure RadioButtonBOClick(Sender: TObject);
    procedure RadioButtonGSClick(Sender: TObject);
    procedure RadioButtonGAClick(Sender: TObject);
    procedure RadioButtonGOClick(Sender: TObject);
    procedure TrackBarShutterChange(Sender: TObject);
    procedure TrackBarBrightChange(Sender: TObject);
    procedure TrackBarGainChange(Sender: TObject);
    procedure ButtonPacketSetClick(Sender: TObject);
  private
    { Private declarations }
    m_hDevice:     THandle;   //设备句柄

    //同步包
    m_CurImageValue: FCAM_GSP_IMAGE;//当前图像参数
    m_bPacketSet:  Boolean;   //包大小是否可调节

    //曝光时间
    m_ShutterInfo: FCAM_FEATURE_INFO; //曝光时间信息
    m_ShutterValue: FCAM_GSP_FEATURE; //曝光时间参数值
    //增益
    m_GainInfo: FCAM_FEATURE_INFO; //增益信息
    m_GainValue: FCAM_GSP_FEATURE; //增益参数值
    //亮度
    m_BrightInfo: FCAM_FEATURE_INFO; //亮度信息
    m_BrightValue: FCAM_GSP_FEATURE; //亮度参数值

  public
    { Public declarations }
    //设置设备句柄
    procedure SetDeviceHandle(hDevice: THandle);
    //初始化调节控件
    function InitAdjustFrame():Boolean;
    //初始化特性调节控件
    function InitFeatureAdjust(out CheckOn:TCheckBox; out Slider:TTrackBar; out Value:TEdit; out RBManual:TRadioButton; out RBAuto:TRadioButton;
               out RBOnepush:TRadioButton; out FeatureInfo:FCAM_FEATURE_INFO; out FeatureValue:FCAM_GSP_FEATURE):Boolean;
    //设置滚动条的信息
    procedure InitSlider(out Slider:TTrackBar; out Value:TEdit; out FeatureInfo:FCAM_FEATURE_INFO; out FeatureValue:FCAM_GSP_FEATURE);
  end;

var
  AdjustForm: TAdjustForm;

implementation

{$R *.dfm}
//设置设备句柄
procedure TAdjustForm.SetDeviceHandle(hDevice: THandle);
begin
    m_hDevice := hDevice;
end;
//初始化调节控件
function TAdjustForm.InitAdjustFrame():Boolean;
var
    hRes: Boolean;
begin
    if m_hDevice = 0 then
    begin
        Result := False;
        Abort;
    end;

    //****包**********
    //获得当前的图像参数
    if FCAM_GetParameter(m_hDevice, GSP_IMAGE, @m_CurImageValue) <> FCAM_SUCCESS then
    begin
        Result := False;
        Abort;
    end;

    //只有1394相机支持包设置
    if m_CurImageValue.CameraType = CAMERA_1394 then
    begin
        m_bPacketSet := m_CurImageValue.S1394Spec.bPacketSetable;
    end;

    //设置包调节控件
    ButtonPacketSet.Enabled := m_bPacketSet;
    EditPacket.Enabled := m_bPacketSet;

    //读取包设置信息
    if m_bPacketSet = True then
    begin
        //初始化包控件
        PacketMax.Caption := IntToStr(m_CurImageValue.S1394Spec.ulMaxBytePerPacket);
        PacketMin.Caption := IntToStr(m_CurImageValue.S1394Spec.ulUnitBytePerPacket);
        EditPacket.Text := IntToStr(m_CurImageValue.S1394Spec.ulPacketSize);
    end;
    //**************
    //曝光时间
    m_ShutterInfo.featureType := SHUTTER;
    m_ShutterValue.FeatureType := SHUTTER;
    hRes := InitFeatureAdjust(CheckBoxShutter, TrackBarShutter, EditShutter, RadioButtonSManual, RadioButtonSAuto,
               RadioButtonSOnePush, m_ShutterInfo, m_ShutterValue);
    if hRes = False then
    begin
        Result := False;
        Abort;
    end;
    //亮度
    m_BrightInfo.featureType := BRIGHTNESS;
    m_BrightValue.FeatureType := BRIGHTNESS;
    hRes := InitFeatureAdjust(CheckBoxBright, TrackBarBright, EditBright, RadioButtonBM, RadioButtonBA, RadioButtonBO, m_BrightInfo, m_BrightValue);
    if hRes = False then
    begin
        Result := False;
        Abort;
    end;

    //增益
    m_GainInfo.featureType := ANG_GAIN;
    m_GainValue.FeatureType := ANG_GAIN;
    hRes := InitFeatureAdjust(CheckBoxGain, TrackBarGain, EditGain, RadioButtonGS, RadioButtonGA, RadioButtonGO, m_GainInfo, m_GainValue);
    if hRes = False then
    begin
        Result := False;
        Abort;
    end;
    //*****************

    Result := True;

end;

//该函数只针对只有一个值调节的特性参数，如果是白平衡，需要两个滚动条，但初始化方法类似，可扩展该函数
function TAdjustForm.InitFeatureAdjust(out CheckOn:TCheckBox; out Slider:TTrackBar; out Value:TEdit; out RBManual:TRadioButton; out RBAuto:TRadioButton;
               out RBOnepush:TRadioButton; out FeatureInfo:FCAM_FEATURE_INFO; out FeatureValue:FCAM_GSP_FEATURE):Boolean;
begin
     //*******特性参数******
    //信息
    if FCAM_GetParameterInfo(m_hDevice, FEATURE_INFO, @FeatureInfo) <> FCAM_SUCCESS then
    begin
        Result := False;
        Abort;
    end;
    //根据信息值初始化曝光时间调节控件
    CheckOn.Enabled := FeatureInfo.bCanOnOff and  FeatureInfo.bAvaliable;      //是否能开关（始能/停止始能)
    RBManual.Enabled := FeatureInfo.bCanManual and  FeatureInfo.bAvaliable;  //是否能手动调节
    RBAuto.Enabled := FeatureInfo.bCanAuto and  FeatureInfo.bAvaliable;      //是否能自动调节
    RBOnepush.Enabled := FeatureInfo.bCanOnePush and  FeatureInfo.bAvaliable;//是否能一次调节

    //当前值
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @FeatureValue) <> FCAM_SUCCESS then
    begin
        Result := False;
        Abort;
    end;
    //根据当前值继续初始化调节控件
    CheckOn.Checked := FeatureValue.bPresentOn;   //当前状态
    //手动方式
    if FeatureValue.AdjustMode = MANUAL then
    begin
        RBManual.Checked := True;
        RBAuto.Checked := False;
        RBOnepush.Checked := False;
        
        InitSlider(Slider, Value, FeatureInfo, FeatureValue);

    end
    //自动方式
    else if m_ShutterValue.AdjustMode = AUTO then
    begin
        RBManual.Checked := False;
        RBAuto.Checked := True;
        RBOnepush.Checked := False;
    end
    else
    begin
        RBManual.Checked := False;
        RBAuto.Checked := False;
        RBOnepush.Checked := True;
    end;
    //*********************

    Result := True;

end;

//设置滚动条的信息
procedure TAdjustForm.InitSlider(out Slider:TTrackBar; out Value:TEdit; out FeatureInfo:FCAM_FEATURE_INFO; out FeatureValue:FCAM_GSP_FEATURE);
var
    lMin: Longword;
    lMax: Longword;
    lPos: Longword;
    sMin: Single;
    sMax: Single;
    Spos: Single;
begin
        if FeatureValue.bValueValid = False then Abort;

        //整形值
        if FeatureValue.ValueType = LONG_VALUE then
        begin
            lMin := 0;
            lMax := (FeatureInfo.FeatureInfoValue.lMax_Value - FeatureInfo.FeatureInfoValue.lMin_Value)
                                  div FeatureInfo.FeatureInfoValue.lStep;
            //当前值有效
            if FeatureValue.bValueValid = True then
                lPos := (FeatureValue.LongValue.lValue[0] - FeatureInfo.FeatureInfoValue.lMin_Value)
                                  div FeatureInfo.FeatureInfoValue.lStep
            else
                lPos := 0;
            //设置滚动条滑动信息
            Slider.Min := lMin;
            Slider.Max := lMax;
            Slider.Position := lPos;

            Value.Text := IntToStr(FeatureValue.LongValue.lValue[0]);
        end
        //浮点型
        else
        begin
            sMin := 0;
            sMax := (FeatureInfo.FeatureInfoValue.fMax_Value - FeatureInfo.FeatureInfoValue.fMin_Value)
                                  / FeatureInfo.FeatureInfoValue.fStep;
            //当前值有效
            if FeatureValue.bValueValid = True then
                sPos := (FeatureValue.FloatValue.fValue[0] - FeatureInfo.FeatureInfoValue.fMin_Value)
                                  / FeatureInfo.FeatureInfoValue.fStep
            else
                sPos := 0;
            //设置滚动条滑动信息
            Slider.Min := Ceil(sMin);
            Slider.Max := Ceil(sMax);
            Slider.Position := Ceil(sPos);

            Value.Text := FloatToStr(FeatureValue.FloatValue.fValue[0]);
        end;
end;

procedure TAdjustForm.FormCreate(Sender: TObject);
begin
    m_hDevice := 0;
    m_bPacketSet := False;
end;

procedure TAdjustForm.CheckBoxShutterClick(Sender: TObject);
begin
    //获得当前曝光值(推荐用户在设置各种参数之前，例如特性参数，图像参数等，先获得当前值，再在获取
    //的结构体值中修改你想改变的值，然后再设置，这样就不需要考虑不去设置的其它参数，例如：此处您只想设置
    //始能或者不使能该特性调节，即你的设置只和参数值结构体中FCAM_GSP_FEATURE的bPresentOn变量有关，
    //而不关心参数值结构体中的其它成员变量值如：AdjustMode、ValueType等，但是在设置之前，其它的成员变量值
    //也必须被正确填充，故如果你先获得当前的参数值，再修改你关心的成员值，就不需要考虑其它的值的问题。具体做法可
    //如下)

    //获得当前曝光时间值
    m_ShutterValue.FeatureType := SHUTTER; //FeatureType为输入参数，必须填充
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue) <> FCAM_SUCCESS then Abort;
    //改变你需要设置的成员值
    m_ShutterValue.bPresentOn := CheckBoxShutter.Checked;
    //设置
    FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue);
end;

procedure TAdjustForm.CheckBoxBrightClick(Sender: TObject);
begin
    //获得当前亮度值
    m_BrightValue.FeatureType := BRIGHTNESS; //FeatureType为输入参数，必须填充
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue) <> FCAM_SUCCESS then Abort;
    //改变你需要设置的成员值
    m_BrightValue.bPresentOn := CheckBoxBright.Checked;
    //设置
    FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue);

end;

procedure TAdjustForm.CheckBoxGainClick(Sender: TObject);
begin
    //获得当前增益值
    m_GainValue.FeatureType := ANG_GAIN; //FeatureType为输入参数，必须填充
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_GainValue) <> FCAM_SUCCESS then Abort;
    //改变你需要设置的成员值
    m_GainValue.bPresentOn := CheckBoxGain.Checked;
    //设置
    FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_GainValue);
end;

procedure TAdjustForm.RadioButtonSManualClick(Sender: TObject);
begin

    //选中手动曝光时间调节方式
    //获得当前曝光时间值
    m_ShutterValue.FeatureType := SHUTTER; //FeatureType为输入参数，必须填充
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue) <> FCAM_SUCCESS then Abort;
    //将调节方式该为手动
    m_ShutterValue.AdjustMode := MANUAL;
    //先设置为手动调节
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue) <> FCAM_SUCCESS then Abort;

    //获得设置为手动方式后的当前值，用于初始化滑动调节条
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue) = FCAM_SUCCESS then
    //设置成功，初始化滚动条并始能滚动条
    begin
        InitSlider(TrackBarShutter, EditShutter, m_ShutterInfo, m_ShutterValue);
        TrackBarShutter.Enabled := True;
        EditShutter.Enabled := True;
    end;

end;

procedure TAdjustForm.RadioButtonSAutoClick(Sender: TObject);
begin

    //选中自动曝光时间调节方式
    //获得当前曝光时间值
    m_ShutterValue.FeatureType := SHUTTER; //FeatureType为输入参数，必须填充
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue) <> FCAM_SUCCESS then Abort;
    //将调节方式该为手动
    m_ShutterValue.AdjustMode := AUTO;
    //设置为自动调节
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue) = FCAM_SUCCESS then
    begin
        TrackBarShutter.Enabled := False;
        EditShutter.Enabled := False;
    end;

end;

procedure TAdjustForm.RadioButtonSOnePushClick(Sender: TObject);
begin

    //选中一次调节曝光时间调节方式
    //获得当前曝光时间值
    m_ShutterValue.FeatureType := SHUTTER; //FeatureType为输入参数，必须填充
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue) <> FCAM_SUCCESS then Abort;
    //将调节方式该为手动
    m_ShutterValue.AdjustMode := ONE_PUSH;
    //设置为一次调节调节
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue) = FCAM_SUCCESS then
    begin
        TrackBarShutter.Enabled := False;
        EditShutter.Enabled := False;
    end;
end;

procedure TAdjustForm.RadioButtonBMClick(Sender: TObject);
begin

    //选中手动亮度调节方式
    //获得当前亮度值
    m_BrightValue.FeatureType := BRIGHTNESS; //FeatureType为输入参数，必须填充
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue) <> FCAM_SUCCESS then Abort;
    //将调节方式该为手动
    m_BrightValue.AdjustMode := MANUAL;
    //先设置为手动调节
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue) <> FCAM_SUCCESS then Abort;

    //获得设置为手动方式后的当前值，用于初始化滑动调节条
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue) = FCAM_SUCCESS then
    //设置成功，初始化滚动条并始能滚动条
    begin
        InitSlider(TrackBarBright, EditBright, m_BrightInfo, m_BrightValue);
        TrackBarBright.Enabled := True;
        EditBright.Enabled := True;
    end;
end;

procedure TAdjustForm.RadioButtonBAClick(Sender: TObject);
begin

     //选中自动亮度调节方式
    //获得当前亮度值
    m_BrightValue.FeatureType := BRIGHTNESS; //FeatureType为输入参数，必须填充
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue) <> FCAM_SUCCESS then Abort;
    //将调节方式该为手动
    m_BrightValue.AdjustMode := AUTO;
    //设置为自动调节
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue) = FCAM_SUCCESS then
    begin
        TrackBarBright.Enabled := False;
        EditBright.Enabled := False;
    end;

end;

procedure TAdjustForm.RadioButtonBOClick(Sender: TObject);
begin

     //选中一次调节亮度调节方式
    //获得当前亮度值
    m_BrightValue.FeatureType := BRIGHTNESS; //FeatureType为输入参数，必须填充
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue) <> FCAM_SUCCESS then Abort;
    //将调节方式该为一次调节
    m_BrightValue.AdjustMode := ONE_PUSH;
    //设置为自动调节
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue) = FCAM_SUCCESS then
    begin
        TrackBarBright.Enabled := False;
        EditBright.Enabled := False;
    end;
end;

procedure TAdjustForm.RadioButtonGSClick(Sender: TObject);
begin

    //选中手动增益调节方式
    //获得当前增益值
    m_GainValue.FeatureType := ANG_GAIN; //FeatureType为输入参数，必须填充
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_GainValue) <> FCAM_SUCCESS then Abort;
    //将调节方式该为手动
    m_GainValue.AdjustMode := MANUAL;
    //先设置为手动调节
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_GainValue) <> FCAM_SUCCESS then Abort;

    //获得设置为手动方式后的当前值，用于初始化滑动调节条
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_GainValue) = FCAM_SUCCESS then
    //设置成功，初始化滚动条并始能滚动条
    begin
        InitSlider(TrackBarGain, EditGain, m_GainInfo, m_GainValue);
        TrackBarGain.Enabled := True;
        EditGain.Enabled := True;
    end;

end;

procedure TAdjustForm.RadioButtonGAClick(Sender: TObject);
begin

     //选中自动增益调节方式
    //获得当前增益值
    m_GainValue.FeatureType := ANG_GAIN; //FeatureType为输入参数，必须填充
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_GainValue) <> FCAM_SUCCESS then Abort;
    //将调节方式该为手动
    m_GainValue.AdjustMode := AUTO;
    //设置为自动调节
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_GainValue) = FCAM_SUCCESS then
    begin
        TrackBarGain.Enabled := False;
        EditGain.Enabled := False;
    end;

end;

procedure TAdjustForm.RadioButtonGOClick(Sender: TObject);
begin

     //选中增益一次调节方式
    //获得当前增益值
    m_GainValue.FeatureType := ANG_GAIN; //FeatureType为输入参数，必须填充
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_GainValue) <> FCAM_SUCCESS then Abort;
    //将调节方式该为一次调节
    m_GainValue.AdjustMode := ONE_PUSH;
    //设置为自动调节
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_GainValue) = FCAM_SUCCESS then
    begin
        TrackBarGain.Enabled := False;
        EditGain.Enabled := False;
    end;

end;

//滑动条调节曝光时间
procedure TAdjustForm.TrackBarShutterChange(Sender: TObject);
var
    lValue: Longint;
    fValue: Single;
begin
    //获得新的滚动值
    if m_ShutterValue.ValueType = LONG_VALUE then
    begin
        lValue := m_ShutterInfo.FeatureInfoValue.lMin_Value
         + m_ShutterInfo.FeatureInfoValue.lStep * TrackBarShutter.Position;

        //将值调整合理
        if lValue < m_ShutterInfo.FeatureInfoValue.lMin_Value then  lValue := m_ShutterInfo.FeatureInfoValue.lMin_Value;
        if lValue > m_ShutterInfo.FeatureInfoValue.lMax_Value then  lValue := m_ShutterInfo.FeatureInfoValue.lMax_Value;

        m_ShutterValue.LongValue.ulValueCnt := 1;
        m_ShutterValue.LongValue.lValue[0] := lValue;
        EditShutter.Text := IntToStr(lValue);
    end
    else
    begin
        fValue := m_ShutterInfo.FeatureInfoValue.fMin_Value
           + m_ShutterInfo.FeatureInfoValue.fStep * TrackBarShutter.Position;

        //将值调整合理
        if fValue < m_ShutterInfo.FeatureInfoValue.fMin_Value then fValue := m_ShutterInfo.FeatureInfoValue.fMin_Value;
        if fValue > m_ShutterInfo.FeatureInfoValue.fMax_Value then fValue := m_ShutterInfo.FeatureInfoValue.fMax_Value;
        m_ShutterValue.FloatValue.ulValueCnt := 1;
        m_ShutterValue.FloatValue.fValue[0] := fValue;
        EditShutter.Text := FloatToStr(fValue);
    end;


    //设置新值
    FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue);

end;

procedure TAdjustForm.TrackBarBrightChange(Sender: TObject);
var
    lValue: Longint;
    fValue: Single;
begin
    //获得新的滚动值
    if m_BrightValue.ValueType = LONG_VALUE then
    begin
        lValue := m_BrightInfo.FeatureInfoValue.lMin_Value
         + m_BrightInfo.FeatureInfoValue.lStep * TrackBarBright.Position;

        //将值调整合理
        if lValue < m_BrightInfo.FeatureInfoValue.lMin_Value then  lValue := m_BrightInfo.FeatureInfoValue.lMin_Value;
        if lValue > m_BrightInfo.FeatureInfoValue.lMax_Value then  lValue := m_BrightInfo.FeatureInfoValue.lMax_Value;

        m_BrightValue.LongValue.ulValueCnt := 1;
        m_BrightValue.LongValue.lValue[0] := lValue;
        EditBright.Text := IntToStr(lValue);
    end
    else
    begin
        fValue := m_BrightInfo.FeatureInfoValue.fMin_Value
           + m_BrightInfo.FeatureInfoValue.fStep * TrackBarBright.Position;

        //将值调整合理
        if fValue < m_BrightInfo.FeatureInfoValue.fMin_Value then fValue := m_BrightInfo.FeatureInfoValue.fMin_Value;
        if fValue > m_BrightInfo.FeatureInfoValue.fMax_Value then fValue := m_BrightInfo.FeatureInfoValue.fMax_Value;
        m_BrightValue.FloatValue.ulValueCnt := 1;
        m_BrightValue.FloatValue.fValue[0] := fValue;
        EditBright.Text := FloatToStr(fValue);
    end;

    //设置新值
    FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue);
end;

procedure TAdjustForm.TrackBarGainChange(Sender: TObject);
var
    lValue: Longint;
    fValue: Single;
begin
    //获得新的滚动值
    if m_GainValue.ValueType = LONG_VALUE then
    begin
        lValue := m_GainInfo.FeatureInfoValue.lMin_Value
         + m_GainInfo.FeatureInfoValue.lStep * TrackBarGain.Position;

        //将值调整合理
        if lValue < m_GainInfo.FeatureInfoValue.lMin_Value then  lValue := m_GainInfo.FeatureInfoValue.lMin_Value;
        if lValue > m_GainInfo.FeatureInfoValue.lMax_Value then  lValue := m_GainInfo.FeatureInfoValue.lMax_Value;

        m_GainValue.LongValue.ulValueCnt := 1;
        m_GainValue.LongValue.lValue[0] := lValue;
        EditGain.Text := IntToStr(lValue);
    end
    else
    begin
        fValue := m_GainInfo.FeatureInfoValue.fMin_Value
           + m_GainInfo.FeatureInfoValue.fStep * TrackBarGain.Position;

        //将值调整合理
        if fValue < m_GainInfo.FeatureInfoValue.fMin_Value then fValue := m_GainInfo.FeatureInfoValue.fMin_Value;
        if fValue > m_GainInfo.FeatureInfoValue.fMax_Value then fValue := m_GainInfo.FeatureInfoValue.fMax_Value;
        m_GainValue.FloatValue.ulValueCnt := 1;
        m_GainValue.FloatValue.fValue[0] := fValue;
        EditGain.Text := FloatToStr(fValue);
    end;

    //设置新值
    FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_GainValue);
end;

procedure TAdjustForm.ButtonPacketSetClick(Sender: TObject);
var
    lPacket: Longword;
begin
    //设置包大小
    lPacket := StrToInt(EditPacket.Text);
    if lPacket < m_CurImageValue.S1394Spec.ulUnitBytePerPacket then lPacket := m_CurImageValue.S1394Spec.ulUnitBytePerPacket;
    if lPacket > m_CurImageValue.S1394Spec.ulMaxBytePerPacket then lPacket := m_CurImageValue.S1394Spec.ulMaxBytePerPacket;
    //必须是单位的整数倍
    lPacket := lPacket div m_CurImageValue.S1394Spec.ulUnitBytePerPacket * m_CurImageValue.S1394Spec.ulUnitBytePerPacket;

    EditPacket.Text := IntToStr(lPacket);
    m_CurImageValue.S1394Spec.ulPacketSize := lPacket;

    FCAM_SetParameter(m_hDevice, GSP_IMAGE, @m_CurImageValue);

end;

end.
