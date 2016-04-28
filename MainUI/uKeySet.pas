unit uKeySet;

interface

{$I SeruneConf.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DirectInput, KeybdConst, IniFiles, PngImage,
  ComCtrls, AppConst,
  // Serune Kalee modules
  SrneeConst, SrneeTypes,
  {$IFDEF SKE_USE_DYNLIB}
  SrneeProcs
  {$ELSE}
  SrneeInput
  {$ENDIF};

type
  TfrmKeymap = class(TForm)
    Shape1: TShape;
    Shape2: TShape;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    l7: TLabel;
    l6: TLabel;
    l5: TLabel;
    l4: TLabel;
    l3: TLabel;
    l2: TLabel;
    l1: TLabel;
    l0: TLabel;
    pgcMain: TPageControl;
    tbKeyboard: TTabSheet;
    tbGCtrl: TTabSheet;
    Label9: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label16: TLabel;
    Label15: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label1: TLabel;
    cbxH7: TComboBox;
    cbxH6: TComboBox;
    cbxH5: TComboBox;
    cbxH4: TComboBox;
    cbxH3: TComboBox;
    cbxH2: TComboBox;
    cbxH1: TComboBox;
    cbxH0: TComboBox;
    cbxC67: TComboBox;
    cbxC56: TComboBox;
    cbxC45: TComboBox;
    cbxC34: TComboBox;
    cbxC23: TComboBox;
    cbxC12: TComboBox;
    cbxC01: TComboBox;
    cbxBlw: TComboBox;
    cbxJBlow: TComboBox;
    cbxJH0: TComboBox;
    cbxJH1: TComboBox;
    cbxJH2: TComboBox;
    cbxJH3: TComboBox;
    cbxJH4: TComboBox;
    cbxJH5: TComboBox;
    cbxJH6: TComboBox;
    cbxJH7: TComboBox;
    Label17: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    cbGctrl: TComboBox;
    Label18: TLabel;
    cbxUseGc: TCheckBox;
    imgPsr: TImage;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    DevCount: integer;
    DevGUIDs: array of TGUID;
    UsedGUID: TGUID;

    procedure ListGctButton(List: TStrings);

  public
    { Public declarations }
  end;

var
  frmKeymap: TfrmKeymap;

implementation

{$R *.dfm}

//==============================================================================

function DIEnumCb(var lpddi : TDIDeviceInstance; pvRef : Pointer): boolean; stdcall;
begin

  SetLength(frmKeymap.DevGUIDs, frmKeymap.DevCount + 1);
  frmKeymap.DevGUIDs[frmKeymap.DevCount]:= lpddi.guidInstance;
  Inc(frmKeymap.DevCount);
  frmKeymap.cbGctrl.Items.Add(lpddi.tszInstanceName);
  Result:= boolean(DIENUM_CONTINUE);

end;

//==============================================================================

procedure TfrmKeymap.ListGctButton(List: TStrings);
var
  zfra: integer;
begin

  List.Clear;
  for zfra:= 0 to 127 do
    List.Add(Format('Button %d', [zfra+1]));

end;

//==============================================================================

procedure TfrmKeymap.FormShow(Sender: TObject);
var
  cfg: TIniFile;
  psr: TPngObject;
  CrDGUID: TGUID;
  zfra: integer;
  gctrli: integer;
begin

  psr:= TPngObject.Create;
  try
    psr.LoadFromResourceName(HInstance, 'SK_IDLE');
    imgPsr.Picture.Assign(psr);
  finally
    psr.Free;
  end;

  // Enumerasi device DirectInput
  cbGctrl.Items.Clear;
  DevCount:= 0;
  Ski_EnumGameControllerDevices(@DIEnumCb);

  GetKeybdList(cbxBlw.Items);
  GetKeybdList(cbxH0.Items);
  GetKeybdList(cbxH1.Items);
  GetKeybdList(cbxH2.Items);
  GetKeybdList(cbxH3.Items);
  GetKeybdList(cbxH4.Items);
  GetKeybdList(cbxH5.Items);
  GetKeybdList(cbxH6.Items);
  GetKeybdList(cbxH7.Items);
  GetKeybdList(cbxC01.Items);
  GetKeybdList(cbxC12.Items);
  GetKeybdList(cbxC23.Items);
  GetKeybdList(cbxC34.Items);
  GetKeybdList(cbxC45.Items);
  GetKeybdList(cbxC56.Items);
  GetKeybdList(cbxC67.Items);

