unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Math, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    Button2: TButton;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Button3: TButton;
    StatusBar1: TStatusBar;
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

implementation

{$R *.dfm}
{$R-}

procedure InvertBitmap(Bitmap: TBitmap);
var
  x, y: Integer;
  Line: PRGBTriple; // For 24-bit, use PRGBQuad for 32-bit
begin
  Bitmap.PixelFormat := pf24bit; // Ensure that 24-bit is used.
  for y := 0 to Bitmap.Height - 1 do
  begin
    Line := Bitmap.ScanLine[y];
    for x := 0 to Bitmap.Width - 1 do
    begin
      Line^.rgbtRed := 255 - Line^.rgbtRed;
      Line^.rgbtGreen := 255 - Line^.rgbtGreen;
      Line^.rgbtBlue := 255 - Line^.rgbtBlue;
      Inc(Line);
    end;
  end;
end;

function InvertRGB(MyBitmap: TBitmap): TBitmap;
var
  x, y: Integer;
  ByteArray: PByteArray;
begin
  MyBitmap.PixelFormat := pf24Bit;
  for y := 0 to MyBitmap.Height - 1 do
  begin
    ByteArray := MyBitmap.ScanLine[y];
    for x := 0 to MyBitmap.Width * 3 - 1 do
    begin
      ByteArray[x] := 255 - ByteArray[x];
    end;
  end;
  Result := MyBitmap;
end;

function InvertBmp(SourceBitmap: TBitmap): TBitmap;
var
  iFor, iFor2: LongInt;
  TempBitmap: TBitmap;
  bRed, bGreen, bBlue: Byte;
  PixelColor: LongInt;
begin
  Screen.Cursor := crHourGlass;
  Form1.StatusBar1.Panels[0].Text := 'Calculating Negativ, please wait..';
  Application.ProcessMessages;
  TempBitmap := TBitmap.Create;
  TempBitmap.Width := SourceBitmap.Width;
  TempBitmap.Height := SourceBitmap.Height;
  for iFor := 0 to SourceBitmap.Width -1 do
  begin
    for iFor2 := 0 to SourceBitmap.Height -1 do
    begin
      PixelColor := ColorToRGB(SourceBitmap.Canvas.Pixels[iFor, iFor2]);
      bRed := PixelColor;
      bGreen := PixelColor shr 8;
      bBlue := PixelColor shr 16;
      bRed := 255 -bRed;
      bGreen := 255 -bGreen;
      bBlue := 255 -bBlue;
      TempBitmap.Canvas.Pixels[iFor, iFor2] := (bRed shl 8 +bGreen) shl 8 +bBlue;
    end;
  end;
  Result := TempBitmap;
  Screen.Cursor := crDefault;
  Form1.StatusBar1.Panels[0].Text := 'Negativ done.';
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  case ComboBox1.ItemIndex of

  0 : begin
        try
          bmp := TBitmap.Create;
          bmp.Assign(Image1.Picture.Bitmap);
          InvertBitmap(bmp);
          Image1.Picture.Bitmap.Assign(bmp);
        finally
          bmp.Free;
        end;
      end;

  1 : begin
      try
        bmp := TBitmap.Create;
        bmp.Assign(Image1.Picture.Bitmap);
        InvertRGB(bmp);
        Image1.Picture.Bitmap.Assign(bmp);
      finally
        bmp.Free;
      end;
end;

  2 : Image1.Picture.Bitmap.Assign(InvertBmp(Image1.Picture.Bitmap));
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    StatusBar1.Panels[0].Text := ExtractFileName(OpenDialog1.FileName);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

end.
