unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SaveDialog1: TSaveDialog;
    ComboBox1: TComboBox;
    Label4: TLabel;
    Button2: TButton;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function TileImage(const FileName: TFileName; Sender: TObject): Boolean;
var
  x, y: Integer;
  Bmp:  TBitmap;
begin
  if FileExists(FileName) then
  begin
    bmp := TBitmap.Create;
    try
      bmp.LoadFromFile(FileName);

      Form1.Image1.Height := bmp.Height*Form1.SpinEdit2.Value;
      Form1.Image1.Width := bmp.Width*Form1.SpinEdit1.Value;


      with (Sender as TImage) do
      begin
        for x := 0 to (Width div bmp.Width) do
          for y := 0 to (Height div bmp.Height) do
            Canvas.Draw( x * bmp.Width ,  y * bmp.Height , bmp);
      end;
    finally
      bmp.Free;
    end;
    Result := True;
  end
  else
    Result := False;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   if OpenDialog1.Execute then
   begin
    TileImage(OpenDialog1.FileName, Image1);
    Label5.Caption := 'X : ' + IntToStr(Image1.Width) + ' - ' +
                      'Y : ' + IntToStr(Image1.Height);
   end;

end;

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

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  TileImage(OpenDialog1.FileName, Image1);
    Label5.Caption := 'X : ' + IntToStr(Image1.Width) + ' - ' +
                      'Y : ' + IntToStr(Image1.Height);
end;

procedure TForm1.SpinEdit2Change(Sender: TObject);
begin
  TileImage(OpenDialog1.FileName, Image1);
    Label5.Caption := 'X : ' + IntToStr(Image1.Width) + ' - ' +
                      'Y : ' + IntToStr(Image1.Height);
end;

end.
