//FCAM_Def.h
//*
//* Copyright (c) 2007, �������ϿƼ��������ι�˾
//* All rights reserved.
//*
//* �ļ����ƣ�FCAM_Def.h
//* �ļ���ʶ��FCAM_Def.h
//* ժ    Ҫ��FCAM.dll�������Ͷ���ͷ�ļ�
//*
//* ����������Microsoft Win32 SDK, Visual C++ 6.00
//*
//* ��ǰ�汾��V2.0.0
//* ��    �ߣ�����÷
//* ������ڣ�2007��11��16��
//*

unit FCAM_Def;

interface
/////////////////////////////////////////////////////////////////////////////////
{$Z4}  //����Ӹ�ָʾ����ʹö�ٱ���ռ�ĸ��ֽڴ�С
//�������
type FCAM_CAMERA_TYPE =
(
    CAMERA_1394 = $0,      //1394�ӿ������IKϵ��
    CAMERA_USB = $1        //USB�ӿ������ID��IEϵ��
);

//������Ϣ����
type FCAM_PARAMINFO_TYPE =
(
    FEATURE_INFO = $0,           //���Բ�����Ϣ����Ӧ��Ϣ�ṹ��FCAM_FEATURE_INFO
    IMAGE_INFO = $1,             //��Ƶ������Ϣ����Ӧ��Ϣ�ṹ��FCAM_IMAGE_INFO
    DATATRANS_INFO = $2,         //���ݴ�����Ϣ����Ӧ��Ϣ�ṹ��FCAM_DATATRANS_INFO
    HARDWARE_INFO = $3,          //Ӳ����Ϣ����Ӧ��Ϣ�ṹ��FCAM_HARDWARE_INFO
    TRIGGER_INFO = $4,           //������Ϣ����Ӧ��Ϣ�ṹ��FCAM_TRIGGER_INFO
    STROBE_INFO = $5,            //Ƶ������Ϣ����Ӧ��Ϣ�ṹ��FCAM_STROBE_INFO
    INTERFACE_INFO = $6          //����ӿ���Ϣ����Ӧ��Ϣ�ṹ��FCAM_INTERFACE_INFO
);

//�����������
type FCAM_FEATURE_TYPE =
(
	BRIGHTNESS              = $0,	  //����
	AUTO_EXPOSURE           = $1,   //�Զ��ع�
	SHARPNESS               = $2,   //��
	WHITE_BALANCE           = $3,	  //��ƽ��,B��R����
	HUE                     = $4,   //ɫ��
	SATURATION              = $5,   //���Ͷ�
	GAMMA                   = $6,   //٤��У��
	SHUTTER                 = $7,   //�ع�ʱ�䣬1��32.944us
	ANG_GAIN                = $8,	  //ģ������
	IRIS                    = $9,   //IRIS����
	FOCUS                   = $a,   //�Խ�
	TEMPERATURE             = $b,   //�¶�
	TRIG_DELAY              = $c,   //�����ӳ�
	WHITE_SHADING           = $d,   //ͨ������,R��G��Bͨ��ֵ
	FRAME_RATE_PRIORITYS    = $e,   //֡Ƶ����
	ZOOM                    = $f,   //�佹
	PAN                     = $10,  //ң��
	TILT                    = $11,  //�����б��
	OPTICAL_FILTER          = $12,  //��ѧ�˲�
	CAPTURE_SIZE_FORMAT6    = $13,  //F6M0_EXIF_FORMAT��Ƶ��ʽ��Ӧ���������ԣ������С
	CAPTURE_QUALITY_FORMAT6 = $14,  //F6M0_EXIF_FORMAT��Ƶ��ʽ��Ӧ���������ԣ�ͼ������
	DIGITAL_SHIFT           = $15,	//����λ��
	BIT_INVERSE             = $16,	//λ��ת
	PROCESS_SPEED           = $17,  //����ڲ����������ٶ�
	CLOCK                   = $18   //�����ʱ��Ƶ��
);

//���Բ������ڷ�ʽ
type FCAM_ADJUST_MODE =
(
	AUTO      = $0,        //����Զ�����
	MANUAL    = $1,        //�ֶ����ڣ��û����ڣ�
	ONE_PUSH  = $2         //���һ�ε���ģʽ
);

//����ֵ����
type FCAM_VALUE_TYPE =
(
	FLOAT_VALUE = $0,          //������
  LONG_VALUE  = $1          //����
);

//���ظ�ʽ��Ϣ
type FCAM_PIXEL_FORMAT =
(
	Raw8       = $0,        //��ɫ�����������8λԭʼ����
	Raw16      = $1,        //��ɫ�����������16λԭʼ����
	YMono8     = $2,        //8λ������Ϣ����
	YMono16    = $3,        //16λ������Ϣ����,�޷���
	S_YMono16  = $4,        //16λ������Ϣ����,�з���
	RGB8       = $5,        //R=B=G=8bit  R-G-B-R-G-B
	RGB16      = $6,        //R=B=G=16bit R-G-B-R-G-B
	S_RGB16    = $7,        //R=B=G=16bit,�з�������

	YUV444     = $8,        //U-Y-V-U-Y-V���У���ռ8bit��pixel bit = 24
	YUV422     = $9,        //U-Y-V-Y-U-Y-V-Y���У���ռ8bit,pixel bit = 16
	YUV411     = $a         //U-Y-Y-V-Y-Y-U���У���ռ8bit, pixel bit = 12
);

