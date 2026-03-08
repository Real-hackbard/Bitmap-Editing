unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    ScrollBox1: TScrollBox;
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Button1: TButton;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    Image2: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Button2: TButton;
    ComboBox1: TComboBox;
    Label12: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label13: TLabel;
    Label14: TLabel;
    SaveDialog1: TSaveDialog;
    Button3: TButton;
    Label15: TLabel;
    Button4: TButton;
    Button5: TButton;
    procedure TrackBar1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private-Deklarationen }
    function ScalePercentBmp(bitmp: TBitmap;
    iPercent: Integer): Boolean;
    procedure ResizeBitmap(imgo, imgd: TBitmap; nw, nh: Integer);
    procedure ResizerBitmap(imgo, imgd: TBitmap; nw, nh: Integer);
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure SkaliereBMP(ABitmap: TBitmap; AFaktorX, AFaktorY: Integer);
type
  TBGR = packed record
    B: Byte;
    G: Byte;
    R: Byte;
  end;
  PBGR = ^TBGR;
var
  OldWidth, OldHeight, NewWidth, NewHeight, x1, x2, y1, y2: Integer;
  OldPixel, NewPixel: PBGR;
begin
  ABitmap.Pixelformat := pf24Bit;
  OldWidth  := ABitmap.Width;
  OldHeight := ABitmap.Height;
  NewWidth  := OldWidth  * AFaktorX;
  NewHeight := OldHeight * AFaktorY;
  {horizontal Skalieren}
  if AFaktorX > 1 then
  begin
    ABitmap.SetSize(NewWidth, OldHeight);
    for y1 := 0 to OldHeight - 1 do
    begin
      OldPixel := ABitmap.ScanLine[y1];
      NewPixel := OldPixel;
      Inc(OldPixel, OldWidth);
      Inc(NewPixel, NewWidth);
      for x1 := OldWidth - 1 downto 0 do
      begin
        Dec(OldPixel);
        for x2 := AFaktorX - 1 downto 0 do
        begin
          Dec(NewPixel);
          NewPixel^ := OldPixel^;
        end;
      end;
    end;
  end;
  {vertikal Skalieren}
  if AFaktorY > 1 then
  begin
    ABitmap.SetSize(NewWidth, NewHeight);
    for y1 := OldHeight - 1 downto 0 do
    begin
      OldPixel := ABitmap.ScanLine[y1];
      for y2 := AFaktorY - 1 downto 0 do
      begin
        NewPixel := ABitmap.ScanLine[y1 * AFaktorY + y2];
        Move(OldPixel^, NewPixel^, SizeOf(TBGR) * NewWidth);
      end;
    end;
  end;
end;

procedure TForm1.ResizerBitmap(imgo, imgd: TBitmap; nw, nh: Integer);
var
  xini, xfi, yini, yfi, saltx, salty: single;
  x, y, px, py, tpix: integer; PixelColor: TColor; r, g, b: longint;

  function MyRound(const X: Double): Integer;
  begin
    Result := Trunc(x);
    if Frac(x) >= 0.5 then
      if x >= 0 then Result := Result + 1
      else
        Result := Result - 1;
  end;

begin
  Screen.Cursor := crHourGlass;
  imgd.Width  := nw; imgd.Height := nh;
  saltx := imgo.Width / nw; salty := imgo.Height / nh;
  yfi := 0;  for y := 0 to nh - 1 do
  begin
    yini := yfi;
    yfi  := yini + salty;
    if yfi >= imgo.Height then yfi := imgo.Height - 1;
    xfi := 0;
    for x := 0 to nw - 1 do
    begin
      xini := xfi; xfi  := xini + saltx;
      if xfi >= imgo.Width then xfi := imgo.Width - 1;
      r := 0; g := 0; b := 0; tpix := 0;
      for py := MyRound(yini) to MyRound(yfi) do
      begin  for px := MyRound(xini) to MyRound(xfi) do
        begin
          Inc(tpix);
          PixelColor := ColorToRGB(imgo.Canvas.Pixels[px, py]);
          r := r + GetRValue(PixelColor);
          g := g + GetGValue(PixelColor);
          b := b + GetBValue(PixelColor);
        end;
      end;
      imgd.Canvas.Pixels[x, y] := rgb(MyRound(r / tpix),
                           MyRound(g / tpix), MyRound(b / tpix)
        );
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.ResizeBitmap(imgo, imgd: TBitmap; nw, nh: Integer);
var
  xini, xfi, yini, yfi, saltx, salty: single;
  x, y, px, py, tpix: integer; PixelColor: TColor; r, g, b: longint;

  function MyRound(const X: Double): Integer;
  begin
    Result := Trunc(x);
    if Frac(x) >= 1.0 then
      if x >= 0 then Result := Result + 1
      else
        Result := Result - 1;
  end;

