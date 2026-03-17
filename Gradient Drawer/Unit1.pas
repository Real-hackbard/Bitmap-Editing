unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    Button2: TButton;
    GroupBox1: TGroupBox;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    GroupBox2: TGroupBox;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox3: TComboBox;
    Label3: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    ColorDialog1: TColorDialog;
    SaveDialog1: TSaveDialog;
    Label4: TLabel;
    Label5: TLabel;
    RadioGroup1: TRadioGroup;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox3Change(Sender: TObject);
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
procedure DrawGradient(ACanvas: TCanvas; Rect: TRect;
  Horicontal: Boolean; Colors: array of TColor);
type
  RGBArray = array[0..2] of Byte;
var
  x, y, z, stelle, mx, bis, faColorsh, mass: Integer;
  Faktor: double;
  A: RGBArray;
  B: array of RGBArray;
  merkw: integer;
  merks: TPenStyle;
  merkp: TColor;
begin
  mx := High(Colors);
  if mx > 0 then
  begin
    if Horicontal then
      mass := Rect.Right - Rect.Left
    else
      mass := Rect.Bottom - Rect.Top;
    SetLength(b, mx + 1);
    for x := 0 to mx do
    begin
      Colors[x] := ColorToRGB(Colors[x]);
      b[x][0] := GetRValue(Colors[x]);
      b[x][1] := GetGValue(Colors[x]);
      b[x][2] := GetBValue(Colors[x]);
    end;
    merkw := ACanvas.Pen.Width;
    merks := ACanvas.Pen.Style;
    merkp := ACanvas.Pen.Color;
    ACanvas.Pen.Width := 1;
    ACanvas.Pen.Style := psSolid;
    faColorsh := Round(mass / mx);
    for y := 0 to mx - 1 do
    begin
      if y = mx - 1 then
        bis := mass - y * faColorsh - 1
      else
        bis := faColorsh;
      for x := 0 to bis do
      begin
        Stelle := x + y * faColorsh;
        faktor := x / bis;
        for z := 0 to 3 do
          a[z] := Trunc(b[y][z] + ((b[y + 1][z] - b[y][z]) * Faktor));
        ACanvas.Pen.Color := RGB(a[0], a[1], a[2]);
        if Horicontal then
        begin
          ACanvas.MoveTo(Rect.Left + Stelle, Rect.Top);
          ACanvas.LineTo(Rect.Left + Stelle, Rect.Bottom);
        end
        else
        begin
          ACanvas.MoveTo(Rect.Left, Rect.Top + Stelle);
          ACanvas.LineTo(Rect.Right, Rect.Top + Stelle);
        end;
      end;
    end;
    b := nil;
    ACanvas.Pen.Width := merkw;
    ACanvas.Pen.Style := merks;
    ACanvas.Pen.Color := merkp;
  end
  else
    // Please specify at least two colors
    raise EMathError.Create('At least two colors must be specified.');
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  Image1.Picture.Graphic := nil;

  case ComboBox1.ItemIndex of
  0 : begin
        Image1.ClientHeight := SpinEdit2.Value;
        Image1.ClientWidth := SpinEdit1.Value;
        case ComboBox2.ItemIndex of           // custom image size
          0 : begin                           // Vertical
                if ComboBox3.ItemIndex = 0 then
                begin
                  DrawGradient(Image1.Canvas, Rect(0, 0, SpinEdit1.Value, SpinEdit2.Value),
                           false, [Shape1.Brush.Color, Shape2.Brush.Color]);
                end;

                if ComboBox3.ItemIndex = 1 then
                begin
                  DrawGradient(Image1.Canvas, Rect(0, 0, SpinEdit1.Value, SpinEdit2.Value),
                           false, [Shape1.Brush.Color, Shape2.Brush.Color,
                                   Shape3.Brush.Color]);
                end;

                if ComboBox3.ItemIndex = 2 then
                begin
                  DrawGradient(Image1.Canvas, Rect(0, 0, SpinEdit1.Value, SpinEdit2.Value),
                           false, [Shape1.Brush.Color, Shape2.Brush.Color,
                                   Shape3.Brush.Color, Shape4.Brush.Color]);
                end;
              end;

          1 : begin                          // horizontal
                if ComboBox3.ItemIndex = 0 then
                begin
                  DrawGradient(Image1.Canvas, Rect(0, 0, SpinEdit1.Value, SpinEdit2.Value),
                           true, [Shape1.Brush.Color, Shape2.Brush.Color]);
                end;

                if ComboBox3.ItemIndex = 1 then
                begin
                  DrawGradient(Image1.Canvas, Rect(0, 0, SpinEdit1.Value, SpinEdit2.Value),
                           true, [Shape1.Brush.Color, Shape2.Brush.Color,
                                   Shape3.Brush.Color]);
                end;

                if ComboBox3.ItemIndex = 2 then
                begin
                  DrawGradient(Image1.Canvas, Rect(0, 0, SpinEdit1.Value, SpinEdit2.Value),
                           true, [Shape1.Brush.Color, Shape2.Brush.Color,
                                   Shape3.Brush.Color, Shape4.Brush.Color]);
                end;
              end;
        end;
      end;

  1 : begin                        // Image dimension size
        DrawGradient(Image1.Canvas, GetClientRect,
                     True, [clLime, clred, clblue, clWhite]);

      end;
  end;

  try
    bmp := TBitmap.Create;
    bmp.Assign(Image1.Picture.Bitmap);

    case RadioGroup1.ItemIndex of
    0 : bmp.PixelFormat := pf8bit;
    1 : bmp.PixelFormat := pf16bit;
    2 : bmp.PixelFormat := pf24bit;
    3 : bmp.PixelFormat := pf32bit;
    end;

    Image1.Picture.Bitmap.Assign(bmp);
  finally
    bmp.Free;
  end;

  ScrollBox1.Update;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
begin
  case ComboBox3.ItemIndex of
  0 : begin
        Shape2.Visible := true;
        Shape3.Visible := false;
        Shape4.Visible := false;
      end;

  1 : begin
        Shape2.Visible := true;
        Shape3.Visible := true;
        Shape4.Visible := false;
      end;

  2 : begin
        Shape2.Visible := true;
        Shape3.Visible := true;
        Shape4.Visible := true;
      end
  end;
end;

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
    Shape1.Brush.Color := ColorDialog1.Color;
end;

procedure TForm1.Shape2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
    Shape2.Brush.Color := ColorDialog1.Color;
end;

procedure TForm1.Shape3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
    Shape3.Brush.Color := ColorDialog1.Color;
end;

procedure TForm1.Shape4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
    Shape4.Brush.Color := ColorDialog1.Color;
end;

end.
