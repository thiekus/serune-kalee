program Serunee;

(*==============================================================================

  Serune Kalee Program
  Copyright © Revolven Technologies
  Coded by Faris Khowarizmi 2014

==============================================================================*)

{$I SeruneConf.inc}

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uAbout in 'uAbout.pas' {frmAbout},
  uKeySet in 'uKeySet.pas' {frmKeymap},
  uPref in 'uPref.pas' {frmPref},
  AppConst in 'AppConst.pas',
  uSplash in 'uSplash.pas' {frmSplash},
  Tambahan in 'Tambahan.pas',
  KeybdConst in 'KeybdConst.pas',
  AppStrings in 'AppStrings.pas',
  SrneeTypes in '..\SeruneEngine\SrneeTypes.pas',
  SrneeConst in '..\SeruneEngine\SrneeConst.pas',
  SrneeProcs in '..\SeruneEngine\SrneeProcs.pas';

{$R *.res}
{$R filers.RES}
{$R Picrs.RES}
{$R XP-THEME.RES}

begin

  Application.Initialize;
  Application.Title := 'Seurune Kalee';
  DoSplash;

  try

    UpdateSplashLabel(s_InitCrtUI);
    Application.CreateForm(TfrmMain, frmMain);
    UpdateSplashLabel(s_InitCrtOt);
    Application.CreateForm(TfrmAbout, frmAbout);
    Application.CreateForm(TfrmKeymap, frmKeymap);
    Application.CreateForm(TfrmPref, frmPref);

  finally

    NoSplash;
    Application.Run;

  end;

end.
