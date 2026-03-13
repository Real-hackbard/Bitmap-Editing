unit BmpGrD12;

interface
uses
  WinProcs, WinTypes, SysUtils, Classes, Graphics, Controls, Forms;

type
  PFullPalette = ^TFullPalette;
  TFullPalette = array[0..255] of TRGBQuad;

{ Converts an 8, 24, or 32-bit bitmap to an 8-bit grayscale bitmap. }
function ConvertToGrayBitmap(ASrcBmp,ADstBmp:TBitmap):Boolean;

{ Changes the palette of a bitmap (1, 4, 8 bits) }
function ChangePalette(ABmp:TBitmap; var APal:TFullPalette):Boolean;

{ returns an 8-bit bitmap with 256 x AHeight pixels,
  which displays the palette. }
function DrawPalette(ABmp:TBitmap; var APal:TFullPalette; AHeight:Integer):Boolean;

implementation

{$R-}
{$ifdef Ver80}

{ *****************  speziell für Delphi 1  ************************* }

type
  PRGBQuad = ^TRGBQuad;

procedure __AHSHIFT; far; external 'KERNEL' index 113;
procedure __AHINCR; far; external 'KERNEL' index 114;

{ Erhöht einen 16-Bit Pointer um Ofs (mittels Erhöhung des Segmentes) }
function OffsetPointer(P: Pointer; Ofs: Longint): Pointer; assembler;
asm
        MOV     AX,Ofs.Word[0]
        MOV     DX,Ofs.Word[2]
        ADD     AX,P.Word[0]
        ADC     DX,0
        MOV     CX,OFFSET __AHSHIFT
        SHL     DX,CL
        ADD     DX,P.Word[2]
end;

{$else}

function OffsetPointer(APointer:Pointer; AOffset:Integer):PByte;
begin
  Result:=APointer;
  Inc(Result,AOffset);
end;

procedure hmemcpy(Dst,Src:Pointer; Len:LongInt);
begin
  Move(Src^,Dst^,Len);
end;

{$endif}


{ Set the size of a scan line to 4 bytes (I in bits) }
function WidthBytes(I:LongInt):LongInt;
begin
  Result:=((I+31) div 32)*4;
end;

{ Determines the number of colors (for palette-oriented bitmaps) }
function GetDInColors(BitCount: Word): Integer;
begin
  case BitCount of
    1, 4, 8: Result := 1 shl BitCount;
  else
    Result := 0;
  end;
end;

type
  PbmiColors = ^TbmiColors;
  TbmiColors = array[0..0] of TRGBQuad;
  PRGBTriple = ^TRGBTriple;

function ConvertToGrayBitmap(ASrcBmp,ADstBmp:TBitmap):Boolean;
var
  { Source bitmap }
  SrcWidth     : LongInt;           { width }
  SrcHeight    : LongInt;           { height }
  SrcStream    : TMemoryStream;     { Stream }
  SrcP0        : Pointer;           { bottom left corner }
  SrcLineSize  : LongInt;           { Size of a scan line in bytes }
  SrcPixelSize : LongInt;           { Pixel size in bytes }
  SrcBfh       : PBitmapFileHeader;
  SrcBih       : PBitmapInfoHeader;
  SrcPalette   : PbmiColors;
  SrcPalCount  : LongInt;           { Number of pallet entries }

  { Zielbitmap }
  DstStream    : TMemoryStream;     { Stream }
  DstP0        : Pointer;           { bottom left corner }
  DstLineSize  : LongInt;           { Size of a scan line in bytes }
  DstPixelSize : LongInt;           { Pixel size in bytes }
  DstBfh       : PBitmapFileHeader;
  DstBih       : PBitmapInfoHeader;
  DstPalette   : PbmiColors;
  DstPalCount  : LongInt;           { Number of pallet entries }

