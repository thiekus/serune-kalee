unit SrneeProcs;

(*==============================================================================

  Serune Kalee core player unit
  Copyright © Revolven Technologies
  Coded by Faris Khowarizmi 2014

==============================================================================*)

interface

{$I SeruneConf.inc}

uses
  SrneeTypes, DirectInput, OpenAL;

const
  SKE_Library = 'SeruneKalee.dll';

  procedure SeruneKaleeInit; stdcall;
  procedure SeruneKaleeDeInit; stdcall;

  // Serune Kalee Player
  procedure Skp_ToggleNoteState(Info: PSrInfo; NoteIndex: integer; Pressed: boolean); stdcall;
  procedure Skp_ToggleBlowState(Info: PSrInfo; Pressed: boolean); stdcall;
  function  Skp_LiveRecord(Info: PSrInfo): boolean; stdcall;
  function  Skp_PlayPausePlayback(Info: PSrInfo): boolean; stdcall;
  function  Skp_StopPlayback(Info: PSrInfo): boolean; stdcall;
  function  Skp_OpenInstrumentFile(Info: PSrInfo; Path: PChar): boolean; stdcall;
  function  Skp_SaveInstrumentFile(Info: PSrInfo; Path: PChar): boolean; stdcall;
  function  Skp_InstrumentLoaded(Info: PSrInfo): boolean; stdcall;
  function  Skp_GetKeyboardKey(Info: PSrInfo; Action, SubAction: byte): byte; stdcall;
  procedure Skp_SetKeyboardKey(Info: PSrInfo; Action, SubAction: byte; Button: byte); stdcall;
  function  Skp_GetGameCtrlKey(Info: PSrInfo; Action, SubAction: byte): byte; stdcall;
  procedure Skp_SetGameCtrlKey(Info: PSrInfo; Action, SubAction: byte; Button: byte); stdcall;
  function  Skp_GetPlayerProperty(Info: PSrInfo; Prop: LongWord): LongInt; stdcall;
  procedure Skp_SetPlayerProperty(Info: PSrInfo; Prop: LongWord; Val: LongInt); stdcall;
  procedure Skp_SetPlayerEventCallback(Info: PSrInfo; CallProc: TSrPlayEventCallback); stdcall;
  function  Skp_SetupPlayer(var Info: PSrInfo; MainHandle: THandle;
                            DeviceIndex: integer; SoundBankPath: PChar;
                            LoadCallback: TSrSoundBankLoadCallback = nil): boolean; stdcall;
  function  Skp_ExitPlayer(var Info: PSrInfo): boolean; stdcall;

  // Serune Kalee File
  function  Skf_LoadInstrumentFile(Path: PChar): PSrInstrument; stdcall;
  function  Skf_SaveInstrumentFile(Path: PChar; Instrument: PSrInstrument): boolean; stdcall;
  function  Skf_NewBlankInstrument: PSrInstrument; stdcall;
  procedure Skf_AddBeatToInstrument(var Instrument: PSrInstrument; Time: LongWord; Notes: Byte; Blow: boolean); stdcall;
  procedure Skf_SetInstrumentEndTime(Instrument: PSrInstrument; Time: LongWord); stdcall;
  procedure Skf_ReleaseInstrument(var Instrument: PSrInstrument); stdcall;

  function  Skf_LoadSoundBank(Path: PChar; LoadCount: PLongInt = nil): PSrSoundBank; stdcall;
  procedure Skf_ReleaseSoundBank(var SoundBank: PSrSoundBank); stdcall;
  procedure Skf_LoadSoundBankToBuffer(var Buffer: TALuint; SoundBank: PSrSoundBank; Index: Byte); stdcall;

  // Serune Kalee Audio
  function  Ska_GetEnumDevices: PChar; stdcall;
  function  Ska_GetDeviceOfIndex(Index: integer): PChar; stdcall;
  function  Ska_GetIndexOfDevice(Device: PChar): integer; stdcall;

  // Serune Kalee Input
  function Ski_GetGameControllerInputState(const InputInterface: IDirectInputDevice8;
                                           var KeyBuffer: TDIJoyState2): boolean; stdcall;
  function Ski_GetKeyboardInputState(const InputInterface: IDirectInputDevice8;
                                     var KeyBuffer: TKeyboardBuffer): boolean; stdcall;
  function Ski_InputAcquire(const InputInterface: IDirectInputDevice8): boolean; stdcall;
  function Ski_InputUnacquire(const InputInterface: IDirectInputDevice8): boolean; stdcall;
  function Ski_EnumGameControllerDevices(Callback: TDIEnumDevicesCallback): boolean; stdcall;
  function Ski_SetupInput(var InputInterface: IDirectInputDevice8; InputType: TSrInputType;
                                 InputGUID: TGUID; FocusHandle: THandle): boolean; stdcall;

