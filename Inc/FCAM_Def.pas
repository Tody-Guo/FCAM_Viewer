//FCAM_Def.h
//*
//* Copyright (c) 2007, 西安方诚科技有限责任公司
//* All rights reserved.
//*
//* 文件名称：FCAM_Def.h
//* 文件标识：FCAM_Def.h
//* 摘    要：FCAM.dll数据类型定义头文件
//*
//* 开发环境：Microsoft Win32 SDK, Visual C++ 6.00
//*
//* 当前版本：V2.0.0
//* 作    者：赵星梅
//* 完成日期：2007年11月16日
//*

unit FCAM_Def;

interface
/////////////////////////////////////////////////////////////////////////////////
{$Z4}  //必须加该指示符，使枚举变量占四个字节大小
//相机类型
type FCAM_CAMERA_TYPE =
(
    CAMERA_1394 = $0,      //1394接口相机，IK系列
    CAMERA_USB = $1        //USB接口相机，ID、IE系列
);

//参数信息类型
type FCAM_PARAMINFO_TYPE =
(
    FEATURE_INFO = $0,           //特性参数信息，对应信息结构体FCAM_FEATURE_INFO
    IMAGE_INFO = $1,             //视频参数信息，对应信息结构体FCAM_IMAGE_INFO
    DATATRANS_INFO = $2,         //数据传输信息，对应信息结构体FCAM_DATATRANS_INFO
    HARDWARE_INFO = $3,          //硬件信息，对应信息结构体FCAM_HARDWARE_INFO
    TRIGGER_INFO = $4,           //触发信息，对应信息结构体FCAM_TRIGGER_INFO
    STROBE_INFO = $5,            //频闪灯信息，对应信息结构体FCAM_STROBE_INFO
    INTERFACE_INFO = $6          //相机接口信息，对应信息结构体FCAM_INTERFACE_INFO
);

//相机特性类型
type FCAM_FEATURE_TYPE =
(
	BRIGHTNESS              = $0,	  //亮度
	AUTO_EXPOSURE           = $1,   //自动曝光
	SHARPNESS               = $2,   //锐化
	WHITE_BALANCE           = $3,	  //白平衡,B、R增益
	HUE                     = $4,   //色度
	SATURATION              = $5,   //饱和度
	GAMMA                   = $6,   //伽玛校正
	SHUTTER                 = $7,   //曝光时间，1：32.944us
	ANG_GAIN                = $8,	  //模拟增益
	IRIS                    = $9,   //IRIS调节
	FOCUS                   = $a,   //对焦
	TEMPERATURE             = $b,   //温度
	TRIG_DELAY              = $c,   //触发延迟
	WHITE_SHADING           = $d,   //通道亮度,R、G、B通道值
	FRAME_RATE_PRIORITYS    = $e,   //帧频优先
	ZOOM                    = $f,   //变焦
	PAN                     = $10,  //遥摄
	TILT                    = $11,  //相机倾斜度
	OPTICAL_FILTER          = $12,  //光学滤波
	CAPTURE_SIZE_FORMAT6    = $13,  //F6M0_EXIF_FORMAT视频格式对应的特性属性：捕获大小
	CAPTURE_QUALITY_FORMAT6 = $14,  //F6M0_EXIF_FORMAT视频格式对应的特性属性：图像质量
	DIGITAL_SHIFT           = $15,	//数字位移
	BIT_INVERSE             = $16,	//位反转
	PROCESS_SPEED           = $17,  //相机内部处理数据速度
	CLOCK                   = $18   //相机的时钟频率
);

//特性参数调节方式
type FCAM_ADJUST_MODE =
(
	AUTO      = $0,        //相机自动调节
	MANUAL    = $1,        //手动调节（用户调节）
	ONE_PUSH  = $2         //相机一次调节模式
);

//参数值类型
type FCAM_VALUE_TYPE =
(
	FLOAT_VALUE = $0,          //浮点型
  LONG_VALUE  = $1          //整型
);

