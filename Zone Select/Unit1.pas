UNIT Unit1;

INTERFACE

USES
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

TYPE
  TForm1 = class(TForm)
    ScrollBox1: TScrollBox;
    Image1: TImage;
    StatusBar1: TStatusBar;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    GrayButton: TButton;
    NegativeButton: TButton;
    Button1: TButton;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GrayButtonClick(Sender: TObject);
    procedure NegativeButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Declarations privates}
  public
    { Declarations publiqs}
  end;

const crMove = 5;

var
  Form1: TForm1;
  MYBMP : TBitmap;
  Xi, Yi : integer;
  XPred, YPred : integer;
  MyRect : TRect;
  ZoneSelected : boolean = false;
  MoveZoneSelected : boolean = false;

implementation

{$R *.DFM}
{$R-}

procedure TForm1.Button2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  MYBMP := TBitmap.Create;
  MYBMP.Assign(image1.picture.bitmap);
  Screen.Cursors[crMove] := LoadCursorFromFile('move.cur');
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Xi := X;
  Yi := Y;
  IF (ZoneSelected) AND (X > MyRect.Left) AND (X < MyRect.Right) AND
                        (Y > MyRect.Top) AND (Y < MyRect.Bottom) THEN
   MoveZoneSelected := true
  ELSE
   BEGIN
   Image1.Canvas.CopyRect(MyRect, MYBMP.Canvas, MyRect);
   MoveZoneSelected := false;
   END;
END;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
BEGIN

  IF (ZoneSelected) AND (X > MyRect.Left) AND (X < MyRect.Right) AND
                        (Y > MyRect.Top) AND (Y < MyRect.Bottom) THEN
   Image1.Cursor := crMove
  ELSE
   Image1.Cursor := crCross;

IF (ssLeft IN Shift) THEN
   IF (MoveZoneSelected) THEN
      BEGIN
      Image1.Canvas.CopyRect(MyRect, MYBMP.Canvas, MyRect);
      IF (MyRect.Left + (X - XPred) >= 0) AND (MyRect.Right +
                        (X - XPred) <= Image1.Width) THEN
         BEGIN
         MyRect.Left := MyRect.Left + (X - XPred);
         MyRect.Right := MYRect.Right + (X - XPred);
         END;

      IF (MyRect.Top + (Y - YPred) >= 0) AND (MyRect.Bottom +
                        (Y - YPred) <= Image1.Height) THEN
         BEGIN
         MyRect.Top := MyRect.Top + (Y - YPred);
         MyRect.Bottom := MyRect.Bottom + (Y - YPred);
         END;

      Image1.Canvas.FrameRect(MyRect);
      END

   ELSE
      BEGIN
      Image1.Canvas.CopyRect(MyRect, MYBMP.Canvas, MyRect);

      IF NOT ((Xi = X) OR (Yi = Y)) THEN
         BEGIN
           IF (Xi < X) AND (Yi < Y) THEN
              MyRect := Rect(Xi,Yi,X,Y)
           ELSE
           IF (Xi < X) AND (Yi > Y) THEN
              MyRect := Rect(Xi,Y,X,Yi)
           ELSE
           IF (Xi > X) AND (Yi < Y) THEN
              MyRect := Rect(X,Yi,Xi,Y)
           ELSE
           IF (Xi > X) AND (Yi > Y) THEN
              MyRect := Rect(X,Y,Xi,Yi);

           IF MyRect.Left < 0 THEN MyRect.Left := 0 ELSE
           IF MyRect.Right > Image1.Width THEN MyRect.Right := Image1.Width;

           IF MyRect.Top < 0 THEN MyRect.Top := 0 ELSE
           IF MyRect.Bottom > Image1.Height THEN MyRect.Bottom := Image1.Height;

           ZoneSelected := true;
           Image1.canvas.Pen.Width := 1;
           Image1.canvas.Pen.Style :=psSolid;
           Image1.canvas.Pen.Color:=clBlue;
           Image1.canvas.Pen.Mode := pmNotXor;
           Image1.canvas.Pen.Style:=psDot;
           Image1.canvas.Brush.Style:=bsClear;
            // we erase the old one
           Image1.canvas.Rectangle(MyRect.Left,MyRect.Top,
                                   MyRect.Right,MyRect.Bottom);
           //Image1.Canvas.FrameRect(MyRect);
         END;
      END;

  XPred := X;
  YPred := Y;
