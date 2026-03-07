unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    StatusBar1: TStatusBar;
    RadioGroup1: TRadioGroup;
    SpinEdit1: TSpinEdit;
    RadioGroup2: TRadioGroup;
    SpinEdit2: TSpinEdit;
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    Image2: TImage;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure AntiAlias5(const i: TBitmap; var o: TBitmap);
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

type
  PixArray = Array [0..2] of Byte;

type
  PixelA3 = array[1..3] of Byte;
  PixelA15 = array[1..15] of Byte;

implementation

{$R *.dfm}
{$R-}
procedure BmpGBlur(Bmp: TBitmap; radius: Single);
Type
  TRGB = Packed Record b, g, r: Byte End;
  TRGBs = Packed Record b, g, r: Single End;
  TRGBArray = Array[0..0] of TRGB;
Var
  MatrixRadius: Byte;
  Matrix : Array[-100..100] of Single;

  Procedure CalculateMatrix;
  Var x: Integer; Divisor: Single;
  Begin
     // The mean/zero point must be taken into account.
    radius:=radius+1;
    MatrixRadius:=Trunc(radius);
    If Frac(radius)=0 Then Dec(MatrixRadius);
    Divisor:=0;
    For x:=-MatrixRadius To MatrixRadius Do Begin
      Matrix[x]:=radius-abs(x);
      Divisor:=Divisor+Matrix[x];
    End;
    For x:=-MatrixRadius To MatrixRadius Do
      Matrix[x]:=Matrix[x]/Divisor;
  End;

Var
  BmpSL : ^TRGBArray;
  BmpRGB : ^TRGB;
  BmpCopy : Array of Array of TRGBs;
  BmpCopyRGB : ^TRGBs;
  R, G, B : Single;
  BmpWidth, BmpHeight: Integer;
  x, y, mx : Integer;
Begin
  Bmp.PixelFormat:=pf24bit;
  // radius range 0 < radius < 99
  If radius<=0 then radius:=1
    else if
  radius>99
    then radius:=99;

  CalculateMatrix;
  BmpWidth:=Bmp.Width;
  BmpHeight:=Bmp.Height;
  SetLength(BmpCopy,BmpHeight,BmpWidth);
  // Write all pixels to the BmpCopy array and blur horizontally at the same time
  For y:=0 To Pred(BmpHeight) Do Begin
    BmpSL:=Bmp.Scanline[y];
    BmpCopyRGB:=@BmpCopy[y,0];
    For x:=0 to Pred(BmpWidth) Do Begin
      R:=0; G:=0; B:=0;
      For Mx:=-MatrixRadius To MatrixRadius Do Begin
        If x+mx<0 Then
        // first Pixel
          BmpRGB:=@BmpSL^[0]
        Else If x+mx>=BmpWidth Then
        // last Pixel
          BmpRGB:=@BmpSL^[Pred(BmpWidth)]
        Else
          BmpRGB:=@BmpSL^[x+mx];
        B:=B+BmpRGB^.b*Matrix[mx];
        G:=G+BmpRGB^.g*Matrix[mx];
        R:=R+BmpRGB^.r*Matrix[mx];
      End;
      // Color values ​​are cached in the Single type!
      BmpCopyRGB^.b:=B;
      BmpCopyRGB^.g:=G;
      BmpCopyRGB^.r:=R;
      Inc(BmpCopyRGB);
    End;
  End;
  // Write all pixels back to the Bmp bitmap and blur vertically at the same time.
  For y:=0 To Pred(BmpHeight) Do Begin
    BmpRGB:=Bmp.ScanLine[y];
    For x:=0 to Pred(BmpWidth) Do Begin
      R:=0; G:=0; B:=0;
      For mx:=-MatrixRadius To MatrixRadius Do Begin
        If y+mx<=0 Then
          // first Pixel
          BmpCopyRGB:=@BmpCopy[0,x]
        Else If y+mx>=BmpHeight Then
          // last Pixel
          BmpCopyRGB:=@BmpCopy[Pred(BmpHeight),x]
        Else
          BmpCopyRGB:=@BmpCopy[y+mx,x];
        B:=B+BmpCopyRGB^.b*Matrix[mx];
        G:=G+BmpCopyRGB^.g*Matrix[mx];
        R:=R+BmpCopyRGB^.r*Matrix[mx];
      End;
      BmpRGB^.b:=Round(B);
      BmpRGB^.g:=Round(G);
      BmpRGB^.r:=Round(R);
      Inc(BmpRGB);
    End;
  End;
  Screen.Cursor := crDefault;
End;

procedure TForm1.AntiAlias5(const i: TBitmap; var o: TBitmap);
var
  Po: ^PixelA3;
  P1, P2, P3, P4, P5: ^PixelA15;
  x, y: Cardinal;
  dekrement: Cardinal;
  AntAussen, AntMitte, AntInnen: double;
