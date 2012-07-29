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
    m_hDevice:     THandle;   //�豸���

    //ͬ����
    m_CurImageValue: FCAM_GSP_IMAGE;//��ǰͼ�����
    m_bPacketSet:  Boolean;   //����С�Ƿ�ɵ���

    //�ع�ʱ��
    m_ShutterInfo: FCAM_FEATURE_INFO; //�ع�ʱ����Ϣ
    m_ShutterValue: FCAM_GSP_FEATURE; //�ع�ʱ�����ֵ
    //����
    m_GainInfo: FCAM_FEATURE_INFO; //������Ϣ
    m_GainValue: FCAM_GSP_FEATURE; //�������ֵ
    //����
    m_BrightInfo: FCAM_FEATURE_INFO; //������Ϣ
    m_BrightValue: FCAM_GSP_FEATURE; //���Ȳ���ֵ

  public
    { Public declarations }
    //�����豸���
    procedure SetDeviceHandle(hDevice: THandle);
    //��ʼ�����ڿؼ�
    function InitAdjustFrame():Boolean;
    //��ʼ�����Ե��ڿؼ�
    function InitFeatureAdjust(out CheckOn:TCheckBox; out Slider:TTrackBar; out Value:TEdit; out RBManual:TRadioButton; out RBAuto:TRadioButton;
               out RBOnepush:TRadioButton; out FeatureInfo:FCAM_FEATURE_INFO; out FeatureValue:FCAM_GSP_FEATURE):Boolean;
    //���ù���������Ϣ
    procedure InitSlider(out Slider:TTrackBar; out Value:TEdit; out FeatureInfo:FCAM_FEATURE_INFO; out FeatureValue:FCAM_GSP_FEATURE);
  end;

var
  AdjustForm: TAdjustForm;

implementation

{$R *.dfm}
//�����豸���
procedure TAdjustForm.SetDeviceHandle(hDevice: THandle);
begin
    m_hDevice := hDevice;
end;
//��ʼ�����ڿؼ�
function TAdjustForm.InitAdjustFrame():Boolean;
var
    hRes: Boolean;
begin
    if m_hDevice = 0 then
    begin
        Result := False;
        Abort;
    end;

    //****��**********
    //��õ�ǰ��ͼ�����
    if FCAM_GetParameter(m_hDevice, GSP_IMAGE, @m_CurImageValue) <> FCAM_SUCCESS then
    begin
        Result := False;
        Abort;
    end;

    //ֻ��1394���֧�ְ�����
    if m_CurImageValue.CameraType = CAMERA_1394 then
    begin
        m_bPacketSet := m_CurImageValue.S1394Spec.bPacketSetable;
    end;

    //���ð����ڿؼ�
    ButtonPacketSet.Enabled := m_bPacketSet;
    EditPacket.Enabled := m_bPacketSet;

    //��ȡ��������Ϣ
    if m_bPacketSet = True then
    begin
        //��ʼ�����ؼ�
        PacketMax.Caption := IntToStr(m_CurImageValue.S1394Spec.ulMaxBytePerPacket);
        PacketMin.Caption := IntToStr(m_CurImageValue.S1394Spec.ulUnitBytePerPacket);
        EditPacket.Text := IntToStr(m_CurImageValue.S1394Spec.ulPacketSize);
    end;
    //**************
    //�ع�ʱ��
    m_ShutterInfo.featureType := SHUTTER;
    m_ShutterValue.FeatureType := SHUTTER;
    hRes := InitFeatureAdjust(CheckBoxShutter, TrackBarShutter, EditShutter, RadioButtonSManual, RadioButtonSAuto,
               RadioButtonSOnePush, m_ShutterInfo, m_ShutterValue);
    if hRes = False then
    begin
        Result := False;
        Abort;
    end;
    //����
    m_BrightInfo.featureType := BRIGHTNESS;
    m_BrightValue.FeatureType := BRIGHTNESS;
    hRes := InitFeatureAdjust(CheckBoxBright, TrackBarBright, EditBright, RadioButtonBM, RadioButtonBA, RadioButtonBO, m_BrightInfo, m_BrightValue);
    if hRes = False then
    begin
        Result := False;
        Abort;
    end;

    //����
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

