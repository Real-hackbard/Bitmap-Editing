unit Unit1;
{$R-}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, System.SyncObjs, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TPlasmaThread = class;

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Bevel1: TBevel;
    PaintBox1: TPaintBox;
    Button3: TButton;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Declarations privates}
    Plsm: TPlasmaThread;
  public
    { Declarations public}
  published
    { Declarations published }
  end;

  TPlasmaThread = class(TThread)
  private
    { Déclarations privates }
    Frame, Freq, FrameStart, FrameStop, FrameBegin, FrameEnd: int64;
    Instant, Average: Single;
    SleepTime: integer;
    Form: TForm1;
    TmpBmp: TBitmap;
    DrawBmp: TBitmap;
    SinTab: array[byte] of integer;
    i1, i2, j1, j2, c: integer;
    procedure CreateBmp;
    procedure Init;
    procedure Render;
    procedure DrawFPS(Canvas: TCanvas);
    procedure Draw;
    procedure Wait;
    procedure QueryPerf;
    function GetPal: HPalette;
  protected
    { Deklarationen protected }
  private
    { Private-Deklarationen}
  public
    { Public-Deklarationen}
    constructor Create(Form: TForm1);
    procedure Execute;override;
    destructor Destroy; override;
  end;

var
  Form1: TForm1;
  CanDraw: boolean;
  ShowStats: boolean;

const
  Mask: integer = $FF;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  CanDraw := true;
  ShowStats := true;
  Plsm := TPlasmaThread.Create(Self);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  CanDraw := false;
  Button1.Enabled := false;
  Button2.Enabled := true;
  Button3.Enabled := true;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  CanDraw := true;
  Button1.Enabled := true;
  Button2.Enabled := false;
  Button3.Enabled := false;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Bitmap: TBitmap;
begin
  if SaveDialog1.Execute then
  begin
    try
      Bitmap:=TBitmap.Create;
      Bitmap.PixelFormat := pf24bit;
      Bitmap.Width:=PaintBox1.Width;
      Bitmap.Height:=PaintBox1.Height;
      Bitmap.Canvas.CopyRect(Bounds(0,0,bitmap.Width, Bitmap.Height),
        PaintBox1.Canvas, PaintBox1.ClientRect);

      Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
    finally
      Bitmap.Free;
    end;
  end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanDraw := false;
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Close;
  //if Key = 71 then ShowStats := not ShowStats;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  Application.ProcessMessages;
end;

constructor TPlasmaThread.Create(Form: TForm1);
begin
  inherited Create(false);
  CreateBmp;
  Init;
  Self.Form := Form;
  FreeOnTerminate := true;
end;

destructor TPlasmaThread.Destroy;
begin
  TmpBmp.Free;
end;

procedure TPlasmaThread.Init;
var
  x: byte;
begin
  for x := 0 to 255 do SinTab[x] := Round(Sin(2 * Pi * x / 255) * 128) + 128;
  i1 := 50;
  j1 := 90;
  QueryPerformanceFrequency(Freq);
  QueryPerformanceCounter(FrameStart);
  FrameBegin := FrameStart;
  Instant := 0;
  Frame := 0;
  SleepTime := 0;
end;

procedure TPlasmaThread.Execute;
begin
  while not Terminated do
    begin
      Render;
      QueryPerf;
      if CanDraw then Synchronize(Draw);
      Wait;
    end;
end;

procedure TPlasmaThread.Render;
var
  x, y: integer;
  Row: PByteArray;
begin
  i1 := i1 - 1;
  j1 := j1 + 2;
  for y := 0 to Pred(TmpBmp.Height) do
    begin
      i2 := SinTab[(y + i1) and Mask];
      j2 := SinTab[j1 and Mask];
      Row := TmpBmp.ScanLine[y];
      for x := 0 to Pred(TmpBmp.Width) do
        begin
          c := SinTab[(x + i2) and Mask] + SinTab[(y + j2) and Mask];
          if CanDraw then Row[x] := c;
        end;
    end;
