{ *       Name               DrawUtil.bas
' *       Purpose            Declarations of functions in library DrawUtil
' *       Development Kit    Microsoft Win32 SDK Visual basic 6.00
' *       Author             ShanHe
' *       Date               2007/05/23
' *       CopyRight          (c) 2006, �������ϿƼ��������ι�˾
' *
' *       Description        GDI��ͼ��������

' *       ��ǰ�汾��V1.1.0
' *       ��    �ߣ�����÷
' *       ������ڣ�2007��11��2��
' *       �汾�Ķ�: ����FD_StretchDrawImage��FD_DrawActualImage����
' *-----------------------------------------------------------------------------
' * }

unit DrawUtil;

interface
//����ͼƬ���ͱ�ʶ
type FD_FILE_TYPE =
(
   FILE_BITMAP = 0,      //����ΪBitmap���͵�ͼ���ļ�����չ��Ϊbmp
    FILE_JPEG  = 1,      //����ΪJPEG���͵�ͼ���ļ�����չ��Ϊjpg��jpeg
    FILE_RAW   = 2       //����Ϊԭʼ�������͵�ͼ���ļ�����չ��Ϊraw������Photoshop����򿪲鿪
);
//���ھ����ʶ
type  HWND   = LongWord;
//��������λ�ýṹ��
RECT = packed record
    left:   longint;   //�����������Ͻ�x����
    top:    longint;   //�����������Ͻ�y����
    right:  longint;   //�����������½�x����
    bottom: longint;   //�����������½�y����
end;



//!GDI��ͼ��������������GDI��ʽ�ڴ����ϻ�ͼ������������ͼ����ͬһ�����ϻ��ơ�

{
*
*����˵����������ͼ���󣬱���ʹ��FD_ReleaseDraw�ͷŶ���
*���������hDisp����ʾ���ھ��
*          lWidth����ʾ��ͼ��ʵ�ʿ��
*          lHeight����ʾ��ͼ��ʵ�ʸ߶�
*          nBitCnt����ʾͼ��λ�֧��RGB24��ʽλͼ��8λ�Ҷ�ͼ
*          bTopToDown��ͼ�������Ƿ��ǵ�λͼ����λͼ��һ��ɨ�����Ƿ���ͼ�����ݾ�������һ��
*          bDwordAligned��ͼ�����ݿ��Ƿ����ֽڱ߽����
*�����������
*�� �� ֵ��λͼ������������ʧ���򷵻�NULL
*
}
function FD_CreateDraw(hDisp: HWND; nWidth: Integer; nHeight: Integer; nBitCnt: Integer;
                  bTopToDown: Boolean; bDwordAligned: Boolean): THandle; stdcall;

{
*
*����˵�����ͷ��Ѵ����Ļ�ͼ����
*���������hDraw����ͼ������
*�����������
*�� �� ֵ����
*
}
procedure FD_ReleaseDraw(hDraw: Thandle); stdcall;

{
*
*����˵������ָ���Ĵ����ϻ�ͼ����������ʾ�Ŀ�Ȼ�߶�Ϊ0����ԭ��С��ʾ
*���������hDraw����ͼ������
*          pBits��ͼ�����ݻ�������ַ
*          lSize��ͼ�����ݻ�������С
*          nLeft��ͼ���ڴ�����ʾʱ�����Ͻ�����ڴ���ͻ����ĺ�����
*          nTop��ͼ���ڴ�����ʾʱ�����Ͻ�����ڴ���ͻ�����������
*          lPlayWidth��������ʾʱ�Ŀ��
*          lPlayHeight��������ʾʱ�ĸ߶�
*�����������
*�� �� ֵ����
*
}
procedure FD_DrawImage(hDraw: Thandle; pBits: Pointer; nSize: LongWord; nLeft: Integer;
								nTop: Integer; nPlayWidth: LongWord; nPlayHeight: LongWord);stdcall;

{
*����˵������ָ���Ĵ�������ʾָ�������ͼ��
*���������hDraw����ͼ������
*          pBits��ͼ�����ݻ�������ַ
*          lSize��ͼ�����ݻ�������С
*          rcInput��Դͼ�н�ȡ��Ҫ��ʾ���ֵľ�������
*          rcOutput���ڴ�������ʾʱ�����ͼ��ľ�������
*�����������
*�� �� ֵ����
*
}
procedure FD_DrawImageEx(hDraw: Thandle; pBits: Pointer; nSize: LongWord;
                   out rcInput: Rect; out rcOutput: RECT);stdcall;

{
*
*����˵�������浱ǰ֡ͼ�񣬱���ͼ��ΪFD_DrawImage��FD_DrawImageEx������ʾ������ͼ����FD_DrawImage��FD_DrawImageEx�����
*���������
*          hDraw����ͼ������
*          szSaveName�������ͼ����
*          FileType�������ļ����ͣ�FILE_BITMAP������ΪBMPͼ��FILE_JPEG������ΪJPEGͼ��
*                    FILE_RAW������Ϊԭʼ�����ļ���
*�����������
*�� �� ֵ����
*
}
procedure FD_SaveImage(hDraw: THandle; szSaveName: PChar; FileType: FD_FILE_TYPE);stdcall;

{
*
*����˵�����ػ����һ�ε���FD_DrawImageEx��FD_DrawImage����������ͼ��ͼ������������ο��Ը�����Ҫ������
*���������hDraw����ͼ������
*          rcInput��Դͼ�н�ȡ��Ҫ��ʾ���ֵľ�������
*          rcOutput���ڴ�������ʾʱ�����ͼ��ľ�������
*�����������
*�� �� ֵ����
*
}
procedure FD_RedrawImage(hDraw: THandle; out rcInput: RECT; out rcOutput: RECT);stdcall;

{*
'*����˵������ָ���Ĵ��ڻ�ͼ���ú�����������, �ֲ���ʾ����Ч�ʸ���FD_DrawImage��FD_DrawImageEx������
'*���������
'*hDraw��    ��ͼ��������
'*pBits��    ͼ�����ݻ�������ַ��
'*nSize��    ͼ�����ݻ�������С��
'*rtSorRect��Դͼ���������
'*rtDesRect����ʾ����������Դͼ�������������ʾ���������С��һ�£����Զ�������ʾ��
'*��������� ��
'}
procedure FD_StretchDrawImage(hDraw: THandle; pBits: Pointer; nSize: Longword; rcInput: RECT; rcOutput: RECT);stdcall;


{*����˵������ָ���Ĵ��ڻ�ͼ���ú�����֧�����ţ���Ч�ʸߣ�CPUռ����С
'*���������
'*hDraw��    ��ͼ��������
'*pBits��    ͼ�����ݻ�������ַ��
'*nSize��    ͼ�����ݻ�������С��
'*nLeft��    ͼ���ڴ�����ʾʱ�����Ͻ�����ڴ���ͻ����ĺ�����
'*nTop��     ͼ���ڴ�����ʾʱ�����Ͻ�����ڴ���ͻ�����������
'*��������� ��
'}
procedure FD_DrawActualImage(hDraw: THandle; pBits: Pointer; nSize: Longword; nLeft: Longint; nTop: Longint);stdcall;


function FD_CreateDraw; external 'DrawUtil.dll' name 'FD_CreateDraw';
procedure FD_ReleaseDraw; external 'DrawUtil.dll' name 'FD_ReleaseDraw';
procedure FD_DrawImage; external 'DrawUtil.dll' name 'FD_DrawImage';
procedure FD_DrawImageEx; external 'DrawUtil.dll' name 'FD_DrawImageEx';
procedure FD_SaveImage; external 'DrawUtil.dll' name 'FD_SaveImage';
procedure FD_RedrawImage; external 'DrawUtil.dll' name 'FD_RedrawImage';
procedure FD_StretchDrawImage; external 'DrawUtil.dll' name 'FD_StretchDrawImage';
procedure FD_DrawActualImage; external 'DrawUtil.dll' name 'FD_DrawActualImage';

implementation

end.