//像素格式信息
type FCAM_PIXEL_FORMAT =
(
	Raw8       = $0,        //彩色传感器输出的8位原始数据
	Raw16      = $1,        //彩色传感器输出的16位原始数据
	YMono8     = $2,        //8位亮度信息数据
	YMono16    = $3,        //16位亮度信息数据,无符号
	S_YMono16  = $4,        //16位亮度信息数据,有符号
	RGB8       = $5,        //R=B=G=8bit  R-G-B-R-G-B
	RGB16      = $6,        //R=B=G=16bit R-G-B-R-G-B
	S_RGB16    = $7,        //R=B=G=16bit,有符号整型

	YUV444     = $8,        //U-Y-V-U-Y-V排列，均占8bit，pixel bit = 24
	YUV422     = $9,        //U-Y-V-Y-U-Y-V-Y排列，均占8bit,pixel bit = 16
	YUV411     = $a         //U-Y-Y-V-Y-Y-U排列，均占8bit, pixel bit = 12
);

//视频格式类型
type FCAM_VIDEO_FORMAT =
(
	F0M0_160_120YUV444  = $0,  //图像分辨率为160 * 120，像素格式为YUV444
	F0M1_320_240YUV422  = $1,  //图像分辨率为320 * 240，像素格式为YUV422
	F0M2_640_480YUV411  = $2,  //图像分辨率为640 * 480，像素格式为YUV411
	F0M3_640_480YUV422  = $3,  //图像分辨率为640 * 480，像素格式为YUV422
	F0M4_640_480RGB8    = $4,  //图像分辨率为640 * 480，像素格式为RGB8
	F0M5_640_480YMono8  = $5,  //图像分辨率为640 * 480，像素格式为YMono8
	F0M6_640_480YMono16 = $6,  //图像分辨率为640 * 480，像素格式为YMono16


	F1M0_800_600YUV422   = $7, //图像分辨率为800 * 600，像素格式为YUV422
	F1M1_800_600RGB8     = $8, //图像分辨率为800 * 600，像素格式为RGB8
	F1M2_800_600YMono8   = $9, //图像分辨率为800 * 600，像素格式为YMono8
	F1M3_1024_768YUV422  = $a, //图像分辨率为1024 * 768，像素格式为YUV422
	F1M4_1024_768RGB8    = $b, //图像分辨率为1024 * 768，像素格式为RGB8
	F1M5_1024_768YMono8  = $c, //图像分辨率为1024 * 768，像素格式为YMono8
	F1M6_800_600YMono16  = $d, //图像分辨率为800 * 600，像素格式为YMono16
	F1M7_1024_768YMono16 = $e, //图像分辨率为1024 * 768，像素格式为YMono16

	F2M0_1280_960YUV422   = $f,  //图像分辨率为1280 * 960，像素格式为YUV422
	F2M1_1280_960RGB8     = $10, //图像分辨率为1280 * 960，像素格式为RGB8
	F2M2_1280_960YMono8   = $11, //图像分辨率为1280 * 960，像素格式为YMono8
	F2M3_1600_1200YUV422  = $12, //图像分辨率为1600 * 1200，像素格式为YUV422
	F2M4_1600_1200RGB8    = $13, //图像分辨率为1600 * 1200，像素格式为RGB8
	F2M5_1600_1200YMono8  = $14, //图像分辨率为1600 * 1200，像素格式为YMono8
	F2M6_1280_960YMono16  = $15, //图像分辨率为1280 * 960，像素格式为YMono16
	F2M7_1600_1200YMono16 = $16, //图像分辨率为1600 * 1200，像素格式为YMono16

	F6M0_EXIF_FORMAT      = $17, //静止图像格式

	//厂商自定义格式
  F7M0_CUSTOM           = $18, //厂商自定义格式0
	F7M1_CUSTOM           = $19, //厂商自定义格式1
	F7M2_CUSTOM           = $1a, //厂商自定义格式2
	F7M3_CUSTOM           = $1b, //厂商自定义格式3
	F7M4_CUSTOM           = $1c, //厂商自定义格式4
	F7M5_CUSTOM           = $1d, //厂商自定义格式5
	F7M6_CUSTOM           = $1e, //厂商自定义格式6
	F7M7_CUSTOM           = $1f  //厂商自定义格式7
);