{ Retrieve data from the source bitmap (stream) }
function GetSrcHeader:Boolean;
var
  p         : PByte;
  BitsIndex : LongInt;
begin
  Result:=False;
  p:=SrcStream.Memory;
  { Read file headers }
  SrcBfh:=PBitmapFileHeader(p);
  { Check if Bitmap }
  if SrcBfh^.bfType<>$4D42 then Exit;
  Inc(p,SizeOf(TBitmapFileHeader));
  { Read BitmapInfoHeader }
  SrcBih:=PBitmapInfoHeader(p);
  Inc(p,SizeOf(TBitmapInfoHeader));
  with SrcBih^ do begin
    { Check if BitmapInfoHeader is present; it could also be BitmapCoreHeader. }
    if biSize<>SizeOf(TBitmapInfoHeader) then Exit;
    { Check if the bitmap is uncompressed; otherwise, it is not implemented. }
    if biCompression<>BI_RGB then Exit;
    { Calculate pallet size and position }
    SrcPalette:=PbmiColors(p);
    SrcPalCount:=GetDInColors(biBitCount);
    { Calculate the position of the image }
    BitsIndex:=SrcBfh^.bfOffBits;
    { When DIBs are upscaled from 8 bits to 24 bits, an additional
      palette is present. }
    if biBitCount>8 then Inc(BitsIndex,biClrUsed*SizeOf(TRGBQuad));
    { Calculate pointer to source DIB }
    SrcP0:=OffsetPointer(SrcStream.Memory,BitsIndex);
    SrcWidth :=biWidth ;
    SrcHeight:=biHeight;
    { Calculating scan line sizes }
    SrcLineSize:=WidthBytes(biWidth*biBitCount);
    case biBitCount of
      8,24,32 : SrcPixelSize:=biBitCount shr 3;
    else
      Exit;  { No 1, 4, 15, or 16-bit bitmaps }
    end;
    { Check if the calculated data lies within the stream. }
    if BitsIndex+biHeight*SrcLineSize>SrcStream.Size then Exit;
  end;
  Result:=True;
end;

{ Generate data from the target bitmap (stream) }
function CreateDstHeader:Boolean;
var
  p       : PByte;
  NewSize : LongInt;
  i       : LongInt;
begin
  Result:=False;
  NewSize:=SizeOf(TBitmapFileHeader)+SizeOf(TBitmapInfoHeader)+
           256*SizeOf(TRGBQuad)+WidthBytes(SrcWidth*8)*SrcHeight;
  DstStream.SetSize(NewSize);
  p:=DstStream.Memory;
  FillChar(p^,NewSize,0);
  { Generate FileHeader }
  DstBfh:=PBitmapFileHeader(p);
  with DstBfh^ do begin
    bfType   :=$4D42;
    bfSize   :=NewSize;
    bfOffBits:=SizeOf(TBitmapFileHeader)+SizeOf(TBitmapInfoHeader)+
               256*SizeOf(TRGBQuad);
  end;
  Inc(p,SizeOf(TBitmapFileHeader));
  { Create BitmapInfoHeader }
  DstBih:=PBitmapInfoHeader(p);
  with DstBih^ do begin
    biSize:=SizeOf(TBitmapInfoHeader);
    biWidth :=SrcWidth;
    biHeight:=SrcHeight;
    biPlanes:=1;
    biBitCount:=8;
    biCompression:=BI_RGB;
    biSizeImage:=0;
    biXPelsPerMeter:=96;
    biYPelsPerMeter:=96;
    biClrUsed:=0;
    biClrImportant:=0;
    DstLineSize :=WidthBytes(biWidth*biBitCount);
    DstPixelSize:=1;         { 1 Byte / Pixel }
  end;
  Inc(p,SizeOf(TBitmapInfoHeader));
  { Set pallet }
  DstPalette :=PbmiColors(p);
  DstPalCount:=256;
  Inc(p,256*SizeOf(TRGBQuad));
  { Set pointer to bitmap data }
  DstP0:=p;
  { Set up palette }
  for i:=0 to 255 do begin
    with DstPalette^[i] do begin
      rgbBlue :=i;
      rgbGreen:=i;
      rgbRed  :=i;
    end;
  end;
  Result:=True;
