unit SrneeTypes;

(*==============================================================================

  Serune Kalee defined-types
  Copyright © Revolven Technologies
  Coded by Faris Khowarizmi 2014

==============================================================================*)

interface

{$I SeruneConf.inc}

uses
  Windows, OpenAL;

// * Serune Kalee Player (Skp_*) *

type

  {$IFDEF WIN64}
  TSkpNoteInfo = record
    Notes: LongInt;
    Blow: LongInt;
  end;
  {$ELSE}
  TSkpNoteInfo = record
    Notes: ShortInt;
    Blowed: ShortInt;
  end;
  {$ENDIF}
  PSkpNoteInfo = ^TSkpNoteInfo;

  TSrPlayMode = (pmNothing,
                 pmLive,
                 pmRecord,
                 pmPause,
                 pmPlayback);

  TSrPlayEvent = (peLiveBegin,
                  peRecordBegin,
                  pePauseBegin,
                  pePlaybackBegin,
                  peLiveEnd,
                  peRecordEnd,
                  pePauseEnd,
                  pePlaybackEnd,
                  peLoaded,
                  peSaved,
                  peNotesUpdate,
                  peExitThread);

  TSrChangeInstDialog = (ciNone, ciLoad, ciSave);

  TSrPlayEventCallback = procedure(Event: TSrPlayEvent; Param: PChar); {$IFDEF MSWINDOWS}  stdcall; {$ENDIF}
  PSrPlayEventCallback = ^TSrPlayEventCallback;

  TSrSoundBankLoadCallback = procedure(num: integer); {$IFDEF MSWINDOWS}  stdcall; {$ENDIF}
  PSrSoundBankLoadCallback = ^TSrSoundBankLoadCallback;

  PSrInfo = Pointer;

// * Serune Kalee File (Skf_*) *

  // Header file instrumen
  TSKTHeader = record
    HeaderString  : array[0..5] of AnsiChar;
    Align0        : array[0..1] of byte;
    Version       : LongWord;
    CRC32Checksum : LongWord;
    BeatsCount    : LongWord;
    TimeLength    : LongWord;
  end;
  PSKTHeader = ^TSKTHeader;

  TSKTBeat = record
    Time  : LongWord;
    Notes : ShortInt;
    Blow  : ShortInt;
  end;
  PSKTBeat = ^TSKTBeat;

  TSrInstrumentMemHeader = record
    BeatsCount : LongWord;
    TimeLength : LongWord;
  end;
  PSrInstrumentMemHeader = ^TSrInstrumentMemHeader;

  TSrInstrument = record
    StructSize : LongWord;
    Header     : TSrInstrumentMemHeader;
    Data       : array[0..High(LongWord) shr 5 - 1] of TSKTBeat;
  end;
  PSrInstrument = ^TSrInstrument;

  TSKBSoundNode = record
    Size: LongWord;
    CRC32: LongWord;
  end;
  PSKBSoundNode = ^TSKBSoundNode;

  // Header file soundbank
  TSKBHeader = record
    HeaderString : array[0..5] of AnsiChar;
    Align0       : array[0..1] of byte;
    Version      : LongWord;
    FileCount    : LongWord;
    FileNode     : array[0..255] of TSKBSoundNode;
  end;
  PSKBHeader = ^TSKBHeader;

  TSrSoundMem = record
    Format    : TALEnum;
    Size      : TALSizei;
    BufSize   : TALSizei;
    Frequency : TALSizei;
    Loop      : TALInt;
    Data      : TALVoid;
    BufData   : TALVoid;
  end;
  PSrSoundMem = ^TSrSoundMem;

  TSrSoundBank = array[0..255] of TSrSoundMem;
  PSrSoundBank = ^TSrSoundBank;

// * Serune Kalee Input (Ski_*)  *

  TSrInputType = (itKeybd, itGCtrl);

  // Untuk input keyboard
  TKeyboardBuffer = array [0..255] of byte;

implementation

end.
