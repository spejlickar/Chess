unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,GenAllTah, Menus;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CreateBitmap;
    function  GetFig(Height:integer):integer;
    procedure SetPaintBox(Height:integer);
    procedure DrawLine;
    procedure ResetArray;
    procedure DrawFig(x,y,jaka:integer);
    procedure DrawAllFig;
    procedure DrawKamen(x,y:integer);
    procedure DrawAllKamen;
    procedure DrawMaskFig(x, y,Jaka: integer);
    procedure DrawMaskKamen(x,y:integer);
    procedure DrawMaskAllFig;
    procedure DrawMaskAllKamen;
    procedure DrawRandomTah(CerBil,Barva:boolean);
    procedure DrawSigTah(KamenX,KamenY:integer);
    function Jump(KamenX,KamenY:integer):boolean;
    procedure ResetSigTah;
    procedure CopyPomBitmap(x,y:integer);
    procedure CopyPomKamen(fx,fy:integer);
    procedure DrawPomBitmap(x,y:integer);
    procedure DrawFigXY(x,y:integer);
    procedure TranKamenXY(x,y:integer;var tx,ty:integer);
    procedure TranFigXY(x,y:integer;var tx,ty:integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure JumpFig(KamenX,KamenY:integer);
    procedure Refresh;
    procedure Timer1Timer(Sender: TObject);
  private
  public
    bKamenB,bKamenC,bAllFig,bMaskAllFig,bMaskAllKamen,bPom,bTah:TBitmap;
    bSigTahM,bSigTahS:TBitMap;
    iFig,dx,dy,sx,sy,FigX,FigY,SigTahX,SigTahY:integer;
    Barva,Posun,bSigTah:boolean;
    bitmap:HBitMap;
    ObrazDC:HDC;
  end;

var
  Form1: TForm1;
  {/////////////////////////////////////
  +/-1=pesec        -=bile
  +/-2=kobila       +=cerne
  +/-3=strelec      barva=true  =>cerne dole
  +/-4=ohrada       barva=false =>bile dole
  +/-5=dama
  +/-6=kral
  /////////////////////////////////////}


implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
Barva:=false;  Posun:=false;
iFig:=GetFig(Screen.Height);
SetPaintBox(Screen.Height);
CreateBitmap;
//DrawLine;
DrawAllKamen;
ResetArray;
DrawAllFig;
DrawMaskAllFig;
DrawMaskAllKamen;
ResetSigTah;
GenTahy(true,barva);
//Image1.Canvas.Draw(0,0,bMaskAllKamen);
end;

function TForm1.GetFig(Height:integer):integer;
var b,klop:boolean;
    incc,decc:integer;
begin
 Result:=round(((0.6*Height)-9)/8);
 b:=true; klop:=true;  incc:=Result; decc:=Result;
 while b do if Result in [24,26,30,33,39,45,52,60] then b:=false else
             if klop then begin inc(incc); klop:=false; Result:=incc; end else
                          begin dec(decc); klop:=true;  Result:=decc; end;
end;

procedure TForm1.SetPaintBox(Height:integer);
var a:integer;
begin
 PaintBox1.Top:=Round(0.18*Height);
 PaintBox1.Left:=50;
 a:=8*iFig+9;
 PaintBox1.Width:=a;
 PaintBox1.Height:=a;
end;

procedure TForm1.CreateBitmap;
begin
 ObrazDC:=CreateCompatibleDC(PaintBox1.Canvas.Handle);
 bitmap:=CreateCompatibleBitmap(PaintBox1.Canvas.Handle,PaintBox1.Width,PaintBox1.Height);
 SelectObject(ObrazDC,bitmap);
 bAllFig:=Tbitmap.Create;
 bAllFig.LoadFromFile('F'+IntToStr(iFig)+'.bmp');
 bKamenC:=TBitmap.Create;
 bKamenC.LoadFromFile('cerne.bmp');
 bKamenB:=TBitmap.Create;
 bKamenB.LoadFromFile('bile.bmp');
 bMaskAllFig:=TBitmap.Create;
 bMaskAllFig.Width:=PaintBox1.Width;
 bMaskAllFig.Height:=PaintBox1.Height;
 bMaskAllKamen:=TBitmap.Create;
 bMaskAllKamen.Width:=PaintBox1.Width;
 bMaskAllKamen.Height:=PaintBox1.Height;
 bTah:=TBitmap.Create;
 bTah.Width:=PaintBox1.Width;
 bTah.Height:=PaintBox1.Height;
 bTah.Canvas.Brush.Color:=0;
 bTah.Canvas.Pen.Color:=0;
 bTah.Canvas.Rectangle(0,0,bTah.Width,bTah.Height);
 bPom:=TBitmap.Create;
 bPom.Width:=iFig;
 bPom.Height:=iFig;

 bSigTahM:=TBitmap.Create;
 bSigTahM.Width:=iFig;
 bSigTahM.Height:=iFig;
 bSigTahM.Canvas.Brush.Color:=0;
 bSigTahM.Canvas.Pen.Color:=0;
 bSigTahM.Canvas.Rectangle(0,0,iFig,iFig);
 bSigTahM.Canvas.Brush.Color:=$ffffff;
 bSigTahM.Canvas.Pen.Color:=$ffffff;
 bSigTahM.Canvas.Rectangle(7,7,iFig-7,iFig-7);

 bSigTahS:=TBitmap.Create;
 bSigTahS.Width:=iFig;
 bSigTahS.Height:=iFig;
 bSigTahS.Canvas.Brush.Color:=clGradientActiveCaption;
 bSigTahS.Canvas.Pen.Color:=clGradientActiveCaption;
 bSigTahS.Canvas.Rectangle(0,0,iFig,iFig);
 bSigTahS.Canvas.Brush.Color:=0;
 bSigTahS.Canvas.Pen.Color:=0;
 bSigTahS.Canvas.Rectangle(7,7,iFig-7,iFig-7);
end;

procedure TForm1.DrawLine;
var i:integer;
begin
PaintBox1.Canvas.Pen.Width:=1;
PaintBox1.Canvas.Pen.Color:=Form1.Color;
 for i:=0 to 8 do begin
   PaintBox1.Canvas.MoveTo((iFig+1)*i,0);
   PaintBox1.Canvas.LineTo((iFig+1)*i,PaintBox1.Height);
  end;
 for i:=0 to 8 do begin
   PaintBox1.Canvas.MoveTo(0,(iFig+1)*i);
   PaintBox1.Canvas.LineTo(PaintBox1.Width,(iFig+1)*i);
 end;
end;

procedure TForm1.DrawKamen(x, y: integer);
var Kam,KamTah,Odkud:HDC;
begin
 KamTah:=bTah.Canvas.Handle;
 Kam:=ObrazDC;
 if ((x+y) mod 2)=1 then Odkud:=bKamenC.Canvas.Handle else
  Odkud:=bKamenB.Canvas.Handle;
 BitBlt(Kam,x*(iFig+1)-iFig,y*(iFig+1)-iFig,iFig,iFig,Odkud,0,0,srcCopy);
 BitBlt(KamTah,x*(iFig+1)-iFig,y*(iFig+1)-iFig,iFig,iFig,Odkud,0,0,srcCopy);
end;

procedure TForm1.DrawAllKamen;
var x,y:integer;
begin
for y:=1 to 8 do
 for x:=1 to 8 do DrawKamen(x,y);
end;

procedure TForm1.DrawFig(x, y, jaka: integer);
var KamX,KamY,OdkudX,dy:integer;
    Kam,KamTah,Odkud:HDC;
begin
if jaka<>0 then begin
 Kam:=ObrazDC;
 KamTah:=bTah.Canvas.Handle;
 KamX:=(x-1)*(iFig+1)+1;
 KamY:=(y-1)*(iFig+1)+1;
 Odkud:=bAllFig.Canvas.Handle;
 OdkudX:=iFig*(abs(Jaka)-1);
 if jaka<0 then  dy:=0 else dy:=1;
 BitBlt(Kam,KamX,KamY,iFig,iFig,Odkud,OdkudX,(dy+2)*iFig-dy,srcAND);
 BitBlt(Kam,KamX,KamY,iFig,iFig,Odkud,OdkudX,dy*(iFig-1),srcPAINT);
 BitBlt(KamTah,KamX,KamY,iFig,iFig,Odkud,OdkudX,(dy+2)*iFig-dy,srcAND);
 BitBlt(KamTah,KamX,KamY,iFig,iFig,Odkud,OdkudX,dy*(iFig-1),srcPAINT);
end;
end;

procedure TForm1.DrawAllFig;
var x,y:integer;
begin
 for y:=1 to 8 do
  for x:=1 to 8 do DrawFig(x,y,a[x,y].Co);
end;

procedure TForm1.DrawMaskFig(x, y,Jaka: integer);
var KamX,KamY,OdkudX,dy:integer;
    Kam,Odkud:HDC;
    Kamen:TRect;
    ColorYX:TColor;
begin
if jaka<>0 then begin
 Kamen.Left:=(x-1)*(iFig+1)+1;
 Kamen.Top:=(y-1)*(iFig+1)+1;
 Kamen.Right:=Kamen.Left+iFig;
 Kamen.Bottom:=Kamen.Top+iFig;
 ColorYX:=(y shl 4)or x;
 bMaskAllFig.Canvas.Pen.Color:=ColorYX;
 bMaskAllFig.Canvas.Brush.Color:=ColorYX;
 bMaskAllFig.Canvas.Rectangle(Kamen);

 Kam:=bMaskAllFig.Canvas.Handle;
 KamX:=(x-1)*(iFig+1)+1;
 KamY:=(y-1)*(iFig+1)+1;
 Odkud:=bAllFig.Canvas.Handle;
 OdkudX:=iFig*(abs(Jaka)-1);
 if jaka>0 then  dy:=0 else dy:=1;
 BitBlt(Kam,KamX,KamY,iFig,iFig,Odkud,OdkudX,(dy+2)*iFig-dy,srcPAINT);
end;
end;

procedure TForm1.DrawMaskKamen(x, y: integer);
var Kamen:TRect;
    ColorYX:TColor;
begin
Kamen.Left:=(x-1)*(iFig+1)+1;
Kamen.Top:=(y-1)*(iFig+1)+1;
Kamen.Right:=Kamen.Left+iFig;
Kamen.Bottom:=Kamen.Top+iFig;
ColorYX:=(y shl 4)or x;
bMaskAllKamen.Canvas.Pen.Color:=ColorYX;
bMaskAllKamen.Canvas.Brush.Color:=ColorYX;
bMaskAllKamen.Canvas.Rectangle(Kamen);
end;


procedure TForm1.ResetArray;
var x,y,neg:integer;
begin
for x:=-1 to 10 do
 for y:=-1 to 10 do begin a[x,y].Co:=9; a[x,y].Tahy:=nil; end;
for x:=1 to 8 do
 for y:=1 to 8 do begin a[x,y].Co:=0; a[x,y].Tahy:=nil; end;
if Barva then neg:=1 else neg:=-1;
for x:=1 to 8 do a[x,2].Co:=neg;
for x:=1 to 8 do a[x,7].Co:=-1*neg;
a[1,1].Co:=4*neg; a[8,1].Co:=4*neg;
a[1,8].Co:=-4*neg; a[8,8].Co:=-4*neg;
a[2,1].Co:=2*neg; a[7,1].Co:=2*neg;
a[2,8].Co:=-2*neg; a[7,8].Co:=-2*neg;
a[3,1].Co:=3*neg; a[6,1].Co:=3*neg;
a[3,8].Co:=-3*neg; a[6,8].Co:=-3*neg;
a[round(4.5+(neg/2)),1].Co:=5*neg;
a[round(4.5+(neg/2)),8].Co:=-5*neg;
a[round(4.5-(neg/2)),1].Co:=6*neg;
a[round(4.5-(neg/2)),8].Co:=-6*neg;
end;


procedure TForm1.FormDestroy(Sender: TObject);
begin
bAllFig.Free;
bKamenC.Free;
bKamenB.Free;
bMaskAllFig.Free;
bMaskAllKamen.Free;
bTah.Free;
bPom.Free;
bSigTahM.Free;
bSigTahS.Free;
ReleaseDC(PaintBox1.Canvas.Handle,ObrazDC);
DeleteObject(bitmap);
end;

procedure TForm1.DrawMaskAllFig;
var x,y:integer;
begin
 for y:=1 to 8 do
  for x:=1 to 8 do DrawMaskFig(x,y,a[x,y].Co);
end;

procedure TForm1.DrawMaskAllKamen;
var x,y:integer;
begin
 for y:=1 to 8 do
  for x:=1 to 8 do DrawMaskKamen(x,y);
end;

procedure TForm1.DrawRandomTah(CerBil, Barva: boolean);
var tah:Ttah;
    pom:integer;
begin
 tah:=GenTahRandom(CerBil,Barva);
 pom:=a[tah.CoX,tah.CoY].Co;
 a[tah.CoX,tah.CoY].Co:=0;
 a[tah.KamX,tah.KamY].Co:=pom;
 DrawKamen(tah.CoX,tah.CoY);
 DrawFig(tah.KamX,tah.KamY,pom);
end;

procedure TForm1.DrawSigTah(KamenX,KamenY:integer);
var StredX,StredY,KamX,KamY,X,Y:integer;
begin
StredX:=KamenX+(iFig div 2);
StredY:=KamenY+(iFig div 2);
TranKamenXY(StredX,StredY,X,Y);
//Label1.Caption:=inttostr(X)+' '+inttostr(Y);
if (SigTahX<>X)or(SigtahY<>Y) then begin
 if FindTah(SigTahX,SigTahY,a[FigX,FigY].Tahy) then begin
   DrawKamen(SigTahX,SigTahY);
   DrawFig(SigTahX,SigTahY,a[SigTahX,SigTahY].Co);
  end;
 SigTahX:=X; SigTahY:=Y;
 bSigtah:=FindTah(X,Y,a[FigX,FigY].Tahy);
end;
 if bSigTah then begin
   KamX:=(X-1)*(iFig+1)+1;
   KamY:=(Y-1)*(iFig+1)+1;
   BitBlt(ObrazDC,KamX,KamY,iFig,iFig,bSigTahM.Canvas.Handle,0,0,srcAND);
   BitBlt(ObrazDC,KamX,KamY,iFig,iFig,bSigTahS.Canvas.Handle,0,0,srcPAINT);
  end;
end;

function TForm1.Jump(KamenX, KamenY: integer): boolean;
var StredX,StredY,X,Y:integer;
begin
StredX:=KamenX+(iFig div 2);
StredY:=KamenY+(iFig div 2);
TranKamenXY(StredX,StredY,X,Y);
Result:=FindTah(X,Y,a[FigX,FigY].Tahy);
end;


procedure TForm1.ResetSigTah;
begin
SigTahX:=0; SigTahY:=0;  bSigTah:=false;
end;

procedure TForm1.TranKamenXY(x, y: integer; var tx, ty: integer);
var pom:integer;
begin
pom:=bMaskAllKamen.Canvas.Pixels[x,y];
tx:=pom and $0f;
ty:=(pom shr 4)and $0f;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var KamenX,KamenY:integer;
begin
TranFigXY(X,Y,FigX,FigY);
if FigX<>15 then
if a[FigX,FigY].Tahy<>nil then begin
 KamenX:=(FigX-1)*(iFig+1)+1;
 KamenY:=(FigY-1)*(iFig+1)+1;
 dx:=X-KamenX;
 dy:=Y-KamenY;
 sx:=X;
 sy:=Y;
 CopyPomKamen(FigX,FigY);
 Posun:=true;
end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var KamenSX,KamenSY,KamenX,KamenY:integer;
begin
 if Posun then begin
  KamenSX:=sx-dx; KamenSY:=sy-dy;
  KamenX:=X-dx; KamenY:=Y-dy;
  if KamenSX<0 then KamenSX:=0;
  if KamenSY<0 then KamenSY:=0;
  if KamenX<0 then KamenX:=0;
  if KamenY<0 then KamenY:=0;
  DrawPomBitmap(KamenSX,KamenSY);
  CopyPomBitmap(KamenX,KamenY);
  DrawSigTah(KamenX,KamenY);
  DrawFigXY(KamenX,KamenY);
  Refresh;
  sx:=X; sy:=Y;
 // if Jump(KamenX,KamenY) then Label1.Caption:='ANO' else Label1.Caption:='NE';
 end;
end;

procedure TForm1.CopyPomBitmap(x, y: integer);
var Kam,Odkud:HDC;
begin
 Kam:=bPom.Canvas.Handle;
 Odkud:=bTah.Canvas.Handle;
 BitBlt(Kam,0,0,iFig,iFig,Odkud,x,y,srcCopy);
end;

procedure TForm1.DrawPomBitmap(x, y: integer);
var Kam,KamTah,Odkud:HDC;
begin
 Odkud:=bPom.Canvas.Handle;
 Kam:=ObrazDC;
 KamTah:=bTah.Canvas.Handle;
 BitBlt(Kam,x,y,iFig,iFig,Odkud,0,0,srcCopy);
 BitBlt(KamTah,x,y,iFig,iFig,Odkud,0,0,srcCopy);
end;

procedure TForm1.DrawFigXY(x, y: integer);
var KamX,KamY,OdkudX,dy,Jaka:integer;
    Kam,Odkud:HDC;
begin
 Jaka:=a[FigX,FigY].Co;
 Kam:=obrazDC;
 Odkud:=bAllFig.Canvas.Handle;
 OdkudX:=iFig*(abs(Jaka)-1);
 if jaka<0 then  dy:=0 else dy:=1;
 BitBlt(Kam,X,Y,iFig,iFig,Odkud,OdkudX,(dy+2)*iFig-dy,srcAND);
 BitBlt(Kam,X,Y,iFig,iFig,Odkud,OdkudX,dy*(iFig-1),srcPAINT);
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var KamenSX,KamenSY,KamenX,KamenY:integer;
    tah:Ttah;
begin
if Posun then begin
  Posun:=false;
  KamenSX:=sx-dx; KamenSY:=sy-dy;
  KamenX:=X-dx; KamenY:=Y-dy;
  if KamenSX<0 then KamenSX:=0;
  if KamenSY<0 then KamenSY:=0;
  if KamenX<0 then KamenX:=0;
  if KamenY<0 then KamenY:=0;
  DrawPomBitmap(KamenSX,KamenSY);
  if Jump(KamenX,KamenY) then begin
   JumpFig(KamenX,KamenY);
   tah:=GenTahRandom(false,barva);
   DrawKamen(tah.CoX,tah.CoY);
   DrawKamen(tah.KamX,tah.KamY);
   DrawFig(tah.KamX,tah.KamY,a[tah.CoX,tah.CoY].Co);
   a[tah.KamX,tah.KamY].Co:=a[tah.CoX,tah.CoY].Co;
   a[tah.CoX,tah.CoY].Co:=0;
   DrawMaskAllFig;
   GenTahy(true,barva);
   end else begin
             DrawKamen(FigX,FigY);
             DrawFig(FigX,FigY,a[FigX,FigY].Co);
            end;
  ResetSigTah;
  Refresh;
end;
end;


procedure TForm1.JumpFig(KamenX, KamenY: integer);
var StredX,StredY,X,Y:integer;
begin
StredX:=KamenX+(iFig div 2);
StredY:=KamenY+(iFig div 2);
TranKamenXY(StredX,StredY,X,Y);
DrawKamen(X,Y);
a[X,Y].Co:=a[FigX,FigY].Co;
a[FigX,FigY].Co:=0;
DrawFig(X,Y,a[X,Y].Co);
end;

procedure TForm1.TranFigXY(x, y: integer; var tx, ty: integer);
var pom:integer;
begin
pom:=bMaskAllFig.Canvas.Pixels[x,y];
tx:=pom and $0f;
ty:=(pom shr 4)and $0f;
end;

procedure TForm1.CopyPomKamen(fx, fy: integer);
var Kam,Odkud:HDC;
begin
 Kam:=bPom.Canvas.Handle;
 if ((fx+fy) mod 2)=1 then Odkud:=bKamenC.Canvas.Handle else
  Odkud:=bKamenB.Canvas.Handle;
 BitBlt(Kam,0,0,iFig,iFig,Odkud,0,0,srcCopy);
end;

procedure TForm1.Refresh;
begin
BitBlt(PaintBox1.Canvas.Handle,0,0,PaintBox1.Width,PaintBox1.Height
       ,ObrazDC,0,0,srcCopy);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
Refresh;
Timer1.Enabled:=false;
end;

end.
