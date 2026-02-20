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
  ExtCtrls, Buttons, Grids, Types;

type

  { TFormTiteldaten }

  TFormTiteldaten = class(TForm)
    Bevel1: TBevel;
    ButtonKopieren: TPanel;
    CaptionAutoComplete: TPanel;
    ButtonSpeichern: TImage;
    ImageLinkAnlegen: TImage;
    ImageLinkAnlegen1: TImage;
    Label2: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Labelsyntax: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ListeVorschlagNamen: TListBox;
    Panel1: TPanel;
    ButtonScholar: TPanel;
    Panel22: TPanel;
    PanelAutoComplete: TPanel;
    RadioArtikel: TRadioButton;
    RadioKapitel: TRadioButton;
    RadioBuch: TRadioButton;
    RadioSammelband: TRadioButton;
    TitelDatenmatrix: TStringGrid;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ButtonKopierenClick(Sender: TObject);
    procedure ButtonScholarClick(Sender: TObject);
    procedure ButtonScholarMouseEnter(Sender: TObject);
    procedure ButtonScholarMouseLeave(Sender: TObject);
    procedure ButtonSpeichernClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure EingabeAutorEnter(Sender: TObject);
    procedure EingabeDatumKeyPress(Sender: TObject; var Key: char);
    procedure EingabeHerausgeberKeyPress(Sender: TObject; var Key: char);
    procedure EingabeOrtEnter(Sender: TObject);
    procedure EingabeOrtKeyPress(Sender: TObject; var Key: char);
    procedure EingabeOrtKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure EingabeSeitenKeyPress(Sender: TObject; var Key: char);
    procedure EingabeTitelEnter(Sender: TObject);
    procedure EingabeVerlagKeyPress(Sender: TObject; var Key: char);
    procedure EingabeVerlagKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EingabeZeitschriftKeyPress(Sender: TObject; var Key: char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure ListeVorschlagNamenClick(Sender: TObject);
    procedure Panel22Click(Sender: TObject);
    procedure TitelDatenmatrixKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
                    FormTiteldaten.Titeldatenmatrix.cells[1,12]:= Literatur[i,Spalte_Ort] ;
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
                  PanelAutocomplete.height:=200;
                  for i:=GetTopEmptyRow('Literatur')  downto 1 do
                  begin
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
                  panelAutoComplete.left:=150;
                  PanelAutocomplete.top:=150;
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
          f:= Titeldatenmatrix.cells[1,0];

          if pos(';',f) = 0 then
          begin //erster Autor
                f:=ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
          end else begin  // Koautor
              f:=deletelastword(Titeldatenmatrix.cells[1,0]);
              f:=trim(f);
              f:=f + ' ' + ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
          end;
          Titeldatenmatrix.cells[1,0]:=f;
          PanelAutoComplete.visible:=False;

     end;

     If CaptionAutoComplete.Caption='Herausgeber' then
     begin
          f:= Titeldatenmatrix.cells[1,9];
          if pos(';',f) = 0 then
          begin //erster Autor
                f:=ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
          end else begin  // Koautor
              f:=deletelastword(Titeldatenmatrix.cells[1,9]);
              f:=trim(f);
              f:=f + ' ' + ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
          end;
          Titeldatenmatrix.cells[1,9]:=f;
          PanelAutoComplete.visible:=False;

     end;
     If CaptionAutoComplete.Caption='Zeitschriften' then
     begin
          f:=ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
          Titeldatenmatrix.cells[1,8]:=f;
          PanelAutoComplete.visible:=False;
          TitelDatenMatrix.SetFocus;
          TitelDatenMatrix.Row:=9; // Ein Feld weiterspringen
     end;
     If CaptionAutoComplete.Caption='Verlage' then
     begin
          f:=ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
          Titeldatenmatrix.cells[1,11]:=f;
          PanelAutoComplete.visible:=False;
          findeVerlagsOrt(f);

     end;
     If CaptionAutoComplete.Caption='Ort' then
     begin
          f:=ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
          Titeldatenmatrix.cells[1,12]:=f;
          PanelAutoComplete.visible:=False;
     end;

end;

procedure TFormTiteldaten.Panel22Click(Sender: TObject);
begin
     PanelAutoComplete.visible:=false;
end;

procedure TFormTiteldaten.TitelDatenmatrixKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
       f:string;
begin
     //------ Autoren -----
     //--------------------
     if Titeldatenmatrix.Row = 0 then
     begin
          if key=vk_return then
          begin
               if panelautocomplete.visible then
               begin
                   f:= Titeldatenmatrix.cells[1,0] ;
                   if pos(';',f) = 0 then
                   begin //erster Autor
                         f:=ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
                   end else begin  // Koautor
                       f:=deletelastword(Titeldatenmatrix.cells[1,0]);
                       f:=trim(f);
                       f:=f + ' '
                            + ListeVorschlagNamen.Items[ListeVorschlagNamen.ItemIndex];
                   end;
                   Titeldatenmatrix.cells[1,0]:=f;
                   PanelAutoComplete.visible:=False;
               end;
          end else begin
               f:=  getlastword(Titeldatenmatrix.cells[1,0]);
               if (length(f) > 1) and (pos(';',f)=0) then AutoComplete('Autoren',f)
                                                     else PanelAutoComplete.visible:=false;
          end;
     end;

     //------- Zeitschrifen----
     //------------------------
     if Titeldatenmatrix.Row = 8 then
     begin
         f:=Titeldatenmatrix.cells[1,8];
         if length(f) > 0 then
         begin
           if length(Titeldatenmatrix.cells[1,9]) < 1
              then RadioArtikel.checked:=true
              else RadioSammelband.checked:=true;
         end;

         if (key<>vk_return) then
         begin
             f:=trim(f);
             if (length(f) > 0) and (key<>vk_up) and (key<>vk_down) then
             begin
                  AutoComplete('Zeitschriften',f);
             end;
         end else begin
               if PanelAutoComplete.visible then
               begin
                   f:=ListeVorschlagNamen.Items[0];
                   Titeldatenmatrix.cells[1,8]:=f;
                   Titeldatenmatrix.row:=titeldatenmatrix.row+1;
               end;
         end;

     end;

     //----------- Verlag ------
     //-------------------------
     if Titeldatenmatrix.Row = 11 then
     begin
         f:=Titeldatenmatrix.cells[1,11];

         if (key<>vk_return) then
         begin
             f:=trim(f);
             if (length(f) > 0) and (key<>vk_up) and (key<>vk_down) then
             begin
                  AutoComplete('Verlage',f);
             end;
         end else begin
               if PanelAutoComplete.visible then
               begin
                   f:=ListeVorschlagNamen.Items[0];
                   Titeldatenmatrix.cells[1,11]:=f;
                   findeVerlagsOrt(f);
                   Titeldatenmatrix.row:=titeldatenmatrix.row+1;
               end;
         end;

     end;





     //Navigationstasten, die feldunabhängig sind
     if (key=vk_up) or (key=vk_down) or (key=vk_return) or (key=vk_tab) then
        PanelAutoComplete.visible:=false;

end;

procedure TFormTiteldaten.ButtonScholarMouseEnter(Sender: TObject);
begin
          if sender is tpanel then Tpanel(sender).font.style:=[fsbold];
end;

procedure TFormTiteldaten.ButtonScholarMouseLeave(Sender: TObject);
begin
          if sender is tpanel then Tpanel(sender).font.style:=[];
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
             fenster.MemoZwischenablage.Lines.text:=clipboard.astext;




         fenster.MemoZwischenablage.Lines.SaveToFile(datname);

         MachPause();

         form:=IdentifiziereImportFormat(datname);
         if form <> '' then
         begin
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
                     for nr:=1 to arraysize do
                        if Literatur2[nr,Spalte_Autor]<> '' then break;


                     //showmessage('i gefunden' + inttostr(nr));
                     //nr:=2; //das ist die Zeile bei einem einzelnen Datensatz
                     //10/2021: nr kann auch irgendwas anderes sein. Daher: erste besetzte Zeile


                     Titeldatenmatrix.cells[1,0]:=             trim(Literatur2[nr,Spalte_Autor]);
                     Titeldatenmatrix.cells[1,1]:=             Literatur2[nr,Spalte_Titel];
                     Titeldatenmatrix.cells[1,2]:=             Literatur2[nr,Spalte_Untertitel];
                     Titeldatenmatrix.cells[1,3]:=             Literatur2[nr,Spalte_Jahr];
                     Titeldatenmatrix.cells[1,4]:=             Literatur2[nr,Spalte_Publikationsdatum];
                     Titeldatenmatrix.cells[1,7]:=             Literatur2[nr,Spalte_Seiten];
                     Titeldatenmatrix.cells[1,8]:=             Literatur2[nr,Spalte_Zeitschrift];
                     Titeldatenmatrix.cells[1,9]:=             Literatur2[nr,Spalte_Band];
                     Titeldatenmatrix.cells[1,10]:=            Literatur2[nr,Spalte_Nummer];
                     Titeldatenmatrix.cells[1,11]:=            Literatur2[nr,Spalte_Verlag];
                     Titeldatenmatrix.cells[1,12]:=            Literatur2[nr,Spalte_Ort];
               end;
               SetLength(Literatur2, 1,1);  //Die Datenbank verkleinern
         end else begin
               showmessage('Das Format konnte nicht erkannt werden...');
         end;
end;

procedure TFormTiteldaten.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TFormTiteldaten.ButtonKopierenClick(Sender: TObject);
var
   ds:      array[1..30] of string;
   i:       integer;
begin
   for i:=2 to spalte_ende do
       ds[i]:=literatur[AktuelleLiteraturArrayZeile,i];
    TmpHinweis:='';   //keine ID vergeben
    Kurzzitat:='';
    GV_TmpZitat:='';
    Titeldatenmatrix.cells[1,0]:=          ds[Spalte_Autor];
     Titeldatenmatrix.cells[1,1]:=         ds[Spalte_Titel] + ' (Kopie)';
     Titeldatenmatrix.cells[1,2]:=         ds[Spalte_Untertitel];
     Titeldatenmatrix.cells[1,3]:=         ds[Spalte_Jahr];
     Titeldatenmatrix.cells[1,4]:=         ds[Spalte_PublikationsDatum];
     Titeldatenmatrix.cells[1,5]:=         ds[Spalte_Band];
     Titeldatenmatrix.cells[1,6]:=         ds[Spalte_Nummer];
     Titeldatenmatrix.cells[1,7]:=         '';
     Titeldatenmatrix.cells[1,8]:=         ds[Spalte_Zeitschrift];
     Titeldatenmatrix.cells[1,9]:=         ds[Spalte_Herausgeber];
     Titeldatenmatrix.cells[1,10]:=        ds[Spalte_Sammelband];
     Titeldatenmatrix.cells[1,11]:=        ds[Spalte_Verlag];
     Titeldatenmatrix.cells[1,12]:=        ds[Spalte_Ort];
     Titeldatenmatrix.cells[1,13]:=        ds[Spalte_Auflage];
     Titeldatenmatrix.cells[1,14]:=           '';

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
               IsTextChanged:=false;
           end;

           //falschen Publikatonstyp korrigieren
           //===================================
           If (RadioSammelband.checked) and
              (Titeldatenmatrix.cells[1,0]='') and
              (Titeldatenmatrix.cells[1,9] <> '') then
           begin
                 Titeldatenmatrix.cells[1,0]:=Titeldatenmatrix.cells[1,9];
                 Titeldatenmatrix.cells[1,9]:='' ;
                 showmsg('ganze Sammelbände werden wie Bücher eingegeben');
           end;
           If (RadioSammelband.checked) and
              (Titeldatenmatrix.cells[1,1]='') and
              (Titeldatenmatrix.cells[1,10] <> '') then
           begin
                 Titeldatenmatrix.cells[1,1]:=Titeldatenmatrix.cells[1,10];
                 Titeldatenmatrix.cells[1,10]:='' ;
           end;
            If (RadioSammelband.checked)  and
               (Titeldatenmatrix.cells[1,5]<>'')
            then RadioArtikel.checked:=true;

           //fehlende Angaben
           if Titeldatenmatrix.cells[1,3]='' then Titeldatenmatrix.cells[1,3]:='o.J.';
           if Titeldatenmatrix.cells[1,0]='' then Titeldatenmatrix.cells[1,0]:='o.A.';

           //geänderte Daten an die alte Stelle zurückspeichern.
           typ:='Buch';
           if RadioArtikel.checked then typ:='Artikel';
           if RadioKapitel.checked then typ:='Kapitel';
           if RadioSammelband.checked then typ:='Sammelband';
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Publikationstyp]  :=typ  ;





           Literatur[AktuelleLiteraturArrayZeile,Spalte_Autor]  :=            TitelDatenmatrix.Cells[1,0] ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Titel]  :=            TitelDatenmatrix.Cells[1,1] ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Untertitel]  :=       TitelDatenmatrix.Cells[1,2] ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Jahr]  :=             TitelDatenmatrix.Cells[1,3] ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Publikationsdatum] := TitelDatenmatrix.Cells[1,4] ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Band]  :=             TitelDatenmatrix.Cells[1,5] ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Nummer] :=            TitelDatenmatrix.Cells[1,6] ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Seiten] :=            TitelDatenmatrix.Cells[1,7] ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Zeitschrift]:=        TitelDatenmatrix.Cells[1,8] ;    ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Herausgeber]:=        TitelDatenmatrix.Cells[1,9] ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Sammelband] :=        TitelDatenmatrix.Cells[1,10] ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Verlag]  :=           TitelDatenmatrix.Cells[1,11] ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Ort] :=               TitelDatenmatrix.Cells[1,12] ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Auflage] :=           TitelDatenmatrix.Cells[1,13] ;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_ISBN]:=               TitelDatenmatrix.Cells[1,14] ;





           Literatur[AktuelleLiteraturArrayZeile,Spalte_Erstautor]:=HolErstautor(AktuelleLiteraturArrayZeile);

           Literatur[AktuelleLiteraturArrayZeile, Spalte_Bearbeitungsdatum] :=   formatdatetime('yyyymmddhhnn', now);
           if Literatur[AktuelleLiteraturArrayZeile, Spalte_Erstelldatum] ='' then
              Literatur[AktuelleLiteraturArrayZeile, Spalte_Erstelldatum]:= formatdatetime('dd.mm.yyyy', now);


           LiteraturVolltext(AktuelleLiteraturArrayZeile); // Volltext muß neu angelegt werden.
           MachPause();
           UpdateBearbeitungszahl();
           Speicherbedarf('l');
           lchanged:=true;
           UngespeicherteZeichen:=UngespeicherteZeichen+250;
      end;


      Fenster.enabled:=true;
      FormTiteldaten.close;

      machpause();
      //Die Sortierung hat sich evtl. geändert. Vielleicht ein neuer Datensatz
      with fenster do
      begin
            fenster.AlleAnzeigenClick(self);
            timer.enabled:=true;
            TimerTimer(self);
            machpause();
            liste.setfocus;
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

