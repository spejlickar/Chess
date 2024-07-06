unit SachControl;
interface

uses unit1;

type TAktuel=class
        private
         ob:Tform;
         CoX,Coy:integer;
         KamX,KamY:integer;
         sx,sy:integer;
         Posun:boolean;
         procedure MouseUp(x,y:integer);virtual;
         procedure MouseMove(x,y:integer);virtual;
         procedure MouseDown(x,y:integer);virtual;
         procedure KeyUp(Key:word);virtual;
         procedure SecondPlayer(Tah:string);virtual;

       end;


implementation

end.
