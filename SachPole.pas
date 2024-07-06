unit SachPole;
interface
uses Typy;

type TAddTahPom=class
       private
        PomUk:TSez;
       public
        constructor Initi;
        destructor Free;
        procedure Add(var Kam: TSez;x,y:integer);
        procedure Prepis(var Kam:TSez);
        procedure Clear;
       end;

type TSachPole=class
       private
        a:array[-1..10,-1..10] of record
                                    Co:integer;
                                    Tahy:UkSez;
                                   end;
       public
        AddTahPom:TAddTahPom;
        constructor Initi;
        destructor Free;
        procedure ClearTahy(FigX,FigY:integer);
        function FindTah(FigX,FigY,TahX,TahY:integer): boolean;
        procedure AddTah(FigX,FigY,TahX,TahY:integer);
        procedure Tah(FigX,FigY,TahX,TahY:integer);
        function GetFig(FigX,FigY:integer):integer;
        function GetEnabledFig(FigX,FigY:integer):boolean;
        procedure LoadFromArray(New:TSachPole);
        function SaveToArray:TSachPole;
        procedure SetNewGame(Barva:TBarva);
     end;

var SachPole:TSachPole;

implementation

procedure TAddTahPom.Clear;
begin
self.
end;


end.
