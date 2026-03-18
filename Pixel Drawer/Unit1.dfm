object Form1: TForm1
  Left = 330
  Top = 172
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Pixel Drawer'
  ClientHeight = 610
  ClientWidth = 591
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 591
    Height = 496
    Align = alClient
    OnPaint = PaintBox1Paint
    ExplicitWidth = 589
    ExplicitHeight = 561
  end
  object Panel1: TPanel
    Left = 0
    Top = 496
    Width = 591
    Height = 114
    Align = alBottom
    Color = 15790320
    TabOrder = 0
    ExplicitTop = 502
    object Label1: TLabel
      Left = 10
      Top = 22
      Width = 51
      Height = 16
      Caption = 'Points :'
    end
    object Label6: TLabel
      Left = 18
      Top = 49
      Width = 43
      Height = 16
      Caption = 'Edge :'
    end
    object Label7: TLabel
      Left = 8
      Top = 79
      Width = 53
      Height = 16
      Caption = 'Border :'
    end
    object Label11: TLabel
      Left = 472
      Top = 46
      Width = 28
      Height = 16
      Caption = 'Bit :'
    end
    object Button1: TButton
      Left = 471
      Top = 74
      Width = 51
      Height = 25
      Caption = 'Draw'
      TabOrder = 0
      TabStop = False
      OnClick = PaintBox1Paint
    end
    object Edit1: TEdit
      Left = 67
      Top = 18
      Width = 78
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '100000'
    end
    object Button2: TButton
      Left = 528
      Top = 74
      Width = 51
      Height = 25
      Caption = 'Save'
      TabOrder = 2
      TabStop = False
      OnClick = Button2Click
    end
    object GroupBox1: TGroupBox
      Left = 151
      Top = 6
      Width = 185
      Height = 97
      Caption = ' Inclination '
      TabOrder = 3
      object Label2: TLabel
        Left = 18
        Top = 27
        Width = 26
        Height = 16
        Caption = 'x1 :'
      end
      object Label3: TLabel
        Left = 18
        Top = 59
        Width = 26
        Height = 16
        Caption = 'x2 :'
      end
      object Label4: TLabel
        Left = 97
        Top = 27
        Width = 27
        Height = 16
        Caption = 'y1 :'
      end
      object Label5: TLabel
        Left = 97
        Top = 59
        Width = 27
        Height = 16
        Caption = 'y2 :'
      end
      object SpinEdit1: TSpinEdit
        Left = 48
        Top = 24
        Width = 41
        Height = 26
        TabStop = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        MaxLength = 2
        MaxValue = 0
        MinValue = -25
        ParentFont = False
        TabOrder = 0
        Value = -4
        OnChange = SpinEdit1Change
      end
      object SpinEdit2: TSpinEdit
        Left = 48
        Top = 56
        Width = 41
        Height = 26
        TabStop = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        MaxLength = 2
        MaxValue = 25
        MinValue = 0
        ParentFont = False
        TabOrder = 1
        Value = 4
        OnChange = SpinEdit2Change
      end
      object SpinEdit3: TSpinEdit
        Left = 128
        Top = 24
        Width = 41
        Height = 26
        TabStop = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        MaxLength = 2
        MaxValue = 25
        MinValue = 0
        ParentFont = False
        TabOrder = 2
        Value = 11
        OnChange = SpinEdit3Change
      end
      object SpinEdit4: TSpinEdit
        Left = 128
        Top = 56
        Width = 41
        Height = 26
        TabStop = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        MaxLength = 2
        MaxValue = 0
        MinValue = -25
        ParentFont = False
        TabOrder = 3
        Value = -1
        OnChange = SpinEdit4Change
      end
    end
    object SpinEdit5: TSpinEdit
      Left = 67
      Top = 46
      Width = 78
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
      TabOrder = 4
      Value = 1000
      OnChange = SpinEdit5Change
    end
    object SpinEdit6: TSpinEdit
      Left = 67
      Top = 76
      Width = 78
      Height = 26
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      MaxLength = 6
      MaxValue = 500000
      MinValue = 1000
      ParentFont = False
      TabOrder = 5
      Value = 500000
    end
    object GroupBox2: TGroupBox
      Left = 342
      Top = 6
      Width = 106
      Height = 99
      Caption = ' Colors'
      TabOrder = 6
      object Label8: TLabel
        Left = 31
        Top = 26
        Width = 36
        Height = 16
        Caption = 'BGR :'
      end
      object Label9: TLabel
        Left = 20
        Top = 47
        Width = 47
        Height = 16
        Caption = 'Pixels :'
      end
      object Label10: TLabel
        Left = 16
        Top = 70
        Width = 51
        Height = 16
        Caption = 'Frame :'
      end
      object Shape1: TShape
        Left = 72
        Top = 24
        Width = 20
        Height = 20
        Cursor = crHandPoint
        OnMouseDown = Shape1MouseDown
      end
      object Shape2: TShape
        Left = 72
        Top = 47
        Width = 20
        Height = 20
        Cursor = crHandPoint
        Brush.Color = clBlack
        OnMouseDown = Shape2MouseDown
      end
      object Shape3: TShape
        Left = 72
        Top = 70
        Width = 20
        Height = 20
        Cursor = crHandPoint
        OnMouseDown = Shape3MouseDown
      end
    end
    object CheckBox1: TCheckBox
      Left = 471
      Top = 19
      Width = 63
      Height = 17
      Caption = 'Frame'
      TabOrder = 7
      OnClick = CheckBox1Click
    end
    object ComboBox1: TComboBox
      Left = 512
      Top = 42
      Width = 67
      Height = 24
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 8
      Text = '24'
      Items.Strings = (
        '8'
        '24'
        '32')
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 48
    Top = 48
  end
  object ColorDialog1: TColorDialog
    Left = 128
    Top = 48
  end
end