//帧频格式
type FCAM_FRAME_RATE =
(
	RATE_1_875    = $0,        //1.875帧每秒
	RATE_3_75     = $1,        //3.75帧每秒
	RATE_7_5      = $2,        //7.5帧每秒
	RATE_15       = $3,        //15帧每秒
	RATE_30       = $4,        //30帧每秒
	RATE_60       = $5,        //60帧每秒
	RATE_120      = $6,        //120帧每秒
	RATE_240      = $7,        //240帧每秒
	RATE_ANY      = $8         //帧频不受限，可能为任何值，由相机硬件厂商决定

);

//滤光片阵列格式
type FCAM_COLORFILTER_PATTERN =
(
	NONE  = $0,	       //非Bayer阵列
	RG_GB = $1,        //Bayer阵列，排列方式为：第一行：R G R G…… 第二行：G B G B……
	GB_RG = $2,        //Bayer阵列，排列方式为：第一行：G B G B…… 第二行：R G R G……
	GR_BG = $3,        //Bayer阵列，排列方式为：第一行：G R G R…… 第二行：B G B G……
	BG_GR = $4         //Bayer阵列，排列方式为：第一行：B G B G…… 第二行：G R G R……

);

//触发源类型
type FCAM_TRIGGER_SOURCE =
(
	TRIGGER_SOR0     = $0,       //硬件0触发源
	TRIGGER_SOR1     = $1,       //硬件1触发源
	TRIGGER_SOR2     = $2,       //硬件2触发源
	TRIGGER_SOR3     = $3,       //硬件3触发源
	TRIGGER_SOR4     = $4,       //硬件4触发源
	TRIGGER_SOR5     = $5,       //硬件5触发源
	TRIGGER_SOR6     = $6,       //硬件6触发源
	TRIGGER_SOFT     = $7       //软件触发

);

//数据传输模式
type FCAM_TRANSTYPE =
(
	IDLE            = $0,       //当前相机不传输数据
	ONE_SHOT        = $1,       //当前相机的传输任务为传输一帧图像数据后，转为IDLE模式
	MUTI_SHOT       = $2,       //当前相机的传输任务为传输多帧图像数据后，转为IDLE模式
	CONTINUOUS_SHOT = $3        //当前相机的传输任务为连续传输

);

//1394相机的传输速度
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
	GSP_FEATURE                = $0,       //特性参数类型，对应FCAM_GSP_FEATURE结构体
	GSP_IMAGE                  = $1,       //图像参数类型，对应FCAM_GSP_IMAGE结构体
	GSP_TRANS                  = $2,       //传输参数类型，对应FCAM_GSP_TRANS结构体
	GSP_STROBE                 = $3,       //频闪灯参数类型，对应FCAM_GSP_STROBE结构体
	GSP_TRIGGER                = $4        //触发参数类型，对应FCAM_GSP_TRIGGER结构体

);

//DIGITAL_SHIFT特性值对应的类型
type VAL_DIGITAL_SHIFT =
(
	DS_HIGH_8BITS	= $0,     //高八位
	DS_MID_8BITS	= $1,     //中八位
	DS_LOW_8BITS	= $2     //低八位
);

//触发或者频闪灯极性值对应的类型
type VAL_POLARITY =
(
	POL_LOW_ACTIVE	= $0,     //低电平有效
	POL_HIGH_ACTIVE = $1      //高电平有效
);

////////////////////////////////////////////////////////////////////////////////
//参数值范围信息
FEATURE_VALUE_RANGE = packed record
    bLongValueValid: longBool;     //整型信息是否有效，若为TRUE，lMax_Value、lMin_Value、lStep有效，反之无效

		lMax_Value: Longint;          //整型参数值的最大值
		lMin_Value: Longint;          //整型参数值的最小值
		lStep: Longint;               //整型参数值的单位步进值

		bFloatValueValid: longBool;   //浮点型信息是否有效，若为TRUE，fMax_Value、fMin_Value、fStep有效，反之无效

		fMax_Value: Single;          //浮点型参数值的最大值
		fMin_Value: Single;          //浮点型参数值的最小值
		fStep: Single;               //浮点型参数值的单位步进值
end;

