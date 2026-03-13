object Form1: TForm1
  Left = 0
  Top = 0
  Cursor = crArrow
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'TrueType Drawer'
  ClientHeight = 626
  ClientWidth = 517
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 16
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 497
    Height = 367
    Cursor = crHandPoint
    AutoSize = True
  end
  object Label1: TLabel
    Left = 19
    Top = 390
    Width = 47
    Height = 16
    Caption = 'Name :'
  end
  object Label2: TLabel
    Left = 28
    Top = 415
    Width = 38
    Height = 16
    Caption = 'Size :'
  end
  object Label3: TLabel
    Left = 22
    Top = 441
    Width = 44
    Height = 16
    Caption = 'Color :'
  end
  object Label5: TLabel
    Left = 26
    Top = 533
    Width = 40
    Height = 16
    Caption = 'Text :'
  end
  object Label6: TLabel
    Left = 72
    Top = 390
    Width = 46
    Height = 16
    Caption = 'Impact'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 72
    Top = 415
    Width = 16
    Height = 16
    Caption = '24'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object Shape1: TShape
    Left = 72
    Top = 441
    Width = 25
    Height = 16
    Cursor = crHandPoint
    Brush.Color = clGray
    OnMouseDown = Shape1MouseDown
  end
  object Label9: TLabel
    Left = 18
    Top = 469
    Width = 48
    Height = 16
    Caption = 'X Pos :'
  end
  object Label10: TLabel
    Left = 18
    Top = 501
    Width = 48
    Height = 16
    Caption = 'Y Pos :'
  end
  object Label8: TLabel
    Left = 320
    Top = 451
    Width = 47
    Height = 16
    Caption = 'Angle :'
  end
  object Label11: TLabel
    Left = 319
    Top = 481
    Width = 48
    Height = 16
    Caption = 'X Pos :'
  end
  object Label12: TLabel
    Left = 314
    Top = 513
    Width = 53
    Height = 16
    Caption = ' Y Pos :'
  end
  object Label13: TLabel
    Left = 327
    Top = 545
    Width = 40
    Height = 16
    Caption = 'Text :'
  end
  object Label14: TLabel
    Left = 323
    Top = 427
    Width = 44
    Height = 16
    Caption = 'Color :'
  end
  object Shape2: TShape
    Left = 373
    Top = 427
    Width = 25
    Height = 16
    Cursor = crHandPoint
    Brush.Color = clGray
    OnMouseDown = Shape2MouseDown
  end
  object Label4: TLabel
    Left = 104
    Top = 440
    Width = 47
    Height = 16
    Caption = 'Brush :'
  end
  object Shape3: TShape
    Left = 157
    Top = 441
    Width = 25
    Height = 16
    Cursor = crHandPoint
    Brush.Color = clMaroon
    OnMouseDown = Shape3MouseDown
  end
  object Label15: TLabel
    Left = 408
    Top = 427
    Width = 47
    Height = 16
    Caption = 'Brush :'
  end
  object Shape4: TShape
    Left = 461
    Top = 426
    Width = 25
    Height = 16
    Cursor = crHandPoint
    Brush.Color = clMaroon
    OnMouseDown = Shape4MouseDown
  end
  object Button1: TButton
    Left = 118
    Top = 593
    Width = 75
    Height = 25
    Caption = 'Accept'
    Enabled = False
    TabOrder = 0
    TabStop = False
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 419
    Top = 593
    Width = 75
    Height = 25
    Caption = 'Accept'
    Enabled = False
    TabOrder = 1
    TabStop = False
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 72
    Top = 530
    Width = 121
    Height = 24
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = 'Example Text'
  end
  object Button3: TButton
    Left = 218
    Top = 562
    Width = 75
    Height = 25
    Caption = 'Font'
    TabOrder = 3
    TabStop = False
    OnClick = Button3Click
  end
  object SpinEdit1: TSpinEdit
    Left = 72
    Top = 466
    Width = 121
    Height = 26
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    MaxValue = 1000
    MinValue = 1
    ParentFont = False
    TabOrder = 4
    Value = 10
  end
  object SpinEdit2: TSpinEdit
    Left = 72
    Top = 498
    Width = 121
    Height = 26
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    MaxValue = 1000
    MinValue = 1
    ParentFont = False
    TabOrder = 5
    Value = 10
  end
  object ComboBox1: TComboBox
    Left = 218
    Top = 468
    Width = 75
    Height = 24
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 6
    TabStop = False
    Text = 'Clear'
    OnChange = ComboBox1Change
    Items.Strings = (
      'Clear'
      'Solid')
  end
  object SpinEdit3: TSpinEdit
    Left = 373
    Top = 448
    Width = 121
    Height = 26
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    MaxLength = 33
    MaxValue = 360
    MinValue = 0
    ParentFont = False
    TabOrder = 7
    Value = 90
  end
  object SpinEdit4: TSpinEdit
    Left = 373
    Top = 478
    Width = 121
    Height = 26
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    MaxValue = 0
    MinValue = 0
    ParentFont = False
    TabOrder = 8
    Value = 100
  end
  object SpinEdit5: TSpinEdit
    Left = 373
    Top = 510
    Width = 121
    Height = 26
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    MaxValue = 0
    MinValue = 0
    ParentFont = False
    TabOrder = 9
    Value = 200
  end
  object Edit2: TEdit
    Left = 373
    Top = 542
    Width = 121
    Height = 24
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    Text = 'Example Text'
  end
  object CheckBox1: TCheckBox
    Left = 373
    Top = 400
    Width = 97
    Height = 17
    TabStop = False
    Caption = 'Amtialiased'
    Checked = True
    State = cbChecked
    TabOrder = 11
    OnClick = CheckBox1Click
  end
  object Button4: TButton
    Left = 218
    Top = 593
    Width = 75
    Height = 25
    Caption = 'Save'
    Enabled = False
    TabOrder = 12
    TabStop = False
    OnClick = Button4Click
  end
  object ComboBox2: TComboBox
    Left = 218
    Top = 500
    Width = 75
    Height = 24
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ItemIndex = 3
    ParentFont = False
    TabOrder = 13
    Text = '24 bit'
    Items.Strings = (
      '4 bit'
      '8 bit'
      '16 bit'
      '24 bit'
      '32 bit')
  end
  object CheckBox2: TCheckBox
    Left = 213
    Top = 417
    Width = 97
    Height = 17
    Caption = 'Overlapped'
    TabOrder = 14
  end
  object CheckBox3: TCheckBox
    Left = 213
    Top = 440
    Width = 50
    Height = 17
    Caption = 'Bold'
    TabOrder = 15
    OnClick = CheckBox3Click
  end
  object ColorDialog1: TColorDialog
    Left = 48
    Top = 64
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Left = 128
    Top = 64
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 216
    Top = 64
  end
  object ColorDialog2: TColorDialog
    Left = 40
    Top = 152
  end
  object ColorDialog3: TColorDialog
    Left = 40
    Top = 224
  end
end