  ListGctButton(cbxJBlow.Items);
  ListGctButton(cbxJH0.Items);
  ListGctButton(cbxJH1.Items);
  ListGctButton(cbxJH2.Items);
  ListGctButton(cbxJH3.Items);
  ListGctButton(cbxJH4.Items);
  ListGctButton(cbxJH5.Items);
  ListGctButton(cbxJH6.Items);
  ListGctButton(cbxJH7.Items);

  cfg:= TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try

    cbxBlw.ItemIndex:= GetKeybdIndex(cfg.ReadInteger('Keys', 'Keyboard.Blow', Def_KbdBlw));

    cbxH0.ItemIndex:= GetKeybdIndex(cfg.ReadInteger('Keys', 'Keyboard.Hole0', Def_KbdKey[0]));
    cbxH1.ItemIndex:= GetKeybdIndex(cfg.ReadInteger('Keys', 'Keyboard.Hole1', Def_KbdKey[1]));
    cbxH2.ItemIndex:= GetKeybdIndex(cfg.ReadInteger('Keys', 'Keyboard.Hole2', Def_KbdKey[2]));
    cbxH3.ItemIndex:= GetKeybdIndex(cfg.ReadInteger('Keys', 'Keyboard.Hole3', Def_KbdKey[3]));
    cbxH4.ItemIndex:= GetKeybdIndex(cfg.ReadInteger('Keys', 'Keyboard.Hole4', Def_KbdKey[4]));
    cbxH5.ItemIndex:= GetKeybdIndex(cfg.ReadInteger('Keys', 'Keyboard.Hole5', Def_KbdKey[5]));
    cbxH6.ItemIndex:= GetKeybdIndex(cfg.ReadInteger('Keys', 'Keyboard.Hole6', Def_KbdKey[6]));
    cbxH7.ItemIndex:= GetKeybdIndex(cfg.ReadInteger('Keys', 'Keyboard.Hole7', Def_KbdKey[7]));

    cbxC01.ItemIndex:= GetKeybdIndex(cfg.ReadInteger('Keys', 'Keyboard.Cmb01', Def_KbdCmbKey[0]));
    cbxC12.ItemIndex:= GetKeybdIndex(cfg.ReadInteger('Keys', 'Keyboard.Cmb12', Def_KbdCmbKey[1]));
    cbxC23.ItemIndex:= GetKeybdIndex(cfg.ReadInteger('Keys', 'Keyboard.Cmb23', Def_KbdCmbKey[2]));
    cbxC34.ItemIndex:= GetKeybdIndex(cfg.ReadInteger('Keys', 'Keyboard.Cmb34', Def_KbdCmbKey[3]));
    cbxC45.ItemIndex:= GetKeybdIndex(cfg.ReadInteger('Keys', 'Keyboard.Cmb45', Def_KbdCmbKey[4]));
    cbxC56.ItemIndex:= GetKeybdIndex(cfg.ReadInteger('Keys', 'Keyboard.Cmb56', Def_KbdCmbKey[5]));
    cbxC67.ItemIndex:= GetKeybdIndex(cfg.ReadInteger('Keys', 'Keyboard.Cmb67', Def_KbdCmbKey[6]));

    UsedGUID:= NullGUID;
    try
      gctrli:= -1;
      CrDGUID:= StringToGUID(cfg.ReadString('Keys', 'GameController.DeviceGUID', NullGUIDStr));
      for zfra:= 0 to DevCount-1 do
        if (GUIDToString(CrDGUID) = GUIDToString(DevGUIDs[zfra])) then
          begin
          gctrli:= zfra;
          UsedGUID:= DevGUIDs[zfra];
          Break;
        end;
    except
      gctrli:= -1;
    end;
    cbGctrl.ItemIndex:= gctrli;
    cbxUseGc.Checked:= cfg.ReadBool('Keys', 'GameController.Enable', FALSE);

    cbxJBlow.ItemIndex:= cfg.ReadInteger('Keys', 'GameController.Blow', Def_GCtBlw);

    cbxJH0.ItemIndex:= cfg.ReadInteger('Keys', 'GameController.Hole0', Def_GCtKey[0]);
    cbxJH1.ItemIndex:= cfg.ReadInteger('Keys', 'GameController.Hole1', Def_GCtKey[1]);
    cbxJH2.ItemIndex:= cfg.ReadInteger('Keys', 'GameController.Hole2', Def_GCtKey[2]);
    cbxJH3.ItemIndex:= cfg.ReadInteger('Keys', 'GameController.Hole3', Def_GCtKey[3]);
    cbxJH4.ItemIndex:= cfg.ReadInteger('Keys', 'GameController.Hole4', Def_GCtKey[4]);
    cbxJH5.ItemIndex:= cfg.ReadInteger('Keys', 'GameController.Hole5', Def_GCtKey[5]);
    cbxJH6.ItemIndex:= cfg.ReadInteger('Keys', 'GameController.Hole6', Def_GCtKey[6]);
    cbxJH7.ItemIndex:= cfg.ReadInteger('Keys', 'GameController.Hole7', Def_GCtKey[7]);

