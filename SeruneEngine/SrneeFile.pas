unit SrneeFile;

(*==============================================================================

  Serune Kalee file structure and routines
  Copyright © Revolven Technologies
  Coded by Faris Khowarizmi 2014

==============================================================================*)

interface

{$I SeruneConf.inc}

uses
  Windows, Messages, SysUtils, Classes, OpenAL, SrneeMsg, SrneeTypes;

(*=== WAV Header =============================================================*)

type
  //WAV file header
  TWAVHeader = record
    RIFFHeader: array [1..4] of AnsiChar;
    FileSize: LongWord;
    WAVEHeader: array [1..4] of AnsiChar;
    FormatHeader: array [1..4] of AnsiChar;
    FormatHeaderSize: LongWord;
    FormatCode: Word;
    ChannelNumber: Word;
    SampleRate: LongWord;
    BytesPerSecond: LongWord;
    BytesPerSample: Word;
    BitsPerSample: Word;
    DataHeader: array [1..4] of AnsiChar;
    DataSize: LongWord;
  end;
  PWAVHeader = ^TWAVHeader;

const
  WAV_STANDARD  = $0001;
  //WAV_IMA_ADPCM = $0011;
  //WAV_MP3       = $0055;

(*=== File Instrumen (*.skt) =================================================*)