end;

var
  OldCursor : TCursor;   { Save the state of the old mouse pointer }
  x, y      : LongInt;   { Coordinates during copying }
  SrcPLine  : PByte;
  SrcP      : PByte;
  DstPLine  : PByte;
  DstP      : PByte;
  PalTab    : array[Byte] of Byte;

begin
  Result:=False;
  OldCursor:=Screen.Cursor;
  Screen.Cursor:=crHourglass;
  try
    SrcStream:=TMemoryStream.Create;
    try
      DstStream:=TMemoryStream.Create;
      try
        ASrcBmp.SaveToStream(SrcStream);
        if Not GetSrcHeader then Exit;
        if Not CreateDstHeader then Exit;
        { Converting 8-bit bitmaps }
        if SrcPixelSize=1 then begin
          { Convert palette }
          for x:=0 to 255 do with SrcPalette^[x] do
            PalTab[x]:=Byte((rgbRed*77{30%}+rgbGreen*151{59%}+rgbBlue*28{11%}) shr 8);
          SrcPLine:=SrcP0;
          DstPLine:=DstP0;
          for y:=0 to SrcHeight-1 do begin    { for all lines}
            SrcP:=SrcPLine;
            DstP:=DstPLine;
            for x:=0 to SrcWidth-1 do begin   { for all columns }
              DstP^:=PalTab[SrcP^];
              Inc(SrcP);
              Inc(DstP);
            end;
            Inc(SrcPLine,SrcLineSize);
            Inc(DstPLine,DstLineSize);
          end;
        end
        { Converting 24-bit or 32-bit bitmaps }
        else begin
          SrcPLine:=SrcP0;
          DstPLine:=DstP0;
          for y:=0 to SrcHeight-1 do begin    { for all lines }
            SrcP:=SrcPLine;
            DstP:=DstPLine;
            for x:=0 to SrcWidth-1 do begin   { for all columns }
              with PRGBQuad(SrcP)^ do
                DstP^:=Byte((rgbRed*77{30%}+rgbGreen*151{59%}+rgbBlue*28{11%}) shr 8);
              Inc(SrcP,SrcPixelSize);
              Inc(DstP);
            end;
            Inc(SrcPLine,SrcLineSize);
            Inc(DstPLine,DstLineSize);
          end;
        end;
        DstStream.Seek(0,soFromBeginning);
        ADstBmp.LoadFromStream(DstStream);
        Result:=True;
      finally
        DstStream.Free;
      end;
    finally
      SrcStream.Free;
    end;
  finally
    Screen.Cursor:=OldCursor;
  end;
end;

function ChangePalette(ABmp:TBitmap; var APal:TFullPalette):Boolean;
var
  Stream    : TMemoryStream;     { Stream }
  Bfh       : PBitmapFileHeader;
  Bih       : PBitmapInfoHeader;
  Palette   : PbmiColors;
  PalCount  : LongInt;           { Number of pallet entries }
  OldCursor : TCursor;   { Save the state of the old mouse pointer }
  p         : PByte;

