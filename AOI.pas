unit AOI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TAOIForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit_Left: TEdit;
    Edit_Top: TEdit;
    Edit_Width: TEdit;
    Edit_Height: TEdit;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AOIForm: TAOIForm;

implementation

{$R *.dfm}

end.