//��Ƶ��ʽ����
type FCAM_VIDEO_FORMAT =
(
	F0M0_160_120YUV444  = $0,  //ͼ��ֱ���Ϊ160 * 120�����ظ�ʽΪYUV444
	F0M1_320_240YUV422  = $1,  //ͼ��ֱ���Ϊ320 * 240�����ظ�ʽΪYUV422
	F0M2_640_480YUV411  = $2,  //ͼ��ֱ���Ϊ640 * 480�����ظ�ʽΪYUV411
	F0M3_640_480YUV422  = $3,  //ͼ��ֱ���Ϊ640 * 480�����ظ�ʽΪYUV422
	F0M4_640_480RGB8    = $4,  //ͼ��ֱ���Ϊ640 * 480�����ظ�ʽΪRGB8
	F0M5_640_480YMono8  = $5,  //ͼ��ֱ���Ϊ640 * 480�����ظ�ʽΪYMono8
	F0M6_640_480YMono16 = $6,  //ͼ��ֱ���Ϊ640 * 480�����ظ�ʽΪYMono16


	F1M0_800_600YUV422   = $7, //ͼ��ֱ���Ϊ800 * 600�����ظ�ʽΪYUV422
	F1M1_800_600RGB8     = $8, //ͼ��ֱ���Ϊ800 * 600�����ظ�ʽΪRGB8
	F1M2_800_600YMono8   = $9, //ͼ��ֱ���Ϊ800 * 600�����ظ�ʽΪYMono8
	F1M3_1024_768YUV422  = $a, //ͼ��ֱ���Ϊ1024 * 768�����ظ�ʽΪYUV422
	F1M4_1024_768RGB8    = $b, //ͼ��ֱ���Ϊ1024 * 768�����ظ�ʽΪRGB8
	F1M5_1024_768YMono8  = $c, //ͼ��ֱ���Ϊ1024 * 768�����ظ�ʽΪYMono8
	F1M6_800_600YMono16  = $d, //ͼ��ֱ���Ϊ800 * 600�����ظ�ʽΪYMono16
	F1M7_1024_768YMono16 = $e, //ͼ��ֱ���Ϊ1024 * 768�����ظ�ʽΪYMono16

	F2M0_1280_960YUV422   = $f,  //ͼ��ֱ���Ϊ1280 * 960�����ظ�ʽΪYUV422
	F2M1_1280_960RGB8     = $10, //ͼ��ֱ���Ϊ1280 * 960�����ظ�ʽΪRGB8
	F2M2_1280_960YMono8   = $11, //ͼ��ֱ���Ϊ1280 * 960�����ظ�ʽΪYMono8
	F2M3_1600_1200YUV422  = $12, //ͼ��ֱ���Ϊ1600 * 1200�����ظ�ʽΪYUV422
	F2M4_1600_1200RGB8    = $13, //ͼ��ֱ���Ϊ1600 * 1200�����ظ�ʽΪRGB8
	F2M5_1600_1200YMono8  = $14, //ͼ��ֱ���Ϊ1600 * 1200�����ظ�ʽΪYMono8
	F2M6_1280_960YMono16  = $15, //ͼ��ֱ���Ϊ1280 * 960�����ظ�ʽΪYMono16
	F2M7_1600_1200YMono16 = $16, //ͼ��ֱ���Ϊ1600 * 1200�����ظ�ʽΪYMono16

	F6M0_EXIF_FORMAT      = $17, //��ֹͼ���ʽ

	//�����Զ����ʽ
  F7M0_CUSTOM           = $18, //�����Զ����ʽ0
	F7M1_CUSTOM           = $19, //�����Զ����ʽ1
	F7M2_CUSTOM           = $1a, //�����Զ����ʽ2
	F7M3_CUSTOM           = $1b, //�����Զ����ʽ3
	F7M4_CUSTOM           = $1c, //�����Զ����ʽ4
	F7M5_CUSTOM           = $1d, //�����Զ����ʽ5
	F7M6_CUSTOM           = $1e, //�����Զ����ʽ6
	F7M7_CUSTOM           = $1f  //�����Զ����ʽ7
);

//֡Ƶ��ʽ
type FCAM_FRAME_RATE =
(
	RATE_1_875    = $0,        //1.875֡ÿ��
	RATE_3_75     = $1,        //3.75֡ÿ��
	RATE_7_5      = $2,        //7.5֡ÿ��
	RATE_15       = $3,        //15֡ÿ��
	RATE_30       = $4,        //30֡ÿ��
	RATE_60       = $5,        //60֡ÿ��
	RATE_120      = $6,        //120֡ÿ��
	RATE_240      = $7,        //240֡ÿ��
	RATE_ANY      = $8         //֡Ƶ�����ޣ�����Ϊ�κ�ֵ�������Ӳ�����̾���

);

