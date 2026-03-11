unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    ScrollBar1: TScrollBar;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure ScrollBar1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

type
  TRGBArray = array[0..0] of TRGBTriple;
  pRGBArray = ^TRGBArray;

implementation

{$R *.dfm}
function IntToByte(i : integer) : byte;
begin
  if (i>255) then
    Result := 255
  else if (i < 0) then
    Result := 0
  else
    Result := i;
end;

procedure Contrast(Src : TBitmap; Amount : integer);
var
  x, y : integer;
  r, g, b : integer;
  rr, gg, bb : integer;
  SrcLine : pRGBArray;
  SrcGap : integer;
begin
  Src.PixelFormat := pf24bit;
  SrcLine := Src.ScanLine[0];
  SrcGap := Integer(Src.ScanLine[1]) - Integer(SrcLine);

  {$ifopt R-}
  {$define RangeCheck}
  {$endif}
  {$R-}

  for y := 0 to pred(Src.Height) do
  begin
    for x := 0 to pred(Src.Width) do
    begin
      r := SrcLine[x].rgbtRed;
      g := SrcLine[x].rgbtGreen;
      b := SrcLine[x].rgbtBlue;
      rr := MulDiv(abs(127-r), Amount, 100);
      gg := MulDiv(abs(127-g), Amount, 100);
      bb := MulDiv(abs(127-b), Amount, 100);
      if (r>127) then
        r := r+rr
      else
        r := r-rr;
      if (g>127) then
        g := g+gg
      else
        g := g-gg;
      if (b>127) then
        b := b+bb
      else
        b := b-bb;
        SrcLine[x].rgbtRed := IntToByte(r);
        SrcLine[x].rgbtGreen := IntToByte(g);
        SrcLine[x].rgbtBlue := IntToByte(b);
    end; {for}
    Form1.Label4.Caption := IntToStr(pred(Src.Height));
    Form1.Label9.Caption := IntToStr(pred(Src.Width));
    SrcLine := pRGBArray(Integer(SrcLine) + SrcGap);
  end; {for}

  {$ifdef RangeCheck}
  {$R+}
  {$undef RangeCheck}
  {$endif}
end;

procedure Kontrast(const Bitmap: TBitmap; value: byte);
var
  x,y,k: integer;
  Ziel,Quelle: ^TRGBTriple;
  Farbarray: array[0..255] of byte;
  faktor: single;
begin
  {$ifopt R-}
  {$define RangeCheck}
  {$endif}
  {$R-}
  faktor := 1 + value /100;
  for x := 0 to 255 do
  begin
    k := Round((integer(x) - 128)*faktor) + 128;
    if k > 255 then Farbarray[x] := 255
    else
    if k < 0 then Farbarray[x] := 0
    else Farbarray[x] := k;

    Form1.Label4.Caption := IntToStr(k);
    Form1.Label9.Caption := IntToStr(x);
  end;
  for y := 0 to Bitmap.Height-1 do
  begin
    Ziel   := Bitmap.Scanline[y];
    Quelle := Bitmap.Scanline[y];
    for x := 0 to (Bitmap.Width-1) do
     begin
      Ziel^.rgbtred   := Farbarray[Quelle^.rgbtred];
      Ziel^.rgbtblue  := Farbarray[Quelle^.rgbtblue];
      Ziel^.rgbtgreen := Farbarray[Quelle^.rgbtgreen];
      inc(ziel);
      inc(quelle);
     end;
  end;
  {$ifdef RangeCheck}
  {$R+}
  {$undef RangeCheck}
  {$endif}
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    Image2.Picture.Bitmap.Assign(Image1.Picture.Bitmap);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
var
  bmp : TBitmap;
begin
  Image1.Picture.Bitmap.Assign(Image2.Picture.Bitmap);

  case ComboBox1.ItemIndex of
  0 : Kontrast(Image1.Picture.Bitmap, ScrollBar1.Position);

  1 : begin
        try
          bmp := TBitmap.Create;
          bmp.Assign(Image1.Picture.Bitmap);
          bmp.PixelFormat := pf24bit;
          Contrast(bmp, ScrollBar1.Position);
          Image1.Picture.Bitmap.Assign(bmp);
        finally
          bmp.Free;
        end;
      end;
  end;

  Image1.Repaint;
  Label7.Caption := IntToStr(ScrollBar1.Position);
end;

end.
 