  finally
    cfg.Free;
  end;

  pgcMain.ActivePage:= tbKeyboard;

end;

procedure TfrmKeymap.Button1Click(Sender: TObject);
var
  cfg: TIniFile;
begin

  cfg:= TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try

    cfg.WriteInteger('Keys', 'Keyboard.Blow', GetKeybdKey(cbxBlw.ItemIndex));

    cfg.WriteInteger('Keys', 'Keyboard.Hole0', GetKeybdKey(cbxH0.ItemIndex));
    cfg.WriteInteger('Keys', 'Keyboard.Hole1', GetKeybdKey(cbxH1.ItemIndex));
    cfg.WriteInteger('Keys', 'Keyboard.Hole2', GetKeybdKey(cbxH2.ItemIndex));
    cfg.WriteInteger('Keys', 'Keyboard.Hole3', GetKeybdKey(cbxH3.ItemIndex));
    cfg.WriteInteger('Keys', 'Keyboard.Hole4', GetKeybdKey(cbxH4.ItemIndex));
    cfg.WriteInteger('Keys', 'Keyboard.Hole5', GetKeybdKey(cbxH5.ItemIndex));
    cfg.WriteInteger('Keys', 'Keyboard.Hole6', GetKeybdKey(cbxH6.ItemIndex));
    cfg.WriteInteger('Keys', 'Keyboard.Hole7', GetKeybdKey(cbxH7.ItemIndex));

    cfg.WriteInteger('Keys', 'Keyboard.Cmb01', GetKeybdKey(cbxC01.ItemIndex));
    cfg.WriteInteger('Keys', 'Keyboard.Cmb12', GetKeybdKey(cbxC12.ItemIndex));
    cfg.WriteInteger('Keys', 'Keyboard.Cmb23', GetKeybdKey(cbxC23.ItemIndex));
    cfg.WriteInteger('Keys', 'Keyboard.Cmb34', GetKeybdKey(cbxC34.ItemIndex));
    cfg.WriteInteger('Keys', 'Keyboard.Cmb45', GetKeybdKey(cbxC45.ItemIndex));
    cfg.WriteInteger('Keys', 'Keyboard.Cmb56', GetKeybdKey(cbxC56.ItemIndex));
    cfg.WriteInteger('Keys', 'Keyboard.Cmb67', GetKeybdKey(cbxC67.ItemIndex));

    if (cbGctrl.ItemIndex > -1) then
      cfg.WriteString('Keys', 'GameController.DeviceGUID', GUIDToString(DevGUIDs[cbGctrl.ItemIndex]))
    else
      if (GUIDToString(UsedGUID) = NullGUIDStr) then
        cfg.WriteString('Keys', 'GameController.DeviceGUID', NullGUIDStr);

    cfg.WriteBool('Keys', 'GameController.Enable', cbxUseGc.Checked);

    cfg.WriteInteger('Keys', 'GameController.Blow', cbxJBlow.ItemIndex);

    cfg.WriteInteger('Keys', 'GameController.Hole0', cbxJH0.ItemIndex);
    cfg.WriteInteger('Keys', 'GameController.Hole1', cbxJH1.ItemIndex);
    cfg.WriteInteger('Keys', 'GameController.Hole2', cbxJH2.ItemIndex);
    cfg.WriteInteger('Keys', 'GameController.Hole3', cbxJH3.ItemIndex);
    cfg.WriteInteger('Keys', 'GameController.Hole4', cbxJH4.ItemIndex);
    cfg.WriteInteger('Keys', 'GameController.Hole5', cbxJH5.ItemIndex);
    cfg.WriteInteger('Keys', 'GameController.Hole6', cbxJH6.ItemIndex);
    cfg.WriteInteger('Keys', 'GameController.Hole7', cbxJH7.ItemIndex);

  finally
    cfg.Free;
  end;

end;

procedure TfrmKeymap.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  DevGUIDs:= nil;
  if (imgPsr.Picture <> nil) then
    imgPsr.Picture.Bitmap.FreeImage;

end;

end.
