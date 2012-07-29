//!
//!-----------------------------------------------------------------------------
//!       Name            Raw2Rgb.PAS
//!       Purpose         Raw2Rgb.dll输出函数声明
//!       CopyRight       (c) 2007, 西安方诚科技有限责任公司
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

//Bayer格式阵列转换为RGB阵列的转换算法
type BAYER_ARITHMETIC =
(
    ARITH_NEAREST_NEIGHBER          = $10000000,   //最邻近三角插值算法
    ARITH_AVERAGE_NEIGHBER          = $10000001,   //四邻域平均插值算法
    ARITH_COLOR_CORRELATION         = $10000002,   //色彩相关插值算法
    ARITH_NEAREST_NEIGHBER_ENHANCE  = $10000003    //最邻近三角插值与色彩增强联合算法
);

//RGB数据格式
RGBTRIPLE  = packed record
    rgbtBlue:  BYTE;         //蓝色分量
    rgbtGreen: BYTE;         //绿色分量
    rgbtRed:   BYTE;         //红色分量
end;

type PRGBTRIPLE = ^RGBTRIPLE;


{*
*函数说明: 将Bayer格式数据经插值算法处理转换为RGB数据
*输入参数:
*          pRgb: 接收RGB数据的缓冲区地址
*           pRaw: Bayer格式数据缓冲区
*           nWidth: 图像宽度
*           nHeight: 图像高度
*           Pattern: Bayer数据格式，参见BAYER_PATTERN
*           Arithmetic：插值算法，有三种算法可选。参见BAYER_ARITHMETIC说明。
*输出参数: 无
*返 回 值：成功则返回算法处理时间（单位为毫秒），否则返回值为0。
*}
function
FC_Raw2Rgb(pRgb: PRGBTRIPLE; pRaw: PByte; nWidth: LongWord; nHeight: LongWord;
             Pattern: BAYER_PATTERN; Arithmetic: BAYER_ARITHMETIC): LongWord; stdcall;

{*
*函数说明: 对RGB格式的图像数据进行色彩增强处理，处理过的图像数据将覆盖原图像数据
*输入参数:
*          pRgb:     RGB格式图像数据的缓冲区地址
*          dwPixels: 待处理图像的象素点数
*输出参数: 无
*返 回 值：成功则返回算法处理时间（单位为毫秒），否则返回值为0。
*}
function FC_ColorEnhance(pRgb: PRGBTRIPLE; dwPixels: LongWord): LongWord; stdcall;

function FC_Raw2Rgb; external 'Raw2Rgb.dll' name 'FC_Raw2Rgb';
function FC_ColorEnhance; external 'Raw2Rgb.dll' name 'FC_ColorEnhance';

implementation
end.
