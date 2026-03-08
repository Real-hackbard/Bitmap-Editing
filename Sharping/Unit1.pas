unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Jpeg, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    TrackBar1: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    Label4: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;
  OrigBmp: TBitmap;

implementation

{$R *.dfm}

procedure BmpAccentuation(Bmp : TBitmap; Correction: integer);
type
  TRGBArray = array[Word] of TRGBTriple;
  PRGBArray = ^TRGBArray;
var
  // 3 x 3 pixel matrix
  Filter: array[0..8] of integer;
  Red, Green, Blue, NewR, NewG, NewB, I,
  PosX, PosY, mX, mY, dX, dY, Divisor : integer;
  TabScanlineBmp : array of PRGBArray;
  TabScanlineFinalBmp : array of PRGBArray;
  FinalBmp : TBitmap;
begin
  Screen.Cursor := crHourGlass;
  Form1.Label10.Caption := 'calculating..';
  Application.ProcessMessages;
   for I:= 0 to High(Filter) do
     if I in [0,2,6,8] then Filter[I]:= - Correction
     // +128 permet une correction bien étalée
     else if I = 4 then Filter[I]:= (Correction * 4) + 128
     else Filter[I]:= 0;
   Divisor:= Filter[4] - (Correction * 4);
   FinalBmp := TBitmap.Create;

   try
      FinalBmp.Assign(Bmp);
      SetLength(TabScanlineBmp, Bmp.Height);
      SetLength(TabScanlineFinalBmp, Bmp.Height);
      for I := 0 to Bmp.Height-1 do
      begin
          TabScanlineBmp[I] := Bmp.Scanline[I];
          TabScanlineFinalBmp[I] := FinalBmp.Scanline[I];
      end;

      for PosY := 0 to Bmp.Height - 1 do
      for PosX := 0 to Bmp.Width - 1 do
      begin
             NewR :=0;
             NewG :=0;
             NewB :=0;
             for dY := -1 to 1 do
                for dX := -1 to 1 do
                begin
                   // position of the pixel to be treated
                   mY := PosY + dY;
                   mX := PosX + dX;
                   // Verification of the limits for reducing the effects of the board
                   // Reading the RGB components of each pixel
                   if  (mY >= 1) and (mY <= BMP.Height - 1)
                     and (mX >= 1) and (mX <= BMP.Width - 1) then
                        begin
                           Red := TabScanlineBmp[mY,mX].RGBTRed;
                           Green := TabScanlineBmp[mY,mX].RGBTGreen;
                           Blue := TabScanlineBmp[mY,mX].RGBTBlue;
                        end
                   else
                        begin
                           Red := TabScanlineBmp[PosY,PosX].RGBTRed;
                           Green := TabScanlineBmp[PosY,PosX].RGBTGreen;
                           Blue := TabScanlineBmp[PosY,PosX].RGBTBlue;
                         end;

                   // I can vary from 0 to 8
                   I := 4 + (dY * 3) + dX;
                   NewR := NewR + Red * Filter[I];
                   NewG := NewG + Green * Filter[I];
                   NewB := NewB + Blue * Filter[I];
                end;

             NewR := NewR div Divisor;
             NewG := NewG div Divisor;
             NewB := NewB div Divisor;
             if NewR > 255 then NewR := 255 else if NewR < 0 then NewR := 0;
             if NewG > 255 then NewG := 255 else if NewG < 0 then NewG := 0;
             if NewB > 255 then NewB := 255 else if NewB < 0 then NewB := 0;
             TabScanlineFinalBmp[PosY,PosX].RGBTRed   := NewR;
             TabScanlineFinalBmp[PosY,PosX].RGBTGreen := NewG;
             TabScanlineFinalBmp[PosY,PosX].RGBTBlue  := NewB;

      end;
      Form1.Label4.Caption := IntToStr(NewR);
      Form1.Label5.Caption := IntToStr(NewG);
      Form1.Label6.Caption := IntToStr(NewB);
      Bmp.Assign(FinalBmp);
      Form1.Label10.Caption := 'done.';
   finally
      FinalBmp.Free;
      Finalize(TabScanlineBmp);
      Finalize(TabScanlineFinalBmp);
   end;
   Screen.Cursor := crDefault;
end;


procedure TForm1.FormCreate(Sender: TObject);
var
  Jpg: TJpegImage;
begin
  try
    Jpg:= TJpegImage.Create;
    OrigBmp:= TBitmap.Create;
    Jpg.LoadFromFile(ExtractFilePath(Application.ExeName) + 'gfx.jpg');
    OrigBmp.Assign(Jpg);
    OrigBmp.PixelFormat:= pf24bit;
  finally
    Jpg.Free;
  end;
  Image1.Picture.Bitmap.Assign(OrigBmp);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Jpg: TJpegImage;
begin
  if OpenDialog1.Execute then
    begin
    try
      Jpg:= TJpegImage.Create;
      OrigBmp:= TBitmap.Create;
      Jpg.LoadFromFile(OpenDialog1.FileName);
      OrigBmp.Assign(Jpg);
      OrigBmp.PixelFormat:= pf24bit;
    finally
      Jpg.Free;
      TrackBar1.Position := 0;
    end;
  end;
  Image1.Picture.Bitmap.Assign(OrigBmp);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Origbmp.Free;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
var
  Bmp: TBitmap;
begin
  Bmp:= TBitmap.Create;
  try
    Bmp.Assign(OrigBmp);
    Bmp.PixelFormat:= pf24bit;
    BmpAccentuation(Bmp, Trackbar1.Position);
    Image1.Picture.Bitmap.Assign(Bmp);
  finally
    bmp.Free;
  end;
end;

end.
