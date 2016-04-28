unit uPref;

interface

{$I SeruneConf.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IniFiles, Registry, ShellAPI,
  // Serune Kalee modules
  SrneeConst, SrneeTypes,
  {$IFDEF SKE_USE_DYNLIB}
  SrneeProcs
  {$ELSE}
  SrneeAudio
  {$ENDIF};

type
  TfrmPref = class(TForm)
    GroupBox2: TGroupBox;
    Label3: TLabel;
    cbxThm: TComboBox;
    GroupBox3: TGroupBox;
    cbxDrc: TCheckBox;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Label4: TLabel;
    cbxCmb: TCheckBox;
    cbxShl: TCheckBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    cbOal: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }

    FileDireg: boolean;

    procedure GetThemes;

  public
    { Public declarations }
  end;

var
  frmPref: TfrmPref;

implementation

{$R *.dfm}

//==============================================================================

procedure TfrmPref.GetThemes;
var
  sr: TSearchRec;
  Found: boolean;
begin

  cbxThm.Items.Clear;
  Found:= FindFirst(ExtractFilePath(ParamStr(0))+'Themes\*', faDirectory, sr) = 0;
  while Found do
    begin
    if (sr.Name <> '.') and (sr.Name <> '..') then
      cbxThm.Items.Add(sr.Name);
    Found:= FindNext(sr) = 0;
  end;
  FindClose(sr);

end;

//==============================================================================

procedure TfrmPref.FormShow(Sender: TObject);
var
  ini: TIniFile;
  Reg: TRegistry;
begin

  cbOal.Items.Text:= Ska_GetEnumDevices;
  cbOal.ItemIndex:= 0;
  GetThemes;

  Reg:= TRegistry.Create(KEY_READ);
  try

    Reg.RootKey:= HKEY_CLASSES_ROOT;
    FileDireg:= Reg.KeyExists('.skt');

    cbxShl.Checked:= FileDireg;

  finally
    Reg.Free;
  end;

  ini:= TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try

    // Device yang digunakan
    cbOal.ItemIndex:= Ska_GetIndexOfDevice(PChar(ini.ReadString('Preferences', 'SelectedSoundDevice', '')));
    // Tema tampilan program
    cbxThm.ItemIndex:= cbxThm.Items.IndexOf(ini.ReadString('Preferences', 'ApplyTheme', 'Merah Putih'));
    // Modus langsung
    cbxDrc.Checked:= ini.ReadBool('Preferences', 'DirectMode', FALSE);
    // Tombol kombinasi
    cbxCmb.Checked:= ini.ReadBool('Preferences', 'UseCombinationKey', TRUE);

  finally

    ini.Free;

  end;

end;

//==============================================================================

procedure TfrmPref.Button1Click(Sender: TObject);
var
  ini: TIniFile;
  OldDev: string;
  DevChange: boolean;
  //StInfo: StartupInfo;
  //PrInfo: Process_Information;
  ShlInfo: SHELLEXECUTEINFO;
  ShlArg: string;
  ShlInt: string;
begin

  DevChange:= FALSE;
  ini:= TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try

    // Device yang digunakan
    OldDev:= ini.ReadString('Preferences', 'SelectedSoundDevice', '');
    if (OldDev <> cbOal.Items[cbOal.ItemIndex]) and (cbOal.ItemIndex >= 0) then
      begin
      ini.WriteString('Preferences', 'SelectedSoundDevice', cbOal.Items[cbOal.ItemIndex]);
      DevChange:= TRUE;
    end;
    // Tema tampilan program
    ini.WriteString('Preferences', 'ApplyTheme', cbxThm.Items[cbxThm.ItemIndex]);
    // Modus langsung
    ini.WriteBool('Preferences', 'DirectMode', cbxDrc.Checked);
    // Tombol kombinasi
    ini.WriteBool('Preferences', 'UseCombinationKey', cbxCmb.Checked);

  finally

    ini.Free;
    if DevChange then
      MessageBox(Handle, PChar('Pengaturan device akan berubah setelah anda membuka program ini kembali!'), PChar('Informasi'), MB_ICONINFORMATION);

  end;

  if (cbxShl.Checked <> FileDireg) then
    begin

    if FileDireg then
      ShlArg:= '-u'
    else
      ShlArg:= '-r "' + ParamStr(0) + '"';
    ShlInt:= ExtractFilePath(ParamStr(0)) + 'SKShlReg.exe';

    ZeroMemory(@ShlInfo, SizeOf(SHELLEXECUTEINFO));
    ShlInfo.cbSize:= SizeOf(SHELLEXECUTEINFO);
    ShlInfo.Wnd:= Self.Handle;
    ShlInfo.lpVerb:= 'Open';
    ShlInfo.lpFile:= PChar(ShlInt);
    ShlInfo.lpParameters:= PChar(ShlArg);
    ShlInfo.lpDirectory:= PChar(ExtractFilePath(ParamStr(0)));
    ShlInfo.nShow:= SW_SHOW;
    ShlInfo.hInstApp:= HInstance;

    if ShellExecuteEx(@ShlInfo) then
      WaitForSingleObject(ShlInfo.hProcess, INFINITE);

    //ZeroMemory(@StInfo, SizeOf(StInfo));
    //ZeroMemory(@PrInfo, SizeOf(PrInfo));
    //FillChar(StInfo, SizeOf(StInfo),0);
    //StInfo.cb:= SizeOf(StInfo);

    //if CreateProcess(nil, PChar('"' + ShlInt + '" ' + ShlArg), nil, nil, TRUE,
    //                 0, nil, PChar(ExtractFilePath(ParamStr(0))), StInfo, PrInfo) then
    //  WaitForSingleObject(PrInfo.hProcess, INFINITE);

  end;

end;

//==============================================================================

end.
