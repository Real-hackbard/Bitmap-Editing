object Form1: TForm1
  Left = 0
  Top = 0
  Cursor = crArrow
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Gradient Drawer'
  ClientHeight = 510
  ClientWidth = 518
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 16
  object Label1: TLabel
    Left = 24
    Top = 344
    Width = 75
    Height = 16
    Caption = 'Alignment :'
  end
  object Label2: TLabel
    Left = 228
    Top = 344
    Width = 121
    Height = 16
    Caption = 'Image Dimension :'
  end
  object Button1: TButton
    Left = 425
    Top = 441
    Width = 75
    Height = 25
    Caption = 'Draw'
    TabOrder = 0
    TabStop = False
    OnClick = Button1Click
  end
  object ComboBox1: TComboBox
    Left = 355
    Top = 341
    Width = 145
    Height = 24
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 1
    TabStop = False
    Text = 'Custom'
    Items.Strings = (
      'Custom'
      'Image Dimension')
  end
  object Button2: TButton
    Left = 425
    Top = 472
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 2
    TabStop = False
    OnClick = Button2Click
  end
  object GroupBox1: TGroupBox
    Left = 13
    Top = 385
    Width = 108
    Height = 112
    Caption = ' Size '
    TabOrder = 3
    object Label4: TLabel
      Left = 8
      Top = 43
      Width = 20
      Height = 16
      Caption = 'X :'
    end
    object Label5: TLabel
      Left = 8
      Top = 75
      Width = 20
      Height = 16
      Caption = 'Y :'
    end
    object SpinEdit1: TSpinEdit
      Left = 34
      Top = 40
      Width = 65
      Height = 26
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      MaxLength = 4
      MaxValue = 2000
      MinValue = 1
      ParentFont = False
      TabOrder = 0
      Value = 300
    end
    object SpinEdit2: TSpinEdit
      Left = 34
      Top = 72
      Width = 65
      Height = 26
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      MaxLength = 4
      MaxValue = 2000
      MinValue = 1
      ParentFont = False
      TabOrder = 1
      Value = 900
    end
  end
  object GroupBox2: TGroupBox
    Left = 127
    Top = 385
    Width = 138
    Height = 112
    Caption = ' Colors'
    TabOrder = 4
    object Label3: TLabel
      Left = 14
      Top = 43
      Width = 60
      Height = 16
      Caption = 'Number :'
    end
    object Shape1: TShape
      Left = 40
      Top = 80
      Width = 17
      Height = 17
      Cursor = crHandPoint
      Brush.Color = clRed
      OnMouseDown = Shape1MouseDown
    end
    object Shape2: TShape
      Left = 63
      Top = 80
      Width = 17
      Height = 17
      Cursor = crHandPoint
      Brush.Color = clLime
      OnMouseDown = Shape2MouseDown
    end
    object Shape3: TShape
      Left = 86
      Top = 80
      Width = 17
      Height = 17
      Cursor = crHandPoint
      Brush.Color = clNavy
      OnMouseDown = Shape3MouseDown
    end
    object Shape4: TShape
      Left = 109
      Top = 80
      Width = 17
      Height = 17
      Cursor = crHandPoint
      OnMouseDown = Shape4MouseDown
    end
    object ComboBox3: TComboBox
      Left = 94
      Top = 40
      Width = 41
      Height = 24
      Style = csDropDownList
      ItemIndex = 2
      TabOrder = 0
      TabStop = False
      Text = '4'
      OnChange = ComboBox3Change
      Items.Strings = (
        '2'
        '3'
        '4')
    end
  end
  object ComboBox2: TComboBox
    Left = 105
    Top = 341
    Width = 104
    Height = 24
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 5
    TabStop = False
    Text = 'Vertical'
    Items.Strings = (
      'Vertical'
      'Horizontal')
  end
  object RadioGroup1: TRadioGroup
    Left = 271
    Top = 390
    Width = 124
    Height = 112
    Caption = ' Pixel Bit'
    Columns = 2
    ItemIndex = 2
    Items.Strings = (
      '8'
      '16'
      '24'
      '32')
    TabOrder = 6
  end
  object ScrollBox1: TScrollBox
    Left = 8
    Top = 16
    Width = 502
    Height = 305
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    TabOrder = 7
    object Image1: TImage
      Left = 3
      Top = 5
      Width = 492
      Height = 284
    end
  end
  object ColorDialog1: TColorDialog
    Left = 48
    Top = 56
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 144
    Top = 56
  end
end
