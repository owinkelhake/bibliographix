unit unitneu;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  clipbrd,
  LCLType, // für vk_return
  SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type

  { TFormNeu }

  TFormNeu = class(TForm)
    EingabeTitelNeueNotiz: TEdit;
    Image9: TImage;
    Label1: TLabel;
    Label4: TLabel;
    OptionMitVerweis: TCheckBox;
    Panel1: TPanel;
    PanelF2: TPanel;
    PanelUnterstrich: TPanel;
    PanelF3: TPanel;
    procedure Button2Click(Sender: TObject);
    procedure ButtonDialogNeueNotizClick(Sender: TObject);
    procedure EingabeTitelNeueNotizKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Label1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure PanelF3Click(Sender: TObject);
    procedure RegisterNeuChange(Sender: TObject);
  private

  public

  end;

var
  FormNeu: TFormNeu;

implementation
uses unit1;
{$R *.lfm}

{ TFormNeu }

procedure TFormNeu.FormCreate(Sender: TObject);
begin

end;

procedure TFormNeu.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
    if key=vk_escape then close;
end;

procedure TFormNeu.Label1Click(Sender: TObject);
begin
  OptionMitVerweis.checked:=not OptionMitVerweis.checked;
end;

procedure TFormNeu.Panel2Click(Sender: TObject);
begin
    close;
  exit;  { damit im Hauptfenster nicht auch ein ESC ausgelöst wird }
end;

procedure TFormNeu.PanelF3Click(Sender: TObject);
begin
   Close;
   fenster.IconNeueQuelleClick(self) ;
end;

procedure TFormNeu.Button2Click(Sender: TObject);
begin

end;

procedure TFormNeu.ButtonDialogNeueNotizClick(Sender: TObject);
var
   alteZeile:        integer;
   AlterTyp:         string;
   Anlegen:          boolean;
   i:                integer;
   linkalt:          string;
   linkneu:          string;
   NeueID:           string;
   NeuerTitel:       string;
   NeuerTitel2:      string;
   NeueZeile:        integer;
begin
     AlterTyp:=  AngezeigterTyp ;
     //Die Links werden standardmäßig erzeugt, aber vielleicht nicht verwendet.
      if AlterTyp='N' then
      begin
           alteZeile:= AktuelleNotizenArrayZeile;
           linkalt:='note://' + AktuelleNotizID + ' ' + Daten[AktuelleNotizenArrayZeile,Spalte_Titel];
      end;
      if Altertyp='L' then
      begin
           alteZeile:= AktuelleLiteraturArrayZeile;
           linkalt:='ref://' + AktuelleLiteraturID + ' '
                             + Literatur[AktuelleLiteraturArrayZeile,Spalte_Erstautor] + ' ('
                             + Literatur[AktuelleLiteraturArrayZeile,Spalte_Jahr] + ') '
                             + Literatur[AktuelleLiteraturArrayZeile,Spalte_Titel]
                             ;
      end;



     
     neuertitel := EingabeTitelNeueNotiz.text   ;
     anlegen:=true;
     if length(neuertitel) = 0  then  anlegen:=false;

     if anlegen then
     begin
          neuertitel2 := ansilowercase(neuerTitel);
          for i := 1 to ArraySize do
          begin
               if ansilowercase(Daten[i, Spalte_Titel]) = neuertitel2 then
               begin
                    showmsg('Eine Notiz mit diesem Titel gibt es schon') ;
                    anlegen:=false;
               end;
          end;
     end;

     if anlegen  then
     begin
          //Fenster.IconAllesSpeichernClick(self);
          Aenderungen:=Aenderungen+100;
          //RahmenDaten der neuen Notiz---
          //------------------------------
          IncreaseMaxID('Daten'); // ID der bisher hgöchsten Karte eins hochzählen.
          neueZeile :=getTopEmptyRow('daten');  //In die erste freie Zeile am
                                                //Ende des Arrays schreiben

          machpause();
          linkalt:= StringReplace(linkalt,' ' , '_', [rfReplaceAll])+ ' ';


          NeueID:= IntToStr(GetMaxID('Daten'));
          Daten[NeueZeile, Spalte_ID]:= NeueID ;
          Daten[NeueZeile, Spalte_Bearbeitungsdatum] := formatdatetime('yyyymmddhhnn', now);
          Daten[NeueZeile, Spalte_Erstelldatum] :=   formatdatetime('yyyymmddhhnn', now);
          Daten[NeueZeile, Spalte_Titel] :=   Neuertitel;
          if Optionmitverweis.checked then Daten[NeueZeile, Spalte_Anmerkung]:=linkalt;
          NotizenDatensatzZahl:=NotizenDatensatzZahl +1;

          linkneu:='note://' + neueID+ ' ' + neuertitel;
          linkneu:= ' ' + StringReplace(linkneu,' ' , '_', [rfReplaceAll])+ ' ';

          if Optionmitverweis.checked then
          begin
               if Altertyp='N' then
               begin
                    if os='win' then
                    begin
                       clipboard.astext:=linkneu;
                       Fenster.Feldinhalt.PasteFromClipboard
                    end else begin
                        Daten[AlteZeile,Spalte_Anmerkung]:=Daten[AlteZeile,Spalte_Anmerkung] + linkneu;
                    end;
                    Daten[AlteZeile, Spalte_Bearbeitungsdatum] :=          formatdatetime('yyyymmddhhnn', now);
                    ichanged:=true;
               end;
               if Altertyp='L' then
               begin
                    if os='win' then
                    begin
                       clipboard.astext:=linkneu;
                       Fenster.Feldinhalt.PasteFromClipboard
                    end else begin
                        Literatur[AlteZeile,Spalte_Anmerkung]:=Literatur[AlteZeile,Spalte_Anmerkung] + linkneu;
                    end;
                    Literatur[AlteZeile, Spalte_Bearbeitungsdatum] :=  formatdatetime('yyyymmddhhnn', now);
                    lchanged:=true;
               end;
          end;



          ichanged:=true;

          sortdb('notizen',sortierenab_daten);  //damit die neue Notiz ganz nach vorn kommt
          with fenster do
          begin
              FeldInhalt.ReadOnly:=False;
              AlleAnzeigenClick(self);
              for i:=0 to  Liste.Rowcount-1    do
              begin
                    if TrefferArray[i,TrefferArraySpalteTitel]=NeuerTitel then
                    begin
                         Liste.Row:=i;
                         break;
                    end;
              end;
              If Feldinhalt.visible then
              begin
                   FeldInhalt.SetFocus;
                   Feldinhalt.SelStart:=1000;
                   formatmd(0,100,false);
              end;
          end;
          fenster.timer.enabled:=false;
          fenster.timer.enabled:=true;
          fenster.FeldInhalt.SetFocus;
     end;

  close;
end;

procedure TFormNeu.EingabeTitelNeueNotizKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then ButtonDialogNeueNotizClick(self);
  if key = vk_escape then close;
end;

procedure TFormNeu.RegisterNeuChange(Sender: TObject);
begin

end;

end.