//�˹�Ƭ���и�ʽ
type FCAM_COLORFILTER_PATTERN =
(
	NONE  = $0,	       //��Bayer����
	RG_GB = $1,        //Bayer���У����з�ʽΪ����һ�У�R G R G���� �ڶ��У�G B G B����
	GB_RG = $2,        //Bayer���У����з�ʽΪ����һ�У�G B G B���� �ڶ��У�R G R G����
	GR_BG = $3,        //Bayer���У����з�ʽΪ����һ�У�G R G R���� �ڶ��У�B G B G����
	BG_GR = $4         //Bayer���У����з�ʽΪ����һ�У�B G B G���� �ڶ��У�G R G R����

);

//����Դ����
type FCAM_TRIGGER_SOURCE =
(
	TRIGGER_SOR0     = $0,       //Ӳ��0����Դ
	TRIGGER_SOR1     = $1,       //Ӳ��1����Դ
	TRIGGER_SOR2     = $2,       //Ӳ��2����Դ
	TRIGGER_SOR3     = $3,       //Ӳ��3����Դ
	TRIGGER_SOR4     = $4,       //Ӳ��4����Դ
	TRIGGER_SOR5     = $5,       //Ӳ��5����Դ
	TRIGGER_SOR6     = $6,       //Ӳ��6����Դ
	TRIGGER_SOFT     = $7       //�������

);

//���ݴ���ģʽ
type FCAM_TRANSTYPE =
(
	IDLE            = $0,       //��ǰ�������������
	ONE_SHOT        = $1,       //��ǰ����Ĵ�������Ϊ����һ֡ͼ�����ݺ�תΪIDLEģʽ
	MUTI_SHOT       = $2,       //��ǰ����Ĵ�������Ϊ�����֡ͼ�����ݺ�תΪIDLEģʽ
	CONTINUOUS_SHOT = $3        //��ǰ����Ĵ�������Ϊ��������

);

//1394����Ĵ����ٶ�
type FCAM_1394SPEED =
(
	SPEED_100M  = $0,       //100M bps/s
	SPEED_200M  = $1,       //200M bps/s
	SPEED_400M  = $2,       //400M bps/s
	SPEED_800M  = $3,       //800M bps/s
	SPEED_1_6G  = $4,       //1600M bps/s
	SPEED_3_2G  = $5        //3200M bps/s

);

type FCAM_GSP_PARAME_TYPE =
(
	GSP_FEATURE                = $0,       //���Բ������ͣ���ӦFCAM_GSP_FEATURE�ṹ��
	GSP_IMAGE                  = $1,       //ͼ��������ͣ���ӦFCAM_GSP_IMAGE�ṹ��
	GSP_TRANS                  = $2,       //����������ͣ���ӦFCAM_GSP_TRANS�ṹ��
	GSP_STROBE                 = $3,       //Ƶ���Ʋ������ͣ���ӦFCAM_GSP_STROBE�ṹ��
	GSP_TRIGGER                = $4        //�����������ͣ���ӦFCAM_GSP_TRIGGER�ṹ��

);

//DIGITAL_SHIFT����ֵ��Ӧ������
type VAL_DIGITAL_SHIFT =
(
	DS_HIGH_8BITS	= $0,     //�߰�λ
	DS_MID_8BITS	= $1,     //�а�λ
	DS_LOW_8BITS	= $2     //�Ͱ�λ
);

//��������Ƶ���Ƽ���ֵ��Ӧ������
type VAL_POLARITY =
(
	POL_LOW_ACTIVE	= $0,     //�͵�ƽ��Ч
	POL_HIGH_ACTIVE = $1      //�ߵ�ƽ��Ч
);

////////////////////////////////////////////////////////////////////////////////
//����ֵ��Χ��Ϣ
FEATURE_VALUE_RANGE = packed record
    bLongValueValid: longBool;     //������Ϣ�Ƿ���Ч����ΪTRUE��lMax_Value��lMin_Value��lStep��Ч����֮��Ч

		lMax_Value: Longint;          //���Ͳ���ֵ�����ֵ
		lMin_Value: Longint;          //���Ͳ���ֵ����Сֵ
		lStep: Longint;               //���Ͳ���ֵ�ĵ�λ����ֵ

		bFloatValueValid: longBool;   //��������Ϣ�Ƿ���Ч����ΪTRUE��fMax_Value��fMin_Value��fStep��Ч����֮��Ч

		fMax_Value: Single;          //�����Ͳ���ֵ�����ֵ
		fMin_Value: Single;          //�����Ͳ���ֵ����Сֵ
		fStep: Single;               //�����Ͳ���ֵ�ĵ�λ����ֵ
