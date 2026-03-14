object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Tile Bitmap'
  ClientHeight = 552
  ClientWidth = 755
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 16
  object Label1: TLabel
    Left = 120
    Top = 483
    Width = 65
    Height = 16
    Caption = 'X-Count :'
  end
  object Label2: TLabel
    Left = 120
    Top = 513
    Width = 65
    Height = 16
    Caption = 'Y-Count :'
  end
  object Label3: TLabel
    Left = 280
    Top = 518
    Width = 76
    Height = 16
    Caption = 'Dimension :'
  end
  object Label4: TLabel
    Left = 294
    Top = 489
    Width = 62
    Height = 16
    Caption = 'Pixel Bit :'
  end
  object Label5: TLabel
    Left = 362
    Top = 518
    Width = 83
    Height = 16
    Caption = 'X : 0 - Y : 0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 24
    Top = 480
    Width = 75
    Height = 25
    Caption = 'Bitmap'
    TabOrder = 0
    TabStop = False
    OnClick = Button1Click
  end
  object ScrollBox1: TScrollBox
    Left = 8
    Top = 8
    Width = 737
    Height = 457
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    TabOrder = 1
    object Image1: TImage
      Left = 3
      Top = 3
      Width = 107
      Height = 112
    end
  end
  object SpinEdit1: TSpinEdit
    Left = 191
    Top = 480
    Width = 66
    Height = 26
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    MaxLength = 2
    MaxValue = 10
    MinValue = 1
    ParentFont = False
    TabOrder = 2
    Value = 4
    OnChange = SpinEdit1Change
  end
  object SpinEdit2: TSpinEdit
    Left = 191
    Top = 510
    Width = 66
    Height = 26
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    MaxLength = 2
    MaxValue = 10
    MinValue = 1
    ParentFont = False
    TabOrder = 3
    Value = 4
    OnChange = SpinEdit2Change
  end
  object ComboBox1: TComboBox
    Left = 362
    Top = 486
    Width = 81
    Height = 24
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 4
    TabStop = False
    Text = '24 bit'
    Items.Strings = (
      '24 bit'
      '32 bit')
  end
  object Button2: TButton
    Left = 654
    Top = 480
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 5
    TabStop = False
    OnClick = Button2Click
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 144
    Top = 64
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 232
    Top = 64
  end
end
