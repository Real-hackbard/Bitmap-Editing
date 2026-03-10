unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ScrollBar1: TScrollBar;
    Image2: TImage;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label5: TLabel;
    Label6: TLabel;
    RadioGroup2: TRadioGroup;
    procedure ScrollBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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

procedure Brightness(Src : TBitmap; Amount : integer);
var
  x, y : integer;
  SrcLine : pRGBArray;
  SrcGap : integer;
begin
  Src.PixelFormat := pf24bit;
  SrcLine := Src.ScanLine[0];
  SrcGap := Integer(Src.ScanLine[1]) - Integer(SrcLine);
  {$ifopt R+}
  {$define RangeCheck}
  {$endif} {$R-}

  for y := 0 to pred(Src.Height) do
  begin
    for x := 0 to pred(Src.Width) do
      begin
        SrcLine[x].rgbtRed := IntToByte(SrcLine[x].rgbtRed +
        MulDiv(SrcLine[x].rgbtRed, Amount, 100));
        SrcLine[x].rgbtGreen := IntToByte(SrcLine[x].rgbtGreen +
        MulDiv(SrcLine[x].rgbtGreen, Amount, 100));
        SrcLine[x].rgbtBlue := IntToByte(SrcLine[x].rgbtBlue +
        MulDiv(SrcLine[x].rgbtBlue, Amount, 100));
      end; {for}
      SrcLine := pRGBArray(Integer(SrcLine) + SrcGap);
  end; {for}

  {$ifdef RangeCheck}
  {$R+}
  {$undef RangeCheck}
  {$endif}
end;

Procedure BrightnessBitmap(SourceBitmap: TBitmap; out DestBitmap: TBitmap; Prozent:integer);
var
  x,y,farbe:Integer;
  r,g,b:byte;
begin
  Screen.Cursor := crHourGlass;
  DestBitmap.Assign(SourceBitmap);

  if Prozent<0 then begin                      //Wenn abdunkeln
    for y:=0 to DestBitmap.Height-1 do
      for x:=0 to DestBitmap.Width-1 do begin
        farbe:=DestBitmap.Canvas.Pixels[x,y];
        b:=byte(farbe shr 16);                 //b=Blau (0..255 oder $00..$FF)
        g:=byte(farbe shr 8);                  //g=Grün (0..255 oder $00..$FF)
        r:=byte(farbe);                        //r=rot(0..255 oder $00..$FF)
        r:=round(r*(100+prozent)/100);
        g:=round(g*(100+prozent)/100);
        b:=round(b*(100+prozent)/100);
        DestBitmap.Canvas.Pixels[x,y]:=b shl 16 + g shl 8 + r;
      end;
  end else begin                               //ansonsten aufhellen
    for y:=0 to DestBitmap.Height-1 do
      for x:=0 to DestBitmap.Width-1 do begin
        farbe:=DestBitmap.Canvas.Pixels[x,y];
        b:=byte(farbe shr 16);
        g:=byte(farbe shr 8);
        r:=byte(farbe);
        r:=round(r+((255-r)*(prozent)/100));
        g:=round(g+((255-g)*(prozent)/100));
        b:=round(b+((255-b)*(prozent)/100));
        DestBitmap.Canvas.Pixels[x,y]:=b shl 16 + g shl 8 + r;
      end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  Begin
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    Image2.Picture.Bitmap.Assign(Image1.Picture.Bitmap);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ScrollBar1.Position := 0;
  Application.ProcessMessages;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := true;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
var
  BmpSource, BmpDest : TBitmap;
begin
  BmpSource := TBitmap.Create;
  BmpDest := TBitmap.Create;
  try
    BmpSource.Assign(Image2.Picture.Bitmap);

    case RadioGroup1.ItemIndex of
    0 : BmpSource.PixelFormat := pf4bit;
    1 : BmpSource.PixelFormat := pf8bit;
    2 : BmpSource.PixelFormat := pf16bit;
    3 : BmpSource.PixelFormat := pf24bit;
    4 : BmpSource.PixelFormat := pf32bit;
    end;

    case RadioGroup2.ItemIndex of
    0 : begin
          Brightness(BmpSource, ScrollBar1.Position);
          Image1.Picture.Bitmap.Assign(BmpSource);
        end;

    1 : begin
          BrightnessBitmap(BmpSource, BmpDest, ScrollBar1.Position);
          Image1.Picture.Bitmap.Assign(BmpDest);
        end;
    end;

    Label5.Caption := IntToStr(ScrollBar1.Position) + ' %';
  finally
    BmpSource.Free;
    BmpDest.Free;
  end;
end;

end.
