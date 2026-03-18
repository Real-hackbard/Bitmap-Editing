unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Panel1: TPanel;
    Button1: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label3: TLabel;
    Label4: TLabel;
    Shape1: TShape;
    Label5: TLabel;
    ColorDialog1: TColorDialog;
    SpinEdit3: TSpinEdit;
    Label6: TLabel;
    Shape2: TShape;
    Label7: TLabel;
    Label8: TLabel;
    Shape3: TShape;
    Label9: TLabel;
    ComboBox3: TComboBox;
    SpinEdit4: TSpinEdit;
    Label10: TLabel;
    Label11: TLabel;
    SpinEdit5: TSpinEdit;
    CheckBox1: TCheckBox;
    SpinEdit6: TSpinEdit;
    SpinEdit7: TSpinEdit;
    Label12: TLabel;
    Label13: TLabel;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
// VerticalTypewriter ( <Text>, <Image to write to>,
// <Time to delay between every chars> )
procedure VerticalTypewriter(text: string; image: timage; delay: integer);
var
 x,y,i: integer;
begin
 Screen.Cursor := crHourGlass;
 if Form1.CheckBox1.Checked = false then
 begin
   Image.Canvas.Brush.Color:= Form1.Shape1.Brush.Color;
   Image.Canvas.Rectangle(0,0,Image.Width,Image.Height);
   Image.Repaint;
   Image.Canvas.Refresh;
 end;

 y := Form1.SpinEdit7.Value;

 Image.Canvas.Brush.Color := Form1.Shape3.Brush.Color;
 Image.Canvas.Font.Color := Form1.Shape2.Brush.Color;
 Image.Canvas.Font.Size := Form1.SpinEdit3.Value;
 Image.Canvas.Font.Name := Form1.ComboBox2.Text;

 case Form1.ComboBox3.ItemIndex of
   0 : Image.Canvas.Brush.Style := bsClear;
   1 : Image.Canvas.Brush.Style := bsSolid;
 end;

 for i := 1 to length(text) do
 begin
  y := y + Image.Canvas.TextHeight(text[i]);

  //x := Image.width div 2 - (image.Canvas.TextWidth(text[i]) div 2);
  x := Form1.SpinEdit6.Value - (Image.Canvas.TextWidth(text[i]) div 2);

  Image.Canvas.TextOut(x, y, text[i]);
  Application.ProcessMessages;
  sleep(delay);
 end;
 Screen.Cursor := crDefault;
end;

// Horizontal Typewriter ( <Text>, <Image to write to>, <Time to delay
// between every chars>, <Space between chars>)
procedure HorizontalTypewriter(text: string; image: timage; delay, space: integer);
var
 x,y,i: integer;
begin
 Screen.Cursor := crHourGlass;
 if Form1.CheckBox1.Checked = false then
 begin
   Image.Canvas.Brush.Color:= Form1.Shape1.Brush.Color;
   Image.Canvas.Rectangle(0,0,Image.Width,Image.Height);
   Image.Repaint;
   Image.Canvas.Refresh;
 end;

 x := Form1.SpinEdit6.Value;

 Image.Canvas.Brush.Color := Form1.Shape3.Brush.Color;
 Image.Canvas.Font.Color := Form1.Shape2.Brush.Color;
 Image.Canvas.Font.Size := Form1.SpinEdit3.Value;
 Image.Canvas.Font.Name := Form1.ComboBox2.Text;

 case Form1.ComboBox3.ItemIndex of
   0 : Image.Canvas.Brush.Style := bsClear;
   1 : Image.Canvas.Brush.Style := bsSolid;
 end;

 for i := 1 to length(text) do
 begin
  application.ProcessMessages;
  y := Form1.SpinEdit7.Value - (image.Canvas.TextHeight(text[i]) div 2);
  x := x + Image.Canvas.TextWidth(text[i])+space;
  Image.Canvas.TextOut(x,y,text[i]);
  Application.ProcessMessages;
  sleep(delay);
 end;
 Screen.Cursor := crDefault;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
   //                      <text>         <image>  <delay>
   0 : VerticalTypewriter('typewriter',   Image1,  SpinEdit4.Value);
   //                        <text>        <image>  <delay>              <space>
   1 : HorizontalTypewriter('typewriter',  Image1,  SpinEdit4.Value,     SpinEdit5.Value);
 end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  if SaveDialog1.Execute then
  begin
   try
    bmp := TBitmap.Create;
    bmp.Assign(Image1.Picture.Bitmap);
    bmp.PixelFormat := pf24bit;
    bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
   finally
    bmp.Free;
   end;
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  a : integer;
begin
  for a := 0 to Screen.Fonts.Count-1 do
  begin
    ComboBox2.Items.Add(Screen.Fonts.Strings[a]);
  end;

  ComboBox2.ItemIndex := 15;
  Image1.Picture.Bitmap.SetSize(SpinEdit2.Value, SpinEdit1.Value);
  Image1.Canvas.Brush.Color:= Shape1.Brush.Color;
  Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
end;

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
  begin
    Shape1.Brush.Color := ColorDialog1.Color;
    Image1.Canvas.Brush.Color:= Shape1.Brush.Color;
    Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
    Image1.Repaint;
  end;
end;

procedure TForm1.Shape2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
  begin
    Shape2.Brush.Color := ColorDialog1.Color;
  end;
end;

procedure TForm1.Shape3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
  begin
    Shape3.Brush.Color := ColorDialog1.Color;
  end;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  Image1.Picture.Bitmap.SetSize(SpinEdit2.Value, SpinEdit1.Value);
  Image1.Canvas.Brush.Color:= Shape1.Brush.Color;
  Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
  Image1.Repaint;
end;

end.