end;

//FCAM_PARAMINFO_TYPE��FEATURE_INFO��Ӧ�Ľṹ��
FCAM_FEATURE_INFO = packed record
    featureType: FCAM_FEATURE_TYPE;   //����������ͣ�Ϊ�������

    bAvaliable: longBool;              //�����Ե�ǰ�Ƿ���ã�TRUEΪ���ã�FALSEΪ������
	  bCanOnePush: longBool;             //�������Ƿ�֧��one push����ģʽ��TRUE֧�֣�FALSE��֧��
	  bCanOnOff: longBool;               //�������Ƿ�֧��ʹ�ܺͲ�ʹ�ܵ��л�������TRUE֧�֣�FALSE��֧��
	  bCanReadOut: longBool;             //�����ԵĲ���ֵ�Ƿ�ɶ���TRUE֧�֣�FALSE��֧��
	  bCanAuto: longBool;                //�������Ƿ�֧���Զ�����ģʽ��TRUE֧�֣�FALSE��֧��
	  bCanManual: longBool;              //�������Ƿ�֧���ֶ�����ģʽ��TRUE֧�֣�FALSE��֧��

	  FeatureInfoValue: FEATURE_VALUE_RANGE
end;
////////////////////////////////////////////////////////////////////////////////
//USB�ӿ���Ϣ
INTERFACE_USBSPEC  = packed record
    bIsUsb20: longBool;    //������ӵ�USB�ӿ��Ƿ���USB2.0�ӿڣ������ǣ�����޷���������
end;
//�ӿ���Ϣ
FCAM_INTERFACE_INFO = packed record
    CameraType: FCAM_CAMERA_TYPE;  //������ͣ���ΪCAMERA_USB��SUsbSpec�ṹ����Ϣ��Ч
	  SUsbSpec: INTERFACE_USBSPEC;
end;
/////////////////////////////////////////////////////////////////////////////////
//HARDWARE_INFO��Ӧ�Ľṹ��
FCAM_HARDWARE_INFO = packed record
	VendorName: Array[0..99] of Char;    //������
	ModelName: Array[0..99] of Char;     //�ͺ���
	ulCameraID: Array[0..1] of Longword; //���ID
	byHdEdition: Array[0..3] of Byte;    //Ӳ���汾��
  byHdUpdateTime: Array[0..3] of Byte; //Ӳ����������
end;
////////////////////////////////////////////////////////////////////////////////
//1394ר��ͼ����Ϣ,����
IMAGEINFO_S1394SPEC = packed record
  fFrameInterval: Single;
end;
//ͼ����Ϣ
FCAM_IMAGE_INFO = packed record

  FormatMode: FCAM_VIDEO_FORMAT; //FCAM_VIDEO_FORMAT��Ƶ��ʽ���ͣ��������

	bSupport: longBool;           //����Ƿ�֧�ָ���Ƶ��ʽ��TRUE֧�֣�FALSE��֧��

	bAOI: longBool;              //����Ƶ��ʽ�Ƿ�֧�ֿ���������TRUE֧�֣�FALSE��֧��
	ulMaxWidthSize: Longword;    //����Ƶ��ʽ֧�ֵ�ͼ���ȵ����ֱ���
	ulMaxHeightSize: Longword;   //����Ƶ��ʽ֧�ֵ�ͼ��߶ȵ����ֱ���
	ulLeftPosUnit: Longword;     //������ʼ�в�����λ��bAOIΪFALSEʱ�ò�����Ч������
	ulTopPosUnit: Longword;      //������ʼ�в�����λ��bAOIΪFALSEʱ�ò�����Ч������
	ulWidthSizeUnit:Longword;    //������Ȳ�����λ��bAOIΪFALSEʱ�ò�����Ч������
	ulHeightSizeUnit: Longword;  //�����߶Ȳ�����λ��bAOIΪFALSEʱ�ò�����Ч������

  ColorFilterPattern: FCAM_COLORFILTER_PATTERN;   //����Ƶ��ʽ�Ĳ�ɫ�˹�Ƭ����ģʽ
	bSupportFrameRate: Array[0..8] of longBool;     //��FCAM_1394_FRAME_RATE֡Ƶ��֧��
	bSupportPixelFormat: Array[0..10] of longBool; //��FCAM_PIXEL_FORMAT���ظ�ʽ��֧��

  CameraType: FCAM_CAMERA_TYPE;   //��ǰ��������ͣ���ΪCAMERA_1394��S1394Spec�ṹ����Ч
  S1394Spec: IMAGEINFO_S1394SPEC;
