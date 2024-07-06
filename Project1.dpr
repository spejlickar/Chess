program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas',
  DynPole in 'DynPole.pas',
  GenTah in 'GenTah.pas',
  SachPole in 'SachPole.pas',
  Typy in 'Typy.pas',
  Stav in 'Stav.pas',
  SachControl in 'SachControl.pas',
  MGraph in 'MGraph.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
