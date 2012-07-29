{FCAM unit
//*
//* Copyright (c) 2006, 西安方诚科技有限责任公司
//* All rights reserved.
//*
//* 文件名称：FCAM.h
//* 文件标识：FCAM.h
//* 摘    要：FCAM.dll输出函数声明
//*
//* 开发环境：Microsoft Win32 SDK, Visual C++ 6.00
//*
//* 当前版本：V2.1.0
//* 作    者：赵星梅
//* 完成日期：
//* 替代版本：V2.0.0
//* 作    者：赵星梅
//* 完成日期：
//*
//* 说明: 增加了对130万彩色相机的自动白平衡函数
          增加了软件触发功能
//* }


unit FCAM;

interface

uses FCAM_Def;

{*
*函数说明: 获得指定序列号和相机类型的相机句柄。
*输入参数: uDeviceIndex:  相机序列号，从1开始。
           CameraType:    相机类型,见FCAM_Def.h文件，FCAM_CAMERA_TYPE类型定义。
*输出参数: 无。
*返 回 值: 成功返回代表该相机的设备句柄，否则返回NULL。
*}
function FCAM_GetDevice(uDeviceIndex: Longword; CameraType: FCAM_CAMERA_TYPE): THandle; stdcall;

{*
*函数说明: 释放获取的设备句柄。
*输入参数: hDev:  待释放的设备句柄。
*输出参数: 无。 
*返 回 值: 成功返回FCAM_SUCCESS，否则返回相应的错误代码。

注: FCAM_GetDevice必须与FCAM_ReleaseDevice配对使用，即使用n次FCAM_GetDevice，
    相应的要调用n次FCAM_ReleaseDevice函数，才能正确释放设备句柄。
*}
function FCAM_ReleaseDevice(hDev: THandle): HRESULT; stdcall;

{*
*函数说明: 获得设备句柄的引用计数，即调用FCAM_GetDevice成功的次数。必须调用引用计
           数次的FCAM_ReleaseDevice才能最终销毁设备对象。

*输入参数: hDev:   已获取的设备句柄。
*输出参数: 无。 
*返 回 值: 返回设备句柄的引用计数。
*}
function FCAM_GetDeviceReferenceCount(hDev: THandle): HRESULT; stdcall;

{*
*函数说明: 启动相机数据传输任务
*输入参数: hDev: 获取的设备句柄
*输出参数: 无
*返回值:   成功返回FCAM_SUCCESS,否则返回相应的错误代码
*}
function FCAM_StartCapture(hDev: THandle): HRESULT; stdcall;

{*
*函数说明: 取消(停止)相机的数据传输
*输入参数: hDev: 获取的设备句柄
*输出参数: 无
*返回值:   成功返回FCAM_SUCCESS,否则返回相应的错误代码
*}
function FCAM_StopCapture(hDev: THandle): HRESULT; stdcall;

{*
*函数说明: 设置相机各类型参数的当前值
*输入参数: hDev:          获取的设备句柄
*          uType:         FCAM_GSP_PARAME_TYPE枚举类型，详见FCAM_Def.h文件
*          pParamStruct:  uType所对应的结构体指针，用来存储设置的参数值
*输出参数: 无
*返回值:   成功返回FCAM_SUCCESS,否则返回相应的错误代码
*}
function FCAM_SetParameter(hDev: THandle; uType: FCAM_GSP_PARAME_TYPE; pParamStruct: pointer): HRESULT; stdcall;

{*
*函数说明: 获取相机各类型参数的当前值
*输入参数: hDev:          获取的设备句柄
*          uType:         FCAM_GSP_PARAME_TYPE枚举类型，详见FCAM_Def.h文件
*          pParamStruct:  uType所对应的结构体指针，用来存储获取到的参数的当前值
*输出参数: 无
*返回值:   成功返回FCAM_SUCCESS,否则返回相应的错误代码
*}
function FCAM_GetParameter(hDev: THandle; uType: FCAM_GSP_PARAME_TYPE; pParamStruct: pointer): HRESULT; stdcall;

{*
*函数说明: 获取相机各参数的信息
*输入参数: hDev:               获取的设备句柄
*          uType:              FCAM_PARAMINFO_TYPE信息参数类型，详FCAM_Def.h文件
*          pParamInfoStruct:   uType所对应的存储参数信息的结构体指针
*输出参数: 无
*返回值:   成功返回FCAM_SUCCESS,否则返回相应的错误代码 
*}
function FCAM_GetParameterInfo(hDev: THandle; uType: FCAM_PARAMINFO_TYPE; pParamInfoStruct: Pointer): HRESULT; stdcall;
//////////////////////////////////////////////////////////////////////////
//数据获取
{*
*函数说明: 获取一个图像数据缓冲区指针，必须与FCAM_PutInFrameBuffer成对使用
*输入参数: hDev:              获取的设备句柄。
           pBuffer:           存储图像数据指针的缓冲区地址。
           pulBufferSizes:    存储buffer大小的缓冲区地址,大小以字节为单位。
           dwWaitMillTime:    获取操作的等待时间。
*输出参数: 无
*返回值:   成功返回FCAM_SUCCESS,否则返回相应的错误代码 
*}
function FCAM_GetOutFrameBuffer(hDev: THandle; out pBuffer: Pointer; out ulBufferSizes: Longword; dwWaitMillTime: Longword): HRESULT; stdcall;

{*
*函数说明: 归还获取的图像数据缓冲区指针
*输入参数: hDev:         获取的设备句柄
*          pBuffer:      获取的图像数据指针
*输出参数: 无
*返回值:   成功返回FCAM_SUCCESS,否则返回相应的错误代码 
*}
function FCAM_PutInFrameBuffer(hDev:THandle; pBuffer: Pointer): HRESULT; stdcall;
/////////////////////////////////////////////////////////////////////////////////////////////////
//软件触发
{*
*函数说明：当前设备状态为软件触发时，给一个软件触发信号，相机接到信号后开始曝光，一帧图像曝光完毕后，
*		   停止曝光，等待下一个触发信号。
*输入参数：hDev：获取的设备句柄
*输出参数：无。
*返 回 值：操作成功则返回FCAM_SUCCESS，否则返为相应的错误码。
*}
function FCAM_SoftWareTrigger(hDev: THandle): HRESULT; stdcall;
/////////////////////////////////////////////////////////////////////////////////////////////////
//相机配置
{*
*函数说明: 保存当前的相机配置到指定文件
*输入参数: hDev:          获取的设备句柄
		   pFileName:     指定文件名
*输出参数: 无
*返回值:   成功返回FCAM_SUCCESS,否则返回相应的错误代码
*}
function FCAM_SaveCameraConfiguration(hDev: THandle;  pFileName: pchar): HRESULT; stdcall;

{*
*函数说明: 从指定文件中读取相机的配置信息并加载到相机中，若当前传输已建立，请停止传输后再调用该函数
*输入参数: hDev:          获取的设备句柄
		   pFileName:     指定文件名
*输出参数: 无
*返回值:   成功返回FCAM_SUCCESS,否则返回相应的错误代码
*}
function FCAM_LoadCameraConfiguration(hDev: THandle;  pFileName: pchar): HRESULT; stdcall;

//////////////////////////////////////////////////////////////////////////
//寄存器读写
{*
*函数说明: 指定地址寄存器读
*输入参数: hDev:          获取的设备句柄
		   ucRegAddr:     寄存器地址
		   ucValue:       存取读取到的数据的数组，4字节
*输出参数: 无
*返回值:   成功返回FCAM_SUCCESS,否则返回相应的错误代码
*}
function FCAM_ReadRegister(hDev:Thandle; ucRegAddr: Array of Byte; ucValue: Array of Byte): HRESULT; stdcall;

{*
*函数说明: 指定地址寄存器写
*输入参数: hDev:          获取的设备句柄
		   ucRegAddr:     寄存器地址
		   ucValue:       存取写入的数据的数组，4字节
*输出参数: 无
*返回值:   成功返回FCAM_SUCCESS,否则返回相应的错误代码
*}
function FCAM_WriteRegister(hDev:Thandle; ucRegAddr: Array of Byte; ucValue: Array of Byte): HRESULT; stdcall;

//////////////////////////////////////////////////////////////////////////
//设备事件处理
{*
*函数说明: 设置流传输的回调函数，该函数在每传满一个数据缓冲区后，该函数被调用一次
*输入参数: hDev:         获取的设备句柄
           pCallBack:    回调例程函数地址
           pUserParam:   用户自定义结构体指针, 详见FCAM_Def.h文件
*返回值:   成功返回FCAM_SUCCESS,否则返回相应的错误代码
*}
function FCAM_SetStreamCallBackRoutine(hDev:THandle; pCallBack:PFCAM_CALLBACK; pUserParam:Pointer): HRESULT; stdcall;

{*
*函数说明: 设置流传输的事件通知窗口句柄, 在每传输满一个buffer，该窗口将会收到WM_FCAM_MESSAGE类型的消息
           消息详见FCAM_Def.h文件
*输入参数: hDev:         获取的设备句柄
           hMsgWnd:      消息接收窗口句柄
		   pUserParam:   用户自定义结构体指针, 详见FCAM_Def.h文件
*返回值:   成功返回FCAM_SUCCESS,否则返回相应的错误代码
*}
function FCAM_SetMessageNotifyWindow(hDev:THandle; hMsgWnd:HWND; pUserParam:Pointer): HRESULT; stdcall;

//相机自动调节，目前只针对FUNCTION-TECH的130万像素彩色相机
{*
*函数说明: 启动相机的自动白平衡调节，调节区域为图像中心区域480*360, 若图像大小不足，则全图调节
*输入参数: hDev:               获取的设备句柄
           pAutoCallBack:      回调函数，当自动白平衡调节完毕后，该函数被调用
		       pAutoContext:       用户传入的在pAutoCallBack函数中用到的数据指针
*返回值:   成功返回FCAM_SUCCESS,否则返回相应的错误代码
*}
function FCAM_SetDoAutoWHB(hDev:THandle; pAutoCallBack:PFCAM_AUTOSET_CALLBACK; pAutoContext:Pointer): HRESULT; stdcall;

///////////////////////////////////////////////////////////////////////////////
function FCAM_GetDevice; external 'FCAM.dll' name 'FCAM_GetDevice';
function FCAM_ReleaseDevice; external 'FCAM.dll' name 'FCAM_ReleaseDevice';
function FCAM_GetDeviceReferenceCount; external 'FCAM.dll' name 'FCAM_GetDeviceReferenceCount';
function FCAM_StartCapture; external 'FCAM.dll' name 'FCAM_StartCapture';
function FCAM_StopCapture; external 'FCAM.dll' name 'FCAM_StopCapture';
function FCAM_SoftWareTrigger; external 'FCAM.dll' name 'FCAM_SoftWareTrigger';
function FCAM_SetParameter; external 'FCAM.dll' name 'FCAM_SetParameter';
function FCAM_GetParameter; external 'FCAM.dll' name 'FCAM_GetParameter';
function FCAM_GetParameterInfo; external 'FCAM.dll' name 'FCAM_GetParameterInfo';

function FCAM_GetOutFrameBuffer; external 'FCAM.dll' name 'FCAM_GetOutFrameBuffer';
function FCAM_PutInFrameBuffer; external 'FCAM.dll' name 'FCAM_PutInFrameBuffer';
function FCAM_SaveCameraConfiguration; external 'FCAM.dll' name 'FCAM_SaveCameraConfiguration';
function FCAM_LoadCameraConfiguration; external 'FCAM.dll' name 'FCAM_LoadCameraConfiguration';
function FCAM_SetStreamCallBackRoutine; external 'FCAM.dll' name 'FCAM_SetStreamCallBackRoutine';
function FCAM_SetMessageNotifyWindow; external 'FCAM.dll' name 'FCAM_SetMessageNotifyWindow';
function FCAM_ReadRegister; external 'FCAM.dll' name 'FCAM_ReadRegister';
function FCAM_WriteRegister; external 'FCAM.dll' name 'FCAM_WriteRegister';
function FCAM_SetDoAutoWHB; external 'FCAM.dll' name 'FCAM_SetDoAutoWHB';
///////////////////////////////////////////////////////////////////////////////
implementation

end.