END;

PROCEDURE TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
BEGIN
  IF (X = Xi) AND (Y = Yi) THEN
   BEGIN
   Image1.Canvas.CopyRect(MyRect, MYBMP.Canvas, MyRect);
   Image1.Cursor := crCross;
   ZoneSelected := false;
   MoveZoneSelected := false;
   END;
  END;

PROCEDURE ToGrayScale (VAR BMP : TBitmap; CONST Rect : TRect);
TYPE
  TRGBArray = ARRAY[0..0] OF TRGBTriple;
  PRGBArray = ^TRGBArray;
VAR
  TabScanline : ARRAY OF PRGBArray;
  I, J : integer;
  N : integer;
BEGIN
  BMP.pixelFormat := pf24bit;
  setLength(TabScanline, BMP.Height);

  FOR N := 0 TO BMP.Height - 1 DO
    TabScanline[N] := BMP.Scanline[N];

  FOR I := Rect.Left TO Rect.Right - 1 DO
    FOR J := Rect.Top TO Rect.Bottom - 1 DO
        BEGIN
        WITH TabScanline[J,I] DO
             BEGIN
             N := (RGBTRed + RGBTGreen + RGBTBlue) DIV 3;
             RGBTRed := N;
             RGBTGreen := N;
             RGBTBlue := N;
             END;
        END;

  TabScanline := NIL;
END;

PROCEDURE Negative (VAR BMP : TBitmap; CONST Rect : TRect);
TYPE
  TRGBArray = ARRAY[0..0] OF TRGBTriple;
  PRGBArray = ^TRGBArray;
VAR
  TabScanline : ARRAY OF PRGBArray;
  I, J : integer;
  N : integer;
BEGIN
  BMP.pixelFormat := pf24bit;
  setLength(TabScanline, BMP.Height);

  FOR N := 0 TO BMP.Height - 1 DO
    TabScanline[N] := BMP.Scanline[N];

  FOR I := Rect.Left TO Rect.Right - 1 DO
    FOR J := Rect.Top TO Rect.Bottom - 1 DO
        BEGIN
        WITH TabScanline[J,I] DO
             BEGIN
             RGBTRed := ABS(255 - RGBTRed);
             RGBTGreen := ABS(255 - RGBTGreen);
             RGBTBlue := ABS(255 - RGBTBlue);
             END;
        END;
  TabScanline := NIL;
END;

PROCEDURE TForm1.GrayButtonClick(Sender: TObject);
BEGIN
  IF ZoneSelected THEN
   ToGrayScale(MYBMP, MyRect)
  ELSE
   ToGrayScale(MYBMP, Rect(0,0,MYBMP.Width, MYBMP.Height));

  Image1.Picture.Bitmap := MYBMP;
  IF ZoneSelected THEN Image1.Canvas.FrameRect(MyRect);
END;

PROCEDURE TForm1.NegativeButtonClick(Sender: TObject);
BEGIN
IF ZoneSelected THEN
   Negative(MYBMP, MyRect)
ELSE
   Negative(MYBMP, Rect(0,0,MYBMP.Width,MYBMP.Height ));
Image1.Picture.Bitmap := MYBMP;
IF ZoneSelected THEN Image1.Canvas.FrameRect(MyRect);
END;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 MYBMP.free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    StatusBar1.Panels[0].Text := OpenDialog1.FileName;
    MYBMP := TBitmap.Create;
    MYBMP.Assign(image1.picture.bitmap);
    Screen.Cursors[crMove] := LoadCursorFromFile('move.cur');
  end;
end;

end.
