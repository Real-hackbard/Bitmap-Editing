unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, System.Math, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    ScrollBox1: TScrollBox;
    Image1: TImage;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    Button3: TButton;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    Button4: TButton;
    SaveDialog1: TSaveDialog;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function Vektor(FromP, Top: TPoint): TPoint;
begin
  Result.x := Top.x - FromP.x;
  Result.y := Top.y - FromP.y;
end;

function xComp(Vektor: TPoint; Angle: Extended): Integer;
begin
  Result := Round(Vektor.x * cos(Angle) - (Vektor.y) * sin(Angle));
end;

function yComp(Vektor: TPoint; Angle: Extended): Integer;
begin
  Result := Round((Vektor.x) * (sin(Angle)) + (vektor.y) * cos(Angle));
end;

function RotImage(srcbit: TBitmap; Angle: Extended; FPoint: TPoint;
  Background: TColor): TBitmap;
var
  highest, lowest, mostleft, mostright: TPoint;
  topoverh, leftoverh: integer;
  x, y, newx, newy: integer;
begin
  Result := TBitmap.Create;

  while Angle >= (2 * pi) do
  begin
    angle := Angle - (2 * pi);
  end;

  if (angle <= (pi / 2)) then
  begin
    highest := Point(0,0);                        //OL
    Lowest := Point(Srcbit.Width, Srcbit.Height); //UR
    mostleft := Point(0,Srcbit.Height);            //UL
    mostright := Point(Srcbit.Width, 0);             //OR
  end
  else if (angle <= pi) then
  begin
    highest := Point(0,Srcbit.Height);
    Lowest := Point(Srcbit.Width, 0);
    mostleft := Point(Srcbit.Width, Srcbit.Height);
    mostright := Point(0,0);
  end
  else if (Angle <= (pi * 3 / 2)) then
  begin
    highest := Point(Srcbit.Width, Srcbit.Height);
    Lowest := Point(0,0);
    mostleft := Point(Srcbit.Width, 0);
    mostright := Point(0,Srcbit.Height);
  end
  else
  begin
    highest := Point(Srcbit.Width, 0);
    Lowest := Point(0,Srcbit.Height);
    mostleft := Point(0,0);
    mostright := Point(Srcbit.Width, Srcbit.Height);
  end;

  topoverh := yComp(Vektor(FPoint, highest), Angle);
  leftoverh := xComp(Vektor(FPoint, mostleft), Angle);
  Result.Height := Abs(yComp(Vektor(FPoint, lowest), Angle)) + Abs(topOverh);
  Result.Width  := Abs(xComp(Vektor(FPoint, mostright), Angle)) + Abs(leftoverh);

  Topoverh := TopOverh + FPoint.y;
  Leftoverh := LeftOverh + FPoint.x;

  Result.Canvas.Brush.Color := Background;
  Result.Canvas.pen.Color   := background;
  Result.Canvas.Fillrect(Rect(0,0,Result.Width, Result.Height));

  for y := 0 to srcbit.Height - 1 do
  begin
    for x := 0 to srcbit.Width - 1 do
    begin
      newX := xComp(Vektor(FPoint, Point(x, y)), Angle);
      newY := yComp(Vektor(FPoint, Point(x, y)), Angle);
      newX := FPoint.x + newx - leftoverh;
      newy := FPoint.y + newy - topoverh;
      // Move beacause of new size
      Result.Canvas.Pixels[newx, newy] := srcbit.Canvas.Pixels[x, y];
      // also fil lthe pixel beside to prevent empty pixels
      if ((angle < (pi / 2)) or
        ((angle > pi) and
        (angle < (pi * 3 / 2)))) then
      begin
        Result.Canvas.Pixels[newx, newy + 1] := srcbit.Canvas.Pixels[x, y];
      end
      else
      begin
        Result.Canvas.Pixels[newx + 1,newy] := srcbit.Canvas.Pixels[x, y];
      end;
    end;
  end;
end;