procedure TFormTiteldaten.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
   fenster.Enabled:=true;
end;

procedure TFormTiteldaten.FormCreate(Sender: TObject);
begin
     //Farbschema des Hauptfensters übernehmen
   {
     FormTitelDaten.Color:=Fenster.ListeGliederungen.color;
     FormTitelDaten.font.color:=Fenster.Feldinhalt.font.color;
     FormTitelDaten.Labelsyntax.Font.color:=FormTitelDaten.font.color;
     FormTiteldaten.PanelAutoComplete.Color:=Fenster.Liste.SelectedColor;
     FormTiteldaten.CaptionAutoComplete.color:=FormTiteldaten.PanelAutoComplete.Color;
     ButtonSpeichern.picture:=fenster.imagequerverweisweg.picture;
     ButtonScholar.Color:=Fenster.ButtonAnlegen.color;
     ButtonKopieren.color:=ButtonScholar.color;
     FormTitelDaten.Font.Name:=fenster.feldinhalt.font.name;
   }
end;

procedure TFormTiteldaten.EingabeAutorEnter(Sender: TObject);
begin
     PanelAutoComplete.visible:=False;
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
                f:= Titeldatenmatrix.cells[1,9];
                if pos(';',f) = 0 then
                begin //erster Autor
                      f:=ListeVorschlagNamen.Items[ListeVOrschlagNamen.ItemIndex];
                end else begin  // Koautor
                    f:=deletelastword(Titeldatenmatrix.cells[1,9]);
                    f:=trim(f);
                    f:=f + ' ' + ListeVorschlagNamen.Items[ListeVOrschlagNamen.ItemIndex];
                end;
                key:=#0;
                Titeldatenmatrix.cells[1,0]:=f;
                PanelAutoComplete.visible:=False;

           end;
      end;

