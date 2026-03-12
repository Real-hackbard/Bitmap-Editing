unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Button2: TButton;
    Button3: TButton;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ColorDialog1: TColorDialog;
    ComboBox1: TComboBox;
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  col : TColor;
  pic : TBitmap;

implementation

{$R *.dfm}
procedure Spray(Canvas: TCanvas; x, y, r: Integer; Color: TColor);
var
  rad, a: Single;
  i: Integer;
begin
  for i := 0 to Form1.SpinEdit2.Value do
  begin
    case Form1.ComboBox1.ItemIndex of
      0 : a   := Random * 2 * pi;
      1 : a   := Random * 1 * pi;
    end;

    rad := Random * r;
    Canvas.Pixels[x + Round(rad * Cos(a)), y +
                      Round(rad * Sin(a))] := Color;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
    col := ColorDialog1.Color;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Image1.Picture.Bitmap.Assign(pic);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  try
    pic := TBitmap.Create;
    pic.Assign(Image1.Picture.Bitmap);
    col := clRed;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then Spray(Image1.Canvas, x, y, SpinEdit1.Value, col);
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ssLeft in Shift then Spray(Image1.Canvas, x, y, SpinEdit1.Value, col);
end;

end.
