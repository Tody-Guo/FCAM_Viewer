{FCAM unit
//*
//* Copyright (c) 2006, �������ϿƼ��������ι�˾
//* All rights reserved.
//*
//* �ļ����ƣ�FCAM.h
//* �ļ���ʶ��FCAM.h
//* ժ    Ҫ��FCAM.dll�����������
//*
//* ����������Microsoft Win32 SDK, Visual C++ 6.00
//*
//* ��ǰ�汾��V2.1.0
//* ��    �ߣ�����÷
//* ������ڣ�
//* ����汾��V2.0.0
//* ��    �ߣ�����÷
//* ������ڣ�
//*
//* ˵��: �����˶�130���ɫ������Զ���ƽ�⺯��
          �����������������
//* }


unit FCAM;

interface

uses FCAM_Def;

{*
*����˵��: ���ָ�����кź�������͵���������
*�������: uDeviceIndex:  ������кţ���1��ʼ��
           CameraType:    �������,��FCAM_Def.h�ļ���FCAM_CAMERA_TYPE���Ͷ��塣
*�������: �ޡ�
*�� �� ֵ: �ɹ����ش����������豸��������򷵻�NULL��
*}
function FCAM_GetDevice(uDeviceIndex: Longword; CameraType: FCAM_CAMERA_TYPE): THandle; stdcall;

{*
*����˵��: �ͷŻ�ȡ���豸�����
*�������: hDev:  ���ͷŵ��豸�����
*�������: �ޡ� 
*�� �� ֵ: �ɹ�����FCAM_SUCCESS�����򷵻���Ӧ�Ĵ�����롣

ע: FCAM_GetDevice������FCAM_ReleaseDevice���ʹ�ã���ʹ��n��FCAM_GetDevice��
    ��Ӧ��Ҫ����n��FCAM_ReleaseDevice������������ȷ�ͷ��豸�����
*}
function FCAM_ReleaseDevice(hDev: THandle): HRESULT; stdcall;

{*
*����˵��: ����豸��������ü�����������FCAM_GetDevice�ɹ��Ĵ���������������ü�
           ���ε�FCAM_ReleaseDevice�������������豸����

*�������: hDev:   �ѻ�ȡ���豸�����
*�������: �ޡ� 
*�� �� ֵ: �����豸��������ü�����
*}
function FCAM_GetDeviceReferenceCount(hDev: THandle): HRESULT; stdcall;

{*
*����˵��: ����������ݴ�������
*�������: hDev: ��ȡ���豸���
*�������: ��
*����ֵ:   �ɹ�����FCAM_SUCCESS,���򷵻���Ӧ�Ĵ������
*}
function FCAM_StartCapture(hDev: THandle): HRESULT; stdcall;

{*
*����˵��: ȡ��(ֹͣ)��������ݴ���
*�������: hDev: ��ȡ���豸���
*�������: ��
*����ֵ:   �ɹ�����FCAM_SUCCESS,���򷵻���Ӧ�Ĵ������
*}
function FCAM_StopCapture(hDev: THandle): HRESULT; stdcall;

{*
*����˵��: ������������Ͳ����ĵ�ǰֵ
*�������: hDev:          ��ȡ���豸���
*          uType:         FCAM_GSP_PARAME_TYPEö�����ͣ����FCAM_Def.h�ļ�
*          pParamStruct:  uType����Ӧ�Ľṹ��ָ�룬�����洢���õĲ���ֵ
*�������: ��
*����ֵ:   �ɹ�����FCAM_SUCCESS,���򷵻���Ӧ�Ĵ������
*}
function FCAM_SetParameter(hDev: THandle; uType: FCAM_GSP_PARAME_TYPE; pParamStruct: pointer): HRESULT; stdcall;

{*
*����˵��: ��ȡ��������Ͳ����ĵ�ǰֵ
*�������: hDev:          ��ȡ���豸���
*          uType:         FCAM_GSP_PARAME_TYPEö�����ͣ����FCAM_Def.h�ļ�
*          pParamStruct:  uType����Ӧ�Ľṹ��ָ�룬�����洢��ȡ���Ĳ����ĵ�ǰֵ
*�������: ��
*����ֵ:   �ɹ�����FCAM_SUCCESS,���򷵻���Ӧ�Ĵ������
*}
function FCAM_GetParameter(hDev: THandle; uType: FCAM_GSP_PARAME_TYPE; pParamStruct: pointer): HRESULT; stdcall;

{*
*����˵��: ��ȡ�������������Ϣ
*�������: hDev:               ��ȡ���豸���
*          uType:              FCAM_PARAMINFO_TYPE��Ϣ�������ͣ���FCAM_Def.h�ļ�
*          pParamInfoStruct:   uType����Ӧ�Ĵ洢������Ϣ�Ľṹ��ָ��
*�������: ��
*����ֵ:   �ɹ�����FCAM_SUCCESS,���򷵻���Ӧ�Ĵ������ 
*}
function FCAM_GetParameterInfo(hDev: THandle; uType: FCAM_PARAMINFO_TYPE; pParamInfoStruct: Pointer): HRESULT; stdcall;
//////////////////////////////////////////////////////////////////////////
//���ݻ�ȡ
{*
*����˵��: ��ȡһ��ͼ�����ݻ�����ָ�룬������FCAM_PutInFrameBuffer�ɶ�ʹ��
*�������: hDev:              ��ȡ���豸�����
           pBuffer:           �洢ͼ������ָ��Ļ�������ַ��
           pulBufferSizes:    �洢buffer��С�Ļ�������ַ,��С���ֽ�Ϊ��λ��
           dwWaitMillTime:    ��ȡ�����ĵȴ�ʱ�䡣
*�������: ��
*����ֵ:   �ɹ�����FCAM_SUCCESS,���򷵻���Ӧ�Ĵ������ 
*}
function FCAM_GetOutFrameBuffer(hDev: THandle; out pBuffer: Pointer; out ulBufferSizes: Longword; dwWaitMillTime: Longword): HRESULT; stdcall;

{*
*����˵��: �黹��ȡ��ͼ�����ݻ�����ָ��
*�������: hDev:         ��ȡ���豸���
*          pBuffer:      ��ȡ��ͼ������ָ��
*�������: ��
*����ֵ:   �ɹ�����FCAM_SUCCESS,���򷵻���Ӧ�Ĵ������ 
*}
function FCAM_PutInFrameBuffer(hDev:THandle; pBuffer: Pointer): HRESULT; stdcall;
/////////////////////////////////////////////////////////////////////////////////////////////////
//�������
{*
*����˵������ǰ�豸״̬Ϊ�������ʱ����һ����������źţ�����ӵ��źź�ʼ�ع⣬һ֡ͼ���ع���Ϻ�
*		   ֹͣ�ع⣬�ȴ���һ�������źš���
*���������hDev����ȡ���豸���
*����������ޡ�
*�� �� ֵ�������ɹ��򷵻�FCAM_SUCCESS������Ϊ��Ӧ�Ĵ����롣
*}
function FCAM_SoftWareTrigger(hDev: THandle): HRESULT; stdcall;
/////////////////////////////////////////////////////////////////////////////////////////////////
//�������
{*
*����˵��: ���浱ǰ��������õ�ָ���ļ�
*�������: hDev:          ��ȡ���豸���
		   pFileName:     ָ���ļ���
*�������: ��
*����ֵ:   �ɹ�����FCAM_SUCCESS,���򷵻���Ӧ�Ĵ������
*}
function FCAM_SaveCameraConfiguration(hDev: THandle;  pFileName: pchar): HRESULT; stdcall;

{*
*����˵��: ��ָ���ļ��ж�ȡ�����������Ϣ�����ص�����У�����ǰ�����ѽ�������ֹͣ������ٵ��øú���
*�������: hDev:          ��ȡ���豸���
		   pFileName:     ָ���ļ���
*�������: ��
*����ֵ:   �ɹ�����FCAM_SUCCESS,���򷵻���Ӧ�Ĵ������
*}
function FCAM_LoadCameraConfiguration(hDev: THandle;  pFileName: pchar): HRESULT; stdcall;

//////////////////////////////////////////////////////////////////////////
//�Ĵ�����д
{*
*����˵��: ָ����ַ�Ĵ�����
*�������: hDev:          ��ȡ���豸���
		   ucRegAddr:     �Ĵ�����ַ
		   ucValue:       ��ȡ��ȡ�������ݵ����飬4�ֽ�
*�������: ��
*����ֵ:   �ɹ�����FCAM_SUCCESS,���򷵻���Ӧ�Ĵ������
*}
function FCAM_ReadRegister(hDev:Thandle; ucRegAddr: Array of Byte; ucValue: Array of Byte): HRESULT; stdcall;

{*
*����˵��: ָ����ַ�Ĵ���д
*�������: hDev:          ��ȡ���豸���
		   ucRegAddr:     �Ĵ�����ַ
		   ucValue:       ��ȡд������ݵ����飬4�ֽ�
*�������: ��
*����ֵ:   �ɹ�����FCAM_SUCCESS,���򷵻���Ӧ�Ĵ������
*}
function FCAM_WriteRegister(hDev:Thandle; ucRegAddr: Array of Byte; ucValue: Array of Byte): HRESULT; stdcall;

//////////////////////////////////////////////////////////////////////////
//�豸�¼�����
{*
*����˵��: ����������Ļص��������ú�����ÿ����һ�����ݻ������󣬸ú���������һ��
*�������: hDev:         ��ȡ���豸���
           pCallBack:    �ص����̺�����ַ
           pUserParam:   �û��Զ���ṹ��ָ��, ���FCAM_Def.h�ļ�
*����ֵ:   �ɹ�����FCAM_SUCCESS,���򷵻���Ӧ�Ĵ������
*}
function FCAM_SetStreamCallBackRoutine(hDev:THandle; pCallBack:PFCAM_CALLBACK; pUserParam:Pointer): HRESULT; stdcall;

{*
*����˵��: ������������¼�֪ͨ���ھ��, ��ÿ������һ��buffer���ô��ڽ����յ�WM_FCAM_MESSAGE���͵���Ϣ
           ��Ϣ���FCAM_Def.h�ļ�
*�������: hDev:         ��ȡ���豸���
           hMsgWnd:      ��Ϣ���մ��ھ��
		   pUserParam:   �û��Զ���ṹ��ָ��, ���FCAM_Def.h�ļ�
*����ֵ:   �ɹ�����FCAM_SUCCESS,���򷵻���Ӧ�Ĵ������
*}
function FCAM_SetMessageNotifyWindow(hDev:THandle; hMsgWnd:HWND; pUserParam:Pointer): HRESULT; stdcall;

//����Զ����ڣ�Ŀǰֻ���FUNCTION-TECH��130�����ز�ɫ���
{*
*����˵��: ����������Զ���ƽ����ڣ���������Ϊͼ����������480*360, ��ͼ���С���㣬��ȫͼ����
*�������: hDev:               ��ȡ���豸���
           pAutoCallBack:      �ص����������Զ���ƽ�������Ϻ󣬸ú���������
		       pAutoContext:       �û��������pAutoCallBack�������õ�������ָ��
*����ֵ:   �ɹ�����FCAM_SUCCESS,���򷵻���Ӧ�Ĵ������
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
