program MainProject;

uses
  Forms,
  MainViewer in 'MainViewer.pas' {Form1},
  DrawUtil in 'Inc\DrawUtil.pas',
  FCAM in 'Inc\FCAM.pas',
  FCAM_Def in 'Inc\FCAM_Def.pas',
  BayerDef in 'Inc\BayerDef.pas',
  Raw2Rgb in 'Inc\Raw2Rgb.pas',
  AOI in 'AOI.pas' {AOIForm},
  Adjust in 'Adjust.pas' {AdjustForm},
  CaptureSet in 'CaptureSet.pas' {CapSet};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAOIForm, AOIForm);
  Application.CreateForm(TAdjustForm, AdjustForm);
  Application.CreateForm(TCapSet, CapSet);
  Application.Run;
end.
