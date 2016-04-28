unit SrneeMsg;

(*==============================================================================

  Serune Kalee message unit
  Copyright © Revolven Technologies
  Coded by Faris Khowarizmi 2014

==============================================================================*)

interface

{$I SeruneConf.inc}

resourcestring
  SrneeModuleName = 'Serune Kalee Core';
  SrneeFileModule = 'Serune Kalee File';

  s_SrFatalError = 'Core fatal error: %s';
  s_SrCbackError = 'Core callback exception error on "%s": %s';
  s_SrCRC32Error = 'CRC32 file intergeration error!';
  s_SrCantLoadSbnk = 'Berberapa sound tidak dapat dimuat karena alasan berikut:';

  s_SrSbnkCRC32Er = 'Index %d: Verfikasi CRC32 gagal!';
  s_SrSbnkWavUnsp = 'Index %d: Jenis file WAV tidak didukung!';

implementation

end.
