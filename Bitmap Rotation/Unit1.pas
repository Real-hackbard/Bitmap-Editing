unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, System.Math, UParallelogramme, ShellAPI,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    ImgPanel: TPanel;
    Image1: TImage;
    Timer1: TTimer;
    ButtonPanel: TPanel;
    SpeedLbl: TLabel;
    SpeedBar: TTrackBar;
    MinLbl: TLabel;
    MaxLbl: TLabel;
    MiddleLbl: TLabel;
    ChooseBitmapLbl: TLabel;
    BitmapList: TComboBox;
    SepBevel2: TBevel;
    PauseBtn: TButton;
    ColorDialog1: TColorDialog;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure SpeedBarChange(Sender: TObject);
    procedure BitmapListChange(Sender: TObject);
    procedure PauseBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Declarations privates }
  public
    { Declarations public }
    procedure ChangeBitmap;
    procedure ShowRectangle;
  end;

var
  Form1: TForm1;
  Rect: TParallelogramme;
  Angle: Integer;
  Bitmap: TBitmap;
  Speed: Integer;
  Color : TColor;

implementation

{$R *.dfm}
{$R-}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then Color := ColorDialog1.Color;
end;

procedure TForm1.ChangeBitmap;
Var
 Points: array [0..3] of TPoint;
begin
 Timer1.Enabled := False;

 Angle := 0;
 Bitmap := TBitmap.Create;
 Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) +
                    'Images\' + BitmapList.Text + '.bmp');

 Points[0].X := (Image1.ClientWidth div 2) - (Bitmap.Width div 2);
 Points[0].Y := (Image1.ClientHeight div 2) - (Bitmap.Height div 2);
 Points[1].X := Points[0].X + Bitmap.Width;
 Points[1].Y := Points[0].Y;
 Points[2].X := Points[1].X;
 Points[2].Y := Points[1].Y + Bitmap.Height;
 Points[3].X := Points[0].X;
 Points[3].Y := Points[0].Y + Bitmap.Height;

 if Assigned(Rect) then Rect.Free;
 Rect := TParallelogramme.Create(Points);

 Image1.Picture := nil;
 Timer1.Enabled := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  InitSCA;
  Speed := 3;
  //DoubleBuffered := True;
  ChangeBitmap;
  Color := clBlack;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Bitmap.Free;
 Rect.Free;
end;

function Clamp(Value: Integer): Integer;
begin
 if Value > 359 then Value := 0;
 Result := Value;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Image1.Canvas.Brush.Color:= Color;
  Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
  Inc(Angle, Speed);
  Clamp(Angle);
  Rect.Rotate(Speed);
  ShowRectangle;
end;

procedure TForm1.ShowRectangle;
Var
 Pts: array [0..2] of TPoint;
begin
 Pts[0] := Rect.Points[1];
 Pts[1] := Rect.Points[2];
 Pts[2] := Rect.Points[0];

 with Image1.Canvas, Rect do
  begin
   FillRect(Image1.ClientRect);
   PlgBlt(Handle, Pts, Bitmap.Canvas.Handle, 0, 0, Bitmap.Width, Bitmap.Height, 0, 0, 0);
  end;
end;

procedure TForm1.SpeedBarChange(Sender: TObject);
begin
 Speed := SpeedBar.Position;
end;

procedure TForm1.BitmapListChange(Sender: TObject);
begin
 ChangeBitmap;
end;

procedure TForm1.PauseBtnClick(Sender: TObject);
begin
 Timer1.Enabled := not Timer1.Enabled;
 case Timer1.Enabled of
  False: PauseBtn.Caption := 'Resume';
  True: PauseBtn.Caption := 'Pause';
 end;
end;

end.
