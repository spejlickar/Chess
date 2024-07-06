unit GenAllTah;
interface

 function GenAllTahy(Barva:Tbarva; Kdo:TKdo;):boolean;

implementation

type TResult=record
               x,y:integer;
               Kobila:boolean;
               poc:integer;
              end;

var CB:integer;
    upBdownC:boolean;


procedure SachKralDOSPK(KX,KY:integer;var Vypis:TResult);
var dx,dy,ax,ay,i:integer;
begin
Vypis.Kobila:=false;  Vypis.poc:=0;

if not((upBdownC)xor(CB=1)) then dy:=1 else dy:=-1;
for i:=1 to 2 do begin
 case i of
   1:dx:=1;
   2:dx:=-1;
  end;
 ax:=KX+dx;  ay:=KY+dy;
 if a[ax,ay].Co=-CB*1 then begin
   inc(Vypis.poc);
   Vypis.x:=dx; Vypis.y:=dy;
  end;
end;

for i:=1 to 4 do begin
 case i of
   1:begin dx:=1;  dy:=1;  end;
   2:begin dx:=-1; dy:=-1; end;
   3:begin dx:=1;  dy:=-1; end;
   4:begin dx:=-1; dy:=1;  end;
  end;
 ax:=KX+dx;  ay:=KY+dy;
 while CB*a[ax,ay].Co in[0,6] do begin ax:=ax+dx; ay:=ay+dy; end;
 if -1*CB*a[ax,ay].Co in [3,5] then begin
   inc(Vypis.poc);
   Vypis.x:=dx; Vypis.y:=dy;
  end;
end;

for i:=1 to 4 do begin
 case i of
   1:begin dx:=0;  dy:=1;  end;
   2:begin dx:=0;  dy:=-1; end;
   3:begin dx:=1;  dy:=0;  end;
   4:begin dx:=-1; dy:=0;  end;
  end;
 ax:=KX+dx;  ay:=KY+dy;
 while CB*a[ax,ay].Co in [0,6] do begin ax:=ax+dx; ay:=ay+dy; end;
 if -1*CB*a[ax,ay].Co in [4,5] then begin
   inc(Vypis.poc);
   Vypis.x:=dx; Vypis.y:=dy;
  end;
end;

for i:=1 to 8 do begin
 case i of
   1:begin dx:=1;   dy:=-2; end;
   2:begin dx:=-1;  dy:=2;  end;
   3:begin dx:=-1;  dy:=-2; end;
   4:begin dx:=1;   dy:=2;  end;
   5:begin dx:=2;   dy:=-1; end;
   6:begin dx:=-2;  dy:=1;  end;
   7:begin dx:=-2;  dy:=-1; end;
   8:begin dx:=2;   dy:=1;  end;
  end;
 ax:=KX+dx;  ay:=KY+dy;
 if a[ax,ay].Co=-CB*2 then begin
   inc(Vypis.poc);
   Vypis.x:=dx; Vypis.y:=dy;
  end;
end;

end;

///////////////////////////////////////////////////////////////////

procedure GenPesec(X,Y:integer);
var dx,dy,ax,ay,i,zakladna:integer;
begin
if not((upBdownC)xor(CB=1)) then begin dy:=1; zakladna:=2; end
   else begin dy:=-1; zakladna:=7; end;
for i:=1 to 2 do begin
 case i of
   1:dx:=1;
   2:dx:=-1;
  end;
 ax:=X+dx;  ay:=Y+dy;
 if -1*CB*a[ax,ay].Co in[1..5] then AddTah(a[X,Y].Tahy,ax,ay);
end;
 ax:=X;  ay:=Y+dy;
 if a[ax,ay].Co=0 then AddTah(a[X,Y].Tahy,ax,ay);
 ax:=X;  ay:=Y+2*dy;
 if (a[ax,ay].Co=0)and(Y=zakladna)and(a[ax,ay-dy].Co=0) then
  AddTah(a[X,Y].Tahy,ax,ay);
end;

