unit SrneeConst;

(*==============================================================================

  Serune Kalee constants
  Copyright © Revolven Technologies
  Coded by Faris Khowarizmi 2014

==============================================================================*)

interface

{$I SeruneConf.inc}

const

  LubangSerune = 7;

//=== Serune Kalee Player (Skp_*)  =============================================

  // Buat properti
  SKP_PROP_PARENT_OWNER     = $00000001;
  SKP_PROP_OPENAL_DEVINDEX  = $00000002;
  SKP_PROP_DIRECT_MODE      = $00000003;
  SKP_PROP_PLAY_MODE        = $00000004;
  SKP_PROP_PLAY_VOLUME      = $00000005;
  SKP_PROP_PLAY_CURRENTTIME = $00000006;
  SKP_PROP_PLAY_TIMELENGTH  = $00000007;
  SKP_PROP_INSTRUMENT_DATA  = $00000008;
  SKP_PROP_INPUT_USE        = $00000009;
  SKP_PROP_KEY_COMBINATION  = $0000000A;
  SKP_PROP_GAMECTRL_GUID    = $0000000B;
  SKP_PROP_GAMECTRL_USE     = $0000000C;
  SKP_PROP_THREAD_HANDLE    = $0000000D;
  SKP_PROP_THREAD_ID        = $0000000E;

  SK_AKEY_BLOW        = $00;
  SK_AKEY_HOLE        = $01;
  SK_AKEY_COMBINATION = $02;

implementation

end.
