unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, U_Quadrangle, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Button2: TButton;
    Button1: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    Panel2: TPanel;
    PaintBox1: TPaintBox;
    Panel3: TPanel;
    Image1: TImage;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    renderbuffer:tbitmap;
    image:tbitmap;
    procedure Render;

  end;

var
  Form1: TForm1;
  A, B, C, D : TPoint;
  Coin:integer;
  Quadrangle: tquadrangle;

implementation

{$R *.dfm}
{$R-}

procedure TForm1.FormCreate(Sender: TObject);
begin
 DoubleBuffered := true;
 PaintBox1.ControlStyle:=PaintBox1.ControlStyle+[csOpaque];
 RenderBuffer:=TBitmap.Create;
 RenderBuffer.Width:=PaintBox1.Width;
 RenderBuffer.Height:=PaintBox1.Height;
 A:=Point(50,30);    // corner left/top
 B:=Point(190,30);   // corner left/right
 D:=Point(50,170);   // corner right/bottom
 C:=Point(190,170);  // corner left/bottom
 Coin:=0;
 Image:=TBitmap.Create;
 Image.LoadFromFile(ExtractFilePath(Application.ExeName) + '\Bitmap\spaceship1.bmp');
 render;

 Application.ProcessMessages;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Image.Free;
 RenderBuffer.Free;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
 PaintBox1.Canvas.Draw(0,0,RenderBuffer);
end;

procedure TForm1.Render;
begin

 RenderBuffer.Canvas.Brush.Color:=ClBlack;
 RenderBuffer.Canvas.FillRect(RenderBuffer.Canvas.ClipRect);

 Quadrangle.A:=A;
 Quadrangle.B:=B;
 Quadrangle.C:=C;
 Quadrangle.D:=D;
 RenderBuffer.Canvas.Draw(OX,OY,Distorsion(Quadrangle,Image,clBlack));


 if CheckBox1.Checked = true then
 begin                             // Quadrangles in Corner
   with RenderBuffer.Canvas do begin
    Brush.Color:=clred;
    Pen.Style :=psSolid;
    Rectangle(A.X-5,A.Y-5,A.X+5,A.Y+5);
    Brush.Color:=clBlue;
    Rectangle(B.X-5,B.Y-5,B.X+5,B.Y+5);
    Rectangle(C.X-5,C.Y-5,C.X+5,C.Y+5);
    Rectangle(D.X-5,D.Y-5,D.X+5,D.Y+5);
   end;
 end;

 with RenderBuffer.Canvas do begin
  MoveTo(A.X,A.Y);
  LineTo(B.X,B.Y);
  LineTo(C.X,C.Y);
  LineTo(D.X,D.Y);
  LineTo(A.X,A.Y);
 end;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Coin:=0;
 if (x in [A.X-5..A.X+5]) and (y in [A.Y-5..A.Y+5]) then Coin:=1;
 if (x in [B.X-5..B.X+5]) and (y in [B.Y-5..B.Y+5]) then Coin:=2;
 if (x in [C.X-5..C.X+5]) and (y in [C.Y-5..C.Y+5]) then Coin:=3;
 if (x in [D.X-5..D.X+5]) and (y in [D.Y-5..D.Y+5]) then Coin:=4;
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if Coin=1 then begin A.X:=X; A.Y:=Y; end;
 if Coin=2 then begin B.X:=X; B.Y:=Y; end;
 if Coin=3 then begin C.X:=X; C.Y:=Y; end;
 if Coin=4 then begin D.X:=X; D.Y:=Y; end;

 if A.X<5 then A.X:=8;
 If A.X>PaintBox1.Width-5 then A.X:=PaintBox1.Width-8;
 if A.Y<5 then A.Y:=8;
 If A.Y>PaintBox1.Height-5 then A.Y:=PaintBox1.Height-8;
 if B.X<5 then B.X:=8;
 If B.X>PaintBox1.Width-5 then B.X:=PaintBox1.Width-8;
 if B.Y<5 then B.Y:=8;
 If B.Y>PaintBox1.Height-5 then B.Y:=PaintBox1.Height-8;
 if C.X<5 then C.X:=8;
 If C.X>PaintBox1.Width-5 then C.X:=PaintBox1.Width-8;
 if C.Y<5 then C.Y:=8;
 If C.Y>PaintBox1.Height-5 then C.Y:=PaintBox1.Height-8;
 if D.X<5 then D.X:=8;
 If D.X>PaintBox1.Width-5 then D.X:=PaintBox1.Width-8;
 if D.Y<5 then D.Y:=8;
 If D.Y>PaintBox1.Height-5 then D.Y:=PaintBox1.Height-8;

 Render;
 PaintBox1.Invalidate;
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Coin:=0;
 Button2.Click;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
r: TRect;
begin
  image1.Picture.Bitmap.Width:= Image1.Width;
  image1.Picture.Bitmap.Height:= Image1.Height;

  Image1.Width:=PaintBox1.Width;
  Image1.Height:=PaintBox1.Height;
  r:=rect(0,0,Image1.Width,Image1.Height);
  Image1.Picture.Bitmap.Canvas.CopyRect(r,PaintBox1.Canvas,r);
  StatusBar1.SetFocus;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 if OpenDialog1.Execute then
 begin
   PaintBox1.ControlStyle:=PaintBox1.ControlStyle+[csOpaque];
   RenderBuffer:=TBitmap.Create;
   RenderBuffer.Width:=PaintBox1.Width;
   RenderBuffer.Height:=PaintBox1.Height;
   A:=Point(50,30);   B:=Point(190,30);
   D:=Point(50,170);   C:=Point(190,170);
   Coin:=0;
   Image:=TBitmap.Create;
   Image.LoadFromFile(OpenDialog1.FileName);
   StatusBar1.Panels[0].Text := OpenDialog1.FileName;
   render;
 end;
 StatusBar1.SetFocus;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
  StatusBar1.SetFocus;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  Render;
  PaintBox1.Invalidate;
  Button2.Click;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  PaintBox1.ControlStyle:=PaintBox1.ControlStyle+[csOpaque];
  RenderBuffer:=TBitmap.Create;
  RenderBuffer.Width:=PaintBox1.Width;
  RenderBuffer.Height:=PaintBox1.Height;
  A:=Point(50,30);    // corner left/top
  B:=Point(190,30);   // corner left/right
  D:=Point(50,170);   // corner right/bottom
  C:=Point(190,170);  // corner left/bottom
  Coin:=0;
  Image:=TBitmap.Create;

  case ComboBox1.ItemIndex of
  0 : Image.LoadFromFile(ExtractFilePath(Application.ExeName) + '\Bitmap\muster2.bmp');
  1 : Image.LoadFromFile(ExtractFilePath(Application.ExeName) + '\Bitmap\spaceship1.bmp');
  end;

  Render;
  PaintBox1.Invalidate;
  Application.ProcessMessages;
end;

end.