procedure GenKobila(X,Y:integer);
var dx,dy,ax,ay,i:integer;
begin
for i:=1 to 8 do begin
 case i of
   1:begin dx:=1;   dy:=-2; end;
   2:begin dx:=-1;  dy:=2;  end;
   3:begin dx:=-1;  dy:=-2; end;
   4:begin dx:=1;   dy:=2;  end;
   5:begin dx:=2;   dy:=-1; end;
   6:begin dx:=-2;  dy:=1;  end;
   7:begin dx:=-2;  dy:=-1; end;
   8:begin dx:=2;   dy:=1;  end;
  end;
 ax:=X+dx; ay:=Y+dy;
if -1*CB*a[ax,ay].Co in[0..5] then AddTah(a[X,Y].Tahy,ax,ay);
end;
end;

procedure GenStrelec(X,Y:integer);
var dx,dy,ax,ay,i:integer;
begin
for i:=1 to 4 do begin
 case i of
   1:begin dx:=1;  dy:=1;  end;
   2:begin dx:=-1; dy:=-1; end;
   3:begin dx:=1;  dy:=-1; end;
   4:begin dx:=-1; dy:=1;  end;
  end;
 ax:=X+dx; ay:=Y+dy;
 while a[ax,ay].Co=0 do begin
                          AddTah(a[X,Y].Tahy,ax,ay);
                          ax:=ax+dx;
                          ay:=ay+dy;
                        end;
 if -1*CB*a[ax,ay].Co in[1..5] then AddTah(a[X,Y].Tahy,ax,ay);
end;
end;

procedure GenOhrada(X,Y:integer);
var dx,dy,ax,ay,i:integer;
begin
for i:=1 to 4 do begin
 case i of
   1:begin dx:=0;  dy:=1;  end;
   2:begin dx:=0;  dy:=-1; end;
   3:begin dx:=1;  dy:=0;  end;
   4:begin dx:=-1; dy:=0;  end;
  end;
 ax:=X+dx; ay:=Y+dy;
 while a[ax,ay].Co=0 do begin
                          AddTah(a[X,Y].Tahy,ax,ay);
                          ax:=ax+dx;
                          ay:=ay+dy;
                        end;
 if -1*CB*a[ax,ay].Co in[1..5] then AddTah(a[X,Y].Tahy,ax,ay);
end;
end;

procedure GenKral(X,Y:integer);
var dx,dy,ax,ay,i:integer;
    Vypis:TResult;
begin
for i:=1 to 8 do begin
 case i of
   1:begin dx:=0;  dy:=1;  end;
   2:begin dx:=0;  dy:=-1; end;
   3:begin dx:=1;  dy:=0;  end;
   4:begin dx:=-1; dy:=0;  end;
   5:begin dx:=1;  dy:=1;  end;
   6:begin dx:=-1; dy:=-1; end;
   7:begin dx:=1;  dy:=-1; end;
   8:begin dx:=-1; dy:=1;  end;
  end;
 ax:=X+dx; ay:=Y+dy;
if -1*CB*a[ax,ay].Co in[0..5] then begin
   SachKralDOSPK(ax,ay,Vypis);
   if Vypis.poc=0 then AddTah(a[X,Y].Tahy,ax,ay);
  end;
end;
end;

procedure CelkoveGen;
var X,Y:integer;
begin
for Y:=1 to 8 do begin
 for X:=1 to 8 do begin
  case CB*a[X,Y].Co of
    1:GenPesec(X,Y);
    2:GenKobila(X,Y);
    3:GenStrelec(X,Y);
    4:GenOhrada(X,Y);
    5:begin GenStrelec(X,Y); GenOhrada(X,Y); end;
    6:GenKral(X,Y);
   end;
 end;
end;
end;

procedure TestBlokSach(KX,KY:integer);
var dx,dy,ax,ay,StinX,StinY,i:integer;
    Px,Py,zakladna,pokus:integer;
    pom:UkSez;
    b:boolean;
begin
if not((upBdownC)xor(CB=1)) then begin Py:=1; zakladna:=2; end
   else begin Py:=-1; zakladna:=7; end;

pom:=nil; b:=true;