end;

procedure TPlasmaThread.Draw;
var
  a, b: integer;
  i, j: integer;
begin
  if Assigned(Form) then
    begin
      DrawBmp.Canvas.Draw(0, 0, TmpBmp);
      a := Form.ClientWidth shr 8;
      b := Form.ClientHeight shr 8;
      for i := 0 to a do
        for j := 0 to b do
          Form.PaintBox1.Canvas.Draw(i shl 8, j shl 8, DrawBmp);
      if ShowStats then DrawFPS(Form.PaintBox1.Canvas);
    end;
end;

procedure TPlasmaThread.CreateBmp;
begin
  // The following bitmap is used to perform all the calculations.
  TmpBmp := TBitmap.Create;
  TmpBmp.PixelFormat := pf8Bit; // must be 8 bit pixel format
  TmpBmp.Palette := GetPal;
  TmpBmp.Width := 256;
  TmpBmp.Height := 256;
  TmpBmp.Canvas.Brush.Color := clBlack;
  TmpBmp.Canvas.FillRect(Rect(0, 0, TmpBmp.Width, TmpBmp.Height));
  // The following bitmap is used to draw more quickly on the screen
  DrawBmp := TBitmap.Create;
  DrawBmp.PixelFormat := pfDevice;
  DrawBmp.Width := 256;
  DrawBmp.Height := 256;
end;

function TPlasmaThread.GetPal: HPalette;
var
  Palette: TMaxLogPalette;
  i: integer;
begin
  // Draw Color Palette Plasma
  Palette.palVersion := $300;
  Palette.palNumEntries := $FE;
  for i := 0 to Pred(Palette.palNumEntries) do
    begin
      with Palette.palPalEntry[i] do
        begin
          peFlags := 0;
          case i of
            0..63:    begin
                        peRed   := i;
                        peGreen := i * 2;
                        peBlue  := i * 4;
                      end;
            64..126:  begin
                        peRed   := (126 - i);
                        peGreen := (126 - i) * 2;
                        peBlue  := (126 - i) * 4;
                      end;
            127..189: begin
                        peRed   := (i - 125) * 4;
                        peGreen := (i - 125);
                        peBlue  := (i - 125) * 2;
                      end;
            190..252: begin
                        peRed   := (255 - i) * 4;
                        peGreen := (255 - i);
                        peBlue  := (255 - i) * 2;
                      end;
            else      begin
                        peRed   := (255 - i) * 4;
                        peGreen := (255 - i);
                        peBlue  := (255 - i) * 2;
                      end;
          end;
        end;
    end;
  Result := CreatePalette(pLogPalette(@Palette)^)
end;

procedure TPlasmaThread.DrawFPS(Canvas: TCanvas);
begin
  // FPS output Text
  if Form1.CheckBox1.Checked = true then
  begin
    Canvas.Font.Color := clWhite;
    Canvas.Brush.Style := bsClear;
    Canvas.Font.Name := 'Verdana';
    Canvas.TextOut(10, 10, Format('FPS Count         : %0.2n', [Instant]));
    Canvas.TextOut(10, 25, Format('FPS Average      : %0.2n', [Average]));
    Canvas.TextOut(10, 40, Format('Rest time (ms)   : %d', [SleepTime]));
  end;
end;

procedure TPlasmaThread.Wait;
begin
  // Frame rate set to around 40-50 FPS
  if (Instant > 50) then Inc(SleepTime);
  if (Instant < 40) and (SleepTime > 0) then Dec(SleepTime);
  Sleep(SleepTime);
end;

procedure TPlasmaThread.QueryPerf;
begin
  QueryPerformanceCounter(FrameStop);
  FrameEnd := FrameStop;
  Instant := Freq / (FrameStop - FrameStart);
  Average := (Frame * Freq) / (FrameEnd - FrameBegin);
  Inc(Frame);
  QueryPerformanceCounter(FrameStart);
end;

end.