//�ú���ֻ���ֻ��һ��ֵ���ڵ����Բ���������ǰ�ƽ�⣬��Ҫ����������������ʼ���������ƣ�����չ�ú���
function TAdjustForm.InitFeatureAdjust(out CheckOn:TCheckBox; out Slider:TTrackBar; out Value:TEdit; out RBManual:TRadioButton; out RBAuto:TRadioButton;
               out RBOnepush:TRadioButton; out FeatureInfo:FCAM_FEATURE_INFO; out FeatureValue:FCAM_GSP_FEATURE):Boolean;
begin
     //*******���Բ���******
    //��Ϣ
    if FCAM_GetParameterInfo(m_hDevice, FEATURE_INFO, @FeatureInfo) <> FCAM_SUCCESS then
    begin
        Result := False;
        Abort;
    end;
    //������Ϣֵ��ʼ���ع�ʱ����ڿؼ�
    CheckOn.Enabled := FeatureInfo.bCanOnOff and  FeatureInfo.bAvaliable;      //�Ƿ��ܿ��أ�ʼ��/ֹͣʼ��)
    RBManual.Enabled := FeatureInfo.bCanManual and  FeatureInfo.bAvaliable;  //�Ƿ����ֶ�����
    RBAuto.Enabled := FeatureInfo.bCanAuto and  FeatureInfo.bAvaliable;      //�Ƿ����Զ�����
    RBOnepush.Enabled := FeatureInfo.bCanOnePush and  FeatureInfo.bAvaliable;//�Ƿ���һ�ε���

    //��ǰֵ
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @FeatureValue) <> FCAM_SUCCESS then
    begin
        Result := False;
        Abort;
    end;
    //���ݵ�ǰֵ������ʼ�����ڿؼ�
    CheckOn.Checked := FeatureValue.bPresentOn;   //��ǰ״̬
    //�ֶ���ʽ
    if FeatureValue.AdjustMode = MANUAL then
    begin
        RBManual.Checked := True;
        RBAuto.Checked := False;
        RBOnepush.Checked := False;
        
        InitSlider(Slider, Value, FeatureInfo, FeatureValue);

    end
    //�Զ���ʽ
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

//���ù���������Ϣ
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

        //����ֵ
        if FeatureValue.ValueType = LONG_VALUE then
        begin
            lMin := 0;
            lMax := (FeatureInfo.FeatureInfoValue.lMax_Value - FeatureInfo.FeatureInfoValue.lMin_Value)
                                  div FeatureInfo.FeatureInfoValue.lStep;
            //��ǰֵ��Ч
            if FeatureValue.bValueValid = True then
                lPos := (FeatureValue.LongValue.lValue[0] - FeatureInfo.FeatureInfoValue.lMin_Value)
                                  div FeatureInfo.FeatureInfoValue.lStep
            else
                lPos := 0;
            //���ù�����������Ϣ
            Slider.Min := lMin;
            Slider.Max := lMax;
            Slider.Position := lPos;

            Value.Text := IntToStr(FeatureValue.LongValue.lValue[0]);
        end
        //������
        else
        begin
            sMin := 0;
            sMax := (FeatureInfo.FeatureInfoValue.fMax_Value - FeatureInfo.FeatureInfoValue.fMin_Value)
                                  / FeatureInfo.FeatureInfoValue.fStep;
            //��ǰֵ��Ч
            if FeatureValue.bValueValid = True then
                sPos := (FeatureValue.FloatValue.fValue[0] - FeatureInfo.FeatureInfoValue.fMin_Value)
                                  / FeatureInfo.FeatureInfoValue.fStep
            else
                sPos := 0;
            //���ù�����������Ϣ
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
    //��õ�ǰ�ع�ֵ(�Ƽ��û������ø��ֲ���֮ǰ���������Բ�����ͼ������ȣ��Ȼ�õ�ǰֵ�����ڻ�ȡ
    //�Ľṹ��ֵ���޸�����ı��ֵ��Ȼ�������ã������Ͳ���Ҫ���ǲ�ȥ���õ��������������磺�˴���ֻ������
    //ʼ�ܻ��߲�ʹ�ܸ����Ե��ڣ����������ֻ�Ͳ���ֵ�ṹ����FCAM_GSP_FEATURE��bPresentOn�����йأ�
    //�������Ĳ���ֵ�ṹ���е�������Ա����ֵ�磺AdjustMode��ValueType�ȣ�����������֮ǰ�������ĳ�Ա����ֵ
    //Ҳ���뱻��ȷ��䣬��������Ȼ�õ�ǰ�Ĳ���ֵ�����޸�����ĵĳ�Աֵ���Ͳ���Ҫ����������ֵ�����⡣����������
    //����)

    //��õ�ǰ�ع�ʱ��ֵ
    m_ShutterValue.FeatureType := SHUTTER; //FeatureTypeΪ����������������
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue) <> FCAM_SUCCESS then Abort;
    //�ı�����Ҫ���õĳ�Աֵ
    m_ShutterValue.bPresentOn := CheckBoxShutter.Checked;
    //����
    FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue);
