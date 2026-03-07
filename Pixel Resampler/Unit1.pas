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
    Button3: TButton;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    Label5: TLabel;
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
 type
  PBitmap = ^TBitmap;
  TLine = array[0..MaxInt div SizeOf(TRGBQUAD) - 1] of TRGBQUAD;
  PLine = ^TLine;


function ResampleSubBitmap(Bitmap: TBitmap; XPos, YPos, Width, Height: Integer): TRGBQuad;
var
  r, g, b: Cardinal;
  Line: PLine;
  x, y, z: Integer;
begin
  Screen.Cursor := crHourGlass;
  z := (Width * Height);
  r := 0;
  g := 0;
  b := 0;

  // Intercept border crossings
  if (YPos + Height) >= Bitmap.Height then Height := (Bitmap.Height - YPos) - 1;
  if (XPos + Width) >= Bitmap.Width then Width := (Bitmap.Width - XPos) - 1;

  // Read the values ​​for each pixel and add them up.
  for y := YPos to YPos + Height do
  begin
    Line := Bitmap.ScanLine[y];
    for x := XPos to XPos + Width do
    begin
      r := r + Line[x].rgbRed;
      g := g + Line[x].rgbGreen;
      b := b + Line[x].rgbBlue;
      Inc(z);
    end;
  end;

  if (z = 0) then z := 1;
  // Determine the average and make a small brightness correction.
  r := Round((r / z) * 1.4);
  if (r > 255) then r := 255;
  g := Round((g / z) * 1.4);
  if (g > 255) then g := 255;
  b := Round((b / z) * 1.4);
  if (b > 255) then b := 255;

  Result.rgbRed   := r;
  Result.rgbGreen := g;
  Result.rgbBlue  := b;
end;

function ResampleBitmap(Bitmap: TBitmap; NewWidth, NewHeight: Integer): Boolean;
var
  Temp: TBitmap;
  Line: PLine;
  x, y: Integer;
  Blockheight, Blockwidth: Cardinal;
  BlockPosX, BlockPosY: Single;
  BlockDiffX, BlockDiffY: Single;
  XPos, YPos: Single;
  DiffX, Diffy: Single;
begin
  Result := True;

  // Create working bitmap
  Temp := TBitmap.Create;

  // Everything must be 32-bit.
  Bitmap.PixelFormat := pf32Bit;
  Temp.PixelFormat   := pf32Bit;

  // New height of our bitmap
  Temp.Height := NewHeight;
  Temp.Width  := NewWidth;

  // Divide the old image into blocks, the average of which is the color.
  // a new pixel
  // Block size per new pixel
  BlockDiffY := (Bitmap.Height / NewHeight);
  BlockDiffX := (Bitmap.Width / NewWidth);
  // Size of a block
  BlockHeight := Trunc(BlockDiffY);
  BlockWidth  := Trunc(BlockDiffY);


  // Pixel spacing in the new image
  DiffX := 1;
  DiffY := 1;

  // Initialize all
  BlockPosY := 0;
  YPos      := 0;
  // Every column
  for y := 0 to NewHeight - 1 do
  begin
    BlockPosX := 0;
    XPos      := 0;
    // Every line
    Line := Temp.ScanLine[Trunc(YPos)];
    for x := 0 to NewWidth - 1 do
    begin
      // From a specified block of the old bitmap, calculate the mean of the
      // Determine color
      Line[Trunc(XPos)] := ResampleSubBitmap(Bitmap,
        Round(BlockPosX), Round(BlockPosY), Blockwidth, BlockHeight);

      // One block/pixel further
      BlockPosX := BlockPosX + BlockDiffX;
      XPos      := XPos + DiffX;
    end;
    // One block/pixel further
    BlockPosY := BlockPosY + BlockDiffY;
    YPos      := YPos + DiffY;
  end;
  // Overwrite old bitmap with new one
  Bitmap.Assign(Temp);

  // Share auxiliary bitmap
  Temp.Free;
  Screen.Cursor := crDefault;
  Form1.Label1.Caption := IntToStr(x);
  Form1.Label2.Caption := IntToStr(y);
  Application.ProcessMessages;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  Label1.Caption := 'Calculating..';
   ResampleBitmap(Image1.Picture.Bitmap,
                  Image1.Picture.Bitmap.Width,
                  Image1.Picture.Bitmap.Height);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  bmp := TBitmap.Create;
  bmp.Assign(Image1.Picture.Bitmap);

  case ComboBox1.ItemIndex of
  0 : bmp.PixelFormat := pf24bit;
  1 : bmp.PixelFormat := pf32bit;
  end;

  if SaveDialog1.Execute then
    bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

end.
 