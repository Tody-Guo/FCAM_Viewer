//!
//!-----------------------------------------------------------------------------
//!       Name            BayerDef.PAS
//!       Purpose         Bayer模板定义
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

unit BayerDef;

interface
//Bayer阵列格式标识
type BAYER_PATTERN =
(
    NOT_BAYER = $00000000,  //非Bayer格式
    BAYER_GB  = $10000000,  //首行为G B G B ...，第二行为R G R G ...
    BAYER_BG  = $10000001,  //首行为B G B G ..., 第二行为G R G R ...
    BAYER_GR  = $10000002,  //首行为G R G R ..., 第二行为B G B G ...
    BAYER_RG  = $10000003   //首行为R G R G ..., 第二行为G B G B ...
);

implementation

end.
