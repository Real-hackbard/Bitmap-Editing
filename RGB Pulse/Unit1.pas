unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    TrackBar1: TTrackBar;
    GroupBox2: TGroupBox;
    TrackBar2: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    TrackBar3: TTrackBar;
    Label3: TLabel;
    TrackBar4: TTrackBar;
    Shape1: TShape;
    Button2: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    Button4: TButton;
    Timer1: TTimer;
    Timer2: TTimer;
    Button6: TButton;
    Label4: TLabel;
    ScrollBar1: TScrollBar;
    Label5: TLabel;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    Image2: TImage;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Button1: TButton;
    Label6: TLabel;
    Label7: TLabel;
    StatusBar1: TStatusBar;
    SaveDialog1: TSaveDialog;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure defcor;
    procedure TrackBar2Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure AplicaLUT(Bmp: TBitmap);
    procedure Button5Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
  lx,ly,d,atual,aplic,cor: integer;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

type
  TCor24Bits = packed record
    R: byte;
    G: byte;
    B: byte;
  end;
  PCor24Bits = ^TCor24Bits;

  TLut = array [0..255] of Byte;

{$R *.DFM}

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  if TrackBar1.position < TrackBar1.max then
  TrackBar1.position := trackbar1.position + 50
 else
 begin
  Timer1.enabled := true;
  Timer2.enabled := false;
end;

end;

procedure tform1.defcor;
var
r1,g1,b1: integer;
r2,g2,b2: integer;
r3,g3,b3: integer;
per,dif: integer;
begin

per:= round(100-((d*100)/trackbar1.position));
//RED
r1:= getrvalue(atual);
r2:= getrvalue(aplic);
if r2>=r1 then
r3:= round(r1 + (((r2-r1)*per)/100))
else
if r1>r2 then
r3:= round(r1 - (((r1-r2)*per)/100));
//GREEN
g1:= getgvalue(atual);
g2:= getgvalue(aplic);
if g2>=g1 then
g3:= round(g1 + (((g2-g1)*per)/100))
else
if g1>g2 then
g3:= round(g1 - (((g1-g2)*per)/100));
//BLUE
b1:= getbvalue(atual);
b2:= getbvalue(aplic);
if b2>=b1 then
b3:= round(b1 + (((b2-b1)*per)/100))
else
if b1>b2 then
b3:= round(b1 - (((b1-b2)*per)/100));
cor:= rgb(r3,g3,b3);
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  lx:= x;
  ly:= y;
  button4.click;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  StatusBar1.Panels[0].Text := 'RGB Pulse - (' + inttostr(lx)+','+
                                                 inttostr(ly)+')'+ ' - (' +
                                                 inttostr(x)+','+
                                                 inttostr(y)+')';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := true;
  lx:= 185;
  ly:= 100;
  cor := clwhite;
  aplic := clwhite;
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  shape1.Brush.color:= RGB(trackbar2.position,
                           trackbar3.position,
                           trackbar4.position);
  aplic := Shape1.Brush.color;
  Button4.Click;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenPictureDialog1.execute then
  begin
    image1.picture.bitmap.LoadFromFile(OpenPictureDialog1.filename);
    image2.picture.bitmap.LoadFromFile(OpenPictureDialog1.filename);
  end;
end;

procedure Tform1.AplicaLUT(Bmp: TBitmap);
var
  pc:  PCor24Bits;
  a,b,x,y: Integer;
begin
  Bmp.PixelFormat := pf24bit;
  for y:=0 to Bmp.Height-1 do
  begin
    pc := Bmp.ScanLine[y];
    for x:=0 to Bmp.Width-1 do
    begin
   if lx>=x then
   b:= lx-x;
   if x>lx then
   b:= x-lx;
   if b<0 then b:=b*(-1);
   if ly>=y then
   a:= ly-y;
   if y>ly then
   a:= y-ly;
   if a<0 then a:=a*(-1);
   d:= round(sqrt( (a*a) + (b*b) ));
   if d<=trackbar1.position then
   begin
   atual:= RGB(pc.b,pc.g,pc.r);
   defcor;
   pc.b:= getrvalue(cor);
   pc.g:= getgvalue(cor);
   pc.r:= getbvalue(cor);
   end;
      Inc(pc);
    end;
  end;
  image1.refresh;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  image1.Picture := image2.picture;
  AplicaLUT(image1.picture.bitmap);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
button4.click;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
button4.click;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
if trackbar1.position>1 then
 trackbar1.position:=trackbar1.position-50
 else
 begin
 timer2.enabled:=true;
 timer1.enabled:=false;
 end;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  if Button6.Caption='Pulse' then
  begin
  TrackBar1.Position := 100;
  Timer1.enabled := true;
  Button6.Caption:='Stop';
  end
  else
  if button6.Caption='Stop' then
  begin
  Timer1.Enabled:=false;
  Timer2.Enabled:=false;
  Button6.Caption:='Pulse';
end
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  Timer1.Interval := ScrollBar1.Position;
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
  lx := ScrollBar2.Position;
  Button4.Click;
end;

procedure TForm1.ScrollBar3Change(Sender: TObject);
begin
  ly := ScrollBar3.Position;
  Button4.Click;
end;

end.
