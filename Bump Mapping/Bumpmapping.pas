unit Bumpmapping;

interface

uses Windows, Graphics;

// ----- Bumpmapping procedures -----
procedure Bump_Init(SourceBitMap: TBitmap; r: Single = 3; g: Single = 3.6;
  b: Single = 4);
procedure Bump_Flush();
procedure Bump_Do(Target: TBitmap; XLight, YLight: Integer);
procedure Bump_SetSource(SourceBitMap: TBitmap);
procedure Bump_SetColor(r, g, b: Single);


implementation

// ----- define a few useful types -----
type 
  PBitmap = ^TBitmap;
  // Small array for faster access to bitmaps
  TLine = array[0..MaxInt div SizeOf(TRGBQUAD) - 1] of TRGBQUAD;
  PLine = ^TLine;

  // ----- Some internal variables -----
var
  ColorArray: array of TRGBQuad;   // Array for the color table in bump mapping
  SourceArray: array of Byte;      // Source pattern
  TargetBMP: TBitmap;              // Target Bitmap
  Black: TRGBQuad;                 // Black
  White: TRGBQuad;                 // White


  // ----- Create the source for bump mapping            -----
  // ----- A black and white array is created from a bitmap. -----
procedure Bump_SetSource(SourceBitMap: TBitmap);
var
  iX, iY: Integer;
  z: Integer;
  sLine: PLine;
  iDot: Integer;
begin
  // Create source array
  SourceBitmap.PixelFormat := pf32Bit;
  SetLength(SourceArray, SourceBitMap.Height * SourceBitMap.Width);

  for iY := 0 to SourceBitMap.Height - 1 do
  begin
    // Get scanline
    sLine := SourceBitMap.ScanLine[iY];

    // And muddle through
    for iX := 0 to SourceBitMap.Width - 1 do
    begin
      //Koordinaten errechnene
      z := iY * SourceBitMap.Width + iX;

      // Determine gray value
      idot := sLine[iX].rgbRed;
      idot := idot + sLine[iX].rgbGreen;
      idot := idot + sLine[iX].rgbBlue;
      iDot := (iDot div 3);
      // And register
      SourceArray[z] := iDot;
    end;
  end;
end;


// ----- Generate color table -----
procedure Bump_SetColor(r, g, b: Single);
var
  iIndex: Integer;
  c: Byte;
begin
  if (r > 4) then r := 4;
  if (r < 0) then r := 0;
  if (g > 4) then g := 4;
  if (g < 0) then g := 0;
  if (b > 4) then b := 4;
  if (b < 0) then b := 0;

  // Set length
  SetLength(ColorArray, 255);
  // And make it black first
  FillMemory(ColorArray, 255 * SizeOf(TRGBQuad), 0);

  // Beautiful blue gradient
  for iIndex := 0 to 127 do
  begin
    c := 63 - iIndex div 2;

    // Here the color can be set from 0.0 to 4.0.
    ColorArray[iIndex].rgbRed   := round(c * r);
    ColorArray[iIndex].rgbGreen := round(c * g);
    ColorArray[iIndex].rgbBlue  := round(c * b);
  end;

  // Define black and white
  Black.rgbRed   := 0;
  Black.rgbBlue  := 0;
  Black.rgbGreen := 0;
  White.rgbRed   := 255;
  White.rgbBlue  := 255;
  White.rgbGreen := 255;
end;


// ----- Perform actual bump mapping -----
procedure Bump_Do(Target: TBitmap; XLight, YLight: Integer);
var
  iX, iY: Integer;
  sLine: PLine;
  iR1, iT1: Integer;
  iR, iT: Integer;
  z: Integer;
begin
  // All lines (except top and bottom)
  for iY := 1 to TargetBMP.Height - 2 do
  begin
    // Get scanline
    sLine := TargetBMP.ScanLine[iY];

    // Starting position in the source array
    z := iY * TargetBMP.Width;

    // Preliminary calculation for lighting
    iT1 := (iY - YLight);

    // And process all the pixels
    for iX := 1 to TargetBMP.Width - 2 do
    begin
      // Update position in array
      Inc(z);

      // Determine the slope at our point
      iT := iT1 - (SourceArray[z + TargetBMP.Width] -
        SourceArray[z - TargetBMP.Width]);
      iR := (iX - XLight) - (SourceArray[z + 1] - SourceArray[z - 1]);

      // Absolutely do it
      if (iR < 0) then iR := -iR;
      if (iT < 0) then iT := -iT;

      // What does the slope look like?
      iR1 := iR + iT;
      if (iR1 < 129) then
      begin
        // Steep incline, get some color
        sLine[iX] := ColorArray[iR1];
      end
      else
      begin
        // Otherwise black
        sLine[iX] := Black;
      end;
    end;
  end;
  // Pass result
  Target.Assign(TargetBMP);
end;

// ----- Bumpmapping initialize -----
procedure Bump_Init(SourceBitMap: TBitmap; r: Single = 3; g: Single = 3.6;
  b: Single = 4);
begin
  // Generate target bitmap
  TargetBMP := TBitmap.Create;
  with TargetBMP do
  begin
    Height      := SourceBitMap.Height;
    Width       := SourceBitMap.Width;
    PixelFormat := pf32Bit;
  end;

  // Initialize color tables
  Bump_SetColor(r, g, b);

  // And create an array from the source bitmap
  Bump_SetSource(SourceBitmap);
end;


// ----- Bumpmapping end -----
procedure Bump_Flush();
begin
  // Free up memory
  TargetBMP.Free;
  SetLength(ColorArray, 0);
end;

end.