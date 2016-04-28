object frmMain: TfrmMain
  Left = 230
  Top = 186
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Serune Kalee Simulator'
  ClientHeight = 507
  ClientWidth = 722
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 720
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox4: TPaintBox
    Left = 194
    Top = 22
    Width = 80
    Height = 36
  end
  object Label1: TLabel
    Left = 42
    Top = 460
    Width = 115
    Height = 13
    Caption = 'Tampilkan nomor lubang'
    Transparent = True
  end
  object Label7: TLabel
    Left = 468
    Top = 360
    Width = 201
    Height = 20
    AutoSize = False
    Caption = 'Label4'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label8: TLabel
    Left = 260
    Top = 360
    Width = 201
    Height = 20
    AutoSize = False
    Caption = 'Label4'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label9: TLabel
    Left = 52
    Top = 360
    Width = 201
    Height = 20
    AutoSize = False
    Caption = 'Label4'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object sBar: TStatusBar
    Left = 0
    Top = 488
    Width = 722
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = 'Volume: 100%'
        Width = 100
      end
      item
        Alignment = taCenter
        Text = 'Modus langsung'
        Width = 125
      end
      item
        Alignment = taCenter
        Text = 'Pilih pilhan'
        Width = 280
      end
      item
        Alignment = taCenter
        Text = 'Permainan bebas'
        Width = 125
      end
      item
        Alignment = taCenter
        Style = psOwnerDraw
        Width = 250
      end>
  end
  object pMain: TPanel
    Left = 0
    Top = 0
    Width = 722
    Height = 488
    Align = alClient
    BevelOuter = bvLowered
    Color = 13956345
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      722
      488)
    object pbxUI: TPaintBox
      Left = 1
      Top = 1
      Width = 720
      Height = 486
      Align = alClient
      Color = 16710627
      ParentColor = False
      OnClick = pbxUIClick
      OnMouseDown = pbxUIMouseDown
      OnMouseMove = pbxUIMouseMove
      OnMouseUp = pbxUIMouseUp
      OnPaint = pbxUIPaint
    end
    object pbDraw: TPaintBox
      Left = 20
      Top = 64
      Width = 680
      Height = 377
      Visible = False
    end
    object pbSr: TPaintBox
      Left = 30
      Top = 115
      Width = 660
      Height = 128
      Anchors = [akBottom]
      Visible = False
    end
    object pbMenu: TPaintBox
      Left = 12
      Top = 4
      Width = 56
      Height = 25
      Visible = False
    end
    object pbRekam: TPaintBox
      Left = 276
      Top = 262
      Width = 50
      Height = 40
      Anchors = [akTop, akRight]
      Visible = False
    end
    object pbPlay: TPaintBox
      Left = 336
      Top = 262
      Width = 50
      Height = 40
      Anchors = [akTop]
      Visible = False
    end
    object pbStop: TPaintBox
      Left = 396
      Top = 262
      Width = 50
      Height = 40
      Visible = False
    end
    object s1: TShape
      Left = 215
      Top = 138
      Width = 25
      Height = 25
      Brush.Color = 32951
      Pen.Style = psClear
      Shape = stCircle
      Visible = False
    end
    object s2: TShape
      Left = 265
      Top = 139
      Width = 25
      Height = 25
      Brush.Color = 32951
      Pen.Style = psClear
      Shape = stCircle
      Visible = False
    end
    object s3: TShape
      Left = 310
      Top = 139
      Width = 25
      Height = 25
      Brush.Color = 32951
      Pen.Style = psClear
      Shape = stCircle
      Visible = False
    end
    object s4: TShape
      Left = 359
      Top = 138
      Width = 25
      Height = 25
      Brush.Color = 32951
      Pen.Style = psClear
      Shape = stCircle
      Visible = False
    end
    object s5: TShape
      Left = 408
      Top = 138
      Width = 25
      Height = 25
      Brush.Color = 32951
      Pen.Style = psClear
      Shape = stCircle
      Visible = False
    end
    object s6: TShape
      Left = 452
      Top = 137
      Width = 25
      Height = 25
      Brush.Color = 32951
      Pen.Style = psClear
      Shape = stCircle
      Visible = False
    end
    object s7: TShape
      Left = 495
      Top = 137
      Width = 25
      Height = 25
      Brush.Color = 32951
      Pen.Style = psClear
      Shape = stCircle
      Visible = False
    end
    object s0: TShape
      Left = 172
      Top = 192
      Width = 25
      Height = 25
      Brush.Color = 32951
      Pen.Style = psClear
      Shape = stCircle
      Visible = False
    end
    object l1: TLabel
      Left = 217
      Top = 142
      Width = 20
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object l2: TLabel
      Left = 268
      Top = 143
      Width = 20
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = '2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object l3: TLabel
      Left = 313
      Top = 143
      Width = 20
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = '3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object l4: TLabel
      Left = 362
      Top = 142
      Width = 20
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = '4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object l5: TLabel
      Left = 411
      Top = 142
      Width = 20
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = '5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object l6: TLabel
      Left = 455
      Top = 141
      Width = 20
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = '6'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object l7: TLabel
      Left = 497
      Top = 141
      Width = 20
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = '7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object l0: TLabel
      Left = 175
      Top = 196
      Width = 20
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblNb: TLabel
      Left = 42
      Top = 463
      Width = 116
      Height = 16
      Anchors = [akLeft, akBottom]
      Caption = 'Tampilkan nomor lubang'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      Transparent = True
      OnClick = vwNumExecute
    end
    object Label2: TLabel
      Left = 210
      Top = 463
      Width = 161
      Height = 16
      Anchors = [akLeft, akBottom]
      Caption = 'Tampilkan daftar tombol  keyboard'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      Transparent = True
      OnClick = vwListKeyExecute
    end
    object Label3: TLabel
      Left = 426
      Top = 463
      Width = 145
      Height = 16
      Anchors = [akLeft, akBottom]
      Caption = 'Tampilkan jendela selalu diatas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      Transparent = True
      OnClick = vwPinExecute
    end
    object lblTimec: TLabel
      Left = 619
      Top = 72
      Width = 60
      Height = 25
      Alignment = taRightJustify
      Caption = '----------'
      Font.Charset = ANSI_CHARSET
      Font.Color = 4802889
      Font.Height = -21
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object lh0: TLabel
      Left = 52
      Top = 344
      Width = 201
      Height = 20
      Alignment = taCenter
      Anchors = [akTop]
      AutoSize = False
      Caption = 'Lubang 0 - <Kunci>'
      Transparent = True
    end
    object lh1: TLabel
      Left = 260
      Top = 344
      Width = 201
      Height = 20
      Alignment = taCenter
      Anchors = [akTop]
      AutoSize = False
      Caption = 'Lubang 1 - <Kunci>'
      Transparent = True
    end
    object lh2: TLabel
      Left = 468
      Top = 344
      Width = 201
      Height = 20
      Alignment = taCenter
      Anchors = [akTop]
      AutoSize = False
      Caption = 'Lubang 2 - <Kunci>'
      Transparent = True
    end
    object lh5: TLabel
      Left = 468
      Top = 368
      Width = 201
      Height = 20
      Alignment = taCenter
      Anchors = [akTop]
      AutoSize = False
      Caption = 'Lubang 5 - <Kunci>'
      Transparent = True
    end
    object lh4: TLabel
      Left = 260
      Top = 368
      Width = 201
      Height = 20
      Alignment = taCenter
      Anchors = [akTop]
      AutoSize = False
      Caption = 'Lubang 4 - <Kunci>'
      Transparent = True
    end
    object lh3: TLabel
      Left = 52
      Top = 368
      Width = 201
      Height = 20
      Alignment = taCenter
      Anchors = [akTop]
      AutoSize = False
      Caption = 'Lubang 3 - <Kunci>'
      Transparent = True
    end
    object lhb: TLabel
      Left = 468
      Top = 392
      Width = 201
      Height = 20
      Alignment = taCenter
      Anchors = [akTop]
      AutoSize = False
      Caption = 'Tiup kosong - <Kunci>'
      Transparent = True
    end
    object lh7: TLabel
      Left = 260
      Top = 392
      Width = 201
      Height = 20
      Alignment = taCenter
      Anchors = [akTop]
      AutoSize = False
      Caption = 'Lubang 7 - <Kunci>'
      Transparent = True
    end
    object lh6: TLabel
      Left = 52
      Top = 392
      Width = 201
      Height = 20
      Alignment = taCenter
      Anchors = [akTop]
      AutoSize = False
      Caption = 'Lubang 6 - <Kunci>'
      Transparent = True
    end
    object lblCaplh: TLabel
      Left = 52
      Top = 320
      Width = 617
      Height = 20
      Alignment = taCenter
      AutoSize = False
      Caption = 'Daftar Tombol'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Image1: TImage
      Left = 480
      Top = 8
      Width = 24
      Height = 24
      AutoSize = True
      Picture.Data = {
        07544269746D6170F6060000424DF60600000000000036000000280000001800
        0000180000000100180000000000C0060000202E0000202E0000000000000000
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFD4ECFA70BEEC9ED3F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFBFE2F763B7EA57B2E897CFF1FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFCFEFFA9D9F459B3E857B2E858B3E998D1F1FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3FAFE95CFF157B2E858B3E958B3
        E958B2E998D0F1FFFFFFE6F4FCDDF0FBFBFDFEFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9F6FD84C8EF57B2E8
        58B3E957B2E858B3E957B3E998D1F1FFFFFFA9D7F358B3E997D0F1EFF8FDFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F9FDEFF8FDEFF8FDF3F9FDD4ECFA72
        BFEC57B2E958B3E957B2E858B3E958B2E857B2E898D1F1FFFFFFAEDAF458B3E9
        55B1E893CEF2F8FCFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF83C7EF5EB6E964B8
        EA64B9EB5CB4E957B3E958B3E958B3E958B3E857B2E858B2E858B3E999D0F1FF
        FFFFA8D7F358B3E958B3E957B2E8BDE3F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        76C1EC57B2E858B3E957B2E857B2E958B3E957B2E857B2E858B3E958B3E957B3
        E857B2E998D0F1FFFFFFBEE1F756B2E756B1E857B2E872BFECECF7FDFFFFFFFF
        FFFFFFFFFFFFFFFF79C2ED58B2E858B3E958B3E958B3E958B2E858B3E958B3E9
        58B3E858B3E958B3E957B2E899D1F2FFFFFFFCFEFFD9EEFB70BEEC55B1E759B3
        E8C4E5F8FFFFFFFFFFFFFFFFFFFFFFFF79C2EC57B2E858B3E958B3E957B2E858
        B3E957B2E858B2E857B3E958B3E958B3E857B2E994CEF0FCFEFFFFFFFFFFFFFF
        C3E5F955B1E757B2E997D0F2FFFFFFFFFFFFFFFFFFFFFFFF79C2ED58B3E957B2
        E858B3E958B3E857B2E958B3E958B3E958B3E957B2E858B3E957B2E860B7E99B
        D2F3F1F9FEFFFFFFE9F5FD68BAEC58B3E882C7EEFFFFFFFFFFFFFFFFFFFFFFFF
        79C2EC58B3E958B3E958B3E858B3E858B3E958B3E858B3E958B3E858B3E957B2
        E858B3E857B2E957B1E8B5DEF6FFFFFFF3FAFE7EC4EE57B2E879C1EDFFFFFFFF
        FFFFFFFFFFFFFFFF79C2EC58B3E858B2E958B3E858B2E857B2E858B3E858B2E8
        57B3E958B3E958B3E858B3E858B3E856B2E8B5DEF6FFFFFFF2F9FD7BC4EE57B2
        E878C1EDFFFFFFFFFFFFFFFFFFFFFFFF78C2ED58B3E958B3E958B3E958B3E958
        B3E957B2E858B3E958B3E958B3E958B3E958B2E961B7EA9DD3F2F2F9FEFFFFFF
        E8F5FC66BAEB57B2E881C6EEFFFFFFFFFFFFFFFFFFFFFFFF79C2EC58B3E857B2
        E858B3E958B3E958B2E958B3E858B3E958B3E857B2E858B2E858B3E995CFF1FC
        FEFFFFFFFFFFFFFFBDE2F857B2E858B2E897D1F2FFFFFFFFFFFFFFFFFFFFFFFF
        79C2ED58B3E857B3E958B2E858B3E858B3E958B2E857B2E858B3E958B3E958B3
        E957B2E899D1F2FFFFFFFBFDFED4ECFA6BBDEC57B2E859B4E9C4E5F8FFFFFFFF
        FFFFFFFFFFFFFFFF76C2ED57B2E858B3E958B3E958B3E958B3E958B3E958B2E8
        58B3E957B2E957B2E857B2E899D0F1FFFFFFBCE1F758B2E957B2E857B2E872BF
        ECEDF7FDFFFFFFFFFFFFFFFFFFFFFFFF84C7EE61B7E966B9EA67BAEB5DB5E957
        B2E858B2E858B3E958B3E958B3E858B3E958B3E999D1F1FFFFFFA8D8F457B2E8
        57B2E856B2E8BDE2F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4FAFEF1F9FDF2F9
        FDF5FBFED6ECFA75C1ED57B3E858B3E958B3E858B3E958B3E958B2E899D0F1FF
        FFFFADD9F458B3E955B0E799D2F3F9FCFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9F6FD86C8F056B2E858B3E957B3E957B2
        E857B3E998D1F1FFFFFFA9D7F357B3E999D1F2F1F9FDFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4FAFE98D1F2
        57B2E858B2E858B3E957B2E998D0F1FFFFFFE7F4FCDEF0FBFCFEFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFDFEFFAEDBF559B3E858B2E858B2E998D1F1FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC2E4F863B8EA57B2E897CFF1FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7ED
        FA71BFEC9DD3F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF}
      Transparent = True
    end
    object trbVol: TTrackBar
      Left = 504
      Top = 12
      Width = 200
      Height = 15
      Max = 100
      Frequency = 5
      Position = 100
      TabOrder = 0
      ThumbLength = 15
      OnChange = trbVolChange
    end
    object cbxNb: TCheckBox
      Left = 24
      Top = 465
      Width = 12
      Height = 15
      Action = vwNum
      Anchors = [akLeft, akBottom]
      State = cbChecked
      TabOrder = 1
    end
    object CheckBox2: TCheckBox
      Left = 192
      Top = 465
      Width = 12
      Height = 13
      Action = vwListKey
      Anchors = [akLeft, akBottom]
      State = cbChecked
      TabOrder = 2
    end
    object CheckBox3: TCheckBox
      Left = 408
      Top = 465
      Width = 12
      Height = 13
      Action = vwPin
      Anchors = [akLeft, akBottom]
      TabOrder = 3
    end
    object pbProg: TProgressBar
      Left = 560
      Top = 456
      Width = 150
      Height = 16
      TabOrder = 4
    end
  end
  object pmMenu: TPopupMenu
    Images = imgLst
    Left = 16
    Top = 80
    object Rekam1: TMenuItem
      Action = actRekam
    end
    object MulaiJeda1: TMenuItem
      Action = actPlayPause
    end
    object Hentikan1: TMenuItem
      Action = actStop
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Bukafileinstrumen1: TMenuItem
      Action = actOpenIns
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object ampilkannomorlubang1: TMenuItem
      Action = vwNum
    end
    object ampilkandaftartombolkeyboard1: TMenuItem
      Action = vwListKey
    end
    object ampilkanjendelaselaludiatas1: TMenuItem
      Action = vwPin
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Aturmasukankeyboard1: TMenuItem
      Action = prfInp
    end
    object Preferensi1: TMenuItem
      Action = prfPrf
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Bantuandandokumentasi1: TMenuItem
      Action = actHelp
    end
    object entang1: TMenuItem
      Action = actAbt
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Keluar1: TMenuItem
      Action = actExit
    end
  end
  object actLst: TActionList
    Images = imgLst
    Left = 48
    Top = 80
    object actRekam: TAction
      Category = 'Aksi'
      Caption = '&Rekam'
      Hint = 'Rekam permainan ke file instrumen'
      ImageIndex = 0
      ShortCut = 16466
      OnExecute = actRekamExecute
    end
    object actPlayPause: TAction
      Category = 'Aksi'
      Caption = '&Putar/Jeda'
      Enabled = False
      Hint = 'Putar atau jeda instrumen'
      ImageIndex = 1
      ShortCut = 16464
      OnExecute = actPlayPauseExecute
    end
    object actStop: TAction
      Category = 'Aksi'
      Caption = '&Hentikan'
      Enabled = False
      Hint = 'Hentikan instrumen yang berjalan'
      ImageIndex = 2
      ShortCut = 16467
      OnExecute = actStopExecute
    end
    object actOpenIns: TAction
      Category = 'File'
      Caption = '&Buka file instrumen'
      Hint = 'Buka berkas instrumen yang tersimpan'
      ImageIndex = 3
      ShortCut = 16463
      OnExecute = actOpenInsExecute
    end
    object vwNum: TAction
      Category = 'View'
      Caption = 'Tampilkan nomor lubang'
      Checked = True
      Hint = 'Tampilkan nomor lubang'
      ShortCut = 113
      OnExecute = vwNumExecute
    end
    object vwListKey: TAction
      Category = 'View'
      Caption = 'Tampilkan daftar tombol  keyboard'
      Checked = True
      Hint = 'Tampilkan daftar tombol  keyboard'
      ShortCut = 114
      OnExecute = vwListKeyExecute
    end
    object prfInp: TAction
      Category = 'Pref'
      Caption = 'Atur perangkat dan tombol &masukan'
      Hint = 'Atur tombol keyboard atau kontroller game'
      ImageIndex = 4
      OnExecute = prfInpExecute
    end
    object prfPrf: TAction
      Category = 'Pref'
      Caption = '&Preferensi'
      Hint = 'Preferensi program'
      ImageIndex = 5
      OnExecute = prfPrfExecute
    end
    object actHelp: TAction
      Category = 'Help'
      Caption = '&Bantuan'
      Hint = 'Tampilkan bantuan penggunaan program'
      ImageIndex = 6
      ShortCut = 112
      OnExecute = actHelpExecute
    end
    object actAbt: TAction
      Category = 'Help'
      Caption = '&Tentang'
      Hint = 'Tentang program ini'
      ImageIndex = 7
      OnExecute = actAbtExecute
    end
    object actExit: TAction
      Caption = '&Keluar'
      Hint = 'Keluar dari program'
      ImageIndex = 8
      OnExecute = actExitExecute
    end
    object vwPin: TAction
      Category = 'View'
      Caption = 'Tampilkan jendela selalu diatas'
      ShortCut = 115
      OnExecute = vwPinExecute
    end
  end
  object odlg: TOpenDialog
    DefaultExt = '*.skt'
    Filter = 'Instrument table (*.skt)|*.skt'
    Left = 88
    Top = 80
  end
  object sdlg: TSaveDialog
    DefaultExt = '*.skt'
    Filter = 'Instrument table (*.skt)|*.skt'
    Left = 120
    Top = 88
  end
  object imgLst: TImageList
    Left = 160
    Top = 40
  end
  object tmrTupd: TTimer
    Enabled = False
    Interval = 20
    OnTimer = tmrTupdTimer
    Left = 56
    Top = 120
  end
  object tmrKy: TTimer
    Interval = 250
    OnTimer = tmrKyTimer
    Left = 96
    Top = 136
  end
end