begin
  // Determine the proportions of the regions in the target pixel
  AntAussen := 12*4; // 12 Pixel to 1/4 in Target pixel
  AntMitte := 8*4; // 8 Pixel to 1/4 in Target pixel
  AntInnen := 2; // 1 Pixel to 1/2 in Target pixel

  dekrement := 3*(i.Width-3);

  // Retrieve scanline of the first 5 lines
  P1 := i.ScanLine[0];
  P2 := i.ScanLine[1];
  P3 := i.ScanLine[2];
  P4 := i.ScanLine[3];
  P5 := i.ScanLine[4];

  for y := 2 to i.Height-4 do
  begin
    // Retrieve scanline of target image
    Po := o.ScanLine[y];
    // and increase the x-position by 2 (as mentioned, the edge does not play a role)
    inc(Po, 2);
    for x := 2 to i.Width-2 do
    begin
      // Construct the blue value of the target pixel from the blue values ​​of the source region
      Po^[1] := round(((P1^[4]+P1^[7]+P1^[10] +
                        P2^[1] + P2^[13] +
                        P3^[1] + P3^[13] +
                        P4^[1] + P4^[13] +
                        P5^[4]+P5^[7]+P5^[10]) / AntAussen) +

                      ((P2^[4]+P2^[7]+P2^[10] +
                        P3^[4] +P3^[10] +
                        P4^[4]+P4^[7]+P4^[10]) / AntMitte) +

                       (P3^[7] / AntInnen));

      // Just like with blue, now with green
      Po^[2] := round(((P1^[5]+P1^[8]+P1^[11] +
                        P2^[2] + P2^[14] +
                        P3^[2] + P3^[14] +
                        P4^[2] + P4^[14] +
                        P5^[5]+P5^[8]+P5^[11]) / AntAussen) +

                      ((P2^[5]+P2^[8]+P2^[11] +
                        P3^[5] +P3^[11] +
                        P4^[5]+P4^[8]+P4^[11]) / AntMitte) +

                       (P3^[8] / AntInnen));

        // and with red...
        Po^[3] := round((( P1^[6]+P1^[9]+P1^[12] +
                          P2^[3] + P2^[15] +
                          P3^[3] + P3^[15] +
                          P4^[3] + P4^[15] +
                          P5^[6]+P5^[9]+P5^[12]) / AntAussen) +

                        ((P2^[6]+P2^[9]+P2^[12] +
                          P3^[6] +P3^[12] +
                          P4^[6]+P4^[9]+P4^[12]) / AntMitte) +

                         (P3^[9] / AntInnen));

        // Increment all pointers by 3 bytes - that is, move them one pixel to the right.
        // (PByte because P1-P5 are 15 bytes in size, and also because
        // (15 bytes would be shifted.)
        inc(PByte(P1), 3);
        inc(PByte(P2), 3);
        inc(PByte(P3), 3);
        inc(PByte(P4), 3);
        inc(PByte(P5), 3);

        // Pointer of the target pixel one pixel to the right
        inc(Po, 1);
      end;

     // Drag all pointers to the pixel on the left.
     dec(PByte(P2), dekrement);
     dec(PByte(P3), dekrement);
     dec(PByte(P4), dekrement);
     dec(PByte(P5), dekrement);

     // and then move the lines
     P1 := P2;
     P2 := P3;
     P3 := P4;
     P4 := P5;
     // and get the new line
     P5 := i.ScanLine[y+3];
   end;
   Screen.Cursor := crDefault;
end;

procedure Antialiasing(Bitmap: TBitmap; Rect: TRect; Percent: Integer);
var
  pix, prevscan, nextscan, hpix: ^PixArray;
  l, p: Integer;
  R, G, B: Integer;
  R1, R2, G1, G2, B1, B2: Byte;
