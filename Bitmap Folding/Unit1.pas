unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Button2: TButton;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    SpinEdit6: TSpinEdit;
    SpinEdit7: TSpinEdit;
    SpinEdit8: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    SpinEdit9: TSpinEdit;
    SpinEdit10: TSpinEdit;
    Label9: TLabel;
    Label10: TLabel;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  pic : TBitmap;

type
  TRGBTripleArray = array[0..10000] of TRGBTriple;
  PRGBTripleArray = ^TRGBTripleArray;

  T3x3FloatArray = array[0..2] of array[0..2] of Extended;

implementation

{$R *.dfm}
function Convolve(ABitmap: TBitmap; AMask: T3x3FloatArray;
  ABias: Integer): TBitmap;
var
  LRow1, LRow2, LRow3, LRowOut: PRGBTripleArray;
  LRow, LCol: integer;
  LNewBlue, LNewGreen, LNewRed: Extended;
  LCoef: Extended;
begin
  LCoef := 0;
  for LRow := 0 to 2 do
    for LCol := 0 to 2 do
      LCoef := LCoef + AMask[LCol, LRow];
  if LCoef = 0 then LCoef := 1;

  Result := TBitmap.Create;

  Result.Width := ABitmap.Width - 2;
  Result.Height := ABitmap.Height - 2;
  Result.PixelFormat := pf24bit;

  LRow2 := ABitmap.ScanLine[0];
  LRow3 := ABitmap.ScanLine[1];

  for LRow := 1 to ABitmap.Height - 2 do 
  begin
    LRow1 := LRow2;
    LRow2 := LRow3;
    LRow3 := ABitmap.ScanLine[LRow + 1];

    LRowOut := Result.ScanLine[LRow - 1];

    for LCol := 1 to ABitmap.Width - 2 do 
    begin
      LNewBlue :=
        (LRow1[LCol - 1].rgbtBlue * AMask[0,0]) + (LRow1[LCol].rgbtBlue * AMask[1,0]) +
        (LRow1[LCol + 1].rgbtBlue * AMask[2,0]) +
        (LRow2[LCol - 1].rgbtBlue * AMask[0,1]) + (LRow2[LCol].rgbtBlue * AMask[1,1]) +
        (LRow2[LCol + 1].rgbtBlue * AMask[2,1]) +
        (LRow3[LCol - 1].rgbtBlue * AMask[0,2]) + (LRow3[LCol].rgbtBlue * AMask[1,2]) +
        (LRow3[LCol + 1].rgbtBlue * AMask[2,2]);
      LNewBlue := (LNewBlue / LCoef) + ABias;
      if LNewBlue > 255 then
        LNewBlue := 255;
      if LNewBlue < 0 then
        LNewBlue := 0;

      LNewGreen :=
        (LRow1[LCol - 1].rgbtGreen * AMask[0,0]) + (LRow1[LCol].rgbtGreen * AMask[1,0]) +
        (LRow1[LCol + 1].rgbtGreen * AMask[2,0]) +
        (LRow2[LCol - 1].rgbtGreen * AMask[0,1]) + (LRow2[LCol].rgbtGreen * AMask[1,1]) +
        (LRow2[LCol + 1].rgbtGreen * AMask[2,1]) +
        (LRow3[LCol - 1].rgbtGreen * AMask[0,2]) + (LRow3[LCol].rgbtGreen * AMask[1,2]) +
        (LRow3[LCol + 1].rgbtGreen * AMask[2,2]);
      LNewGreen := (LNewGreen / LCoef) + ABias;
      if LNewGreen > 255 then
        LNewGreen := 255;
      if LNewGreen < 0 then
        LNewGreen := 0;

      LNewRed :=
        (LRow1[LCol - 1].rgbtRed * AMask[0,0]) + (LRow1[LCol].rgbtRed * AMask[1,0])
        + (LRow1[LCol + 1].rgbtRed * AMask[2,0]) +
        (LRow2[LCol - 1].rgbtRed * AMask[0,1]) + (LRow2[LCol].rgbtRed * AMask[1,1])
        + (LRow2[LCol + 1].rgbtRed * AMask[2,1]) +
        (LRow3[LCol - 1].rgbtRed * AMask[0,2]) + (LRow3[LCol].rgbtRed * AMask[1,2])
        + (LRow3[LCol + 1].rgbtRed * AMask[2,2]);
      LNewRed := (LNewRed / LCoef) + ABias;
      if LNewRed > 255 then
        LNewRed := 255;
      if LNewRed < 0 then
        LNewRed := 0;

      LRowOut[LCol - 1].rgbtBlue  := trunc(LNewBlue);
      LRowOut[LCol - 1].rgbtGreen := trunc(LNewGreen);
      LRowOut[LCol - 1].rgbtRed   := trunc(LNewRed);
    end;
  end;
end;
procedure TForm1.Button1Click(Sender: TObject);
var
  LMask: T3x3FloatArray;
begin
  LMask[0,0] := SpinEdit1.Value;
  LMask[1,0] := SpinEdit2.Value;
  LMask[2,0] := SpinEdit3.Value;
  LMask[0,1] := SpinEdit4.Value;
  LMask[1,1] := SpinEdit9.Value;
  LMask[2,1] := SpinEdit5.Value;
  LMask[0,2] := SpinEdit6.Value;
  LMask[1,2] := SpinEdit7.Value;
  LMask[2,2] := SpinEdit8.Value;
  Image1.Picture.Bitmap := Convolve(Image1.Picture.Bitmap, LMask, SpinEdit10.Value);
end;
procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    pic.Assign(Image1.Picture.Bitmap);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Image1.Picture.Bitmap.Assign(pic);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  pic.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  try
    pic := TBitmap.Create;
    pic.Assign(Image1.Picture.Bitmap);
  except
    on E : Exception do
      ShowMessage(E.Message);
  end;
end;

end.