for i:=1 to 4 do begin
 case i of
   1:begin dx:=1;  dy:=1;  end;
   2:begin dx:=-1; dy:=-1; end;
   3:begin dx:=1;  dy:=-1; end;
   4:begin dx:=-1; dy:=1;  end;
  end;
 ax:=KX+dx;  ay:=KY+dy;
 while a[ax,ay].Co=0 do begin AddTah(pom,ax,ay); ax:=ax+dx; ay:=ay+dy; end;
 if CB*a[ax,ay].Co in[1..5] then begin
   StinX:=ax;  StinY:=ay;
   repeat
     ax:=ax+dx;
     ay:=ay+dy;
     AddTah(pom,ax,ay);
   until a[ax,ay].Co<>0;
   if -1*CB*a[ax,ay].Co in[3,5] then begin
      case a[StinX,StinY].Co*CB of
          1:begin
             ClearTahy(a[StinX,StinY].Tahy);
             if (StinX+1=ax)and(StinY+Py=ay)
                 or(StinX-1=ax)and(StinY+Py=ay) then
                    AddTah(a[StinX,StinY].Tahy,ax,ay);
            end;
        3,5:begin
             ClearTahy(a[StinX,StinY].Tahy);
             a[StinX,StinY].Tahy:=pom;
             b:=false;
            end;
        2,4:ClearTahy(a[StinX,StinY].Tahy);
       end;
    end;
 end;
 if b then ClearTahy(pom) else begin pom:=nil; b:=true; end;
end;


for i:=1 to 4 do begin
 case i of
   1:begin dx:=0;  dy:=1;  end;
   2:begin dx:=0;  dy:=-1; end;
   3:begin dx:=1;  dy:=0;  end;
   4:begin dx:=-1; dy:=0;  end;
  end;
 ax:=KX+dx;  ay:=KY+dy;
 while a[ax,ay].Co=0 do begin AddTah(pom,ax,ay); ax:=ax+dx; ay:=ay+dy; end;
 if CB*a[ax,ay].Co in[1..5] then begin
   StinX:=ax;  StinY:=ay;
   repeat
     ax:=ax+dx;
     ay:=ay+dy;
     AddTah(pom,ax,ay);
   until a[ax,ay].Co<>0;
   if -1*CB*a[ax,ay].Co in[4,5] then begin
      case a[StinX,StinY].Co*CB of
          1:begin
             ClearTahy(a[StinX,StinY].Tahy);
             if a[StinX,StinY+Py].Co=0 then begin
               pokus:=0;
               AddTah(a[StinX,StinY].Tahy,StinX,StinY+Py);
              end;
             if (StinY=zakladna)and(a[StinX,StinY+2*Py].Co=0)
               and(a[StinX,StinY+Py].Co=0) then
               AddTah(a[StinX,StinY].Tahy,StinX,StinY+2*Py);
            end;
        4,5:begin
             ClearTahy(a[StinX,StinY].Tahy);
             a[StinX,StinY].Tahy:=pom;
             b:=false;
            end;
        2,3:ClearTahy(a[StinX,StinY].Tahy);
       end;
    end;
 end;
 if b then ClearTahy(pom) else begin pom:=nil; b:=true; end;
end;


end;

function AddTahGotoXY(X,Y:integer):boolean;
var dx,dy,ax,ay,i,zakladna:integer;
begin
Result:=True;

if not((upBdownC)xor(CB=1)) then begin dy:=1; zakladna:=2; end
   else begin dy:=-1; zakladna:=7; end;

for i:=1 to 2 do begin
 case i of
   1:dx:=1;
   2:dx:=-1;
  end;
 ax:=X+dx;  ay:=Y-dy;
 if (a[ax,ay].Co=CB*1)and(-1*CB*a[X,Y].Co in[1..4]) then begin
               AddTah(a[ax,ay].Tahy,X,Y);
               Result:=false;
              end;
end;
 ax:=X; ay:=Y-dy;
 if (a[ax,ay].Co=CB*1)and(a[X,Y].Co=0) then begin
               AddTah(a[ax,ay].Tahy,X,Y);
               Result:=false;
              end;
 ax:=X; ay:=Y-2*dy;
 if (a[ax,ay].Co=CB*1)and(a[X,Y].Co=0)and(zakladna=ay) then begin
               AddTah(a[ax,ay].Tahy,X,Y);
               Result:=false;
              end;

