unit SrneeCore;

(*==============================================================================

  Serune Kalee core player unit
  Copyright © Revolven Technologies
  Coded by Faris Khowarizmi 2014

==============================================================================*)

interface

{$I SeruneConf.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

uses
  Windows, SysUtils, MMSystem, ActiveX, DirectInput, OpenAL,
  // Serune Kalee Modules
  SrneeConst, SrneeTypes, SrneeInput, SrneeAudio, SrneeFile, SrneeMsg;

const
  LubangSerune = 7;    // Tidak termasuk lubang bawah
  StringBufSz = $7FFF; // Default size  of string buffer

type

  TSrNote = array[0..LubangSerune] of ByteBool;
  PSrNote = ^TSrNote;

  TSrInfo = packed record

    SoundBankPath : PChar;

    FocusHandle   : THandle;
    DeviceIndex   : LongInt;
    DirectMode    : ByteBool;
    Mulai         : ByteBool;

    PlayMode      : TSrPlayMode;
    PlayVolume    : Single;
    PlayTimeCur   : LongWord;
    PlayTimeMax   : LongWord;

    InstData      : PSrInstrument;
    InstSaved     : ByteBool;

    ChangeMode    : ByteBool;
    ChangeInstDlg : TSrChangeInstDialog;
    ParamFilePath : PChar;
    ParamPathSize : LongWord;
    EventCallback : TSrPlayEventCallback;
    IsInCallback  : ByteBool;
    Keluar        : ByteBool;

    UseDevInput   : ByteBool;
    KbdButton     : array[0..LubangSerune] of Byte;
    KbdButtonCmb  : array[0..LubangSerune-1] of Byte;
    KbdButtonBlow : Byte;
    UseCombKey    : ByteBool;

    GameCtrlGUID  : TGUID;
    UseGameCtrl   : ByteBool;
    GCtButton     : array[0..LubangSerune] of Byte;
    GCtButtonBlow : Byte;

    NoteToggle    : TSrNote;
    BlowToggle    : ByteBool;
    SBankLoaded   : LongInt;

    ThreadCs      : TRTLCriticalSection;
    ThreadHandle  : THandle;
    ThreadID      : LongWord;

  end;
  PSrInfo = ^TSrInfo;