//FCAM_PARAMINFO_TYPE的FEATURE_INFO对应的结构体
FCAM_FEATURE_INFO = packed record
    featureType: FCAM_FEATURE_TYPE;   //相机特性类型，为输入参数

    bAvaliable: longBool;              //该特性当前是否可用，TRUE为可用，FALSE为不可用
	  bCanOnePush: longBool;             //该特性是否支持one push调节模式，TRUE支持，FALSE不支持
	  bCanOnOff: longBool;               //该特性是否支持使能和不使能的切换操作，TRUE支持，FALSE不支持
	  bCanReadOut: longBool;             //该特性的参数值是否可读，TRUE支持，FALSE不支持
	  bCanAuto: longBool;                //该特性是否支持自动调节模式，TRUE支持，FALSE不支持
	  bCanManual: longBool;              //该特性是否支持手动调节模式，TRUE支持，FALSE不支持

	  FeatureInfoValue: FEATURE_VALUE_RANGE
end;
////////////////////////////////////////////////////////////////////////////////
//USB接口信息
INTERFACE_USBSPEC  = packed record
    bIsUsb20: longBool;    //相机连接的USB接口是否是USB2.0接口，若不是，相机无法正常工作
end;
//接口信息
FCAM_INTERFACE_INFO = packed record
    CameraType: FCAM_CAMERA_TYPE;  //相机类型，若为CAMERA_USB，SUsbSpec结构体信息有效
	  SUsbSpec: INTERFACE_USBSPEC;
end;
/////////////////////////////////////////////////////////////////////////////////
//HARDWARE_INFO对应的结构体
FCAM_HARDWARE_INFO = packed record
	VendorName: Array[0..99] of Char;    //厂商名
	ModelName: Array[0..99] of Char;     //型号名
	ulCameraID: Array[0..1] of Longword; //相机ID
	byHdEdition: Array[0..3] of Byte;    //硬件版本号
  byHdUpdateTime: Array[0..3] of Byte; //硬件更新日期
end;
////////////////////////////////////////////////////////////////////////////////
//1394专有图像信息,保留
IMAGEINFO_S1394SPEC = packed record
  fFrameInterval: Single;
end;
//图像信息
FCAM_IMAGE_INFO = packed record

  FormatMode: FCAM_VIDEO_FORMAT; //FCAM_VIDEO_FORMAT视频格式类型，输入参数

	bSupport: longBool;           //相机是否支持该视频格式，TRUE支持，FALSE不支持

	bAOI: longBool;              //该视频格式是否支持开窗操作，TRUE支持，FALSE不支持
	ulMaxWidthSize: Longword;    //该视频格式支持的图像宽度的最大分辨率
	ulMaxHeightSize: Longword;   //该视频格式支持的图像高度的最大分辨率
	ulLeftPosUnit: Longword;     //开窗起始列步进单位，bAOI为FALSE时该参数无效，忽略
	ulTopPosUnit: Longword;      //开窗起始行步进单位，bAOI为FALSE时该参数无效，忽略
	ulWidthSizeUnit:Longword;    //开窗宽度步进单位，bAOI为FALSE时该参数无效，忽略
	ulHeightSizeUnit: Longword;  //开窗高度步进单位，bAOI为FALSE时该参数无效，忽略

  ColorFilterPattern: FCAM_COLORFILTER_PATTERN;   //该视频格式的彩色滤光片阵列模式
	bSupportFrameRate: Array[0..8] of longBool;     //对FCAM_1394_FRAME_RATE帧频的支持
	bSupportPixelFormat: Array[0..10] of longBool; //对FCAM_PIXEL_FORMAT像素格式的支持

  CameraType: FCAM_CAMERA_TYPE;   //当前的相机类型，若为CAMERA_1394，S1394Spec结构体有效
  S1394Spec: IMAGEINFO_S1394SPEC;
end;
////////////////////////////////////////////////////////////////////////////////
//for STROBE_INFO频闪灯信息
FCAM_STROBE_INFO = packed record

	ulStrobeIndex: LongWord;        //频闪灯通道选择，输入参数，从0~3

	bAvaliable: longBool;           //相机是否支持该路频闪灯操作，TRUE表示支持，FALSE为不支持
	bCanOnOff: longBool;            //该通道是否支持使能或者不使能的切换操作，TRUE支持，FALSE不支持
	bCanReadOut: longBool;          //该通道的参数值是否可读，TRUE可读，FALSE不可读
	bCanChangePolarity: longBool;   //频闪灯极性是否可改变，TRUE表示可以改变，FALSE不可改变

	StrobeInfoValue: FEATURE_VALUE_RANGE; //参数(频闪等的延迟和持续时间)值信息
