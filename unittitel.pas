unit unittitel;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  Clipbrd,  //für clipboard
  SysUtils, FileUtil, Forms, Controls, Graphics,
  LCLType, // für vk_return
  lclintf, // für openurl
  Dialogs, StdCtrls,
  ExtCtrls, Buttons, Types;

type

  { TFormTiteldaten }

  TFormTiteldaten = class(TForm)
    Bevel1: TBevel;
    Bevel11: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    CaptionAutoComplete: TPanel;
    LabelAutor: TEdit;
    EingabeAuflage: TEdit;
    EingabeAutor: TEdit;
    EingabeBand: TEdit;
    EingabeDatum: TEdit;
    EingabeHerausgeber: TEdit;
    EingabeISBN: TEdit;
    EingabeJahr: TEdit;
    EingabeNummer: TEdit;
    EingabeOrt: TEdit;
    EingabeSammelband: TEdit;
    EingabeSeiten: TEdit;
    EingabeTitel: TEdit;
    EingabeUntertitel: TEdit;
    EingabeVerlag: TEdit;
    EingabeZeitschrift: TEdit;
    Label1: TLabel;
    LabelAutor1: TEdit;
    LabelAutor10: TEdit;
    LabelAutor11: TEdit;
    LabelAutor12: TEdit;
    LabelAutor13: TEdit;
    LabelAutor14: TEdit;
    LabelAutor2: TEdit;
    LabelAutor3: TEdit;
    LabelAutor4: TEdit;
    LabelAutor5: TEdit;
    LabelAutor6: TEdit;
    LabelAutor7: TEdit;
    LabelAutor8: TEdit;
    LabelAutor9: TEdit;
    Label3: TLabel;
    Labelsyntax: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ListeVorschlagNamen: TListBox;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Jahreszahl: TPanel;
    Panel14: TPanel;
    ButtonScholar: TPanel;
    Panel2: TPanel;
    Panel22: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    PanelAutoComplete: TPanel;
    RadioArtikel: TRadioButton;
    RadioKapitel: TRadioButton;
    RadioBuch: TRadioButton;
    RadioSammelband: TRadioButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure ButtonScholarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ButtonJahrEintragenClick(Sender: TObject);
    procedure ButtonSpeichernClick(Sender: TObject);
    procedure LabelAutorChange(Sender: TObject);
    procedure EingabeAutorEnter(Sender: TObject);
    procedure EingabeAutorExit(Sender: TObject);
    procedure EingabeAutorKeyPress(Sender: TObject; var Key: char);
    procedure EingabeAutorKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EingabeDatumKeyPress(Sender: TObject; var Key: char);
    procedure EingabeHerausgeberKeyPress(Sender: TObject; var Key: char);
    procedure EingabeHerausgeberKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EingabeJahrClick(Sender: TObject);
    procedure EingabeOrtEnter(Sender: TObject);
    procedure EingabeOrtKeyPress(Sender: TObject; var Key: char);
    procedure EingabeOrtKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure EingabeSeitenKeyPress(Sender: TObject; var Key: char);
    procedure EingabeTitelEnter(Sender: TObject);
    procedure EingabeTypChange(Sender: TObject);
    procedure EingabeVerlagChange(Sender: TObject);
    procedure EingabeVerlagKeyPress(Sender: TObject; var Key: char);
    procedure EingabeVerlagKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EingabeZeitschriftKeyPress(Sender: TObject; var Key: char);
    procedure EingabeZeitschriftKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure JahreszahlClick(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure ListeVorschlagNamenClick(Sender: TObject);
    procedure ListeVorschlagNamenContextPopup(Sender: TObject;
      MousePos: TPoint; var Handled: Boolean);
    procedure ListeVorschlagNamenKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListeVorschlagNamenMouseWheel(Sender: TObject;
      Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
      var Handled: Boolean);
    procedure Panel22Click(Sender: TObject);
    procedure xxxClick(Sender: TObject);
  private

  public

  end;

var
  FormTiteldaten: TFormTiteldaten;

implementation
uses unit1;
{$R *.lfm}

{ TFormTiteldaten }
function FindeVerlagsOrt(verlag:string):boolean;
var
  i:     integer;
begin
          for i:=GetTopEmptyRow('Literatur')  downto 1 do
          begin
               if (pos(verlag,Literatur[i,Spalte_Verlag])=1)  then
               begin
                    FormTiteldaten.EingabeOrt.Text:= Literatur[i,Spalte_Ort] ;
                    break;
               end;
          end;
          result:=true;
end;

function AutoComplete(feld,t:string):boolean  ;
var
   a: string;
   i: integer;
   TL:string;
   maxitems:integer;
begin
        tl:=' ';
        maxitems:=7; //Zu viel Scrollen. Wird nicht mehr angezeigt.
        FormTitelDaten.ListeVorschlagNamen.Sorted:=false;
        FormTitelDaten.ListeVorschlagNamen.items.clear;

        //=== AUTORFELD ===
        //=================
        if (feld='Autoren') then
        begin
            with formtiteldaten do
            begin
                  panelAutoComplete.left:=EingabeAutor.left +25;
                  PanelAutocomplete.top:=100;
                  PanelAutocomplete.height:=250;
                  for i:=GetTopEmptyRow('Literatur')  downto 1 do
                  begin
                       if (pos(t,Literatur[i,Spalte_Autor])>0) or (pos(t,Literatur[i,Spalte_Herausgeber])>0) then
                       begin
                          a:=Literatur[i,Spalte_Autor] + ';' + Literatur[i,1] + ';' ;
                          a:=copy(a,pos(t,a),200); //Name großzügig ausgeschnitten
                          a:=copy(a,1,pos(';',a)-1); //Ende Weg
                          a:=trim(A);
                          if (pos(a,tl)=0) and (a <> t)  then //Der Name ist ein Treffer und neu
                          begin
                               tl:= tl+ a + ' ';
                               FormTitelDaten.ListeVorschlagNamen.items.add(a);
                               if  FormTitelDaten.ListeVorschlagNamen.items.count > maxitems then break;
                          end;
                       end;
                  end;
            end;
        end;
        //====ZEITSCHRIFTEN=====
        //======================
        if (feld='Zeitschriften') then
        begin
            with formtiteldaten do
            begin
                  panelAutoComplete.left:=EingabeZeitschrift.left +180;
                  PanelAutocomplete.top:=300;
                  PanelAutocomplete.height:=200;
                  for i:=GetTopEmptyRow('Literatur')  downto 1 do
                  begin
                       //3=Autor; 12=Herausgeber 8=Zeitschrift
                       if (pos(ansilowercase(t),ansilowercase(Literatur[i,Spalte_Zeitschrift]))=1)  then    //07 21: nicht mehr Fragment, sondern Anfang
                       begin
                          a:=trim(Literatur[i,Spalte_Zeitschrift]);
                          if (pos(ansilowercase(a),tl)=0)  and (a <> t)  then //Der Name ist ein Treffer und neu
                          begin
                               tl:= tl+ ansilowercase(a) + ' ';
                               FormTitelDaten.ListeVorschlagNamen.items.add(a);
                               if  FormTitelDaten.ListeVorschlagNamen.items.count > maxitems then break;
                          end;
                       end;
                  end;

            end;
        end;
        //===VERLAG===
        //============
        if (feld='Verlage') then
        begin
            with formtiteldaten do
            begin
                  panelAutoComplete.left:=EingabeOrt.left -20;
                  PanelAutocomplete.top:=200;
                  PanelAutocomplete.height:=150;
                  for i:=GetTopEmptyRow('Literatur')  downto 1 do
                  begin

                       if (pos(t,Literatur[i,Spalte_Verlag])>0)  then
                       begin
                          a:=trim(Literatur[i,Spalte_Verlag]);
                          if (pos(a,tl)=0)  and (a <> t) then //Der Name ist ein Treffer und neu
                          begin
                               tl:= tl+ a + ' ';
                               FormTitelDaten.ListeVorschlagNamen.items.add(a);
                               if  FormTitelDaten.ListeVorschlagNamen.items.count > maxitems then break;

                          end;
                       end;
                  end;
            end;
        end;
        //=====ORT====
        //============
        if (feld='Ort') then
        begin
            with formtiteldaten do
            begin
                  panelAutoComplete.left:=EingabeVerlag.left;
                  PanelAutocomplete.top:=EingabeSammelband.top -50;
                  PanelAutocomplete.height:=150;
                  for i:=GetTopEmptyRow('Literatur')  downto 1 do
                  begin

                       if (pos(t,Literatur[i,Spalte_Ort])>0)  then
                       begin
                          a:=trim(Literatur[i,Spalte_Ort]);
                          if (pos(a,tl)=0)  and (a <> t) then //Der Name ist ein Treffer und neu
                          begin
                               tl:= tl+ a + ' ';
                               FormTitelDaten.ListeVorschlagNamen.items.add(a);
                               if  FormTitelDaten.ListeVorschlagNamen.items.count > maxitems then break;

                          end;
                       end;
                  end;

            end;
        end;


        FormTitelDaten.CaptionAutoComplete.Caption:=Feld;
        if (length(tl) > 3) and (FormTitelDaten.Listevorschlagnamen.Items.Count > 0) then
        begin

        //    fenster.ListeVorschlagNamen.Sorted:=true;
            FormTitelDaten.ListeVorschlagNamen.itemindex:=0;
            FormTitelDaten.PanelAutoComplete.Visible:=true;
        end else begin
            FormTitelDaten.PanelAutoComplete.Visible:=false;
        end;
        FormTitelDaten.ListeVorschlagNamen.scrollwidth:=100;
        result:=true;
end;


procedure TFormTiteldaten.ListeVorschlagNamenClick(Sender: TObject);
var
       f:      string;
begin

     If CaptionAutoComplete.Caption='Autoren' then
     begin
          f:= eingabeAutor.text;

          if pos(';',f) = 0 then
          begin //erster Autor
                f:=ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
          end else begin  // Koautor
              f:=deletelastword(eingabeautor.text);
              f:=trim(f);
              f:=f + ' ' + ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
          end;
          EingabeAutor.text:=f;
          PanelAutoComplete.visible:=False;
          EingabeAutor.Setfocus;
          EingabeAutor.selstart:=1000 ;
     end;

     If CaptionAutoComplete.Caption='Herausgeber' then
     begin
          f:= eingabeHerausgeber.text;
          if pos(';',f) = 0 then
          begin //erster Autor
                f:=ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
          end else begin  // Koautor
              f:=deletelastword(eingabeHErausgeber.text);
              f:=trim(f);
              f:=f + ' ' + ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
          end;
          EingabeHerausgeber.text:=f;
          PanelAutoComplete.visible:=False;
          EingabeHerausgeber.Setfocus;
          EingabeHerausgeber.selstart:=1000 ;
     end;
     If CaptionAutoComplete.Caption='Zeitschriften' then
     begin
          f:=ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
          EingabeZeitschrift.text:=f;
          PanelAutoComplete.visible:=False;
          EingabeZeitschrift.Setfocus;
          EingabeZeitschrift.selstart:=1000 ;
     end;
     If CaptionAutoComplete.Caption='Verlage' then
     begin
          f:=ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
          EingabeVerlag.text:=f;
          PanelAutoComplete.visible:=False;
          findeVerlagsOrt(f);

     end;
     If CaptionAutoComplete.Caption='Ort' then
     begin
          f:=ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
          EingabeOrt.text:=f;
          PanelAutoComplete.visible:=False;
     end;

end;

procedure TFormTiteldaten.ListeVorschlagNamenContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TFormTiteldaten.ListeVorschlagNamenKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);