  procedure Skp_ToggleNoteState(Info: PSrInfo; NoteIndex: integer; Pressed: boolean); {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  procedure Skp_ToggleBlowState(Info: PSrInfo; Pressed: boolean); {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function  Skp_LiveRecord(Info: PSrInfo): boolean; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function  Skp_PlayPausePlayback(Info: PSrInfo): boolean; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function  Skp_StopPlayback(Info: PSrInfo): boolean; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function  Skp_OpenInstrumentFile(Info: PSrInfo; Path: PChar): boolean; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function  Skp_SaveInstrumentFile(Info: PSrInfo; Path: PChar): boolean; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function  Skp_InstrumentLoaded(Info: PSrInfo): boolean; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function  Skp_GetKeyboardKey(Info: PSrInfo; Action, SubAction: byte): byte; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  procedure Skp_SetKeyboardKey(Info: PSrInfo; Action, SubAction: byte; Button: byte); {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function  Skp_GetGameCtrlKey(Info: PSrInfo; Action, SubAction: byte): byte; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  procedure Skp_SetGameCtrlKey(Info: PSrInfo; Action, SubAction: byte; Button: byte); {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function  Skp_GetPlayerProperty(Info: PSrInfo; Prop: LongWord): LongInt; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  procedure Skp_SetPlayerProperty(Info: PSrInfo; Prop: LongWord; Val: LongInt); {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  procedure Skp_SetPlayerEventCallback(Info: PSrInfo; CallProc: TSrPlayEventCallback); {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function  Skp_SetupPlayer(var Info: PSrInfo; MainHandle: THandle;
                            DeviceIndex: integer; SoundBankPath: PChar;
                            LoadCallback: TSrSoundBankLoadCallback = nil): boolean; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function  Skp_ExitPlayer(var Info: PSrInfo): boolean; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}

implementation

//==============================================================================

function GetIndexOfKey(Note: PSrNote): Byte;
var
  tmp: Byte;
  l: integer;
begin

  tmp:= 0;
  for l:= 0 to LubangSerune do
    tmp:= tmp or ((Byte(Note^[l]) and 1) shl (LubangSerune-l));
  Result:= tmp;

end;

//==============================================================================

function GetNameOfEvent(Event: TSrPlayEvent): string;
begin

  case Event of
    peLiveBegin:     Result:= 'LiveBegin';
    peRecordBegin:   Result:= 'RecordBegin';
    pePauseBegin:    Result:= 'PauseBegin';
    pePlaybackBegin: Result:= 'PlaybackBegin';
    peLiveEnd:       Result:= 'LiveEnd';
    peRecordEnd:     Result:= 'RecordEnd';
    pePauseEnd:      Result:= 'PauseEnd';
    pePlaybackEnd:   Result:= 'PlaybackEnd';
    peLoaded:        Result:= 'Loaded';
    peSaved:         Result:= 'Saved';
    peNotesUpdate:   Result:= 'NotesUpdate';
    peExitThread:    Result:= 'ExitThread';
  else
    Result:= '<Undefined>';
  end;

end;

//==============================================================================

function SrThreadPool(Info: PSrInfo): Integer;

  procedure PanggilEventCallback(Event: TSrPlayEvent; Param: Pointer = nil);
  begin
    if (@Info^.EventCallback <> nil) then
      begin
      EnterCriticalSection(Info^.ThreadCs);
      Info^.IsInCallback:= TRUE;
      try
        try
          TSrPlayEventCallback(Info^.EventCallback)(Event, Param);
        except
          on E: Exception do
            begin
            MessageBox(Info^.FocusHandle,
                       PChar(Format(s_SrCbackError,
                                    [GetNameOfEvent(Event), E.Message])),
                       PChar(SrneeModuleName), MB_ICONERROR + MB_TOPMOST);
          end;
        end;
      finally
        Info^.IsInCallback:= FALSE;
        LeaveCriticalSection(Info^.ThreadCs);
      end;
    end;
  end;

//=== Variabel pool thread =====================================================
const

  NullGUIDStr = '{00000000-0000-0000-0000-000000000000}';
  NullGUID: TGUID = '{00000000-0000-0000-0000-000000000000}';

var

  // Untuk properti OpenAL
  OalCtx: PALCcontext;
  OalDev: PALCdevice;
  SBuf: TALuint;
  SndSource: TALuint;
  SndSrcPosition: TAL3DFloat;
  SndSrcVelocity: TAL3DFloat;
  SndLstPosition: TAL3DFloat;
  SndLstVelocity: TAL3DFloat;
  SndLstOrientation: TALOrientFloat;
  SVol: TALfloat;

  // Untuk list soundbank
  SBank: PSrSoundBank;

  // Properti DirectInput
  KInpIntfc: IDirectInputDevice8;
  KBuf: TKeyboardBuffer;
  KbLost: boolean;
  GInpIntfc: IDirectInputDevice8;
  GBuf: TDIJoyState2;
  GCLost: boolean;
  GCGUIDStr: string;
  OldGCGUID: string;

  // Dan lain2...
  {$IFDEF WIN64}
  PackedNote: Int64;
  {$ELSE}
  PackedNote: LongInt;
  {$ENDIF}
  PtrNote: PSkpNoteInfo;
  Kunci: TSrNote;
  Ditiup: boolean;
  KeluarSuara: boolean;
  KeyState: Byte;
  OldHoleState: Byte;
  OldBlowState: boolean;
  OldPlayMode: TSrPlayMode;
  NadaBaru: boolean;
  DapatKey: boolean;
  KombKey: boolean;

  // Instrumen
  InstCIdx: LongWord;
  InstMIdx: LongWord;
  InstTimeBegin, InstTimeCur: LongWord;
  InstPauseBegin, InstPauseEnd: LongWord;
  InstPath: string;

  // loop only
  l: integer;

  procedure SesiBaru;
  begin
    ZeroMemory(@Kunci, SizeOf(TSrNote));
    Ditiup:= FALSE;
    KeluarSuara:= FALSE;
    KeyState:= 0;
    InstCIdx:= 0;
    InstMIdx:= 0;
    Info^.PlayTimeCur:= 0;
    Info^.PlayTimeMax:= 0;
  end;

begin

  // Inisialisasi thread
  Info^.Mulai:= FALSE;
  Result:= -1;

  try

    // Set presisi timer ke 1 ms
    timeBeginPeriod(1);

    // Inisialisasi Alut
    if Info^.DeviceIndex = 0 then
      OalDev:= alcOpenDevice(nil)
    else
      OalDev:= alcOpenDevice(PChar(Ska_GetDeviceOfIndex(Info^.DeviceIndex)));
    OalCtx:= alcCreateContext(OalDev, nil);
    alcMakeContextCurrent(OalCtx);
    alGetError();

    // Load SoundBank
    SBank:= Skf_LoadSoundBank(Info^.SoundBankPath, @Info^.SBankLoaded);
    // Buat Buffer
    AlGenBuffers(1, @SBuf);
    Skf_LoadSoundBankToBuffer(SBuf, SBank, 0); //test

    // Buat sumber suara
    AlGenSources(1, @SndSource);
    AlSourcei(SndSource, AL_BUFFER, SBuf);
    AlSourcef(SndSource, AL_PITCH, 1.0);
    AlSourcef(SndSource, AL_GAIN, 1.0);

    SndSrcPosition[0]:= 0.0;
    SndSrcPosition[1]:= 0.0;
    SndSrcPosition[2]:= 0.0;
    AlSourcefv(SndSource, AL_POSITION, @SndSrcPosition);

    SndSrcPosition[0]:= 0.0;
    SndSrcPosition[1]:= 0.0;
    SndSrcPosition[2]:= 0.0;
    AlSourcefv(SndSource, AL_VELOCITY, @SndSrcVelocity);
    AlSourcei(SndSource, AL_LOOPING, TALint(TRUE));

    // Dan lokasi pendengar
    SndLstPosition[0]:= 0.0;
    SndLstPosition[1]:= 0.0;
    SndLstPosition[2]:= 0.0;
    AlListenerfv(AL_POSITION, @SndLstPosition);

    SndLstVelocity[0]:= 0.0;
    SndLstVelocity[1]:= 0.0;
    SndLstVelocity[2]:= 0.0;
    AlListenerfv(AL_VELOCITY, @SndLstVelocity);

    SndLstOrientation[0]:= 0.0;
    SndLstOrientation[1]:= 0.0;
    SndLstOrientation[2]:= -1.0;
    SndLstOrientation[3]:= 0.0;
    SndLstOrientation[4]:= 1.0;
    SndLstOrientation[5]:= 0.0;
    AlListenerfv(AL_ORIENTATION, @SndLstOrientation);

    try

      // Setup input keyboard
      Assert(Ski_SetupInput(KInpIntfc, itKeybd, NullGUID, Info^.FocusHandle),
             'Tidak dapat menginisialisasi keyboard!');

      // Settingan sebelum bagian utama
      SesiBaru;
      OldHoleState:= 0;
      OldBlowState:= FALSE;
      OldPlayMode:= pmNothing;

      SVol:= 1.0;
      Info^.PlayVolume:= SVol;
      Info^.PlayMode:= pmLive;
      Info^.IsInCallback:= FALSE;
      Info^.InstData:= nil;
      KbLost:= TRUE;
      OldGCGUID:= NullGUIDStr;
      GCLost:= TRUE;
      InstTimeBegin:= timeGetTime();
      InstPauseBegin:= 0;

      // Inisialisasi selesai! mulai program!
      Info^.Mulai:= TRUE;

      // Loop utama
      while (not Info^.Keluar) do
        begin

        // Atur volume
        if (SVol <> Info^.PlayVolume) then
          begin
          SVol:= Info^.PlayVolume;
          AlSourcef(SndSource, AL_GAIN, SVol);
        end;

        // Buka file instrumen
        if (Info^.ChangeInstDlg = ciLoad) then
          begin
          // Kalau data masih terbuka, unload dulu
          if (Info^.InstData <> nil) then
            Skf_ReleaseInstrument(Info^.InstData);
          Info^.InstData:= Skf_LoadInstrumentFile(Info^.ParamFilePath);
          InstPath:= Info^.ParamFilePath;
          FreeMem(Info^.ParamFilePath, Info^.ParamPathSize);
          Info^.ParamFilePath:= nil;
          Info^.ChangeMode:= FALSE;
          Info^.PlayMode:= pmLive;
          Info^.ChangeInstDlg:= ciNone;
          if (Info^.InstData <> nil) then
            PanggilEventCallback(peLoaded, @InstPath[1])
          else
            PanggilEventCallback(peLoaded, nil);
        end
        else // Simpan file instrumen
        if (Info^.ChangeInstDlg = ciSave) then
          begin
          Info^.InstSaved:= Skf_SaveInstrumentFile(Info^.ParamFilePath, Info^.InstData);
          InstPath:= Info^.ParamFilePath;
          FreeMem(Info^.ParamFilePath, Info^.ParamPathSize);
          Info^.ParamFilePath:= nil;
          Info^.ChangeMode:= FALSE;
          Info^.PlayMode:= pmLive;
          Info^.ChangeInstDlg:= ciNone;
          if Info^.InstSaved then
            PanggilEventCallback(peSaved, @InstPath[1])
          else
            PanggilEventCallback(peSaved, nil);
        end;

        // Kalo Keyboard lost
        if KbLost then
          KbLost:= not Ski_InputAcquire(KInpIntfc);

        // Akusisi device Game Controller
        GCGUIDStr:= GUIDToString(Info^.GameCtrlGUID);
        if (GCGUIDStr <> NullGUIDStr) and (Info^.UseGameCtrl) then
          begin
          if (OldGCGUID <> GCGUIDStr) then
            begin
            if (GInpIntfc <> nil) then
              GInpIntfc:= nil;
            if Ski_SetupInput(GInpIntfc, itGCtrl, Info^.GameCtrlGUID, Info^.FocusHandle) then
              if Ski_InputAcquire(GInpIntfc) then
                begin
                OldGCGUID:= GUIDToString(Info^.GameCtrlGUID);
                GCLost:= FALSE;
              end;
          end
          else
          if GCLost then
            begin
            GCLost:= not Ski_InputAcquire(GInpIntfc);
          end;
        end
        else
        if (OldGCGUID = NullGUIDStr) or (not Info^.UseGameCtrl) then
          begin
          OldGCGUID:= NullGUIDStr;
          GCLost:= TRUE;
          if (GInpIntfc <> nil) then
            GInpIntfc:= nil;
        end;

        // Pergantian modus permainan
        if (OldPlayMode <> Info^.PlayMode) then
          begin

          // Sebelum ganti ke modus yang baru,
          // finalisasi untuk modus yang lama
          case OldPlayMode of

            //=== Selesai main bebas ===========================================
            pmLive:
              begin

              PanggilEventCallback(peLiveEnd);

            end;

            //=== Selesai Rekaman ==============================================
            pmRecord:
              begin

              InstTimeCur:= timeGetTime();
              Info^.PlayTimeCur:= LongWord(InstTimeCur - InstTimeBegin);
              Skf_SetInstrumentEndTime(Info^.InstData, Info^.PlayTimeCur);

              PanggilEventCallback(peRecordEnd);

            end;

            //=== Selesai pause ================================================
            pmPause:
              begin

              if (KeluarSuara) then
                alSourcePlay(SndSource);

              PanggilEventCallback(pePauseEnd);

            end;

            //=== Selesai putar balik ==========================================
            pmPlayback:
              begin

              PanggilEventCallback(pePlaybackEnd);

            end;

          end;

          // Atur untuk modus yang baru
          case Info^.PlayMode of

            //=== Mau main bebas ===============================================
            pmLive:
              begin

              SesiBaru;
              PanggilEventCallback(peLiveBegin);

            end;

            //=== Mau Rekaman ==================================================
            pmRecord:
              begin

              SesiBaru;

              // Unload instrumen dari sesi sebelumnya
              if (Info^.InstData <> nil) then
                Skf_ReleaseInstrument(Info^.InstData);
              // Mulai rekaman baru
              Info^.InstData:= Skf_NewBlankInstrument;
              InstTimeBegin:= timeGetTime();

              PanggilEventCallback(peRecordBegin);

            end;

            //=== Mau Pause ====================================================
            pmPause:
              begin

              InstPauseBegin:= timeGetTime();
              if (KeluarSuara) then
                alSourcePause(SndSource);

              PanggilEventCallback(pePauseBegin);

            end;

            //=== Mau Putar balik ==============================================
            pmPlayback:
              begin

              if (OldPlayMode = pmLive) then
                begin
                SesiBaru;
                //if (InstData = nil) then
                //  InstData:= DialogLoadInstrumentFile;
                if (Info^.InstData <> nil) then
                  begin

                  // Atur pengturan awal sesuai instrumen
                  Info^.PlayTimeCur:= 0;
                  Info^.PlayTimeMax:= Info^.InstData^.Header.TimeLength;
                  InstMIdx:= Info^.InstData^.Header.BeatsCount;
                  InstTimeBegin:= timeGetTime();

                  PanggilEventCallback(pePlaybackBegin);

                end
                else // tidak ada instrumen terload, balik ke mode live!
                  Info^.PlayMode:= pmLive;
              end
              else
              if (OldPlayMode = pmPause) then
                begin

                InstPauseEnd:= timeGetTime();
                InstTimeBegin:= InstTimeBegin +
                                LongWord(InstPauseEnd - InstPauseBegin);

                PanggilEventCallback(pePlaybackBegin);

              end;

            end;

          end;

          OldPlayMode:= Info^.PlayMode;
          Info^.ChangeMode:= FALSE;

        end;

        // Hitung waktu saat ini
        if (Info^.PlayMode <> pmLive) and (Info^.PlayMode <> pmPause) then
          begin
          InstTimeCur:= timeGetTime();
          Info^.PlayTimeCur:= LongWord(InstTimeCur - InstTimeBegin);
        end;

        // Kalau lagi main-main atau rekaman
        if (Info^.PlayMode = pmLive) or (Info^.PlayMode = pmRecord) then
          begin

          // Dapatkan status keyboard
          if (GetForegroundWindow() = Info^.FocusHandle) then
            begin
            DapatKey:= FALSE;
            if (not KbLost) then
              begin
              KbLost:= not Ski_GetKeyboardInputState(KInpIntfc, KBuf);
              DapatKey:= not KbLost;
            end;
            if (not GCLost) then
              begin
              GCLost:= not Ski_GetGameControllerInputState(GInpIntfc, GBuf);
              DapatKey:= DapatKey or (not GCLost);
            end;
          end
          else
            DapatKey:= FALSE;

          // Status dari input berhasil didapatkan
          if (DapatKey) and ((KBuf[DIK_LCONTROL] and $80) <> $80)
                        and ((KBuf[DIK_RCONTROL] and $80) <> $80) then
            begin

            // Tombol utama
            for l:= 0 to LubangSerune do
              begin
              Kunci[l]:= FALSE;
              // keyboard
              if (not KbLost) then
                if (Info^.KbdButton[l] <> 0) then
                  Kunci[l]:= ((KBuf[Info^.KbdButton[l]] and $80) = $80);
              // game controller
              if (not GCLost) then
                if (Info^.GCtButton[l] <> 0) then
                  Kunci[l]:= ((GBuf.rgbButtons[Info^.GCtButton[l]] and $80) = $80) or
                             Kunci[l];
              // mouse
              Kunci[l]:= (Info^.NoteToggle[l]) or Kunci[l];
            end;

            // Tombol dengan lubang kombinasi
            if (Info^.UseCombKey) then
              if (not KbLost) then
                for l:= 0 to LubangSerune-1 do
                  if (Info^.KbdButtonCmb[l] <> 0) then
                    begin
                    KombKey:= (KBuf[Info^.KbdButtonCmb[l]] and $80) = $80;
                    Kunci[l]:= Kunci[l] or KombKey;
                    Kunci[l+1]:= Kunci[l+1] or KombKey;
                  end;

            Ditiup:= FALSE;
            // Tombol tiup keyboard
            if (not KbLost) then
              if (Info^.KbdButtonBlow <> 0) then
                Ditiup:= (KBuf[Info^.KbdButtonBlow] and $80) = $80;
            // Dan untuk game controller
            if (not GCLost) then
              if (Info^.GCtButtonBlow <> 0) then
                Ditiup:= ((GBuf.rgbButtons[Info^.GCtButtonBlow] and $80) = $80) or
                         Ditiup;

            // Sederhanakan data dari array
            KeyState:= GetIndexOfKey(@Kunci);

            // Direct mode or blow toggle
            if (Info^.DirectMode) and (not Ditiup) then
              Ditiup:= (KeyState > 0) or (Info^.BlowToggle);

          end;

        end
        else // Sedang playback
        if (Info^.PlayMode = pmPlayback) then // Playback tidak dipause
          begin

          if (InstCIdx < InstMIdx) then
            if (Info^.PlayTimeCur >= Info^.InstData^.Data[InstCIdx].Time) then
              begin
              KeyState:= Info^.InstData^.Data[InstCIdx].Notes;
              Ditiup:= boolean(Info^.InstData^.Data[InstCIdx].Blow);
              Inc(InstCIdx);
            end;
          if (Info^.PlayTimeCur >= Info^.PlayTimeMax) then
            begin
            Info^.ChangeMode:= TRUE;
            Info^.PlayMode:= pmLive;
          end;

        end;

        // Posisi lubang berubah atau tidak?
        NadaBaru:= (KeyState <> OldHoleState) or (Ditiup <> OldBlowState);
        OldHoleState:= KeyState;
        OldBlowState:= Ditiup;

        // Kalau ada perubahan nada, panggil callback
        // Atau, kalo sedang modus rekaman, masukan informasi dulu
        if NadaBaru then
          begin

          // Modus rekaman, masukan informasi
          if (Info^.PlayMode = pmRecord) then
            Skf_AddBeatToInstrument(Info^.InstData, Info^.PlayTimeCur, KeyState, Ditiup);

          // Panggil callback
          PackedNote:= 0;
          PtrNote:= @PackedNote;
          PtrNote.Notes:= Byte(KeyState);
          PtrNote.Blowed:= Byte(Ditiup);
          PanggilEventCallback(peNotesUpdate, PtrNote);

        end;

        // Saatnya meniup serunee!
        if Ditiup then
          begin
          if NadaBaru then
            begin
            AlSourceStop(SndSource);
            //AlSourcei(SndSource, AL_BUFFER, 0);
            AlDeleteBuffers(1, @SBuf);
            AlGenBuffers(1, @SBuf);
            Skf_LoadSoundBankToBuffer(SBuf, SBank, KeyState);
            AlSourcei(SndSource, AL_BUFFER, SBuf);
            AlSourcePlay(SndSource);
            KeluarSuara:= TRUE;
          end;
        end
        else // Kalo ga' ditiup, hentikan suara
        if NadaBaru then
          begin
          AlSourceStop(SndSource);
          KeluarSuara:= FALSE;
        end;

        // Delay 1 ms
        Sleep(1);

      end;

      // Hentikan semua suara
      AlSourceStop(SndSource);
      Result:= 0;

    finally

      // Menghindari locking saat menunggu thread
      Info^.Mulai:= TRUE;

      // Bersihkan diri
      if (Info^.ParamFilePath <> nil) then
        FreeMem(Info^.ParamFilePath, Info^.ParamPathSize);
      if (Info^.InstData <> nil) then
        Skf_ReleaseInstrument(Info^.InstData);
      if (SBank <> nil) then
        Skf_ReleaseSoundBank(SBank);
      KInpIntfc:= nil;
      AlDeleteBuffers(1, @SBuf);
      AlDeleteSources(1, @SndSource);

      // Bebaskan OpenAL
      OalCtx:= alcGetCurrentContext();
      OalDev:= alcGetContextsDevice(OalCtx);
      alcDestroyContext(OalCtx);
      alcCloseDevice(OalDev);

      timeEndPeriod(1);

    end;

  except

    on E: Exception do
      begin
      MessageBox(0,//Info^.FocusHandle,
                 PChar(Format(s_SrFatalError, [E.Message])),
                 PChar(SrneeModuleName), MB_ICONERROR + MB_TOPMOST);
      ExitProcess(0);
    end;

  end;

end;

//==============================================================================

procedure Skp_ToggleNoteState(Info: PSrInfo; NoteIndex: integer; Pressed: boolean);
begin

  Info^.NoteToggle[NoteIndex]:= Pressed;

end;

//==============================================================================

procedure Skp_ToggleBlowState(Info: PSrInfo; Pressed: boolean);
begin

  Info^.BlowToggle:= Pressed;

end;

//==============================================================================

function Skp_LiveRecord(Info: PSrInfo): boolean;
begin

  Result:= FALSE;
  if (not Info^.ChangeMode) or (Info^.IsInCallback) then
    begin
    Info^.ChangeMode:= TRUE;
    if (Info^.PlayMode = pmLive) then
      Info^.PlayMode:= pmRecord
    else
    if (Info^.PlayMode = pmRecord) then
      Info^.PlayMode:= pmLive
    else
      Info^.ChangeMode:= FALSE;
    Result:= Info^.ChangeMode;
  end;

end;

//==============================================================================

function Skp_PlayPausePlayback(Info: PSrInfo): boolean;
begin

  Result:= FALSE;
  if (not Info^.ChangeMode) or (Info^.IsInCallback) then
    begin
    Info^.ChangeMode:= TRUE;
    if (Info^.PlayMode = pmLive) then
      Info^.PlayMode:= pmPlayback
    else
    if (Info^.PlayMode = pmPlayback) then
      Info^.PlayMode:= pmPause
    else
    if (Info^.PlayMode = pmPause) then
      Info^.PlayMode:= pmPlayback
    else
      Info^.ChangeMode:= FALSE;
    Result:= Info^.ChangeMode;
  end;

end;

//==============================================================================

function Skp_StopPlayback(Info: PSrInfo): boolean;
begin

  Result:= FALSE;
  if (not Info^.ChangeMode) or (Info^.IsInCallback) then
    begin
    if (Info^.PlayMode <> pmLive) then
      begin
      Info^.ChangeMode:= TRUE;
      Info^.PlayMode:= pmLive;
      Result:= TRUE;
    end;
  end;

end;

//==============================================================================

function Skp_OpenInstrumentFile(Info: PSrInfo; Path: PChar): boolean;
var
  msize: LongWord;
begin

  Result:= FALSE;
  if (not Info^.ChangeMode) or (Info^.IsInCallback) then
    begin
    if (Info^.PlayMode <> pmPlayback) then
      begin
      msize:= Length(Path)+1;
      Info^.ParamPathSize:= msize;
      GetMem(Info^.ParamFilePath, msize);
      CopyMemory(Info^.ParamFilePath, Path, msize);
      Info^.ChangeMode:= TRUE;
      Info^.ChangeInstDlg:= ciLoad;
      if (not Info^.IsInCallback) then
        while (Info.ChangeInstDlg = ciLoad) do
          Sleep(0);
      Result:= (Info^.InstData <> nil) or (Info^.IsInCallback);
    end;
  end;

end;

//==============================================================================

function Skp_SaveInstrumentFile(Info: PSrInfo; Path: PChar): boolean;
var
  msize: LongWord;
begin

  Result:= FALSE;
  if (not Info^.ChangeMode) or (Info^.IsInCallback) then
    begin
    if (Info^.PlayMode <> pmRecord) then
      begin
      msize:= Length(Path)+1;
      Info^.ParamPathSize:= msize;
      GetMem(Info^.ParamFilePath, msize);
      CopyMemory(Info^.ParamFilePath, Path, msize);
      Info^.ChangeMode:= TRUE;
      Info^.ChangeInstDlg:= ciSave;
      if (not Info^.IsInCallback) then
        while (Info.ChangeInstDlg = ciSave) do
          Sleep(0);
      Result:= Info^.InstSaved or (Info^.IsInCallback);
    end;
  end;

end;

//==============================================================================

procedure Skp_WaitChangeState(var Info: PSrInfo);
begin

  while (Info^.ChangeMode) do
    Sleep(0);

end;

//==============================================================================

function Skp_InstrumentLoaded(Info: PSrInfo): boolean;
begin

  Result:= Info^.InstData <> nil;

end;

//==============================================================================

function Skp_GetKeyboardKey(Info: PSrInfo; Action, SubAction: byte): byte;
begin

  case Action of

    SK_AKEY_BLOW: Result:= Info^.KbdButtonBlow;

    SK_AKEY_HOLE: Result:= Info^.KbdButton[SubAction];

    SK_AKEY_COMBINATION: Result:= Info^.KbdButtonCmb[SubAction];

  else

    Result:= 0;

  end;

end;

//==============================================================================

procedure Skp_SetKeyboardKey(Info: PSrInfo; Action, SubAction: byte; Button: byte);
begin

  case Action of

    SK_AKEY_BLOW: Info^.KbdButtonBlow:= Button;

    SK_AKEY_HOLE: Info^.KbdButton[SubAction]:= Button;

    SK_AKEY_COMBINATION: Info^.KbdButtonCmb[SubAction]:= Button;

  end;

end;

//==============================================================================

function Skp_GetGameCtrlKey(Info: PSrInfo; Action, SubAction: byte): byte;
begin

  case Action of

    SK_AKEY_BLOW: Result:= Info^.GCtButtonBlow;

    SK_AKEY_HOLE: Result:= Info^.GCtButton[SubAction];

  else

    Result:= 0;

  end;

end;

//==============================================================================

procedure Skp_SetGameCtrlKey(Info: PSrInfo; Action, SubAction: byte; Button: byte);
begin

  case Action of

    SK_AKEY_BLOW: Info^.GCtButtonBlow:= Button;

    SK_AKEY_HOLE: Info^.GCtButton[SubAction]:= Button;

  end;

end;

//==============================================================================

function Skp_GetPlayerProperty(Info: PSrInfo; Prop: LongWord): LongInt;
begin

  case Prop of

    SKP_PROP_PARENT_OWNER: Result:= LongInt(Info^.FocusHandle);

    SKP_PROP_OPENAL_DEVINDEX: Result:= LongInt(Info^.DeviceIndex);

    SKP_PROP_DIRECT_MODE: Result:= LongInt(Info^.DirectMode);

    SKP_PROP_PLAY_MODE: Result:= LongInt(Info^.PlayMode);

    SKP_PROP_PLAY_VOLUME: Result:= LongInt(Round(Info^.PlayVolume));

    SKP_PROP_PLAY_CURRENTTIME: Result:= LongInt(Info^.PlayTimeCur);

    SKP_PROP_PLAY_TIMELENGTH: Result:= LongInt(Info^.PlayTimeMax);

    SKP_PROP_INSTRUMENT_DATA: Result:= LongInt(Info^.InstData);

    SKP_PROP_INPUT_USE: Result:= LongInt(Info^.UseDevInput);

    SKP_PROP_KEY_COMBINATION: Result:= LongInt(Info^.UseCombKey);

    SKP_PROP_GAMECTRL_GUID: Result:= LongInt(@Info^.GameCtrlGUID);

    SKP_PROP_GAMECTRL_USE: Result:= LongInt(Info^.UseGameCtrl);

    SKP_PROP_THREAD_HANDLE: Result:= LongInt(Info^.ThreadHandle);

    SKP_PROP_THREAD_ID: Result:= LongInt(Info^.ThreadID);

  else

    Result:= 0;

  end;

end;

//==============================================================================

procedure Skp_SetPlayerProperty(Info: PSrInfo; Prop: LongWord; Val: LongInt);
begin

  case Prop of

    SKP_PROP_PARENT_OWNER: Info^.FocusHandle:= Val;

    SKP_PROP_DIRECT_MODE: Info^.DirectMode:= boolean(Val);

    SKP_PROP_PLAY_MODE: Info^.PlayMode:= TSrPlayMode(Val);

    SKP_PROP_PLAY_VOLUME: Info^.PlayVolume:= Val/100;

    //SKP_PROP_PLAYTIME_CURRENT: Info^:= ;

    //SKP_PROP_PLAYTIME_LENGTH: Info^:= ;

    SKP_PROP_INPUT_USE: Info^.UseDevInput:= boolean(Val);

    SKP_PROP_KEY_COMBINATION: Info^.UseCombKey:= boolean(Val);

    SKP_PROP_GAMECTRL_GUID: Info^.GameCtrlGUID:= PGUID(Val)^;

    SKP_PROP_GAMECTRL_USE: Info^.UseGameCtrl:= boolean(Val);

  end;

end;

//==============================================================================

procedure Skp_SetPlayerEventCallback(Info: PSrInfo; CallProc: TSrPlayEventCallback);
begin

  Info^.EventCallback:= CallProc;

end;

//==============================================================================

function Skp_SetupPlayer(var Info: PSrInfo; MainHandle: THandle; DeviceIndex: integer;
  SoundBankPath: PChar; LoadCallback: TSrSoundBankLoadCallback = nil): boolean;
var
  SbOld: LongInt;
  sbstsz: integer;
begin

  // Alokasi memori dan tulis berberapa data
  GetMem(Info, SizeOf(TSrInfo));
  ZeroMemory(Info, SizeOf(TSrInfo));

  // Alokasikan memori untuk path SoundBank
  sbstsz:= Length(SoundBankPath)+1;
  GetMem(Info^.SoundBankPath, sbstsz);
  CopyMemory(Info^.SoundBankPath, SoundBankPath, sbstsz);
  Info^.DeviceIndex:= DeviceIndex;
  Info^.FocusHandle:= MainHandle;
  Info^.ChangeMode:= FALSE;
  Info^.ChangeInstDlg:= ciNone;
  Info^.Keluar:= FALSE;

  // Sebelum load soundbank, wajib dikosongkan
  Info^.SBankLoaded:= 0;
  SbOld:= 0;

  // Inisialisasi Critical Section dan mulai thread
  InitializeCriticalSection(Info^.ThreadCs);
  Info^.ThreadHandle:= BeginThread(nil, 0, @SrThreadPool, Info, 0, Info^.ThreadID);

  // Tunggu hingga siap inisialisasi
  while (not Info^.Mulai) do
    begin
    if (@LoadCallback <> nil) then
      if (Info^.SBankLoaded <> SbOld) then
        begin
        SbOld:= Info^.SBankLoaded;
        LoadCallback(SbOld);
      end;
    Sleep(0);
  end;
  if (@LoadCallback <> nil) then
    LoadCallback(0);
  // Kosongkan buffer string path ke Soundbank, karena tidak perlu lagi
  FreeMem(Info^.SoundBankPath, sbstsz);
  Result:= Info^.ThreadHandle <> 0;

end;

//==============================================================================

function Skp_ExitPlayer(var Info: PSrInfo): boolean;
begin

  Info^.Keluar:= TRUE;
  Result:= WaitForSingleObject(Info^.ThreadHandle, INFINITE) <> WAIT_FAILED;
  DeleteCriticalSection(Info^.ThreadCs);
  FreeMem(Info, SizeOf(TSrInfo));
  Info:= nil;

end;

end.