begin
  Result:=False;
  OldCursor:=Screen.Cursor;
  Screen.Cursor:=crHourglass;
  try
    Stream:=TMemoryStream.Create;
    try
      ABmp.SaveToStream(Stream);
      p:=Stream.Memory;
      { Read file headers }
      Bfh:=PBitmapFileHeader(p);
      { Check if Bitmap }
      if Bfh^.bfType<>$4D42 then Exit;
      Inc(p,SizeOf(TBitmapFileHeader));
      { Read BitmapInfoHeader }
      Bih:=PBitmapInfoHeader(p);
      Inc(p,SizeOf(TBitmapInfoHeader));
      with Bih^ do begin
        { Check if BitmapInfoHeader is present; it could also be BitmapCoreHeader. }
        if biSize<>SizeOf(TBitmapInfoHeader) then Exit;
        { Calculate pallet size and position }
        Palette:=PbmiColors(p);
        PalCount:=GetDInColors(biBitCount);
      end;
      Move(APal,Palette^,PalCount*SizeOf(TRGBQuad));
      Stream.Seek(0,soFromBeginning);
      ABmp.LoadFromStream(Stream);
      Result:=True;
    finally
      Stream.Free;
    end;
  finally
    Screen.Cursor:=OldCursor;
  end;
end;

function DrawPalette(ABmp:TBitmap; var APal:TFullPalette; AHeight:Integer):Boolean;
const
  AWidth = 256;

var
  Stream    : TMemoryStream;     { Stream }
  Bfh       : PBitmapFileHeader;
  Bih       : PBitmapInfoHeader;
  P0        : Pointer;
  LineSize  : LongInt;
  PixelSize : LongInt;
  Palette   : PbmiColors;
  PalCount  : LongInt;           { Number of pallet entries }
  OldCursor : TCursor;   { Rettet den Zustand des alten Mauszeigers }
  NewSize   : Integer;
  p         : PByte;
  pLine     : PByte;
  x,y       : Integer;

begin
  Result:=False;
  OldCursor:=Screen.Cursor;
  Screen.Cursor:=crHourglass;
  try
    Stream:=TMemoryStream.Create;
    try
      NewSize:=SizeOf(TBitmapFileHeader)+SizeOf(TBitmapInfoHeader)+
               256*SizeOf(TRGBQuad)+WidthBytes(AWidth*8)*AHeight;
      Stream.SetSize(NewSize);
      p:=Stream.Memory;
      FillChar(p^,NewSize,0);
      { Generate FileHeader }
      Bfh:=PBitmapFileHeader(p);
      with Bfh^ do begin
        bfType   :=$4D42;
        bfSize   :=NewSize;
        bfOffBits:=SizeOf(TBitmapFileHeader)+SizeOf(TBitmapInfoHeader)+
                   256*SizeOf(TRGBQuad);
      end;
      Inc(p,SizeOf(TBitmapFileHeader));
      { Create BitmapInfoHeader }
      Bih:=PBitmapInfoHeader(p);
      with Bih^ do begin
        biSize:=SizeOf(TBitmapInfoHeader);
        biWidth :=AWidth;
        biHeight:=AHeight;
        biPlanes:=1;
        biBitCount:=8;
        biCompression:=BI_RGB;
        biSizeImage:=0;
        biXPelsPerMeter:=96;
        biYPelsPerMeter:=96;
        biClrUsed:=0;
        biClrImportant:=0;
        LineSize :=WidthBytes(biWidth*biBitCount);
        PixelSize:=1;         { 1 Byte / Pixel }
      end;
      Inc(p,SizeOf(TBitmapInfoHeader));
      { Set pallet }
      Palette :=PbmiColors(p);
      PalCount:=256;
      Inc(p,256*SizeOf(TRGBQuad));
      { Set pointer to bitmap data }
      P0:=p;
      { Copy palette }
      Move(APal,Palette^,PalCount*SizeOf(TRGBQuad));
      { Generate bitmap }
      pLine:=p0;
      for y:=0 to AHeight-1 do begin
        p:=pLine;
        for x:=0 to AWidth-1 do begin
          p^:=x;
          Inc(p);
        end;
        Inc(pLine,LineSize);
      end;
      Stream.Seek(0,soFromBeginning);
      ABmp.LoadFromStream(Stream);
      Result:=True;
    finally
      Stream.Free;
    end;
  finally
    Screen.Cursor:=OldCursor;
  end;
end;

end.
