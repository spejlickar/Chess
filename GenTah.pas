unit GenTah;
interface

type Ttah=record
            Mat:boolean;
            CoX,CoY:integer;
            KamX,KamY:integer;
           end;

function GenTahRandom(CerBil,Barva:boolean):Ttah;

implementation

function GenTahRandom(CerBil,Barva:boolean):Ttah;
type Tpolozka=record
                CoX,CoY:integer;
                KamX,KamY:integer;
               end;
var acc:array[1..100] of Tpolozka;
    delka,ran,CoX,CoY,KamY,KamX:integer;
begin
if GenTahy(CerBil,Barva) then Result.Mat:=true else begin
 Result.Mat:=false;
 delka:=0;
 for CoY:=1 to 8 do
  for CoX:=1 to 8 do
   for KamY:=1 to 8 do
    for KamX:=1 to 8 do
     if FindTah(KamX,KamY,a[CoX,CoY].Tahy) then begin
       inc(delka);
       acc[delka].CoX:=CoX;
       acc[delka].CoY:=CoY;
       acc[delka].KamX:=KamX;
       acc[delka].KamY:=KamY;
      end;
 Randomize;
 ran:=Random(delka)+1;
 Result.CoX:=acc[ran].CoX;
 Result.CoY:=acc[ran].CoY;
 Result.KamX:=acc[ran].KamX;
 Result.KamY:=acc[ran].KamY;
end;
end;


end.