end;

procedure TAdjustForm.CheckBoxBrightClick(Sender: TObject);
begin
    //��õ�ǰ����ֵ
    m_BrightValue.FeatureType := BRIGHTNESS; //FeatureTypeΪ����������������
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue) <> FCAM_SUCCESS then Abort;
    //�ı�����Ҫ���õĳ�Աֵ
    m_BrightValue.bPresentOn := CheckBoxBright.Checked;
    //����
    FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue);

end;

procedure TAdjustForm.CheckBoxGainClick(Sender: TObject);
begin
    //��õ�ǰ����ֵ
    m_GainValue.FeatureType := ANG_GAIN; //FeatureTypeΪ����������������
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_GainValue) <> FCAM_SUCCESS then Abort;
    //�ı�����Ҫ���õĳ�Աֵ
    m_GainValue.bPresentOn := CheckBoxGain.Checked;
    //����
    FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_GainValue);
end;

procedure TAdjustForm.RadioButtonSManualClick(Sender: TObject);
begin

    //ѡ���ֶ��ع�ʱ����ڷ�ʽ
    //��õ�ǰ�ع�ʱ��ֵ
    m_ShutterValue.FeatureType := SHUTTER; //FeatureTypeΪ����������������
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue) <> FCAM_SUCCESS then Abort;
    //�����ڷ�ʽ��Ϊ�ֶ�
    m_ShutterValue.AdjustMode := MANUAL;
    //������Ϊ�ֶ�����
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue) <> FCAM_SUCCESS then Abort;

    //�������Ϊ�ֶ���ʽ��ĵ�ǰֵ�����ڳ�ʼ������������
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue) = FCAM_SUCCESS then
    //���óɹ�����ʼ����������ʼ�ܹ�����
    begin
        InitSlider(TrackBarShutter, EditShutter, m_ShutterInfo, m_ShutterValue);
        TrackBarShutter.Enabled := True;
        EditShutter.Enabled := True;
    end;

end;

procedure TAdjustForm.RadioButtonSAutoClick(Sender: TObject);
begin

    //ѡ���Զ��ع�ʱ����ڷ�ʽ
    //��õ�ǰ�ع�ʱ��ֵ
    m_ShutterValue.FeatureType := SHUTTER; //FeatureTypeΪ����������������
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue) <> FCAM_SUCCESS then Abort;
    //�����ڷ�ʽ��Ϊ�ֶ�
    m_ShutterValue.AdjustMode := AUTO;
    //����Ϊ�Զ�����
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue) = FCAM_SUCCESS then
    begin
        TrackBarShutter.Enabled := False;
        EditShutter.Enabled := False;
    end;

end;

procedure TAdjustForm.RadioButtonSOnePushClick(Sender: TObject);
begin

    //ѡ��һ�ε����ع�ʱ����ڷ�ʽ
    //��õ�ǰ�ع�ʱ��ֵ
    m_ShutterValue.FeatureType := SHUTTER; //FeatureTypeΪ����������������
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue) <> FCAM_SUCCESS then Abort;
    //�����ڷ�ʽ��Ϊ�ֶ�
    m_ShutterValue.AdjustMode := ONE_PUSH;
    //����Ϊһ�ε��ڵ���
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue) = FCAM_SUCCESS then
    begin
        TrackBarShutter.Enabled := False;
        EditShutter.Enabled := False;
    end;
end;

