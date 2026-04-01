unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,math, ExtCtrls, XPMan, Spin;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    Image2: TImage;
    Label1: TLabel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    Label2: TLabel;
    Button3: TButton;
    SaveDialog1: TSaveDialog;
    SpinEdit1: TSpinEdit;
    Label3: TLabel;
    Shape1: TShape;
    Label4: TLabel;
    ColorDialog1: TColorDialog;
    Shape2: TShape;
    Label5: TLabel;
    CheckBox1: TCheckBox;
    Button4: TButton;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageDblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure drawpolygone;
  end;

type
 polygone=record
   size:integer;
   sommet:array of tpoint;
   end;
   tligne = record
   count:integer;
   side:array of integer;
   end;
   Tarray32=array[0..16000] of dword;
   parray32=^tarray32;

var
  Form1: TForm1;
  p:polygone;

implementation

{$R *.dfm}

procedure swapval(var x,y: integer);
var
  tmp:integer;
begin
  tmp:=x;
  x:=y;
  y:=tmp;
end;

procedure TForm1.drawpolygone;
var
  i,j,k:integer;
  ligne:TLigne;
  x0,y0,x1,y1,x2,y2:integer;
  mini,maxi:integer;
  texture,image:parray32;
begin
 // We add two vertices that will form a loop with the first two
 setlength(p.sommet,p.size + 2);
 p.sommet[p.size].X:=p.sommet[0].X;
 p.sommet[p.size].y:=p.sommet[0].y;
 p.sommet[p.size+1].X:=p.sommet[1].X;
 p.sommet[p.size+1].y:=p.sommet[1].y;

 // find the highest and lowest lines
 mini := 600;
 maxi := 0;
 for i:=1 to p.size do
  begin
   if p.sommet[i].Y>maxi then maxi:=p.sommet[i].Y;
   if p.sommet[i].Y<mini then mini:=p.sommet[i].Y;
  end;

 for i:=mini to maxi do
  begin
   ligne.count := 0;
   setlength(ligne.side,0);

   // finding the points of intersection with the edges
   for j:=1 to p.size do
    begin
     x0:=p.sommet[j-1].x;
     y0:=p.sommet[j-1].y;
     x1:=p.sommet[j].x;
     y1:=p.sommet[j].y;
     x2:=p.sommet[j+1].x;
     y2:=p.sommet[j+1].y;

     // special case of a vertex on the horizontal
     // If it's the second point, we'll deal with it in the next iteration.
     if (i=y2) then  continue;
     // If that's the first point, we look at how
     if (i=y1) then
      begin
        // we record the intersection
        inc(ligne.count);
        setlength(ligne.side,ligne.count);
        ligne.side[ligne.count-1]:=x1;

        // If both edges are on the same side of the horizontal line,
        // the point counts double.
        if sign(y1-y0)*sign(y1-y2)>=0 then
         begin
          inc(ligne.count);
          setlength(ligne.side,ligne.count);
          ligne.side[ligne.count-1]:=x1;
         end;
        continue;
      end;

     // the edge is horizontal, we drop
     if y1=y2 then continue;

     // We sort the two points in order of their Y values.
     if y1>y2 then
     begin
      swapval(x1,x2);
      swapval(y1,y2);
     end;

     // If the line passes between the two y-coordinates, there is an intersection.
     if ((y1<=i) and (i<=y2)) then
      begin
       inc(ligne.count);
       setlength(ligne.side,ligne.count);
       // formula giving the abscissa
       ligne.side[ligne.count-1]:=round(x1+(i-y1)/(y2-y1)*(x2-x1));
      end;
   end;

   // We sort the points of intersection in ascending order
   for j:=0 to ligne.count-2 do
    for k:=j+1 to ligne.count-1 do
     if ligne.side[j]>ligne.side[k] then swapval(ligne.side[j],ligne.side[k]);

   // we point towards the canvas line and the corresponding texture
   image:=image1.picture.Bitmap.ScanLine[i];
   texture:=Image2.picture.Bitmap.ScanLine[i mod Image2.height];

   // We draw the segments by taking the intersections two by two.
   for j:=0 to (ligne.count div 2)-1 do
    for k:=ligne.side[j*2] to ligne.side[j*2+1] do
     image[k]:=texture[k mod Image2.Width];
  end;

  // we trace the outlines
  for i:=0 to p.size do
   begin
    image1.canvas.MoveTo(p.sommet[i].x,p.sommet[i].y);
    image1.canvas.LineTo(p.sommet[i+1].x,p.sommet[i+1].y);
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  p.size:=0;
  setlength(p.sommet,0);
  Image1.Picture.Bitmap := tbitmap.Create;
  Image1.Picture.Bitmap.Width:=image1.Width;
  Image1.Picture.Bitmap.Height:=image1.Height;
  Image1.picture.Bitmap.PixelFormat:= pf32bit;
  Image2.picture.Bitmap.PixelFormat:= pf32bit;
  Image1.Canvas.Brush.Color := clSilver;
  Image1.Canvas.FillRect(Image1.ClientRect);
end;

procedure TForm1.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if p.size =-1 then
  begin
   p.size:=0;
   setlength(p.sommet,0);
   exit;
  end;

 inc(p.size);
 setlength(p.sommet,p.size);
 p.sommet[p.size-1].X:=x;
 p.sommet[p.size-1].y:=y;

 if p.size=1 then
  begin
   image1.canvas.Pixels[x,y] := clBlack;
  end
 else
  begin
   Image1.Canvas.Pen.Width := SpinEdit1.Value;
   Image1.Canvas.Pen.Color := Shape1.Brush.Color;
   Image1.canvas.MoveTo(p.sommet[p.size-2].x,p.sommet[p.size-2].y);
   Image1.canvas.LineTo(p.sommet[p.size-1].x,p.sommet[p.size-1].y);
  end;   
end;

procedure TForm1.ImageDblClick(Sender: TObject);
begin
  image1.canvas.MoveTo(p.sommet[p.size-1].x,p.sommet[p.size-1].y);
  image1.canvas.LineTo(p.sommet[0].x,p.sommet[0].y);
  drawpolygone;
  p.size := -1;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Image2.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  image1.canvas.MoveTo(p.sommet[p.size-1].x,p.sommet[p.size-1].y);
  image1.canvas.LineTo(p.sommet[0].x,p.sommet[0].y);
  drawpolygone;
  p.size := -1;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
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
  begin
    Shape2.Brush.Color := ColorDialog1.Color;
    Image1.Canvas.Brush.Color := Shape2.Brush.Color;
    Image1.Canvas.FillRect(Image1.ClientRect);
  end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked = true then
  begin
    Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Image1.Picture.Graphic := nil;
  p.size:=0;
  setlength(p.sommet,0);
  Image1.Picture.Bitmap:=tbitmap.Create;
  Image1.Picture.Bitmap.Width:=image1.Width;
  Image1.Picture.Bitmap.Height:=image1.Height;
  Image1.picture.Bitmap.PixelFormat:= pf32bit;
  Image2.picture.Bitmap.PixelFormat:= pf32bit;
  Image1.Canvas.Brush.Color := Shape2.Brush.Color;
  Image1.Canvas.FillRect(Image1.ClientRect);

  if CheckBox1.Checked = true then
  begin
    Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
  end;
end;

end.