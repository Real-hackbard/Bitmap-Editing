object Form1: TForm1
  Left = 421
  Top = 156
  Caption = 'Gradient Sphere Drawer'
  ClientHeight = 483
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 433
    Height = 329
    AutoSize = True
    PopupMenu = PopupMenu1
  end
  object Panel1: TPanel
    Left = 0
    Top = 432
    Width = 505
    Height = 51
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 160
      Top = 24
      Width = 89
      Height = 13
      Hint = 
        'Augmentez le nombre de traitements afin d'#39'obtenir des mesures si' +
        'gnificatives'
      AutoSize = False
      Caption = 'Nbre de passes:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Button3: TButton
      Tag = 24
      Left = 312
      Top = 8
      Width = 129
      Height = 33
      Hint = 'Change the Bmp format (24 or 32 bits)'
      Caption = 'PixelFormat : 24 bits'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = Button3Click
    end
    object Button2: TButton
      Tag = 9999999
      Left = 160
      Top = 8
      Width = 145
      Height = 33
      Hint = 'Launches Andres'#39' algorithm calculated in memory'
      Caption = 'Memory Gradient'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
      WordWrap = True
      OnClick = Button2Click
    end
    object Button1: TButton
      Tag = 9999999
      Left = 8
      Top = 8
      Width = 145
      Height = 33
      Hint = 'Launch Andres'#39' algorithm calculated on the TCanvas'
      Caption = 'Canvas Gradient'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TabStop = False
      WordWrap = True
      OnClick = Button1Click
    end
    object edtTimes: TEdit
      Left = 456
      Top = 16
      Width = 25
      Height = 21
      Hint = 
        'Augmentez le nombre de traitements afin d'#39'obtenir des mesures si' +
        'gnificatives'
      TabStop = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 3
      Text = '1'
    end
    object UpDown1: TUpDown
      Left = 481
      Top = 16
      Width = 15
      Height = 21
      Hint = 
        'Augmentez le nombre de traitements afin d'#39'obtenir des mesures si' +
        'gnificatives'
      Associate = edtTimes
      Min = 1
      ParentShowHint = False
      Position = 1
      ShowHint = True
      TabOrder = 4
      OnChanging = UpDown1Changing
    end
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 24
    Top = 48
  end
  object PopupMenu1: TPopupMenu
    Left = 56
    Top = 48
    object S1: TMenuItem
      Caption = 'Save'
      OnClick = S1Click
    end
  end
end
