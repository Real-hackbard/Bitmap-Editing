object Form1: TForm1
  Left = 360
  Top = 166
  Caption = 'Animate Canvas'
  ClientHeight = 525
  ClientWidth = 769
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 596
    Height = 525
    Align = alClient
    OnPaint = PaintBox1Paint
    ExplicitWidth = 592
    ExplicitHeight = 524
  end
  object Panel1: TPanel
    Left = 596
    Top = 0
    Width = 173
    Height = 525
    Align = alRight
    BevelOuter = bvNone
    Color = 15790320
    TabOrder = 0
    ExplicitLeft = 592
    ExplicitHeight = 524
    object Label1: TLabel
      Left = 16
      Top = 144
      Width = 89
      Height = 16
      Caption = 'Speed (ms) :'
    end
    object TrackBar1: TTrackBar
      Left = 16
      Top = 24
      Width = 137
      Height = 45
      Max = 100
      Min = 10
      Frequency = 10
      Position = 50
      TabOrder = 0
      TabStop = False
      OnChange = PaintBox1Paint
    end
    object Button1: TButton
      Left = 24
      Top = 75
      Width = 129
      Height = 25
      Caption = 'Animate'
      TabOrder = 1
      TabStop = False
      OnClick = Button1Click
    end
    object SpinEdit1: TSpinEdit
      Left = 111
      Top = 141
      Width = 49
      Height = 26
      TabStop = False
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 35
      OnChange = SpinEdit1Change
    end
    object RadioGroup1: TRadioGroup
      Left = 24
      Top = 208
      Width = 129
      Height = 113
      Caption = ' Canvas '
      ItemIndex = 0
      Items.Strings = (
        'None'
        'Circle'
        'Elipse')
      TabOrder = 3
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 35
    OnTimer = Timer1Timer
    Left = 24
    Top = 40
  end
end
