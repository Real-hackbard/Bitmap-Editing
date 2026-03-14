unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ScrollBar1: TScrollBar;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    procedure ScrollBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  pic : TBitmap;
  zoom: Real;

implementation

{$R *.dfm}
procedure SetCanvasZoomFactor(Canvas: TCanvas; AZoomFactor: Integer);
var
  i: Integer;
begin
  if AZoomFactor = 100 then
    SetMapMode(Canvas.Handle, MM_TEXT)
  else
  begin
    SetMapMode(Canvas.Handle, MM_ISOTROPIC);
    SetWindowExtEx(Canvas.Handle, AZoomFactor, AZoomFactor, nil);
    SetViewportExtEx(Canvas.Handle, 100, 100, nil);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    try
      pic := TBitmap.Create;
      pic.Assign(Image1.Picture.Bitmap);
    except
      on E : Exception do
        ShowMessage(E.Message);
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.ItemIndex = 1 then
    Edit1.Enabled := true
      else
    Edit1.Enabled := false;
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
  end;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
var
  bitmap: TBitmap;
begin
  if ComboBox1.ItemIndex = 0 then
    begin
    Image1.Picture.Bitmap.Assign(pic);
    bitmap := TBitmap.Create;
    try
      bitmap.Assign(Image1.Picture.Bitmap);
      Image1.Picture.Graphic := nil;
      SetCanvasZoomFactor(bitmap.Canvas, ScrollBar1.Position);
      Image1.Canvas.Draw(0, 0, bitmap);
      Image1.Picture.Bitmap.Height := bitmap.Height;
      Image1.Picture.Bitmap.Width := bitmap.Width;
    finally
      bitmap.Free
    end;
  end;

  if ComboBox1.ItemIndex = 1 then
  begin
    Edit1.Text:= FloatToStr(zoom);
    Image1.Stretch :=True;
    Image1.Autosize := False;
    zoom:= ScrollBar1.Position/10;
    Image1.Width := Round(Image1.Picture.Width*zoom);
    Image1.Height := Round(Image1.Picture.Height*zoom);
  end;
  Label2.Caption := IntToStr(ScrollBar1.Position) + ' %';
end;

end.
