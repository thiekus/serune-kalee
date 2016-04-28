object frmKeymap: TfrmKeymap
  Left = 346
  Top = 196
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Atur kunci keyboard dan kontroller'
  ClientHeight = 458
  ClientWidth = 701
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Shape2: TShape
    Left = 16
    Top = 16
    Width = 673
    Height = 137
    Brush.Color = clBlack
  end
  object Shape1: TShape
    Left = 8
    Top = 8
    Width = 673
    Height = 137
  end
  object Bevel1: TBevel
    Left = 8
    Top = 416
    Width = 681
    Height = 2
    Shape = bsBottomLine
  end
  object l7: TLabel
    Left = 480
    Top = 44
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
  object l6: TLabel
    Left = 436
    Top = 44
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
  object l5: TLabel
    Left = 388
    Top = 44
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
  object l4: TLabel
    Left = 342
    Top = 44
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
  object l3: TLabel
    Left = 296
    Top = 44
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
  object l2: TLabel
    Left = 243
    Top = 45
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
  object l1: TLabel
    Left = 200
    Top = 44
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
  object l0: TLabel
    Left = 158
    Top = 90
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
  object imgPsr: TImage
    Left = 12
    Top = 10
    Width = 660
    Height = 128
  end
  object Button1: TButton
    Left = 472
    Top = 424
    Width = 107
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 584
    Top = 424
    Width = 107
    Height = 25
    Caption = '&Batal'
    ModalResult = 2
    TabOrder = 1
  end
  object pgcMain: TPageControl
    Left = 8
    Top = 168
    Width = 681
    Height = 233
    ActivePage = tbGCtrl
    TabIndex = 1
    TabOrder = 2
    object tbKeyboard: TTabSheet
      Caption = '&Keyboard'
      object Label9: TLabel
        Left = 24
        Top = 104
        Width = 59
        Height = 13
        Caption = 'Lubang ke-7'
      end
      object Label8: TLabel
        Left = 504
        Top = 56
        Width = 59
        Height = 13
        Caption = 'Lubang ke-6'
      end
      object Label7: TLabel
        Left = 344
        Top = 56
        Width = 59
        Height = 13
        Caption = 'Lubang ke-5'
      end
      object Label6: TLabel
        Left = 184
        Top = 56
        Width = 59
        Height = 13
        Caption = 'Lubang ke-4'
      end
      object Label5: TLabel
        Left = 24
        Top = 56
        Width = 59
        Height = 13
        Caption = 'Lubang ke-3'
      end
      object Label4: TLabel
        Left = 504
        Top = 8
        Width = 59
        Height = 13
        Caption = 'Lubang ke-2'
      end
      object Label3: TLabel
        Left = 344
        Top = 8
        Width = 59
        Height = 13
        Caption = 'Lubang ke-1'
      end
      object Label2: TLabel
        Left = 184
        Top = 8
        Width = 59
        Height = 13
        Caption = 'Lubang ke-0'
      end
      object Label16: TLabel
        Left = 504
        Top = 152
        Width = 94
        Height = 13
        Caption = 'Lubang ke-6 + ke-7'
      end
      object Label15: TLabel
        Left = 344
        Top = 152
        Width = 94
        Height = 13
        Caption = 'Lubang ke-5 + ke-6'
      end
      object Label14: TLabel
        Left = 184
        Top = 152
        Width = 94
        Height = 13
        Caption = 'Lubang ke-4 + ke-5'
      end
      object Label13: TLabel
        Left = 24
        Top = 152
        Width = 94
        Height = 13
        Caption = 'Lubang ke-3 + ke-4'
      end
      object Label12: TLabel
        Left = 504
        Top = 104
        Width = 94
        Height = 13
        Caption = 'Lubang ke-2 + ke-3'
      end
      object Label11: TLabel
        Left = 344
        Top = 104
        Width = 94
        Height = 13
        Caption = 'Lubang ke-1 + ke-2'
      end
      object Label10: TLabel
        Left = 184
        Top = 104
        Width = 94
        Height = 13
        Caption = 'Lubang ke-0 + ke-1'
      end
      object Label1: TLabel
        Left = 24
        Top = 8
        Width = 20
        Height = 13
        Caption = 'Tiup'
      end
      object cbxH7: TComboBox
        Left = 24
        Top = 120
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 8
      end
      object cbxH6: TComboBox
        Left = 504
        Top = 72
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 7
      end
      object cbxH5: TComboBox
        Left = 344
        Top = 72
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 6
      end
      object cbxH4: TComboBox
        Left = 184
        Top = 72
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 5
      end
      object cbxH3: TComboBox
        Left = 24
        Top = 72
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
      end
      object cbxH2: TComboBox
        Left = 504
        Top = 24
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
      end
      object cbxH1: TComboBox
        Left = 344
        Top = 24
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
      end
      object cbxH0: TComboBox
        Left = 184
        Top = 24
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
      end
      object cbxC67: TComboBox
        Left = 504
        Top = 168
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 15
      end
      object cbxC56: TComboBox
        Left = 344
        Top = 168
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 14
      end
      object cbxC45: TComboBox
        Left = 184
        Top = 168
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 13
      end
      object cbxC34: TComboBox
        Left = 24
        Top = 168
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 12
      end
      object cbxC23: TComboBox
        Left = 504
        Top = 120
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 11
      end
      object cbxC12: TComboBox
        Left = 344
        Top = 120
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 10
      end
      object cbxC01: TComboBox
        Left = 184
        Top = 120
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 9
      end
      object cbxBlw: TComboBox
        Left = 24
        Top = 24
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object tbGCtrl: TTabSheet
      Caption = '&Game Controller'
      ImageIndex = 1
      object Label17: TLabel
        Left = 24
        Top = 56
        Width = 20
        Height = 13
        Caption = 'Tiup'
      end
      object Label25: TLabel
        Left = 184
        Top = 56
        Width = 59
        Height = 13
        Caption = 'Lubang ke-0'
      end
      object Label26: TLabel
        Left = 344
        Top = 56
        Width = 59
        Height = 13
        Caption = 'Lubang ke-1'
      end
      object Label27: TLabel
        Left = 24
        Top = 104
        Width = 59
        Height = 13
        Caption = 'Lubang ke-2'
      end
      object Label28: TLabel
        Left = 184
        Top = 104
        Width = 59
        Height = 13
        Caption = 'Lubang ke-3'
      end
      object Label29: TLabel
        Left = 344
        Top = 104
        Width = 59
        Height = 13
        Caption = 'Lubang ke-4'
      end
      object Label30: TLabel
        Left = 184
        Top = 152
        Width = 59
        Height = 13
        Caption = 'Lubang ke-6'
      end
      object Label31: TLabel
        Left = 24
        Top = 152
        Width = 59
        Height = 13
        Caption = 'Lubang ke-5'
      end
      object Label32: TLabel
        Left = 344
        Top = 152
        Width = 59
        Height = 13
        Caption = 'Lubang ke-7'
      end
      object Label18: TLabel
        Left = 24
        Top = 8
        Width = 129
        Height = 13
        Caption = 'Perangkat Game Controller'
      end
      object cbxJBlow: TComboBox
        Left = 24
        Top = 72
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
      end
      object cbxJH0: TComboBox
        Left = 184
        Top = 72
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
      end
      object cbxJH1: TComboBox
        Left = 344
        Top = 72
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
      end
      object cbxJH2: TComboBox
        Left = 24
        Top = 120
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
      end
      object cbxJH3: TComboBox
        Left = 184
        Top = 120
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 5
      end
      object cbxJH4: TComboBox
        Left = 344
        Top = 120
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 6
      end
      object cbxJH5: TComboBox
        Left = 24
        Top = 168
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 7
      end
      object cbxJH6: TComboBox
        Left = 184
        Top = 168
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 8
      end
      object cbxJH7: TComboBox
        Left = 344
        Top = 168
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 9
      end
      object cbGctrl: TComboBox
        Left = 24
        Top = 24
        Width = 465
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 10
      end
      object cbxUseGc: TCheckBox
        Left = 504
        Top = 24
        Width = 153
        Height = 17
        Caption = 'Gunakan controller'
        TabOrder = 1
      end
    end
  end
end
