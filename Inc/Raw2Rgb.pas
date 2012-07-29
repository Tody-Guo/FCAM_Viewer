//!
//!-----------------------------------------------------------------------------
//!       Name            Raw2Rgb.PAS
//!       Purpose         Raw2Rgb.dll�����������
//!       CopyRight       (c) 2007, �������ϿƼ��������ι�˾
//!       Development Kit Borland Delphi 6.00
//!       Author          ZhaoXingMei
//!       Date            2007/03/12
//!
//!
//!       Description     Ver 1.00.0000 Beta
//!
//!
//!-----------------------------------------------------------------------------
unit Raw2Rgb;

interface
    uses BayerDef;

//Bayer��ʽ����ת��ΪRGB���е�ת���㷨
type BAYER_ARITHMETIC =
(
    ARITH_NEAREST_NEIGHBER          = $10000000,   //���ڽ����ǲ�ֵ�㷨
    ARITH_AVERAGE_NEIGHBER          = $10000001,   //������ƽ����ֵ�㷨
    ARITH_COLOR_CORRELATION         = $10000002,   //ɫ����ز�ֵ�㷨
    ARITH_NEAREST_NEIGHBER_ENHANCE  = $10000003    //���ڽ����ǲ�ֵ��ɫ����ǿ�����㷨
);

//RGB���ݸ�ʽ
RGBTRIPLE  = packed record
    rgbtBlue:  BYTE;         //��ɫ����
    rgbtGreen: BYTE;         //��ɫ����
    rgbtRed:   BYTE;         //��ɫ����
end;

type PRGBTRIPLE = ^RGBTRIPLE;


{*
*����˵��: ��Bayer��ʽ���ݾ���ֵ�㷨����ת��ΪRGB����
*�������:
*          pRgb: ����RGB���ݵĻ�������ַ
*           pRaw: Bayer��ʽ���ݻ�����
*           nWidth: ͼ����
*           nHeight: ͼ��߶�
*           Pattern: Bayer���ݸ�ʽ���μ�BAYER_PATTERN
*           Arithmetic����ֵ�㷨���������㷨��ѡ���μ�BAYER_ARITHMETIC˵����
*�������: ��
*�� �� ֵ���ɹ��򷵻��㷨����ʱ�䣨��λΪ���룩�����򷵻�ֵΪ0��
*}
function
FC_Raw2Rgb(pRgb: PRGBTRIPLE; pRaw: PByte; nWidth: LongWord; nHeight: LongWord;
             Pattern: BAYER_PATTERN; Arithmetic: BAYER_ARITHMETIC): LongWord; stdcall;

{*
*����˵��: ��RGB��ʽ��ͼ�����ݽ���ɫ����ǿ�����������ͼ�����ݽ�����ԭͼ������
*�������:
*          pRgb:     RGB��ʽͼ�����ݵĻ�������ַ
*          dwPixels: ������ͼ������ص���
*�������: ��
*�� �� ֵ���ɹ��򷵻��㷨����ʱ�䣨��λΪ���룩�����򷵻�ֵΪ0��
*}
function FC_ColorEnhance(pRgb: PRGBTRIPLE; dwPixels: LongWord): LongWord; stdcall;

function FC_Raw2Rgb; external 'Raw2Rgb.dll' name 'FC_Raw2Rgb';
function FC_ColorEnhance; external 'Raw2Rgb.dll' name 'FC_ColorEnhance';

implementation
end.
