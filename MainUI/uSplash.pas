unit uSplash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, PngImage, Tambahan;

type
  TfrmSplash = class(TForm)
    lblStatus: TLabel;
    lblVer: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }

    Scr: TPngObject;

  public
    { Public declarations }
  end;

  procedure DoSplash;
  procedure NoSplash;
  procedure UpdateSplashLabel(Stat: string);

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

//==============================================================================

procedure DoSplash;
begin
  frmSplash:= TfrmSplash.Create(nil);
  frmSplash.Show;
  frmSplash.Update;
end;

procedure NoSplash;
begin
  Sleep(100);
  frmSplash.Close;
  frmSplash.Free;
end;

procedure UpdateSplashLabel(Stat: string);
begin
  frmSplash.lblStatus.Caption:= Stat;
  frmSplash.lblStatus.Update;
end;

//==============================================================================

procedure TfrmSplash.FormCreate(Sender: TObject);
begin

  Scr:= TPngObject.Create;
  Scr.LoadFromResourceName(HInstance, 'SPLASHSCR');
  Self.ClientWidth:= Scr.Width;
  Self.ClientHeight:= Scr.Height;
  Self.Left:= (Screen.WorkAreaWidth - Self.Width) div 2;
  Self.Top:= (Screen.WorkAreaHeight - Self.Height) div 2;
  lblVer.Caption:= Format('Version %s', [GetAppVer]);
  lblVer.Update;
  Self.DoubleBuffered:= TRUE;

end;

//==============================================================================

procedure TfrmSplash.FormDestroy(Sender: TObject);
begin

  Scr.Free;

end;

//==============================================================================

procedure TfrmSplash.FormPaint(Sender: TObject);
begin
  Canvas.Lock;
  try
    Canvas.Draw(0, 0, Scr);
  finally
    Canvas.Unlock;
  end;
end;

//==============================================================================

end.
