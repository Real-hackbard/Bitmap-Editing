object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Loading oversized Bitmaps'
  ClientHeight = 428
  ClientWidth = 627
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  DesignSize = (
    627
    428)
  TextHeight = 15
  object Button1: TButton
    Left = 544
    Top = 395
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Bitmap'
    TabOrder = 0
    TabStop = False
    OnClick = Button1Click
  end
  object ScrollBox1: TScrollBox
    Left = 8
    Top = 8
    Width = 611
    Height = 369
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object Image1: TImage
      Left = 3
      Top = 3
      Width = 353
      Height = 241
      AutoSize = True
    end
  end
end
