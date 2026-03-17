unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Button3: TButton;
    SaveDialog1: TSaveDialog;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Shape1: TShape;
    ColorDialog1: TColorDialog;
    Label2: TLabel;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

procedure CANVAS_DEGRADE_SHAPE(NaCanvas: TCanvas; InsideRect: TRect;
          OuterRect: TRect; InsideColor:Tcolor; OuterColor:Tcolor;
          Forma: TShapeType; X3, Y3: Integer);

implementation

{$R *.dfm}
procedure CANVAS_DEGRADE_SHAPE(NaCanvas: TCanvas; InsideRect: TRect;
          OuterRect: TRect; InsideColor:Tcolor; OuterColor:Tcolor;
          Forma: TShapeType; X3, Y3: Integer);

       procedure DesenharForma(_Rect: TRect);
       begin
         Case Forma Of
           stCircle, stEllipse: NaCanvas.Ellipse(_Rect);
           stRectangle, stSquare: NaCanvas.Rectangle(_Rect);
           stRoundRect, stRoundSquare: NaCanvas.RoundRect(_Rect.Left,
                                                          _Rect.Top,
                                                          _Rect.Right,
                                                          _Rect.Bottom,
                                                          X3, Y3);
         End;
       end;
var
  i: Integer;
  aRect: TRect;
  Arr_StartRGB : Array[0..2] of Byte;
  Arr_DifRGB   : Array[0..2] of integer;
  Arr_CurRGB   : Array[0..2] of Byte;
begin
  Arr_StartRGB[0] := GetRValue( ColorToRGB( InsideColor ) );
  Arr_StartRGB[1] := GetGValue( ColorToRGB( InsideColor ) );
  Arr_StartRGB[2] := GetBValue( ColorToRGB( InsideColor ) );

  Arr_DifRGB[0] := GetRValue( ColorToRGB( OuterColor )) - Arr_StartRGB[0] ;
  Arr_DifRGB[1] := GetgValue( ColorToRGB( OuterColor )) - Arr_StartRGB[1] ;
  Arr_DifRGB[2] := GetbValue( ColorToRGB( OuterColor )) - Arr_StartRGB[2] ;

  With NaCanvas do
  begin
    Brush.Style := bsSolid;
    Pen.Style   := psSolid;
    Pen.Mode    := pmCopy;
    Pen.Width   := 1;
    Pen.Color   := OuterColor;
    Brush.Color := OuterColor;
    DesenharForma(OuterRect);

    for i:= 255 Downto 0 do
    begin
      aRect.Left   := InsideRect.Left   + MulDiv(i, (OuterRect.Left   - InsideRect.Left),   256);
      aRect.right  := InsideRect.Right  + MulDiv(i, (OuterRect.Right  - InsideRect.Right),  256);
      aRect.Top    := InsideRect.Top    + MulDiv(i, (OuterRect.Top    - InsideRect.Top),    256);
      aRect.Bottom := InsideRect.Bottom + MulDiv(i, (OuterRect.Bottom - InsideRect.Bottom), 256);

      Arr_CurRGB[0] := Arr_StartRGB[0] + MulDiv( i, Arr_DifRGB[0] , 255 );
      Arr_CurRGB[1] := Arr_StartRGB[1] + MulDiv( i, Arr_DifRGB[1] , 255 );
      Arr_CurRGB[2] := Arr_StartRGB[2] + MulDiv( i, Arr_DifRGB[2] , 255 );

      Pen.Color   := RGB(Arr_CurRGB[0], Arr_CurRGB[1], Arr_CurRGB[2]);
      Brush.color := Pen.Color;
      DesenharForma(aRect);
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  CANVAS_DEGRADE_SHAPE(Image1.Canvas,
                       classes.Rect(10, 100, 50, 140),
                       classes.Rect(20, 120, 60, 150),
                       Shape2.Brush.Color, Shape3.Brush.Color, stRectangle, 0, 0);

  CANVAS_DEGRADE_SHAPE(Image1.Canvas,
                       classes.Rect(20, 300, 150, 400),
                       classes.Rect(60, 240, 230, 300),
                       Shape2.Brush.Color, Shape3.Brush.Color, stSquare, 0, 0);
  ComboBox1.OnChange(sender);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  CANVAS_DEGRADE_SHAPE(Image1.Canvas,
                       classes.Rect(200, 50, 220, 70),
                       classes.Rect(180, 240, 350, 300),
                       Shape4.Brush.Color, Shape5.Brush.Color, stEllipse, 0, 0);

  CANVAS_DEGRADE_SHAPE(Image1.Canvas,
                       classes.Rect(500, 200, 400, 300),
                       classes.Rect(400, 100, 500, 200),
                       Shape4.Brush.Color, Shape5.Brush.Color, stEllipse, 0, 0);

  CANVAS_DEGRADE_SHAPE(Image1.Canvas,
                       classes.Rect(300, 400, 300, 400),
                       classes.Rect(350, 450, 250, 350),
                       Shape4.Brush.Color, Shape5.Brush.Color, stEllipse, 0, 0);

  CANVAS_DEGRADE_SHAPE(Image1.Canvas,
                       classes.Rect(500, 200, 600, 300),
                       classes.Rect(600, 300, 900, 400),
                       Shape4.Brush.Color, Shape5.Brush.Color, stCircle, 0, 0);
  ComboBox1.OnChange(sender);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  bmp : TBitmap;
begin
  try
    bmp := TBitmap.Create;
    bmp.Assign(Image1.Picture.Bitmap);

    case ComboBox1.ItemIndex of
    0 : bmp.PixelFormat := pf4bit;
    1 : bmp.PixelFormat := pf8bit;
    2 : bmp.PixelFormat := pf24bit;
    3 : bmp.PixelFormat := pf32bit;
    end;

    Image1.Picture.Bitmap.Assign(bmp);
  finally
    bmp.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Image1.Canvas.Brush.Color:=clBlack;
  Image1.Canvas.Rectangle(0,0, Image1.Width,Image1.Height);
end;

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
  begin
    Shape1.Brush.Color := ColorDialog1.Color;
    Image1.Canvas.Brush.Color:= Shape1.Brush.Color;
    Image1.Canvas.Rectangle(0,0, Image1.Width,Image1.Height);
  end;
end;

procedure TForm1.Shape2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
  begin
    Shape2.Brush.Color := ColorDialog1.Color;
    Button1.Click;
  end;
end;

procedure TForm1.Shape3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
  begin
    Shape3.Brush.Color := ColorDialog1.Color;
    Button1.Click;
  end;
end;

procedure TForm1.Shape4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
  begin
    Shape4.Brush.Color := ColorDialog1.Color;
    Button2.Click;
  end;
end;

procedure TForm1.Shape5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
  begin
    Shape5.Brush.Color := ColorDialog1.Color;
    Button2.Click;
  end;
end;

end.
