object Form1: TForm1
  Left = 228
  Top = 132
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Sharping'
  ClientHeight = 605
  ClientWidth = 530
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 16
  object Label1: TLabel
    Left = 260
    Top = 490
    Width = 8
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '0'
  end
  object Label2: TLabel
    Left = 12
    Top = 490
    Width = 31
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '-100'
  end
  object Label3: TLabel
    Left = 481
    Top = 490
    Width = 24
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '100'
  end
  object Label4: TLabel
    Left = 190
    Top = 571
    Width = 8
    Height = 16
    Caption = '0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 298
    Top = 571
    Width = 8
    Height = 16
    Caption = '0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 402
    Top = 571
    Width = 8
    Height = 16
    Caption = '0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 122
    Top = 571
    Width = 64
    Height = 16
    Caption = 'New (R) :'
  end
  object Label8: TLabel
    Left = 227
    Top = 571
    Width = 65
    Height = 16
    Caption = 'New (G) :'
  end
  object Label9: TLabel
    Left = 330
    Top = 571
    Width = 64
    Height = 16
    Caption = 'New (B) :'
  end
  object Label10: TLabel
    Left = 16
    Top = 544
    Width = 41
    Height = 16
    Caption = 'ready.'
  end
  object TrackBar1: TTrackBar
    Left = 24
    Top = 510
    Width = 481
    Height = 27
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Ctl3D = True
    Max = 100
    Min = -100
    ParentCtl3D = False
    Frequency = 20
    TabOrder = 0
    TabStop = False
    ThumbLength = 14
    TickMarks = tmTopLeft
    OnChange = TrackBar1Change
  end
  object ScrollBox1: TScrollBox
    Left = 8
    Top = 8
    Width = 513
    Height = 465
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    TabOrder = 1
    object Image1: TImage
      Left = 2
      Top = 2
      Width = 174
      Height = 123
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      AutoSize = True
    end
  end
  object Button1: TButton
    Left = 12
    Top = 568
    Width = 75
    Height = 25
    Caption = 'JPG'
    TabOrder = 2
    TabStop = False
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 447
    Top = 565
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 3
    TabStop = False
    OnClick = Button2Click
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Jpg (*.jpg)|*.jpg'
    Left = 216
    Top = 40
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 304
    Top = 40
  end
end
