object frmSplash: TfrmSplash
  Left = 192
  Top = 107
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'SplashScreen'
  ClientHeight = 225
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  DesignSize = (
    400
    225)
  PixelsPerInch = 96
  TextHeight = 13
  object lblStatus: TLabel
    Left = 269
    Top = 11
    Width = 120
    Height = 13
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Initializing program...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblVer: TLabel
    Left = 200
    Top = 144
    Width = 96
    Height = 13
    Caption = 'Version 1.0.2.120'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
end