begin

end;

procedure TFormTiteldaten.ListeVorschlagNamenMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
end;

procedure TFormTiteldaten.Panel22Click(Sender: TObject);
begin
     PanelAutoComplete.visible:=false;
end;

procedure TFormTiteldaten.ButtonJahrEintragenClick(Sender: TObject);
begin

end;

procedure TFormTiteldaten.BitBtn1Click(Sender: TObject);
begin
   Openurl('http://scholar.google.com');
end;

procedure TFormTiteldaten.ButtonScholarClick(Sender: TObject);
    var
       datname:string;
       form:string;
       nr:integer;
    begin
         datname:=DBDirectory + 'import.tmp';
         fenster.MemoZwischenablage.lines.clear;
         if os='win' then
            fenster.MemoZwischenablage.PasteFromClipboard
         else
             fenster.MemoZwischenablage.PasteFromClipboard;
             //fenster.MemoZwischenablage.Lines.Text:=clipboard.AsText;
             // pastefromclipboard funktioniert nicht beim Mac. Evtl. hat der mehrere Clipboards
         fenster.MemoZwischenablage.Lines.SaveToFile(datname);
         showmessage('d');
         MachPause();

         form:=IdentifiziereImportFormat(datname);

         if form='ris'then ImportRISDB(datname);
         if form='refer'then ImportreferDB(datname);
         if form='pubmed'then ImportpubmedDB(datname);
         if form='bibtex'then ImportBibTeXDB(datname);
         if form='z3950'then Importz3950DB(datname);
         if form='bx' then LiteraturLaden('Literatur2',datname);
         MachPause();

         if formTiteldaten.Visible=false then formtiteldaten.show;
         with formtiteldaten do
         begin

               for nr:=1 to ArraySize do
                  if Literatur2[nr,Spalte_Autor]<> '' then break;
               //nr:=2; //das ist die Zeile bei einem einzelnen Datensatz
               //10/2021: nr kann auch irgendwas anderes sein. Daher: erste besetzte Zeile
               EingabeAutor.Text:=       trim(Literatur2[nr,Spalte_Autor]);
               EingabeTitel.Text:=       Literatur2[nr,Spalte_Titel];
               EingabeUnterTitel.Text:=  Literatur2[nr,Spalte_Untertitel];
               EingabeJahr.Text:=        Literatur2[nr,Spalte_Jahr];
               EingabeDatum.Text:=       Literatur2[nr,Spalte_Publikationsdatum];
               EingabeSeiten.Text:=      Literatur2[nr,Spalte_Seiten];
               EingabeZeitschrift.Text:= Literatur2[nr,Spalte_Zeitschrift];
               EingabeBand.Text:=        Literatur2[nr,Spalte_Band];
               EingabeNummer.Text:=      Literatur2[nr,Spalte_Nummer];
               EingabeVerlag.Text:=      Literatur2[nr,Spalte_Verlag];
               EingabeOrt.Text:=         Literatur2[nr,Spalte_Ort];
         end;
         SetLength(Literatur2, 1,1);  //Die Datenbank verkleinern

