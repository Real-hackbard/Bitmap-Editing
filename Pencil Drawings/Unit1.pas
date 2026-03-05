unit Unit1;

interface
{$WARNINGS OFF}
{$RANGECHECKS OFF}
{$R-}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.StdCtrls;

type

  TWork=class(tthread)
  private
   ThFinal:tbitmap;
   ThOriginal:tbitmap;
   progression:integer;
   TabConLum:array[0..255] of byte;
   procedure DisplayResult;
   procedure PosterProgress;
  protected
    procedure Execute; override;
  public
    Angle:integer;
    variation:integer;
    size:integer;
    Contrast:integer;
    Brightness:integer;
    length:integer;
    quantity:integer;
    Restart:boolean;
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
  end;

  TForm1 = class(TForm)
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    Label2: TLabel;
    ScrollBar3: TScrollBar;
    Label3: TLabel;
    ScrollBar4: TScrollBar;
    Label4: TLabel;
    ScrollBar5: TScrollBar;
    Label5: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    Label6: TLabel;
    ScrollBar6: TScrollBar;
    ScrollBar7: TScrollBar;
    Label7: TLabel;
    ProgressBar1: TProgressBar;
    Button1: TButton;
    Button2: TButton;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PaintBox1Paint(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Declarations privates }
    procedure enable;
  public
    { Declarations public }
    Final : TBitmap;
    Original : TBitmap;
  end;

var
  Form1: TForm1;
  Work:TWork;

implementation

{$R *.dfm}
constructor TWork.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  thOriginal := TBitmap.Create;
  form1.Original.Canvas.Lock;
  thOriginal.Assign(form1.Original);
  form1.Original.Canvas.UnLock;
  thOriginal.PixelFormat:=pf24bit;
  thFinal := TBitmap.Create;
  thFinal.width:=thOriginal.Width;
  thFinal.Height:=thOriginal.Height;
  Restart:=true;
end;

destructor TWork.Destroy;
begin
  thFinal.Free;
  thOriginal.Free;
  inherited Destroy;
end;

procedure TForm1.enable;
begin
  Label1.Enabled := true;
  Label2.Enabled := true;
  Label3.Enabled := true;
  Label4.Enabled := true;
  Label5.Enabled := true;
  Label6.Enabled := true;
  Label7.Enabled := true;
  ScrollBar1.Enabled := true;
  ScrollBar2.Enabled := true;
  ScrollBar3.Enabled := true;
  ScrollBar4.Enabled := true;
  ScrollBar5.Enabled := true;
  ScrollBar6.Enabled := true;
  ScrollBar7.Enabled := true;
end;

procedure TWork.PosterProgress;
begin
 form1.ProgressBar1.Position:=progression;
 form1.Label8.Caption := IntToStr(progression) + ' %';
end;

procedure TWork.DisplayResult;
begin
 form1.Final.canvas.Draw(0,0,thfinal);
 form1.PaintBox1.Canvas.Draw(0,0,thfinal);
end;

procedure TWork.Execute;
var
 i,j,l,tl,x,y,ii,jj,maxIt,progress:integer;
 a:single;
 r,v,b:integer;
 lum,cont,tai,ang,varia,lon,quant:integer;
 im1:pbytearray;
begin
  while not terminated do
   begin
    progression:=0;
    synchronize(PosterProgress);

    while not restart and not terminated do;
    restart:=false;
    lum:=Brightness;
    cont:=contrast;
    tai:=size;
    ang:=angle;
    varia:=variation;
    lon:=length;
    quant:=quantity;

    for i:=0 to 255 do
     begin
      l:=i+((255-i)*Lum) Div 255;
      tl :=(Abs(127-l)*Cont) Div 255;
      If (l > 127) Then l:=l+tl Else l:=l-tl;
      if l<0 then l:=0 else if l>255 then l:=255;
      TabConLum[i]:=l
     end;

    thfinal.Canvas.Lock;
    thoriginal.Canvas.Lock;
    thfinal.Canvas.FillRect(thfinal.canvas.ClipRect);
    maxIt:=thoriginal.Height*thoriginal.width*quant div 100;
    for j:=1 to MaxIt do
     begin
      if restart or terminated then break;
      x:=random(thoriginal.Width-7);
      y:=random(thoriginal.Height-7);
      r:=0;
      v:=0;
      b:=0;
      for jj:=y to y+6 do
       begin
        im1:=thoriginal.ScanLine[jj];
        for ii:=x to x+6 do
         begin
          r:=r+TabConLum[im1[ii*3+2]];
          v:=v+TabConLum[im1[ii*3+1]];
          b:=b+TabConLum[im1[ii*3+0]];
         end;
       end;
       a:=(angle+random(varia*2)-varia)*pi/180;
       thfinal.Canvas.Pen.Width:=tai;
       thfinal.Canvas.Pen.Color:=rgb(r div 49,v div 49,b div 49);
       thfinal.canvas.MoveTo(x,y);
       thfinal.canvas.LineTo(round(x+lon*cos(a)),round(y+lon*sin(a)));
       progress:=j*100 div MaxIt;
       if progression<>progress then
        begin
         progression:=progress;
         synchronize(PosterProgress);
        end;
     end;
   thoriginal.Canvas.UnLock;
   thfinal.Canvas.unLock;
   if not restart and not terminated then
    synchronize(DisplayResult);
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DoubleBuffered := true;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  ScrollBar1.Enabled := false;
  ScrollBar2.Enabled := false;
  ScrollBar3.Enabled := false;
  ScrollBar4.Enabled := false;
  ScrollBar5.Enabled := false;
  ScrollBar6.Enabled := false;
  ScrollBar7.Enabled := false;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  paintbox1.Canvas.Draw(0,0,final);
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
 Work.Contrast:=scrollbar1.Position;
 Work.Brightness:=scrollbar2.Position;
 Work.size:=scrollbar3.Position;
 Work.Angle:=scrollbar4.Position;
 Work.Variation:=scrollbar5.Position;
 Work.length:=scrollbar6.Position;
 Work.quantity:=scrollbar7.Position;
 label1.caption:=format('Contrast: %d%%',[scrollbar1.Position*100 div 255]);
 label2.caption:=format('Brightness: %d%%',[scrollbar2.Position*100 div 255]);
 label3.caption:=format('Pencil size: %d',[scrollbar3.Position]);
 label4.caption:=format('Main Angle: %d°',[scrollbar4.Position]);
 label5.caption:=format('Variation: ±%d°',[scrollbar5.Position]);
 label6.caption:=format('Line length: %d',[scrollbar6.Position]);
 label7.caption:=format('Trait Quantity: %d%%',[scrollbar7.Position]);
 Work.Restart:=true;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 if not openpicturedialog1.Execute then exit;
 begin
   original := TBitmap.Create;
   final := TBitmap.Create;
   Work := TWork.Create(false);
   original.LoadFromFile(openpicturedialog1.FileName);
   original.PixelFormat:=pf24bit;
   paintbox1.Width:=original.Width;
   paintbox1.Height:=original.Height;

   final.Assign(original);
   Work:=TWork.Create(false);
   ScrollBar1Change(nil);
   enable;
 end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if not savepicturedialog1.Execute then exit;
 final.SaveToFile(savepicturedialog1.FileName);
end;

end.
