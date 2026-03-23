unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, Buttons, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    SpinEdit1: TSpinEdit;
    Panel3: TPanel;
    Panel4: TPanel;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpinEdit5: TSpinEdit;
    PaintBox2: TPaintBox;
    PaintBox1: TPaintBox;
    Panel6: TPanel;
    PaintBox3: TPaintBox;
    Panel5: TPanel;
    Label8: TLabel;
    SpinEdit6: TSpinEdit;
    Label13: TLabel;
    SpinEdit7: TSpinEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  rnd,x1,x2,x3,y1,y2,y3,FinalAge:integer;
  c:char;
  ot:string;
  cc,AngleR,AngleL,StartAngle,ConCoef:Real;

implementation

{$R *.dfm}
{Treugolnik Serpinskogo}
procedure Line(x1,y1,x2,y2:real; C:TCanvas);
begin
  c.Moveto(round(x1),round(y1));
  c.lineto(round(x2),round(y2));
end;

Procedure TriS(age:integer;x1,y1,x2,y2,x3,y3:real);
var
  xd,yd,xe,ye,xf,yf:real;
begin
  inc(age);

  if age= FinalAge then
  begin
    line(x1,y1,x2,y2, Form1.PaintBox1.Canvas);
    line(x2,y2,x3,y3, Form1.PaintBox1.Canvas);
    line(x3,y3,x1,y1, Form1.PaintBox1.Canvas);
    form1.PaintBox1.Canvas.Refresh;
  end
  else
  begin
    xd:=round((x1+x2)/2);
    yd:=round((y1+y2)/2);

    xe:=round((x2+x3)/2);
    ye:=round((y2+y3)/2);

    xf:=round((x1+x3)/2);
    yf:=round((y1+y3)/2);

    TriS(age,x1,y1,xd,yd,xf,yf);
    TriS(age,xd,yd,x2,y2,xe,ye);
    TriS(age,xf,yf,xe,ye,x3,y3);
  end;
end;

Procedure drawtree(age,kx,ky,r:integer; naklon:real);
var
  sx,sy:integer;
begin
  r:=round(r-0.2*r);
  inc(AGe);
  if age=FinalAge then
  begin
   Line(kx,ky,round(kx + R * cos(naklon)), round(ky + R * sin(naklon)),
                    form1.PaintBox2.Canvas);
   sx:=round(kx + R * cos(naklon));
   sy:=round(ky + R * sin(naklon));
   Line(sx,sy,round(sx + R * cos(naklon-angleL)),
              round(sy + R * sin(naklon-angleL)),
              form1.PaintBox2.Canvas);
   Line(sx,sy,round(sx + R * cos(naklon+angleR)),
              round(sy + R * sin(naklon+angleR)),
              form1.PaintBox2.Canvas);
  end
 else
  begin
   sx:=round(kx + R * cos(naklon));
   sy:=round(ky + R * sin(naklon));
   drawtree(age,sx,sy,r+random(rnd),naklon-angleL);
   drawtree(age,sx,sy,r+random(rnd),naklon+angleR);
   Line(kx,ky,round(kx + R * cos(naklon)), round(ky + R * sin(naklon)),
                    form1.PaintBox2.Canvas);
  end;
end;

Procedure DrawDragon(age:integer;x1,y1,x2,y2:real;n:real);
var
  dx,dy,AC,CD,AD,cx,cy:real;
