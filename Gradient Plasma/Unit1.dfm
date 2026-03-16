object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Gradient Plasma'
  ClientHeight = 453
  ClientWidth = 787
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 16
  object Label1: TLabel
    Left = 16
    Top = 391
    Width = 53
    Height = 16
    Caption = 'Height :'
  end
  object Label2: TLabel
    Left = 20
    Top = 421
    Width = 49
    Height = 16
    Caption = 'Width :'
  end
  object Label3: TLabel
    Left = 174
    Top = 391
    Width = 28
    Height = 16
    Caption = 'Fill :'
  end
  object Label4: TLabel
    Left = 160
    Top = 421
    Width = 42
    Height = 16
    Caption = 'Step :'
  end
  object Label5: TLabel
    Left = 288
    Top = 391
    Width = 47
    Height = 16
    Caption = 'Angle :'
  end
  object Label6: TLabel
    Left = 313
    Top = 421
    Width = 22
    Height = 16
    Caption = 'Pi :'
  end
  object Label7: TLabel
    Left = 421
    Top = 391
    Width = 49
    Height = 16
    Caption = 'Curve :'
  end
  object Label8: TLabel
    Left = 424
    Top = 421
    Width = 44
    Height = 16
    Caption = 'Color :'
  end
  object Label9: TLabel
    Left = 592
    Top = 391
    Width = 28
    Height = 16
    Caption = 'Bit :'
  end
  object Label10: TLabel
    Left = 584
    Top = 421
    Width = 36
    Height = 16
    Caption = 'BGR :'
  end
  object Shape1: TShape
    Left = 626
    Top = 421
    Width = 65
    Height = 19
    Cursor = crHandPoint
    Brush.Color = clBlack
    OnMouseDown = Shape1MouseDown
  end
  object Button1: TButton
    Left = 704
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Draw'
    TabOrder = 0
    TabStop = False
    OnClick = Button1Click
  end
  object ScrollBox1: TScrollBox
    Left = 8
    Top = 8
    Width = 771
    Height = 353
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    TabOrder = 1
    object Image1: TImage
      Left = 3
      Top = 5
      Width = 105
      Height = 81
      AutoSize = True
    end
  end
  object SpinEdit1: TSpinEdit
    Left = 75
    Top = 384
    Width = 62
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
    TabOrder = 2
    Value = 340
  end
  object SpinEdit2: TSpinEdit
    Left = 75
    Top = 414
    Width = 62
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
    TabOrder = 3
    Value = 640
  end
  object SpinEdit3: TSpinEdit
    Left = 208
    Top = 384
    Width = 62
    Height = 26
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    MaxLength = 3
    MaxValue = 500
    MinValue = 1
    ParentFont = False
    TabOrder = 4
    Value = 200
  end
  object SpinEdit4: TSpinEdit
    Left = 208
    Top = 416
    Width = 62
    Height = 26
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    MaxLength = 3
    MaxValue = 255
    MinValue = 1
    ParentFont = False
    TabOrder = 5
    Value = 255
  end
  object Button2: TButton
    Left = 704
    Top = 415
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 6
    TabStop = False
    OnClick = Button2Click
  end
  object SpinEdit5: TSpinEdit
    Left = 344
    Top = 384
    Width = 62
    Height = 26
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    MaxLength = 3
    MaxValue = 360
    MinValue = 1
    ParentFont = False
    TabOrder = 7
    Value = 360
  end
  object SpinEdit6: TSpinEdit
    Left = 344
    Top = 416
    Width = 62
    Height = 26
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    MaxLength = 3
    MaxValue = 180
    MinValue = 1
    ParentFont = False
    TabOrder = 8
    Value = 180
  end
  object SpinEdit7: TSpinEdit
    Left = 476
    Top = 384
    Width = 93
    Height = 26
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    MaxLength = 4
    MaxValue = 1000
    MinValue = 0
    ParentFont = False
    TabOrder = 9
    Value = 100
  end
  object ComboBox1: TComboBox
    Left = 476
    Top = 418
    Width = 93
    Height = 24
    Style = csDropDownList
    ItemIndex = 6
    TabOrder = 10
    Text = 'White'
    Items.Strings = (
      'Red'
      'Green'
      'Blue'
      'Yellow'
      'Aqua'
      'Pink'
      'White')
  end
  object ComboBox2: TComboBox
    Left = 626
    Top = 386
    Width = 65
    Height = 24
    Style = csDropDownList
    ItemIndex = 2
    TabOrder = 11
    Text = '24'
    Items.Strings = (
      '4'
      '8'
      '24'
      '32')
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 160
    Top = 64
  end
  object ColorDialog1: TColorDialog
    Left = 248
    Top = 64
  end
end