end;
////////////////////////////////////////////////////////////////////////////////
//for STROBE_INFOƵ������Ϣ
FCAM_STROBE_INFO = packed record

	ulStrobeIndex: LongWord;        //Ƶ����ͨ��ѡ�������������0~3

	bAvaliable: longBool;           //����Ƿ�֧�ָ�·Ƶ���Ʋ�����TRUE��ʾ֧�֣�FALSEΪ��֧��
	bCanOnOff: longBool;            //��ͨ���Ƿ�֧��ʹ�ܻ��߲�ʹ�ܵ��л�������TRUE֧�֣�FALSE��֧��
	bCanReadOut: longBool;          //��ͨ���Ĳ���ֵ�Ƿ�ɶ���TRUE�ɶ���FALSE���ɶ�
	bCanChangePolarity: longBool;   //Ƶ���Ƽ����Ƿ�ɸı䣬TRUE��ʾ���Ըı䣬FALSE���ɸı�

	StrobeInfoValue: FEATURE_VALUE_RANGE; //����(Ƶ���ȵ��ӳٺͳ���ʱ��)ֵ��Ϣ
end;

///////////////////////////////////////////////////////////////////////////////
//����
FCAM_TRIGGER_INFO = packed record

	bAvaliable: longBool;               //������Ƿ�֧�ִ������ܣ�TRUE��ʾ֧�֣�FALSEΪ��֧��
	bCanOnOff: longBool;                //���������Ƿ�֧��ʹ�ܻ��߲�ʹ�ܵ��л�������TRUEΪ֧�֣�FALSE��֧��
	bCanReadOut: longBool;              //��������ֵ�Ƿ�ɶ���TRUE�ɶ���FALSE���ɶ�
	bCanChangePolarity: longBool;       //���������Ƿ�ɸı䣬TRUE��ʾ���Ըı䣬FALSE���ɸı�
	bCanReadRawTrgInput: longBool;      //ԭʼ���������ź�ֵ�Ƿ�ɶ�����bCanReadOutΪFALSE����ֵ����

	bHdTriggerSor: Array[0..6] of longBool;         //�����FCAM_TRIGGER_SOURCE�����TRIGGER_SOR0��TRIGGER_SOR6���ִ���ͨ����֧��
	bSoftWareTrigger: longBool;                     //����Ƿ�֧������������ܣ�TRUEΪ֧�֣�FALSEΪ��֧��
	bTriggerMode: Array[0..15] of longBool;         //�����16�ִ���ģʽ��֧�֣�TRUEΪ֧�֣�����֧��
end;
////////////////////////////////////////////////////////////////////////////////
//1394���ݴ�����Ϣ
FCAM_DATATRANS_S1394SPEC = packed record
	 bSpeedSupport: Array[0..5] of longBool;     //��FCAM_1394SPEED�����6���ٶȵ�֧�֣�TRUEΪ֧�֣�FALSEΪ��֧��
	 ulMaxChannelNumber: Longword;               //���֧�ֵ�������ͨ��ֵ,��0��ʼ
end;
//���ݴ�����Ϣ
FCAM_DATATRANS_INFO = packed record

	bCanMutiShot: longBool;             //����Ƿ�֧�������ɼ�����ģʽ��TRUEΪ֧�֣�FALSEΪ��֧��
	bCanContinusShot: longBool;         //����Ƿ�֧�ֶ�֡�ɼ�����ģʽ��TRUE֧�֣�FALSE��֧��
	bCanOneShot: longBool;              //����Ƿ�֧�ֵ�֡�ɼ�����ģʽ��TRUE֧�֣�FALSE��֧��

	ulMaxStreamBufferCount: Longword;    //���ݻ����������������
	ulMaxFrameCountOfBuffer: Longword;   //���仺�������������֡��

  CameraType: FCAM_CAMERA_TYPE;      //������ͣ���ΪCAMERA_1394��S1394Spec�ṹ����Ϣ��Ч

	S1394Spec: FCAM_DATATRANS_S1394SPEC;
end;
////////////////////////////////////////////////////////////////////////////////
//����ֵ
FCAM_FEATURE_LONG_VALUE = packed record
  ulValueCnt: Longword;       //��ǰ���Ͳ���ֵ���������Ϊ3
  lValue: Array[0..2] of Longword;  //��ValueTypeΪLONG_VALUE��ǰuValueCnt��ֵΪ��Ӧ�Ĳ���ֵ
end;
//������ֵ
FCAM_FEATURE_FLOAT_VALUE = packed record
  ulValueCnt: Longword;           //��ǰ�������ֵ���������Ϊ3
	fValue: Array[0..2] of Single;  //��ValueTypeΪFLOAT_VALUE��ǰuValueCnt��ֵΪ��Ӧ�Ĳ���ֵ
