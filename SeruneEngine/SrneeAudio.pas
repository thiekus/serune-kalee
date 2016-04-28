unit SrneeAudio;

(*==============================================================================

  Serune Kalee audio system module
  Copyright © Revolven Technologies
  Coded by Faris Khowarizmi 2014

==============================================================================*)

interface

{$I SeruneConf.inc}

uses
  Windows, SysUtils, Classes, OpenAL;

type
  // Untuk OpenAL
  TAL3DFloat     = array [0..2] of TALfloat;
  TALOrientFloat = array [0..5] of TALfloat;

  {$IFDEF SKE_USE_DYNLIB}
  procedure _InitSrneeAudio;
  procedure _DeInitSrneeAudio;
  {$ENDIF}
  
  function  Ska_GetEnumDevices: PChar; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function  Ska_GetDeviceOfIndex(Index: integer): PChar; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function  Ska_GetIndexOfDevice(Device: PChar): integer; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}

implementation

var
  EnumsLst: TStringList;

//==============================================================================

function Ska_GetEnumDevices: PChar;
begin

  Result:= @EnumsLst.Text[1];

end;

//==============================================================================

function Ska_GetDeviceOfIndex(Index: integer): PChar;
begin

  Result:= @EnumsLst[Index][1];

end;

//==============================================================================

function Ska_GetIndexOfDevice(Device: PChar): integer;
begin

  Result:= EnumsLst.IndexOf(Device);

end;

//==============================================================================

procedure _InitSrneeAudio;
var
  LoadByOal32: boolean;
  DevLst, DefDev: PALCubyte;
  zfra: LongWord;
begin

  // Inisialisasi OpenAL
  LoadByOal32:= InitOpenAL('OpenAL32.dll');
  if (not LoadByOal32) then
    Assert(InitOpenAL('soft_oal.dll'), 'Gagal menginisialisasi device OpenAL!');

  if LoadByOal32 then
    begin
    // List enumerasi device
    DefDev:= '';
    DevLst:= '';
    if alcIsExtensionPresent(nil, 'ALC_ENUMERATION_EXT') then
      begin
      DefDev:= alcGetString(nil, ALC_DEFAULT_DEVICE_SPECIFIER);
      DevLst:= alcGetString(nil, ALC_DEVICE_SPECIFIER);
    end;
    // Lalu buat stringlistnya
    EnumsLst:= TStringList.Create;
    EnumsLst.Add(string(DevLst));
    for zfra:= 0 to 12 do
      begin
      StrCopy(DevLst, @DevLst[StrLen(PChar(EnumsLst.Text))-(zfra+1)]);
      if (Length(DevLst) <= 0) then
        Break;
      EnumsLst.Add(string(DevLst));
    end;
    EnumsLst.Insert(0, DefDev + ' (Default)');
  end
  else
    begin
    EnumsLst:= TStringList.Create;
    EnumsLst.Add('OpenAL Soft');
  end;

end;

//==============================================================================

procedure _DeInitSrneeAudio;
begin

  if (EnumsLst <> nil) then
    EnumsLst.Free;

end;

//==============================================================================

{$IFNDEF SKE_NO_RTLINIT}
initialization

  _InitSrneeAudio();

finalization

  _DeInitSrneeAudio();

{$ENDIF}

end.
