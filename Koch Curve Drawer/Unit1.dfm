object Form1: TForm1
  Left = 281
  Top = 171
  Width = 795
  Height = 609
  Caption = 'Koch Curve Drawer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 779
    Height = 570
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    TabStop = False
    object TabSheet1: TTabSheet
      Caption = 'Sierpinski Triangle'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 105
        Height = 542
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object Label4: TLabel
          Left = 8
          Top = 16
          Width = 25
          Height = 13
          Caption = 'Age :'
        end
        object SpinEdit1: TSpinEdit
          Left = 7
          Top = 32
          Width = 82
          Height = 22
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxValue = 0
          MinValue = 0
          ParentFont = False
          TabOrder = 0
          Value = 10
        end
        object Button1: TButton
          Left = 8
          Top = 152
          Width = 75
          Height = 25
          Caption = 'Draw'
          TabOrder = 1
          TabStop = False
          OnClick = Button1Click
        end
        object CheckBox1: TCheckBox
          Left = 8
          Top = 72
          Width = 51
          Height = 17
          TabStop = False
          Caption = 'Frame'
          TabOrder = 2
        end
        object CheckBox2: TCheckBox
          Left = 8
          Top = 96
          Width = 37
          Height = 17
          TabStop = False
          Caption = 'Flip'
          TabOrder = 3
          OnClick = CheckBox2Click
        end
      end
      object Panel2: TPanel
        Left = 105
        Top = 0
        Width = 666
        Height = 542
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 1
        object PaintBox1: TPaintBox
          Left = 1
          Top = 1
          Width = 664
          Height = 540
          Align = alClient
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Tree'
      ImageIndex = 1
      object Panel3: TPanel
        Left = 105
        Top = 0
        Width = 666
        Height = 542
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object PaintBox2: TPaintBox
          Left = 1
          Top = 1
          Width = 664
          Height = 540
          Align = alClient
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 105
        Height = 542
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object Label1: TLabel
          Left = 8
          Top = 94
          Width = 54
          Height = 13
          Caption = 'Left Angle :'
        end
        object Label2: TLabel
          Left = 8
          Top = 141
          Width = 61
          Height = 13
          Caption = 'Right Angle :'
        end
        object Label3: TLabel
          Left = 8
          Top = 16
          Width = 25
          Height = 13
          Caption = 'Age :'
        end
        object Label5: TLabel
          Left = 10
          Top = 188
          Width = 30
          Height = 13
          Caption = 'RND :'
        end
        object Label13: TLabel
          Left = 8
          Top = 236
          Width = 37
          Height = 13
          Caption = 'Height :'
        end
        object SpinEdit2: TSpinEdit
          Left = 7
          Top = 32
          Width = 91
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxValue = 0
          MinValue = 0
          ParentFont = False
          TabOrder = 0
          Value = 10
        end
        object SpinEdit3: TSpinEdit
          Left = 7
          Top = 111
          Width = 91
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxValue = 0
          MinValue = 0
          ParentFont = False
          TabOrder = 1
          Value = 25
        end
        object SpinEdit4: TSpinEdit
          Left = 7
          Top = 157
          Width = 91
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxValue = 0
          MinValue = 0
          ParentFont = False
          TabOrder = 2
          Value = 25
        end
        object SpinEdit5: TSpinEdit
          Left = 7
          Top = 203
          Width = 91
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxValue = 0
          MinValue = 0
          ParentFont = False
          TabOrder = 3
          Value = 0
        end
        object SpinEdit7: TSpinEdit
          Left = 7
          Top = 252
          Width = 91
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxValue = 0
          MinValue = 0
          ParentFont = False
          TabOrder = 4
          Value = 120
        end
        object Button2: TButton
          Left = 8
          Top = 320
          Width = 75
          Height = 25
          Caption = 'Draw'
          TabOrder = 5
          OnClick = Button2Click
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Dragon'
      ImageIndex = 2
      object Panel6: TPanel
        Left = 105
        Top = 0
        Width = 696
        Height = 553
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object PaintBox3: TPaintBox
          Left = 1
          Top = 1
          Width = 694
          Height = 551
          Align = alClient
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 105
        Height = 553
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object Label8: TLabel
          Left = 8
          Top = 16
          Width = 25
          Height = 13
          Caption = 'Age :'
        end
        object SpinEdit6: TSpinEdit
          Left = 7
          Top = 32
          Width = 91
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 15
        end
        object Button3: TButton
          Left = 8
          Top = 152
          Width = 75
          Height = 25
          Caption = 'Draw'
          TabOrder = 1
          OnClick = Button3Click
        end
        object CheckBox3: TCheckBox
          Left = 8
          Top = 72
          Width = 37
          Height = 17
          Caption = 'Flip'
          TabOrder = 2
          OnClick = CheckBox3Click
        end
      end
    end
  end
end
