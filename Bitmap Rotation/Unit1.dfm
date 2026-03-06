object Form1: TForm1
  Left = 1788
  Top = 192
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Bitmap Rotation'
  ClientHeight = 490
  ClientWidth = 430
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
  object ImgPanel: TPanel
    Left = 0
    Top = 0
    Width = 430
    Height = 387
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 430
      Height = 387
      Align = alClient
      Center = True
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 303
      ExplicitHeight = 271
    end
  end
  object ButtonPanel: TPanel
    Left = 0
    Top = 387
    Width = 430
    Height = 103
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 393
    object SpeedLbl: TLabel
      Left = 8
      Top = 8
      Width = 259
      Height = 13
      Caption = 'Rotation speed (between 3 and 25 for optimal rotation):'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object MinLbl: TLabel
      Left = 16
      Top = 53
      Width = 6
      Height = 13
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object MaxLbl: TLabel
      Left = 282
      Top = 53
      Width = 12
      Height = 13
      Caption = '40'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object MiddleLbl: TLabel
      Left = 154
      Top = 53
      Width = 12
      Height = 13
      Caption = '20'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ChooseBitmapLbl: TLabel
      Left = 8
      Top = 80
      Width = 92
      Height = 13
      Caption = 'Choose the Bitmap:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object SepBevel2: TBevel
      Left = 300
      Top = 8
      Width = 1
      Height = 90
    end
    object SpeedBar: TTrackBar
      Left = 8
      Top = 24
      Width = 286
      Height = 27
      Max = 40
      Frequency = 5
      Position = 3
      TabOrder = 0
      TabStop = False
      OnChange = SpeedBarChange
    end
    object BitmapList: TComboBox
      Left = 106
      Top = 77
      Width = 129
      Height = 21
      Style = csDropDownList
      ItemIndex = 2
      TabOrder = 1
      TabStop = False
      Text = 'Tex'
      OnChange = BitmapListChange
      Items.Strings = (
        'Bacterius'
        'Spirale'
        'Tex')
    end
    object PauseBtn: TButton
      Left = 341
      Top = 22
      Width = 75
      Height = 25
      Caption = 'Pause'
      TabOrder = 2
      TabStop = False
      OnClick = PauseBtnClick
    end
    object Button1: TButton
      Left = 341
      Top = 53
      Width = 75
      Height = 25
      Caption = 'BGR Color'
      TabOrder = 3
      TabStop = False
      OnClick = Button1Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 64
    Top = 16
  end
  object ColorDialog1: TColorDialog
    Left = 136
    Top = 16
  end
end
