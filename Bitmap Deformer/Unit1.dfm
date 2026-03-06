object Form1: TForm1
  Left = 302
  Top = 187
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Bitmap Deformer 1.0'
  ClientHeight = 392
  ClientWidth = 698
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 276
    Height = 13
    Caption = 'Move the corners of the image with the mouse to deform it.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 373
    Width = 698
    Height = 19
    Panels = <
      item
        Text = 'Pattern2'
        Width = 50
      end>
    ExplicitTop = 387
    ExplicitWidth = 696
  end
  object Panel1: TPanel
    Left = 0
    Top = 332
    Width = 698
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 346
    ExplicitWidth = 696
    object Label2: TLabel
      Left = 200
      Top = 16
      Width = 40
      Height = 13
      Caption = 'Pattern :'
    end
    object Button2: TButton
      Left = 96
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Render'
      TabOrder = 0
      TabStop = False
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 16
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Bitmap'
      TabOrder = 1
      TabStop = False
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 605
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 2
      TabStop = False
      OnClick = Button3Click
    end
    object ComboBox1: TComboBox
      Left = 246
      Top = 12
      Width = 99
      Height = 21
      ItemIndex = 1
      TabOrder = 3
      TabStop = False
      Text = 'Pattern2'
      OnChange = ComboBox1Change
      Items.Strings = (
        'Pattern1'
        'Pattern2')
    end
    object CheckBox1: TCheckBox
      Left = 364
      Top = 14
      Width = 129
      Height = 17
      TabStop = False
      Caption = 'Quadrangles in Corner'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = CheckBox1Click
    end
  end
  object Panel2: TPanel
    Left = 8
    Top = 45
    Width = 337
    Height = 276
    TabOrder = 2
    object PaintBox1: TPaintBox
      Left = 7
      Top = 11
      Width = 322
      Height = 254
      OnMouseDown = PaintBox1MouseDown
      OnMouseMove = PaintBox1MouseMove
      OnMouseUp = PaintBox1MouseUp
      OnPaint = PaintBox1Paint
    end
  end
  object Panel3: TPanel
    Left = 351
    Top = 45
    Width = 338
    Height = 276
    TabOrder = 3
    object Image1: TImage
      Left = 13
      Top = 11
      Width = 316
      Height = 254
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 96
    Top = 96
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 224
    Top = 104
  end
end
