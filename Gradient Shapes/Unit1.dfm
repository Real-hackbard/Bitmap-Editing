object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Gradient Shapes'
  ClientHeight = 597
  ClientWidth = 775
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 410
    Top = 571
    Width = 72
    Height = 15
    Caption = 'Pixel Format :'
  end
  object Shape1: TShape
    Left = 600
    Top = 569
    Width = 25
    Height = 20
    Cursor = crHandPoint
    OnMouseDown = Shape1MouseDown
  end
  object Label2: TLabel
    Left = 568
    Top = 571
    Width = 28
    Height = 15
    Caption = 'BGR :'
  end
  object Shape2: TShape
    Left = 104
    Top = 569
    Width = 20
    Height = 20
    Cursor = crHandPoint
    Brush.Color = clYellow
    OnMouseDown = Shape2MouseDown
  end
  object Shape3: TShape
    Left = 130
    Top = 569
    Width = 20
    Height = 20
    Cursor = crHandPoint
    Brush.Color = clRed
    OnMouseDown = Shape3MouseDown
  end
  object Shape4: TShape
    Left = 256
    Top = 569
    Width = 20
    Height = 20
    Cursor = crHandPoint
    Brush.Color = clAqua
    OnMouseDown = Shape4MouseDown
  end
  object Shape5: TShape
    Left = 282
    Top = 569
    Width = 20
    Height = 20
    Cursor = crHandPoint
    Brush.Color = clNavy
    OnMouseDown = Shape5MouseDown
  end
  object Button1: TButton
    Left = 15
    Top = 564
    Width = 75
    Height = 25
    Caption = 'Rectangle'
    TabOrder = 0
    TabStop = False
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 168
    Top = 564
    Width = 75
    Height = 25
    Caption = 'Ellipse'
    TabOrder = 1
    TabStop = False
    OnClick = Button2Click
  end
  object ScrollBox1: TScrollBox
    Left = 8
    Top = 16
    Width = 759
    Height = 542
    TabOrder = 2
    object Image1: TImage
      Left = 3
      Top = 4
      Width = 749
      Height = 525
      Cursor = crHandPoint
      AutoSize = True
    end
  end
  object Button3: TButton
    Left = 687
    Top = 564
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 3
    OnClick = Button3Click
  end
  object ComboBox1: TComboBox
    Left = 488
    Top = 568
    Width = 57
    Height = 23
    Style = csDropDownList
    ItemIndex = 2
    TabOrder = 4
    Text = '24 bit'
    OnChange = ComboBox1Change
    Items.Strings = (
      '4 bit'
      '8 bit'
      '24 bit'
      '32 bit')
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 64
    Top = 72
  end
  object ColorDialog1: TColorDialog
    Left = 152
    Top = 72
  end
end
