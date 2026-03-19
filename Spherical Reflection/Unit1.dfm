object Form1: TForm1
  Left = 224
  Top = 153
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Spherical Reflection'
  ClientHeight = 570
  ClientWidth = 974
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 494
    Top = 24
    Width = 480
    Height = 480
  end
  object Label1: TLabel
    Left = 256
    Top = 534
    Width = 20
    Height = 16
    Caption = 'X :'
  end
  object Image1: TImage
    Left = 8
    Top = 24
    Width = 480
    Height = 480
  end
  object Label2: TLabel
    Left = 360
    Top = 534
    Width = 20
    Height = 16
    Caption = 'Y :'
  end
  object Label3: TLabel
    Left = 16
    Top = 534
    Width = 57
    Height = 16
    Caption = 'Picture :'
  end
  object Shape1: TShape
    Left = 568
    Top = 534
    Width = 25
    Height = 16
    Cursor = crHandPoint
    OnMouseDown = Shape1MouseDown
  end
  object Label4: TLabel
    Left = 488
    Top = 534
    Width = 74
    Height = 16
    Caption = 'BGR Color :'
  end
  object Button1: TButton
    Left = 800
    Top = 531
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    TabStop = False
    OnClick = Button1Click
  end
  object SpinEdit1: TSpinEdit
    Left = 282
    Top = 530
    Width = 65
    Height = 26
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    Increment = 20
    MaxValue = 1200
    MinValue = 600
    ParentFont = False
    TabOrder = 1
    Value = 760
  end
  object SpinEdit2: TSpinEdit
    Left = 392
    Top = 530
    Width = 65
    Height = 26
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    Increment = 20
    MaxValue = 1200
    MinValue = 600
    ParentFont = False
    TabOrder = 2
    Value = 1080
  end
  object ComboBox1: TComboBox
    Left = 79
    Top = 530
    Width = 153
    Height = 24
    ItemIndex = 2
    TabOrder = 3
    TabStop = False
    Text = 'Sun'
    OnChange = ComboBox1Change
    Items.Strings = (
      'Apple'
      'Palm'
      'Sun'
      'Spirale'
      'Stonehenge')
  end
  object Button2: TButton
    Left = 881
    Top = 531
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 4
    TabStop = False
    OnClick = Button2Click
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 48
    Top = 48
  end
  object ColorDialog1: TColorDialog
    Left = 128
    Top = 48
  end
end
