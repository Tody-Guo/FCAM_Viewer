unit MainViewer;

interface

//ע���ڵ���FCAM������������ʱ���ɲμ��������֧��˵���Լ�FCAM����ӿ�˵���е�
//�⿪������˵��������������׵�ʹ��FCAM��

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, AOI, Adjust, FCAM, FCAM_Def, DrawUtil, ToolWin,
  ComCtrls, ImgList, shellapi, inifiles, Raw2Rgb, BayerDef;  //�����DLL���������ݽṹFCAM, FCAM_Def, DrawUtil, raw2rgb

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    C1: TMenuItem;
    Start: TMenuItem;
    Stop: TMenuItem;
    Exit: TMenuItem;
    A1: TMenuItem;
    AOI: TMenuItem;
    VideoAdjust: TMenuItem;
    ScrollBoxShow: TScrollBox;
    ShowPanel: TPanel;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    H1: TMenuItem;
    A2: TMenuItem;
    tb_StartCapture: TToolButton;
    ImageList1: TImageList;
    tb_captureAPic: TToolButton;
    tb_videoAdjust: TToolButton;
    tb_cameraProp: TToolButton;
    tb_windowSetting: TToolButton;
    tb_CaptureSettings: TToolButton;
    tb_zoomUp: TToolButton;
    tb_zoomIn: TToolButton;
    tb_saveConfig: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    tb_fullscreen: TToolButton;
    Timer1: TTimer;
    tb_timerCapture: TToolButton;
    tb_browserImage: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton1: TToolButton;
    tb_softtriger: TToolButton;
    Settings1: TMenuItem;
    SoftTriger1: TMenuItem;
    procedure StartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StopClick(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure AOIClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure VideoAdjustClick(Sender: TObject);
    procedure MyTransMsgProc(var msg: TMessage); message WM_FCAM_MESSAGE;
    procedure A2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tb_StartCaptureClick(Sender: TObject);
    procedure tb_captureAPicClick(Sender: TObject);
    procedure tb_windowSettingClick(Sender: TObject);
    procedure tb_videoAdjustClick(Sender: TObject);
    procedure tb_CaptureSettingsClick(Sender: TObject);
    procedure tb_fullscreenClick(Sender: TObject);
    procedure tb_timerCaptureClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure tb_zoomUpClick(Sender: TObject);
    procedure tb_browserImageClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure tb_softtrigerClick(Sender: TObject);
    procedure tb_zoomInClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SoftTriger1Click(Sender: TObject);
  private
  { Private declarations }
  public
    { Public declarations }

    m_hDev:          THandle;    //�豸���
    m_hDraw:         THandle;    //��ͼ���
    m_bCapture:      Boolean;
    m_DataTransInfo: FCAM_DATATRANS_INFO;  //���ݴ�����Ϣ
    m_CurImage:      FCAM_GSP_IMAGE;       //��ǰͼ�����
    m_ImageInfo:     FCAM_IMAGE_INFO;      //ͼ����Ϣ
    m_lShowWidth:    Longword;            //ͼ���ڴ�����ʾ�Ŀ��
    m_lShowHeight:   Longword;            //ͼ���ڴ�����ʾ�ĸ߶�
    m_lBitCnt:       Longword;            //ͼ��λ��
    pCommuInfo:      PFCAM_COMMU_INFO;
    TriggerInfo:     FCAM_TRIGGER_INFO;

    // Full screen mode parameters
    FOldWinState:       TWindowState;
    OldState,OldHeight,OldWidth,OldX,OldY:  Longint;

    // Config parameters
    savePath : String;
    saveFileType: Integer;
    TimerTime: Integer;

    rcIn, rcOut: RECT;

  public
    //����,�豸���
    procedure DeviceClear();
    //׼����ͼ��Դ
    procedure PrepareForDraw();
    //���ٻ�ͼ��Դ
    procedure ClearDraw();
    //Ϊ��ʾ������ʾ����
    procedure SetShowZone();
    function zoomFunc(lWidth :Longword; lHeight:Longword): boolean;

  end;


var
  Form1: TForm1;

implementation

uses CaptureSet;

{$R *.dfm}
//��Ϣ������
procedure TForm1.MyTransMsgProc(var msg: TMessage);
var
    bChange:   Boolean;
    pRGB : PRGBTRIPLE;
begin

     //�ɹ�ȡ��һ֡ͼ�����ݵ���Ϣ
     if (msg.WParam = WM_FCAM_ONE_RSVD) then
    begin
        //��ô����������Ϣ�ṹ��ָ��
        pCommuInfo  :=  Pointer(msg.LParam);  //msg.LParam��ֵ������Ϣ�ṹ���ַ

        bChange := False;
        if m_lShowWidth <> pCommuInfo.ulFrameWidth then  bChange := True;
        if m_lShowHeight <> pCommuInfo.ulFrameHeight then  bChange := True;
//        if m_lBitCnt <> pCommuInfo.ulFramePixelBits then  bChange := True;

        //ͼ���С�б䶯��Ӧ���´�����ͼ��Դ
        if bChange = True then
        begin
            m_lShowWidth := pCommuInfo.ulFrameWidth;
            m_lShowHeight := pCommuInfo.ulFrameHeight;
            if not (m_Imageinfo.ColorFilterPattern = NONE) then
              m_lBitCnt := 24   //pCommuInfo.ulFramePixelBits;
            else
              m_lBitCnt := pCommuInfo.ulFramePixelBits;

            //���´�����ͼ��Դ
            PrepareForDraw();
            //����������ʾ����λ�úʹ�С��������ʾ
            SetShowZone();
        end;

        rcIn.left   := 0;
        rcIn.top    := 0;
        rcIn.right  := m_ImageInfo.ulMaxWidthSize;
        rcIn.bottom := m_ImageInfo.ulMaxHeightSize;

        rcOut.left  := ShowPanel.Left;
        rcOut.top   := ShowPanel.Top;
        rcOut.right := ShowPanel.Width;
        rcout.bottom:= ShowPanel.Height;

        //��ʾͼ��, �û�Ҳ��ʹ���Լ�����ʾ����
        //����Ҫ����ͼ�񣬿ɵ���DrawUtil��������ʾ����
          GetMem(pRGB, 3*pCommuInfo.ulFrameWidth*pCommuInfo.ulFrameHeight);  // apply for memory
          if FC_Raw2Rgb(pRGB, pCommuInfo.pDataBuffer, pCommuInfo.ulFrameWidth, pCommuInfo.ulFrameHeight
                      , BAYER_GR, ARITH_NEAREST_NEIGHBER) = 0 then
          begin
            StatusBar1.Panels.Items[0].Text := 'BW Format';
          end;
//          FD_DrawImage(m_hDraw, pRGB, 3*pCommuInfo.ulFrameWidth*pCommuInfo.ulFrameHeight, 0,0,0,0);
          FD_DrawImageEx(m_hDraw, pRGB, 3*pCommuInfo.ulFrameWidth*pCommuInfo.ulFrameHeight, rcIn, rcOut);

          StatusBar1.Panels.Items[1].Text := 'Bit: ' + IntToStr(m_lBitCnt) +
                  'Max Size: ' + IntToStr(m_ImageInfo.ulMaxWidthSize) +'x' +
                  IntToStr(m_ImageInfo.ulMaxHeightSize);

          freeMem(pRGB);  // destory memory

//          FD_DrawImage(m_hDraw, pCommuInfo.pDataBuffer, pCommuInfo.ulFrameAvaliableSizes, 0, 0, 0, 0);
    end;

end;

procedure TForm1.DeviceClear();
begin
    if m_hDev <> 0 then
    begin
        //����ǰ�ڴ��䣬ֹͣ����
        if m_bCapture = true then
        begin
            FCAM_StopCapture(m_hDev);
            m_bCapture := False;
        end;
        //�ͷ��豸���
        FCAM_ReleaseDevice(m_hDev);
        m_hDev := 0;
    end;
end;

procedure TForm1.PrepareForDraw();
begin
    ClearDraw();
    //������ͼ����
    m_hDraw := FD_CreateDraw(ShowPanel.Handle, m_lShowWidth, m_lShowHeight, m_lBitCnt, False, True);
end;

procedure TForm1.ClearDraw();
begin
    if m_hDraw <> 0 then
    begin
        FD_ReleaseDraw(m_hDraw);
        m_hDraw := 0;
    end;

end;

procedure TForm1.SetShowZone();
var
    lFrameWidth: Longword;
    lFrameHeight: Longword;
begin
    //��ô��ڴ�С
    lFrameWidth := ScrollBoxShow.Width;
    lFrameHeight := ScrollBoxShow.Height;
    //������ʾpanel�Ĵ�С
    ShowPanel.Width := m_lShowWidth;
    ShowPanel.Height := m_lShowHeight;
    //��ʾpanel��λ��
    if  lFrameWidth > m_lShowWidth then ShowPanel.Left :=  (lFrameWidth - m_lShowWidth) div 2
    else
        ShowPanel.Left := 0;
    if  lFrameHeight > m_lShowHeight then  ShowPanel.Top := (lFrameHeight - m_lShowHeight) div 2
    else
        ShowPanel.Top := 0;
end;

procedure TForm1.StartClick(Sender: TObject);
var
    hRes: HRESULT;
    TransParam: FCAM_GSP_TRANS;

begin

    if m_hDev = 0 then
    begin
        //�����Ϊ1��1394�豸, CAMERA_1394��ΪCAMERA_USB���USB�ӿڵ�ID��IEϵ�����
        //support USB and 1394 cam, USB is default device.
        m_hDev := FCAM_GetDevice(1, CAMERA_USB);
        if (m_hDev = 0) then
        begin
            m_hDev := FCAM_GetDevice(1, CAMERA_1394);
            if ( m_hDev = 0) then
            begin
              Application.MessageBox('����豸ʧ��!', '֪ͨ');
              tb_StartCapture.Down := false;
              tb_StartCapture.ImageIndex := 0;
              abort;
            end;            
        end;

        //������ݴ�����Ϣ
        hRes := FCAM_GetParameterInfo(m_hDev, DATATRANS_INFO, @m_DataTransInfo); //@ȡ��ַ��
        if (hRes <> FCAM_SUCCESS) then
        begin
            DeviceClear;
            Application.MessageBox('������ݴ�����Ϣʧ��!', '֪ͨ');
            abort;
        end;

        //����ǰ�Ƿ�֧����������ģʽ
        if (m_DataTransInfo.bCanContinusShot = False) then
        begin
            DeviceClear;
            Application.MessageBox('�������֧�������ɼ�ģʽ!', '֪ͨ');
            abort;
        end;

        //������Ϣ���շ�ʽ
        hRes := FCAM_SetMessageNotifyWindow(m_hDev, Form1.Handle, nil);
        if (hRes <> FCAM_SUCCESS) then
        begin
            DeviceClear;
            Application.MessageBox('������Ϣ���շ�ʽʧ��!', '֪ͨ');
            abort;
        end;

        //��õ�ǰͼ�����
        hRes := FCAM_GetParameter(m_hDev, GSP_IMAGE, @m_CurImage);
        if (hRes <> FCAM_SUCCESS) then
        begin
            DeviceClear;
            Application.MessageBox('��õ�ǰͼ�����ʧ��!', '֪ͨ');
            abort;
        end;

        //ָ���������Ϊ��ǰͼ�����Ƶ��ʽ,��ָ����������Ƶ��ʽ�����õ���������Ƶ��ʽ��ͼ����Ϣ
        m_ImageInfo.FormatMode := m_CurImage.FormatMode;
        //��õ�ǰ��Ƶ��ʽ��ͼ����Ϣ���Ƿ񿪴������ڵ�λ��֧�ֵ����ظ�ʽ�ȵ���Ϣ
        hRes := FCAM_GetParameterInfo(m_hDev, IMAGE_INFO, @m_ImageInfo);
        if (hRes <> FCAM_SUCCESS) then
        begin
            DeviceClear;
            Application.MessageBox('��õ�ǰͼ����Ϣʧ��!', '֪ͨ');
            abort;
        end;
    end;

    //�������ݴ���
    if m_bCapture = False then
    begin
        //��õ�ǰ�Ĵ������ֵ
        if FCAM_GetParameter(m_hDev, GSP_TRANS, @TransParam) <> FCAM_SUCCESS then
        begin
            DeviceClear;
            Application.MessageBox('������ݴ��䵱ǰֵʧ��!', '֪ͨ');
            abort;
        end;
        //���ô���ģʽΪ��������ģʽ
        TransParam.TransMode := CONTINUOUS_SHOT;
        if FCAM_SetParameter(m_hDev, GSP_TRANS, @TransParam) <> FCAM_SUCCESS then
        begin
            DeviceClear;
            Application.MessageBox('�������ݴ���ֵʧ��!', '֪ͨ');
            abort;
        end;

        //��������
        if FCAM_StartCapture(m_hDev) <> FCAM_SUCCESS then
        begin
            DeviceClear;
            Application.MessageBox('�������ݴ���ʧ��!', '֪ͨ');
            abort;
        end;

        m_bCapture := True;
    end;

end;
//���ڴ���
procedure TForm1.FormCreate(Sender: TObject);
var
  ini: TINIFILE;
begin
    //��ʼ������
    m_hDev := 0;
    m_bCapture := False;
    m_lShowWidth := 0;
    m_lShowHeight := 0;
    m_hDraw := 0;
    m_lBitCnt := 0;

    if (not FileExists('.\FCAM_Setting.ini')) then
    begin
      Application.MessageBox('FCAM_Setting.iniδ�ҵ�!', '����', MB_ICONERROR);
      abort ;
    end;

    ini := TIniFile.Create('.\FCAM_Setting.ini');
    savepath := ini.ReadString('CAPTURE_SETTING', 'Savepath', '');
    saveFileType := ini.ReadInteger('CAPTURE_SETTING', 'SaveFileType', -1);
    TimerTime := ini.ReadInteger('CAPTURE_SETTING', 'Timer', 1);

    ini.Free;

end;
//��������
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    //ȷ���豸��Դ������
    DeviceClear();
    //���ٻ�ͼ��Դ
    ClearDraw();
end;

procedure TForm1.StopClick(Sender: TObject);
begin
    //ֹͣ���ݴ���
    if  m_bCapture = True then
    begin
        FCAM_StopCapture(m_hDev);
        m_bCapture := False;
    end;
end;

procedure TForm1.ExitClick(Sender: TObject);
begin
    //ȷ���豸��Դ������
    DeviceClear();
    //���ٻ�ͼ��Դ
    ClearDraw();
    Application.Terminate;
end;

procedure TForm1.AOIClick(Sender: TObject);
var
  lLeft   : LongWord;
  lTop    : LongWord;
  lWidth  : LongWord;
  lHeight : LongWord;
begin
    if m_hDev <> 0 then
    begin
        if m_ImageInfo.bAOI = True then
        begin
            //��ʼ�������Ŀؼ�ֵ
            AOIForm.Edit_Left.Text := IntToStr(m_CurImage.ulLeft);
            AOIForm.Edit_Top.Text := IntToStr(m_CurImage.ulTop);
            AOIForm.Edit_Width.Text := IntToStr(m_CurImage.ulWidth);
            AOIForm.Edit_Height.Text := IntToStr(m_CurImage.ulHeight);

            //�û�������ͼ��Ŀ���λ��
            if AOIForm.ShowModal = mrOK then
            begin
                //����û�������ֵ
                lLeft := StrToInt(AOIForm.Edit_Left.Text);
                lTop := StrToInt(AOIForm.Edit_Top.Text);
                lWidth := StrToInt(AOIForm.Edit_Width.Text);
                lHeight := StrToInt(AOIForm.Edit_Height.Text);

                //���ڿ���λ��Ϊ����ֵ
                //��ʼ�в���С��0
                if lLeft < 0 then lLeft := 0;
                //��ʼ�в�Ӧ�ô���ͼ�������ȼ���ȵ���Сֵ
                if lLeft > (m_ImageInfo.ulMaxWidthSize - m_ImageInfo.ulWidthSizeUnit) then
                    lLeft := m_ImageInfo.ulMaxWidthSize - m_ImageInfo.ulWidthSizeUnit;
                //��ʼ��Ӧ���ǰ���ʼ�е�λΪ��λ
                lLeft := lLeft div m_ImageInfo.ulLeftPosUnit * m_ImageInfo.ulLeftPosUnit;

                 //��ʼ�в���С��0
                if lTop < 0  then lTop := 0;
                //��ʼ�в�Ӧ�ô���ͼ������߶ȼ��߶ȵ���Сֵ
                if lTop > (m_ImageInfo.ulMaxHeightSize - m_ImageInfo.ulHeightSizeUnit) then
                    lTop := m_ImageInfo.ulMaxHeightSize - m_ImageInfo.ulHeightSizeUnit;
                //��ʼ��Ӧ���ǰ���ʼ�е�λΪ��λ
                lTop := lTop div m_ImageInfo.ulTopPosUnit * m_ImageInfo.ulTopPosUnit;

                //ͼ���Ȳ���С����С��ȣ������ڵ�λ��
                if lWidth < m_ImageInfo.ulWidthSizeUnit then lWidth := m_ImageInfo.ulWidthSizeUnit;
                //ͼ����ʼ�к�ͼ����֮�Ͳ��ܴ��������
                if lWidth > (m_ImageInfo.ulMaxWidthSize - lLeft) Then
                    lWidth := m_ImageInfo.ulMaxWidthSize - lLeft;
                //ͼ����Ӧ�ð���ȵ��ڵ�λΪ��λ
                lWidth := lWidth div m_ImageInfo.ulWidthSizeUnit * m_ImageInfo.ulWidthSizeUnit;
                //ͼ�������ĵ���������������ʾ���û���ѡ���Ƿ���Ӹ������
                lWidth := lWidth div 4 * 4;
                
                //ͼ��߶Ȳ���С����С�߶�
                if lHeight < m_ImageInfo.ulHeightSizeUnit then lHeight := m_ImageInfo.ulHeightSizeUnit;
                //ͼ����ʼ�к͸߶�֮�Ͳ��ܴ������߶�
                if lHeight > (m_ImageInfo.ulMaxHeightSize - lTop) Then
                    lHeight := m_ImageInfo.ulMaxHeightSize - lTop;
                //ͼ��߶�Ӧ�ð��߶ȵ��ڵ�λΪ��λ
                lHeight := lHeight div m_ImageInfo.ulHeightSizeUnit * m_ImageInfo.ulHeightSizeUnit;

                m_CurImage.ulLeft := lLeft;
                m_CurImage.ulTop := lTop;
                m_CurImage.ulWidth := lWidth;
                m_CurImage.ulHeight := lHeight;

                //����ͼ�񿪴�
                if FCAM_SetParameter(m_hDev, GSP_IMAGE, @m_CurImage) <> FCAM_SUCCESS then
                begin
                    Application.MessageBox('����ʧ�ܣ�������!', '֪ͨ');
                end;
                ShowPanel.Refresh;
            end;
        end;
    end;

end;

procedure TForm1.FormResize(Sender: TObject);
begin
    SetShowZone();
end;

procedure TForm1.VideoAdjustClick(Sender: TObject);
begin
    if m_hDev <> 0 then
    begin
        AdjustForm.SetDeviceHandle(m_hDev);
        if AdjustForm.InitAdjustFrame() = True then AdjustForm.ShowModal;
    end;
end;

procedure TForm1.A2Click(Sender: TObject);
begin
  Application.MessageBox('FCAM View(Message) '+char(10)+char(13)+'(c) Tody 2012, T-Ware Inc.',
         'About', 48);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if ( m_hDev <> 0 ) then
  begin
    DeviceClear();
    ClearDraw();
  end;
end;

procedure TForm1.tb_StartCaptureClick(Sender: TObject);
begin
  if ((tb_StartCapture.Down = true)) then
  begin
    tb_StartCapture.ImageIndex := 1;
    StartClick(Sender);
  end
  else
  begin
    StopClick(Sender);
    tb_StartCapture.ImageIndex := 0;

  end;  
end;

procedure TForm1.tb_captureAPicClick(Sender: TObject);
Var
  FileName: String;
begin
  if m_hDraw <> 0 then
  begin
    FileName:=savepath+'/FCAM-'+FormatDateTime('yyyymmddhhnnss', Now);
    FD_DrawImage(m_hDraw, pCommuInfo.pDataBuffer, pCommuInfo.ulFrameAvaliableSizes, 0, 0, 0, 0)  ;
    FD_SaveImage(m_hDraw, PChar(FileName), FD_FILE_TYPE(saveFileType));
  end
  else
    Application.MessageBox('�豸δ���ӻ�δ����', '����', 48);
end;

procedure TForm1.tb_windowSettingClick(Sender: TObject);
begin
  AOIClick(Sender);  
end;

procedure TForm1.tb_videoAdjustClick(Sender: TObject);
begin
  VideoAdjustClick(Sender);
end;

procedure TForm1.tb_CaptureSettingsClick(Sender: TObject);
var
  ini: TINIFILE;
begin
  ini := TINIFILE.Create('.\FCAM_Setting.ini');
  CapSet.Edit1.Text := SavePath;
  CapSet.TimerEditTime.Text := IntToStr(TimerTime);
  
  if CapSet.ShowModal = mrOk then
  begin
    ini.WriteString('CAPTURE_SETTING', 'Savepath', CapSet.Edit1.Text);
    Savepath := CapSet.Edit1.Text;

    if CapSet.RadioButton2.Checked = true then
    begin
      ini.WriteInteger('CAPTURE_SETTING', 'SaveFileType', 1);
      saveFileType := 1;
    end;

    if StrToInt(CapSet.TimerEditTime.Text) > 0 then
    begin
      ini.WriteInteger('CAPTURE_SETTING', 'Timer', StrToInt(CapSet.TimerEditTime.Text));
      TimerTime := StrToInt(CapSet.TimerEditTime.Text);
    end else
      ini.WriteInteger('CAPTURE_SETTING', 'Timer', 1);
      
  end;
  ini.Free;
end;

procedure TForm1.tb_fullscreenClick(Sender: TObject);
begin

//  if m_hDev = 0 then
//  begin
//    Application.MessageBox('�豸δ����', '��ʾ', MB_ICONEXCLAMATION);
//    tb_fullscreen.Down := False;
//    abort;
//  end;
  
  if tb_fullscreen.Down = true then
  begin
    OldState:=GetWindowLong(Form1.Handle, GWL_STYLE);
    OldHeight:=Form1.Height;
    OldWidth:=Form1.Width;
    OldX:=Form1.Left ;
    OldY:=Form1.Top;
    FOldWinState := Form1.WindowState;
    Form1.Top:=0;
    Form1.Left:=0;
    Form1.WindowState:=wsmaximized;
    SetWindowLong(Form1.Handle, GWL_STYLE,
                 GetWindowLong(Form1.Handle, GWL_STYLE) AND NOT WS_CAPTION);
    ToolBar1.Visible := false;
    Statusbar1.Visible := false;
    Form1.Menu := nil;
    Form1.ClientHeight:=Screen.Height;
    ScrollBoxShow.BorderStyle := bsNone;
    Form1.Refresh;
  end
  else
  begin
    SetWindowLong(Form1.Handle, GWL_STYLE, OldState);
    Form1.Height:= oldHeight;
    Form1.Width:=oldwidth;
    Form1.Left:=OldX;
    Form1.Top:=OldY;
    Form1.WindowState:= FOldWinState;
    ToolBar1.Visible := true;
    Form1.Menu:=MainMenu1;
    StatusBar1.Visible :=True;
    ScrollBoxShow.BorderStyle := bsSingle;
    Form1.Refresh;
  end;

//    DeviceClear();
    PrepareForDraw();
    SetShowZone();
    StartClick(Sender);

end;

procedure TForm1.tb_timerCaptureClick(Sender: TObject);
begin
  if m_hDev = 0 then
  begin
    Application.MessageBox('�豸δ����', '��ʾ', MB_ICONEXCLAMATION);
    tb_timerCapture.Down := False;
    abort;
  end;

  if tb_timerCapture.Down = true then
  begin
    Timer1.Interval := TimerTime  ;
    Timer1.Enabled:=true;
  end else
    Timer1.Enabled:=False;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
if m_hDraw <> 0 then
      tb_softtrigerClick(Sender);
end;

procedure TForm1.tb_zoomUpClick(Sender: TObject);
var
  lWidth  :Longword;
  lheight :Longword;
begin
    if m_hDev = 0 then
    begin
      Application.MessageBox('�豸δ��', '����', MB_ICONWARNING);
      abort;
    end;

    if FCAM_GetParameter(m_hDev, GSP_IMAGE, @m_CurImage) <> FCAM_SUCCESS then
    begin
      Application.MessageBox('����ʧ�ܣ�������!', '֪ͨ');
    end;


    lWidth := m_CurImage.ulWidth + 100;
    lHeight := round((m_CurImage.ulHeight*lWidth)/(m_CurImage.ulWidth));

    // call zoom function now
    zoomFunc(lWidth, lHeight);
end;

procedure TForm1.tb_browserImageClick(Sender: TObject);
begin
  ShellExecute(application.Handle,'open','explorer.exe',
                  pchar(savepath), nil, 1);
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  ExitClick(Sender);
end;

procedure TForm1.tb_softtrigerClick(Sender: TObject);
var
  gspTrigger: FCAM_GSP_TRIGGER;
begin
//  Function for Soft Trigger...
  if (m_hDev <> 0) then
  begin
    if FCAM_GetParameterInfo(m_hDev, TRIGGER_INFO, @TriggerInfo) = FCAM_SUCCESS then
    begin
      if TriggerInfo.bAvaliable then
      begin
        if TriggerInfo.bCanOnOff then
        begin
          if FCAM_GetParameter(m_hDev, GSP_TRIGGER, @gspTrigger) = FCAM_SUCCESS then
          begin
            gspTrigger.bPresentOn   := TRUE;
            gspTrigger.TrgSorce     := TRIGGER_SOFT;
            gspTrigger.ulTrgleMode  := 0;
            if FCAM_SetParameter(m_hDev, GSP_TRIGGER, @gspTrigger) = FCAM_SUCCESS then
            begin
                  FCAM_SoftWareTrigger(m_hDev);
                  SoftTriger1.Checked := True;
            end;
          end;
        end else
        begin
           StatusBar1.Panels.Items[1].Text := 'Can not do Soft Trigger ';
           Abort;
        end;
      end;
    end;
  end;
end;

procedure TForm1.tb_zoomInClick(Sender: TObject);
var
  lWidth :Longword;
  lHeight  :Longword;
begin
    if m_hDev = 0 then
    begin
      Application.MessageBox('�豸δ��', '����', MB_ICONWARNING);
      abort;
    end;

    if FCAM_GetParameter(m_hDev, GSP_IMAGE, @m_CurImage) <> FCAM_SUCCESS then
    begin
      Application.MessageBox('����ʧ�ܣ�������!', '֪ͨ');
    end;


    lWidth := m_CurImage.ulWidth - 100;
    lHeight := round((m_CurImage.ulHeight*lWidth)/(m_CurImage.ulWidth));

    // call zoom function now
    zoomFunc(lWidth, lHeight);
    
end;

function TForm1.zoomFunc(lWidth :Longword; lHeight:Longword): Boolean;
var
  lLeft :Longword;
  lTop  :Longword;
begin
    if m_hDev <> 0 then
    begin
        if m_ImageInfo.bAOI = True then
        begin
          lLeft := 0;
          lTop  := 0;


                //���ڿ���λ��Ϊ����ֵ
                //��ʼ�в���С��0
                if lLeft < 0 then lLeft := 0;
                //��ʼ�в�Ӧ�ô���ͼ�������ȼ���ȵ���Сֵ
                if lLeft > (m_ImageInfo.ulMaxWidthSize - m_ImageInfo.ulWidthSizeUnit) then
                    lLeft := m_ImageInfo.ulMaxWidthSize - m_ImageInfo.ulWidthSizeUnit;
                //��ʼ��Ӧ���ǰ���ʼ�е�λΪ��λ
                lLeft := lLeft div m_ImageInfo.ulLeftPosUnit * m_ImageInfo.ulLeftPosUnit;

                 //��ʼ�в���С��0
                if lTop < 0  then lTop := 0;
                //��ʼ�в�Ӧ�ô���ͼ������߶ȼ��߶ȵ���Сֵ
                if lTop > (m_ImageInfo.ulMaxHeightSize - m_ImageInfo.ulHeightSizeUnit) then
                    lTop := m_ImageInfo.ulMaxHeightSize - m_ImageInfo.ulHeightSizeUnit;
                //��ʼ��Ӧ���ǰ���ʼ�е�λΪ��λ
                lTop := lTop div m_ImageInfo.ulTopPosUnit * m_ImageInfo.ulTopPosUnit;

                //ͼ���Ȳ���С����С��ȣ������ڵ�λ��
                if lWidth < m_ImageInfo.ulWidthSizeUnit then lWidth := m_ImageInfo.ulWidthSizeUnit;
                //ͼ����ʼ�к�ͼ����֮�Ͳ��ܴ��������
                if lWidth > (m_ImageInfo.ulMaxWidthSize - lLeft) Then
                    lWidth := m_ImageInfo.ulMaxWidthSize - lLeft;
                //ͼ����Ӧ�ð���ȵ��ڵ�λΪ��λ
                lWidth := lWidth div m_ImageInfo.ulWidthSizeUnit * m_ImageInfo.ulWidthSizeUnit;
                //ͼ�������ĵ���������������ʾ���û���ѡ���Ƿ���Ӹ������
                lWidth := lWidth div 4 * 4;
                
                //ͼ��߶Ȳ���С����С�߶�
                if lHeight < m_ImageInfo.ulHeightSizeUnit then lHeight := m_ImageInfo.ulHeightSizeUnit;
                //ͼ����ʼ�к͸߶�֮�Ͳ��ܴ������߶�
                if lHeight > (m_ImageInfo.ulMaxHeightSize - lTop) Then
                    lHeight := m_ImageInfo.ulMaxHeightSize - lTop;
                //ͼ��߶�Ӧ�ð��߶ȵ��ڵ�λΪ��λ
                lHeight := lHeight div m_ImageInfo.ulHeightSizeUnit * m_ImageInfo.ulHeightSizeUnit;

                m_CurImage.ulLeft := lLeft;
                m_CurImage.ulTop := lTop;
                m_CurImage.ulWidth := lWidth;
                m_CurImage.ulHeight := lHeight;

                StatusBar1.Panels.Items[1].Text := 'Width: ' + IntToStr(lWidth) + ' Height:' + IntToStr(lHeight);

                //����ͼ�񿪴�
                if FCAM_SetParameter(m_hDev, GSP_IMAGE, @m_CurImage) <> FCAM_SUCCESS then
                begin
                    Application.MessageBox('����ʧ�ܣ�������!', '֪ͨ');
                end;
                ShowPanel.Refresh;
        end;
    end;
      Result := true;
end;


procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) and (tb_fullscreen.Down = true) then
  begin
    tb_fullscreen.Down := false;
    tb_fullscreenClick(Sender);
  end;
end;

procedure TForm1.SoftTriger1Click(Sender: TObject);
var
  gspTrigger: FCAM_GSP_TRIGGER;
begin
  if (m_hDev <> 0) and (SoftTriger1.Checked = True) then
  begin
    if FCAM_GetParameter(m_hDev, GSP_TRIGGER, @gspTrigger) = FCAM_SUCCESS then
    begin
      gspTrigger.bPresentOn   := False;
      if FCAM_SetParameter(m_hDev, GSP_TRIGGER, @gspTrigger) = FCAM_SUCCESS then
      begin
        SoftTriger1.Checked := False;
      end;
    end;
  end;
end;

end.