end;

///////////////////////////////////////////////////////////////////////////////
//触发
FCAM_TRIGGER_INFO = packed record

	bAvaliable: longBool;               //该相机是否支持触发功能，TRUE表示支持，FALSE为不支持
	bCanOnOff: longBool;                //触发功能是否支持使能或者不使能的切换操作，TRUE为支持，FALSE不支持
	bCanReadOut: longBool;              //触发参数值是否可读，TRUE可读，FALSE不可读
	bCanChangePolarity: longBool;       //触发极性是否可改变，TRUE表示可以改变，FALSE不可改变
	bCanReadRawTrgInput: longBool;      //原始触发输入信号值是否可读，若bCanReadOut为FALSE，该值忽略

	bHdTriggerSor: Array[0..6] of longBool;         //相机对FCAM_TRIGGER_SOURCE定义的TRIGGER_SOR0到TRIGGER_SOR6七种触发通道的支持
	bSoftWareTrigger: longBool;                     //相机是否支持软件触发功能，TRUE为支持，FALSE为不支持
	bTriggerMode: Array[0..15] of longBool;         //相机对16种触发模式的支持，TRUE为支持，否则不支持
end;
////////////////////////////////////////////////////////////////////////////////
//1394数据传输信息
FCAM_DATATRANS_S1394SPEC = packed record
	 bSpeedSupport: Array[0..5] of longBool;     //对FCAM_1394SPEED定义的6种速度的支持，TRUE为支持，FALSE为不支持
	 ulMaxChannelNumber: Longword;               //相机支持的最大可用通道值,从0开始
end;
//数据传输信息
FCAM_DATATRANS_INFO = packed record

	bCanMutiShot: longBool;             //相机是否支持连续采集传输模式，TRUE为支持，FALSE为不支持
	bCanContinusShot: longBool;         //相机是否支持多帧采集传输模式，TRUE支持，FALSE不支持
	bCanOneShot: longBool;              //相机是否支持单帧采集传输模式，TRUE支持，FALSE不支持

	ulMaxStreamBufferCount: Longword;    //数据缓冲区可设的最大个数
	ulMaxFrameCountOfBuffer: Longword;   //传输缓冲区包含的最大帧数

  CameraType: FCAM_CAMERA_TYPE;      //相机类型，若为CAMERA_1394，S1394Spec结构体信息有效

	S1394Spec: FCAM_DATATRANS_S1394SPEC;
end;
////////////////////////////////////////////////////////////////////////////////
//整型值
FCAM_FEATURE_LONG_VALUE = packed record
  ulValueCnt: Longword;       //当前整型参数值个数，最大为3
  lValue: Array[0..2] of Longword;  //若ValueType为LONG_VALUE，前uValueCnt个值为对应的参数值
end;
//浮点型值
FCAM_FEATURE_FLOAT_VALUE = packed record
  ulValueCnt: Longword;           //当前浮点参数值个数，最大为3
	fValue: Array[0..2] of Single;  //若ValueType为FLOAT_VALUE，前uValueCnt个值为对应的参数值
end;
//特性参数值
FCAM_GSP_FEATURE = packed record

  FeatureType: FCAM_FEATURE_TYPE; //FCAM_FEATURE_TYPE定义的特性类型，输入参数

  bAvaliable: longBool;   //相机是否支持该特性设置，同于FCAM_FEATURE_INFO中的bAvaliable,只读

  bPresentOn: longBool;  //若为TRUE，该特性使能，否则不使能，
                         //若FCAM_FEATURE_INFO中的bCanOnOff为FALSE，则该参数为只读，不可改变

  AdjustMode: FCAM_ADJUST_MODE;  //FCAM_ADJUST_MODE类型定义的调节模式

	bValueValid: longBool; //参数值是否有效，若为TRUE，则ValueType和FeatureValue中的值有效，反之无效

  ValueType: FCAM_VALUE_TYPE;   //当前参数值类型，见FCAM_VALUE_TYPE定义。若为FLOAT_VALUE，
                                //则FloatValue结构体有效，若为LONG_VALUE，则LongValue结构体有效

	LongValue: FCAM_FEATURE_LONG_VALUE;
	FloatValue: FCAM_FEATURE_FLOAT_VALUE;