end;

procedure TFormTiteldaten.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TFormTiteldaten.Button3Click(Sender: TObject);
var
   ds:      array[1..30] of string;
   i:       integer;
begin
   for i:=2 to spalte_ende do
       ds[i]:=literatur[AktuelleLiteraturArrayZeile,i];
    TmpHinweis:='';   //keine ID vergeben
    Kurzzitat:='';
    GV_TmpZitat:='';
    EingabeAutor.text:=          ds[Spalte_Autor];
    EingabeTitel.text:=          ds[Spalte_Titel] + ' (Kopie)';
     EingabeUnterTitel.text:=    ds[Spalte_Untertitel];
     EingabeJahr.Text:=          ds[Spalte_Jahr];
     EingabeDatum.Text:=         ds[Spalte_PublikationsDatum];
     EingabeZeitschrift.Text:=   ds[Spalte_Zeitschrift];
     EingabeBand.Text:=          ds[Spalte_Band];
     EingabeNummer.Text:=        ds[Spalte_Nummer];
     EingabeSeiten.Text:=         '';
     EingabeHerausgeber.Text:=   ds[Spalte_Herausgeber];
     EingabeSammelband.Text:=    ds[Spalte_Sammelband];
     EingabeVerlag.Text:=        ds[Spalte_Verlag];
     EingabeOrt.Text:=           ds[Spalte_Ort];
     EingabeAuflage.Text:=       ds[Spalte_Auflage];
     EingabeISBN.Text:=           '';

