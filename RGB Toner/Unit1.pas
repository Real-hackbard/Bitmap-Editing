unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ComboBox1: TComboBox;
    Label7: TLabel;
    CheckBox1: TCheckBox;
    SpinEdit1: TSpinEdit;
    Button2: TButton;
    procedure ScrollBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  bmp : TBitmap;

type
  PixArray = Array [0..2] of Byte;

implementation

{$R *.dfm}
procedure Antialiasing(Bitmap: TBitmap; Rect: TRect; Percent: Integer);
var
  pix, prevscan, nextscan, hpix: ^PixArray;
  l, p: Integer;
  R, G, B: Integer;
  R1, R2, G1, G2, B1, B2: Byte;
begin
  Bitmap.PixelFormat := pf24bit;
  with Bitmap.Canvas do
  begin
    Brush.Style := bsclear;
    for l := Rect.Top to Rect.Bottom - 1 do
    begin
      pix:= Bitmap.ScanLine[l];
      if l <> Rect.Top then prevscan := Bitmap.ScanLine[l-1]
      else prevscan := nil;
      if l <> Rect.Bottom - 1 then nextscan := Bitmap.ScanLine[l+1]
      else nextscan := nil;

      for p := Rect.Left to Rect.Right - 1 do
      begin
        R1 := pix^[2];
        G1 := pix^[1];
        B1 := pix^[0];

        if p <> Rect.Left then
        begin
          //Pixel links
          //Pixel left

          hpix := pix;
          dec(hpix);
          R2 := hpix^[2];
          G2 := hpix^[1];
          B2 := hpix^[0];

          if (R1 <> R2) or (G1 <> G2) or (B1 <> B2) then
          begin
            R := R1 + (R2 - R1) * 50 div (Percent + 50);
            G := G1 + (G2 - G1) * 50 div (Percent + 50);
            B := B1 + (B2 - B1) * 50 div (Percent + 50);
            hpix^[2] := R;
            hpix^[1] := G;
            hpix^[0] := B;
          end;
        end;

        if p <> Rect.Right - 1 then
        begin
          //Pixel rechts
          //Pixel right
          hpix := pix;
          inc(hpix);
          R2 := hpix^[2];
          G2 := hpix^[1];
          B2 := hpix^[0];

          if (R1 <> R2) or (G1 <> G2) or (B1 <> B2) then
          begin
            R := R1 + (R2 - R1) * 50 div (Percent + 50);
            G := G1 + (G2 - G1) * 50 div (Percent + 50);
            B := B1 + (B2 - B1) * 50 div (Percent + 50);
            hpix^[2] := R;
            hpix^[1] := G;
            hpix^[0] := B;
          end;
        end;

        if prevscan <> nil then
        begin
          //Pixel oben
          //Pixel up
          R2 := prevscan^[2];
          G2 := prevscan^[1];
          B2 := prevscan^[0];

          if (R1 <> R2) or (G1 <> G2) or (B1 <> B2) then
          begin
            R := R1 + (R2 - R1) * 50 div (Percent + 50);
            G := G1 + (G2 - G1) * 50 div (Percent + 50);
            B := B1 + (B2 - B1) * 50 div (Percent + 50);
            prevscan^[2] := R;
            prevscan^[1] := G;
            prevscan^[0] := B;
          end;
          Inc(prevscan);
        end;

        if nextscan <> nil then
        begin
          //Pixel unten
          //Pixel down
          R2 := nextscan^[2];
          G2 := nextscan^[1];
          B2 := nextscan^[0];

          if (R1 <> R2) or (G1 <> G2) or (B1 <> B2) then
          begin
            R := R1 + (R2 - R1) * 50 div (Percent + 50);
            G := G1 + (G2 - G1) * 50 div (Percent + 50);
            B := B1 + (B2 - B1) * 50 div (Percent + 50);
            nextscan^[2] := R;
            nextscan^[1] := G;
            nextscan^[0] := B;
          end;
          Inc(nextscan);
        end;
        Inc(pix);
      end;
    end;
  end;
end;

procedure Tone(Bit: TBitmap; r, g, b: Integer);
type
  PixArray = array[1..4] of Byte;