end;
////////////////////////////////////////////////////////////////////////////////
//1394包参数
FCAM_IMAGE_1394PACKET = packed record
  bDataVerify: longBool;             //是否对数据进行校验，该值在当前版本忽略

	bPacketSetable: longBool;          {只读参数，表示当前包大小是否可设，TRUE为可设，且ulUnitBytePerPacket
											              ulMaxBytePerPacket、ulRecBytePerPacket有效，反之无效，且ulPacketSize为只读参数}

  ulUnitBytePerPacket: Longword;     //包大小设置单位，也为包大小可设的最小值，只读
	ulMaxBytePerPacket: Longword;      //包大小可设的最大值，只读
	ulRecBytePerPacket: Longword;      //相机推荐的包大小，为0表示忽略，只读

	ulPacketSize: Longword;            //当前包大小，若包大小不可设，该值只读。若报大小可设且该值为0，则包大小设置忽略
	ulPacketPerFrame: Longword;        //当前一帧图像数据的包个数，只读

end;

//相机某一视频格式下的图像参数
FCAM_GSP_IMAGE = packed record

  FormatMode: FCAM_VIDEO_FORMAT;   //当前视频格式
  FrameRate: FCAM_FRAME_RATE;     //当前帧频模式

  PixelFormat: FCAM_PIXEL_FORMAT; //当前的像素格式
	ulPixelBits: Longword;   //像素位数,read only,设置时忽略该值
	
	ulLeft: Longword;        //显示图像的起始列，当获得的FCAM_IMAGE_INFO信息结构体中的bAOI为TRUE时，该值可按照ulLeftPosUnit设置，否则只读
	ulTop: Longword;         //显示图像的起始行。当获得的FCAM_IMAGE_INFO信息结构体中的bAOI为TRUE时，该值可按照ulTopPosUnit设置，否则只读
	ulWidth: Longword;       //显示图像的宽度，当获得的FCAM_IMAGE_INFO信息结构体中的bAOI为TRUE时，该值可按照ulWidthSizeUnit设置，否则只读
	ulHeight: Longword;      //显示图像的高度，当获得的FCAM_IMAGE_INFO信息结构体中的bAOI为TRUE时，该值可按照ulHeightSizeUnit设置，否则只读

  CameraType: FCAM_CAMERA_TYPE;    //相机类型，若该值为CAMERA_1394,S1394Spec结构体有效，否则S1394Spec无效
	S1394Spec: FCAM_IMAGE_1394PACKET; //1394相机包信息
end;

////////////////////////////////////////////////////////////////////////////////
//频闪灯整型参数值
FCAM_STROBE_LONG_VALUE = packed record
  lDelayValue: Longword;      //为频闪灯延迟时间，整型
	lDurationValue: Longword;   //为频闪灯持续时间，整型
end;

FCAM_STROBE_FLOAT_VALUE = packed record
  fDelayValue: Single;      //为频闪灯延迟时间，浮点型
	fDurationValue: Single;   //为频闪灯持续时间，浮点型
end;

FCAM_GSP_STROBE = packed record

	ulStrobeIndex: Longword;//频闪灯通道值，从0-3,输入参数

	bAvaliable: longBool;   //相机是否支持频闪灯通道设置，同于同样通道FCAM_STROBE_INFO信息中的
                          //bAvaliable。该参数为只读参数，即只能获取不能设置。若该参数为FALSE，
                          //以下所有参数值无效

	bPresentOn: longBool;   //若为TRUE，该特性设置使能，否则不使能，若FCAM_STROBE_INFO中的bCanOnOff为FALSE，则该参数为只读，不可设置
	byPolarity: Longword;   //频闪灯极性，若FCAM_STROBE_INFO中的bCanChangePolarity为TRUE，则该参数可读可设，否则该参数只读

	bValueValid: longBool;  //参数值是否有效，若为TRUE，则ValueType和StrobeValue中的值有效，反之无效

	ValueType:FCAM_VALUE_TYPE;    //当前参数值类型，见FCAM_VALUE_TYPE定义。若为FLOAT_VALUE，则FloatValue结构体有效，
                                //若为LONG_VALUE，则LongValue结构体有效
	
  LongValue: FCAM_STROBE_LONG_VALUE;
  FloatValue: FCAM_STROBE_FLOAT_VALUE;