end;

procedure TFormTiteldaten.ButtonSpeichernClick(Sender: TObject);
var
   i:     integer;
   typ:   string;
begin
      MachPause();
      if schreibrecht() then      // Schreibrecht vorhanden. Ohne geht gar nichts
      begin
            if  TmpHinweis ='' then //es handelt sich um einen neuen Datensatz
            begin
               increaseMaxID('Literatur');
               AktuelleLiteraturArrayZeile:=
                      getTopEmptyRow('Literatur');  //Dahin wird geschrieben werden  // ID erzeugen und schreiben
               Literatur[AktuelleLiteraturArrayZeile,1]:= IntToStr(GetMaxID('Literatur'));
               Fenster.Feldinhalt.lines.clear;
           end;

           //falschen Publikatonstyp korrigieren
           //===================================
           If (RadioSammelband.checked) and
              (EingabeAutor.text='') and
              (EingabeHerausgeber.Text <> '') then
           begin
                 EingabeAutor.text:=EingabeHerausgeber.Text;
                 EingabeHerausgeber.Text:='' ;
                 showmsg('ganze Sammelbände werden wie Bücher eingegeben');
           end;
           If (RadioSammelband.checked) and
              (EingabeTitel.text='') and
              (EingabeSammelband.Text <> '') then
           begin
                 EingabeTitel.text:=EingabeSammelband.Text;
                 EingabeSammelband.Text:='' ;
           end;
            If (RadioSammelband.checked)  and
               (EingabeZeitschrift.text<>'')
            then RadioArtikel.checked:=true;

           //fehlende Angaben
           if EingabeJahr.text='' then EingabeJahr.text:='o.J.';
           if EingabeAutor.text='' then EingabeAutor.text:='o.A.';

           //geänderte Daten an die alte Stelle zurückspeichern.
           typ:='Buch';
           if RadioArtikel.checked then typ:='Artikel';
           if RadioKapitel.checked then typ:='Kapitel';
           if RadioSammelband.checked then typ:='Sammelband';
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Publikationstyp]  :=typ  ;




           Literatur[AktuelleLiteraturArrayZeile,Spalte_Autor]  :=EingabeAutor.text ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Titel]  :=EingabeTitel.text ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Untertitel]  :=EingabeUnterTitel.text ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Jahr]  :=Trim(EingabeJahr.Text)  ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Publikationsdatum]:=    Trim(EingabeDatum.Text) ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Zeitschrift]:=          Trim(EingabeZeitschrift.Text)  ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Band]  :=                         Trim(EingabeBand.Text)  ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Nummer] :=              Trim(EingabeNummer.Text)  ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Seiten] :=              EingabeSeiten.Text;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Herausgeber] :=         EingabeHerausgeber.Text    ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Sammelband] :=                         Trim(EingabeSammelband.Text);
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Verlag]  :=EingabeVerlag.Text ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Ort] :=Trim(EingabeOrt.Text) ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Auflage]:=EingabeAuflage.Text  ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_ISBN]:=EingabeISBN.Text  ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Erstautor]:=HolErstautor(AktuelleLiteraturArrayZeile);

           Literatur[AktuelleLiteraturArrayZeile, Spalte_Bearbeitungsdatum] :=   formatdatetime('yyyymmddhhnn', now);
           if Literatur[AktuelleLiteraturArrayZeile, Spalte_Erstelldatum] ='' then
              Literatur[AktuelleLiteraturArrayZeile, Spalte_Erstelldatum]:= formatdatetime('dd.mm.yyyy', now);


           LiteraturVolltext(AktuelleLiteraturArrayZeile); // Volltext muß neu angelegt werden.
           MachPause();
           UpdateBearbeitungszahl();
           IsTextChanged:=true;
           Speicherbedarf('l');
      end;

      FormTiteldaten.close; { 08/2024: bisher .close, was Probleme
                                       bereitet hat. }

      machpause();
      //Fenster.IconAllesSpeichernClick(self);
      Aenderungen:=Aenderungen + 200;

      //Die Sortierung hat sich evtl. geändert. Vielleicht ein neuer Datensatz
      with fenster do
      begin
            fenster.AlleAnzeigenClick(self);
            machpause();
            For i:=0 to Fenster.Liste.Rowcount-1 do
            begin
                 if  (Trefferarray[i,TrefferArraySpalteArrayZeile]=inttostr(AktuelleLiteraturArrayZeile))
                 and (Trefferarray[i,TrefferArraySpalteTyp]='L')
                 then
                     begin
                          Fenster.Liste.Row:=i;
                          timer.enabled:=true;
                          break;
                     end;
            end;
        end;
