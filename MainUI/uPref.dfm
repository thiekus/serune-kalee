object frmPref: TfrmPref
  Left = 213
  Top = 110
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Preferensi'
  ClientHeight = 383
  ClientWidth = 356
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 344
    Width = 337
    Height = 2
    Shape = bsBottomLine
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 96
    Width = 337
    Height = 81
    Caption = 'Tampilan'
    TabOrder = 1
    object Label3: TLabel
      Left = 16
      Top = 24
      Width = 131
      Height = 13
      Caption = 'Pilih tema tampilan program'
    end
    object cbxThm: TComboBox
      Left = 16
      Top = 40
      Width = 305
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Merah Putih'
      Items.Strings = (
        'Merah Putih')
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 184
    Width = 337
    Height = 153
    Caption = 'Pengaturan lanjutan'
    TabOrder = 2
    object Label4: TLabel
      Left = 32
      Top = 48
      Width = 283
      Height = 41
      AutoSize = False
      Caption = 
        '(Suara Serune langsung dibunyikan ketika menekan lubang tanpa ha' +
        'rus ditiup terlebih dahulu. Anda dapat mengganti modus ini pada ' +
        'layar utama dengan menekan Shift)'
      WordWrap = True
    end
    object cbxDrc: TCheckBox
      Left = 16
      Top = 24
      Width = 305
      Height = 17
      Caption = 'Modus langsung'
      TabOrder = 0
    end
    object cbxCmb: TCheckBox
      Left = 16
      Top = 96
      Width = 297
      Height = 17
      Caption = 'Gunakan tombol kombinasi pada keyboard'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object cbxShl: TCheckBox
      Left = 16
      Top = 120
      Width = 305
      Height = 17
      Caption = 'Integerasikan file *.skt ke program ini'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object Button1: TButton
    Left = 128
    Top = 352
    Width = 105
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 240
    Top = 352
    Width = 105
    Height = 25
    Caption = '&Batal'
    ModalResult = 2
    TabOrder = 4
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 337
    Height = 81
    Caption = 'Perangkat suara OpenAL'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 242
      Height = 13
      Caption = 'Pilih perangkat atau wrapper untuk library OpenAL'
    end
    object cbOal: TComboBox
      Left = 16
      Top = 40
      Width = 305
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Soft OpenAL'
      Items.Strings = (
        'Soft OpenAL')
    end
  end
end
