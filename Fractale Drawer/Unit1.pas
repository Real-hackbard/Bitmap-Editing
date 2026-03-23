unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, ClipBrd, System.ImageList, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.ExtDlgs, Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Samples.Spin, Vcl.ToolWin;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    SpinEdit1: TSpinEdit;
    Image1: TImage;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Copierlimage1: TMenuItem;
    Enregistrerlimage1: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    StatusBar1: TStatusBar;
    N1: TMenuItem;
    P1: TMenuItem;
    ColorDialog1: TColorDialog;
    SpeedButton2: TSpeedButton;
    procedure TracerVague(xA, yA, xB, yB, p : Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Enregistrerlimage1Click(Sender: TObject);
    procedure Copierlimage1Click(Sender: TObject);
    procedure FormConstrainedResize(Sender: TObject; var MinWidth,
      MinHeight, MaxWidth, MaxHeight: Integer);
    procedure SpinEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure P1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;
  bmp : TBitmap;
  Lbl : TLabel;

implementation

{$R *.dfm}

procedure TForm1.TracerVague(xA, yA, xB, yB, p : Integer);
var
  xC, yC, xD, yD, xM, yM : Integer;
begin
  if p = 0 then bmp.Canvas.LineTo(xB, yB)
  else begin
    xM := round((xA + xB)/2);
    yM := round((yA + yB)/2);
    xC := round(xA + (xM - xA)/2 - (yM - yA)/2);
    yC := round(yA + (yM - yA)/2 + (xM - xA)/2);
    xD := round(xB + (xM - xB)/2 - (yM - yB)/2);
    yD := round(yB + (yM - yB)/2 + (xM - xB)/2);
    Dec(p);
    TracerVague(xA, yA, xC, yC, p);
    TracerVague(xC, yC, xD, yD, p);
    TracerVague(xD, yD, xB, yB, p);
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
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
    bmp.Canvas.Pen.Color := ColorDialog1.Color;
    bmp.Canvas.PenPos := Point(Label1.Left+3, Label1.Top+7);
    TracerVague(Label1.Left+3, Label1.Top+7, Label2.Left+3, Label2.Top+7, SpinEdit1.Value);
    Image1.Picture.Assign(bmp);
  finally
    bmp.Free;
  end;
  QueryPerformanceCounter(t);
  StatusBar1.Panels[0].Text :=  FormatFloat('0.000 ms', (t-t0)/f*1000);
  PopupMenu1.AutoPopup := true;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  ColorDialog1.Execute;
end;

procedure TForm1.Label1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Lbl := TLabel(Sender);
  Timer1.Enabled := true;
end;

procedure TForm1.Label1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Timer1.Enabled := false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Lbl.Left := Mouse.CursorPos.X - Left - 8;
  Lbl.Top := Mouse.CursorPos.Y - Top - 62;
end;

procedure TForm1.Enregistrerlimage1Click(Sender: TObject);
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

procedure TForm1.P1Click(Sender: TObject);
begin
  Label1.Visible := P1.Checked;
  Label2.Visible := P1.Checked;
end;

end.