end;

procedure TFormTiteldaten.LabelAutorChange(Sender: TObject);
begin

end;

procedure TFormTiteldaten.EingabeAutorEnter(Sender: TObject);
begin
     PanelAutoComplete.visible:=False;
end;

procedure TFormTiteldaten.EingabeAutorExit(Sender: TObject);
begin

end;

procedure TFormTiteldaten.EingabeAutorKeyPress(Sender: TObject; var Key: char);
var
  f:string  ;
begin
     if key=#13 then
     begin
          if panelautocomplete.visible then
          begin
              f:= eingabeAutor.text;
              if pos(';',f) = 0 then
              begin //erster Autor
                    f:=ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
              end else begin  // Koautor
                  f:=deletelastword(eingabeautor.text);
                  f:=trim(f);
                  f:=f + ' ' + ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
              end;
              key:=#0;
              EingabeAutor.text:=f;
              PanelAutoComplete.visible:=False;
              EingabeAutor.Setfocus;
              EingabeAutor.selstart:=1000  ;
          end else begin
              EingabeTitel.SetFocus;
          end;
     end;

end;

procedure TFormTiteldaten.EingabeAutorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
    var
    t: string;   //Namensanfang


begin

       if key<>vk_return then
       begin // die Auswahl an das Ende des Feldes
           t:=EingabeAutor.text;
           //Falls es andere Autoren gibt, ausfiltern:
           While pos(';',t)> 0 do t:=copy(t,pos(';',t)+1, 1000);
           t:=trim(t);  //Anfang des Autorennamens
           if (length(t) > 0) and (key<>vk_up) and (key<>vk_down) then
           begin
                AutoComplete('Autoren',t);
           end;

       end
