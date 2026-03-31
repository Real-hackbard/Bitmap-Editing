unit Unit1;
{$R-}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, System.Types, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Image1            : TImage;
    Panel1            : TPanel;
    Button3: TButton;
    Button2: TButton;
    Button1: TButton;
    edtTimes          : TEdit;
    UpDown1           : TUpDown;
    Label1            : TLabel;
    SaveDialog1: TSaveDialog;
    PopupMenu1: TPopupMenu;
    S1: TMenuItem;
    procedure FormCreate             (Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormResize             (Sender: TObject);
    procedure Button3Click      (Sender: TObject);
    procedure UpDown1Changing        (Sender: TObject;
      var AllowChange: Boolean);
    procedure Reset;
    procedure S1Click(Sender: TObject);

  private
    { Private-Deklarationen}
  public
    { Public-Deklarationen}
  end;

var
  Form1: TForm1;


IMPLEMENTATION

{$R *.dfm}

type
	TBMPinfos  = record // DATA NECESSARY TO DRAW IN THE MEMORY OF A BITMAP.
  	Sc0,              // Value, in Integer, of the address of line[0] of the Bitmap.
    BpL,              // Bytes per line: size of a line of pixels in memory (in bytes).
    BpP,              // Bytes per Pixel: pixel format (in bytes)
    Wth,              // Bitmap width.
    Hht: Integer;     // Bitmap height.
               end;

{ Returns a TBMPinfos of the Bitmap passed as a parameter: }
function GetBMPinfos(const BMP: TBitmap; var BMPinfos : TBMPinfos): Boolean;
begin
  Result := true;
  if Assigned(BMP) then begin
    with BMPinfos, BMP do begin
      Wth   := Width;
  	  Hht   := Height;
      if (Wth=0) or (Hht=0) then begin
        ShowMessage('The BitMap has a dimension equal to zero !');
        Result := false;
        Exit;
      end;
      case BMP.PixelFormat of
        pf24bit : BpP := 3;
        pf32bit	: BpP := 4;
        else  begin
                ShowMessage('The Bitmap format is not supported. !');
                Result := false;
                Exit;
      end;    end;
  	  BpL := (((Wth * BpP shl 3) + 31) and -31) shr 3;
      Sc0 := Integer(ScanLine[0]);
      if Sc0-Integer(ScanLine[1])<0 then begin
        ShowMessage('Top-Down DIB not supported !'#13#10'(Bottom-Up DIB only)');
    	  Result := false;
    	  Exit;
      end;
    end;  end
  else begin
    ShowMessage('The bitmap is not assigned !');
    Result := false;
  end;
end;

{ Reset the performance counters to zero. }
procedure TForm1.Reset;
begin
  with image1.Picture.Bitmap.Canvas do
    FillRect(ClipRect);
    Button1.Caption := 'Canvas Gradient';
    Button1.Tag := 999999;
    Button2.Caption := 'Memory Gradient';
    Button2.Tag := 999999;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //DoubleBuffered  := true; // Not useful here.
  //Width           := 393;
  //Height          := 450;
  Image1.Align    := alClient;
	with Image1.Picture.Bitmap do begin
  	Width         := Image1.Width;
  	Height        := Image1.Height;
    PixelFormat   := pf24bit;
	end;
  Reset;
end;

procedure TForm1.FormResize(Sender: TObject);
  begin
  with Image1 do begin
    Picture.Bitmap.Width  := Width;
    Picture.Bitmap.Height := Height;
  end;
  Reset;
end;

{ Andres' circle drawing algorithm on TCanvas. }
procedure DrawAndresCircle(Canv: TCanvas; Cx,Cy,R,Col: Integer); overload;
var
  X, Y, D : Integer;
  Wth,Hht : Integer;
begin
  if R<= 0 then Exit;
  with Canv.ClipRect do begin
    Wth := Right  - Left;
    Hht := Bottom - Top ;
  end;
	X   := 0;
	Y   := R;
	D   := R-1;
  while Y >= X do begin
    // Prohibitive processing time with TCanvas.Pixels[] !!!
    {
    Canv.Pixels[Cx+X, Cy+Y] := Col;       // Drawing the circle by symmetry
    Canv.Pixels[Cx+Y, Cy+X] := Col;       // of the 8 octants.
    Canv.Pixels[Cx-X, Cy+Y] := Col;       // "
    Canv.Pixels[Cx-Y, Cy+X] := Col;       // "
    Canv.Pixels[Cx+X, Cy-Y] := Col;       // "
    Canv.Pixels[Cx+Y, Cy-X] := Col;       // "
    Canv.Pixels[Cx-X, Cy-Y] := Col;       // "
    Canv.Pixels[Cx-Y, Cy-X] := Col;       //
    }

    // Verification that the point is located within the Bmp, then drawing
    // the circle by symmetry of the 8 octants. }

    if (Cx+X>=0) and (Cy+Y>=0) and (Cx+X<Wth) and (Cy+Y<Hht) then
      SetPixelV(Canv.Handle,Cx+X,Cy+Y,Col);
    if (Cx+Y>=0) and (Cy+X>=0) and (Cx+Y<Wth) and (Cy+X<Hht) then
      SetPixelV(Canv.Handle,Cx+Y,Cy+X,Col);
    if (Cx-X>=0) and (Cy+Y>=0) and (Cx-X<Wth) and (Cy+Y<Hht) then
      SetPixelV(Canv.Handle,Cx-X,Cy+Y,Col);
    if (Cx-Y>=0) and (Cy+X>=0) and (Cx-Y<Wth) and (Cy+X<Hht) then
      SetPixelV(Canv.Handle,Cx-Y,Cy+X,Col);
    if (Cx+X>=0) and (Cy-Y>=0) and (Cx+X<Wth) and (Cy-Y<Hht) then
      SetPixelV(Canv.Handle,Cx+X,Cy-Y,Col);
    if (Cx+Y>=0) and (Cy-X>=0) and (Cx+Y<Wth) and (Cy-X<Hht) then
      SetPixelV(Canv.Handle,Cx+Y,Cy-X,Col);
    if (Cx-X>=0) and (Cy-Y>=0) and (Cx-X<Wth) and (Cy-Y<Hht) then
      SetPixelV(Canv.Handle,Cx-X,Cy-Y,Col);
    if (Cx-Y>=0) and (Cy-X>=0) and (Cx-Y<Wth) and (Cy-X<Hht) then
      SetPixelV(Canv.Handle,Cx-Y,Cy-X,Col);

    if D >= X+X then begin
       D := D-X-X-1;
       Inc(X);       end
    else  if D <= R+R-Y-Y then begin
             D := D+Y+Y-1;
             Dec(Y);           end
          else begin
             D := D+Y+Y-X-X-2;
             Dec(Y);
             Inc(X);
    end;
  end;
end;

{ Andres circle plotting algorithm in the memory of a Bmp. }
procedure DrawAndresCircle(Bmp: TBMPinfos; Cx,Cy,R: Integer;
         Col: TRGBTriple); overload;
var
  X, Y, D : Integer;
begin
  if R<=0 then Exit;
	X := 0;
	Y := R;
	D := R-1;
  with Bmp do begin
    while Y >= X do begin
     {   Verification that the point is located within the Bmp, then drawing
         the circle by symmetry of the 8 octants.}
      if (Cx+X>=0) and (Cy+Y>=0) and (Cx+X<Wth) and (Cy+Y<Hht) then
        pRGBTriple(Sc0 - (Cy+Y)*BpL + (Cx+X)*BpP)^ := Col;
      if (Cx+Y>=0) and (Cy+X>=0) and (Cx+Y<Wth) and (Cy+X<Hht) then
        pRGBTriple(Sc0 - (Cy+X)*BpL + (Cx+Y)*BpP)^ := Col;
      if (Cx-X>=0) and (Cy+Y>=0) and (Cx-X<Wth) and (Cy+Y<Hht) then
        pRGBTriple(Sc0 - (Cy+Y)*BpL + (Cx-X)*BpP)^ := Col;
      if (Cx-Y>=0) and (Cy+X>=0) and (Cx-Y<Wth) and (Cy+X<Hht) then
        pRGBTriple(Sc0 - (Cy+X)*BpL + (Cx-Y)*BpP)^ := Col;
      if (Cx+X>=0) and (Cy-Y>=0) and (Cx+X<Wth) and (Cy-Y<Hht) then
        pRGBTriple(Sc0 - (Cy-Y)*BpL + (Cx+X)*BpP)^ := Col;
      if (Cx+Y>=0) and (Cy-X>=0) and (Cx+Y<Wth) and (Cy-X<Hht) then
        pRGBTriple(Sc0 - (Cy-X)*BpL + (Cx+Y)*BpP)^ := Col;
      if (Cx-X>=0) and (Cy-Y>=0) and (Cx-X<Wth) and (Cy-Y<Hht) then
        pRGBTriple(Sc0 - (Cy-Y)*BpL + (Cx-X)*BpP)^ := Col;
      if (Cx-Y>=0) and (Cy-X>=0) and (Cx-Y<Wth) and (Cy-X<Hht) then
        pRGBTriple(Sc0 - (Cy-X)*BpL + (Cx-Y)*BpP)^ := Col;

      if D >= X+X then begin
         D := D-X-X-1;
         Inc(X);       end
      else  if D <= R+R-Y-Y then begin
               D := D+Y+Y-1;
               Dec(Y);           end
            else begin
               D := D+Y+Y-X-X-2;
               Dec(Y);
               Inc(X);
      end;
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Btn           : TButton absolute Sender;
  Gris, R       : Integer;
  Col           : TColor;
  Start,Elapsed : Int64;
  Times         : Integer;
  PtO           : TPoint; // Center of the circle
begin
  with image1.Picture.Bitmap.Canvas do FillRect(ClipRect);
  PtO := CenterPoint(Image1.BoundsRect);
  image1.Picture.Bitmap.Canvas.TextOut(1, Image1.Height-40,
    'Blocking treatment that can last several seconds.');
  image1.Picture.Bitmap.Canvas.TextOut(1, Image1.Height-20,
    '                    WAIT !');
  image1.Refresh;
  Start := GetTickCount;

  for Times := 1 to StrToInt(edtTimes.Text) do begin
    Gris := 256;
    for R := 1 to Round(Sqrt(Image1.Width*Image1.Width +
                             Image1.Height*Image1.Height)) do
    begin
      Dec(Gris);
      Col := RGB(Gris,Gris,Gris);
      DrawAndresCircle(Image1.Picture.Bitmap.Canvas, PtO.X, PtO.Y, R, Col);
    end;
  end;
  
  Elapsed := GetTickCount-Start;
  if Btn.Tag>Elapsed then begin
    Btn.Tag     := Elapsed;
    Btn.Caption := 'Gradient on Canvas' + #13#10 +
                   Format('Minimum time :  %.0n ms',[Elapsed/1]);
  end;
  Image1.Refresh;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Btn           : TButton absolute Sender;
  Gris,R        : Integer;
  Col           : TRGBTriple;
  Start,Elapsed : Int64;
  Times         : Integer;
  PtO           : TPoint; // Center of the circle
  Bmp           : TBMPinfos;
begin
  if not GetBMPinfos(Image1.Picture.Bitmap, Bmp) then Exit;

  with image1.Picture.Bitmap.Canvas do FillRect(ClipRect);
  image1.Refresh;
  Start := GetTickCount;

  for Times := 1 to StrToInt(edtTimes.Text) do begin
    PtO := CenterPoint(Image1.BoundsRect);
    Gris := 256;
    for R := 1 to Round(Sqrt(Bmp.Wth*Bmp.Wth + Bmp.Wth*Bmp.Hht)) do
    begin
      Dec(Gris);
      with Col do begin
  	    rgbtRed   := Gris;
        rgbtGreen := Gris;
        rgbtBlue  := Gris;
      end;
      DrawAndresCircle(Bmp, PtO.X, PtO.Y, R, Col);
    end;
  end;

  Elapsed := GetTickCount-Start;
  if Btn.Tag>Elapsed then begin
    Btn.Tag     := Elapsed;
    Btn.Caption := 'Degraded in memory' + #13#10 +
                    Format('Minimum time :  %.0n ms',[Elapsed/1]);
  end;
  Image1.Refresh;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Btn : TButton absolute Sender;
begin
  Reset;
  with Btn do
  begin
    if Tag = 24 then
    begin
      Tag := 32;
      Image1.Picture.Bitmap.PixelFormat := pf32bit;
      Caption := 'PixelFormat: 32 bits';
    end else begin
      Tag := 24;
      Image1.Picture.Bitmap.PixelFormat := pf24bit;
      Caption := 'PixelFormat: 24 bits';
    end;
  end;
end;

procedure TForm1.UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
begin
  Reset;
end;


procedure TForm1.S1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

END.