procedure TAdjustForm.RadioButtonBMClick(Sender: TObject);
begin

    //ѡ���ֶ����ȵ��ڷ�ʽ
    //��õ�ǰ����ֵ
    m_BrightValue.FeatureType := BRIGHTNESS; //FeatureTypeΪ����������������
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue) <> FCAM_SUCCESS then Abort;
    //�����ڷ�ʽ��Ϊ�ֶ�
    m_BrightValue.AdjustMode := MANUAL;
    //������Ϊ�ֶ�����
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue) <> FCAM_SUCCESS then Abort;

    //�������Ϊ�ֶ���ʽ��ĵ�ǰֵ�����ڳ�ʼ������������
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue) = FCAM_SUCCESS then
    //���óɹ�����ʼ����������ʼ�ܹ�����
    begin
        InitSlider(TrackBarBright, EditBright, m_BrightInfo, m_BrightValue);
        TrackBarBright.Enabled := True;
        EditBright.Enabled := True;
    end;
end;

procedure TAdjustForm.RadioButtonBAClick(Sender: TObject);
begin

     //ѡ���Զ����ȵ��ڷ�ʽ
    //��õ�ǰ����ֵ
    m_BrightValue.FeatureType := BRIGHTNESS; //FeatureTypeΪ����������������
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue) <> FCAM_SUCCESS then Abort;
    //�����ڷ�ʽ��Ϊ�ֶ�
    m_BrightValue.AdjustMode := AUTO;
    //����Ϊ�Զ�����
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue) = FCAM_SUCCESS then
    begin
        TrackBarBright.Enabled := False;
        EditBright.Enabled := False;
    end;

end;

procedure TAdjustForm.RadioButtonBOClick(Sender: TObject);
begin

     //ѡ��һ�ε������ȵ��ڷ�ʽ
    //��õ�ǰ����ֵ
    m_BrightValue.FeatureType := BRIGHTNESS; //FeatureTypeΪ����������������
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue) <> FCAM_SUCCESS then Abort;
    //�����ڷ�ʽ��Ϊһ�ε���
    m_BrightValue.AdjustMode := ONE_PUSH;
    //����Ϊ�Զ�����
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue) = FCAM_SUCCESS then
    begin
        TrackBarBright.Enabled := False;
        EditBright.Enabled := False;
    end;
end;

procedure TAdjustForm.RadioButtonGSClick(Sender: TObject);
begin

    //ѡ���ֶ�������ڷ�ʽ
    //��õ�ǰ����ֵ
    m_GainValue.FeatureType := ANG_GAIN; //FeatureTypeΪ����������������
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_GainValue) <> FCAM_SUCCESS then Abort;
    //�����ڷ�ʽ��Ϊ�ֶ�
    m_GainValue.AdjustMode := MANUAL;
    //������Ϊ�ֶ�����
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_GainValue) <> FCAM_SUCCESS then Abort;

    //�������Ϊ�ֶ���ʽ��ĵ�ǰֵ�����ڳ�ʼ������������
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_GainValue) = FCAM_SUCCESS then
    //���óɹ�����ʼ����������ʼ�ܹ�����
    begin
        InitSlider(TrackBarGain, EditGain, m_GainInfo, m_GainValue);
        TrackBarGain.Enabled := True;
        EditGain.Enabled := True;
    end;

end;

procedure TAdjustForm.RadioButtonGAClick(Sender: TObject);
begin

     //ѡ���Զ�������ڷ�ʽ
    //��õ�ǰ����ֵ
    m_GainValue.FeatureType := ANG_GAIN; //FeatureTypeΪ����������������
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_GainValue) <> FCAM_SUCCESS then Abort;
    //�����ڷ�ʽ��Ϊ�ֶ�
    m_GainValue.AdjustMode := AUTO;
    //����Ϊ�Զ�����
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_GainValue) = FCAM_SUCCESS then
    begin
        TrackBarGain.Enabled := False;
        EditGain.Enabled := False;
    end;

end;

procedure TAdjustForm.RadioButtonGOClick(Sender: TObject);
begin

     //ѡ������һ�ε��ڷ�ʽ
    //��õ�ǰ����ֵ
    m_GainValue.FeatureType := ANG_GAIN; //FeatureTypeΪ����������������
    if FCAM_GetParameter(m_hDevice, GSP_FEATURE, @m_GainValue) <> FCAM_SUCCESS then Abort;
    //�����ڷ�ʽ��Ϊһ�ε���
    m_GainValue.AdjustMode := ONE_PUSH;
    //����Ϊ�Զ�����
    if FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_GainValue) = FCAM_SUCCESS then
    begin
        TrackBarGain.Enabled := False;
        EditGain.Enabled := False;
    end;

