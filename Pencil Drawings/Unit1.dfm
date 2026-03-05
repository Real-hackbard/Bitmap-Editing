object Form1: TForm1
  Left = 1739
  Top = 203
  Caption = 'Pencil Drawings'
  ClientHeight = 445
  ClientWidth = 650
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 150
    Height = 433
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitHeight = 432
    object Label1: TLabel
      Left = 7
      Top = 7
      Width = 59
      Height = 13
      Caption = 'Contrast: 0%'
      Enabled = False
    end
    object Label2: TLabel
      Left = 7
      Top = 46
      Width = 72
      Height = 13
      Caption = 'Brightness:: 0%'
      Enabled = False
    end
    object Label3: TLabel
      Left = 7
      Top = 85
      Width = 62
      Height = 13
      Caption = 'Pencil size: 3'
      Enabled = False
    end
    object Label4: TLabel
      Left = 7
      Top = 124
      Width = 75
      Height = 13
      Caption = 'Main Angle: 45'#176
      Enabled = False
    end
    object Label5: TLabel
      Left = 7
      Top = 163
      Width = 63
      Height = 13
      Caption = 'Variation: '#177'0'#176
      Enabled = False
    end
    object Label6: TLabel
      Left = 7
      Top = 202
      Width = 70
      Height = 13
      Caption = 'Line length: 10'
      Enabled = False
    end
    object Label7: TLabel
      Left = 7
      Top = 241
      Width = 83
      Height = 13
      Caption = 'Trait Quantity: 5%'
      Enabled = False
    end
    object Label8: TLabel
      Left = 88
      Top = 336
      Width = 17
      Height = 13
      Caption = '0 %'
    end
    object Label9: TLabel
      Left = 32
      Top = 336
      Width = 47
      Height = 13
      Caption = 'Progress :'
    end
    object ScrollBar1: TScrollBar
      Left = 7
      Top = 26
      Width = 137
      Height = 13
      Enabled = False
      Max = 1024
      Min = -255
      PageSize = 0
      TabOrder = 0
      TabStop = False
      OnChange = ScrollBar1Change
    end
    object ScrollBar2: TScrollBar
      Left = 7
      Top = 65
      Width = 137
      Height = 13
      Enabled = False
      Max = 255
      Min = -255
      PageSize = 0
      TabOrder = 1
      TabStop = False
      OnChange = ScrollBar1Change
    end
    object ScrollBar3: TScrollBar
      Left = 7
      Top = 104
      Width = 137
      Height = 13
      Max = 50
      Min = 1
      PageSize = 0
      Position = 3
      TabOrder = 2
      TabStop = False
      OnChange = ScrollBar1Change
    end
    object ScrollBar4: TScrollBar
      Left = 7
      Top = 143
      Width = 137
      Height = 13
      Max = 360
      PageSize = 0
      Position = 45
      TabOrder = 3
      TabStop = False
      OnChange = ScrollBar1Change
    end
    object ScrollBar5: TScrollBar
      Left = 7
      Top = 182
      Width = 137
      Height = 13
      Enabled = False
      Max = 90
      PageSize = 0
      TabOrder = 4
      TabStop = False
      OnChange = ScrollBar1Change
    end
    object ScrollBar6: TScrollBar
      Left = 7
      Top = 221
      Width = 137
      Height = 13
      Max = 60
      Min = 1
      PageSize = 0
      Position = 10
      TabOrder = 5
      TabStop = False
      OnChange = ScrollBar1Change
    end
    object ScrollBar7: TScrollBar
      Left = 7
      Top = 260
      Width = 137
      Height = 13
      Min = 1
      PageSize = 0
      Position = 5
      TabOrder = 6
      TabStop = False
      OnChange = ScrollBar1Change
    end
    object Button1: TButton
      Left = 7
      Top = 368
      Width = 137
      Height = 25
      Caption = 'Picture'
      TabOrder = 7
      TabStop = False
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 7
      Top = 400
      Width = 137
      Height = 25
      Caption = 'Save'
      TabOrder = 8
      TabStop = False
      OnClick = Button2Click
    end
  end
  object ScrollBox1: TScrollBox
    Left = 150
    Top = 0
    Width = 500
    Height = 433
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 1
    ExplicitWidth = 496
    ExplicitHeight = 432
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 265
      Height = 321
      OnPaint = PaintBox1Paint
    end
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 433
    Width = 650
    Height = 12
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 432
    ExplicitWidth = 646
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 265
    Top = 48
  end
  object SavePictureDialog1: TSavePictureDialog
    Left = 297
    Top = 48
  end
end
