unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Bumpmapping, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SpinEdit4: TSpinEdit;
    Label4: TLabel;
    SpinEdit5: TSpinEdit;
    SpinEdit6: TSpinEdit;
    Label5: TLabel;
    Label6: TLabel;
    ComboBox1: TComboBox;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  XPos: Single;
  YPos: Single;
  bmp : TBitmap;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    bmp.Assign(Image1.Picture.Bitmap);
    Bump_Init(Image1.Picture.Bitmap, SpinEdit1.Value,
                                   SpinEdit2.Value,
                                   SpinEdit3.Value);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  pic : TBitmap;
begin

  if SaveDialog1.Execute then
  begin
    try
      pic := TBitmap.Create;
      pic.Assign(Image1.Picture.Bitmap);
      pic.Pixelformat := pf24bit;
      pic.SaveToFile(SaveDialog1.FileName + '.bmp');
    finally
      pic.Free;
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Timer1.Enabled := not Timer1.Enabled;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Bump_Flush();
  bmp.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := true;
  bmp := TBitmap.Create;
  bmp.Assign(Image1.Picture.Bitmap);
  Bump_Init(Image1.Picture.Bitmap, SpinEdit1.Value,
                                   SpinEdit2.Value,
                                   SpinEdit3.Value);
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  Image1.Picture.Bitmap.Assign(bmp);
  Bump_Init(Image1.Picture.Bitmap, SpinEdit1.Value,
                                   SpinEdit2.Value,
                                   SpinEdit3.Value);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Timer1.Interval := SpinEdit4.Value;

  // Change the position of the light point
  XPos := XPos + 0.02;
  YPos := YPos + 0.01;

  // Limit to 2Pi
  if (XPos > 2 * PI) then XPos := XPos - 2 * PI;
  if (YPos > 2 * PI) then YPos := YPos - 2 * PI;

  // And spend
  with Image1.Picture do
  case ComboBox1.ItemIndex of
  0 : begin
        Bump_Do(Bitmap,
        trunc(sin(XPos+SpinEdit5.Value) * (Bitmap.Width shr 1) +
                                        (Bitmap.Width shr 1)),
        trunc(sin(YPos+SpinEdit6.Value) * (Bitmap.Height shr 1) +
                                        (Bitmap.Height shr 1)));
      end;
  1 : begin
        Bump_Do(Bitmap,
        trunc(cos(XPos+SpinEdit5.Value) * (Bitmap.Width shr 1) +
                                        (Bitmap.Width shr 1)),
        trunc(cos(YPos+SpinEdit6.Value) * (Bitmap.Height shr 1) +
                                        (Bitmap.Height shr 1)));
      end;
  2 : begin
        Bump_Do(Bitmap,
        trunc(Tangent(XPos+SpinEdit5.Value) * (Bitmap.Width shr 1) +
                                        (Bitmap.Width shr 1)),
        trunc(Tangent(YPos+SpinEdit6.Value) * (Bitmap.Height shr 1) +
                                        (Bitmap.Height shr 1)));
      end;
  3 : begin
        Bump_Do(Bitmap,
        trunc(Ln(XPos+SpinEdit5.Value) * (Bitmap.Width shr 1) +
                                        (Bitmap.Width shr 1)),
        trunc(Ln(YPos+SpinEdit6.Value) * (Bitmap.Height shr 1) +
                                        (Bitmap.Height shr 1)));
      end;
  end;


end;

end.