end;
//���Բ���ֵ
FCAM_GSP_FEATURE = packed record

  FeatureType: FCAM_FEATURE_TYPE; //FCAM_FEATURE_TYPE������������ͣ��������

  bAvaliable: longBool;   //����Ƿ�֧�ָ��������ã�ͬ��FCAM_FEATURE_INFO�е�bAvaliable,ֻ��

  bPresentOn: longBool;  //��ΪTRUE��������ʹ�ܣ�����ʹ�ܣ�
                         //��FCAM_FEATURE_INFO�е�bCanOnOffΪFALSE����ò���Ϊֻ�������ɸı�

  AdjustMode: FCAM_ADJUST_MODE;  //FCAM_ADJUST_MODE���Ͷ���ĵ���ģʽ

	bValueValid: longBool; //����ֵ�Ƿ���Ч����ΪTRUE����ValueType��FeatureValue�е�ֵ��Ч����֮��Ч

  ValueType: FCAM_VALUE_TYPE;   //��ǰ����ֵ���ͣ���FCAM_VALUE_TYPE���塣��ΪFLOAT_VALUE��
                                //��FloatValue�ṹ����Ч����ΪLONG_VALUE����LongValue�ṹ����Ч

	LongValue: FCAM_FEATURE_LONG_VALUE;
	FloatValue: FCAM_FEATURE_FLOAT_VALUE;
end;
////////////////////////////////////////////////////////////////////////////////
//1394������
FCAM_IMAGE_1394PACKET = packed record
  bDataVerify: longBool;             //�Ƿ�����ݽ���У�飬��ֵ�ڵ�ǰ�汾����

	bPacketSetable: longBool;          {ֻ����������ʾ��ǰ����С�Ƿ���裬TRUEΪ���裬��ulUnitBytePerPacket
											              ulMaxBytePerPacket��ulRecBytePerPacket��Ч����֮��Ч����ulPacketSizeΪֻ������}

  ulUnitBytePerPacket: Longword;     //����С���õ�λ��ҲΪ����С�������Сֵ��ֻ��
	ulMaxBytePerPacket: Longword;      //����С��������ֵ��ֻ��
	ulRecBytePerPacket: Longword;      //����Ƽ��İ���С��Ϊ0��ʾ���ԣ�ֻ��

	ulPacketSize: Longword;            //��ǰ����С��������С�����裬��ֵֻ����������С�����Ҹ�ֵΪ0�������С���ú���
	ulPacketPerFrame: Longword;        //��ǰһ֡ͼ�����ݵİ�������ֻ��

end;

//���ĳһ��Ƶ��ʽ�µ�ͼ�����
FCAM_GSP_IMAGE = packed record

  FormatMode: FCAM_VIDEO_FORMAT;   //��ǰ��Ƶ��ʽ
  FrameRate: FCAM_FRAME_RATE;     //��ǰ֡Ƶģʽ

  PixelFormat: FCAM_PIXEL_FORMAT; //��ǰ�����ظ�ʽ
	ulPixelBits: Longword;   //����λ��,read only,����ʱ���Ը�ֵ
	
	ulLeft: Longword;        //��ʾͼ�����ʼ�У�����õ�FCAM_IMAGE_INFO��Ϣ�ṹ���е�bAOIΪTRUEʱ����ֵ�ɰ���ulLeftPosUnit���ã�����ֻ��
	ulTop: Longword;         //��ʾͼ�����ʼ�С�����õ�FCAM_IMAGE_INFO��Ϣ�ṹ���е�bAOIΪTRUEʱ����ֵ�ɰ���ulTopPosUnit���ã�����ֻ��
	ulWidth: Longword;       //��ʾͼ��Ŀ�ȣ�����õ�FCAM_IMAGE_INFO��Ϣ�ṹ���е�bAOIΪTRUEʱ����ֵ�ɰ���ulWidthSizeUnit���ã�����ֻ��
	ulHeight: Longword;      //��ʾͼ��ĸ߶ȣ�����õ�FCAM_IMAGE_INFO��Ϣ�ṹ���е�bAOIΪTRUEʱ����ֵ�ɰ���ulHeightSizeUnit���ã�����ֻ��

  CameraType: FCAM_CAMERA_TYPE;    //������ͣ�����ֵΪCAMERA_1394,S1394Spec�ṹ����Ч������S1394Spec��Ч
	S1394Spec: FCAM_IMAGE_1394PACKET; //1394�������Ϣ
end;

////////////////////////////////////////////////////////////////////////////////
//Ƶ�������Ͳ���ֵ
FCAM_STROBE_LONG_VALUE = packed record
  lDelayValue: Longword;      //ΪƵ�����ӳ�ʱ�䣬����
	lDurationValue: Longword;   //ΪƵ���Ƴ���ʱ�䣬����
end;

FCAM_STROBE_FLOAT_VALUE = packed record
  fDelayValue: Single;      //ΪƵ�����ӳ�ʱ�䣬������
	fDurationValue: Single;   //ΪƵ���Ƴ���ʱ�䣬������
end;

