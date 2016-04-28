library SeruneKalee;

(*==============================================================================

  Serune Kalee main dynamic library project
  Copyright © Revolven Technologies
  Coded by Faris Khowarizmi 2014

==============================================================================*)

{$I SeruneConf.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

// Harus pada modus dll, atau ga' compile error!
{$IFNDEF SKE_USE_DYNLIB}
  {$Message Error 'You must enable dynamic library option before compile this library!'}
{$ENDIF}

uses
  SrneeConst in 'SrneeConst.pas',
  SrneeTypes in 'SrneeTypes.pas',
  SrneeMsg in 'SrneeMsg.pas',
  SrneeCore in 'SrneeCore.pas',
  SrneeFile in 'SrneeFile.pas',
  SrneeAudio in 'SrneeAudio.pas',
  SrneeInput in 'SrneeInput.pas';

{$R *.res}

//==============================================================================

procedure SeruneKaleeInit; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
begin

  _InitSrneeAudio;
  _InitSrneeInput;

end;

//==============================================================================

procedure SeruneKaleeDeInit; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
begin

  _DeInitSrneeAudio;
  _DeInitSrneeInput;

end;

//==============================================================================

exports

  // Main init/deinit
  SeruneKaleeInit,
  SeruneKaleeDeInit,

  // Player
  Skp_ToggleNoteState,
  Skp_LiveRecord,
  Skp_PlayPausePlayback,
  Skp_StopPlayback,
  Skp_OpenInstrumentFile,
  Skp_SaveInstrumentFile,
  Skp_InstrumentLoaded,
  Skp_GetKeyboardKey,
  Skp_SetKeyboardKey,
  Skp_GetGameCtrlKey,
  Skp_SetGameCtrlKey,
  Skp_GetPlayerProperty,
  Skp_SetPlayerProperty,
  Skp_SetPlayerEventCallback,
  Skp_SetupPlayer,
  Skp_ExitPlayer,

  // File
  Skf_LoadInstrumentFile,
  Skf_SaveInstrumentFile,
  Skf_NewBlankInstrument,
  Skf_AddBeatToInstrument,
  Skf_SetInstrumentEndTime,
  Skf_ReleaseInstrument,

  Skf_LoadSoundBank,
  Skf_ReleaseSoundBank,
  Skf_LoadSoundBankToBuffer,

  // Audio
  Ska_GetEnumDevices,
  Ska_GetDeviceOfIndex,
  Ska_GetIndexOfDevice,

  // Input
  Ski_GetGameControllerInputState,
  Ski_GetKeyboardInputState,
  Ski_InputAcquire,
  Ski_InputUnacquire,
  Ski_EnumGameControllerDevices,
  Ski_SetupInput;

begin

end.
