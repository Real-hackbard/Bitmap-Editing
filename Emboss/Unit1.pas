unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    Button1: TButton;
    SpinEdit1: TSpinEdit;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Button2: TButton;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  pic : TBitmap;

implementation

{$R *.dfm}
procedure Emboss(ABitmap : TBitmap; AMount : Integer);
var
  x, y, i : integer;
  p1, p2: PByteArray;
begin
  for i := 0 to AMount do
  begin
    for y := 0 to Form1.SpinEdit2.Value-2 do
    begin
      p1 := ABitmap.ScanLine[y];
      p2 := ABitmap.ScanLine[y+1];
      for x := 0 to Form1.SpinEdit3.Value do
      begin
        p1[x*3]   := (p1[x*3]+(p2[(x+3)*3] xor $FF)) shr 1;
        p1[x*3+1] := (p1[x*3+1]+(p2[(x+3)*3+1] xor $FF)) shr 1;
        p1[x*3+2] := (p1[x*3+1]+(p2[(x+3)*3+1] xor $FF)) shr 1;
      end;
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  try
    bmp := TBitmap.Create;
    bmp.Assign(pic);
    bmp.PixelFormat := pf24bit;
    Emboss(bmp, SpinEdit1.Value);
    Image1.Picture.Bitmap.Assign(bmp);
  finally
    bmp.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    pic.Assign(Image1.Picture.Bitmap);
    SpinEdit2.Value := Image1.Height;
    SpinEdit3.Value := Image1.Width;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  pic.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  try
    pic := TBitmap.Create;
    pic.Assign(Image1.Picture.Bitmap);
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  Button1.Click;
end;

end.
