unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    SpinEdit3: TSpinEdit;
    Label3: TLabel;
    SpinEdit4: TSpinEdit;
    Label4: TLabel;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    SpinEdit5: TSpinEdit;
    SpinEdit6: TSpinEdit;
    Label5: TLabel;
    Label6: TLabel;
    SpinEdit7: TSpinEdit;
    Label7: TLabel;
    ComboBox1: TComboBox;
    Label8: TLabel;
    ComboBox2: TComboBox;
    Label9: TLabel;
    Label10: TLabel;
    Shape1: TShape;
    ColorDialog1: TColorDialog;
    procedure Button1Click(Sender: TObject);
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
{ Draw 1 pixcel width line }
procedure DrawLine(X,Y,H,L:Integer; Step:Real);
var
  R, C : Integer;
begin
  Screen.Cursor := crHourGlass;
     for R:=0 To H Do
     begin
       { Change fill color }
       if R<=L then
       begin
          C:=Round(R*Step);
          { Black -> Color }
          case Form1.ComboBox1.ItemIndex of
            0 : Form1.Image1.Canvas.Pen.Color:= RGB(C,0,0);
            1 : Form1.Image1.Canvas.Pen.Color:= RGB(0,C,0);
            2 : Form1.Image1.Canvas.Pen.Color:= RGB(0,0,C);
            3 : Form1.Image1.Canvas.Pen.Color:= RGB(C,C,0);
            4 : Form1.Image1.Canvas.Pen.Color:= RGB(0,C,C);
            5 : Form1.Image1.Canvas.Pen.Color:= RGB(C,0,C);
            6 : Form1.Image1.Canvas.Pen.Color:= RGB(C,C,C);
          end;

       end
       else if R<=2*L Then
       begin
          C:=Round((R-L)*Step);
          { Color -> Black }
          case Form1.ComboBox1.ItemIndex of
            0 : Form1.Image1.Canvas.Pen.Color:=RGB(255-C,0,0);
            1 : Form1.Image1.Canvas.Pen.Color:=RGB(0,255-C,0);
            2 : Form1.Image1.Canvas.Pen.Color:=RGB(0,0,255-C);
            3 : Form1.Image1.Canvas.Pen.Color:=RGB(255-C,255-C,0);
            4 : Form1.Image1.Canvas.Pen.Color:=RGB(0,255-C,255-C);
            5 : Form1.Image1.Canvas.Pen.Color:=RGB(255-C,0,255-C);
            6 : Form1.Image1.Canvas.Pen.Color:=RGB(255-C,255-C,255-C);
          end;
       end;
       { Fill area by drawing lines }
       Form1.Image1.Canvas.MoveTo(X,Y+R);
       Form1.Image1.Canvas.LineTo(X+1,Y+R);
     end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.Button1Click(Sender: TObject);
Var
  Angle, X, Y, H, H2, W, L : Integer;
  Step : Real;
begin
  { Get image size }
  H := SpinEdit1.Value;
  W := SpinEdit2.Value;
  Image1.Picture.Bitmap.Height := H;
  Image1.Picture.Bitmap.Width := W;

  { Fill image area by form color }
  Image1.Canvas.Brush.Color := Shape1.Brush.Color;
  Image1.Canvas.Pen.Color := Shape1.Brush.Color;
  Image1.Canvas.Rectangle(0,0,W,H);

  { Pixel format }
  case ComboBox2.ItemIndex of
  0 : Image1.Picture.Bitmap.PixelFormat := pf4bit;
  1 : Image1.Picture.Bitmap.PixelFormat := pf8bit;
  2 : Image1.Picture.Bitmap.PixelFormat := pf24bit;
  3 : Image1.Picture.Bitmap.PixelFormat := pf32bit;
  end;

  { Set fill size }
  H2 := SpinEdit3.Value;
  L:= H2 Div 2;

  { Set fill step size }
  Step:= SpinEdit4.Value/L;
  Angle:=0;
  for X:=1 to W do
   begin
      Y:=Round(100 * Sin(Angle*(Pi / SpinEdit6.Value)));
      DrawLine(X,(H div 3)-Y,H2,L,Step);
      Inc(Angle);
      if Angle > SpinEdit5.Value then Angle:=0;
   end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := true;
end;

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
    Shape1.Brush.Color := ColorDialog1.Color;
end;

end.
