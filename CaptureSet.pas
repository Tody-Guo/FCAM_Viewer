unit CaptureSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, ExtCtrls;

type
  TCapSet = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Button2: TButton;
    Button3: TButton;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    TimerEditTime: TEdit;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CapSet: TCapSet;

implementation

{$R *.dfm}

procedure TCapSet.Button1Click(Sender: TObject);
var
  strDir: String;
begin
  if SelectDirectory('选择要保存的目录位置', '', strDir) then
    Edit1.Text := strDir;

end;


end.
