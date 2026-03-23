unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, System.ImageList, Vcl.ImgList,
  Vcl.ExtDlgs, Vcl.Menus, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ToolWin, Vcl.Clipbrd;

type
  TRGBArray = ARRAY[0..0] OF TRGBTriple;
  pRGBArray = ^TRGBArray;
  TForm1 = class(TForm)
    Image1: TImage;
    ToolBar1: TToolBar;
    SpinEdit1: TSpinEdit;
    SpeedButton1: TSpeedButton;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    Copierlimage1: TMenuItem;
    Enregistrerlimage1: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    SpeedButton2: TSpeedButton;
    ImageList1: TImageList;
    ColorDialog1: TColorDialog;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    StatusBar1: TStatusBar;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Copierlimage1Click(Sender: TObject);
    procedure Enregistrerlimage1Click(Sender: TObject);
    procedure FormConstrainedResize(Sender: TObject; var MinWidth,
      MinHeight, MaxWidth, MaxHeight: Integer);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpinEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Declarations privates }
  public
    { Declarations public }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{$R-}

{procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  i, j, degre : Integer;
  triangle : Array of Array of Boolean;
  bmp : TBitmap;
  P : pRGBArray;
  t0, t1, f : Int64;
begin
  if ActiveControl = SpinEdit1 then ActiveControl := nil;
  PopupMenu1.AutoPopup := false;
  StaticText1.Hide;
  QueryPerformanceFrequency(f);
  QueryPerformanceCounter(t0);
  degre := SpinEdit1.Value;
  if ClientWidth < degre+4 then ClientWidth := degre+4;
  if ClientHeight < degre+33 then ClientHeight := degre+33;
  SetLength(triangle, degre, degre);
  triangle[0, 0] := true;
  for i := 1 to degre-1 do begin
    triangle[i, 0] := true;
    for j := 1 to i-1 do triangle[i, j] := triangle[i-1, j-1] xor triangle[i-1, j];
    triangle[i, i] := true;
  end;
  bmp := TBitmap.Create;
  try
    bmp.PixelFormat := pf24bit;
    bmp.Width := degre;
    bmp.Height := degre;
    for j := 0 to degre-1 do begin
      P := bmp.Scanline[j];
      for i := 0 to degre-1 do begin
        if triangle[j, i] then begin
          P[i].rgbtRed := 255;
          P[i].rgbtGreen := 0;
          P[i].rgbtBlue := 0;
        end
        else begin
          P[i].rgbtRed := 255;
          P[i].rgbtGreen := 255;
          P[i].rgbtBlue := 255;
        end;
      end;
    end;
    Image1.Picture.Assign(bmp);
  finally
    bmp.Free;
  end;
  QueryPerformanceCounter(t1);
  Caption := 'Sierpinski'+FormatFloat('0.000 ms', (t1-t0)/f*1000);
  StaticText1.Show;
  PopupMenu1.AutoPopup := true;
end;}

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  i, j, degre : Integer;
  triangle : Array of Boolean;
  bmp : TBitmap;
  P : pRGBArray;
  t0, t1, f : Int64;
begin
  if ActiveControl = SpinEdit1 then ActiveControl := nil;
  PopupMenu1.AutoPopup := false;
  QueryPerformanceFrequency(f);
  QueryPerformanceCounter(t0);
  degre := SpinEdit1.Value;
  ClientWidth := degre+4;
  ClientHeight := degre+33;
  SetLength(triangle, degre+2);
  triangle[0] := true;
  bmp := TBitmap.Create;
  try
    bmp.PixelFormat := pf24bit;
    bmp.Width := degre+1;
    bmp.Height := degre;
  for i := 1 to degre do begin
    P := bmp.Scanline[i-1];
    triangle[0] := true;

    P[0].rgbtRed := 0;
    P[0].rgbtGreen := 0;
    P[0].rgbtBlue := 0;

    for j := i downto 1 do begin
      if triangle[j] then begin
      P[j].rgbtRed := SpinEdit2.Value;
        P[j].rgbtGreen := SpinEdit3.Value;
        P[j].rgbtBlue := SpinEdit4.Value;
      end;
      triangle[j] := triangle[j-1] xor triangle[j];
    end;
  end;
    Image1.Picture.Assign(bmp);
  finally
    bmp.Free;
  end;
  QueryPerformanceCounter(t1);
  StatusBar1.Panels[0].Text := FormatFloat('0.000 ms', (t1-t0)/f*1000);
  PopupMenu1.AutoPopup := true;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Panel1.DoubleBuffered := true;
end;

procedure TForm1.Copierlimage1Click(Sender: TObject);
begin
  Clipboard.Assign(Image1.Picture);
end;

procedure TForm1.Enregistrerlimage1Click(Sender: TObject);
begin
  if SavePictureDialog1.Execute then Image1.Picture.SaveToFile(SavePictureDialog1.FileName);
end;

procedure TForm1.FormConstrainedResize(Sender: TObject; var MinWidth,
  MinHeight, MaxWidth, MaxHeight: Integer);
begin
  MinWidth := 305;
  MinHeight := 316;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  a, b : Array[0..2] of Integer;
  x, y, k, i : Integer;
  bmp : TBitmap;
  P : pRGBArray;
  t0, t1, f : Int64;
begin
  QueryPerformanceFrequency(f);
  QueryPerformanceCounter(t0);
  a[0] := 0;
  a[1] := Image1.Width;
  a[2] := a[1] div 2;
  b[0] := Image1.Height-2;
  b[1] := b[0];
  b[2] := 0;
  x := a[0];
  y := b[0];
  Randomize;
  bmp := TBitmap.Create;
  try
    bmp.PixelFormat := pf24bit;
    bmp.Width := a[1]+1;
    bmp.Height := b[0]+1;

    for i := 0 to sqr(SpinEdit1.Value) do begin
      k := Random(3);
      x := (x + a[k]) div 2;
      y := (y + b[k]) div 2;
      P := bmp.ScanLine[y];
      P[x].rgbtRed := SpinEdit2.Value;
      P[x].rgbtGreen := SpinEdit3.Value;
      P[x].rgbtBlue := 0;
    end;

    Image1.Picture.Assign(bmp);
  finally
    bmp.Free;
  end;
  QueryPerformanceCounter(t1);
  StatusBar1.Panels[0].Text := FormatFloat('0.000 ms', (t1-t0)/f*1000);
  PopupMenu1.AutoPopup := true;
end;

procedure TForm1.SpinEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key in ['-', '+', FormatSettings.DecimalSeparator]) then begin
    Key := #0;
    Beep;
  end;
end;

end.
