unit unitkeyword;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  Clipbrd,     //Clipboard
  LCLType,     // für vk_return
  SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  CheckLst, Buttons, ComCtrls, Menus, RichMemo;

type

  { TFormKeyword }

  TFormKeyword = class(TForm)
    Button2: TButton;
    Panel1: TPanel;
    Register: TPageControl;
    SeiteSuchen: TTabSheet;

    procedure AllesClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure fragKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure Liste1Click(Sender: TObject);
    procedure Liste2Click(Sender: TObject);
    procedure Memo1DblClick(Sender: TObject);
    procedure neuesucheClick(Sender: TObject);
    procedure RegisterChange(Sender: TObject);
    procedure SchlagwortComboboxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SchlagwortlisteClick(Sender: TObject);
    procedure SchlagwortlisteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SuchListeClick(Sender: TObject);
  private

  public

  end;

var
  FormKeyword: TFormKeyword;

implementation
uses unit1;
{$R *.lfm}


{ TFormKeyword }

function insertkeyword(sw:string):boolean;

begin


end;

procedure TFormKeyword.SchlagwortlisteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
end;

procedure TFormKeyword.SuchListeClick(Sender: TObject);
var
   bu:         string;
   b1,b2,b3:   string;
   i:          integer;
   k1:       string;


   kwliste:    string;
   suchtext:   string;
   treffer:    boolean;
   suchbegriff:    string;


begin
 {     //definiert die Suchanfrage
      Suchbegriff:= Liste2.Getselectedtext;

      Suchtext:=trim(fenster.sucheingabe.text + ' ' + suchbegriff);
      LabelSuchtext.caption:=suchtext;
      neuesuche.visible:=true;
      with fenster do
      begin
           Sucheingabe.text:=suchtext;
           SucheingabeClick(self);
           timer.Enabled := True;
      end;
      machpause();
      LabelSuchtext.caption:=stringreplace(suchtext,' ','+',[rfreplaceall]);


      //Kombinationen suchen und anzeigen

      Suchtext:=Fenster.SuchEingabe.text;

      b1:=getfirstword(suchtext);
      suchtext:=deletefirstword(suchtext) ;
      b2:=getfirstword(suchtext);
      suchtext:=deletefirstword(suchtext) ;
      b3:=getfirstword(suchtext);
      suchtext:='';

      if b1='' then b1:= ' ' ;
      if b2='' then b2:=' ';
      if b3='' then b3:=' ';
      }


{
      kwliste:= schlagwortliste.text; //die Originalliste
      bu:='a';
      Suchliste.text:='';  //die Liste mit denKobinationen
      machpause();
      while length(kwliste) > 1 do
      begin
           k1:=getfirstword(kwliste);
           kwliste:=deletefirstword(kwliste);
           treffer:=false;
           for i:=0 to maxanzeige do  //Muss Null sein. Wegen der Liste
           begin
                treffer:=false;
                if  pos(b1,Trefferarray[i,7])>0 then treffer:=true;
                if treffer then
                   if  pos(b2,Trefferarray[i,7])=0 then treffer:=false;
                if treffer then
                   if  pos(b3,Trefferarray[i,7])=0 then treffer:=false;
                if treffer then
                   if  pos(k1,Trefferarray[i,7])=0 then treffer:=false;
                if treffer then
                   if pos(k1,suchliste.text)> 0 then treffer:=false;
                if treffer then
                   if pos(ansilowercase(k1),ansilowercase(fenster.sucheingabe.text))> 0 then treffer:=false;
               if treffer then
               begin
                    if ansilowercase(copy(k1,1,1))=bu  then
                    begin
                          Suchliste.text:=Suchliste.text + k1+ ' ';
                    end  else begin
                          Suchliste.text:=Suchliste.text+ #10 + k1+ ' ';
                          bu:=ansilowercase(copy(k1,1,1));
                    end;
                    break;
               end;


           end;

      end;
      Suchliste.setfocus; //Sonst wird beim Click immer der erste Begriff ausgewählt.
      }

end;

procedure TFormKeyword.SchlagwortlisteClick(Sender: TObject);
var
   sw:    string;

begin





end;

procedure TFormKeyword.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TFormKeyword.Button2Click(Sender: TObject);
begin
end;

procedure TFormKeyword.fragKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);

begin

end;

procedure TFormKeyword.BitBtn2Click(Sender: TObject);

begin


end;

procedure TFormKeyword.BitBtn1Click(Sender: TObject);


begin


end;

procedure TFormKeyword.AllesClick(Sender: TObject);
begin

end;

procedure TFormKeyword.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin



end;

procedure TFormKeyword.FormResize(Sender: TObject);
begin

end;

procedure TFormKeyword.Liste1Click(Sender: TObject);

begin

end;

procedure TFormKeyword.Liste2Click(Sender: TObject);


begin


end;

procedure TFormKeyword.Memo1DblClick(Sender: TObject);
begin

end;

procedure TFormKeyword.neuesucheClick(Sender: TObject);
begin

end;

procedure TFormKeyword.RegisterChange(Sender: TObject);

begin


end;

procedure TFormKeyword.SchlagwortComboboxKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);

begin

end;

end.

