object Form1: TForm1
  Left = 329
  Top = 178
  Caption = 'Mouse query using the example of a triangle'
  ClientHeight = 541
  ClientWidth = 858
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 858
    Height = 541
    Align = alClient
    PopupMenu = PopupMenu1
    OnMouseDown = PaintBox1MouseDown
    OnMouseMove = PaintBox1MouseMove
    OnMouseUp = PaintBox1MouseUp
    OnPaint = PaintBox1Paint
    ExplicitWidth = 854
    ExplicitHeight = 540
  end
  object PopupMenu1: TPopupMenu
    Left = 56
    Top = 56
    object Save1: TMenuItem
      Caption = 'Save'
      OnClick = Save1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Reset1: TMenuItem
      Caption = 'Reset'
      OnClick = Reset1Click
    end
    object Corners1: TMenuItem
      AutoCheck = True
      Caption = 'Corners'
      Checked = True
      OnClick = Corners1Click
    end
    object CornerSize1: TMenuItem
      Caption = 'Corner Size'
      object x11: TMenuItem
        AutoCheck = True
        Caption = 'x1'
        Checked = True
        RadioItem = True
        OnClick = x11Click
      end
      object x21: TMenuItem
        AutoCheck = True
        Caption = 'x2'
        RadioItem = True
        OnClick = x21Click
      end
    end
    object CrossSections1: TMenuItem
      AutoCheck = True
      Caption = 'Cross Sections'
      Checked = True
      OnClick = CrossSections1Click
    end
    object Frame1: TMenuItem
      AutoCheck = True
      Caption = 'Frame'
      OnClick = Frame1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Color1: TMenuItem
      Caption = 'Color'
      object Background1: TMenuItem
        Caption = 'Background'
        OnClick = Background1Click
      end
      object Frame2: TMenuItem
        Caption = 'Frame'
        OnClick = Frame2Click
      end
      object riangle1: TMenuItem
        Caption = 'Triangle'
        OnClick = riangle1Click
      end
      object CrossSections2: TMenuItem
        Caption = 'Cross Sections'
        OnClick = CrossSections2Click
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 144
    Top = 56
  end
  object ColorDialog1: TColorDialog
    Left = 240
    Top = 56
  end
  object ColorDialog2: TColorDialog
    Left = 240
    Top = 128
  end
  object ColorDialog3: TColorDialog
    Left = 240
    Top = 208
  end
  object ColorDialog4: TColorDialog
    Left = 240
    Top = 280
  end
end
