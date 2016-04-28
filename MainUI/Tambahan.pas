unit Tambahan;

interface

uses
  Windows, SysUtils, Graphics, Forms;

  function TickTimeToString(Time: LongWord): string;
  function GetAppVer: string;
  function SwapToBGRA(Warna: TColor): TColor;
  function BlendRGB(const Color1, Color2: TColor; const Blend: Integer): TColor;
  procedure DrawGradient(Color1, Color2: TColor; Canv: TCanvas; RectArea: TRect);
  procedure DisableScalingForm(Form: TForm);

implementation

function TickTimeToString(Time: LongWord): string;
var
  mm, ss, ms, ws: integer;
begin

  mm:= Time div 60000;
  ws:= LongInt(Time) - mm*60000;
  ss:= ws div 1000;
  ms:= ws - ss*1000;
  Result:= Format('%.2d:%.2d:%.3d', [mm, ss, ms]);

end;

function GetAppVer: string;
var
  Major, Minor, Rev, Build: Word;
  VerInfoSize, VerValueSize, Dummy: DWORD;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
begin

  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  GetMem(VerInfo, VerInfoSize);
  try
    GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
    if not VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize) then
      Result := '0.0.0.0'
    else
      with VerValue^ do
        begin
        Major := HiWord(dwFileVersionMS);
        Minor := LoWord(dwFileVersionMS);
        Rev   := HiWord(dwFileVersionLS);
        Build := LoWord(dwFileVersionLS);
        Result := Format('%d.%d.%d.%d', [Major, Minor, Rev, Build]);
      end;
  finally
    FreeMem(VerInfo, VerInfoSize);
  end;

end;

function SwapToBGRA(Warna: TColor): TColor;
begin
  with TRGBQuad(Result)  do
    begin
    rgbBlue:= TRGBQuad(Warna).rgbRed;
    rgbGreen:= TRGBQuad(Warna).rgbGreen;
    rgbRed:= TRGBQuad(Warna).rgbBlue;
    rgbReserved:= TRGBQuad(Warna).rgbReserved;
  end;
end;

function BlendRGB(const Color1, Color2: TColor; const Blend: Integer): TColor;
{ Buat ColorBlend dengan paduan Warna1 dan Warna2 supaya bisa nge-buat form
  ColorBlend. Blend warna harus diantara 0 dan 63; 0 = semua Warna1,
  63 = semua Warna2. }
type
  TColorBytes = array[0..3] of Byte;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to 2 do
    TColorBytes(Result)[I] := Integer(TColorBytes(Color1)[I] +
      ((TColorBytes(Color2)[I] - TColorBytes(Color1)[I]) * Blend) div 63);
end;

procedure DrawGradient(Color1, Color2: TColor; Canv: TCanvas; RectArea: TRect);
var
  Z: integer;
  CS: TPoint;
begin

  for Z := 0 to 63 do
    begin

    Canv:= Canv; //frmMain.Canvas dapat diganti sesuai nama form.
    CS:= RectArea.BottomRight;
    Canv.Pen.Width:= 0;
    Canv.Brush.Style:= bsSolid;
    Canv.Brush.Color:= BlendRGB(ColorToRGB(Color1), ColorToRGB(Color2), Z);
    Canv.Pen.Color:= Canv.Brush.Color;

    Canv.Rectangle(RectArea.Left + MulDiv(CS.X, Z, 63),RectArea.Top, MulDiv(CS.X, Z+1, 63), CS.Y);

  end;

end;

procedure DisableScalingForm(Form: TForm);
begin

  Form.Scaled:= FALSE;
  if (Screen.PixelsPerInch <> Form.PixelsPerInch) then
    Form.ScaleBy(Screen.PixelsPerInch, Form.PixelsPerInch);

end;

end.