begin
  Screen.Cursor := crHourGlass;
  imgd.Width  := nw; imgd.Height := nh;
  saltx := imgo.Width / nw; salty := imgo.Height / nh;
  yfi := 0;  for y := 0 to nh - 1 do
  begin
  Application.ProcessMessages;
    yini := yfi;
    yfi  := yini + salty;
    if yfi >= imgo.Height then yfi := imgo.Height - 1;
    xfi := 0;
    for x := 0 to nw - 1 do
    begin
      xini := xfi; xfi  := xini + saltx;
      if xfi >= imgo.Width then xfi := imgo.Width - 1;
      r := 0; g := 0; b := 0; tpix := 0;
      for py := MyRound(yini) to MyRound(yfi) do
      begin  for px := MyRound(xini) to MyRound(xfi) do
        begin
          Inc(tpix);
          PixelColor := ColorToRGB(imgo.Canvas.Pixels[px, py]);
          r := r + GetRValue(PixelColor);
          g := g + GetGValue(PixelColor);
          b := b + GetBValue(PixelColor);
        end;
      end;
      imgd.Canvas.Pixels[x, y] := rgb(MyRound(r / tpix),
                           MyRound(g / tpix), MyRound(b / tpix) );
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  try
    bmp := TBitmap.Create;
    bmp.Assign(Image1.Picture.Bitmap);
    bmp.PixelFormat := pf24bit;

    if SaveDialog1.Execute then
      bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
  finally
    bmp.Free;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  case ComboBox1.ItemIndex of

  2 : ResizeBitmap(Image2.Picture.Bitmap, Image1.Picture.Bitmap,
                SpinEdit1.Value, SpinEdit2.Value);

  3 : ResizeBitmap(Image2.Picture.Bitmap, Image1.Picture.Bitmap,
               SpinEdit1.Value, SpinEdit2.Value);

  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  SkaliereBMP(Image1.Picture.Bitmap, 2, 2);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Image1.Picture.Bitmap.Assign(Image2.Picture.Bitmap);
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
  0 : begin
        TrackBar1.Enabled := true;
        TrackBar1.Max := 2000;
        Label3.Caption := '0 px';
        Label5.Caption := '1000 px';
        Label4.Caption := '2000 px';
        Label14.Enabled := false;
        Label13.Enabled := false;
        Button3.Enabled := false;
        SpinEdit1.Enabled := false;
        SpinEdit2.Enabled := false;
        Button4.Enabled := false;
        Button5.Enabled := false;
      end;
  1 : begin
        TrackBar1.Enabled := true;
        TrackBar1.Max := 500;
        TrackBar1.Position := 0;
        Label3.Caption := '0 %';
        Label5.Caption := '250 %';
        Label4.Caption := '500 %';
        Label14.Enabled := false;
        Label13.Enabled := false;
        Button3.Enabled := false;
        SpinEdit1.Enabled := false;
        SpinEdit2.Enabled := false;
        Button4.Enabled := false;
        Button5.Enabled := false;
      end;
  2..3 : begin
        Label14.Enabled := true;
        Label13.Enabled := true;
        Button3.Enabled := true;
        SpinEdit1.Enabled := true;
        SpinEdit2.Enabled := true;
        TrackBar1.Enabled := false;
        Button4.Enabled := false;
        Button5.Enabled := false;
      end;
  4 : begin
        Label14.Enabled := false;
        Label13.Enabled := false;
        Button3.Enabled := false;
        SpinEdit1.Enabled := false;
        SpinEdit2.Enabled := false;
        TrackBar1.Enabled := false;

        Button4.Enabled := true;
        Button5.Enabled := true;
      end;


  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := true;
end;

function TForm1.ScalePercentBmp(bitmp: TBitmap;
  iPercent: Integer): Boolean;