end;

procedure TFormTiteldaten.EingabeDatumKeyPress(Sender: TObject; var Key: char);
begin
    RadioArtikel.checked:=true
end;

procedure TFormTiteldaten.EingabeHerausgeberKeyPress(Sender: TObject;
  var Key: char);
    var
       f:string  ;
begin
      RadioKapitel.checked:=true  ;

      if key=#13 then
      begin
           if PanelAutoComplete.visible then
           begin
                f:= eingabeHerausgeber.text;
                if pos(';',f) = 0 then
                begin //erster Autor
                      f:=ListeVorschlagNamen.Items[ListeVOrschlagNamen.ItemIndex];
                end else begin  // Koautor
                    f:=deletelastword(eingabeHerausgeber.text);
                    f:=trim(f);
                    f:=f + ' ' + ListeVorschlagNamen.Items[ListeVOrschlagNamen.ItemIndex];
                end;
                key:=#0;
                EingabeHerausgeber.text:=f;
                PanelAutoComplete.visible:=False;
                EingabeHerausgeber.Setfocus;
                EingabeHerausgeber.selstart:=1000 ;
                EingabeHerausgeber.sellength:=0;
           end else begin
                EingabeSammelband.Setfocus;
           end;
      end;

end;

procedure TFormTiteldaten.EingabeHerausgeberKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
    var
      t: string;   //Namensanfang


    begin
      t:=EingabeHerausgeber.text;
      if (length(t) > 2) then
      begin
        if (length(EingabeSeiten.Text) > 1)
            then RadioKapitel.checked:=true
            else  RadioSammelband.checked:=true
      end;

      if key<>vk_return then
      begin // die Auswahl an das Ende des Feldes
          //Falls es andere Autoren gibt, ausfiltern:
          While pos(';',t)> 0 do t:=copy(t,pos(';',t)+1, 1000);
          t:=trim(t);  //Anfang des Autorennamens
          if (length(t) > 2) and (key<>vk_up) and (key<>vk_down) then
          begin
               AutoComplete('Herausgeber',t);
          end;
      end;


