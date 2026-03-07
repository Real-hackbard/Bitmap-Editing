unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Vcl.Menus, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    PopupMenu1: TPopupMenu;
    SaveDialog1: TSaveDialog;
    Save1: TMenuItem;
    Reset1: TMenuItem;
    Corners1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Color1: TMenuItem;
    Background1: TMenuItem;
    ColorDialog1: TColorDialog;
    Frame1: TMenuItem;
    ColorDialog2: TColorDialog;
    Frame2: TMenuItem;
    ColorDialog3: TColorDialog;
    riangle1: TMenuItem;
    CrossSections1: TMenuItem;
    CrossSections2: TMenuItem;
    ColorDialog4: TColorDialog;
    CornerSize1: TMenuItem;
    x11: TMenuItem;
    x21: TMenuItem;
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Save1Click(Sender: TObject);
    procedure Reset1Click(Sender: TObject);
    procedure Corners1Click(Sender: TObject);
    procedure Background1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Frame1Click(Sender: TObject);
    procedure Frame2Click(Sender: TObject);
    procedure riangle1Click(Sender: TObject);
    procedure CrossSections1Click(Sender: TObject);
    procedure CrossSections2Click(Sender: TObject);
    procedure x11Click(Sender: TObject);
    procedure x21Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  bm:tbitmap;
  mat:array[0..2] of tpoint;
  p:integer;
  r : integer;

implementation

{$R *.dfm}

procedure TForm1.PaintBox1Paint(Sender: TObject);
var
  n,m:integer;
begin
  bm.width:= paintbox1.width;
  bm.Height:= paintbox1.Height;

  if Frame1.Checked = true then
  begin
    bm.Canvas.pen.color:= ColorDialog2.Color;
  end else begin
    bm.Canvas.pen.color:= ColorDialog1.Color;
  end;

  bm.Canvas.brush.color:= ColorDialog1.Color;
  bm.Canvas.rectangle(0,0,bm.Width,bm.height);
  bm.Canvas.pen.color:= ColorDialog3.Color;

  for n:=0 to 2 do begin
    case n of
      0:m:=1;
      1:m:=2;
      else m:=0;
    end;

    bm.Canvas.Pen.Color:= ColorDialog3.Color;
    bm.canvas.MoveTo(mat[n].x,mat[n].y);
    bm.canvas.lineTo(mat[m].x,mat[m].y);
    bm.Canvas.Pen.Color:= ColorDialog4.Color;

    if CrossSections1.Checked = true then
    begin
      bm.canvas.lineTo((mat[n].x+mat[3-m-n].x) div 2,
                      (mat[n].y+mat[3-n-m].y) div 2);
    end;
  end;

    bm.canvas.pen.color:= clTeal;

  if Corners1.Checked = true then
  begin
    for n :=0 to 2 do
    bm.canvas.Ellipse(mat[n].x-r,
                      mat[n].y-r,
                      mat[n].x+r,
                      mat[n].y+r);
  end;

  paintbox1.canvas.draw(0,0,bm);
end;

procedure TForm1.Reset1Click(Sender: TObject);
begin
  bm:= tbitmap.create;
  bm.width:=paintbox1.width;
  bm.Height:=paintbox1.Height;
  mat[0].x:=150;
  mat[0].y:=100;
  mat[1].x:=750;
  mat[1].y:=200;
  mat[2].x:=350;
  mat[2].y:=450;
  p:=3;
  PaintBox1Paint(Sender);
end;

procedure TForm1.riangle1Click(Sender: TObject);
begin
  if ColorDialog3.Execute then
  PaintBox1.OnPaint(sender);
end;

procedure TForm1.Save1Click(Sender: TObject);
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

procedure TForm1.x11Click(Sender: TObject);
begin
  r := 5;
  PaintBox1.OnPaint(sender);
end;

procedure TForm1.x21Click(Sender: TObject);
begin
  r := 10;
  PaintBox1.OnPaint(sender);
end;

procedure TForm1.Background1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
  PaintBox1.OnPaint(sender);
end;

procedure TForm1.Corners1Click(Sender: TObject);
begin
  PaintBox1.OnPaint(sender);
end;

procedure TForm1.CrossSections1Click(Sender: TObject);
begin
  PaintBox1.OnPaint(sender);
end;

procedure TForm1.CrossSections2Click(Sender: TObject);
begin
  if ColorDialog4.Execute then
  PaintBox1.OnPaint(sender);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  bm:=tbitmap.create;
  bm.width:=paintbox1.width;
  bm.Height:=paintbox1.Height;
  mat[0].x:=150;
  mat[0].y:=100;
  mat[1].x:=750;
  mat[1].y:=200;
  mat[2].x:=350;
  mat[2].y:=450;
  p:=3;
  PaintBox1Paint(Sender);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bm.free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  r := 5;
  ColorDialog1.Color := clWhite;
end;

procedure TForm1.Frame1Click(Sender: TObject);
begin
  PaintBox1.OnPaint(sender);
end;

procedure TForm1.Frame2Click(Sender: TObject);
begin
  if ColorDialog2.Execute then
  PaintBox1.OnPaint(sender);
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var o:integer;
begin
  p:=3;
  for o:=0 to 2 do begin
   if sqr(X-mat[o].x)+sqr(Y-mat[o].y)<=sqr(r) then p:=o;
  end;
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  p:=3;
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var q,o:integer;
begin
  if p<3 then begin
    mat[p].x:=X;
    if mat[p].x<0 then mat[p].x:=0;
    if mat[p].x>paintbox1.width then mat[p].x:=paintbox1.width;
    mat[p].y:=Y;
    if mat[p].y<0 then mat[p].y:=0;
    if mat[p].y>paintbox1.height then mat[p].y:=paintbox1.height;
    PaintBox1Paint(Sender);
  end
  else begin
     q:=3;
     for o:=0 to 2 do begin
       if sqr(X-mat[o].x)+sqr(Y-mat[o].y)<=sqr(r) then q:=o;
     end;
     if q<3 then paintbox1.Cursor:=crHandPoint
            else paintbox1.Cursor:=crdefault
  end;
end;

end.
