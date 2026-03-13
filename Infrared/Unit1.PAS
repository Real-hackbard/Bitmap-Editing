unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Button2: TButton;
    Image4: TImage;
    OpenDialog1: TOpenDialog;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SaveDialog1: TSaveDialog;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private-Deklarationen }
    FIsPicture     : Boolean;
    FIsGrayPicture : Boolean;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses
  BmpGrD12;

{$R *.DFM}
{$R-}
function Is24BitBitmap(Bitmap: TBitmap): Boolean;
begin
  Result := (Bitmap.PixelFormat = pf24bit);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  with OpenDialog1 do begin
    if Execute then begin
      Button2.Enabled := true;
      Button4.Enabled := true;
      Label11.Caption := 'Correct Pixel Format.';

      Image1.Picture.Bitmap.LoadFromFile(Filename);
      Image2.Picture.Graphic := nil;
      Image3.Picture.Graphic := nil;


      try
        bmp := TBitmap.Create;
        bmp.Assign(Image1.Picture.Bitmap);
        // Check if the bitmap is 24/32 bit.

        if Is24BitBitmap(bmp) = false then
        begin
          Label11.Caption := 'Not 24 bit Pixel Format.';
          Button2.Enabled := false;
          Button4.Enabled := false;
        end;
      finally
        bmp.Free;
      end;

      FIsPicture:=True;
    end;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image3.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp')
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  ABitmap : TBitmap;
  APalette : TFullPalette;
begin
  FIsPicture:=True;

  ABitmap := TBitmap.Create;
  try
    if DrawPalette(ABitmap,APalette,Image4.Height) then
    begin
      Image4.Picture.Bitmap.Assign(ABitmap);
    end;
  finally
    ABitmap.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  ABitmap : TBitmap;
  APalette : TFullPalette;
  i : Integer;
  x : Double;
begin
  if Not FIsPicture then Exit;
  ABitmap:=TBitmap.Create;
  try
    if ConvertToGrayBitmap(Image1.Picture.Bitmap, ABitmap) then begin
      FIsGrayPicture:=True;
      Image2.Picture.Bitmap.Assign(ABitmap);
    end;
  finally
    ABitmap.Free;
  end;

  if Not FIsGrayPicture then Exit;
  { Segment 0 }
  x := 256 / 42;
  for i := 0 to 41 do
    with APalette[i] do begin     {   0 ..  41 }
    rgbBlue := 0;
    rgbGreen:= Trunc(i*x);
    rgbRed  := 255;
    Label4.Caption := FloatToStr(i*x);
  end;
  { Segment 1 }
  x:=256 / 43;
  for i:=0 to 42 do
    with APalette[i+42] do begin  {  42 ..  84 }
    rgbBlue :=0;
    rgbGreen:=255;
    rgbRed  :=Trunc((42-i)*x);
    Label5.Caption := FloatToStr((42-i)*x);
  end;
  { Segment 2 }
  x:=256 / 43;
  for i:=0 to 42 do
    with APalette[i+85] do begin  {  85 .. 127 }
    rgbBlue :=Trunc(i*x);
    rgbGreen:=255;
    rgbRed  :=0;
    Label6.Caption := FloatToStr(i*x);
  end;
  { Segment 3 }
  x:=256 / 42;
  for i:=0 to 41 do
    with APalette[i+128] do begin { 128 .. 169 }
    rgbBlue :=255;
    rgbGreen:=Trunc((41-i)*x);
    rgbRed  :=0;
    Label7.Caption := FloatToStr((41-i)*x);
  end;
  { Segment 4 }
  x:=256 / 43;
  for i:=0 to 42 do
  with APalette[i+170] do begin { 170 .. 212 }
    rgbBlue :=255;
    rgbGreen:=0;
    rgbRed  :=Trunc(i*x);
    Label8.Caption := FloatToStr(i*x);
  end;
  { Segment 5 }
  x:=256 / 43;
  for i:=0 to 42 do
  with APalette[i+213] do begin { 213 .. 255 }
    rgbBlue :=Trunc((42-i)*x);
    rgbGreen:=0;
    rgbRed  :=255;
    Label9.Caption := FloatToStr((42-i)*x);
  end;

  ABitmap := TBitmap.Create;
  try
    if DrawPalette(ABitmap,APalette,Image4.Height) then
    begin
      Image4.Picture.Bitmap.Assign(ABitmap);
    end;

    ABitmap.Assign(Image2.Picture.Bitmap);

    if ChangePalette(ABitmap,APalette) then
    begin
      Image3.Picture.Bitmap.Assign(ABitmap);
    end;
  finally
    ABitmap.Free;
  end;
end;

end.