end;
/////////////////////////////////////////////////////////////////////////////////
//-for GSP_TRIGGER-触发参数
FCAM_GSP_TRIGGER = packed record
	bAvaliable: longBool;       //相机是否支持触发设置，同于FCAM_TRIGGER_INFO信息中的bAvaliable。
                              //该参数为只读参数，即只能获取不能设置。若该参数为FALSE，以下所有参数值无效

	bPresentOn: longBool;       //若为TRUE，该特性设置使能，否则不使能，若对应的FCAM_TRIGGER_INFO信息中的bCanOnOff为FALSE，则该参数为只读，不可设置

	ulTrgPolarity: Longword;         //触发极性，若FCAM_TRIGGER_INFO中的bCanChangePolarity为TRUE，则该参数可读可设，否则该参数只读
  TrgSorce: FCAM_TRIGGER_SOURCE;   //触发源
	ulTrgleMode: Longword;           //触发模式

	bValueValid: longBool;           //触发信号值是否有效
	ulTrgInputValue: Longword;       //触发信号，只读
end;
////////////////////////////////////////////////////////////////////////////////
//for GSP_TRANS-
//1394传输参数
FCAM_GSP_TRANS_S1394SPEC = packed record
	uChannel: Longword;      //传输通道值，最大值对应FCAM_DATATRANS_INFO中的uMaxChannelNumber
	TransSpeed: FCAM_1394SPEED;    //传输速度，对各速度类型的支持见FCAM_DATATRANS_INFO中的bSpeedSupport[6]
end;
//相机传输参数
FCAM_GSP_TRANS = packed record
  TransMode: FCAM_TRANSTYPE;      //当前传输模式
	ulTransFrameCnt: Longword;      //多帧传输模式的传输帧数，当传输模式为MUTI_SHOT时，该值有效，否则忽略

	ulStreamBufferCnt: Longword;     //流传输的数据缓冲区个数，最大值对应FCAM_DATATRANS_INFO中的uMaxStreamBufferCount

	ulFrameCntOfOneBuffer: Longword; //一个数据缓冲区存储的帧数。在ONE_SHOT传输模式下，该值必须为1，在MUTI_SHOT模式下，
	                                 //该值应能整除uTransFrameCnt，最大值对应FCAM_DATATRANS_INFO中的uMaxFrameCountOfBuffer
	ulStreamBufferSize: Longword;    //流传输的数据缓冲区大小，以字节为单位，只读

  CameraType: FCAM_CAMERA_TYPE;    //相机类型，当该值为CAMERA_1394时，S1394Spec有效，否则无效
	S1394Spec: FCAM_GSP_TRANS_S1394SPEC;
end;

//////////////////////////////////////////////////////////////////////////////////////
FCAM_COMMU_INFO = packed record
	pDataBuffer: Pointer;              //当前数据缓冲区的地址
	ulDataSizes: Longword;              //数据缓冲区的大小，字节为单位
	ulFrameCountOfData: Longword;       //该数据缓冲区包含的帧数

	ulFrameLeft: Longword;              //每帧数据图像的开窗起始列数
	ulFrameTop: Longword;               //每帧数据图像的开窗起始行数
	ulFrameWidth: Longword;             //每帧数据图像的宽度
	ulFrameHeight: Longword;            //每帧数据图像的高度
	ulFrameSizes: Longword;             //一帧图像数据的大小，字节为单位
	ulFrameAvaliableSizes: Longword;    //一帧图像数据的有效字节数

  PixelFormat: FCAM_PIXEL_FORMAT;     //像素格式
	ulFramePixelBits: Longword;         //像素位数

	ulDeviceIndex: Longword;            //当前相机序号
  CameraType: FCAM_CAMERA_TYPE;       //当前相机类型
	pUserParam: Pointer;                //用户自定义数据类型指针