implementation

  procedure SeruneKaleeInit; external SKE_Library;
  procedure SeruneKaleeDeInit; external SKE_Library;

  // Serune Kalee Player
  procedure Skp_ToggleNoteState(Info: PSrInfo; NoteIndex: integer; Pressed: boolean); external SKE_Library;
  procedure Skp_ToggleBlowState(Info: PSrInfo; Pressed: boolean); external SKE_Library;
  function  Skp_LiveRecord(Info: PSrInfo): boolean; external SKE_Library;
  function  Skp_PlayPausePlayback(Info: PSrInfo): boolean; external SKE_Library;
  function  Skp_StopPlayback(Info: PSrInfo): boolean; external SKE_Library;
  function  Skp_OpenInstrumentFile(Info: PSrInfo; Path: PChar): boolean; external SKE_Library;
  function  Skp_SaveInstrumentFile(Info: PSrInfo; Path: PChar): boolean; external SKE_Library;
  function  Skp_InstrumentLoaded(Info: PSrInfo): boolean; external SKE_Library;
  function  Skp_GetKeyboardKey(Info: PSrInfo; Action, SubAction: byte): byte; external SKE_Library;
  procedure Skp_SetKeyboardKey(Info: PSrInfo; Action, SubAction: byte; Button: byte); external SKE_Library;
  function  Skp_GetGameCtrlKey(Info: PSrInfo; Action, SubAction: byte): byte; external SKE_Library
  procedure Skp_SetGameCtrlKey(Info: PSrInfo; Action, SubAction: byte; Button: byte); external SKE_Library
  function  Skp_GetPlayerProperty(Info: PSrInfo; Prop: LongWord): LongInt; external SKE_Library;
  procedure Skp_SetPlayerProperty(Info: PSrInfo; Prop: LongWord; Val: LongInt); external SKE_Library;
  procedure Skp_SetPlayerEventCallback(Info: PSrInfo; CallProc: TSrPlayEventCallback); external SKE_Library;
  function  Skp_SetupPlayer(var Info: PSrInfo; MainHandle: THandle;
                            DeviceIndex: integer; SoundBankPath: PChar;
                            LoadCallback: TSrSoundBankLoadCallback = nil): boolean; external SKE_Library;
  function  Skp_ExitPlayer(var Info: PSrInfo): boolean; external SKE_Library;

  // Serune Kalee File
  function  Skf_LoadInstrumentFile(Path: PChar): PSrInstrument; external SKE_Library;
  function  Skf_SaveInstrumentFile(Path: PChar; Instrument: PSrInstrument): boolean; external SKE_Library;
  function  Skf_NewBlankInstrument: PSrInstrument; external SKE_Library;
  procedure Skf_AddBeatToInstrument(var Instrument: PSrInstrument; Time: LongWord; Notes: Byte; Blow: boolean); external SKE_Library;
  procedure Skf_SetInstrumentEndTime(Instrument: PSrInstrument; Time: LongWord); external SKE_Library;
  procedure Skf_ReleaseInstrument(var Instrument: PSrInstrument); external SKE_Library;

  function  Skf_LoadSoundBank(Path: PChar; LoadCount: PLongInt = nil): PSrSoundBank; external SKE_Library;
  procedure Skf_ReleaseSoundBank(var SoundBank: PSrSoundBank); external SKE_Library;
  procedure Skf_LoadSoundBankToBuffer(var Buffer: TALuint; SoundBank: PSrSoundBank; Index: Byte); external SKE_Library;


  // Serune Kalee Audio
  function  Ska_GetEnumDevices: PChar; external SKE_Library;
  function  Ska_GetDeviceOfIndex(Index: integer): PChar; external SKE_Library;
  function  Ska_GetIndexOfDevice(Device: PChar): integer; external SKE_Library;

  // Serune Kalee Input
  function Ski_GetGameControllerInputState(const InputInterface: IDirectInputDevice8;
                                           var KeyBuffer: TDIJoyState2): boolean; external SKE_Library;
  function Ski_GetKeyboardInputState(const InputInterface: IDirectInputDevice8;
                                     var KeyBuffer: TKeyboardBuffer): boolean; external SKE_Library;
  function Ski_InputAcquire(const InputInterface: IDirectInputDevice8): boolean; external SKE_Library;
  function Ski_InputUnacquire(const InputInterface: IDirectInputDevice8): boolean; external SKE_Library;
  function Ski_EnumGameControllerDevices(Callback: TDIEnumDevicesCallback): boolean; external SKE_Library;
  function Ski_SetupInput(var InputInterface: IDirectInputDevice8; InputType: TSrInputType;
                                 InputGUID: TGUID; FocusHandle: THandle): boolean; external SKE_Library;


end.
