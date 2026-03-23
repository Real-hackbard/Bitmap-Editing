unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Vcl.ExtDlgs, Vcl.Menus, System.ImageList,
  Vcl.ImgList, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ToolWin, Vcl.Clipbrd;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    SpinEdit1: TSpinEdit;
    Image1: TImage;
    Panel1: TPanel;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Copierlimage1: TMenuItem;
    Enregistrerlimage1: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    StatusBar1: TStatusBar;
    SpeedButton2: TSpeedButton;
    ColorDialog1: TColorDialog;
    procedure TracerPoussiere(xA, xB, p : Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Enregistrerlimage1Click(Sender: TObject);
    procedure Copierlimage1Click(Sender: TObject);
    procedure FormConstrainedResize(Sender: TObject; var MinWidth,
      MinHeight, MaxWidth, MaxHeight: Integer);
    procedure SpinEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;
  bmp : TBitmap;
  y : Integer;

implementation

{$R *.dfm}
procedure TForm1.TracerPoussiere(xA, xB, p : Integer);
var
  xC, xD : Integer;
begin
  if p = 0 then bmp.Canvas.FillRect(Rect(xA, y, xB, y + 8))
  else begin
    xC := round(xA + (xB - xA)/3);
    xD := round(xB - (xB - xA)/3);
    Dec(p);
    TracerPoussiere(xA, xC, p);
    TracerPoussiere(xD, xB, p);
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  i : Integer;
  t0, t, f : Int64;
begin
  if ActiveControl = SpinEdit1 then ActiveControl := nil;
  PopupMenu1.AutoPopup := false;
  QueryPerformanceFrequency(f);
  QueryPerformanceCounter(t0);
  bmp := TBitmap.Create;
  try
    bmp.PixelFormat := pf24bit;
    bmp.Width := Image1.Width;
    bmp.Height := Image1.Height;
    bmp.Canvas.Brush.Color := ColorDialog1.Color;
    for i := 0 to SpinEdit1.Value do begin
      y := 17*i + 50;
      TracerPoussiere(3, Image1.Width - 3, i);
    end;
    Image1.Picture.Assign(bmp);
  finally
    bmp.Free;
  end;
  QueryPerformanceCounter(t);
  Caption := 'Cantor Dust';
  StatusBar1.Panels[0].Text := FormatFloat('0.000 ms', (t-t0)/f*1000);
  PopupMenu1.AutoPopup := true;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  ColorDialog1.Execute;
end;

procedure TForm1.Enregistrerlimage1Click(Sender: TObject);
var
  F : String;
begin
  if SavePictureDialog1.Execute then Image1.Picture.SaveToFile(SavePictureDialog1.FileName);
end;

procedure TForm1.Copierlimage1Click(Sender: TObject);
begin
  ClipBoard.Assign(Image1.Picture);
end;

procedure TForm1.FormConstrainedResize(Sender: TObject; var MinWidth,
  MinHeight, MaxWidth, MaxHeight: Integer);
begin
  MinWidth := 169;
  MinHeight := 198;
end;

procedure TForm1.SpinEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key in ['-', '+', FormatSettings.DecimalSeparator]) then begin
    Key := #0;
    Beep;
  end;
end;

end.
