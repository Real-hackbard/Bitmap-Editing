unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Jpeg, BmpGrD12;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    Button3: TButton;
    Button4: TButton;
    SaveDialog1: TSaveDialog;
    ComboBox1: TComboBox;
    Label1: TLabel;
    ComboBox2: TComboBox;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
    FIsPicture     : Boolean;
    FIsGrayPicture : Boolean;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  pic : TBitmap;

implementation

{$R *.dfm}
procedure ImageGrayScale(var AnImage: TImage);
var
  JPGImage: TJPEGImage;
  BMPImage: TBitmap;
  MemStream: TMemoryStream;
begin
  BMPImage := TBitmap.Create;
  try
    BMPImage.Width  := AnImage.Picture.Bitmap.Width;
    BMPImage.Height := AnImage.Picture.Bitmap.Height;

    JPGImage := TJPEGImage.Create;
    try
      JPGImage.Assign(AnImage.Picture.Bitmap);
      JPGImage.CompressionQuality := 100;
      JPGImage.Compress;
      JPGImage.Grayscale := True;
      BMPImage.Canvas.Draw(0, 0, JPGImage);

      MemStream := TMemoryStream.Create;
      try
        BMPImage.SaveToStream(MemStream);
        // you need to reset the position of the MemoryStream to 0
        MemStream.Position := 0;

        AnImage.Picture.Bitmap.LoadFromStream(MemStream);
        AnImage.Refresh;
      finally
        MemStream.Free;
      end;
    finally
      JPGImage.Free;
    end;
  finally
    BMPImage.Free;
  end;
  // end of ImageGrayScale
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  ABitmap : TBitmap;
begin
  Screen.Cursor := crHourGlass;
  case ComboBox2.ItemIndex of
      // low quality
  0 : ImageGrayScale(Image1);

  1 : begin
        // high quality
        if Not FIsPicture then Exit;
          ABitmap := TBitmap.Create;
          try
            if ConvertToGrayBitmap(Image1.Picture.Bitmap, ABitmap) then
            begin
              FIsGrayPicture:=True;
              Image1.Picture.Bitmap.Assign(ABitmap);
            end;
          finally
            ABitmap.Free;
          end;
      end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    pic.Assign(Image1.Picture.Bitmap);
    pic.PixelFormat := pf24bit;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Image1.Picture.Bitmap.Assign(pic);
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  if SaveDialog1.Execute then
  begin
    try
      bmp := TBitmap.Create;
      bmp.Assign(Image1.Picture.Bitmap);

      case ComboBox1.ItemIndex of
      0 : bmp.PixelFormat := pf4bit;
      1 : bmp.PixelFormat := pf8bit;
      2 : bmp.PixelFormat := pf16bit;
      3 : bmp.PixelFormat := pf24bit;
      4 : bmp.PixelFormat := pf32bit;
      end;

      bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
    finally
      bmp.Free;
    end;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  pic.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FIsPicture:=True;
  pic := TBitmap.Create;
  pic.Assign(Image1.Picture.Bitmap);
end;

end.
