unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button2: TButton;
    Button3: TButton;
    StatusBar1: TStatusBar;
    Image2: TImage;
    Label4: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label5: TLabel;
    Button4: TButton;
    ColorDialog1: TColorDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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
{$R-}
procedure TColor2RGB(const Color: TColor; var R, G, B: Byte);
begin
  // convert hexa-decimal values to RGB
  R := Color and $FF;
  G := (Color shr 8) and $FF;
  B := (Color shr 16) and $FF;

  //Form1.SpinEdit1.Value := R;
end;

function SetRGBChannelValue(Bitmap: TBitmap; Red, Green, Blue: Integer): Boolean;
var
  i, j: Integer;
  rgbc: array[0..2] of Byte;
  c: TColor;
  r, g, b: Byte;
begin
  Screen.Cursor := crHourGlass;
  //If there is no change, exit:
  if (Red = 0) and (Green = 0) and (Blue = 0) then
  begin
    Result := False;
    Exit;
  end;

  for i := 0 to Bitmap.Height do
  begin
    for j := 0 to Bitmap.Width do
    begin
      // Get the old Color
      c := Bitmap.Canvas.Pixels[j, i];
      // Splitt the old color into the different colors:
      rgbc[0] := GetRValue(c);
      rgbc[1] := GetGValue(c);
      rgbc[2] := GetBValue(c);

      //Check that there is no "new" color while the addition
      //of the values:
      if not (rgbc[0] + Red < 0) and not (rgbc[0] + Red > 255) then
        rgbc[0] := rgbc[0] + Red;
      if not (rgbc[1] + Green < 0) and not (rgbc[1] + Green > 255) then
        rgbc[1] := rgbc[1] + Green;
      if not (rgbc[2] + Blue < 0) and not (rgbc[2] + Blue > 255) then
        rgbc[2] := rgbc[2] + Blue;

      r := rgbc[0];
      g := rgbc[1];
      b := rgbc[2];

      //set the new color back to the picture:
      Bitmap.Canvas.Pixels[j, i] := RGB(r, g, b);
    end;
  end;
  Result := True;
  Form1.StatusBar1.Panels[0].Text := 'finish';
  Screen.Cursor := crDefault;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := 'Calculating, please wait..';
  Application.ProcessMessages;
  Image1.Picture.Bitmap.Assign(Image2.Picture.Bitmap);

  SetRGBChannelValue(Image1.picture.Bitmap, SpinEdit1.Value,
                                            SpinEdit2.Value,
                                            SpinEdit3.Value);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    Image2.Picture.Bitmap.Assign(Image1.Picture.Bitmap);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  R, G, B : Byte;
begin
  if ColorDialog1.Execute then
  begin
    TColor2RGB(ColorDialog1.Color, R, G, B);
    SpinEdit1.Value := R;
    SpinEdit2.Value := G;
    SpinEdit3.Value := B;
  end;
end;

end.
