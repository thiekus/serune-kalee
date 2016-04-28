(*==============================================================================

  Serune Kalee compiler switch configuration
  Copyright © Revolven Technologies
  Coded by Faris Khowarizmi 2014

==============================================================================*)

// Gunakan dynamic library (*.dll di Windows)
{$DEFINE SKE_USE_DYNLIB}

{$IFDEF SKE_USE_DYNLIB}
  // Gunakan fungsi pemanggilan standar windows daripada standar delphi
  {$IFDEF MSWINDOWS}
    {$DEFINE SKE_STDCALL}
  {$ENDIF}
  // Kalau pake DLL, inisialisasi default oleh RTL (kalo gak, program ga jalan!)
  {$DEFINE SKE_NO_RTLINIT}
{$ENDIF}

{$IFDEF WIN32}
  // Gunakan kalkulator CRC32 berbasis Assembly
  {$DEFINE SKE_USE_FASTCRC32}
{$ENDIF}