begin
  inc(age);
  if Age=FinalAge then
  begin
  line(x1,y1,x2,y2, form1.PaintBox3.canvas);
  end else
  begin
    cx:=(x2+x1)/2;
    cy:=(y2+y1)/2;

    AC:=sqrt(sqr(cx-x1)+sqr(cy-y1));
    dx:=cx + AC * (cos(n+pi/2));
    dy:=cy + AC * (sin(n+pi/2));
    drawdragon(age,x1,y1,dx,dy,n+45*cc);
    drawdragon(age,x2,y2,dx,dy,n+90*cc+45*cc);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  PaintBox1.canvas.CleanupInstance;
  PaintBox1.Canvas.Brush.Color := clWhite;
  PaintBox1.Canvas.rectangle(0,0,PaintBox1.Width, PaintBox1.Height);

  x1:=10;
  y1:=10;
  x2:=320;
  y2:=470;
  x3:=630;
  y3:=10;

  if CheckBox1.Checked = true then
  begin
    PaintBox1.Canvas.CleanupInstance;
    PaintBox1.Canvas.rectangle(0,0,640,480);
  end;

  if SpinEdit1.value > 0 then
  begin
    Finalage := Spinedit1.Value;
    Tris(0,x1,y1,x2,y2,x3,y3);
  end;
  
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  StartX,StartY,StartHeight:integer;
  ot,tm:string;
  i,j,iter,Total:longint;
  StartH,StartM,StartS,StartS1,StopH,StopM,StopS,StopS1:word;
begin
  PaintBox2.canvas.CleanupInstance;
  PaintBox2.Canvas.Brush.Color := clWhite;
  PaintBox2.Canvas.rectangle(0,0,PaintBox2.Width,PaintBox2.Height);

  ConCoef:=(pi/180);
  AngleL:=spinedit3.value*ConCoef;
  AngleR:=Spinedit4.value*ConCoef;

  StartHeight := spinedit7.Value;
  StartAngle:=3/2*pi;
  StartX:=320;
  StartY:=480;
  Color:=15;
  RND:=0;

  if (spinedit2.Value>0) and (spinedit5.Value>=0) then
  begin
    RND := spinedit5.Value;
    FinalAge := Spinedit2.Value;
    drawtree(0,StartX,StartY,StartHeight,StartAngle);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  x1:=145;
  y1:=160;
  x2:=560;
  y2:=160;

  PaintBox3.canvas.CleanupInstance;
  PaintBox3.Canvas.Brush.Color := clWhite;
  PaintBox3.Canvas.rectangle(0,0,PaintBox3.Width,PaintBox3.Height);

  CC:=(pi/180);
  FinalAge:=spinedit6.Value;
  DrawDragon(0,x1,y1,x2,y2,0);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := true;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
var
  SrcRect, DestRect: TRect;
  Bmp: TBitmap;
begin
  Bmp := TBitmap.Create;
  Bmp.PixelFormat := pf24bit;
  Bmp.Width:=PaintBox1.Width;
  Bmp.Height:=PaintBox1.Height;
  Bmp.Canvas.CopyRect(Bounds(0,0,Bmp.Width, Bmp.Height),
        PaintBox1.Canvas, PaintBox1.ClientRect);
  try
    DestRect := Rect(0, 0, PaintBox1.Width, PaintBox1.Height);

    // To flip vertically:
     SrcRect := Rect(0, Bmp.Height, Bmp.Width, 0);

    PaintBox1.Canvas.CopyRect(DestRect, Bmp.Canvas, SrcRect);
  finally
    Bmp.Free;
  end;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
var
  SrcRect, DestRect: TRect;
  Bmp: TBitmap;
begin
  Bmp := TBitmap.Create;
  Bmp.PixelFormat := pf24bit;
  Bmp.Width:=PaintBox3.Width;
  Bmp.Height:=PaintBox3.Height;
  Bmp.Canvas.CopyRect(Bounds(0,0,Bmp.Width, Bmp.Height),
        PaintBox3.Canvas, PaintBox3.ClientRect);
  try
    DestRect := Rect(0, 0, PaintBox3.Width, PaintBox3.Height);

    // To flip vertically:
     SrcRect := Rect(0, Bmp.Height, Bmp.Width, 0);

    PaintBox3.Canvas.CopyRect(DestRect, Bmp.Canvas, SrcRect);
  finally
    Bmp.Free;
  end;
end;

end.