const

  SKTHeaderString = 'SKTABL';
  SKTVersion = $01000000;

  // Rutin Instrumen
  function  Skf_LoadInstrumentFile(Path: PChar): PSrInstrument; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function  Skf_SaveInstrumentFile(Path: PChar; Instrument: PSrInstrument): boolean; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  function  Skf_NewBlankInstrument: PSrInstrument; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  procedure Skf_AddBeatToInstrument(var Instrument: PSrInstrument; Time: LongWord; Notes: Byte; Blow: boolean); {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  procedure Skf_SetInstrumentEndTime(Instrument: PSrInstrument; Time: LongWord); {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  procedure Skf_ReleaseInstrument(var Instrument: PSrInstrument); {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}

(*=== File SoundBank (*.dat) =================================================*)

const

  SKBHeaderString = 'SKBANK';
  SKBVersion = $01000000;

  // Rutin Soundbank
  function  Skf_LoadSoundBank(Path: PChar; LoadCount: PLongInt = nil): PSrSoundBank; {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  procedure Skf_ReleaseSoundBank(var SoundBank: PSrSoundBank); {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}
  procedure Skf_LoadSoundBankToBuffer(var Buffer: TALuint; SoundBank: PSrSoundBank; Index: Byte); {$IFDEF SKE_STDCALL}  stdcall; {$ENDIF}

implementation

{$IFDEF SKE_USE_FASTCRC32}
uses ShaCrcUnit;
{$ENDIF}

{$R SRNFDLG.RES}

//==============================================================================

{$IFNDEF SKE_USE_FASTCRC32}
// Algoritma -> http://www.efg2.com/Lab/Mathematics/CRC.htm
procedure CalcCRC32(p: pointer; ByteCount: DWORD; var CRCValue: DWORD);
const
    table:  array[0..255] of cardinal =
   ($00000000, $77073096, $EE0E612C, $990951BA,
    $076DC419, $706AF48F, $E963A535, $9E6495A3,
    $0EDB8832, $79DCB8A4, $E0D5E91E, $97D2D988,
    $09B64C2B, $7EB17CBD, $E7B82D07, $90BF1D91,
    $1DB71064, $6AB020F2, $F3B97148, $84BE41DE,
    $1ADAD47D, $6DDDE4EB, $F4D4B551, $83D385C7,
    $136C9856, $646BA8C0, $FD62F97A, $8A65C9EC,
    $14015C4F, $63066CD9, $FA0F3D63, $8D080DF5,
    $3B6E20C8, $4C69105E, $D56041E4, $A2677172,
    $3C03E4D1, $4B04D447, $D20D85FD, $A50AB56B,
    $35B5A8FA, $42B2986C, $DBBBC9D6, $ACBCF940,
    $32D86CE3, $45DF5C75, $DCD60DCF, $ABD13D59,
    $26D930AC, $51DE003A, $C8D75180, $BFD06116,
    $21B4F4B5, $56B3C423, $CFBA9599, $B8BDA50F,
    $2802B89E, $5F058808, $C60CD9B2, $B10BE924,
    $2F6F7C87, $58684C11, $C1611DAB, $B6662D3D,

    $76DC4190, $01DB7106, $98D220BC, $EFD5102A,
    $71B18589, $06B6B51F, $9FBFE4A5, $E8B8D433,
    $7807C9A2, $0F00F934, $9609A88E, $E10E9818,
    $7F6A0DBB, $086D3D2D, $91646C97, $E6635C01,
    $6B6B51F4, $1C6C6162, $856530D8, $F262004E,
    $6C0695ED, $1B01A57B, $8208F4C1, $F50FC457,
    $65B0D9C6, $12B7E950, $8BBEB8EA, $FCB9887C,
    $62DD1DDF, $15DA2D49, $8CD37CF3, $FBD44C65,
    $4DB26158, $3AB551CE, $A3BC0074, $D4BB30E2,
    $4ADFA541, $3DD895D7, $A4D1C46D, $D3D6F4FB,
    $4369E96A, $346ED9FC, $AD678846, $DA60B8D0,
    $44042D73, $33031DE5, $AA0A4C5F, $DD0D7CC9,
    $5005713C, $270241AA, $BE0B1010, $C90C2086,
    $5768B525, $206F85B3, $B966D409, $CE61E49F,
    $5EDEF90E, $29D9C998, $B0D09822, $C7D7A8B4,
    $59B33D17, $2EB40D81, $B7BD5C3B, $C0BA6CAD,

    $EDB88320, $9ABFB3B6, $03B6E20C, $74B1D29A,
    $EAD54739, $9DD277AF, $04DB2615, $73DC1683,
    $E3630B12, $94643B84, $0D6D6A3E, $7A6A5AA8,
    $E40ECF0B, $9309FF9D, $0A00AE27, $7D079EB1,
    $F00F9344, $8708A3D2, $1E01F268, $6906C2FE,
    $F762575D, $806567CB, $196C3671, $6E6B06E7,
    $FED41B76, $89D32BE0, $10DA7A5A, $67DD4ACC,
    $F9B9DF6F, $8EBEEFF9, $17B7BE43, $60B08ED5,
    $D6D6A3E8, $A1D1937E, $38D8C2C4, $4FDFF252,
    $D1BB67F1, $A6BC5767, $3FB506DD, $48B2364B,
    $D80D2BDA, $AF0A1B4C, $36034AF6, $41047A60,
    $DF60EFC3, $A867DF55, $316E8EEF, $4669BE79,
    $CB61B38C, $BC66831A, $256FD2A0, $5268E236,
    $CC0C7795, $BB0B4703, $220216B9, $5505262F,
    $C5BA3BBE, $B2BD0B28, $2BB45A92, $5CB36A04,
    $C2D7FFA7, $B5D0CF31, $2CD99E8B, $5BDEAE1D,

    $9B64C2B0, $EC63F226, $756AA39C, $026D930A,
    $9C0906A9, $EB0E363F, $72076785, $05005713,
    $95BF4A82, $E2B87A14, $7BB12BAE, $0CB61B38,
    $92D28E9B, $E5D5BE0D, $7CDCEFB7, $0BDBDF21,
    $86D3D2D4, $F1D4E242, $68DDB3F8, $1FDA836E,
    $81BE16CD, $F6B9265B, $6FB077E1, $18B74777,
    $88085AE6, $FF0F6A70, $66063BCA, $11010B5C,
    $8F659EFF, $F862AE69, $616BFFD3, $166CCF45,
    $A00AE278, $D70DD2EE, $4E048354, $3903B3C2,
    $A7672661, $D06016F7, $4969474D, $3E6E77DB,
    $AED16A4A, $D9D65ADC, $40DF0B66, $37D83BF0,
    $A9BCAE53, $DEBB9EC5, $47B2CF7F, $30B5FFE9,
    $BDBDF21C, $CABAC28A, $53B39330, $24B4A3A6,
    $BAD03605, $CDD70693, $54DE5729, $23D967BF,
    $B3667A2E, $C4614AB8, $5D681B02, $2A6F2B94,
    $B40BBE37, $C30C8EA1, $5A05DF1B, $2D02EF8D);

var
  i: CARDINAL;
  q: ^BYTE;
begin
  q := p;
  for i:= 0 to ByteCount-1 do begin
    CRCvalue := (CRCvalue shr 8)  xor
    Table[ q^ xor (CRCvalue and $000000FF) ];
    inc(q)
  end;
end;
{$ENDIF}

//==============================================================================

function Skf_LoadInstrumentFile(Path: PChar): PSrInstrument;
var
  fs: TFileStream;
  hdr: TSKTHeader;
  StructSz: LongWord;
  BeatRoom: LongWord;
  BeatRead: LongWord;
  LBuffer: PChar;
  bread: LongWord;
  CRC32: DWORD;
begin

  Result:= nil;
  CRC32:= $FFFFFFFF;
  fs:= TFileStream.Create(Path, fmOpenRead or fmShareDenyWrite);
  try
    fs.Position:= 0;
    fs.ReadBuffer(hdr, SizeOf(TSKTHeader));
    if (hdr.HeaderString = SKTHeaderString) then
      begin
      if (hdr.Version = SKTVersion) then
        begin
        BeatRoom:= SizeOf(TSKTBeat) * hdr.BeatsCount;
        StructSz:= 4 + SizeOf(TSrInstrumentMemHeader) + BeatRoom;
        GetMem(Result, StructSz);
        ZeroMemory(Result, StructSz);
        try
          Result^.StructSize:= StructSz;
          Result^.Header.BeatsCount:= hdr.BeatsCount;
          Result^.Header.TimeLength:= hdr.TimeLength;
          LBuffer:= @Result^.Data[0];
          BeatRead:= 0;
          bread:= 256;
          while (BeatRead < BeatRoom) do
            begin
            if (BeatRoom-BeatRead < 256) then
              bread:= BeatRoom-BeatRead;
            fs.ReadBuffer(LBuffer^, bread);
            {$IFDEF SKE_USE_FASTCRC32}
            CRC32:= ShaCrcRefresh(CRC32, LBuffer, bread);
            {$ELSE}
            CalcCRC32(LBuffer, bread, CRC32);
            {$ENDIF}
            LBuffer:= Pointer(LongWord(LBuffer) + bread);
            Inc(BeatRead, bread);
          end;
          CRC32:= not CRC32;
          if (hdr.CRC32Checksum <> CRC32) then // Verifikasi CRC32 gagal?
            begin
            FreeMem(Result, StructSz);
            Result:= nil;
            MessageBox(0, PChar(s_SrCRC32Error),
                       PChar(SrneeFileModule), MB_ICONERROR + MB_SETFOREGROUND + MB_TOPMOST);
          end;
        except
          FreeMem(Result, StructSz);
          Result:= nil;
        end;
      end;
    end;
  finally
    fs.Free;
  end;

end;

//==============================================================================

function Skf_SaveInstrumentFile(Path: PChar; Instrument: PSrInstrument): boolean;
var
  fs: TFileStream;
  hdr: TSKTHeader;
  BeatRoom: LongWord;
  BeatWrite: LongWord;
  LBuffer: PChar;
  bwrite: LongWord;
  CRC32: DWORD;
begin

  Result:= TRUE;
  CRC32:= $FFFFFFFF;
  try

    fs:= TFileStream.Create(Path, fmCreate or fmShareDenyWrite);
    try

      fs.Position:= SizeOf(TSKTHeader);
      LBuffer:= @Instrument^.Data[0];
      BeatRoom:= SizeOf(TSKTBeat) * Instrument^.Header.BeatsCount;
      BeatWrite:= 0;
      bwrite:= 256;
      while (BeatWrite < BeatRoom) do
        begin
        if (BeatRoom-BeatWrite < 256) then
          bwrite:= BeatRoom-BeatWrite;
        {$IFDEF SKE_USE_FASTCRC32}
        CRC32:= ShaCrcRefresh(CRC32, LBuffer, bwrite);
        {$ELSE}
        CalcCRC32(LBuffer, bwrite, CRC32);
        {$ENDIF}
        fs.WriteBuffer(LBuffer^, bwrite);
        LBuffer:= Pointer(LongWord(LBuffer) + bwrite);
        Inc(BeatWrite, bwrite);
      end;
      CRC32:= not CRC32;

      // tulis header
      fs.Position:= 0;
      ZeroMemory(@hdr, SizeOf(TSKTHeader));
      hdr.HeaderString:= SKTHeaderString;
      hdr.Version:= SKTVersion;
      hdr.CRC32Checksum:= CRC32;
      hdr.BeatsCount:= Instrument^.Header.BeatsCount;
      hdr.TimeLength:= Instrument^.Header.TimeLength;
      fs.WriteBuffer(hdr, SizeOf(TSKTHeader));

    finally
      fs.Free;
    end;

  except
    Result:= FALSE;
  end;

end;

//==============================================================================

function Skf_NewBlankInstrument: PSrInstrument;
var
  StructSz: LongWord;
begin

  StructSz:= 4 + SizeOf(TSrInstrumentMemHeader);
  GetMem(Result, StructSz);
  ZeroMemory(Result, StructSz);
  Result^.StructSize:= StructSz;

end;

//==============================================================================

procedure Skf_AddBeatToInstrument(var Instrument: PSrInstrument; Time: LongWord; Notes: Byte; Blow: boolean);
var
  NewSize: LongWord;
  NewMem: PSrInstrument;
begin

  // Hitung besar utk memori yg baru, terus alokasi ketempat baru
  NewSize:= Instrument^.StructSize + SizeOf(TSKTBeat);
  GetMem(NewMem, NewSize);
  CopyMemory(NewMem, Instrument, Instrument^.StructSize);
  FreeMem(Instrument, Instrument^.StructSize);

  // Masukan data baru diujung data instrumen
  NewMem^.StructSize:= NewSize;
  NewMem^.Data[NewMem^.Header.BeatsCount].Time:= Time;
  NewMem^.Data[NewMem^.Header.BeatsCount].Notes:= ShortInt(Notes);
  NewMem^.Data[NewMem^.Header.BeatsCount].Blow:= ShortInt(Blow) and 1;
  NewMem^.Header.BeatsCount:= NewMem^.Header.BeatsCount + 1;

  Instrument:= NewMem;

end;

//==============================================================================

procedure Skf_SetInstrumentEndTime(Instrument: PSrInstrument; Time: LongWord);
begin

  // Set waktu berakhir instrumen
  Instrument^.Header.TimeLength:= Time;

end;

//==============================================================================

procedure Skf_ReleaseInstrument(var Instrument: PSrInstrument);
begin

  // Bebaskan instrumen dari memori
  FreeMem(Instrument, Instrument^.StructSize);

end;

//==============================================================================

var
  SbErrList: string;

function Skf_LoadSoundBank(Path: PChar; LoadCount: PLongInt = nil): PSrSoundBank;

  function ErrDlgPrc(hWnd, Msg, wParam, lParam: Integer): Boolean; stdcall;
  var
    wrc: TRect;
    nx, ny: integer;
  begin

    Result:= FALSE;
    case Msg of

      WM_INITDIALOG:
        begin

        GetWindowRect(hWnd, wrc);
        nx:= (GetSystemMetrics(SM_CXFULLSCREEN)-(wrc.Right-wrc.Left)) div 2;
        ny:= (GetSystemMetrics(SM_CYFULLSCREEN)-(wrc.Bottom-wrc.Top)) div 2;
        SetWindowPos(hWnd, 0, nx, ny, 0, 0, SWP_NOSIZE);

        SetDlgItemText(hWnd, 101, PChar(SbErrList));

        Result:= TRUE;

      end;

      WM_COMMAND:
        begin

        if LOWORD(wParam) = IDOK then
          EndDialog(hWnd, IDOK)
        else
        if LOWORD(wParam) = IDCANCEL then
          EndDialog(hWnd, IDCANCEL);
        Result:= TRUE;

      end;

      WM_CLOSE:
        begin

        EndDialog(hWnd, IDCANCEL);
        Result:= TRUE;
        
      end;

    end;

  end;

var
  l: integer;
  sbs: TFileStream;
  hdr: TSKBHeader;
  wavhdr: PWAVHeader;
  fcnt: integer;
  LBuffer: PChar;
  LoadRoom, LoadRead: LongWord;
  bread: LongWord;
  CRC32: DWORD;
begin

  SbErrList:= '';
  GetMem(Result, SizeOf(TSrSoundBank));
  ZeroMemory(Result, SizeOf(TSrSoundBank));
  try
    sbs:= TFileStream.Create(Path, fmOpenRead or fmShareDenyWrite);
    try
      sbs.Position:= 0;
      sbs.ReadBuffer(hdr, SizeOf(TSKBHeader));
      if (hdr.HeaderString = SKBHeaderString) then
        begin
        if (hdr.Version = SKBVersion) then
          begin
          fcnt:= hdr.FileCount;
          for l:= 0 to fcnt do
            begin
            if (LoadCount <> nil) then
              LoadCount^:= l+1;
            CRC32:= $FFFFFFFF;
            Result[l].Size:= hdr.FileNode[l].Size;
            LoadRoom:= hdr.FileNode[l].Size;
            GetMem(Result^[l].Data, Result[l].Size);
            LBuffer:= Result^[l].Data;
            LoadRead:= 0;
            bread:= 256;
            // Pembacaan file
            while (LoadRead < LoadRoom) do
              begin
              if (LoadRoom-LoadRead < 256) then
                bread:= LoadRoom-LoadRead;
              sbs.ReadBuffer(LBuffer^, bread);
              {$IFDEF SKE_USE_FASTCRC32}
              CRC32:= ShaCrcRefresh(CRC32, LBuffer, bread);
              {$ELSE}
              CalcCRC32(LBuffer, bread, CRC32);
              {$ENDIF}
              LBuffer:= Pointer(LongWord(LBuffer) + bread);
              Inc(LoadRead, bread);
            end;
            CRC32:= not CRC32;
            // Mulai membaca properti
            if (hdr.FileNode[l].CRC32 = CRC32) then
              begin
              wavhdr:= Result^[l].Data;
              if (wavhdr^.FormatCode = WAV_STANDARD) then
                begin
                Result^[l].Frequency:= wavhdr^.SampleRate;
                if wavhdr^.ChannelNumber = 1 then
                  case wavhdr^.BitsPerSample of
                    8:  Result[l].Format:= AL_FORMAT_MONO8;
                    16: Result[l].Format:= AL_FORMAT_MONO16;
                  end;
                if wavhdr^.ChannelNumber = 2 then
                  case wavhdr^.BitsPerSample of
                    8:  Result[l].Format:= AL_FORMAT_STEREO8;
                    16: Result[l].Format:= AL_FORMAT_STEREO16;
                  end;
                Result^[l].BufData:= Pointer(LongWord(Result^[l].Data) + SizeOf(TWAVHeader));
                Result^[l].BufSize:= wavhdr^.DataSize;
              end
              else
                SbErrList:= SbErrList + Format(s_SrSbnkWavUnsp, [l]) + #13#10;
            end
            else
              begin
              SbErrList:= SbErrList + Format(s_SrSbnkCRC32Er, [l]) + #13#10;
            end;
          end;
          if (SbErrList <> '') then
            if DialogBox(HInstance, PChar('DLG_SBERR'), 0, @ErrDlgPrc) = IDOK then
              ExitProcess(0);
        end;
      end;
    finally
      sbs.Free;
    end;
  except
    FreeMem(Result, SizeOf(TSrSoundBank));
    Result:= nil;
  end;

end;

//==============================================================================

procedure Skf_ReleaseSoundBank(var SoundBank: PSrSoundBank);
var
  l: integer;
begin

  // Bebaskan satu persatu sound yang telah dimuat, terus bebaskan juga contextnya
  for l:= 0 to 255 do
    with SoundBank^[l] do
      if (Data <> nil) then
        FreeMem(Data, Size);
  FreeMem(SoundBank, SizeOf(TSrSoundBank));

end;

//==============================================================================

procedure Skf_LoadSoundBankToBuffer(var Buffer: TALuint; SoundBank: PSrSoundBank; Index: Byte);
begin

  with SoundBank^[Index] do
    AlBufferData(Buffer, Format, BufData, BufSize, Frequency);

end;

//==============================================================================

end.
