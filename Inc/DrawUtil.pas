{ *       Name               DrawUtil.bas
' *       Purpose            Declarations of functions in library DrawUtil
' *       Development Kit    Microsoft Win32 SDK Visual basic 6.00
' *       Author             ShanHe
' *       Date               2007/05/23
' *       CopyRight          (c) 2006, 西安方诚科技有限责任公司
' *
' *       Description        GDI绘图函数声明

' *       当前版本：V1.1.0
' *       作    者：赵星梅
' *       完成日期：2007年11月2日
' *       版本改动: 增加FD_StretchDrawImage、FD_DrawActualImage函数
' *-----------------------------------------------------------------------------
' * }

unit DrawUtil;

interface
//保存图片类型标识
type FD_FILE_TYPE =
(
   FILE_BITMAP = 0,      //保存为Bitmap类型的图像文件，扩展名为bmp
    FILE_JPEG  = 1,      //保存为JPEG类型的图像文件，扩展名为jpg或jpeg
    FILE_RAW   = 2       //保存为原始数据类型的图像文件，扩展名为raw，可用Photoshop软件打开查开
);
//窗口句柄标识
type  HWND   = LongWord;
//矩形区域位置结构体
RECT = packed record
    left:   longint;   //矩形区域左上角x坐标
    top:    longint;   //矩形区域左上角y坐标
    right:  longint;   //矩形区域右下角x坐标
    bottom: longint;   //矩形区域右下角y坐标
end;



//!GDI绘图函数，此组数用GDI方式在窗体上绘图，适用于续列图像在同一窗体上绘制。

{
*
*函数说明：创建绘图对象，必须使用FD_ReleaseDraw释放对象
*输入参数：hDisp：显示窗口句柄
*          lWidth：显示的图像实际宽度
*          lHeight：显示的图像实际高度
*          nBitCnt：显示图像位深，支持RGB24格式位图和8位灰度图
*          bTopToDown：图像数据是否是倒位图，即位图第一个扫描行是否在图像数据矩阵的最后一行
*          bDwordAligned：图像数据块是否四字节边界对齐
*输出参数：无
*返 回 值：位图对象句柄，创建失败则返回NULL
*
}
function FD_CreateDraw(hDisp: HWND; nWidth: Integer; nHeight: Integer; nBitCnt: Integer;
                  bTopToDown: Boolean; bDwordAligned: Boolean): THandle; stdcall;

{
*
*函数说明：释放已创建的绘图对象
*输入参数：hDraw：绘图对象句柄
*输出参数：无
*返 回 值：无
*
}
procedure FD_ReleaseDraw(hDraw: Thandle); stdcall;

{
*
*函数说明：在指定的窗体上绘图。若拉伸显示的宽度或高度为0，则按原大小显示
*输入参数：hDraw：绘图对象句柄
*          pBits：图像数据缓冲区地址
*          lSize：图像数据缓冲区大小
*          nLeft：图像在窗体显示时，左上角相对于窗体客户区的横坐标
*          nTop：图像在窗体显示时，左上角相对于窗体客户区的纵坐标
*          lPlayWidth：拉伸显示时的宽度
*          lPlayHeight：拉伸显示时的高度
*输出参数：无
*返 回 值：无
*
}
procedure FD_DrawImage(hDraw: Thandle; pBits: Pointer; nSize: LongWord; nLeft: Integer;
								nTop: Integer; nPlayWidth: LongWord; nPlayHeight: LongWord);stdcall;

{
*函数说明：在指定的窗体上显示指定区域的图像。
*输入参数：hDraw：绘图对象句柄
*          pBits：图像数据缓冲区地址
*          lSize：图像数据缓冲区大小
*          rcInput：源图中截取的要显示部分的矩形区域
*          rcOutput：在窗体中显示时的输出图像的矩形区域
*输出参数：无
*返 回 值：无
*
}
procedure FD_DrawImageEx(hDraw: Thandle; pBits: Pointer; nSize: LongWord;
                   out rcInput: Rect; out rcOutput: RECT);stdcall;

{
*
*函数说明：保存当前帧图像，保存图像为FD_DrawImage或FD_DrawImageEx函数显示的整幅图像，在FD_DrawImage或FD_DrawImageEx后调用
*输入参数：
*          hDraw：绘图对象句柄
*          szSaveName：保存的图像名
*          FileType：保存文件类型，FILE_BITMAP：保存为BMP图，FILE_JPEG：保存为JPEG图，
*                    FILE_RAW：保存为原始数据文件。
*输出参数：无
*返 回 值：无
*
}
procedure FD_SaveImage(hDraw: THandle; szSaveName: PChar; FileType: FD_FILE_TYPE);stdcall;

{
*
*函数说明：重画最近一次调用FD_DrawImageEx或FD_DrawImage函数所画的图像，图像输入输出矩形可以根据需要调整。
*输入参数：hDraw：绘图对象句柄
*          rcInput：源图中截取的要显示部分的矩形区域
*          rcOutput：在窗体中显示时的输出图像的矩形区域
*输出参数：无
*返 回 值：无
*
}
procedure FD_RedrawImage(hDraw: THandle; out rcInput: RECT; out rcOutput: RECT);stdcall;

{*
'*函数说明：在指定的窗口绘图，该函数可以缩放, 局部显示，且效率高于FD_DrawImage和FD_DrawImageEx函数。
'*输入参数：
'*hDraw：    绘图对象句柄。
'*pBits：    图像数据缓冲区地址。
'*nSize：    图像数据缓冲区大小。
'*rtSorRect：源图像矩形区域。
'*rtDesRect：显示矩形区域。若源图像矩形区域与显示矩形区域大小不一致，则自动缩放显示。
'*输出参数： 无
'}
procedure FD_StretchDrawImage(hDraw: THandle; pBits: Pointer; nSize: Longword; rcInput: RECT; rcOutput: RECT);stdcall;


{*函数说明：在指定的窗口绘图，该函数不支持缩放，但效率高，CPU占用率小
'*输入参数：
'*hDraw：    绘图对象句柄。
'*pBits：    图像数据缓冲区地址。
'*nSize：    图像数据缓冲区大小。
'*nLeft：    图像在窗体显示时，左上角相对于窗体客户区的横坐标
'*nTop：     图像在窗体显示时，左上角相对于窗体客户区的纵坐标
'*输出参数： 无
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