FCAM_GSP_STROBE = packed record

	ulStrobeIndex: Longword;//Ƶ����ͨ��ֵ����0-3,�������

	bAvaliable: longBool;   //����Ƿ�֧��Ƶ����ͨ�����ã�ͬ��ͬ��ͨ��FCAM_STROBE_INFO��Ϣ�е�
                          //bAvaliable���ò���Ϊֻ����������ֻ�ܻ�ȡ�������á����ò���ΪFALSE��
                          //�������в���ֵ��Ч

	bPresentOn: longBool;   //��ΪTRUE������������ʹ�ܣ�����ʹ�ܣ���FCAM_STROBE_INFO�е�bCanOnOffΪFALSE����ò���Ϊֻ������������
	byPolarity: Longword;   //Ƶ���Ƽ��ԣ���FCAM_STROBE_INFO�е�bCanChangePolarityΪTRUE����ò����ɶ����裬����ò���ֻ��

	bValueValid: longBool;  //����ֵ�Ƿ���Ч����ΪTRUE����ValueType��StrobeValue�е�ֵ��Ч����֮��Ч

	ValueType:FCAM_VALUE_TYPE;    //��ǰ����ֵ���ͣ���FCAM_VALUE_TYPE���塣��ΪFLOAT_VALUE����FloatValue�ṹ����Ч��
                                //��ΪLONG_VALUE����LongValue�ṹ����Ч
	
  LongValue: FCAM_STROBE_LONG_VALUE;
  FloatValue: FCAM_STROBE_FLOAT_VALUE;
end;
/////////////////////////////////////////////////////////////////////////////////
//-for GSP_TRIGGER-��������
FCAM_GSP_TRIGGER = packed record
	bAvaliable: longBool;       //����Ƿ�֧�ִ������ã�ͬ��FCAM_TRIGGER_INFO��Ϣ�е�bAvaliable��
                              //�ò���Ϊֻ����������ֻ�ܻ�ȡ�������á����ò���ΪFALSE���������в���ֵ��Ч

	bPresentOn: longBool;       //��ΪTRUE������������ʹ�ܣ�����ʹ�ܣ�����Ӧ��FCAM_TRIGGER_INFO��Ϣ�е�bCanOnOffΪFALSE����ò���Ϊֻ������������

	ulTrgPolarity: Longword;         //�������ԣ���FCAM_TRIGGER_INFO�е�bCanChangePolarityΪTRUE����ò����ɶ����裬����ò���ֻ��
  TrgSorce: FCAM_TRIGGER_SOURCE;   //����Դ
	ulTrgleMode: Longword;           //����ģʽ

	bValueValid: longBool;           //�����ź�ֵ�Ƿ���Ч
	ulTrgInputValue: Longword;       //�����źţ�ֻ��
end;
////////////////////////////////////////////////////////////////////////////////
//for GSP_TRANS-
//1394�������
FCAM_GSP_TRANS_S1394SPEC = packed record
	uChannel: Longword;      //����ͨ��ֵ�����ֵ��ӦFCAM_DATATRANS_INFO�е�uMaxChannelNumber
	TransSpeed: FCAM_1394SPEED;    //�����ٶȣ��Ը��ٶ����͵�֧�ּ�FCAM_DATATRANS_INFO�е�bSpeedSupport[6]
end;
//����������
FCAM_GSP_TRANS = packed record
  TransMode: FCAM_TRANSTYPE;      //��ǰ����ģʽ
	ulTransFrameCnt: Longword;      //��֡����ģʽ�Ĵ���֡����������ģʽΪMUTI_SHOTʱ����ֵ��Ч���������

	ulStreamBufferCnt: Longword;     //����������ݻ��������������ֵ��ӦFCAM_DATATRANS_INFO�е�uMaxStreamBufferCount

	ulFrameCntOfOneBuffer: Longword; //һ�����ݻ������洢��֡������ONE_SHOT����ģʽ�£���ֵ����Ϊ1����MUTI_SHOTģʽ�£�
	                                 //��ֵӦ������uTransFrameCnt�����ֵ��ӦFCAM_DATATRANS_INFO�е�uMaxFrameCountOfBuffer
	ulStreamBufferSize: Longword;    //����������ݻ�������С�����ֽ�Ϊ��λ��ֻ��

  CameraType: FCAM_CAMERA_TYPE;    //������ͣ�����ֵΪCAMERA_1394ʱ��S1394Spec��Ч��������Ч
	S1394Spec: FCAM_GSP_TRANS_S1394SPEC;
end;

//////////////////////////////////////////////////////////////////////////////////////
FCAM_COMMU_INFO = packed record
	pDataBuffer: Pointer;              //��ǰ���ݻ������ĵ�ַ
	ulDataSizes: Longword;              //���ݻ������Ĵ�С���ֽ�Ϊ��λ
	ulFrameCountOfData: Longword;       //�����ݻ�����������֡��

	ulFrameLeft: Longword;              //ÿ֡����ͼ��Ŀ�����ʼ����
	ulFrameTop: Longword;               //ÿ֡����ͼ��Ŀ�����ʼ����
	ulFrameWidth: Longword;             //ÿ֡����ͼ��Ŀ��
	ulFrameHeight: Longword;            //ÿ֡����ͼ��ĸ߶�
	ulFrameSizes: Longword;             //һ֡ͼ�����ݵĴ�С���ֽ�Ϊ��λ
	ulFrameAvaliableSizes: Longword;    //һ֡ͼ�����ݵ���Ч�ֽ���

  PixelFormat: FCAM_PIXEL_FORMAT;     //���ظ�ʽ
	ulFramePixelBits: Longword;         //����λ��

	ulDeviceIndex: Longword;            //��ǰ������
  CameraType: FCAM_CAMERA_TYPE;       //��ǰ�������
	pUserParam: Pointer;                //�û��Զ�����������ָ��
end;

//����ֵ�ʹ��ھ����ʶ
type
    HRESULT             =     LongWord;
    HWND                =     LongWord;

//����һ�����͵�ָ������
type
PFCAM_COMMU_INFO = ^FCAM_COMMU_INFO;
//�ص���������
PFCAM_CALLBACK = function(pCommuParam: PFCAM_COMMU_INFO): Integer; stdcall;

//�Զ����ڻص�����
//pParamΪ���ںõĲ���ֵ�ṹ��ָ�룬ֻ�ڻص���������Ч
//pContext�û��Զ���ṹ��ָ��
PFCAM_AUTOSET_CALLBACK = procedure(pParam: Pointer; pContext: Pointer); stdcall;
//////////////////////////////////////////////////////////////////////////

//��Ϣ����
const WM_USER             = $0400;
const WM_FCAM_MESSAGE           = WM_USER + 500;         //����Ϣ
const WM_FCAM_ONE_RSVD          = WM_FCAM_MESSAGE + 1;  //�յ�ͼ�񻺳�����С��ͼ������
const WM_FCAM_ONE_FAILED        = WM_FCAM_MESSAGE + 2;  //��ȡͼ������ʧ��

/////////////////////////����ֵ����//////////////////////////////////////
FCAM_SUCCESS: HRESULT                =$20000000;      //�����ɹ�
FCAM_UNSUCCESSFUL: HRESULT           =$E0000000;    //����ʧ��
FCAM_NO_SUCH_DEVICE:HRESULT          =$E0000001;    //�Ҳ���ָ�����豸
FCAM_DEVICE_INIT_FAIL:HRESULT        =$E0000002;    //�豸��ʼ��ʧ��
FCAM_DEVICE_NOT_MATCH:HRESULT        =$E0000003;    //�豸��ƥ��
FCAM_DEVICE_TRANS_FAILED:HRESULT     =$E0000004;    //�豸����ʧ�ܣ��ڻ�ø����͵ķ���ֵ��Ӧ���������������ݴ���
FCAM_CONFIGFILE_NOT_MATCH:HRESULT    =$E0000005;    //�����ļ���ƥ��

FCAM_INVALID_PARAMETER:HRESULT       =$E0000020;    //��Ч����
FCAM_INVALID_TRIGGER_SOURCE:HRESULT  =$E0000021;    //��Ч�Ĵ���Դ
FCAM_INVALID_TRIGGER_MODE:HRESULT    =$E0000022;    //��Ч�Ĵ���ģʽ
FCAM_INVALID_HANDLE_VALUE:HRESULT    =$E0000023;    //��Ч�ľ��ֵ

FCAM_INSUFFICIENT_RESOURCE:HRESULT   =$E0000040;    //��Դ����
FCAM_REASONLESS_PARAMETER:HRESULT    =$E0000041;    //������Ĳ���
FCAM_RESONLESS_PACKETSIZE:HRESULT    =$E0000042;    //������İ���С

FCAM_FEATURE_NOT_SUPPORT:HRESULT     =$E0000050;    //�������Բ�֧��
FCAM_VIDEOFORMAT_NOT_SUPPORT:HRESULT =$E0000051;    //��Ƶ��ʽ��֧��
FCAM_TRIGGER_NOT_SUPPORT:HRESULT     =$E0000052;    //������֧��
FCAM_STROBE_NOT_SUPPORT:HRESULT      =$E0000053;    //Ƶ����ͨ����֧��
FCAM_FRAMERATE_NOT_SUPPORT:HRESULT   =$E0000054;    //֡Ƶ��֧��
FCAM_PIXELFORMAT_NOT_SUPPORT:HRESULT =$E0000055;    //���ظ�ʽ��֧��
FCAM_AOI_NOT_SUPPORT:HRESULT         =$E0000056;    //������֧��
FCAM_REGISTER_RW_NOT_SUPPORT:HRESULT =$E0000057;    //ĳ��ַ�ļĴ�����д��֧��
FCAM_AUTOWHB_NOT_SUPPORT:HRESULT     =$E0000058;     //�Զ���ƽ�ⲻ֧��
FCAM_TRANSMODE_NOT_SUPPORT:HRESULT   =$E0000059;     //����ģʽ��֧��
FCAM_TRANSSPEED_NOT_SUPPORT:HRESULT  =$E0000060;     //�����ٶȲ�֧��

FCAM_SOFTTRIGGER_BUSY:HRESULT        =$E0000070;     //��һ֡�������û�н���
//////////////////////////////////////////////////////////////////////////

implementation

end.

