unit unitquerverweis;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  Clipbrd,
  LCLType, // für vk_return
  RichMemo,  //für formatmd
  SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, ComCtrls;

type

  { TQVerweis }

  TQVerweis = class(TForm)
    Bevel1: TBevel;
    Label5: TLabel;
    Label1: TLabel;
    AnzeigeTitel: TLabel;
    LabelTrefferzahl: TLabel;
    OptionSortAlphabet: TCheckBox;
    Panel1: TPanel;
    Panel19: TPanel;
    Panel2: TPanel;
    ButtonGliedern: TPanel;
    ButtonAnlegen: TPanel;
    QListe: TListBox;
    QSuche: TEdit;
    QuerverweisAllesZeigen: TImage;
    procedure ButtonGliedernClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ButtonAnlegenClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure OptionSortAlphabetChange(Sender: TObject);
    procedure OptionSortAlphabetClick(Sender: TObject);
    procedure QListeClick(Sender: TObject);
    procedure QListeDblClick(Sender: TObject);
    procedure QSucheKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure QuerverweisAllesZeigenClick(Sender: TObject);
  private

  public

  end;

var
  QVerweis: TQVerweis;


  qarray:    array[0..1001,1..4] of string;

implementation
uses unit1;
{$R *.lfm}

{ TQVerweis }

function sortqlist(treffer:integer;kriterium:string):boolean ;
var
  ar:array[1..4] of string;
  h:             integer;
  i,j,k:     integer ;
  tauschen:  boolean;
begin
       qverweis.qliste.items.clear;
       for i:=1 to treffer do
       begin
           for j:=i+1 to treffer do
           begin
                tauschen:=false;
                if kriterium='zeit' then
                begin
                    if  qarray[i,4]< qarray[j,4] then tauschen:=true;
                end else begin
                    if  qarray[i,1]> qarray[j,1] then tauschen:=true;
                end;

                //if  qarray[i,4]< qarray[j,4] then         //4 = datum 1=titel
                if  tauschen then
                begin
                     for k:=1 to 4 do ar[k]:= qarray[i,k];
                     for k:=1 to 4 do qarray[i,k]:= qarray[j,k];
                     for k:=1 to 4 do qarray[j,k]:= ar[k];
                end;
           end;
       end;
       for i:=1 to treffer do   qverweis.qliste.items.add(qarray[i,1]);
       machpause();
       i:=0;                          //leere Zeilen am Anfang der Listbox
       qverweis.qliste.topindex:=0;   //wegscrollen. Ist einfacher als die
       for i:=1 to treffer do         //Zeilen zu löschen, weil es unter
       begin                          //schiedlich viele Leerzeilen geben
           if qarray[i,1]=''          //kann
           then  qverweis.qliste.topindex:=qverweis.qliste.topindex+1
           else break;
       end;
       // Fensterhöhe ggf. anpassen
       if treffer < 15 then
       begin
            h:=treffer*30+ 170;
            if h < fenster.Height then qverweis.height:=h;
       end else begin
           qverweis.height:=Fenster.Top - Qverweis.top+ Fenster.Height - 50;
       end;



end;

procedure TQVerweis.QSucheKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   begriff1:    string;
   begriff2:    string;
   i:           integer;
   j:           integer;
   max:         integer;
   treffer:     integer;
   zit:         string;
