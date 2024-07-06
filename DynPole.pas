unit DynPole;
interface
uses Typy;

type TDynPole=class
       public
        procedure ClearTahy(var Kde: TSez);
        function FindTah(Kde: TSez; TahX,TahY:integer): boolean;
        procedure AddTah(var Kde:TSez; TahX,TahY:integer);
       end;

implementation

procedure TDynPole.ClearTahy(var Jake: UkSez);
var pom1,pom2:UkSez;
begin
pom1:=Jake;
while pom1<>nil do begin
 pom2:=pom1^.Nasl;
 dispose(pom1);
 pom1:=pom2;
end;
Jake:=nil;
end;

function TDynPole.FindTah(x,y:integer; Kde: UkSez): boolean;
var pom:UkSez;
begin
Result:=false;
pom:=Kde;
while (pom<>nil)and(not(Result)) do begin
 if (pom^.Vek.x=x)and(pom^.Vek.y=y) then result:=true;
 pom:=pom^.Nasl;
end;
end;

procedure TDynPole.AddTah(var Kam: UkSez;x,y:integer);
var pom:UkSez;
begin
if Kam=nil then begin
        new(Kam);
        Kam^.Vek.x:=x;
        Kam^.Vek.y:=y;
        Kam^.Nasl:=nil;
      end
else begin
pom:=Kam;
while pom^.Nasl<>nil do pom:=pom^.Nasl;
new(pom^.Nasl);
pom:=pom^.Nasl;
pom^.Vek.x:=x;
pom^.Vek.y:=y;
pom^.Nasl:=nil;
end;
end;

end.