end;

//返回值和窗口句柄标识
type
    HRESULT             =     LongWord;
    HWND                =     LongWord;

//定义一个类型的指针类型
type
PFCAM_COMMU_INFO = ^FCAM_COMMU_INFO;
//回调函数声明
PFCAM_CALLBACK = function(pCommuParam: PFCAM_COMMU_INFO): Integer; stdcall;

//自动调节回调函数
//pParam为调节好的参数值结构体指针，只在回调函数中有效
//pContext用户自定义结构体指针
PFCAM_AUTOSET_CALLBACK = procedure(pParam: Pointer; pContext: Pointer); stdcall;
//////////////////////////////////////////////////////////////////////////

//消息定义
const WM_USER             = $0400;
const WM_FCAM_MESSAGE           = WM_USER + 500;         //主消息
const WM_FCAM_ONE_RSVD          = WM_FCAM_MESSAGE + 1;  //收到图像缓冲区大小的图像数据
const WM_FCAM_ONE_FAILED        = WM_FCAM_MESSAGE + 2;  //获取图像数据失败

/////////////////////////返回值定义//////////////////////////////////////
FCAM_SUCCESS: HRESULT                =$20000000;      //操作成功
FCAM_UNSUCCESSFUL: HRESULT           =$E0000000;    //操作失败
FCAM_NO_SUCH_DEVICE:HRESULT          =$E0000001;    //找不到指定的设备
FCAM_DEVICE_INIT_FAIL:HRESULT        =$E0000002;    //设备初始化失败
FCAM_DEVICE_NOT_MATCH:HRESULT        =$E0000003;    //设备不匹配
FCAM_DEVICE_TRANS_FAILED:HRESULT     =$E0000004;    //设备传输失败，在获得该类型的返回值后，应尝试重新启动数据传输
FCAM_CONFIGFILE_NOT_MATCH:HRESULT    =$E0000005;    //配置文件不匹配

FCAM_INVALID_PARAMETER:HRESULT       =$E0000020;    //无效参数
FCAM_INVALID_TRIGGER_SOURCE:HRESULT  =$E0000021;    //无效的触发源
FCAM_INVALID_TRIGGER_MODE:HRESULT    =$E0000022;    //无效的触发模式
FCAM_INVALID_HANDLE_VALUE:HRESULT    =$E0000023;    //无效的句柄值

FCAM_INSUFFICIENT_RESOURCE:HRESULT   =$E0000040;    //资源不足
FCAM_REASONLESS_PARAMETER:HRESULT    =$E0000041;    //不合理的参数
FCAM_RESONLESS_PACKETSIZE:HRESULT    =$E0000042;    //不合理的包大小

FCAM_FEATURE_NOT_SUPPORT:HRESULT     =$E0000050;    //特性属性不支持
FCAM_VIDEOFORMAT_NOT_SUPPORT:HRESULT =$E0000051;    //视频格式不支持
FCAM_TRIGGER_NOT_SUPPORT:HRESULT     =$E0000052;    //触发不支持
FCAM_STROBE_NOT_SUPPORT:HRESULT      =$E0000053;    //频闪灯通道不支持
FCAM_FRAMERATE_NOT_SUPPORT:HRESULT   =$E0000054;    //帧频不支持
FCAM_PIXELFORMAT_NOT_SUPPORT:HRESULT =$E0000055;    //像素格式不支持
FCAM_AOI_NOT_SUPPORT:HRESULT         =$E0000056;    //开窗不支持
FCAM_REGISTER_RW_NOT_SUPPORT:HRESULT =$E0000057;    //某地址的寄存器读写不支持
FCAM_AUTOWHB_NOT_SUPPORT:HRESULT     =$E0000058;     //自动白平衡不支持
FCAM_TRANSMODE_NOT_SUPPORT:HRESULT   =$E0000059;     //传输模式不支持
FCAM_TRANSSPEED_NOT_SUPPORT:HRESULT  =$E0000060;     //传输速度不支持

FCAM_SOFTTRIGGER_BUSY:HRESULT        =$E0000070;     //上一帧软件触发没有结束
//////////////////////////////////////////////////////////////////////////

implementation

end.

