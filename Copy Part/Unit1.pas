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
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    SpinEdit6: TSpinEdit;
    SpinEdit7: TSpinEdit;
    SpinEdit8: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    ScrollBox2: TScrollBox;
    Image2: TImage;
    Button2: TButton;
    Button3: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SpinEdit9: TSpinEdit;
    SpinEdit10: TSpinEdit;
    Label9: TLabel;
    Label10: TLabel;
    ComboBox1: TComboBox;
    Label11: TLabel;
    Label12: TLabel;
    ComboBox2: TComboBox;
    Label13: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Image2.Picture.Graphic := nil;

  case ComboBox1.ItemIndex of
  0 : begin
        Image2.Canvas.CopyRect(               // Paint Canvas Parts
          Rect(SpinEdit1.Value,               // Distance (X)
               SpinEdit2.Value,               // Distance (Y)
               SpinEdit3.Value,               // Range width (X)
               SpinEdit4.Value),              // Range width (Y)
          Image1.Canvas,                      // From Image1
          Rect(
            SpinEdit5.Value,                  // Distance (X) Image1
            SpinEdit6.Value,                  // Distance (Y) Image1
            SpinEdit7.Value - SpinEdit9.Value,
            SpinEdit8.Value - SpinEdit10.Value));
      end;
  1 : begin
        Image2.Canvas.CopyRect(               // Paint Canvas Parts
          Rect(SpinEdit1.Value,               // Distance (X)
               SpinEdit2.Value,               // Distance (Y)
               SpinEdit3.Value,               // Range width (X)
               SpinEdit4.Value),              // Range width (Y)
          Image1.Canvas,                      // From Image1
          Rect(
            SpinEdit5.Value,                  // Distance (X) Image2
            SpinEdit6.Value,                  // Distance (Y) Image2
            Image1.Picture.Width + SpinEdit9.Value,
            Image1.Picture.Height + SpinEdit10.Value));
      end;
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    SpinEdit3.Value := Image1.Width;
    SpinEdit4.Value := Image1.Height;
    SpinEdit7.Value := Image1.Width;
    SpinEdit8.Value := Image1.Height;
    Label12.Caption := ExtractFileName(OpenDialog1.FileName);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  if SaveDialog1.Execute then
  begin
    try
      bmp := TBitmap.Create;
      bmp.Assign(Image2.Picture.Bitmap);

      case ComboBox2.ItemIndex of
      0 : bmp.PixelFormat := pf24bit;
      1 : bmp.PixelFormat := pf32bit;
      end;

      bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
    finally
      bmp.Free;
    end;
  end;
end;

end.
