object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Typwriter'
  ClientHeight = 554
  ClientWidth = 654
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 654
    Height = 384
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 0
    object Image1: TImage
      Left = 3
      Top = 3
      Width = 241
      Height = 217
      AutoSize = True
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 384
    Width = 654
    Height = 170
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 390
    object Label1: TLabel
      Left = 13
      Top = 27
      Width = 62
      Height = 15
      Caption = 'Alignment :'
    end
    object Label2: TLabel
      Left = 40
      Top = 54
      Width = 35
      Height = 15
      Caption = 'Fonts :'
    end
    object Label3: TLabel
      Left = 320
      Top = 24
      Width = 78
      Height = 15
      Caption = 'Image Height :'
    end
    object Label4: TLabel
      Left = 324
      Top = 56
      Width = 74
      Height = 15
      Caption = 'Image Width :'
    end
    object Shape1: TShape
      Left = 404
      Top = 86
      Width = 20
      Height = 20
      Cursor = crHandPoint
      Brush.Color = clBlack
      OnMouseDown = Shape1MouseDown
    end
    object Label5: TLabel
      Left = 338
      Top = 88
      Width = 60
      Height = 15
      Caption = 'BGR Color :'
    end
    object Label6: TLabel
      Left = 49
      Top = 83
      Width = 26
      Height = 15
      Caption = 'Size :'
    end
    object Shape2: TShape
      Left = 81
      Top = 110
      Width = 20
      Height = 20
      Cursor = crHandPoint
      OnMouseDown = Shape2MouseDown
    end
    object Label7: TLabel
      Left = 40
      Top = 112
      Width = 35
      Height = 15
      Caption = 'Color :'
    end
    object Label8: TLabel
      Left = 128
      Top = 112
      Width = 36
      Height = 15
      Caption = 'Brush :'
    end
    object Shape3: TShape
      Left = 170
      Top = 110
      Width = 20
      Height = 20
      Cursor = crHandPoint
      Brush.Color = clRed
      OnMouseDown = Shape3MouseDown
    end
    object Label9: TLabel
      Left = 44
      Top = 138
      Width = 31
      Height = 15
      Caption = 'Style :'
    end
    object Label10: TLabel
      Left = 336
      Top = 131
      Width = 62
      Height = 15
      Caption = 'Delay (ms) :'
    end
    object Label11: TLabel
      Left = 176
      Top = 24
      Width = 37
      Height = 15
      Caption = 'Space :'
    end
    object Label12: TLabel
      Left = 505
      Top = 24
      Width = 37
      Height = 15
      Caption = 'X-Pos :'
    end
    object Label13: TLabel
      Left = 505
      Top = 56
      Width = 37
      Height = 15
      Caption = 'Y-Pos :'
    end
    object Button1: TButton
      Left = 488
      Top = 129
      Width = 75
      Height = 25
      Caption = 'Type'
      TabOrder = 0
      TabStop = False
      OnClick = Button1Click
    end
    object ComboBox1: TComboBox
      Left = 81
      Top = 22
      Width = 83
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'Vertical'
      Items.Strings = (
        'Vertical'
        'Horizontal')
    end
    object ComboBox2: TComboBox
      Left = 81
      Top = 51
      Width = 192
      Height = 23
      Style = csDropDownList
      DropDownCount = 30
      TabOrder = 2
    end
    object SpinEdit1: TSpinEdit
      Left = 404
      Top = 22
      Width = 65
      Height = 24
      TabStop = False
      MaxLength = 4
      MaxValue = 2000
      MinValue = 1
      TabOrder = 3
      Value = 400
      OnChange = SpinEdit1Change
    end
    object SpinEdit2: TSpinEdit
      Left = 404
      Top = 52
      Width = 65
      Height = 24
      TabStop = False
      MaxLength = 4
      MaxValue = 2000
      MinValue = 1
      TabOrder = 4
      Value = 650
    end
    object SpinEdit3: TSpinEdit
      Left = 81
      Top = 80
      Width = 56
      Height = 24
      MaxLength = 3
      MaxValue = 100
      MinValue = 1
      TabOrder = 5
      Value = 18
    end
    object ComboBox3: TComboBox
      Left = 81
      Top = 135
      Width = 109
      Height = 23
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 6
      Text = 'Solid'
      Items.Strings = (
        'Transparent'
        'Solid')
    end
    object SpinEdit4: TSpinEdit
      Left = 404
      Top = 128
      Width = 65
      Height = 24
      TabStop = False
      MaxLength = 4
      MaxValue = 1000
      MinValue = 1
      TabOrder = 7
      Value = 80
    end
    object SpinEdit5: TSpinEdit
      Left = 222
      Top = 21
      Width = 51
      Height = 24
      MaxLength = 3
      MaxValue = 100
      MinValue = 1
      TabOrder = 8
      Value = 10
    end
    object CheckBox1: TCheckBox
      Left = 505
      Top = 88
      Width = 97
      Height = 17
      TabStop = False
      Caption = 'Overwrite text'
      TabOrder = 9
    end
    object SpinEdit6: TSpinEdit
      Left = 548
      Top = 22
      Width = 65
      Height = 24
      TabStop = False
      MaxLength = 4
      MaxValue = 2000
      MinValue = 0
      TabOrder = 10
      Value = 50
    end
    object SpinEdit7: TSpinEdit
      Left = 548
      Top = 52
      Width = 65
      Height = 24
      TabStop = False
      MaxLength = 4
      MaxValue = 2000
      MinValue = 0
      TabOrder = 11
      Value = 10
    end
    object Button2: TButton
      Left = 569
      Top = 128
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 12
      TabStop = False
      OnClick = Button2Click
    end
  end
  object ColorDialog1: TColorDialog
    Left = 56
    Top = 48
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 144
    Top = 48
  end
end