end;

procedure TFormTiteldaten.EingabeOrtEnter(Sender: TObject);
    var
       i:integer;
    begin
       //Das Verlagsfeld ist besetzt
       if (length(Titeldatenmatrix.cells[1,11])>1) and (length(Titeldatenmatrix.cells[1,12])=0) then
       begin
           for i:=1 to LiteraturDatensatzzahl do
           begin
                if (literatur[i,Spalte_Verlag]=Titeldatenmatrix.cells[1,11]) and (literatur[i,Spalte_Ort]<>'') then
                begin
                  Titeldatenmatrix.cells[1,12]:=Literatur[i,Spalte_Ort];
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
           Titeldatenmatrix.cells[1,12]:=f;
           PanelAutoComplete.visible:=False;

      end;

end;

procedure TFormTiteldaten.EingabeOrtKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
    var
      t: string;   //Ortanfang
    begin
      t:=Titeldatenmatrix.cells[1,12];

        if key<>vk_return then
        begin // die Auswahl an das Ende des Feldes

            t:=trim(t);
            if (length(t) > 0) and (key<>vk_up) and (key<>vk_down) then
            begin
             //    AutoComplete('Ort',t);
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

procedure TFormTiteldaten.EingabeVerlagKeyPress(Sender: TObject; var Key: char);
    var
       f:string;

    begin
        if key=#13 then
      begin
           f:=ListeVorschlagNamen.Items[ListeVOrschlagNamen.ItemIndex];
           key:=#0;
           Titeldatenmatrix.cells[1,11]:=f;
           PanelAutoComplete.visible:=False;
           FindeVerlagsort(f);
      end;