begin
   begriff1:=ansilowercase(QSuche.Text) ;
   max:=1000;
   if pos(' ',begriff1) > 0 then
   begin
       begriff2:=getlastword(begriff1);
       begriff1:=deletelastword(begriff1);
   end else begin
       if begriff1='' then begriff1:=' ';
       begriff2:=begriff1;
   end;
   if length(begriff1) > 1 then
   begin
         qliste.items.clear;
         treffer:=0 ;
         for i:=1 to max do
             for j:=1 to 4 do qarray[i,j]:='';

         //beide Datenbanken werden separat durchsucht, damit die erste Datenbank
         //nicht alle Treffer abdeckt von von den max. Treffern für die zweite
         //keine übrigbleiben.
         for i:=arraysize downto 1 do
         begin
             //Zuerst die Notizen durchsuchen
             if  (pos(begriff1,daten[i,Spalte_Volltext])> 0)
             and (pos(begriff2,daten[i,Spalte_Volltext])> 0)
             then begin
                 treffer:=treffer+1;
                 qarray[treffer,1]:= daten[i,Spalte_Titel];
                 qarray[treffer,2]:= 'N';
                 qarray[treffer,3]:= daten[i,Spalte_ID]  ;
                 qarray[treffer,4]:= daten[i,Spalte_Bearbeitungsdatum]  ;
             end;
             //Jetzt die Literatur
             if  (pos(begriff1,literatur[i,Spalte_Volltext])> 0)
             and (pos(begriff2,literatur[i,Spalte_Volltext])> 0)
             then  begin
                 zit:=  literatur[i,Spalte_Erstautor] + ' (' +
                        literatur[i,Spalte_Jahr] + ') ' +
                        literatur[i,Spalte_Titel];
                 zit:=copy(zit,1,60);
                 if length(zit) > 59 then zit:=deletelastword(zit);
                 treffer:=treffer+1;
                 qarray[treffer,1]:= zit;
                 qarray[treffer,2]:= 'L';
                 qarray[treffer,3]:= Literatur[i,Spalte_ID]  ;
                 qarray[treffer,4]:= Literatur[i,Spalte_Bearbeitungsdatum]  ;

             end;
             if treffer > max then break;

         end;

         //Liste mit bubblesort sortieren und ausgeben
         labelTrefferzahl.caption:=inttostr(treffer) + ' Treffer';
         qliste.ItemHeight:=16;
         if optionsortalphabet.checked then  sortqlist(treffer+1,'az')
                                       else  sortqlist(treffer+1,'zeit');
                                       {02/2024}
   end;

end;

procedure TQVerweis.ButtonAnlegenClick(Sender: TObject);
var
   cur:  integer;
   i:    integer;
   l:    string;

begin
     l:='';
     if qliste.ItemIndex > -1 then
     begin
           i:=qliste.itemindex +1 ;
           cur:=Fenster.Feldinhalt.selstart;
           if Qarray[i,2]='N' then
           begin
             l:='note://' + Qarray[i,3] + ' ' + Qarray[i,1];
           end;

           if Qarray[i,2]='L' then
           begin
             l:='ref://' + Qarray[i,3] + ' ' + Qarray[i,1];
           end;

           //Das Link in die Anmerkungen
           l:=' ' + StringReplace(l,' ' , '_', [rfReplaceAll])+ ' ';
           if fenster.Feldinhalt.SelStart>-1 then  paste(l);
           IsTextChanged:=true; //sonst wird evtl. nicht abgespeichert 02/2024
            savechangestoarray();
           machpause();
           formatmd(0,10000,false); //das ist umständlich, aber der Absatz wird evtl.
           machpause();       //nicht richtig erkannt. Also alles neuformatieren
           qliste.ItemIndex :=-1;
           Fenster.Feldinhalt.selstart:=cur + length(l); //Cursor hinter den QV
     end;
end;

procedure TQVerweis.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if key=vk_escape then
  begin

       close;
       exit;  { damit im Hauptfenster nicht auch ein ESC ausgelöst wird }
  end;
end;

procedure TQVerweis.FormShow(Sender: TObject);
begin
  Fenster.FormChangeBounds(self);
end;

procedure TQVerweis.Label5Click(Sender: TObject);
begin
  OptionsortAlphabet.checked:=not OptionsortAlphabet.checked;
end;

procedure TQVerweis.OptionSortAlphabetChange(Sender: TObject);
begin

end;

procedure TQVerweis.OptionSortAlphabetClick(Sender: TObject);
begin
  if OptionsortAlphabet.checked then sortqlist(Qliste.items.count,'az')
                                else sortqlist(Qliste.items.count,'zeit')
