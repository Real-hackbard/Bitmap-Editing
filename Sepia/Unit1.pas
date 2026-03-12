unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, jpeg, Vcl.Samples.Spin, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    SpinEdit1: TSpinEdit;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    SpinEdit2: TSpinEdit;
    Label2: TLabel;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
{$R-}
function bmptosepia(const bmp: TBitmap; depth: Integer): Boolean;
var
  color,color2:longint;
  r,g,b,rr,gg:byte;
  h,w:integer;
begin
  Screen.Cursor := crHourGlass;
  for h := 0 to Form1.SpinEdit3.Value do
  begin
    for w := 0 to Form1.SpinEdit4.Value do
    begin
      //first convert the bitmap to greyscale
      color:=colortorgb(bmp.Canvas.pixels[w,h]);
      r:=getrvalue(color);
      g:=getgvalue(color);
      b:=getbvalue(color);
      color2:=(r+g+b) div Form1.SpinEdit2.Value;
      bmp.canvas.Pixels[w,h] := RGB(color2,color2,color2);
      //then convert it to sepia
      color:=colortorgb(bmp.Canvas.pixels[w,h]);
      r:=getrvalue(color);
      g:=getgvalue(color);
      b:=getbvalue(color);
      rr:=r+(depth*2);
      gg:=g+depth;

      if rr <= ((depth*2)-1) then
      rr:=255;

      if gg <= (depth-1) then
        gg:=255;
        bmp.canvas.Pixels[w,h]:=RGB(rr,gg,b);

      Form1.StatusBar1.Panels[0].Text := '   (R) : ' + IntToStr(RR) +
                                         '   (G) : ' + IntToStr(GG) +
                                         '   (B) : ' + IntToStr(B) +
                                         '   (Depth) : ' + IntToStr(Depth);
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  bmptosepia(Image1.Picture.Bitmap, SpinEdit1.Value);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Image1.Picture.Bitmap.Assign(pic);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    try
      pic := TBitmap.Create;
      pic.PixelFormat := pf24bit;
      pic.Assign(Image1.Picture.Bitmap);

      SpinEdit3.Value := Image1.Height;
      SpinEdit4.Value := Image1.Width;
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  try
    bmp := TBitmap.Create;
    bmp.Assign(Image1.Picture.Bitmap);
    bmp.PixelFormat := pf24bit;

    if SaveDialog1.Execute then
    begin
      bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
    end;
  finally
    bmp.Free;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  pic.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  try
    pic := TBitmap.Create;
    pic.PixelFormat := pf24bit;
    pic.Assign(Image1.Picture.Bitmap);
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

end.
