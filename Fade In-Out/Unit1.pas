unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button2: TButton;
    Button3: TButton;
    Image2: TImage;
    ComboBox1: TComboBox;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    SpinEdit2: TSpinEdit;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
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
  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array[0..32767] of TRGBTriple;

implementation

{$R *.dfm}
{$R-}
// Fade In Bitmap
procedure FadeIn(const Bmp: TBitmap);
var
  Bitmap, BaseBitmap: TBitmap;
  Row, BaseRow: PRGBTripleArray;
  x, y, step: integer;
begin
  // Preparing the Bitmap
  Bitmap := TBitmap.Create;
  try
    case Form1.ComboBox1.ItemIndex of
    0 : Bitmap.PixelFormat := pf24bit;  // or pf24bit //
    1 : Bitmap.PixelFormat := pf32bit;  // or pf24bit //
    end;

    Bitmap.Assign(Bmp);
    BaseBitmap := TBitmap.Create;
    try
      BaseBitmap.PixelFormat := pf24bit;

      case Form1.ComboBox1.ItemIndex of
      0 : BaseBitmap.PixelFormat := pf24bit;  // or pf24bit //
      1 : BaseBitmap.PixelFormat := pf32bit;  // or pf32bit //
      end;

      BaseBitmap.Assign(Bitmap);
      // Fading //
      for step := 0 to 32 do
      begin
        for y := 0 to (Bitmap.Height - 1) do
        begin
          BaseRow := BaseBitmap.Scanline[y];
          // Getting colors from final image //
          Row := Bitmap.Scanline[y];
          // Colors from the image as it is now //
          for x := 0 to (Bitmap.Width - 1) do
          begin
            Row[x].rgbtRed := (step * BaseRow[x].rgbtRed) shr 5;
            Row[x].rgbtGreen := (step * BaseRow[x].rgbtGreen) shr 5; // Fading //
            Row[x].rgbtBlue := (step * BaseRow[x].rgbtBlue) shr 5;
          end;
        end;
        Form1.Image2.Canvas.Draw(0, 0, Bitmap); //  Output new image
        Sleep(Form1.SpinEdit2.Value);
        InvalidateRect(Form1.Handle, nil, False);
        // Redraw window //
        RedrawWindow(Form1.Handle, nil, 0, RDW_UPDATENOW);
      end;
    finally
      BaseBitmap.Free;
    end;
  finally
    Bitmap.Free;
  end;
end;

// Fade Out Bitmap File
procedure FadeOut(const Bmp: TBitmap);
var
  Bitmap, BaseBitmap: TBitmap;
  Row, BaseRow: PRGBTripleArray;
  x, y, step: integer;
begin
  // Preparing the Bitmap //
  Bitmap := TBitmap.Create;
  try
    case Form1.ComboBox1.ItemIndex of
    0 : Bitmap.PixelFormat := pf24bit;  // or pf24bit //
    1 : Bitmap.PixelFormat := pf32bit;  // or pf32bit //
    end;
    Bitmap.Assign(Bmp);
    BaseBitmap := TBitmap.Create;
    try
      case Form1.ComboBox1.ItemIndex of
      0 : BaseBitmap.PixelFormat := pf24bit;  // or pf24bit //
      1 : BaseBitmap.PixelFormat := pf32bit;  // or pf32bit //
      end;
      BaseBitmap.Assign(Bitmap);
      // Fading //
     for step := 32 downto 0 do
      begin
        for y := 0 to (Bitmap.Height - 1) do
        begin
          BaseRow := BaseBitmap.Scanline[y];
          // Getting colors from final image
          Row := Bitmap.Scanline[y];
          // Colors from the image as it is now
          for x := 0 to (Bitmap.Width - 1) do
          begin
            Row[x].rgbtRed := (step * BaseRow[x].rgbtRed) shr 5;
            Row[x].rgbtGreen := (step * BaseRow[x].rgbtGreen) shr 5; // Fading //
            Row[x].rgbtBlue := (step * BaseRow[x].rgbtBlue) shr 5;
          end;
        end;
        Form1.Image2.Canvas.Draw(0, 0, Bitmap);   // Output new image //
        Sleep(Form1.SpinEdit1.Value);
        InvalidateRect(Form1.Handle, nil, False);
        // Redraw window //
        RedrawWindow(Form1.Handle, nil, 0, RDW_UPDATENOW);
      end;
    finally
      BaseBitmap.Free;
    end;
  finally
    Bitmap.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FadeOut(Image1.Picture.Bitmap);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  FadeIn(Image1.Picture.Bitmap);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := true;
  Image2.Canvas.Brush.Color := clBlack;
  Image2.Canvas.Rectangle(0,0,Image2.Width,Image2.Height);
end;

end.
