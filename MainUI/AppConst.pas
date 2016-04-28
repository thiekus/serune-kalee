unit AppConst;

(*==============================================================================

  Serune Kalee application constant
  Copyright © Revolven Technologies
  Coded by Faris Khowarizmi 2014

==============================================================================*)

interface

const

  AppName = 'Serune Kalee Simulator';

  ScreenWSize = 720;
  ScreenHSize = 480;

  NullGUID: TGUID = '{00000000-0000-0000-0000-000000000000}';
  NullGUIDStr = '{00000000-0000-0000-0000-000000000000}';

  Def_KbdBlw = 57;
  Def_KbdKey: array[0..7] of byte = (30, 31, 32, 33, 36, 37, 38, 39);
  Def_KbdCmbKey: array[0..6] of byte = (17, 18, 19, 22, 23, 24, 25);

  Def_GCtBlw = 01;
  Def_GCtKey: array[0..7] of byte = (02, 03, 04, 05, 06, 07, 08, 09);

implementation

end.
