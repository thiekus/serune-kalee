unit AppStrings;

(*==============================================================================

  Serune Kalee application strings
  Copyright © Revolven Technologies
  Coded by Faris Khowarizmi 2014

==============================================================================*)

interface

const
  btn_file: array[0..3] of string = ('btn_menu_%s.png',
                                     'btn_rec_%s.png',
                                     'btn_play_%s.png',
                                     'btn_stop_%s.png');

  hint_str: array[0..3] of string = ('Menu program',
                                     'Rekam',
                                     'Mainkan/Jeda',
                                     'Hentikan');

  pmode_str: array[0..2] of string = ('Merekam',
                                      'Jeda',
                                      'Memutar');

resourcestring

  s_InitCrtUI = 'Creating Main User Interface...';
  s_InitCrtOt = 'Creating Additional User Interface...';
  s_InitCore  = 'Initializing Core Engine...';
  s_InitUIMan = 'Initializing UI Properties...';
  s_InitSbprg = 'Loading SoundBank: %d of %d...';
  s_InitCoref = 'Core Initialization Finished!';

  s_HintHole = 'Lubang %d - %s';
  s_HintBlow = 'Tiup - %s';

  s_PlayLive  = 'Permainan bebas';
  s_PlayRecd  = 'Sedang merekam';
  s_PlayPause = 'Pemutaran dijeda';
  s_PlayPlayb = 'Sedang memutar';

  s_ModeDirect = 'Modus langsung';
  s_ModeNormal = 'Modus biasa';

  s_Warning = 'Peringatan';

  s_NotSaved = 'Belum Tersimpan';
  s_NotSavedQuest = 'Anda belum menyimpan instrumen ini ke file, apakah anda ingin menyimpannya terlebih dahulu?';

implementation

end.
