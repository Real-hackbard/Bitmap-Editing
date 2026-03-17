unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Jpeg, System.Math;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    Button4: TButton;
    ScrollBox1: TScrollBox;
    Image2: TImage;
    ScrollBox2: TScrollBox;
    Image1: TImage;
    Button5: TButton;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure CombineAndSaveJPG(Bmp1, Bmp2: TBitmap; Filename: string);
var
  NewBmp: TBitmap;
  NewJpg: TJpegImage;
begin
  NewBmp := TBitmap.Create;
  try
    NewBmp.Width := Max(Bmp1.Width, Bmp2.Width);
    NewBmp.Height := Bmp1.Height + Bmp2.Height;
    NewBmp.Canvas.Draw(0, 0, Bmp1);
    NewBmp.Canvas.Draw(0, Bmp1.Height, Bmp2);
    NewJpg := TJpegImage.Create;
      try
        NewJpg.Assign(NewBmp);
        NewJpg.SaveToFile(FileName);
      finally
        NewJpg.Free;
      end;
  finally
    NewBmp.Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  bmSig: TBitMap;
begin
  bmSig:= TBitmap.Create;
  try
    bmSig.Assign(Image1.Picture.Bitmap);
    CombineAndSaveJPG(Image1.Picture.Bitmap, Image2.Picture.Bitmap,'combine.jpg');
    Image2.Picture.Bitmap.Width := Max(Image1.Picture.Bitmap.Width,bmSig.Width);
    Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height + bmSig.Height;
    Image2.Picture.Bitmap.Canvas.Draw(0, 0,bmSig);
    Image2.Picture.Bitmap.Canvas.Draw(0, BmSig.height,Image1.Picture.Bitmap);
    Image2.Picture.Bitmap.Height:= 400;
  finally
    bmSig.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  bmSig: TBitMap;
  MyFormat : Word;
  AData: THandle;
  APalette: HPalette;
begin
  bmSig := TBitmap.Create;
  try
    bmSig.Assign(Image1.Picture.Graphic);
    //bmSig.Height:= bmSig.Height;
    image2.Picture.Bitmap.Canvas.CopyMode:= cmMergeCopy ;
    Image2.Picture.Bitmap.Width := Max(Image1.Picture.bitmap.Width, bmSig.Width);
    //Image2.Picture.Bitmap.Height := Image1.Picture.bitmap.Height + bmSig.Height;
    Image2.Picture.Bitmap.Canvas.Draw(0, BmSig.height, Image1.Picture.bitmap);
    image2.Picture.Bitmap.Canvas.CopyMode:= cmSrcAnd;
    Image2.Picture.Bitmap.Canvas.Draw(0, 0,bmSig);

    // Signature Create
    //Image2.Picture.Bitmap.Canvas.TextOut(75,80,Edit1.Text+' '+'Dated '+ Edit2.text);
    //Image2.Picture.Bitmap.Canvas.TextOut(75,95,Edit3.Text);
    //Image2.Picture.Bitmap.Canvas.TextOut(75,110,'Signature Verified');
    //Image2.Picture.SaveToClipboardFormat(MyFormat,AData,APalette);
    //ClipBoard.SetAsHandle(MyFormat,AData);
  finally
    bmSig.Free;
  end; // try..finally
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  bmSig: TBitMap;
begin
  try
    bmSig:= TBitmap.Create;
    if OpenDialog1.Execute then
    begin
      Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
      bmSig.Assign(Image1.Picture.Graphic);
      bmSig := Image1.Picture.Bitmap;

      if (Image1.Height <> Image2.Height) and (Image1.Width <> Image2.Width) then
      begin
        Beep;
        ShowMessage('The image is not the same size as the other one.');
      end;
    end;
  finally
    StatusBar1.Panels[3].Text := IntToStr(Image1.Picture.Bitmap.Height) +'x'+
                                 IntToStr(Image1.Picture.Bitmap.Width);
    //bmSig.Free; // do not use
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  if SaveDialog1.Execute then
  begin
  try
    bmp := TBitmap.Create;
    bmp.Assign(Image2.Picture.Bitmap);
    bmp.PixelFormat := pf24bit;
    bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
  finally
    bmp.Free;
    end;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image2.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    StatusBar1.Panels[1].Text := IntToStr(Image2.Picture.Bitmap.Height) +'x'+
                                 IntToStr(Image2.Picture.Bitmap.Width);

    if (Image2.Height <> Image1.Height) and (Image2.Width <> Image1.Width) then
    begin
      Beep;
      ShowMessage('The image is not the same size as the other one.');
    end;
  end;
end;

end.
