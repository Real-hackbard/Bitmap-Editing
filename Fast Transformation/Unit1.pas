unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Grids, Vcl.Imaging.jpeg,
  Vcl.Menus, Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TRGBArray = ARRAY[0..32767] OF TRGBTriple;
  pRGBArray = ^TRGBArray;

type
  TForm1 = class(TForm)
    P5: TPanel;
    L1: TLabel;
    SG1: TStringGrid;
    Edit1: TEdit;
    C1: TComboBox;
    CB1: TCheckBox;
    rg1: TRadioGroup;
    OpenPictureDialog1: TOpenPictureDialog;
    MainMenu1: TMainMenu;
    M5: TMenuItem;
    M6: TMenuItem;
    Me4: TMenuItem;
    D1: TButton;
    L2: TLabel;
    D2: TButton;
    D3: TButton;
    f1: TMenuItem;
    D4: TButton;
    D5: TButton;
    D6: TButton;
    D7: TButton;
    P2: TPanel;
    Image1: TImage;
    D8: TButton;
    D11: TButton;
    D12: TButton;
    D13: TButton;
    D14: TButton;
    D15: TButton;
    D10: TButton;
    D9: TButton;
    D16: TButton;
    D17: TButton;
    D18: TButton;
    S1: TSpeedButton;
    S2: TSpeedButton;
    S3: TSpeedButton;
    I2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure B1C(Sender: TObject);
    procedure B2C(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure B3C(Sender: TObject);
    procedure C1C(Sender: TObject);
    procedure B4C(Sender: TObject);
    procedure D4C(Sender: TObject);
    procedure D5C(Sender: TObject);
    procedure S3C(Sender: TObject);
    procedure zurueck(sender:tobject);
    procedure D9C(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure schalter;
  public
    { Public declarations }
    OriginalBMP : TBitmap;
    procedure CopyMe(tobmp: TBitmap; frbmp : TGraphic);
    procedure ConvolveM(ray : array of integer; z : word; aBmp : TBitmap);
    procedure ConvolveE(ray : array of integer; z : word; aBmp : TBitmap);
    procedure ConvolveI(ray : array of integer; z : word; aBmp : TBitmap);
  end;

var  Form1: TForm1;

implementation

//uses grund, grundx;

{$R *.DFM}
{$R-}

procedure tForm1.schalter;
var
  b,h,i:integer;
begin
  CopyMe(OriginalBMP,I2.Picture.Graphic);
  Image1.Picture.Assign(OriginalBMP);
  b:= Image1.width;
  h:= Image1.height;
  Image1.left:=(p2.width-B) div 2;
  Image1.top:=(p2.height-h) div 2;
  for i:=2 to 18 do
    TButton(FindComponent('d'+IntToStr(i))).enabled:=true;
  Cb1.Enabled := TRUE;
  C1.Enabled := TRUE;
end;

procedure TForm1.zurueck(sender:tobject);
var
  b,h:integer;
begin
  if CB1.Checked then begin
    Image1.Picture.Assign(OriginalBMP);
    b:= Image1.width;
    h:= Image1.height;
    Image1.left:=(p2.width-B) div 2;
    Image1.top:=(p2.height-h) div 2;
  end;
end;

procedure TForm1.CopyMe(tobmp: TBitmap; frbmp : TGraphic);
begin
  tobmp.Width := frbmp.Width;
  tobmp.Height := frbmp.Height;
  tobmp.PixelFormat := pf24bit;
  tobmp.Canvas.Draw(0,0,frbmp);
end;

function Set255(Clr : integer) : integer;
asm
  MOV  EAX,Clr  // store value in EAX register (32-bit register)
  CMP  EAX,254  // compare it to 254
  JG   @SETHI   // if greater than 254 then go set to 255 (max value)
  CMP  EAX,1    // if less than 255, compare to 1
  JL   @SETLO   // if less than 1 go set to 0 (min value)
  RET           // otherwise it doesn't change, just exit
@SETHI:         // Set value to 255
  MOV  EAX,255  // Move 255 into the EAX register
  RET           // Exit (result value is the EAX register value)
@SETLO:         // Set value to 0
  MOV  EAX,0    // Move 0 into EAX register
end;            // Result is in EAX

procedure TForm1.ConvolveM(ray : array of integer; z : word; aBmp : TBitmap);
var
  O, T, C, B : pRGBArray;
  x, y : integer;
  tBufr : TBitmap;
begin
  tBufr := TBitmap.Create;
  tBufr.Width:=aBmp.Width+2;
  tBufr.Height:=aBmp.Height+2;
  tBufr.PixelFormat := pf24bit;
  O := tBufr.ScanLine[0];
  T := aBmp.ScanLine[0];
  O[0] := T[0];  // Left
  O[tBufr.Width - 1] := T[aBmp.Width - 1];
  tBufr.Canvas.CopyRect(RECT(1,0,tBufr.Width - 1,1),aBmp.Canvas,
        RECT(0,aBmp.Height - 1,aBmp.Width,aBmp.Height-2));

  O := tBufr.ScanLine[tBufr.Height - 1];
  T := aBmp.ScanLine[aBmp.Height - 1];
  O[0] := T[0];
  O[tBufr.Width - 1] := T[aBmp.Width - 1];
  tBufr.Canvas.CopyRect(RECT(1,tBufr.Height-1,tBufr.Width - 1,tBufr.Height),
       aBmp.Canvas,RECT(0,0,aBmp.Width,1));
  tBufr.Canvas.CopyRect(RECT(tBufr.Width-1,1,tBufr.Width,tBufr.Height-1),
       aBmp.Canvas,RECT(0,0,1,aBmp.Height));
  tBufr.Canvas.CopyRect(RECT(0,1,1,tBufr.Height-1),
        aBmp.Canvas,RECT(aBmp.Width - 1,0,aBmp.Width,aBmp.Height));
  tBufr.Canvas.CopyRect(RECT(1,1,tBufr.Width - 1,tBufr.Height - 1),
        aBmp.Canvas,RECT(0,0,aBmp.Width,aBmp.Height));
  for x := 0 to aBmp.Height - 1 do begin
    O := aBmp.ScanLine[x];
    T := tBufr.ScanLine[x];
    C := tBufr.ScanLine[x+1];
    B := tBufr.ScanLine[x+2];
    for y := 1 to (tBufr.Width - 2) do begin
      O[y-1].rgbtRed := Set255(
        ((T[y-1].rgbtRed*ray[0]) +
        (T[y].rgbtRed*ray[1]) + (T[y+1].rgbtRed*ray[2]) +
        (C[y-1].rgbtRed*ray[3]) +
        (C[y].rgbtRed*ray[4]) + (C[y+1].rgbtRed*ray[5])+
        (B[y-1].rgbtRed*ray[6]) +
        (B[y].rgbtRed*ray[7]) + (B[y+1].rgbtRed*ray[8])) div z
        );
      O[y-1].rgbtBlue := Set255(
        ((T[y-1].rgbtBlue*ray[0]) +
        (T[y].rgbtBlue*ray[1]) + (T[y+1].rgbtBlue*ray[2]) +
        (C[y-1].rgbtBlue*ray[3]) +
        (C[y].rgbtBlue*ray[4]) + (C[y+1].rgbtBlue*ray[5])+
        (B[y-1].rgbtBlue*ray[6]) +
        (B[y].rgbtBlue*ray[7]) + (B[y+1].rgbtBlue*ray[8])) div z
        );
      O[y-1].rgbtGreen := Set255(
        ((T[y-1].rgbtGreen*ray[0]) +
        (T[y].rgbtGreen*ray[1]) + (T[y+1].rgbtGreen*ray[2]) +
        (C[y-1].rgbtGreen*ray[3]) +
        (C[y].rgbtGreen*ray[4]) + (C[y+1].rgbtGreen*ray[5])+
        (B[y-1].rgbtGreen*ray[6]) +
        (B[y].rgbtGreen*ray[7]) + (B[y+1].rgbtGreen*ray[8])) div z
        );
    end;
  end;
  tBufr.Free;
end;

procedure TForm1.ConvolveE(ray : array of integer; z : word; aBmp : TBitmap);
var
  O, T, C, B : pRGBArray;
  x, y : integer;
  tBufr : TBitmap;
begin
  tBufr := TBitmap.Create;
  tBufr.Width:=aBmp.Width+2;
  tBufr.Height:=aBmp.Height+2;
  tBufr.PixelFormat := pf24bit;
  O := tBufr.ScanLine[0];
  T := aBmp.ScanLine[0];
  O[0] := T[0];
  O[tBufr.Width - 1] := T[aBmp.Width - 1];
  tBufr.Canvas.CopyRect(RECT(1,0,tBufr.Width - 1,1),aBmp.Canvas,
        RECT(0,0,aBmp.Width,1));

  O := tBufr.ScanLine[tBufr.Height - 1];
  T := aBmp.ScanLine[aBmp.Height - 1];
  O[0] := T[0];
  O[tBufr.Width - 1] := T[aBmp.Width - 1];
  tBufr.Canvas.CopyRect(RECT(1,tBufr.Height-1,tBufr.Width - 1,tBufr.Height),
       aBmp.Canvas,RECT(0,aBmp.Height-1,aBmp.Width,aBmp.Height));
  tBufr.Canvas.CopyRect(RECT(tBufr.Width-1,1,tBufr.Width,tBufr.Height-1),
       aBmp.Canvas,RECT(aBmp.Width-1,0,aBmp.Width,aBmp.Height));
  tBufr.Canvas.CopyRect(RECT(0,1,1,tBufr.Height-1),
       aBmp.Canvas,RECT(0,0,1,aBmp.Height));
  tBufr.Canvas.CopyRect(RECT(1,1,tBufr.Width - 1,tBufr.Height - 1),
       aBmp.Canvas,RECT(0,0,aBmp.Width,aBmp.Height));
  for x := 0 to aBmp.Height - 1 do begin
    O := aBmp.ScanLine[x];
    T := tBufr.ScanLine[x];
    C := tBufr.ScanLine[x+1];
    B := tBufr.ScanLine[x+2];
    for y := 1 to (tBufr.Width - 2) do begin
      O[y-1].rgbtRed := Set255(
        ((T[y-1].rgbtRed*ray[0]) +
        (T[y].rgbtRed*ray[1]) + (T[y+1].rgbtRed*ray[2]) +
        (C[y-1].rgbtRed*ray[3]) +
        (C[y].rgbtRed*ray[4]) + (C[y+1].rgbtRed*ray[5])+
        (B[y-1].rgbtRed*ray[6]) +
        (B[y].rgbtRed*ray[7]) + (B[y+1].rgbtRed*ray[8])) div z
        );
      O[y-1].rgbtBlue := Set255(
        ((T[y-1].rgbtBlue*ray[0]) +
        (T[y].rgbtBlue*ray[1]) + (T[y+1].rgbtBlue*ray[2]) +
        (C[y-1].rgbtBlue*ray[3]) +
        (C[y].rgbtBlue*ray[4]) + (C[y+1].rgbtBlue*ray[5])+
        (B[y-1].rgbtBlue*ray[6]) +
        (B[y].rgbtBlue*ray[7]) + (B[y+1].rgbtBlue*ray[8])) div z
        );
      O[y-1].rgbtGreen := Set255(
        ((T[y-1].rgbtGreen*ray[0]) +
        (T[y].rgbtGreen*ray[1]) + (T[y+1].rgbtGreen*ray[2]) +
        (C[y-1].rgbtGreen*ray[3]) +
        (C[y].rgbtGreen*ray[4]) + (C[y+1].rgbtGreen*ray[5])+
        (B[y-1].rgbtGreen*ray[6]) +
        (B[y].rgbtGreen*ray[7]) + (B[y+1].rgbtGreen*ray[8])) div z
        );
    end;
  end;
  tBufr.Free;
end;

procedure TForm1.ConvolveI(ray : array of integer; z : word; aBmp : TBitmap);
var
  O, T, C, B : pRGBArray;
  x, y : integer;
  tBufr : TBitmap;
begin
  tBufr := TBitmap.Create;
  tBufr.PixelFormat := pf24bit;
  CopyMe(tBufr,aBmp);
  for x := 1 to aBmp.Height - 2 do begin
    O := aBmp.ScanLine[x];
    T := tBufr.ScanLine[x-1];
    C := tBufr.ScanLine[x];
    B := tBufr.ScanLine[x+1];
    for y := 1 to (tBufr.Width - 2) do begin
      O[y].rgbtRed := Set255(
        ((T[y-1].rgbtRed*ray[0]) +
        (T[y].rgbtRed*ray[1]) + (T[y+1].rgbtRed*ray[2]) +
        (C[y-1].rgbtRed*ray[3]) +
        (C[y].rgbtRed*ray[4]) + (C[y+1].rgbtRed*ray[5])+
        (B[y-1].rgbtRed*ray[6]) +
        (B[y].rgbtRed*ray[7]) + (B[y+1].rgbtRed*ray[8])) div z);
      O[y].rgbtBlue := Set255(
        ((T[y-1].rgbtBlue*ray[0]) +
        (T[y].rgbtBlue*ray[1]) + (T[y+1].rgbtBlue*ray[2]) +
        (C[y-1].rgbtBlue*ray[3]) +
        (C[y].rgbtBlue*ray[4]) + (C[y+1].rgbtBlue*ray[5])+
        (B[y-1].rgbtBlue*ray[6]) +
        (B[y].rgbtBlue*ray[7]) + (B[y+1].rgbtBlue*ray[8])) div z);
      O[y].rgbtGreen := Set255(
        ((T[y-1].rgbtGreen*ray[0]) +
        (T[y].rgbtGreen*ray[1]) + (T[y+1].rgbtGreen*ray[2]) +
        (C[y-1].rgbtGreen*ray[3]) +
        (C[y].rgbtGreen*ray[4]) + (C[y+1].rgbtGreen*ray[5])+
        (B[y-1].rgbtGreen*ray[6]) +
        (B[y].rgbtGreen*ray[7]) + (B[y+1].rgbtGreen*ray[8])) div z);
    end;
  end;
  tBufr.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  x,y : integer;
begin
  OriginalBMP := TBitmap.Create;
  OriginalBMP.PixelFormat := pf24bit;
  for y := 0 to 2 do
    for x := 0 to 2 do
      SG1.Cells[y,x] := '-1';
  SG1.Cells[1,1] := '9';
end;

procedure TForm1.B1C(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then begin
    I2.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    schalter;
  end;
end;

procedure TForm1.B2C(Sender: TObject);
var
  ray : array [0..8] of integer;
  z,i,j : word;
  OrigBMP : TBitmap;
begin
  zurueck(sender);
  OrigBMP := TBitmap.Create;
  OrigBMP.PixelFormat := pf24bit;
  CopyMe(OrigBMP, Image1.Picture.Graphic);
  for i:=0 to 2 do
    for j:=0 to 2 do
      ray[3*i+j] := strtoint(SG1.Cells[j,i]);
  z := strtoInt(Edit1.text);
  if z = 0 then z := 1;
  case rg1.ItemIndex of
    0 : ConvolveM(ray,z,OrigBMP);
    1 : ConvolveE(ray,z,OrigBMP);
    2 : ConvolveI(ray,z,OrigBMP);
  end;
  Image1.Picture.Assign(OrigBMP);
  OrigBMP.Free;
  Image1.Refresh;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Image1.free;
  i2.free;
  OriginalBMP.Free;
end;

procedure TForm1.B3C(Sender: TObject);
begin
  Image1.Picture.Assign(OriginalBMP);
  Image1.Refresh;
end;

procedure TForm1.C1C(Sender: TObject);
const parameter : array[0..11] of array[0..9] of shortint =
      ((-1,-1,-1,-1,8,-1,-1,-1,-1,1),(-1,-1,-1,-1,9,-1,-1,-1,-1,1),
       (1,1,1,1,-2,1,-1,-1,-1,1),(-1,-1,-1,-1,16,-1,-1,-1,-1,8),
       (0,-1,0,-1,5,-1,0,-1,0,1),(1,0,1,0,0,0,1,0,-2,1),
       (2,2,2,2,0,2,2,2,2,16),(3,3,3,3,8,3,3,3,3,32),
       (-1,0,1,-1,0,1,-1,0,1,1),(3,0,-3,10,0,-10,3,0,-3,1),
       (1,1,1,1,1,1,1,1,1,9),(1,2,1,2,4,2,1,2,1,16));
var
  i,j : integer;
  ray : array [0..8] of integer;
begin
  for i:=0 to 8 do ray[i]:=parameter[c1.itemindex,i];
    edit1.text:=inttostr(parameter[c1.itemindex,9]);
  for i:=0 to 2 do
    for j:=0 to 2 do
      SG1.Cells[j,i] := IntToStr(ray[3*i+j]);
  b2C(sender);
end;

procedure TForm1.B4C(Sender: TObject);
begin
  close
end;

procedure Invertieren32Bit(Bitmap:TBitmap);
var j :  INTEGER;
    P   :  PDWord;
begin
   p := Bitmap.Scanline[Bitmap.Height-1];
   for j := 1 to Bitmap.Height* Bitmap.Width do begin
     p^ := not p^;
     inc(p);
   end;
   bitmap.Assign(bitmap);
end;

procedure TForm1.D5C(Sender: TObject);
begin
  zurueck(sender);
  Image1.Picture.bitmap.PixelFormat := pf32bit;
  Invertieren32bit(Image1.picture.bitmap);
end;

procedure Graustufen(Bitmap:TBitmap);
var i,j  :  INTEGER;
    Row  :  ^TRGBTriple;
    grau : byte;
begin
  for j := 0 to Bitmap.Height-1 do begin
    row := Bitmap.Scanline[j];
    for i := 0 to Bitmap.Width-1 do begin
      grau := (row^.rgbtred * 77 + row^.rgbtgreen * 151 +
                                   row^.rgbtblue * 28) div 256;
      row^.rgbtred   := grau;
      row^.rgbtBlue  := grau;
      row^.rgbtgreen := grau;
      inc(row);
    end;
  end;
  bitmap.Assign(bitmap);
end;

procedure Helligkeit(Bitmap, Original : TBitmap; Value    : integer);
var x,y     : integer;
    Ziel    : ^TRGBTriple;
    Quelle  : ^TRGBTriple;
    n       : byte;
    ar      : array[0..255] of byte;
begin
  n := abs(value);
  if value > 0 then
    for x := 0 to 255 do
      if integer(x + n) > 255 then ar[x] := 255 else ar[x] := x + n
      else
        for x := 0 to 255 do
          if integer(x - n) < 0 then ar[x] := 0 else ar[x] := x - n;
  for y := 0 to Bitmap.Height-1 do begin
    Ziel   := Bitmap.Scanline[y];
    Quelle := Original.Scanline[y];
    for x := 0 to (Bitmap.Width-1) do begin
      Ziel^.rgbtBlue  := ar[Quelle^.rgbtBlue];
      Ziel^.rgbtred   := ar[Quelle^.rgbtred];
      Ziel^.rgbtGreen := ar[Quelle^.rgbtGreen];
      inc(Ziel);
      inc(quelle);
    end;
  end;
end;

procedure Kontrast(Bitmap:TBitmap; value: byte);
var x,y     : integer;
    Ziel,
    Quelle  : ^TRGBTriple;
    ar      : array[0..255] of byte;
    k       : integer;
    fak     : single;
begin
  fak := 1 + value /100;
  for x := 0 to 255 do begin
    k := Round((integer(x) - 128)*fak) + 128;
    IF k > 255 THEN
      ar[x] := 255
    ELSE
     IF k < 0 THEN
       ar[x] := 0
     ELSE
       ar[x] := k;
  end;
  for y := 0 to Bitmap.Height-1 do begin
    Ziel   := Bitmap.Scanline[y];
    Quelle := Bitmap.Scanline[y];
    for x := 0 to (Bitmap.Width-1) do begin
      Ziel^.rgbtred   := ar[Quelle^.rgbtred];
      Ziel^.rgbtblue  := ar[Quelle^.rgbtblue];
      Ziel^.rgbtgreen := ar[Quelle^.rgbtgreen];
      inc(ziel);
      inc(quelle);
    end;
  end;
end;

procedure SpiegelnHorizontal(Bitmap:TBitmap);
var i,j,w :  INTEGER;
    RowIn :  pRGBArray;
    RowOut:  pRGBArray;
begin
  w := bitmap.width*sizeof(TRGBTriple);
  Getmem(rowin,w);
  for j := 0 to Bitmap.Height-1 do begin
    move(Bitmap.Scanline[j]^,rowin^,w);
    rowout := Bitmap.Scanline[j];
    for i := 0 to Bitmap.Width-1 do rowout[i] := rowin[Bitmap.Width-1-i];
  end;
  bitmap.Assign(bitmap);
  Freemem(rowin);
end;

procedure SpiegelnVertikal(Bitmap : TBitmap);
var j,w :  INTEGER;
    help  :  TBitmap;
begin
  help := TBitmap.Create;
  help.Width       := Bitmap.Width;
  help.Height      := Bitmap.Height;
  help.PixelFormat := Bitmap.PixelFormat;
  w := Bitmap.Width*sizeof(TRGBTriple);
  for j := 0 to Bitmap.Height-1 do
    move(Bitmap.Scanline[j]^,Help.Scanline[Bitmap.Height - 1 - j]^,w);
  Bitmap.Assign(help);
  help.free;
end;

type TMyhelp = array[0..0] of TRGBQuad;

procedure Drehen90Grad(Bitmap:TBitmap);
var P       : PRGBQuad;
    x,y,b,h : Integer;
    RowOut  : ^TMyHelp;
    help    : TBitmap;

BEGIN
  Bitmap.PixelFormat := pf32bit;
  help := TBitmap.Create;
  help.PixelFormat := pf32bit;
  b := bitmap.Height;
  h := bitmap.Width;
  help.Width := b;
  help.height := h;
  for y := 0 to (h-1) do begin
    rowOut := help.ScanLine[y];
    P  := Bitmap.scanline[bitmap.height-1];
    inc(p,y);
    for x := 0 to (b-1) do begin
      rowout[x] := p^;
      inc(p,h);
    end;
  end;
  bitmap.Assign(help);
end;
procedure TForm1.S3C(Sender: TObject);
var b,h:integer;
begin
  zurueck(sender);
  Image1.Picture.bitmap.PixelFormat := pf24bit;
  Drehen90Grad(Image1.picture.bitmap);
  b:= Image1.width;
  h:= Image1.height;
  Image1.left:=(p2.width-B) div 2;
  Image1.top:=(p2.height-h) div 2;
end;

procedure Graustufen2(Bitmap:TBitmap);
var i,j  :  INTEGER;
    Row  :  ^TRGBTriple;
    grau : byte;
begin
  for j := 0 to Bitmap.Height-1 do begin
    row := Bitmap.Scanline[j];
    for i := 0 to Bitmap.Width-1 do begin
      grau := (row^.rgbtred + row^.rgbtgreen + row^.rgbtblue) div 3;
      row^.rgbtred   := grau;
      row^.rgbtBlue  := grau;
      row^.rgbtgreen := grau;
      inc(row);
    end;
  end;
  bitmap.Assign(bitmap);
end;

procedure rot(Bitmap:TBitmap);
var i,j  :  INTEGER;
    Row  :  ^TRGBTriple;
begin
  for j := 0 to Bitmap.Height-1 do begin
    row := Bitmap.Scanline[j];
    for i := 0 to Bitmap.Width-1 do begin
      row^.rgbtBlue  := 0;
      row^.rgbtgreen := 0;
      inc(row);
    end;
  end;
  bitmap.Assign(bitmap);
end;

procedure gruen(Bitmap:TBitmap);
var i,j  :  INTEGER;
    Row  :  ^TRGBTriple;
begin
  for j := 0 to Bitmap.Height-1 do begin
    row := Bitmap.Scanline[j];
    for i := 0 to Bitmap.Width-1 do begin
      row^.rgbtred  := 0;
      row^.rgbtblue := 0;
      inc(row);
    end;
  end;
  bitmap.Assign(bitmap);
end;

procedure blau(Bitmap:TBitmap);
var i,j  :  INTEGER;
    Row  :  ^TRGBTriple;
begin
  for j := 0 to Bitmap.Height-1 do begin
    row := Bitmap.Scanline[j];
    for i := 0 to Bitmap.Width-1 do begin
      row^.rgbtred  := 0;
      row^.rgbtgreen := 0;
      inc(row);
    end;
  end;
  bitmap.Assign(bitmap);
end;

procedure rot2(Bitmap:TBitmap);
var i,j,h  :  INTEGER;
    Row  :  ^TRGBTriple;
begin
  for j := 0 to Bitmap.Height-1 do begin
    row := Bitmap.Scanline[j];
    for i := 0 to Bitmap.Width-1 do begin
      h:=row^.rgbtred;
      row^.rgbtred:=row^.rgbtgreen;
      row^.rgbtgreen := h;
      inc(row);
    end;
  end;
  bitmap.Assign(bitmap);
end;

procedure rot3(Bitmap:TBitmap);
var i,j,h  :  INTEGER;
    Row  :  ^TRGBTriple;
begin
  for j := 0 to Bitmap.Height-1 do begin
    row := Bitmap.Scanline[j];
    for i := 0 to Bitmap.Width-1 do begin
      h:=row^.rgbtred;
      row^.rgbtred:=row^.rgbtblue;
      row^.rgbtblue := h;
      inc(row);
    end;
  end;
  bitmap.Assign(bitmap);
end;

procedure rot4(Bitmap:TBitmap);
var i,j,h  :  INTEGER;
    Row  :  ^TRGBTriple;
begin
  for j := 0 to Bitmap.Height-1 do begin
    row := Bitmap.Scanline[j];
    for i := 0 to Bitmap.Width-1 do begin
      h:=row^.rgbtblue;
      row^.rgbtblue:=row^.rgbtgreen;
      row^.rgbtgreen := h;
      inc(row);
    end;
  end;
  bitmap.Assign(bitmap);
end;
procedure rot5(Bitmap:TBitmap);
var i,j  :  INTEGER;
    Row  :  ^TRGBTriple;
begin
  for j := 0 to Bitmap.Height-1 do begin
    row := Bitmap.Scanline[j];
    for i := 0 to Bitmap.Width-1 do begin
      row^.rgbtred:=255-row^.rgbtred;
      inc(row);
    end;
  end;
  bitmap.Assign(bitmap);
end;
procedure rot6(Bitmap:TBitmap);
var i,j  :  INTEGER;
    Row  :  ^TRGBTriple;
begin
  for j := 0 to Bitmap.Height-1 do begin
    row := Bitmap.Scanline[j];
    for i := 0 to Bitmap.Width-1 do begin
      row^.rgbtgreen:=255-row^.rgbtgreen;
      inc(row);
    end;
  end;
  bitmap.Assign(bitmap);
end;
procedure rot7(Bitmap:TBitmap);
var i,j  :  INTEGER;
    Row  :  ^TRGBTriple;
begin
  for j := 0 to Bitmap.Height-1 do begin
    row := Bitmap.Scanline[j];
    for i := 0 to Bitmap.Width-1 do begin
      row^.rgbtblue:=255-row^.rgbtblue;
      inc(row);
    end;
  end;
  bitmap.Assign(bitmap);
end;

procedure TForm1.D4C(Sender: TObject);
begin
  zurueck(sender);
  Image1.Picture.bitmap.PixelFormat := pf24bit;
  if sender=d4 then graustufen(Image1.picture.bitmap);
  if sender=d8 then graustufen2(Image1.picture.bitmap);
  if sender=d6 then begin
    Helligkeit(Image1.picture.bitmap,Image1.picture.bitmap,15);
    Image1.repaint
  end;
  if sender=d7 then begin
    Kontrast(Image1.picture.bitmap,55);
    Image1.repaint
  end;
  if sender=s2 then SpiegelnVertikal(Image1.picture.bitmap);
  if sender=s1 then SpiegelnHorizontal(Image1.picture.bitmap);
  if sender=d11 then rot(Image1.picture.bitmap);
  if sender=d12 then gruen(Image1.picture.bitmap);
  if sender=d13 then blau(Image1.picture.bitmap);
  if sender=d14 then rot2(Image1.picture.bitmap);
  if sender=d15 then rot3(Image1.picture.bitmap);
  if sender=d10 then rot4(Image1.picture.bitmap);
  if sender=d16 then rot5(Image1.picture.bitmap);
  if sender=d17 then rot6(Image1.picture.bitmap);
  if sender=d18 then rot7(Image1.picture.bitmap);
end;

procedure TForm1.D9C(Sender: TObject);
  procedure Sepia(bmp: TBitmap);
  var
    gcolor:integer;//greyscale color
    r,g,b:byte;
    h,w:integer;
    RowOriginal :  pRGBArray;
    depth:byte;
  begin
    depth:=34;
    for h := 0 to bmp.height-1 do begin
      RowOriginal  := pRGBArray(bmp.Scanline[h]);
      for w := 0 to bmp.width-1 do begin
        //get greyscale
        r:=RowOriginal[w].rgbtRed;
        g:=RowOriginal[w].rgbtGreen;
        b:=RowOriginal[w].rgbtBlue;
        gcolor:=(r+g+b) div 3;
        //then convert it to sepia
        r:=gcolor+(depth*2);
        g:=gcolor+depth;
        b:=gcolor;
        if r <= ((depth*2)-1) then
          r:=255;
        if g <= (depth-1) then
          g:=255;
        //output
        RowOriginal[w].rgbtRed:=r;
        RowOriginal[w].rgbtGreen:=g;
        RowOriginal[w].rgbtBlue:=b;
      end;
    end;
  end;
begin
  zurueck(sender);
  Image1.Picture.bitmap.PixelFormat := pf24bit;
  sepia(Image1.picture.bitmap);
  Image1.repaint
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  schalter;
end;

end.
