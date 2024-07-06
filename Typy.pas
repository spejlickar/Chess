unit Typy;
interface
type  TBarva=(DownBlack,DownWhite);
      TKdo=(Black,White);
      TSachPole=array[1..8,1..8] of integer;
      TSez=^Sez;
      Zaz=record
            x,y:integer;
          end;
      Sez=Record
            Vek:Zaz;
            Nasl:UkSez;
          end;

implementation
end.
