//!
//!-----------------------------------------------------------------------------
//!       Name            BayerDef.PAS
//!       Purpose         Bayerģ�嶨��
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

unit BayerDef;

interface
//Bayer���и�ʽ��ʶ
type BAYER_PATTERN =
(
    NOT_BAYER = $00000000,  //��Bayer��ʽ
    BAYER_GB  = $10000000,  //����ΪG B G B ...���ڶ���ΪR G R G ...
    BAYER_BG  = $10000001,  //����ΪB G B G ..., �ڶ���ΪG R G R ...
    BAYER_GR  = $10000002,  //����ΪG R G R ..., �ڶ���ΪB G B G ...
    BAYER_RG  = $10000003   //����ΪR G R G ..., �ڶ���ΪG B G B ...
);

implementation

end.
