unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Button2: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Button3: TButton;
    Label11: TLabel;
    Label10: TLabel;
    SaveDialog1: TSaveDialog;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    Bevel1: TBevel;
    RadioGroup1: TRadioGroup;
    ComboBox1: TComboBox;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
    lx,ly,d,atual,aplic,cor: integer;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  PDown             : TPoint;
  PActually         : TPoint;
  MouseIsDown       : Boolean;
  pic               : TBitmap;

implementation

{$R *.dfm}
procedure TForm1.Button2Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  if SaveDialog1.Execute then
  begin
    try
      bmp := TBitmap.Create;
      bmp.Assign(Image1.Picture.Bitmap);

      case ComboBox1.ItemIndex of
      0 : bmp.PixelFormat := pf24bit;
      1 : bmp.PixelFormat := pf32bit;
      end;

      bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
    finally
      bmp.Free;
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Image1.Picture.Bitmap.Assign(pic);
  Label7.Caption := '0';
  Label9.Caption := '0';
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image1.Picture.Graphic := nil;
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    pic.Assign(Image1.Picture.Bitmap);
    Label7.Caption := '0';
    Label9.Caption := '0';
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := true;

  try
    pic := TBitmap.Create;
    pic.Assign(Image1.Picture.Bitmap);
  except
    on E : Exception do
      ShowMessage(E.Message);
  end
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  lx:= x; ly:= y;
  PDown := Point(x, y);
  PActually := Point(x, y);
  MouseIsDown := true;
  Image1.Canvas.DrawFocusRect(Rect(x, y, x, y));
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label1.Caption := '(' + inttostr(lx)+','+inttostr(ly)+')';
  Label4.Caption := '(' + inttostr(x)+','+inttostr(y)+')';

  if MouseIsDown then
  begin
    Image1.Canvas.DrawFocusRect(Rect(PDown.x, PDown.y, PActually.x,PActually.y));
    PActually := Point(x, y);
    Image1.Canvas.DrawFocusRect(Rect(PDown.x, PDown.y, x, y));
  end;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Canvas.DrawFocusRect(Rect(PDown.x, PDown.y, PActually.x, PActually.y));
  Image1.Canvas.DrawFocusRect(Rect(PDown.x, PDown.y, x, y));
  PActually := Point(x, y);
  MouseIsDown := false;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  TmpBmp            : TBitmap;
begin
  Image1.Canvas.DrawFocusRect(Rect(PDown.x, PDown.y, PActually.x, PActually.y));
  TmpBmp := TBitmap.Create;
  with TmpBmp do
  try
    Width := Round(abs(PActually.x - PDown.x));
    Height := Round(abs(PActually.y - PDown.y));
    BitBlt(Canvas.Handle, 0, 0, Width, Height, Image1.Canvas.Handle, PDown.x,
      PDown.y, SRCCOPY);
    Image1.AutoSize := true;
    Image1.Picture.Bitmap.Assign(TmpBmp);

    Label7.Caption := IntToStr(Image1.Picture.Bitmap.Height);
    Label9.Caption := IntToStr(Image1.Picture.Bitmap.Width);
  finally
    Free;
  end;
end;

end.
 