end;

procedure TFormTiteldaten.EingabeVerlagKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  t: string;   //Namensanfang


begin
  t:=Titeldatenmatrix.cells[1,11];
  if key<>vk_return then
  begin // die Auswahl an das Ende des Feldes
      t:=trim(t);  //Anfang des Autorennamens
      if (length(t) > 0) and (key<>vk_up) and (key<>vk_down) then
      begin
       //    AutoComplete('Verlage',t);
      end;

  end;
  //Identifkation des Publikatonstyps
  if length(Titeldatenmatrix.cells[1,9]) > 1  then
  begin
       if length(Titeldatenmatrix.cells[1,7]) > 1
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
              Titeldatenmatrix.cells[1,8]:=f;
              PanelAutoComplete.visible:=False;


     end;

end;

procedure TFormTiteldaten.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if key=vk_escape then close;
    if panelAutocomplete.Visible then
    begin;
          if key=vk_up then ListeVorschlagnamen.setfocus;
          if key=vk_down then ListeVorschlagnamen.setfocus;
    end;
end;

procedure TFormTiteldaten.FormShow(Sender: TObject);
var
   fs:integer;
begin
     Fenster.FormChangeBounds(self);
      { dark mode prüfen. Hier, weil es sonst zu Abstürzen kommen kann, wenn
        das Fenster noch nicht erzeugt worden ist.}

      fs:=fenster.feldinhalt.font.size;
      if fs > 13 then fs:=13;
      FormTiteldaten.Font.Size:=fs;
      TitelDatenMatrix.row:=0;
      Titeldatenmatrix.Col:=1;

      Titeldatenmatrix.EditorMode:=true;
      TitelDatenMatrix.setfocus;
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

end.

