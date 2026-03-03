unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, ProEffectImage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Bumpmapping, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Panel2: TPanel;
    EffectsList: TListBox;
    TrackBar: TTrackBar;
    Button_APPLY: TButton;
    AutoMatic: TCheckBox;
    Button1: TButton;
    Label1: TLabel;
    ScrollBox1: TScrollBox;
    ProEffectImage: TProEffectImage;
    Label2: TLabel;
    Button2: TButton;
    CheckBox1: TCheckBox;
    SaveDialog1: TSaveDialog;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure EffectsListClick(Sender: TObject);
    procedure Button_APPLYClick(Sender: TObject);
    procedure TrackBarChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpinEdit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  XPos: Single;
  YPos: Single;

implementation

{$R *.DFM}

{ FORM CREATION }
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Bump_Flush();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := true;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  
end;

{ EFFECT LISTBOX ACTIONS }
procedure TForm1.EffectsListClick(Sender: TObject);
begin
 {Start}
 if ProEffectImage.Picture.Graphic = nil then Exit;
 ProEffectImage.Picture.LoadFromFile (OpenDialog1.FileName);
 Button_APPLY.Enabled := True;
 TrackBar.Enabled     := True;
 TrackBar.Position    := 1;
end;

{ APPLY BUTTON ACTIONS }
procedure TForm1.Button1Click(Sender: TObject);
var
  FileHeader: TBitmapFileHeader;
  InfoHeader: TBitmapInfoHeader;
  Stream    : TFileStream;
begin
  if OpenDialog1.Execute then
  begin
    ProEffectImage.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
    // Dimension & Format Information
    Stream := TFileStream.Create(OpenDialog1.FileName, fmOpenRead or fmShareDenyNone);
      try
        Stream.Read(FileHeader, SizeOf(FileHeader));
        Stream.Read(InfoHeader, SizeOf(InfoHeader));
        StatusBar1.Panels[1].Text := ExtractFileName(OpenDialog1.FileName);
        StatusBar1.Panels[3].Text := Format('%d Bytes', [FileHeader.bfSize]);
        StatusBar1.Panels[5].Text := '(X-' + Format('%d)', [InfoHeader.biWidth]) + 'x' +
                                      Format('(Y-%d)', [InfoHeader.biHeight]);
        StatusBar1.Panels[7].Text := Format('%d', [InfoHeader.biBitCount]);
      finally
        Stream.Free;
      end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    if CheckBox3.Checked = true then
    begin
      ProEffectImage.Transparent := true;
    end;
    ProEffectImage.Picture.Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
  end;
end;

procedure TForm1.Button_APPLYClick(Sender: TObject);
var
  i  : Integer; {For Loop}
begin
  Screen.Cursor := crHourGlass;
  ProEffectImage.Picture.LoadFromFile (OpenDialog1.FileName);
  Button_APPLY.Enabled := False;

  { E F F E C T S }
     Case EffectsList.ItemIndex of

           0: ProEffectImage.Effect_GaussianBlur   (TrackBar.Position);
           1: ProEffectImage.Effect_SplitBlur      (TrackBar.Position);
           2: ProEffectImage.Effect_AddColorNoise  (TrackBar.Position * 3);
           3: ProEffectImage.Effect_AddMonoNoise   (TrackBar.Position * 3);
           4: For i:=1 to TrackBar.Position do
              ProEffectImage.Effect_AntiAlias;
           5: ProEffectImage.Effect_Contrast       (TrackBar.Position * 3);
           6: ProEffectImage.Effect_FishEye        (TrackBar.Position div 10+1);
           7: ProEffectImage.Effect_Lightness      (TrackBar.Position * 2);
           8: ProEffectImage.Effect_Darkness       (TrackBar.Position * 2);
           9: ProEffectImage.Effect_Saturation     (255-((TrackBar.Position * 255) div 100));
          10: ProEffectImage.Effect_Mosaic         (TrackBar.Position div 2);
          11: ProEffectImage.Effect_Twist          (200-(TrackBar.Position * 2)+1);
          12: ProEffectImage.Effect_Splitlight     (TrackBar.Position div 20);
          13: ProEffectImage.Effect_Tile           (TrackBar.Position div 10);
          14: ProEffectImage.Effect_SpotLight      (TrackBar.Position ,
                                                    Rect (TrackBar.Position ,
                                                    TrackBar.Position ,
                                                    TrackBar.Position +TrackBar.Position*2,
                                                    TrackBar.Position +TrackBar.Position*2));
          15: ProEffectImage.Effect_Trace          (TrackBar.Position div 10);
          16: For i:=1 to TrackBar.Position do
              ProEffectImage.Effect_Emboss;
          17: ProEffectImage.Effect_Solorize       (255-((TrackBar.Position * 255) div 100));
          18: ProEffectImage.Effect_Posterize      (((TrackBar.Position * 255) div 100)+1);
          19: ProEffectImage.Effect_Grayscale;
          20: ProEffectImage.Effect_Invert;
     end;{Case}
  Screen.Cursor := crDefault;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked = true then
  begin
    Bump_Init(ProEffectImage.Picture.Bitmap, 2,3,4);

    XPos := XPos + 0.02;
    YPos := YPos + 0.01;

    //Limit to 2Pi
    if (XPos > 2 * PI) then XPos := XPos - 2 * PI;
    if (YPos > 2 * PI) then YPos := YPos - 2 * PI;

    //And spend
    with ProEffectImage.Picture do
      Bump_Do(Bitmap,
        trunc(Sin(XPos) * (Bitmap.Width shr 1) + (Bitmap.Width shr 1)),
        trunc(Sin(YPos) * (Bitmap.Height shr 1) + (Bitmap.Height shr 1))
        );
  end else begin
    ProEffectImage.Picture.LoadFromFile (OpenDialog1.FileName);
    Button_APPLY.Enabled := True;
    TrackBar.Enabled     := True;
    TrackBar.Position    := 1;
 end;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked = true then
  begin
    ProEffectImage.Align := alClient;
    ProEffectImage.Stretch := true;
  end else begin
    ProEffectImage.Align := alNone;
    ProEffectImage.Stretch := false;
  end;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  ProEffectImage.Transparent := CheckBox3.Checked;
end;

procedure TForm1.TrackBarChange(Sender: TObject);
begin
 if not Button_APPLY.Enabled then Button_APPLY.Enabled := True;
 if AutoMatic.Checked        then Button_APPLY.Click;
end;

end.
