program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1, dialogs, lazcontrols, unitquerverweis, unitneu,
  unittitel;

{$R *.res}

begin
  Application.Scaled:=True;
  Application.Title:='Bibliographix';
  Application.Initialize;
  Application.CreateForm(TFenster, Fenster);
  Application.CreateForm(TQVerweis, QVerweis);
  Application.CreateForm(TFormNeu, FormNeu);
  Application.CreateForm(TFormTiteldaten, FormTiteldaten);
  Application.Run;
end.