var
  TmpBmp: TBitmap;
  ARect: TRect;
  h, w: Real;
  hi, wi: Integer;
begin
  Screen.Cursor := crHourGlass;
  Result := False;
  try TmpBmp := TBitmap.Create;
    try
      h := bitmp.Height * (iPercent / 100);
      w := bitmp.Width * (iPercent / 100);
      hi := StrToInt(FormatFloat('#', h)) + bitmp.Height;
      wi := StrToInt(FormatFloat('#', w)) + bitmp.Width;
      TmpBmp.Width := wi;
      TmpBmp.Height := hi; ARect := Rect(0, 0, wi, hi);
      TmpBmp.Canvas.StretchDraw(ARect, Bitmp);
      bitmp.Assign(TmpBmp); finally
      TmpBmp.Free; end; Result := True;  except  Result := False;
  end;
  Screen.Cursor := crDefault;
end;


procedure StretchGraphic(const src, dest: TGraphic;
  DestWidth, DestHeight: integer; Smooth: Boolean = true);
var
  temp, aCopy: TBitmap;
  faktor: double;
begin
  Screen.Cursor := crHourGlass;
  Assert(Assigned(src) and Assigned(dest));
  if (src.Width = 0) or (src.Height = 0) then
    raise Exception.CreateFmt('Invalid source dimensions: %d x %d',[src.Width, src.Height]);
  if src.Width > DestWidth then
    begin
      faktor := DestWidth / src.Width;
      if (src.Height * faktor) > DestHeight then
        faktor := DestHeight / src.Height;
    end
  else
    begin
      faktor := DestHeight / src.Height;
      if (src.Width * faktor) > DestWidth then
        faktor := DestWidth / src.Width;
    end;
  try
    aCopy := TBitmap.Create;
    try
      aCopy.PixelFormat := pf24Bit;
      aCopy.Assign(src);
      temp := TBitmap.Create;
      try
        temp.Width := round(src.Width * faktor);
        temp.Height := round(src.Height * faktor);
        if Smooth then
          SetStretchBltMode(temp.Canvas.Handle, HALFTONE);
        StretchBlt(temp.Canvas.Handle, 0, 0, temp.Width, temp.Height,
          aCopy.Canvas.Handle, 0, 0, aCopy.Width, aCopy.Height, SRCCOPY);
        dest.Assign(temp);
      finally
        temp.Free;
      end;
    finally
      aCopy.Free;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar(E.Message), nil, MB_OK or MB_ICONERROR);
  end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  FileHeader: TBitmapFileHeader;
  InfoHeader: TBitmapInfoHeader;
  Stream    : TFileStream;
begin
  if OpenDialog1.Execute then
  begin
    Image2.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    Image1.Picture.Bitmap.Assign(Image2.Picture.Bitmap);

    Stream := TFileStream.Create(OpenDialog1.FileName, fmOpenRead or fmShareDenyNone);
    try
      Stream.Read(FileHeader, SizeOf(FileHeader));
      Stream.Read(InfoHeader, SizeOf(InfoHeader));
      Label9.Caption := Format('%d bytes', [FileHeader.bfSize]);
      Label10.Caption := Format('%d x ', [InfoHeader.biWidth]) +
                         Format('%d', [InfoHeader.biHeight]);
      Label11.Caption := Format('%d', [InfoHeader.biBitCount]);

    finally
      Stream.Free;
    end;
    TrackBar1.Position := StrToInt(Format('%d', [InfoHeader.biWidth]));
  end;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
  0 : begin
        StretchGraphic(Image2.Picture.Bitmap, Image1.Picture.Bitmap,
        TrackBar1.Position, TrackBar1.Position,  true);
        Label2.Caption := IntToStr(TrackBar1.Position) + ' px';
      end;
  1 : begin
        Image1.Picture.Bitmap.Assign(Image2.Picture.Bitmap);
        ScalePercentBmp(Image1.Picture.Bitmap, TrackBar1.Position);
        Label2.Caption := IntToStr(TrackBar1.Position) + ' %';
      end;
  2 : begin
        //Image1.Picture.Bitmap.Assign(Image2.Picture.Bitmap);
        //ResizeBitmap(Image1.Picture.Bitmap, SpinEdit1.Value, SpinEdit2.Value);
        Label2.Caption := IntToStr(TrackBar1.Position) + ' %';
      end;

  end;
end;

end.