var
  p: ^PixArray;
  h, w: Integer;
begin
  Screen.Cursor := crHourGlass;
  Bit.Pixelformat := pf32bit;
  for h := 0 to Bit.Height - 1 do
  begin
    p := Bit.ScanLine[h];
    for w := 0 to Bit.Width - 1 do
    begin
      if (round(p^[1] * (1 + b / 100)) < 0) then p^[1] := 0 else
        if (round(p^[1] * (1 + b / 100)) > 255) then p^[1] := 255
        else p^[1] := round(p^[1] * (1 + b / 100));
      if (round(p^[2] * (1 + g / 100)) < 0) then p^[2] := 0 else
        if (round(p^[2] * (1 + g / 100)) > 255) then p^[2] := 255
        else p^[2] := round(p^[2] * (1 + g / 100));
      if (round(p^[3] * (1 + r / 100)) < 0) then p^[3] := 0 else
        if (round(p^[3] * (1 + r / 100)) > 255) then p^[3] := 255
        else p^[3] := round(p^[3] * (1 + r / 100));
        p^[4]:=0;
      Inc(p);
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    try
      Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
      bmp.Assign(Image1.Picture.Bitmap);

      case ComboBox1.ItemIndex of
      0 : bmp.PixelFormat := pf4bit;
      1 : bmp.PixelFormat := pf8bit;
      2 : bmp.PixelFormat := pf16bit;
      3 : bmp.PixelFormat := pf24bit;
      4 : bmp.PixelFormat := pf32bit;
      end;

      Image1.Picture.Bitmap.Assign(bmp);

      ScrollBar1.Position := 0;
      ScrollBar2.Position := 0;
      ScrollBar3.Position := 0;
    except
      on E : Exception do
        ShowMessage(E.Message);
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  pic : TBitmap;
begin
  if SaveDialog1.Execute then
  begin
    try
      pic := TBitmap.Create;
      pic.Assign(Image1.Picture.Bitmap);

      case ComboBox1.ItemIndex of
      0 : pic.PixelFormat := pf4bit;
      1 : pic.PixelFormat := pf8bit;
      2 : pic.PixelFormat := pf16bit;
      3 : pic.PixelFormat := pf24bit;
      4 : pic.PixelFormat := pf32bit;
      end;

      pic.SaveToFile(SaveDialog1.FileName + '.bmp');
    finally
      pic.Free;
    end;
  end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  SpinEdit1.Enabled := CheckBox1.Checked;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bmp.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  try
    bmp := TBitmap.Create;
    bmp.Assign(Image1.Picture.Bitmap);
    bmp.PixelFormat := pf24bit;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;

end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
var
  AA : TBitmap;
begin
  try
    Image1.Picture.Bitmap.Assign(bmp);

    if CheckBox1.Checked = true then begin
    try
    AA := TBitmap.Create;
    AA.Assign(bmp);
    Antialiasing(AA,
      Rect(0, 0, AA.Width, AA.Height), 15);
    Image1.Picture.Bitmap.Assign(AA);
    finally
    AA.Free;
    end;
    end;


    Tone(Image1.Picture.Bitmap,
          Scrollbar1.Position,
          Scrollbar2.Position,
          Scrollbar3.Position);
    Label4.Caption := IntToStr(ScrollBar1.Position) + ' %';
  except
    on E : Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
  try
    Image1.Picture.Bitmap.Assign(bmp);
    Tone(Image1.Picture.Bitmap,
          Scrollbar1.Position,
          Scrollbar2.Position,
          Scrollbar3.Position);
    Label5.Caption := IntToStr(ScrollBar2.Position) + ' %';
  except
    on E : Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TForm1.ScrollBar3Change(Sender: TObject);
begin
  try
    Image1.Picture.Bitmap.Assign(bmp);
    Tone(Image1.Picture.Bitmap,
          Scrollbar1.Position,
          Scrollbar2.Position,
          Scrollbar3.Position);
    Label6.Caption := IntToStr(ScrollBar3.Position) + ' %';
  except
    on E : Exception do
      ShowMessage(E.Message);
  end;
end;

end.
