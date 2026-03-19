unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, jpeg, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    Button1: TButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label1: TLabel;
    Image1: TImage;
    ComboBox1: TComboBox;
    Button2: TButton;
    Label2: TLabel;
    Label3: TLabel;
    SaveDialog1: TSaveDialog;
    Shape1: TShape;
    Label4: TLabel;
    ColorDialog1: TColorDialog;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure TForm1.Button1Click(Sender: TObject);
const
  bb=960;
var
  i,j,waagerecht,senkrecht:integer;
  xk,yk,q,xi,yi,sq:double;
  xm,ym:integer;
  bitmap,bitmap2,bitmapz:tbitmap;
  rect:trect;
  P : PByteArray;

procedure ladejpg(const FileName: String; Bild: TBitMap);
var
  Jpeg: TJpegImage;
begin
  Jpeg:=TJpegImage.Create;
  jpeg.LoadFromFile(filename);
  Bild.Assign(Jpeg);
  jpeg.free;
end;
begin
   // Shifting the center of the mirror
   ladejpg(ExtractFilePath(Application.ExeName) + 'gfx\' +
          ComboBox1.text + '.jpg', image1.Picture.Bitmap);
   application.ProcessMessages;
   waagerecht:=spinedit1.value;
   senkrecht:=spinedit2.value;
   bitmap2:=tbitmap.create;
   bitmap2.assign(image1.Picture.Bitmap);
   bitmap2.PixelFormat := pf32bit;

   bitmap:=tbitmap.Create;
   bitmap.width:=bb;
   bitmap.height:=bb;
   // Stretch the image to double size
   rect.left:=0;
   rect.Top:=0;
   rect.right:=bb;
   rect.Bottom:=bb;
   bitmap.canvas.copyrect(rect,bitmap2.Canvas,image1.clientrect);
   // Center point
   xm:=paintbox1.Width div 2;
   ym:=paintbox1.height div 2;

   bitmapz:=tbitmap.Create;
   bitmapz.Width:=paintbox1.Width;
   bitmapz.height:=paintbox1.height;
   bitmapz.PixelFormat:=pf32bit;
   // background color
   bitmapz.Canvas.Brush.Color:= Shape1.Brush.Color;
   bitmapz.Canvas.Rectangle(-1,-1,961,961);
   // Determine pixels line by line
   for i:=0 to bb-1 do begin
     P := BitMap.ScanLine[i];
     yi:=(2*i-senkrecht)/bb;
     for j:=0 to bb-1 do begin
       // Convert to complex coordinates
       xi:=(2*j-waagerecht)/bb;
       // Transformation to the Riemann sphere
       sq := sqr(xi)+sqr(yi);
       // only draw if in the lower half of the Riemann sphere
       if sq<1.0 then begin
         q:=1+xi*xi+yi*yi;
          // xk:=xi/q;
          // yk:=yi/q;
         bitmapz.Canvas.pixels[trunc(xm+480*xi/q),
                            trunc(ym+480*yi/q)]:=rgb(p[4*j+2],p[4*j+1],p[4*j]);
        // bitmapz.Canvas.pixels[trunc(xm+480*xk),trunc(ym+480*yk)]:=p[j];
       end;
     end;
     paintbox1.Canvas.Draw(0,0,bitmapz);
   end;
   bitmap.free;
   bitmap2.free;
   bitmapz.free;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Bitmap: TBitmap;
begin
  if SaveDialog1.Execute then
  begin
    try
      Bitmap:=TBitmap.Create;
      Bitmap.PixelFormat := pf24bit;
      Bitmap.Width:=PaintBox1.Width;
      Bitmap.Height:=PaintBox1.Height;
      Bitmap.Canvas.CopyRect(Bounds(0,0,bitmap.Width, Bitmap.Height),
        PaintBox1.Canvas, PaintBox1.ClientRect);

      Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
    finally
      Bitmap.Free;
    end;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
  procedure ladejpg(const FileName: String; Bild: TBitMap);
  var
    Jpeg: TJpegImage;
  begin
    Jpeg:=TJpegImage.Create;
    jpeg.LoadFromFile(filename);
    Bild.Assign(Jpeg);
    jpeg.free;
  end;
begin
  ladejpg(ExtractFilePath(Application.ExeName) + 'gfx\' +
          ComboBox1.text + '.jpg', image1.Picture.Bitmap);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Jpeg: TJpegImage;

  procedure ladejpg(const FileName: String; Bild: TBitMap);
  var
  Jpeg: TJpegImage;
  begin
    Jpeg:=TJpegImage.Create;
    jpeg.LoadFromFile(filename);
    Bild.Assign(Jpeg);
    jpeg.free;
  end;

  begin
   // Shifting the center of the mirror
   ladejpg(ExtractFilePath(Application.ExeName) + 'gfx\' +
          ComboBox1.text + '.jpg', image1.Picture.Bitmap);

end;

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
    Shape1.Brush.Color := COlorDialog1.Color;
end;

end.
