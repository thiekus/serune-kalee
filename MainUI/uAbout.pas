unit uAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Tambahan;

type
  TfrmAbout = class(TForm)
    mmAbout: TMemo;
    Shape1: TShape;
    Label2: TLabel;
    Shape2: TShape;
    Bevel1: TBevel;
    Button1: TButton;
    Label3: TLabel;
    Image1: TImage;
    lblVer: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

procedure TfrmAbout.FormShow(Sender: TObject);
var
  Rs: TResourceStream;
begin

  lblVer.Caption:= Format('Version %s', [GetAppVer]);
  Rs:= TResourceStream.Create(HInstance, 'ABOUTTXT', RT_RCDATA);
  try
    mmAbout.Clear;
    mmAbout.Lines.LoadFromStream(Rs);
  finally
    Rs.Free;
  end;

end;

end.