end;

procedure TFormTiteldaten.EingabeJahrClick(Sender: TObject);
begin

end;

procedure TFormTiteldaten.EingabeOrtEnter(Sender: TObject);
    var
       i:integer;
    begin
       //Das Verlagsfeld ist besetzt
       if (length(EingabeVerlag.text)>1) and (length(EingabeOrt.text)=0) then
       begin
           for i:=1 to LiteraturDatensatzzahl do
           begin
                if (literatur[i,Spalte_Verlag]=EingabeVerlag.Text) and (literatur[i,Spalte_Ort]<>'') then
                begin
                  EingabeOrt.Text:=Literatur[i,Spalte_Ort];
                  break;
                end;
           end;
       end;

end;

procedure TFormTiteldaten.EingabeOrtKeyPress(Sender: TObject; var Key: char);
    var
       f:string;

    begin
        if (key=#13) then   // and (length(EingabeVerlag)=0)
      begin
           f:=ListeVorschlagNamen.Items[ListeVOrschlagNamen.ItemIndex];
           key:=#0;
           EingabeOrt.text:=f;
           PanelAutoComplete.visible:=False;

      end;

end;

procedure TFormTiteldaten.EingabeOrtKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
    var
      t: string;   //Ortanfang
    begin
      t:=EingabeOrt.text;

        if key<>vk_return then
        begin // die Auswahl an das Ende des Feldes

            t:=trim(t);
            if (length(t) > 0) and (key<>vk_up) and (key<>vk_down) then
            begin
                 AutoComplete('Ort',t);
            end;
        end;


end;

procedure TFormTiteldaten.EingabeSeitenKeyPress(Sender: TObject; var Key: char);
begin
    If RadioBuch.checked then RadioArtikel.checked:=true;
end;

procedure TFormTiteldaten.EingabeTitelEnter(Sender: TObject);
begin
  PanelAutoComplete.visible:=False;
end;

procedure TFormTiteldaten.EingabeTypChange(Sender: TObject);
begin

end;

procedure TFormTiteldaten.EingabeVerlagChange(Sender: TObject);
begin

end;

procedure TFormTiteldaten.EingabeVerlagKeyPress(Sender: TObject; var Key: char);
    var
       f:string;

    begin
        if key=#13 then
      begin
           f:=ListeVorschlagNamen.Items[ListeVOrschlagNamen.ItemIndex];
           key:=#0;
           EingabeVerlag.text:=f;
           PanelAutoComplete.visible:=False;
           FindeVerlagsort(f);
      end;

end;

procedure TFormTiteldaten.EingabeVerlagKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  t: string;   //Namensanfang


begin
  t:=EingabeVerlag.text;
  if key<>vk_return then
  begin // die Auswahl an das Ende des Feldes
      t:=trim(t);  //Anfang des Autorennamens
      if (length(t) > 0) and (key<>vk_up) and (key<>vk_down) then
      begin
           AutoComplete('Verlage',t);
      end;

  end;
  //Identifkation des Publikatonstyps
  if length(EingabeHerausgeber.text) > 1  then
  begin
       if length(EingabeSeiten.Text) > 1
       then  RadioKapitel.checked:=true
       else  RadioSammelband.checked:=true;;
  end;


end;

procedure TFormTiteldaten.EingabeZeitschriftKeyPress(Sender: TObject;
  var Key: char);
var
  f:string  ;
begin
     if key=#13 then   //RETURN
     begin
              f:=ListeVorschlagNamen.Items[ListeVOrschlagNamen.ItemIndex];
              key:=#0;
              eingabeZeitschrift.text:=f;
              PanelAutoComplete.visible:=False;

          EingabeHerausgeber.SetFocus;
     end;

end;

procedure TFormTiteldaten.EingabeZeitschriftKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  t: string;   //Zeitschriftenanfag
begin
  t:=EingabeZeitschrift.text;
  if length(t) > 2 then
  begin
    if length(EingabeHerausgeber.text) < 1
       then RadioArtikel.checked:=true
       else RadioSammelband.checked:=true;
  end;

  if key<>vk_return then
  begin // die Auswahl an das Ende des Feldes

      t:=trim(t);
      if (length(t) > 0) and (key<>vk_up) and (key<>vk_down) then
      begin
           AutoComplete('Zeitschriften',t);
      end;
  end;


end;

procedure TFormTiteldaten.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin

end;

procedure TFormTiteldaten.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if key=vk_escape then close;
    if key=vk_up then ListeVorschlagnamen.setfocus;
    if key=vk_down then ListeVorschlagnamen.setfocus;
end;

procedure TFormTiteldaten.FormShow(Sender: TObject);


begin
     Fenster.FormChangeBounds(self);

      if length(EingabeJahr.text) = 0  then
      begin
          Jahreszahl.caption:=formatdatetime('yyyy', now) + ' ->';
          Jahreszahl.width:=70;
          Jahreszahl.borderstyle:=bssingle;

      end else begin
          Jahreszahl.width:=1;
          Jahreszahl.borderstyle:=bsnone;
          Jahreszahl.caption:='';
      end;
      EingabeAutor.Setfocus;  //sein lassen. Führt zur Fehlermeldung

     if os='linux' then
     begin
        ButtonScholar.visible:=false;

     end else begin

     end;


end;

procedure TFormTiteldaten.JahreszahlClick(Sender: TObject);
begin
  EingabeJahr.text:=formatdatetime('yyyy', now) ;
  Jahreszahl.width:=1;
  Jahreszahl.borderstyle:=bsnone;
  Jahreszahl.caption:='';
end;

procedure TFormTiteldaten.Label11Click(Sender: TObject);
begin

end;

procedure TFormTiteldaten.Label3Click(Sender: TObject);
begin
  RadioBuch.Checked:=not RadioBuch.Checked;

end;

procedure TFormTiteldaten.Label4Click(Sender: TObject);
begin
  RadioArtikel.Checked:=not RadioArtikel.Checked;
end;

procedure TFormTiteldaten.Label7Click(Sender: TObject);
begin
    RadioKapitel.Checked:=not Radiokapitel.Checked;
end;

procedure TFormTiteldaten.Label8Click(Sender: TObject);
begin
  RadioSammelband.Checked:=not RadioSammelband.Checked
end;

procedure TFormTiteldaten.xxxClick(Sender: TObject);

begin


end;

end.