for i:=1 to 4 do begin
 case i of
   1:begin dx:=1;  dy:=1;  end;
   2:begin dx:=-1; dy:=-1; end;
   3:begin dx:=1;  dy:=-1; end;
   4:begin dx:=-1; dy:=1;  end;
  end;
 ax:=X+dx;  ay:=Y+dy;
 while a[ax,ay].Co=0 do begin ax:=ax+dx; ay:=ay+dy; end;
 if CB*a[ax,ay].Co in [3,5] then
                         begin AddTah(a[ax,ay].Tahy,X,Y); Result:=false; end;
end;

for i:=1 to 4 do begin
 case i of
   1:begin dx:=0;  dy:=1;  end;
   2:begin dx:=0;  dy:=-1; end;
   3:begin dx:=1;  dy:=0;  end;
   4:begin dx:=-1; dy:=0;  end;
  end;
 ax:=X+dx;  ay:=Y+dy;
 while a[ax,ay].Co=0 do begin ax:=ax+dx; ay:=ay+dy; end;
 if CB*a[ax,ay].Co in [4,5] then
                          begin AddTah(a[ax,ay].Tahy,X,Y); Result:=false; end;
end;

for i:=1 to 8 do begin
 case i of
   1:begin dx:=1;   dy:=-2; end;
   2:begin dx:=-1;  dy:=2;  end;
   3:begin dx:=-1;  dy:=-2; end;
   4:begin dx:=1;   dy:=2;  end;
   5:begin dx:=2;   dy:=-1; end;
   6:begin dx:=-2;  dy:=1;  end;
   7:begin dx:=-2;  dy:=-1; end;
   8:begin dx:=2;   dy:=1;  end;
  end;
 ax:=X+dx;  ay:=Y+dy;
 if a[ax,ay].Co=CB*2 then begin AddTah(a[ax,ay].Tahy,X,Y); Result:=false; end;
end;

end;


function ZabranSachK(Vypis:TResult):boolean;
begin
Result:=AddTahGotoXY(Vypis.x,Vypis.y);
end;

function ZabranSachDOSP(Vypis:TResult;KX,KY:integer):boolean;
var ax,ay:integer;
begin
Result:=true;
ax:=KX;  ay:=KY;
repeat
ax:=ax+Vypis.x;
ay:=ay+Vypis.y;
if not AddTahGotoXY(ax,ay) then Result:=false;
until a[ax,ay].Co<>0;
end;

function UhybSach(KX,KY:integer):boolean;
var dx,dy,ax,ay,i:integer;
    Vypis:TResult;
begin
Result:=true;
for i:=1 to 8 do begin
 case i of
   1:begin dx:=0;  dy:=1;  end;
   2:begin dx:=0;  dy:=-1; end;
   3:begin dx:=1;  dy:=0;  end;
   4:begin dx:=-1; dy:=0;  end;
   5:begin dx:=1;  dy:=1;  end;
   6:begin dx:=-1; dy:=-1; end;
   7:begin dx:=1;  dy:=-1; end;
   8:begin dx:=-1; dy:=1;  end;
  end;
 ax:=KX+dx; ay:=KY+dy;
if -1*CB*a[ax,ay].Co in [0..5] then begin
   SachKralDOSPK(ax,ay,Vypis);
   if Vypis.poc=0 then begin
                        AddTah(a[KX,KY].Tahy,ax,ay);
                        Result:=false;
                       end;
  end;
end;
end;



function GenTahy(CerBil,Barva:boolean):boolean;
{True=>cerne,False=>bile}
var Vypis:TResult;
    x,y,KralX,KralY:integer;
    pom:boolean;
begin
ClearA;
upBdownC:=Barva;    Result:=false;
if CerBil then CB:=1 else CB:=-1;
for x:=1 to 8 do
 for y:=1 to 8 do
  if a[x,y].Co=6*CB then begin KralX:=x; KralY:=y; end;
SachKralDOSPK(KralX,KralY,Vypis);
case Vypis.poc of
  0:begin CelkoveGen; TestBlokSach(KralX,KralY); end;
  1:begin
      if Vypis.Kobila then pom:=ZabranSachK(Vypis)
        else pom:=ZabranSachDOSP(Vypis,KralX,KralY);
      Result:=UhybSach(KralX,KralY) and pom ;
    end;
  2:Result:=UhybSach(KralX,KralY);
 end;
end;

end.
