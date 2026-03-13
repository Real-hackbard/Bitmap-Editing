unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    ColorDialog1: TColorDialog;
    FontDialog1: TFontDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Shape1: TShape;
    Edit1: TEdit;
    Button3: TButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label9: TLabel;
    Label10: TLabel;
    ComboBox1: TComboBox;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    Edit2: TEdit;
    CheckBox1: TCheckBox;
    Label8: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Shape2: TShape;
    Button4: TButton;
    SaveDialog1: TSaveDialog;
    ComboBox2: TComboBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label4: TLabel;
    Shape3: TShape;
    ColorDialog2: TColorDialog;
    Label15: TLabel;
    Shape4: TShape;
    ColorDialog3: TColorDialog;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Shape3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox1Change(Sender: TObject);
    procedure Shape4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
Procedure VerticalText(Rotation, x, y: Integer; aText: String; aCanvas: TCanvas);
Var
  aFt: LOGFONT;
  hOldFont: THandle;
Begin
  hOldFont := aCanvas.Font.Handle;
  Try
    // Must be TrueType
    aCanvas.Font.Name := Form1.Label6.Caption;
    aCanvas.Font.Size := StrToInt(Form1.Label7.Caption);
    aCanvas.Font.Color := Form1.Shape2.Brush.Color;

    Form1.Image1.Picture.Bitmap.Canvas.Brush.Color := Form1.Shape4.Brush.Color;

    if Form1.CheckBox3.Checked = true then
    begin
      aCanvas.Font.Style := aCanvas.Font.Style + [fsBold];
      Form1.FontDialog1.Font.Style := Form1.FontDialog1.Font.Style + [fsBold];
    end else begin
      aCanvas.Font.Style := aCanvas.Font.Style + [];
      Form1.FontDialog1.Font.Style := Form1.FontDialog1.Font.Style + [];
    end;

    case Form1.ComboBox1.ItemIndex of
      0 : Form1.Image1.Picture.Bitmap.Canvas.Brush.Style := bsClear;
      1 : Form1.Image1.Picture.Bitmap.Canvas.Brush.Style := bsSolid;
    end;

    GetObject(aCanvas.Font.Handle, SizeOf(aFt), @Aft);

    // Rotate is the angle in degrees
    aFt.lfEscapement := 10 * Rotation;
    aFt.lfOrientation := aft.lfEscapement;

    if Form1.CheckBox1.Checked = true then
    begin
      aFt.lfQuality := ANTIALIASED_QUALITY;
    end;

    aCanvas.Font.Handle := CreateFontIndirect(aFt);
    aCanvas.TextOut(x, y, aText);
  Finally
    DeleteObject(aCanvas.Font.Handle);
    aCanvas.Font.Handle := hOldFont;
  End;
End;

procedure TForm1.Button1Click(Sender: TObject);
begin
  with Image1.Picture.Bitmap.Canvas do
  begin

    if Form1.CheckBox2.Checked = false then
    begin
      Image1.Picture.Bitmap.Canvas.Brush.Color := clWhite;
    end;

    Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
    Font.Name   := Label6.Caption;
    Font.Size   := StrToInt(Label7.Caption);
    Font.Color  := ColorDialog1.Color;
    Brush.Color := Shape3.Brush.Color;

    case ComboBox1.ItemIndex of
      0 : Brush.Style := bsClear;
      1 : Brush.Style := bsSolid;
    end;

    if Form1.CheckBox3.Checked = true then
    begin
      Font.Style := FontDialog1.Font.Style + [fsBold];
    end else begin
      Font.Style := FontDialog1.Font.Style + [];
    end;

    TextOut(SpinEdit1.Value, SpinEdit2.Value, Edit1.Text);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form1.FontDialog1.Font.Size := StrToInt(Form1.Label7.Caption);
  Form1.FontDialog1.Font.Name := Form1.Label6.Caption;

  if CheckBox2.Checked = true then
  begin
    //Image1.Picture.Bitmap.Canvas.Brush.Color := clWhite;
    Image1.Canvas.Rectangle(0,0, Image1.Width,Image1.Height);
    VerticalText(SpinEdit3.Value, SpinEdit4.Value,
               SpinEdit5.Value, Edit2.Text,
               Image1.Canvas);
  end else begin
    Image1.Picture.Bitmap.Canvas.Brush.Color := clWhite;
    Image1.Canvas.Rectangle(0,0, Image1.Width,Image1.Height);
    VerticalText(SpinEdit3.Value, SpinEdit4.Value,
               SpinEdit5.Value, Edit2.Text,
               Image1.Canvas);
  end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    Label6.Caption := FontDialog1.Font.Name;
    Label7.Caption := IntToStr(FontDialog1.Font.Size);
    Button1.Enabled := true;
    Button2.Enabled := true;
    Button4.Enabled := true;
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
     bmp.Assign(Image1.Picture.Bitmap);

       case ComboBox2.ItemIndex of
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

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  Button2.Click;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  //FontDialog1.Font.Style := FontDialog1.Font.Style + [fsBold];
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.ItemIndex = 1 then
  begin
    CheckBox2.Checked := false;
    CheckBox2.Enabled := false;
  end else begin
    CheckBox2.Enabled := true;
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  with FontDialog1 do
  begin
    Font.Size := 24;
    Font.Name := 'Impact';
    Font.Style := FontDialog1.Font.Style + [];
  end;

  ColorDialog1.Color    := clGray;
  Image1.Canvas.Brush.Color := clWhite;
  Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
end;

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
    Shape1.Brush.Color := ColorDialog1.Color;
  Button1.Click;
end;

procedure TForm1.Shape2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
    Shape2.Brush.Color := ColorDialog1.Color;
  Button2.Click;
end;

procedure TForm1.Shape3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog2.Execute then
    Shape3.Brush.Color := ColorDialog2.Color;
  Button1.Click;
end;

procedure TForm1.Shape4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog3.Execute then
    Shape4.Brush.Color := ColorDialog3.Color;
  Button2.Click;
end;

end.
