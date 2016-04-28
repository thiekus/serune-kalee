unit uMain;

(*==============================================================================

  Serune Kalee Main User Interface (MainUI)
  Copyright © Revolven Technologies
  Coded by Faris Khowarizmi 2014

==============================================================================*)

interface

{$I SeruneConf.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, ComCtrls, PngImage, ImgList, ActnList,
  ShellAPI, CommCtrl, IniFiles, DirectInput, AppConst, AppStrings, KeybdConst,
  // Serune Kalee modules
  SrneeConst, SrneeTypes,
  {$IFDEF SKE_USE_DYNLIB}
  SrneeProcs
  {$ELSE}
  SrneeCore, SrneeAudio
  {$ENDIF};

type
  TTombolStat = (tblIdle, tblPush);
  TTombol = record
    Aktif: boolean;
    Area: TRect;
    Ditekan: boolean;
    Ditahan: boolean;
    Objek: array[0..1] of TPNGObject;
  end;
  TMenuTheme = record
    DefGradientBegin  : TColor;
    DefGradientEnd    : TColor;
    SelGradientBegin  : TColor;
    SelGradientEnd    : TColor;
    TextColor         : TColor;
    TextDisabledColor : TColor;
    TextShadowColor   : TColor;
    SeparatorColor    : TColor;
  end;

type
  TfrmMain = class(TForm)
    pmMenu: TPopupMenu;
    sBar: TStatusBar;
    pMain: TPanel;
    entang1: TMenuItem;
    Keluar1: TMenuItem;
    N1: TMenuItem;
    pbxUI: TPaintBox;
    trbVol: TTrackBar;
    pbMenu: TPaintBox;
    pbRekam: TPaintBox;
    pbPlay: TPaintBox;
    PaintBox4: TPaintBox;
    pbStop: TPaintBox;
    pbDraw: TPaintBox;
    s1: TShape;
    s2: TShape;
    s3: TShape;
    s4: TShape;
    s5: TShape;
    s6: TShape;
    s7: TShape;
    s0: TShape;
    l1: TLabel;
    l2: TLabel;
    l3: TLabel;
    l4: TLabel;
    l5: TLabel;
    l6: TLabel;
    l7: TLabel;
    l0: TLabel;
    pbSr: TPaintBox;
    actLst: TActionList;
    Bantuandandokumentasi1: TMenuItem;
    Preferensi1: TMenuItem;
    N2: TMenuItem;
    ampilkannomorlubang1: TMenuItem;
    N3: TMenuItem;
    ampilkandaftartombolkeyboard1: TMenuItem;
    Rekam1: TMenuItem;
    N4: TMenuItem;
    MulaiJeda1: TMenuItem;
    Hentikan1: TMenuItem;
    N5: TMenuItem;
    Bukafileinstrumen1: TMenuItem;
    Aturmasukankeyboard1: TMenuItem;
    actRekam: TAction;
    actPlayPause: TAction;
    actStop: TAction;
    actOpenIns: TAction;
    vwNum: TAction;
    vwListKey: TAction;
    prfInp: TAction;
    prfPrf: TAction;
    actHelp: TAction;
    actAbt: TAction;
    actExit: TAction;
    cbxNb: TCheckBox;
    lblNb: TLabel;
    Label1: TLabel;
    CheckBox2: TCheckBox;
    Label2: TLabel;
    odlg: TOpenDialog;
    sdlg: TSaveDialog;
    imgLst: TImageList;
    vwPin: TAction;
    ampilkanjendelaselaludiatas1: TMenuItem;
    CheckBox3: TCheckBox;
    Label3: TLabel;
    lblTimec: TLabel;
    pbProg: TProgressBar;
    tmrTupd: TTimer;
    lh0: TLabel;
    lh1: TLabel;
    lh2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lh5: TLabel;
    lh4: TLabel;
    lh3: TLabel;
    lhb: TLabel;
    lh7: TLabel;
    lh6: TLabel;
    lblCaplh: TLabel;
    Image1: TImage;
    tmrKy: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure pbxUIPaint(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pbxUIMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbxUIMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbxUIClick(Sender: TObject);
    procedure trbVolChange(Sender: TObject);
    procedure pbxUIMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure actExitExecute(Sender: TObject);
    procedure actAbtExecute(Sender: TObject);
    procedure prfInpExecute(Sender: TObject);
    procedure actOpenInsExecute(Sender: TObject);
    procedure vwListKeyExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure prfPrfExecute(Sender: TObject);
    procedure vwNumExecute(Sender: TObject);
    procedure vwPinExecute(Sender: TObject);
    procedure actRekamExecute(Sender: TObject);
    procedure actPlayPauseExecute(Sender: TObject);
    procedure actStopExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure tmrTupdTimer(Sender: TObject);
    procedure tmrKyTimer(Sender: TObject);
  private
    { Private declarations }

    ThemeName: string;
    ThemeDir: string;
    MenuColor: TMenuTheme;
    MenuIcons: array[0..9] of TPngObject;
    BackgroundBase: TBitmap;

    // Tombol 0: Menu
    // Tombol 1: Rekam
    // Tombol 2: Play/Pause
    // Tombol 3: Stop
    Tombols: array[0..3] of TTombol;

    //
    SrneeImg: TPngObject;
    SrneeRct: TRect;

    GakDisimpan: boolean;
    KeluarNo: boolean;

    procedure EventCallback(Event: TSrPlayEvent; Param: PChar);
    procedure TahanLabel(Sender: TObject; Button: TMouseButton;
                            Shift: TShiftState; X, Y: Integer);
    procedure LepasLabel(Sender: TObject; Button: TMouseButton;
                           Shift: TShiftState; X, Y: Integer);
    procedure GambarItemMenu(Sender: TObject; ACanvas: TCanvas;
                             ARect: TRect; Selected: Boolean);


  public
    { Public declarations }

    AppVerStr: string;
    SrneeInfo: PSrInfo;

    procedure MuatUlangBackground(ListKey: boolean);
    procedure MuatTema(NamaTema: string);
    procedure BacaPengaturan;
    procedure TampilkanMenu;
    procedure TampilkanDaftarKey(Nyala: boolean);
    function  PosisiDiDalam(Area: TRect; X, Y: integer): boolean;
    procedure GambarTombol(idx: integer);
    procedure SetVolume(Vol: integer);
    procedure SetPlayModeStatus(ModeStr: string);
    procedure SetMainCaption(SubCapStr: string);
    procedure SetTombolAktif(Index: integer; Aktif: boolean);
    function  PeringatanBelumSave: boolean;
    function  PeringatanBelumSaveRk: boolean;

  end;

var
  frmMain: TfrmMain;

implementation

uses Tambahan, uAbout, uKeySet, uPref, uSplash;

{$R *.dfm}
{$R Icnrs.RES}

//==============================================================================

procedure SBLoadProg(num: integer); {$IFDEF MSWINDOWS}  stdcall; {$ENDIF}
begin

  if (num > 0) then
    UpdateSplashLabel(Format(s_InitSbprg, [num, 256]))
  else
    UpdateSplashLabel(s_InitCoref);

end;

//==============================================================================

procedure TfrmMain.EventCallback(Event: TSrPlayEvent; Param: PChar);
var
  Note: LongInt;
  //Ditiup: boolean;
begin

  case Event of

    //==========================================================================
    // Event Ketika permainan bebas dimulai
    peLiveBegin:
      begin

        lblTimec.Hide;
        pbProg.Position:= 0;
        
        pbxUI.Canvas.Lock;
        try
          SetTombolAktif(1, TRUE);
          SetTombolAktif(2, TRUE);
          SetTombolAktif(3, FALSE);
        finally
          pbxUI.Canvas.Unlock;
        end;
        SetPlayModeStatus(s_PlayLive);

    end;

    //==========================================================================
    // Event ketika perekaman dimulai
    peRecordBegin:
      begin

        lblTimec.Show;
        Tombols[1].Ditahan:= TRUE;

        actOpenIns.Enabled:= FALSE;
        pbxUI.Canvas.Lock;
        try
          SetTombolAktif(1, FALSE);
          SetTombolAktif(2, FALSE);
          SetTombolAktif(3, TRUE);
        finally
          pbxUI.Canvas.Unlock;
        end;
        SetPlayModeStatus(s_PlayRecd);
        SetMainCaption(Format('(%s)', [s_PlayRecd]));

        tmrTupd.Enabled:= TRUE;
        GakDisimpan:= TRUE;

    end;

    //==========================================================================
    // Event ketika dipause
    pePauseBegin:
      begin

        SetPlayModeStatus(s_PlayPause);
        tmrTupd.Enabled:= TRUE;

    end;

    //==========================================================================
    // Event ketika mulai pemutaran balik
    pePlaybackBegin:
      begin

        lblTimec.Show;
        Tombols[2].Ditahan:= TRUE;

        actOpenIns.Enabled:= FALSE;
        pbxUI.Canvas.Lock;
        try
          SetTombolAktif(1, FALSE);
          SetTombolAktif(2, TRUE);
          SetTombolAktif(3, TRUE);
        finally
          pbxUI.Canvas.Unlock;
        end;
        SetPlayModeStatus(s_PlayPlayb);

        tmrTupd.Enabled:= TRUE;

    end;

    //==========================================================================
    // Event ketika permainan langsung berakhir
    peLiveEnd:
      begin

        // tidak ada yang dikerjakan... disisakan buat kapan2

    end;

    //==========================================================================
    // Event ketika perekaman berakhir
    peRecordEnd:
      begin

        tmrTupd.Enabled:= FALSE;
        Tombols[1].Ditahan:= FALSE;
        GambarTombol(1);
        actOpenIns.Enabled:= TRUE;

        SetMainCaption(Format('(%s)', [s_NotSaved]));
        if sdlg.Execute then
          Skp_SaveInstrumentFile(SrneeInfo, PChar(sdlg.FileName))

    end;

    //==========================================================================
    // Event ketika berhenti dijeda
    pePauseEnd:
      begin

        tmrTupd.Enabled:= FALSE;

    end;

    //==========================================================================
    // Event ketika pemutaran dihentikan
    pePlaybackEnd:
      begin

        tmrTupd.Enabled:= FALSE;
        Tombols[2].Ditahan:= FALSE;
        GambarTombol(2);
        actOpenIns.Enabled:= TRUE;

    end;

    //==========================================================================
    // Event ketika file instrumen berhasil diload
    peLoaded:
      begin

        GakDisimpan:= FALSE;
        if (Param <> nil) then
          SetMainCaption(ExtractFileName(Param))
        else
          SetMainCaption('');

    end;

    //==========================================================================
    // Event ketika file instrumen selesai disave
    peSaved:
      begin

        GakDisimpan:= FALSE;
        if (Param <> nil) then
          SetMainCaption(ExtractFileName(Param))
        else
          SetMainCaption('');

    end;

    //==========================================================================
    // Event ketika adanya masukan baru dengan nada baru
    peNotesUpdate:
      begin

        Note:= PSkpNoteInfo(Param).Notes;
        //Ditiup:= Boolean(PSkpNoteInfo(Param).Blowed and 1);

        (*s0.Visible:= Boolean(Note and 128);
        s1.Visible:= Boolean(Note and 64);
        s2.Visible:= Boolean(Note and 32);
        s3.Visible:= Boolean(Note and 16);
        s4.Visible:= Boolean(Note and 8);
        s5.Visible:= Boolean(Note and 4);
        s6.Visible:= Boolean(Note and 2);
        s7.Visible:= Boolean(Note and 1);*)

        l0.Font.Color:= LongWord($00241dbe * (Note and 128 div 128));
        l1.Font.Color:= LongWord($00241dbe * (Note and 64 div 64));
        l2.Font.Color:= LongWord($00241dbe * (Note and 32 div 32));
        l3.Font.Color:= LongWord($00241dbe * (Note and 16 div 16));
        l4.Font.Color:= LongWord($00241dbe * (Note and 8 div 8));
        l5.Font.Color:= LongWord($00241dbe * (Note and 4 div 4));
        l6.Font.Color:= LongWord($00241dbe * (Note and 2 div 2));
        l7.Font.Color:= LongWord($00241dbe * (Note and 1 div 1));

        l0.Update;
        l1.Update;
        l2.Update;
        l3.Update;
        l4.Update;
        l5.Update;
        l6.Update;
        l7.Update;

        //sbnyi.Visible:= Ditiup;

    end;

    //==========================================================================
    // Event ketika adanya masukan baru dengan nada baru
    peExitThread:
      begin

        // tidak ada yang dikerjakan... disisakan buat kapan2

    end;

  end;

end;

procedure ECbackBridge(Event: TSrPlayEvent; Param: PChar); {$IFDEF MSWINDOWS}  stdcall; {$ENDIF}
begin

  frmMain.EventCallback(Event, Param);

end;

//==============================================================================

procedure TfrmMain.TahanLabel(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  Skp_ToggleNoteState(SrneeInfo, StrToInt(TLabel(Sender).Caption), TRUE);

end;

//==============================================================================

procedure TfrmMain.LepasLabel(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  Skp_ToggleNoteState(SrneeInfo, StrToInt(TLabel(Sender).Caption), FALSE);

end;

//==============================================================================

procedure TfrmMain.GambarItemMenu(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
var
  MenuAktif: boolean;
  Pemisah: boolean;
  RataAtas: integer;
  CapStr: string;
  SCut: string;
  SCutW: integer;
begin

  MenuAktif:= TMenuItem(Sender).Enabled;
  Pemisah:= TMenuItem(Sender).Caption = '-';
  RataAtas:= ARect.Top + ((ARect.Bottom-ARect.Top) div 2);

  ACanvas.Lock;
  try

    ACanvas.Pen.Style:= psSolid;
    if (Selected) and (MenuAktif) then // Item dipilih dan aktif
      begin
      DrawGradient(MenuColor.SelGradientBegin, MenuColor.SelGradientEnd, ACanvas, ARect);
      ACanvas.Pen.Color:= clBlack;
      ACanvas.Brush.Style:= bsClear;
      ACanvas.Rectangle(ARect);
    end
    else
      // Item biasa
      DrawGradient(MenuColor.DefGradientBegin, MenuColor.DefGradientEnd, ACanvas, ARect);

    if (Pemisah) then
      begin
      // Buat garis separator
      ACanvas.Pen.Color:= clSilver;
      ACanvas.MoveTo(ARect.Left+2, RataAtas);
      ACanvas.LineTo(ARect.Right-2, RataAtas);
    end
    else
      begin

      // Gambarkan Icon
      if (TMenuItem(Sender).ImageIndex >= 0) then
        ACanvas.Draw(2, ARect.Top+1, MenuIcons[TMenuItem(Sender).ImageIndex]);
      if (TMenuItem(Sender).Checked) then
        ACanvas.Draw(2, ARect.Top+1, MenuIcons[9]);

      CapStr:= StringReplace(TMenuItem(Sender).Caption, '&', '', [rfReplaceAll]);
      SCut:= ShortCutToText(TMenuItem(Sender).ShortCut);
      SCutW:= ACanvas.TextWidth(SCut);
      ACanvas.Brush.Style:= bsClear;
      ACanvas.Font.Color:= MenuColor.TextShadowColor;

      // Buat bayangan pada teks
      ACanvas.TextOut(ARect.Left+21, ARect.Top+3, CapStr);
      if (SCut <> '') then
        ACanvas.TextOut(ARect.Right-SCutW-5, ARect.Top+3, SCut);
      if (MenuAktif) then
        ACanvas.Font.Color:= MenuColor.TextColor
      else
        ACanvas.Font.Color:= MenuColor.TextDisabledColor;

      // Gambarkan teks asli
      ACanvas.TextOut(ARect.Left+20, ARect.Top+2, CapStr);
      if (SCut <> '') then
        ACanvas.TextOut(ARect.Right-SCutW-6, ARect.Top+2, SCut);
      
    end;

    // Tampilkan hints
    if (Selected) and (MenuAktif) then
      sBar.Panels[2].Text:= TMenuItem(Sender).Hint;

  finally
    ACanvas.Unlock;
  end;

end;

//==============================================================================

procedure TfrmMain.MuatUlangBackground(ListKey: boolean);
var
  BackPng: TPngObject;
begin

  if (BackgroundBase <> nil) then
    BackgroundBase.Free;
  BackgroundBase:= TBitmap.Create;
  BackPng:= TPngObject.Create;
  try
    BackPng.LoadFromFile(ThemeDir + 'mainbg.png');
    BackPng.Canvas.Lock;
    try
      BackPng.Canvas.Draw(SrneeRct.Left, SrneeRct.Top, SrneeImg);
      //if (ListKey) then
    finally
      BackPng.Canvas.Unlock;
    end;
    BackgroundBase.Assign(BackPng);
    BackgroundBase.PixelFormat:= pf24Bit;
  finally
    BackPng.Free;
  end;

end;

//==============================================================================

procedure TfrmMain.MuatTema(NamaTema: string);
var
  //themedir: string;
  uidef_s: string;
  uidef: TIniFile;
  l: integer;
begin

  ThemeName:= NamaTema;
  ThemeDir:= ExtractFilePath(ParamStr(0))+'Themes\'+NamaTema+'\';
  uidef_s:= themedir + 'UIDef.ini';

  if DirectoryExists(ThemeDir) then
    begin
    if FileExists(uidef_s) then
      begin
      uidef:= TIniFile.Create(uidef_s);
      try
        MenuColor.DefGradientBegin:= SwapToBGRA(uidef.ReadInteger('Menu', 'DefGradientBegin', 0));
        MenuColor.DefGradientEnd:= SwapToBGRA(uidef.ReadInteger('Menu', 'DefGradientEnd', 0));
        MenuColor.SelGradientBegin:= SwapToBGRA(uidef.ReadInteger('Menu', 'SelGradientBegin', 0));
        MenuColor.SelGradientEnd:= SwapToBGRA(uidef.ReadInteger('Menu', 'SelGradientEnd', 0));
        MenuColor.TextColor:= SwapToBGRA(uidef.ReadInteger('Menu', 'TextColor', 0));
        MenuColor.TextDisabledColor:= SwapToBGRA(uidef.ReadInteger('Menu', 'TextDisabledColor', 0));
        MenuColor.TextShadowColor:= SwapToBGRA(uidef.ReadInteger('Menu', 'TextShadowColor', 0));
        MenuColor.SeparatorColor:= SwapToBGRA(uidef.ReadInteger('Menu', 'SeparatorColor', 0));
      finally
        uidef.Free;
      end;
      MuatUlangBackground(vwListKey.Checked);
      for l:= 0 to 3 do
        with Tombols[l] do
          begin
          if (Objek[0] <> nil) then
            Objek[0].Free;
          Objek[0]:= TPNGObject.Create;
          Objek[0].LoadFromFile(ThemeDir + Format(btn_file[l], ['def']));
          if (Objek[1] <> nil) then
            Objek[1].Free;
          Objek[1]:= TPNGObject.Create;
          Objek[1].LoadFromFile(ThemeDir + Format(btn_file[l], ['down']));
        end;
    end;
  end;
  
end;

//==============================================================================

procedure TfrmMain.BacaPengaturan;
var
  ini: TIniFile;
  NewTheme: string;
  l: integer;
  dmode: boolean;
  guidvar: TGUID;
begin

  ini:= TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try

    // Nomor lubang
    vwNum.Checked:= ini.ReadBool('Main', 'ShowHoleNumber', TRUE);
    l0.Visible:= vwNum.Checked;
    l1.Visible:= vwNum.Checked;
    l2.Visible:= vwNum.Checked;
    l3.Visible:= vwNum.Checked;
    l4.Visible:= vwNum.Checked;
    l5.Visible:= vwNum.Checked;
    l6.Visible:= vwNum.Checked;
    l7.Visible:= vwNum.Checked;

    // Daftar tombol keyboard
    vwListKey.Checked:= ini.ReadBool('Main', 'ShowKeyList', TRUE);
    TampilkanDaftarKey(vwListKey.Checked);

    // Set form selalu diatas atau gak
    vwPin.Checked:= ini.ReadBool('Main', 'AlwaysOnTop', FALSE);

    // Tema tampilan program
    NewTheme:= ini.ReadString('Preferences', 'ApplyTheme', 'Emas Klasik');
    // Modus langsung
    dmode:= ini.ReadBool('Preferences', 'DirectMode', FALSE);
    Skp_SetPlayerProperty(SrneeInfo, SKP_PROP_DIRECT_MODE, LongInt(dmode));
    // Update status modus input
    if dmode then
      sBar.Panels[1].Text:= s_ModeDirect
    else
      sBar.Panels[1].Text:= s_ModeNormal;

    // "Toggle" buat tombol kombinasi
    Skp_SetPlayerProperty(SrneeInfo, SKP_PROP_KEY_COMBINATION, LongInt(ini.ReadBool('Preferences', 'UseCombinationKey', TRUE)));

    // Load pengaturan tombol keyboard
    Skp_SetKeyboardKey(SrneeInfo, SK_AKEY_BLOW, 0, ini.ReadInteger('Keys', 'Keyboard.Blow', Def_KbdBlw));
    for l:= 0 to LubangSerune do
      Skp_SetKeyboardKey(SrneeInfo, SK_AKEY_HOLE, l, ini.ReadInteger('Keys', Format('Keyboard.Hole%d', [l]), Def_KbdKey[l]));

    Skp_SetKeyboardKey(SrneeInfo, SK_AKEY_COMBINATION, 0, ini.ReadInteger('Keys', 'Keyboard.Cmb01', Def_KbdCmbKey[0]));
    Skp_SetKeyboardKey(SrneeInfo, SK_AKEY_COMBINATION, 1, ini.ReadInteger('Keys', 'Keyboard.Cmb12', Def_KbdCmbKey[1]));
    Skp_SetKeyboardKey(SrneeInfo, SK_AKEY_COMBINATION, 2, ini.ReadInteger('Keys', 'Keyboard.Cmb23', Def_KbdCmbKey[2]));
    Skp_SetKeyboardKey(SrneeInfo, SK_AKEY_COMBINATION, 3, ini.ReadInteger('Keys', 'Keyboard.Cmb34', Def_KbdCmbKey[3]));
    Skp_SetKeyboardKey(SrneeInfo, SK_AKEY_COMBINATION, 4, ini.ReadInteger('Keys', 'Keyboard.Cmb45', Def_KbdCmbKey[4]));
    Skp_SetKeyboardKey(SrneeInfo, SK_AKEY_COMBINATION, 5, ini.ReadInteger('Keys', 'Keyboard.Cmb56', Def_KbdCmbKey[5]));
    Skp_SetKeyboardKey(SrneeInfo, SK_AKEY_COMBINATION, 6, ini.ReadInteger('Keys', 'Keyboard.Cmb67', Def_KbdCmbKey[6]));

    // Load pengaturan joystick
    try
      guidvar:= StringToGUID(ini.ReadString('Keys', 'GameController.DeviceGUID', '{00000000-0000-0000-0000-000000000000}'));
    except
      guidvar:= NullGUID;
    end;
    Skp_SetPlayerProperty(SrneeInfo, SKP_PROP_GAMECTRL_GUID, LongInt(@guidvar));
    Skp_SetPlayerProperty(SrneeInfo, SKP_PROP_GAMECTRL_USE, LongInt(ini.ReadBool('Keys', 'GameController.Enable', FALSE)));
    Skp_SetGameCtrlKey(SrneeInfo, SK_AKEY_BLOW, 0, ini.ReadInteger('Keys', 'GameController.Blow', Def_GCtBlw));
    for l:= 0 to LubangSerune do
      Skp_SetGameCtrlKey(SrneeInfo, SK_AKEY_HOLE, l, ini.ReadInteger('Keys', Format('GameController.Hole%d', [l]), Def_GCtKey[l]));

    // Hint dimuat menurut konfigurasi kunci yang baru
    lh0.Caption:= Format(s_HintHole, [0, SKeyboardKeys[GetKeybdIndex(Skp_GetKeyboardKey(SrneeInfo, SK_AKEY_HOLE, 0))].Name]);
    lh1.Caption:= Format(s_HintHole, [1, SKeyboardKeys[GetKeybdIndex(Skp_GetKeyboardKey(SrneeInfo, SK_AKEY_HOLE, 1))].Name]);
    lh2.Caption:= Format(s_HintHole, [2, SKeyboardKeys[GetKeybdIndex(Skp_GetKeyboardKey(SrneeInfo, SK_AKEY_HOLE, 2))].Name]);
    lh3.Caption:= Format(s_HintHole, [3, SKeyboardKeys[GetKeybdIndex(Skp_GetKeyboardKey(SrneeInfo, SK_AKEY_HOLE, 3))].Name]);
    lh4.Caption:= Format(s_HintHole, [4, SKeyboardKeys[GetKeybdIndex(Skp_GetKeyboardKey(SrneeInfo, SK_AKEY_HOLE, 4))].Name]);
    lh5.Caption:= Format(s_HintHole, [5, SKeyboardKeys[GetKeybdIndex(Skp_GetKeyboardKey(SrneeInfo, SK_AKEY_HOLE, 5))].Name]);
    lh6.Caption:= Format(s_HintHole, [6, SKeyboardKeys[GetKeybdIndex(Skp_GetKeyboardKey(SrneeInfo, SK_AKEY_HOLE, 6))].Name]);
    lh7.Caption:= Format(s_HintHole, [7, SKeyboardKeys[GetKeybdIndex(Skp_GetKeyboardKey(SrneeInfo, SK_AKEY_HOLE, 7))].Name]);

    lhb.Caption:= Format(s_HintBlow, [SKeyboardKeys[GetKeybdIndex(Skp_GetKeyboardKey(SrneeInfo, SK_AKEY_BLOW, 0))].Name]);

    // Muat tema, diload ulang hanya jika nama tema berganti
    if (NewTheme <> ThemeName) then
      MuatTema(NewTheme);

  finally
    ini.Free;
  end;

end;

//==============================================================================

procedure TfrmMain.TampilkanMenu;
var
  mspos: TPoint;
begin

  mspos.X:= Self.Left + GetSystemMetrics(SM_CXDLGFRAME) + pMain.BevelWidth + pbMenu.Left;
  mspos.Y:= Self.Top + GetSystemMetrics(SM_CYCAPTION) + GetSystemMetrics(SM_CXDLGFRAME)+ pMain.BevelWidth + pbMenu.Top + pbMenu.Height;
  pmMenu.Popup(mspos.X, mspos.Y);

end;

//==============================================================================

procedure TfrmMain.TampilkanDaftarKey(Nyala: boolean);
begin

  lblCaplh.Visible:= Nyala;

  lh0.Visible:= Nyala;
  lh1.Visible:= Nyala;
  lh2.Visible:= Nyala;
  lh3.Visible:= Nyala;
  lh4.Visible:= Nyala;
  lh5.Visible:= Nyala;
  lh6.Visible:= Nyala;
  lh7.Visible:= Nyala;
  lhb.Visible:= Nyala;

end;

//==============================================================================

function TfrmMain.PosisiDiDalam(Area: TRect; X, Y: integer): boolean;
begin

  Result:= (X >= Area.Left) and (X <= Area.Left+Area.Right)
           and (Y >= Area.Top) and (Y <= Area.Top+Area.Bottom);
           
end;

//==============================================================================

procedure TfrmMain.GambarTombol(idx: integer);
begin

  pbxUI.Canvas.Draw(Tombols[idx].Area.Left, Tombols[idx].Area.Top, Tombols[idx].Objek[integer(Tombols[idx].Ditekan or Tombols[idx].Ditahan)]);

end;

//==============================================================================

procedure TfrmMain.SetVolume(Vol: integer);
begin

  Skp_SetPlayerProperty(SrneeInfo, SKP_PROP_PLAY_VOLUME, Vol);
  sBar.Panels[0].Text:= Format('Volume: %d%%', [Vol]);
  sBar.Update;

end;

//==============================================================================

procedure TfrmMain.SetPlayModeStatus(ModeStr: string);
begin

  sBar.Panels[3].Text:= ModeStr;
  sBar.Update;

end;

//==============================================================================

procedure TfrmMain.SetMainCaption(SubCapStr: string);
begin

  if (SubCapStr <> '') then
    Caption:= Format('%s - %s', [AppName, SubCapStr])
  else
    Caption:= AppName;
  PostMessage(Handle, WM_NCACTIVATE, Integer(TRUE), 0);

end;

//==============================================================================

procedure TfrmMain.SetTombolAktif(Index: integer; Aktif: boolean);
begin

  case Index of
    1: actRekam.Enabled:= Aktif;
    2: actPlayPause.Enabled:= Aktif;
    3: actStop.Enabled:= Aktif;
  end;
  Tombols[Index].Aktif:= Aktif;
  GambarTombol(Index);

end;

//==============================================================================

function TfrmMain.PeringatanBelumSave: boolean;
begin
  if (GakDisimpan) then
    begin
    Result:= TRUE;
    case MessageBox(Handle, PChar(s_NotSavedQuest), PChar(s_Warning), MB_ICONQUESTION + MB_YESNOCANCEL) of
      IDYES:
        begin
        if sdlg.Execute then
          Skp_SaveInstrumentFile(SrneeInfo, PChar(sdlg.FileName));
      end;
      IDNO: Result:= FALSE;
    end;
  end
  else
    Result:= TRUE;
end;

//==============================================================================

function TfrmMain.PeringatanBelumSaveRk: boolean;
begin
  if (GakDisimpan) then
    begin
    Result:= TRUE;
    case MessageBox(Handle, PChar(s_NotSavedQuest), PChar(s_Warning), MB_ICONQUESTION + MB_YESNOCANCEL) of
      IDYES:
        begin
        if sdlg.Execute then
          Skp_SaveInstrumentFile(SrneeInfo, PChar(sdlg.FileName));
      end;
      IDCANCEL: Result:= FALSE;
    end;
  end
  else
    Result:= TRUE;
end;

//==============================================================================

procedure TfrmMain.FormShow(Sender: TObject);
begin

  ClientWidth:= ScreenWSize + pMain.BevelWidth*2;
  ClientHeight:= ScreenHSize + sBar.Height + pMain.BevelWidth*2;
  Left:= (Screen.WorkAreaWidth-Width) div 2;
  Top:= (Screen.WorkAreaHeight-Height) div 2;
  pMain.SetFocus;
  Skp_SetPlayerProperty(SrneeInfo, SKP_PROP_PARENT_OWNER, Self.Handle);

  //debug
  //pMain.Caption:= Format('w %d, h %d', [pbxUI.Width, pbxUI.Height]);

end;

//==============================================================================

procedure TfrmMain.FormCreate(Sender: TObject);

  function AmbilLokasi(Objek: TControl): TRect;
  begin
    Result:= Objek.ClientRect;
    Result.Left:= Objek.Left;
    Result.Top:= Objek.Top;
    Result.Right:= Objek.Width;
    Result.Bottom:= Objek.Height;
  end;

var
  l: integer;
  dev: integer;
  dvini: TIniFile;
  ShFilePth: string;
begin

  {$IFDEF SKE_USE_DYNLIB}
  SeruneKaleeInit;
  {$ENDIF}

  Caption:= AppName;
  AppVerStr:= Format('%s - version %s', [AppName, GetAppVer]);
  sBar.Panels[2].Text:= AppVerStr;
  DisableScalingForm(Self);

  // Setup awal
  UpdateSplashLabel(s_InitCore);
  // cari index device
  dvini:= TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try
    dev:= Ska_GetIndexOfDevice(PChar(dvini.ReadString('Preferences', 'SelectedSoundDevice', '')));
    if dev < 0 then
      dev:= 0;
  finally
    dvini.Free;
  end;
  Skp_SetupPlayer(SrneeInfo, Handle, dev, PChar(ExtractFilePath(ParamStr(0)) + 'SKBank.dat'), @SBLoadProg);
  Skp_SetPlayerEventCallback(SrneeInfo, @ECbackBridge);

  // Untuk hint key list dan gambar serunee utama
  SrneeImg:= TPngObject.Create;
  SrneeImg.LoadFromResourceName(HInstance, 'SK_IDLE');
  SrneeRct:= AmbilLokasi(pbSr);

  ThemeName:= '';
  BacaPengaturan;

  UpdateSplashLabel(s_InitUIMan);
  l0.OnMouseDown:= TahanLabel;
  l1.OnMouseDown:= TahanLabel;
  l2.OnMouseDown:= TahanLabel;
  l3.OnMouseDown:= TahanLabel;
  l4.OnMouseDown:= TahanLabel;
  l5.OnMouseDown:= TahanLabel;
  l6.OnMouseDown:= TahanLabel;
  l7.OnMouseDown:= TahanLabel;

  l0.OnMouseUp:= LepasLabel;
  l1.OnMouseUp:= LepasLabel;
  l2.OnMouseUp:= LepasLabel;
  l3.OnMouseUp:= LepasLabel;
  l4.OnMouseUp:= LepasLabel;
  l5.OnMouseUp:= LepasLabel;
  l6.OnMouseUp:= LepasLabel;
  l7.OnMouseUp:= LepasLabel;

  for l:= 0 to pmMenu.Items.Count-1 do
    pmMenu.Items[l].OnDrawItem:= GambarItemMenu;

  // Taruh progressbar ke statusbar
  TControl(pbProg).Parent:= sBar;

  // Set double buffer untuk menghindari flickering
  pMain.DoubleBuffered:= TRUE;
  sBar.DoubleBuffered:= TRUE;
  pmMenu.MenuAnimation:= [maLeftToRight, maToptoBottom];

  for l:= 0 to 3 do
    with Tombols[l] do
      begin
      Aktif:= l < 3;
      Ditekan:= FALSE;
      Ditahan:= FALSE;
      case l of
        0: Area:= AmbilLokasi(pbMenu);
        1: Area:= AmbilLokasi(pbRekam);
        2: Area:= AmbilLokasi(pbPlay);
        3: Area:= AmbilLokasi(pbStop);
      end;
    end;

  // muat icon menu
  for l:= 0 to 9 do
    begin
    MenuIcons[l]:= TPngObject.Create;
    MenuIcons[l].LoadFromResourceName(HInstance, Format('MICO_%.2d', [l]));
  end;

  // Set form diatas atau gak
  if (vwPin.Checked) then
    Self.FormStyle:= fsStayOnTop
  else
    Self.FormStyle:= fsNormal;

  // Untuk saat ini gak ada file yang perlu disimpan
  GakDisimpan:= FALSE;

  // Kalo ada file dibuka langsung dengan klik filenya, buka aja...
  if (ParamCount > 0) then
    begin
    ShFilePth:= ParamStr(1);
    if FileExists(ShFilePth) then
      Skp_OpenInstrumentFile(SrneeInfo, PChar(ShFilePth));
  end;
  
end;

//==============================================================================

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ini: TIniFile;
begin

  // Ketika program ditutup
  ini:= TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try

    ini.WriteBool('Main', 'ShowHoleNumber', vwNum.Checked);
    ini.WriteBool('Main', 'ShowKeyList', vwListKey.Checked);
    ini.WriteBool('Main', 'AlwaysOnTop', vwPin.Checked);

  finally
    ini.Free;
  end;

end;

//==============================================================================

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  x: integer;
begin

  // Deinisialisasi program
  Skp_ExitPlayer(SrneeInfo);
  {$IFDEF SKE_USE_DYNLIB}
  SeruneKaleeDeInit;
  {$ENDIF}
  for x:= 0 to 9 do
    MenuIcons[x].Free;
  BackgroundBase.Free;
  SrneeImg.Free;
  for x:= 0 to 3 do
    with Tombols[x] do
      begin
      Objek[0].Free;
      Objek[1].Free;
    end;

end;

//==============================================================================

procedure TfrmMain.pbxUIPaint(Sender: TObject);
var
  x: integer;
begin

  pbxUI.Canvas.Lock;
  with pbxUI.Canvas do
  try
    Draw(0, 0, BackgroundBase);
    for x:= 0 to 3 do
      GambarTombol(x);
  finally
    Unlock;
  end;

end;

//==============================================================================

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  CanClose:= TRUE;
  if (GakDisimpan) then
    case MessageBox(Handle, PChar(s_NotSavedQuest), PChar(s_Warning), MB_ICONQUESTION + MB_YESNOCANCEL) of
      IDYES:
        begin
        if sdlg.Execute then
          Skp_SaveInstrumentFile(SrneeInfo, PChar(sdlg.FileName));
      end;
      IDCANCEL: CanClose:= FALSE;
  end;

end;

//==============================================================================

procedure TfrmMain.pbxUIMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i: integer;
begin

  // Ketika mouse ditahan
  for i:= 0 to 3 do
    begin
    Tombols[i].Ditekan:= FALSE;
    if PosisiDiDalam(Tombols[i].Area, X, Y) then
      if Tombols[i].Aktif then
        begin
        Tombols[i].Ditekan:= TRUE;
        GambarTombol(i);
      end
      else
        Beep;
  end;
  
end;

//==============================================================================

procedure TfrmMain.pbxUIMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i: integer;
begin

  // Ketika mouse dilepas kliknya
  for i:= 0 to 3 do
    begin
    Tombols[i].Ditekan:= FALSE;
    GambarTombol(i);
    if PosisiDiDalam(Tombols[i].Area, X, Y) then
      if Tombols[i].Aktif then
        begin
        case i of
          0: TampilkanMenu;               // Tombol Menu
          1: actRekamExecute(Sender);     // Tombol Rekam
          2: actPlayPauseExecute(Sender); // Tombol Play/Pause
          3: actStopExecute(Sender);      // Tombol Stop
        end;
      end;
  end;

end;

//==============================================================================

procedure TfrmMain.pbxUIClick(Sender: TObject);
begin

  // Set ke parent container
  pMain.SetFocus;

end;

//==============================================================================

procedure TfrmMain.trbVolChange(Sender: TObject);
begin

  // Set volume serune
  SetVolume(trbVol.Position);

end;

//==============================================================================

procedure TfrmMain.pbxUIMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  i: integer;
  buf: string;
begin

  // Set status dari tombol terpilih, jika tidak tampilkan nam program dan versi
  buf:= '';
  for i:= 0 to 3 do
    if PosisiDiDalam(Tombols[i].Area, X, Y) then
      buf:= hint_str[i];

  if (buf = '') then
    buf:= AppVerStr;

  sBar.Panels[2].Text:= buf;

end;

//==============================================================================

procedure TfrmMain.actExitExecute(Sender: TObject);
begin

  // Tutup program :0
  Close;

end;

//==============================================================================

procedure TfrmMain.actAbtExecute(Sender: TObject);
begin

  // Tampilkan dialog about
  frmAbout.ShowModal;

end;

//==============================================================================

procedure TfrmMain.prfInpExecute(Sender: TObject);
begin

  // Dialog setting pengaturan
  if (frmKeymap.ShowModal = mrOk) then
    BacaPengaturan;

end;

//==============================================================================

procedure TfrmMain.actOpenInsExecute(Sender: TObject);
begin

  // Buka file instrumen
  if odlg.Execute then
    Skp_OpenInstrumentFile(SrneeInfo, PChar(odlg.FileName));
  
end;

//==============================================================================

procedure TfrmMain.vwListKeyExecute(Sender: TObject);
begin

  // Tampilkan atau hilangkaan list key
  vwListKey.Checked:= not vwListKey.Checked;
  MuatUlangBackground(vwListKey.Checked);
  pbxUI.Repaint;
  TampilkanDaftarKey(vwListKey.Checked);

end;

//==============================================================================

procedure TfrmMain.actHelpExecute(Sender: TObject);
var
  cdir: string;
begin

  // Tampilkan dokumentasi
  cdir:= ExtractFilePath(ParamStr(0));
  ShellExecute(Handle, PChar('open'), PChar(cdir + 'SeruneKaleeInfo.pdf'), nil, PChar(cdir), SW_SHOW);

end;

//==============================================================================

procedure TfrmMain.prfPrfExecute(Sender: TObject);
begin

  // Tampilkan dialog preferensi
  if (frmPref.ShowModal = mrOk) then
    begin
    BacaPengaturan;
    pbxUI.Repaint;
  end;

end;

//==============================================================================

procedure TfrmMain.vwNumExecute(Sender: TObject);
begin

  // Tampilkan atau hilangkan nomor tombol
  vwNum.Checked:= not vwNum.Checked;

  l0.Visible:= vwNum.Checked;
  l1.Visible:= vwNum.Checked;
  l2.Visible:= vwNum.Checked;
  l3.Visible:= vwNum.Checked;
  l4.Visible:= vwNum.Checked;
  l5.Visible:= vwNum.Checked;
  l6.Visible:= vwNum.Checked;
  l7.Visible:= vwNum.Checked;

end;

//==============================================================================

procedure TfrmMain.vwPinExecute(Sender: TObject);
begin

  // Set form diatas atau tidak
  vwPin.Checked:= not vwPin.Checked;
  if (vwPin.Checked) then
    Self.FormStyle:= fsStayOnTop
  else
    Self.FormStyle:= fsNormal;
  Self.Update;
  Skp_SetPlayerProperty(SrneeInfo, SKP_PROP_PARENT_OWNER, Self.Handle);

end;

//==============================================================================

procedure TfrmMain.actRekamExecute(Sender: TObject);
begin

  // Mulai merekam
  KeluarNo:= FALSE;
  if PeringatanBelumSaveRk then
    Skp_LiveRecord(SrneeInfo);

end;

//==============================================================================

procedure TfrmMain.actPlayPauseExecute(Sender: TObject);
begin

  // Putar file instrumen
  if not Skp_InstrumentLoaded(SrneeInfo) then
    if odlg.Execute then
      Skp_OpenInstrumentFile(SrneeInfo, PChar(odlg.FileName));
  if Skp_InstrumentLoaded(SrneeInfo) then
    Skp_PlayPausePlayback(SrneeInfo);

end;

//==============================================================================

procedure TfrmMain.actStopExecute(Sender: TObject);
begin

  // Hentikan pemutaran file
  Skp_StopPlayback(SrneeInfo);

end;

//==============================================================================

procedure TfrmMain.FormResize(Sender: TObject);
var
  prgrect: TRect;
begin

  // Atur ulang posisi dan besar progress bar di status bar
  SendMessage(sBar.Handle, SB_GETRECT, 4, Integer(@prgrect));
  with prgrect do
    pbProg.SetBounds(Left, Top, Right - Left, Bottom - Top);
  pbxUI.Repaint;

end;

//==============================================================================

procedure TfrmMain.tmrTupdTimer(Sender: TObject);
begin

  // Update waktu pemutaran atau rekaman terkini
  lblTimec.Caption:= Format('%s - %s',
                            [pmode_str[Integer(Skp_GetPlayerProperty(SrneeInfo, SKP_PROP_PLAY_MODE)-2)],
                            TickTimeToString(Skp_GetPlayerProperty(SrneeInfo, SKP_PROP_PLAY_CURRENTTIME))]);
  if (TSrPlayMode(Skp_GetPlayerProperty(SrneeInfo, SKP_PROP_PLAY_MODE)) = pmPlayback) then
    pbProg.Position:= Trunc((Skp_GetPlayerProperty(SrneeInfo, SKP_PROP_PLAY_CURRENTTIME) /
                             Skp_GetPlayerProperty(SrneeInfo, SKP_PROP_PLAY_TIMELENGTH)) * 100);

end;

//==============================================================================

procedure TfrmMain.tmrKyTimer(Sender: TObject);
var
  dmode: boolean;
begin

  if (GetForegroundWindow() = Self.Handle) then
    if (GetAsyncKeyState(VK_LSHIFT) <> 0) or (GetAsyncKeyState(VK_RSHIFT) <> 0) then
      begin
      dmode:= not (Skp_GetPlayerProperty(SrneeInfo, SKP_PROP_DIRECT_MODE) <> 0);
      Skp_SetPlayerProperty(SrneeInfo, SKP_PROP_DIRECT_MODE, LongInt(dmode));
      if dmode then
        sBar.Panels[1].Text:= s_ModeDirect
      else
        sBar.Panels[1].Text:= s_ModeNormal;
      sBar.Update;
    end;

end;

end.
