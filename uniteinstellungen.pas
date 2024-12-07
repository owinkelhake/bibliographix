unit uniteinstellungen;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  ExtCtrls, //für timage
  StdCtrls,   //für Combobox
  SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls;

type

  { TFormEinstellungen }

  TFormEinstellungen = class(TForm)
    AuswahlFeld: TComboBox;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    CheckBox2: TCheckBox;
    ErsatzText: TEdit;
    ExportObsidian: TButton;
    FeldSuchText: TEdit;
    FontBeispiel: TLabel;
    FontListe: TComboBox;
    FontSizes: TComboBox;
    Image4: TImage;
    Label22: TLabel;
    Label27: TLabel;
    Label30: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label66: TLabel;
    Label72: TLabel;
    Label75: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    OptionAlleSeiten: TRadioButton;
    OptionAlphaSortIdee: TCheckBox;
    OptionAnmerkungenDrucken: TCheckBox;
    OptionAnmerkungenDrucken1: TCheckBox;
    OptionBibTeX: TRadioButton;
    OptionBibtexExport: TRadioButton;
    OptionEineSeiteDrucken: TRadioButton;
    OptionGliederungDrucken: TRadioButton;
    OptionKeinAnhang: TRadioButton;
    OptionKompakt: TCheckBox;
    OptionLiteraturDrucken: TCheckBox;
    OptionNotizenDrucken: TCheckBox;
    OptionNurMarkierteZeigen: TCheckBox;
    OptionReferExport: TRadioButton;
    OptionRISExport: TRadioButton;
    OptionRTF: TRadioButton;
    OptionSucheLiteratur: TCheckBox;
    OptionSucheNotizen: TCheckBox;
    OptionWordExport: TRadioButton;
    Panel11: TPanel;
    PayPalSeite: TTabSheet;
    RegisterOptionen: TPageControl;
    SeiteErsetze: TTabSheet;
    SeiteOptionenDatenaustausch: TTabSheet;
    SeiteOptionenDrucken: TTabSheet;
    SeiteOptionenEinstellungen: TTabSheet;
    SeiteUpdate: TTabSheet;
    procedure FontListeChange(Sender: TObject);
    procedure FontSizesChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FormEinstellungen: TFormEinstellungen;

implementation
 uses unit1;
{$R *.lfm}

 { TFormEinstellungen }

 procedure TFormEinstellungen.FontListeChange(Sender: TObject);
 begin
  SetIni('feldinhaltfont',Fontliste.text);
  Fenster.FeldInhalt.Font.name:=Fontliste.text;

  Fenster.Feldinhalt.Refresh;
  ZeichenSatz:= Fontliste.text;
  FontBeispiel.caption:=Zeichensatz;
  FontBeispiel.Font.name:=Fontliste.text;
  //aktualisiert noch nicht
  fenster.timer.enabled:=false;
  fenster.timer.enabled:=true;
 end;

procedure TFormEinstellungen.FontSizesChange(Sender: TObject);
begin
   fenster.feldinhalt.font.size:=str2int(fontsizes.Text) ;
   fontbeispiel.Font.size:=fenster.Feldinhalt.font.size;
end;

procedure TFormEinstellungen.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin


end;

end.