begin
  Bitmap.PixelFormat := pf24bit;
  with Bitmap.Canvas do
  begin
    Brush.Style := bsclear;
    for l := Rect.Top to Rect.Bottom - 1 do
    begin
      pix:= Bitmap.ScanLine[l];
      if l <> Rect.Top then prevscan := Bitmap.ScanLine[l-1]
      else prevscan := nil;
      if l <> Rect.Bottom - 1 then nextscan := Bitmap.ScanLine[l+1]
      else nextscan := nil;

      for p := Rect.Left to Rect.Right - 1 do
      begin
        R1 := pix^[2];
        G1 := pix^[1];
        B1 := pix^[0];

        if p <> Rect.Left then
        begin
          //Pixel left

          hpix := pix;
          dec(hpix);
          R2 := hpix^[2];
          G2 := hpix^[1];
          B2 := hpix^[0];

          if (R1 <> R2) or (G1 <> G2) or (B1 <> B2) then
          begin
            R := R1 + (R2 - R1) * 50 div (Percent + 50);
            G := G1 + (G2 - G1) * 50 div (Percent + 50);
            B := B1 + (B2 - B1) * 50 div (Percent + 50);
            hpix^[2] := R;
            hpix^[1] := G;
            hpix^[0] := B;
          end;
        end;

        if p <> Rect.Right - 1 then
        begin
          //Pixel right
          hpix := pix;
          inc(hpix);
          R2 := hpix^[2];
          G2 := hpix^[1];
          B2 := hpix^[0];

          if (R1 <> R2) or (G1 <> G2) or (B1 <> B2) then
          begin
            R := R1 + (R2 - R1) * 50 div (Percent + 50);
            G := G1 + (G2 - G1) * 50 div (Percent + 50);
            B := B1 + (B2 - B1) * 50 div (Percent + 50);
            hpix^[2] := R;
            hpix^[1] := G;
            hpix^[0] := B;
          end;
        end;

        if prevscan <> nil then
        begin
          //Pixel up
          R2 := prevscan^[2];
          G2 := prevscan^[1];
          B2 := prevscan^[0];

          if (R1 <> R2) or (G1 <> G2) or (B1 <> B2) then
          begin
            R := R1 + (R2 - R1) * 50 div (Percent + 50);
            G := G1 + (G2 - G1) * 50 div (Percent + 50);
            B := B1 + (B2 - B1) * 50 div (Percent + 50);
            prevscan^[2] := R;
            prevscan^[1] := G;
            prevscan^[0] := B;
          end;
          Inc(prevscan);
        end;

        if nextscan <> nil then
        begin
          //Pixel down
          R2 := nextscan^[2];
          G2 := nextscan^[1];
          B2 := nextscan^[0];

          if (R1 <> R2) or (G1 <> G2) or (B1 <> B2) then
          begin
            R := R1 + (R2 - R1) * 50 div (Percent + 50);
            G := G1 + (G2 - G1) * 50 div (Percent + 50);
            B := B1 + (B2 - B1) * 50 div (Percent + 50);
            nextscan^[2] := R;
            nextscan^[1] := G;
            nextscan^[0] := B;
          end;
          Inc(nextscan);
        end;
        Inc(pix);
      end;
    end;
  end;
  Screen.Cursor := crDefault;
end; 

procedure TForm1.Button1Click(Sender: TObject);
var
  a : integer;
begin
  Screen.Cursor := crHourGlass;
  CheckBox1.Enabled := false;
  Image2.Picture.Bitmap.Assign(Image1.Picture.Bitmap);

  case RadioGroup1.ItemIndex of
  0 : a := 2;
  1 : a := 4;
  2 : a := 8;
  3 : a := 16;
  4 : a := SpinEdit1.Value;
  end;

  Antialiasing(Image2.Picture.Bitmap,
  Rect(0, 0, Image2.Picture.Bitmap.Width, Image2.Picture.Bitmap.Height), a);
  StatusBar1.SetFocus;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Image2.Picture.Bitmap.Assign(Image1.Picture.Bitmap);
  StatusBar1.SetFocus;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  a : integer;
  bmp1, bmp2 : TBitmap;
begin
  Screen.Cursor := crHourGlass;
  CheckBox1.Enabled := true;

  bmp1 := TBitmap.Create;
  bmp1.Assign(Image1.Picture.Bitmap);
  bmp1.Width := Image1.Width;
  bmp1.Height :=Image2.Height;
  bmp1.PixelFormat := pf24Bit;

  bmp2 := TBitmap.Create;
  bmp2.Assign(Image1.Picture.Bitmap);
  bmp2.Width := Image2.Width;
  bmp2.Height := Image2.Height;
  bmp2.PixelFormat := pf24Bit;

  //bmp1.Assign(Image1.Picture.Bitmap);
  //bmp2.Assign(Image1.Picture.Bitmap);
  case RadioGroup2.ItemIndex of
  0 : a := 2;
  1 : a := 4;
  2 : a := 8;
  3 : a := 16;
  4 : a := SpinEdit2.Value;
  end;

  if CheckBox1.Checked = true then begin
    BmpGBlur(bmp1, a);
    Image2.Picture.Bitmap.Assign(bmp1);
  end;

  AntiAlias5(bmp1, bmp2);
  Image2.Picture.Bitmap.Assign(bmp2);
  //Image1.Picture.Bitmap.Assign(bmp1);
  Image1.Stretch := true;
  Image2.Stretch := true;

  StatusBar1.SetFocus;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    Image2.Picture.Bitmap.Assign(Image1.Picture.Bitmap);
  end;
  StatusBar1.SetFocus;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  CheckBox1.Enabled := false;

  case RadioGroup1.ItemIndex of
  0 : StatusBar1.SimpleText := 'MSAA x2';
  1 : StatusBar1.SimpleText := 'MSAA x4';
  2 : StatusBar1.SimpleText := 'MSAA x8';
  3 : StatusBar1.SimpleText := 'MSAA x16';
  4 : StatusBar1.SimpleText := 'MSAA ' + IntToStr(SpinEdit1.Value);
  end;
  StatusBar1.SetFocus;
end;

procedure TForm1.RadioGroup2Click(Sender: TObject);
begin
  CheckBox1.Enabled := false;

  case RadioGroup2.ItemIndex of
  0 : StatusBar1.SimpleText := 'SSAA x2';
  1 : StatusBar1.SimpleText := 'SSAA x4';
  2 : StatusBar1.SimpleText := 'SSAA x8';
  3 : StatusBar1.SimpleText := 'SSAA x16';
  4 : StatusBar1.SimpleText := 'SSAA ' + IntToStr(SpinEdit2.Value);
  end;
  StatusBar1.SetFocus;
end;

end.
 