end;

procedure TQVerweis.QListeClick(Sender: TObject);
begin
   AnzeigeTitel.caption:= Qarray[qliste.itemindex +1,1];
end;

procedure TQVerweis.QListeDblClick(Sender: TObject);
begin
  if ButtonAnlegen.Visible then ButtonAnlegenClick(self);
end;

procedure TQVerweis.Button1Click(Sender: TObject);
begin
  Fenster.Feldinhalt.setfocus;

  Qverweis.close;
  qverweis.visible:=false;

end;

procedure TQVerweis.ButtonGliedernClick(Sender: TObject);
var
   i:integer;

  punkt: Ttreenode;
  l:string;
begin
     l:='';
     if qliste.ItemIndex > -1 then
     begin
           i:=qliste.itemindex +1 ;
           if Qarray[i,2]='N' then
             l:=Qarray[i,1] + abstand +   '(#' +  Qarray[i,3];
           if Qarray[i,2]='L' then
             l:=Qarray[i,1] + abstand + '(LI' +  Qarray[i,3];

           with fenster do
           begin
                 if (RegisterSuche.Activepage=SeiteGliederung)  then
                     begin
                            if gliederung.selected <> nil then
                            begin
                                 // showmessage('letzter');
                                 machpause();
                                 punkt := Gliederung.Items.AddChild(Gliederung.Selected, l );
                                 Gliederung.selected.Expand(True);

                            end else begin  // kein Eintrag ausgewählt, also ans ende
                                //showmessage('mair');
                                machpause();
                                punkt := Gliederung.Items.Add(nil, l );
                                Gliederung.Fullexpand;
                                GliederungArrayEinlesen();
                                timer.Enabled:=true;
                            end;
                            GliederungSpeichern(DBDirectory + Gliederungsdatei);
                            GliederungArrayEinlesen();
                            punkt.Selected := True;
                end else begin //das Gliederungsfenster ist nicht sichbar
                         showmsg('Oops... Bitte wechseln Sie in die Gliederungsansicht');
                end;


          end;
     end;
end;

procedure TQVerweis.QuerverweisAllesZeigenClick(Sender: TObject);
var
   i:          integer;
   treffer:    integer ;
   zit:        string;
begin
     machpause();
     qsuche.text:='';
     treffer:=1 ;
     qliste.items.clear;
     machpause() ;
                 { hier greife ich auf die globale Variable MINDESTDATUM zurück.
                   die ich im Hauptfenster in ALLEZETTELANZEIGEN erzeugt habe.
                   Die gibt eine vernünftiges Mindestdatum an, das hinreichend
                   viele Treffer zeigt }
     for i:=arraysize downto 1 do
     begin
         if  (daten[i,Spalte_Bearbeitungsdatum]> MindestDatum) then
         begin
                qarray[treffer,1]:= daten[i,Spalte_Titel];
                qarray[treffer,2]:= 'N';
                qarray[treffer,3]:= daten[i,Spalte_ID]  ;
                qarray[treffer,4]:= daten[i,Spalte_Bearbeitungsdatum]  ;
                treffer:=treffer+1;
          end;

          if  (Literatur[i,Spalte_Bearbeitungsdatum]> MindestDatum) then
          begin
               zit:=  literatur[i,Spalte_Erstautor] + ' (' +
                      literatur[i,Spalte_Jahr] + ') ' +
                      literatur[i,Spalte_Titel];
               zit:=copy(zit,1,60);
               if length(zit) > 59 then zit:=deletelastword(zit);
               qarray[treffer,1]:= zit;
               qarray[treffer,2]:= 'L';
               qarray[treffer,3]:= Literatur[i,Spalte_ID]  ;
               qarray[treffer,4]:= Literatur[i,Spalte_Bearbeitungsdatum]  ;
               treffer:=treffer+1;
          end;




     end;

     machpause();
     sortqlist(treffer,'zeit');
     machpause();
     Qverweis.qsuche.Setfocus;
end;

end.