procedure Vertical(Bild1:TImage);
var
  x,y:integer;
  hilf : TColor;
begin
  Screen.Cursor := crHourGlass;
  Form1.Label3.Caption := 'Calculating, please Wait..';
  Application.ProcessMessages;
  for x:=0 to Bild1.width div 2 - 1 do
   for y:=0 to Bild1.height - 1 do
   begin
    hilf := Bild1.canvas.pixels[x,y];
    Bild1.canvas.pixels[x,y]:=Bild1.canvas.pixels[Bild1.width-1-x,y];
    Bild1.canvas.pixels[Bild1.width-1-x,y] := hilf;
   end;
   Screen.Cursor := crDefault;
   Form1.Label3.Caption := 'done.';
end;

procedure Horizontal(Bild1:TImage);
var
  x,y:integer;
  hilf : TColor;
begin
  Screen.Cursor := crHourGlass;
  Form1.Label3.Caption := 'Calculating, please Wait..';
  Application.ProcessMessages;
  for x:=0 to Bild1.width - 1 do
   for y:=0 to Bild1.height div 2 - 1 do
   begin
    hilf := Bild1.canvas.pixels[x,y];
    Bild1.canvas.pixels[x,y]:=Bild1.canvas.pixels[x,Bild1.height-1-y];
    Bild1.canvas.pixels[x,Bild1.height-1-y] := hilf;
   end;
   Screen.Cursor := crDefault;
   Form1.Label3.Caption := 'done.';
end;

procedure FlipV(AImage: TImage);
var
  lBmp: TBitmap;
begin
  lBmp := TBitmap.Create;
  try
    lBmp.Assign(AImage.Picture.Graphic);

    StretchBlt(lBmp.Canvas.Handle,
                 0,
                 0,
                 lBmp.Width,
                 lBmp.Height,
               lBmp.Canvas.Handle,
                 0,
                 lBmp.Height,
                 lBmp.Width,
                 -lBmp.Height,
               SRCCOPY);

    AImage.Picture.Assign(lBmp);;
  finally
    lBmp.Free;
  end;
end;

procedure FlipH(AImage: TImage);
var
  lBmp: TBitmap;
begin
  lBmp := TBitmap.Create;
  try
    lBmp.Assign(AImage.Picture.Graphic);

    StretchBlt(lBmp.Canvas.Handle,
                 0,
                 0,
                 lBmp.Width,
                 lBmp.Height,
               lBmp.Canvas.Handle,
                 lBmp.Width,
                 0,
                -lBmp.Width,
                 lBmp.Height,
               SRCCOPY);

    AImage.Picture.Assign(lBmp);;
  finally
    lBmp.Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
  0 : FlipV(Image1);
  1 : Vertical(Image1);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
  0 : FlipH(Image1);
  1 : Horizontal(Image1);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  BitRot : TBitmap;
begin
  Screen.Cursor := crHourGlass;
  Form1.Label3.Caption := 'Calculating, please Wait..';
  Application.ProcessMessages;
  BitRot := TBitmap.Create;
  try
    if assigned(image1.Picture.Bitmap) then
    begin
      BitRot := RotImage(image1.Picture.Bitmap,                    {Source}
                         DegToRad(SpinEdit1.Value),                {90 degree to rotate}
                         Point(image1.Picture.Bitmap.Width div 2,  {x point for center rotate}
                         Image1.Picture.Bitmap.Height div 2),      {y point for center rotate}
                         clWhite);                                 {background Color for rotated image}
      Image1.Picture.Assign(BitRot);
    end;
  finally
    BitRot.Free;
  end;
  Screen.Cursor := crDefault;
  Form1.Label3.Caption := 'done.';
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  if SaveDialog1.Execute then
  begin
    try
      bmp := TBitmap.Create;
      bmp.Assign(Image1.Picture.Bitmap);
      bmp.PixelFormat := pf24bit;
      bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
    finally
      bmp.Free;
    end;
  end;
end;

end.
