unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    Label6: TLabel;
    SaveDialog1: TSaveDialog;
    SpinEdit6: TSpinEdit;
    Label7: TLabel;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ColorDialog1: TColorDialog;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    Label11: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
    procedure SpinEdit5Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  mat:array[0..6,1..4] of real;
  x,xi,y,yi,sum:real;
  bm : tbitmap;

 {
const x0 = -4;
      x1 = 4;
      y0 = 11;
      y1 = -1;
      rand = 1000;
}

  x0, x1, y0, y1, rand : integer;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
var
  Bitmap: TBitmap;
begin
  if SaveDialog1.Execute then
  begin
    try
      Bitmap:=TBitmap.Create;

      case ComboBox1.ItemIndex of
      0 : Bitmap.PixelFormat := pf8bit;
      1 : Bitmap.PixelFormat := pf24bit;
      2 : Bitmap.PixelFormat := pf32bit;
      end;

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

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  Button1.Click;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bm.free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  x0 := SpinEdit1.Value;
  x1 := SpinEdit2.Value;
  y0 := SpinEdit3.Value;
  y1 := SpinEdit4.Value;
  rand := SpinEdit5.Value;

  bm:=tbitmap.create;
  bm.width:=paintbox1.width;
  bm.height:=paintbox1.height;

  mat[0,1]:=0.85;
  mat[0,2]:=0.07;
  mat[0,3]:=0.07;
  mat[0,4]:=0.01;
  mat[1,1]:=0.85;
  mat[1,2]:=0.2;
  mat[1,3]:=-0.15;
  mat[1,4]:=0;
  mat[2,1]:=0.04;
  mat[2,2]:=-0.26;
  mat[2,3]:=0.28;
  mat[2,4]:=0;
  mat[3,1]:=-0.04;
  mat[3,2]:=0.26;
  mat[3,3]:=0.23;
  mat[3,4]:=0;
  mat[4,1]:=0.85;
  mat[4,2]:=0.22;
  mat[4,3]:=0.24;
  mat[4,4]:=0.16;
  mat[5,1]:=0;
  mat[5,2]:=0;
  mat[5,3]:=0;
  mat[5,4]:=0;
  mat[6,1]:=1.6;
  mat[6,2]:=1.6;
  mat[6,3]:=0.44;
  mat[6,4]:=0;

  x:=0;
  y:=0;
  sum:=mat[0,1]+mat[0,2]+mat[0,3]+mat[0,4];
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var
  i,r,c,grenze:integer;
begin
  Screen.Cursor := crHourGlass;
  grenze := strtoint(edit1.Text);
  if grenze> SpinEdit6.Value then grenze := SpinEdit6.Value;

  if CheckBox1.Checked = true then
  begin
    bm.Canvas.Pen.Color:= Shape3.Brush.Color;
  end else begin
    bm.Canvas.Pen.Color:= Shape1.Brush.Color;
  end;

  bm.Canvas.brush.Color:= Shape1.Brush.Color;
  bm.Canvas.rectangle(0,0,bm.width,bm.height);
  c:=0;

  randomize;
  for i:=0 to grenze do begin
    r:=random(rand+1);
    if (r<=rand*mat[0,1]/sum) then c:=1;
    if (r>rand*mat[0,1]/sum) and (r<=rand*(mat[0,1]+mat[0,2])/sum) then c:=2;
    if (r>rand*(mat[0,1]+mat[0,2])/sum) and (r<=rand*(mat[0,1]+mat[0,2]+mat[0,3])/sum) then c:=3;
    if (r>rand*(mat[0,1]+mat[0,2]+mat[0,3])/sum) then c:=4;
    xi:=mat[1,c]*x+mat[2,c]*y+mat[5,c];
    yi:=mat[3,c]*x+mat[4,c]*y+mat[6,c];
    x:=xi;
    y:=yi;
    bm.Canvas.Pixels[round(paintbox1.width*(x-x0)/(x1-x0)),
                 round(paintbox1.height*(y-y0)/(y1-y0))] := Shape2.Brush.Color;
  end;
  paintbox1.canvas.draw(0,0,bm);
  Screen.Cursor := crDefault;
end;

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
  begin
    Shape1.Brush.Color := ColorDialog1.Color;
    Button1.Click;
  end;
end;

procedure TForm1.Shape2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
  begin
    Shape2.Brush.Color := ColorDialog1.Color;
    Button1.Click;
  end;
end;

procedure TForm1.Shape3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
  begin
    Shape3.Brush.Color := ColorDialog1.Color;
    Button1.Click;
  end;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  x0 := SpinEdit1.Value;
end;

procedure TForm1.SpinEdit2Change(Sender: TObject);
begin
  x1 := SpinEdit2.Value;
end;

procedure TForm1.SpinEdit3Change(Sender: TObject);
begin
  y0 := SpinEdit3.Value;
end;

procedure TForm1.SpinEdit4Change(Sender: TObject);
begin
  SpinEdit4.Value;
end;

procedure TForm1.SpinEdit5Change(Sender: TObject);
begin
  rand := SpinEdit5.Value;
end;

end.