end;

//�����������ع�ʱ��
procedure TAdjustForm.TrackBarShutterChange(Sender: TObject);
var
    lValue: Longint;
    fValue: Single;
begin
    //����µĹ���ֵ
    if m_ShutterValue.ValueType = LONG_VALUE then
    begin
        lValue := m_ShutterInfo.FeatureInfoValue.lMin_Value
         + m_ShutterInfo.FeatureInfoValue.lStep * TrackBarShutter.Position;

        //��ֵ��������
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

        //��ֵ��������
        if fValue < m_ShutterInfo.FeatureInfoValue.fMin_Value then fValue := m_ShutterInfo.FeatureInfoValue.fMin_Value;
        if fValue > m_ShutterInfo.FeatureInfoValue.fMax_Value then fValue := m_ShutterInfo.FeatureInfoValue.fMax_Value;
        m_ShutterValue.FloatValue.ulValueCnt := 1;
        m_ShutterValue.FloatValue.fValue[0] := fValue;
        EditShutter.Text := FloatToStr(fValue);
    end;


    //������ֵ
    FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_ShutterValue);

end;

procedure TAdjustForm.TrackBarBrightChange(Sender: TObject);
var
    lValue: Longint;
    fValue: Single;
begin
    //����µĹ���ֵ
    if m_BrightValue.ValueType = LONG_VALUE then
    begin
        lValue := m_BrightInfo.FeatureInfoValue.lMin_Value
         + m_BrightInfo.FeatureInfoValue.lStep * TrackBarBright.Position;

        //��ֵ��������
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

        //��ֵ��������
        if fValue < m_BrightInfo.FeatureInfoValue.fMin_Value then fValue := m_BrightInfo.FeatureInfoValue.fMin_Value;
        if fValue > m_BrightInfo.FeatureInfoValue.fMax_Value then fValue := m_BrightInfo.FeatureInfoValue.fMax_Value;
        m_BrightValue.FloatValue.ulValueCnt := 1;
        m_BrightValue.FloatValue.fValue[0] := fValue;
        EditBright.Text := FloatToStr(fValue);
    end;

    //������ֵ
    FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_BrightValue);
end;

procedure TAdjustForm.TrackBarGainChange(Sender: TObject);
var
    lValue: Longint;
    fValue: Single;
begin
    //����µĹ���ֵ
    if m_GainValue.ValueType = LONG_VALUE then
    begin
        lValue := m_GainInfo.FeatureInfoValue.lMin_Value
         + m_GainInfo.FeatureInfoValue.lStep * TrackBarGain.Position;

        //��ֵ��������
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

        //��ֵ��������
        if fValue < m_GainInfo.FeatureInfoValue.fMin_Value then fValue := m_GainInfo.FeatureInfoValue.fMin_Value;
        if fValue > m_GainInfo.FeatureInfoValue.fMax_Value then fValue := m_GainInfo.FeatureInfoValue.fMax_Value;
        m_GainValue.FloatValue.ulValueCnt := 1;
        m_GainValue.FloatValue.fValue[0] := fValue;
        EditGain.Text := FloatToStr(fValue);
    end;

    //������ֵ
    FCAM_SetParameter(m_hDevice, GSP_FEATURE, @m_GainValue);
end;

procedure TAdjustForm.ButtonPacketSetClick(Sender: TObject);
var
    lPacket: Longword;
begin
    //���ð���С
    lPacket := StrToInt(EditPacket.Text);
    if lPacket < m_CurImageValue.S1394Spec.ulUnitBytePerPacket then lPacket := m_CurImageValue.S1394Spec.ulUnitBytePerPacket;
    if lPacket > m_CurImageValue.S1394Spec.ulMaxBytePerPacket then lPacket := m_CurImageValue.S1394Spec.ulMaxBytePerPacket;
    //�����ǵ�λ��������
    lPacket := lPacket div m_CurImageValue.S1394Spec.ulUnitBytePerPacket * m_CurImageValue.S1394Spec.ulUnitBytePerPacket;

    EditPacket.Text := IntToStr(lPacket);
    m_CurImageValue.S1394Spec.ulPacketSize := lPacket;

    FCAM_SetParameter(m_hDevice, GSP_IMAGE, @m_CurImageValue);

end;

end.
