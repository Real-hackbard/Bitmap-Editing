unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Shape1: TShape;
    ColorDialog1: TColorDialog;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    ScrollBox2: TScrollBox;
    Image2: TImage;
    Button2: TButton;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure Highlight(aSource, ATarget: TBitmap; AColor: TColor);
// alters ASource to ATarget by making it appear as if
// looked through
// colored glass as given by AColor
// ASource, ATarget must have been created.
// Isn't as slow as it looks.
// Physics courtesy
var i, j: Integer;
  s, t: pRGBTriple;
  r, g, b: byte;
  cl: TColor;
begin
  cl := ColorToRGB(AColor);
  r := GetRValue(cl);
  g := GetGValue(cl);
  b := GetBValue(cl);

  aSource.PixelFormat := pf24bit;
  ATarget.PixelFormat := pf24bit;

  ATarget.Width := aSource.Width;
  ATarget.Height := aSource.Height;

  for i := 0 to aSource.Height - 1 do
  begin
    s := ASource.Scanline[i];
    t := ATarget.Scanline[i];
    for j := 0 to aSource.Width - 1 do
    begin
      t^.rgbtBlue  := (b * s^.rgbtBlue) div 255;
      t^.rgbtGreen := (g * s^.rgbtGreen) div 255;
      t^.rgbtRed   := (r * s^.rgbtRed) div 255;
      inc(s);
      inc(t);
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Image2.Picture.Graphic := nil;
  Highlight(Image1.Picture.Bitmap, Image2.Picture.Bitmap, Shape1.Brush.Color);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image2.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
    Shape1.Brush.Color := ColorDialog1.Color;
end;

end.
