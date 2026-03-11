unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Label1: TLabel;
    StatusBar1: TStatusBar;
    CheckBox1: TCheckBox;
    GroupBox1: TGroupBox;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox2: TCheckBox;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    ColorDialog1: TColorDialog;
    ColorDialog2: TColorDialog;
    OpenDialog1: TOpenDialog;
    SpinEdit3: TSpinEdit;
    Label6: TLabel;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    BmpH, BmpV : TBitmap;
    OldX, OldY: Integer;
    procedure Cross(X, Y: Integer);
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  RectSaved : boolean = false;

implementation

{$R *.dfm}
procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.Cross(X, Y: Integer);
begin
  Image1.Canvas.Pen.Color := Shape1.Brush.Color;
  Image1.Canvas.Pen.Width := SpinEdit3.Value;

  // Restore last image to erase line
  if RectSaved then
  begin
    Image1.Canvas.CopyRect(Rect(OldX - 5, 0, OldX + 5, BmpV.Height),
    BmpV.Canvas, Rect(0,0,BmpV.Width,BmpV.Height));
    Image1.Canvas.CopyRect(Rect(0, OldY - 5, BmpH.Width, OldY + 5),
    BmpH.Canvas, Rect(0,0,BmpH.Width,BmpH.Height));
    BmpH.Free;
    BmpV.Free;
  end;
  // Now save the image at new position for each line
  // horizontal line
  BmpH := TBitmap.Create;
    BmpH.Width := Image1.Width;
    BmpH.Height := 10;
    BmpH.Canvas.CopyRect(Rect(0,0,BmpH.Width,BmpH.Height),
                  Image1.Canvas,Rect(0, Y - 5, BmpH.Width, Y + 5));

  // Vertical line
  BmpV := TBitmap.Create;
  BmpV.Width := 10;
  BmpV.Height := Image1.Height;
  BmpV.Canvas.CopyRect(Rect(0,0,BmpV.Width,BmpV.Height),
                 Image1.Canvas,Rect(X - 5, 0, X + 5, BmpV.Height));

  // Now draw the current position
  if CheckBox2.Checked = true then
  begin
    if CheckBox3.Checked = true then
    begin
      Image1.Canvas.MoveTo(0, Y);
      Image1.Canvas.LineTo(Image1.Width, Y);
    end;

    if CheckBox4.Checked = true then
    begin
      Image1.Canvas.MoveTo(X, 0);
      Image1.Canvas.LineTo(X, Image1.Height);
    end;
  end;

  RectSaved := true;
  OldX := X;
  OldY := Y;

  if CheckBox1.Checked = true then
  begin
    Label1.Left := X + SpinEdit1.Value;
    Label1.Top := Y - SpinEdit2.Value;;
    Label1.Caption := '(X:' + IntToStr(X) + ' x Y:' + IntToStr(Y) +')';
  end;

  StatusBar1.Panels[1].Text := '(X:' + IntToStr(X) + ' x Y:' + IntToStr(Y) +')';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // This prevents that the image is blinking
  DoubleBuffered := true;
  Label1.Transparent := true;
  Label1.Font.Color := Shape2.Brush.Color;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Cross(X, Y);
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  StatusBar1.Panels[3].Text := '(X:' + IntToStr(X) + ' x Y:' + IntToStr(Y) +')';
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Cross(X, Y);
end;

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
    Shape1.Brush.Color := ColorDialog1.Color;
end;

procedure TForm1.Shape2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog2.Execute then
  begin
    Shape2.Brush.Color := ColorDialog2.Color;
    Label1.Font.Color := Shape2.Brush.Color;
  end;
end;

end.
