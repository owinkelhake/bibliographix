{The Softwddare is open source software which may be redistributed
and revised under the terms of the GNU General Public License of
the Free Software Foundation, version 2 or any later version,
see www.gnu.org/licenses.  }
unit Unit1;
 {$warnings off}

{$mode objfpc}{$H+}
 interface

uses
  {$IFDEF LINUX} baseunix,unix,  {$ENDIF}
  {$IFDEF WINDOWS}  shellapi,windirs,    {$ENDIF}      //ushelldragdrop,
  ExtCtrls,
  Classes,
  Controls,
  Clipbrd,
  ComCtrls,
  Dialogs,
  FileUtil,
  FileCtrl,
  Forms,
  fphttpclient,
  Graphics,
  Grids,
  LCLIntf,
  lcltype,
  Menus,
  RichMemo,
  StdCtrls,
  SysUtils,
  Types,
  uniqueinstanceraw;


const     //globale Konstanten
  myversion ='2026.02';

  Maxanzeige =             500;   // Maximale Anzahl der in der Trefferliste angezeigten Zettel
  MaxNodes = 500;                  // maximale Anzahl der Nodes in einem Tree

  blau =                   $00E8AC26;//$00CA6B30;

  RTFKleinAE='\'+ ''''+ 'e4';
  RTFGrossAE='\'+ ''''+ 'c4';
  RTFKleinOE='\'+ ''''+ 'f6';
  RTFGrossOE='\'+ ''''+ 'd6';
  RTFKleinUe='\'+ ''''+ 'fc';
  RTFGrossUe='\'+ ''''+ 'dc';
  RTFEsszett='\'+ ''''+ 'df';

  abstand= '                                                                                                            ';
  //Struktur des Trefferliste
  ListeSpalteMarkierung    = 0;
  ListeSpalteNummer        = 1;
  ListeSpalteIcon          = 2;
  ListeSpalteTitel         = 3;
  ListeSpaltePin           = 4;

  TrefferArraySpalteTyp =             3;
  TrefferArraySpalteID =              4;
  TrefferArraySpalteArrayZeile =      5;
  TrefferArraySpalteTitel  =          6;
  TrefferArraySpalteBearbeitung=      8;
  TrefferArraySpalteVolltext=         10;


  //Struktur beider Arrays
  Spalte_ID =                1;
  Spalte_Titel=              2;
  Spalte_Anmerkung=          3;
  Spalte_Volltext =          4;
  Spalte_Erstelldatum =      5;
  Spalte_Bearbeitungsdatum = 6;
  Spalte_Bearbeitungszahl =  7;
  Spalte_Position    =       8;

  //ab hier nur noch bei Literaturquellen besetzt

  Spalte_Autor =             9;
  Spalte_Publikationsdatum=  10;
  Spalte_Jahr =              11;
  Spalte_Untertitel=         12;
  Spalte_Band=               13;
  Spalte_Nummer=             14;
  Spalte_Seiten=             15;
  Spalte_Herausgeber =       16;
  Spalte_Sammelband =        17;
  Spalte_Verlag =            18;
  Spalte_Ort =               19;
  Spalte_Auflage=            20;
  Spalte_ISBN=               21;
  Spalte_Zeitschrift =       22;

  Spalte_Erstautor=          23;
  Spalte_KurzZitat   =       24;
  Spalte_Publikationstyp =   25;

  Spalte_Ende =              26; //maximale Spaltenzahl. Später kürzen
  Spalte_Vollzitat =         27;
  Spalte_Buchstabe =         28;
  Spalte_Quellenhinweis =    29;
  Spalte_Anzahl =            29;





type

  { TFenster }

  TFenster = class(TForm)
    Alles2: TImage;
    AnhangAlleAutoren: TCheckBox;
    AnzeigeVersion: TPanel;
    AuswahlFeld: TComboBox;
    BaumVerweise: TTreeView;
    BaumVerweise2: TTreeView;
    BaumVerweise3: TTreeView;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    Bevel15: TBevel;
    Bevel16: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    ButtonComboboxGliederung: TPanel;
    ButtonCutCopy: TButton;
    ButtonEineQuelle: TPanel;
    ButtonErsetze: TPanel;
    ButtonExport1: TPanel;
    ButtonGliederungLevel1: TPanel;
    ButtonGliederungLevel2: TPanel;
    ButtonLevelGliederung: TPanel;
    ButtonNeuDialogWeg: TImage;
    ButtonQuerverweisEnde5: TPanel;
    ButtonQuerverweisEnde6: TPanel;
    Dateneingabe: TEdit;
    DIYButtonNeueQuelleOK: TPanel;
    EingabeTitelNeueNotiz: TEdit;
    ErsatzText: TEdit;
    Feldinhalt: TRichMemo;
    FeldSuchText: TEdit;
    IconButton1: TImage;
    IconButton2: TImage;
    IconButton3: TImage;
    IconDateiVerweisKlein: TImage;
    IconEinstellungenKlein: TImage;
    IconGliederung2: TImage;
    IconHilfeKlein: TImage;
    IconLoeschen: TImage;
    IconSpeichernKlein: TImage;
    ButtonNeueGliederung: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    ImageOptionDarkMode: TImage;
    ImageOptionMenue: TImage;
    ImageSchlagwortlisteWeg: TImage;
    Label22: TLabel;
    LabelOptionMitQuerverweis: TLabel;
    Label30: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label6: TLabel;
    LabelHomepage: TLabel;
    ListeScrollbarTop: TImage;
    ListeScrollbarBottom: TImage;
    ImageSchlagwortlisteWeg1: TImage;
    Label26: TLabel;
    Label41: TLabel;
    LabelGliederungLevel1: TLabel;
    LabelGliederungLevel2: TLabel;
    LabelGliederungLevel3: TLabel;
    LabelGliederungLevelAll: TLabel;
    MemoFilter: TRichMemo;
    LabelTitelFilter: TPanel;
    Markierungenloeschen: TMenuItem;
    OptionAlleSeiten: TRadioButton;
    OptionAnmerkungenDrucken: TCheckBox;
    OptionBibTeX: TRadioButton;
    OptionBibtexExport: TRadioButton;
    OptionEineSeiteDrucken: TRadioButton;
    OptionGliederungDrucken: TRadioButton;
    OptionLiteraturDrucken: TCheckBox;
    OptionMitVerweis: TCheckBox;
    OptionNotizenDrucken: TCheckBox;
    OptionObsidianExport: TRadioButton;
    OptionReferExport: TRadioButton;
    OptionRISExport: TRadioButton;
    OptionRTF: TRadioButton;
    OptionSucheLiteratur: TCheckBox;
    OptionSucheNotizen: TCheckBox;
    OptionWordExport: TRadioButton;
    ScrollbarEndeGliederung1: TImage;
    ScrollbarGliederungHintergrund: TPanel;
    PanelNeueQuelle: TPanel;
    Panel8: TPanel;
    PanelF2: TPanel;
    PanelF3: TPanel;
    PanelUnterstrich: TPanel;
    PanelUnterstrichSuche: TPanel;
    RegisterEinstellungen: TPageControl;
    Panel11: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel9: TPanel;
    PanelIconEineQuelle: TPanel;
    PanelOptionDarkMode: TPanel;
    PanelOptionDetails2: TPanel;
    PanelOptionenDatenaustausch: TPanel;
    PanelOptionenDrucken: TPanel;
    PanelSchlagwortDazu1: TPanel;
    PanelSchlagwortDazu2: TPanel;
    PanelSchlagwortDazu3: TPanel;
    PanelSchlagwortWeg4: TPanel;
    runderbutton1: TPanel;
    runderbutton2: TPanel;
    runderbutton3: TPanel;
    DIYButtonZwischenablage: TPanel;
    DIYButtonKopieren: TPanel;
    DIYButtonTiteldatenSpeichern: TPanel;
    runderButtonLinks10: TImage;
    runderButtonLinks11: TImage;
    runderButtonLinks12: TImage;
    runderButtonLinks13: TImage;
    runderButtonLinks14: TImage;
    runderButtonLinks15: TImage;
    runderButtonLinks16: TImage;
    runderButtonLinks17: TImage;
    runderButtonLinks6: TImage;
    runderButtonLinks7: TImage;
    runderButtonLinks8: TImage;
    runderButtonRechts10: TImage;
    runderButtonRechts11: TImage;
    runderButtonRechts12: TImage;
    runderButtonRechts13: TImage;
    runderButtonRechts14: TImage;
    runderButtonRechts15: TImage;
    runderButtonRechts16: TImage;
    runderButtonRechts17: TImage;
    runderButtonRechts6: TImage;
    runderButtonRechts7: TImage;
    runderButtonRechts8: TImage;
    runderButtonSchaltflaeche10: TPanel;
    runderButtonSchaltflaeche11: TPanel;
    runderButtonSchaltflaeche12: TPanel;
    runderButtonSchaltflaeche13: TPanel;
    runderButtonSchaltflaeche14: TPanel;
    runderButtonSchaltflaeche15: TPanel;
    runderButtonSchaltflaeche16: TPanel;
    runderButtonSchaltflaeche5: TPanel;
    runderButtonSchaltflaeche6: TPanel;
    runderButtonSchaltflaeche7: TPanel;
    runderButtonSchaltflaeche9: TPanel;
    ScrollbarGliederungHintergrundOben: TPanel;
    ScrollbarGliederungSchieber: TPanel;
    ScrollbarListeSchieber: TPanel;
    ScrollbarListeHintergrund: TPanel;
    ListeScrollbar: TPanel;
    PanelEbenenAnzeigen: TPanel;
    memoGliederungen: TRichMemo;
    MemoSchlagwoerter: TRichMemo;
    ScrollbarAnmerkungenSchieber: TPanel;
    SeiteEinstellungenAnzeige: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    LabelTitelNeu: TPanel;
    UnterstrichPin: TPanel;
    UnterstrichStern: TPanel;
    IconPictureZitat: TImage;
    IconQV: TImage;
    IconRefresh: TImage;
    IconResizeVerweise: TBevel;
    IconSchlagwortKlein: TImage;
    IconUndo: TImage;
    IconZitatKlein: TImage;
    Image1: TImage;
    ImageEinstellungenWeg: TImage;
    ImageMenuSortierung: TImage;
    Labelsyntax: TLabel;
    MemoZwischenablage: TMemo;
    MenuSortTime: TMenuItem;
    MenuNurMarkierte: TMenuItem;
    MenuLiteraturZeigen: TMenuItem;
    MenuNotizenZeigen: TMenuItem;
    HintergrundEinstellungen: TPanel;
    PanelCaptionEinstellungen: TPanel;
    runderbutton: TPanel;
    runderButtonLinks9: TImage;
    runderButtonRechts9: TImage;
    runderButtonSchaltflaeche8: TPanel;
    Separator7: TMenuItem;
    MenuSortAlpha: TMenuItem;
    PanelPtyp: TPanel;
    PanelSchlagwortWeg1: TPanel;
    PanelSchlagwortWeg2: TPanel;
    PanelTitelDaten: TPanel;
    PanelSchlagwortDazu: TPanel;
    PanelSchlagwortWeg: TPanel;
    MenuSortierung: TPopupMenu;
    RadioArtikel: TRadioButton;
    RadioBuch: TRadioButton;
    RadioKapitel: TRadioButton;
    RadioSammelband: TRadioButton;
    runderAnfang: TImage;
    runderButtonLinks1: TImage;
    runderButtonLinks2: TImage;
    runderButtonLinks4: TImage;
    runderButtonLinks5: TImage;
    runderButtonRechts1: TImage;
    runderButtonRechts2: TImage;
    runderButtonRechts4: TImage;
    runderButtonRechts5: TImage;
    runderButtonSchaltflaeche1: TPanel;
    runderButtonSchaltflaeche2: TPanel;
    runderButtonSchaltflaeche3: TPanel;
    runderButtonSchaltflaeche4: TPanel;
    rundesEnde: TImage;
    ImageSucheingabeLupe: TImage;
    IconFormatierung: TImage;
    ImagePin: TImage;
    ImageStern: TImage;
    ImageSucheBackspace: TImage;
    LabelButton1: TLabel;
    LabelButton2: TLabel;
    LabelButton3: TLabel;
    LabelGliederungName: TLabel;
    LabelComboboxGliederung: TLabel;
    LabelErstelltAm: TLabel;
    LabelFussnote: TLabel;
    LabelGeaendertAm: TLabel;
    LabelTitel: TEdit;
    LabelVerweise: TLabel;
    LabelVollzitat: TLabel;
    MenuAlsCode: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    Panel1: TPanel;
    PanelButton1: TPanel;
    PanelButtonHerausnehmen: TPanel;
    PanelButtonGliedern: TPanel;
    PanelSucheingabeLinks: TPanel;
    PanelSucheingabe: TPanel;
    PanelGliederungKopf: TPanel;
    Panel5: TPanel;
    PanelSucheingabeRechts: TPanel;
    PanelSucheingabeMitte: TPanel;
    PanelAnmerkungenScrollbarButton: TPanel;
    ScrollbarAnmerkungen: TPanel;
    PanelErstelltAm: TPanel;
    PanelFeldInhalt: TPanel;
    PanelFeldinhaltIcons: TPanel;
    PanelInhalt: TPanel;
    PanelTitel: TPanel;
    PanelUnterDemText: TPanel;
    PanelUnterstrichTitel: TPanel;
    PanelVergebeneKeywords: TPanel;
    PanelVerweiseAufDieseSeite: TPanel;
    PanelVollzitat2: TPanel;
    Separator3: TMenuItem;
    Separator2: TMenuItem;
    MenuItem5: TMenuItem;
    MenuFett: TMenuItem;
    MenuItem9: TMenuItem;
    MenuSpiegelstrich: TMenuItem;
    MenuKursiv: TMenuItem;
    PopupTextFormatierung: TPopupMenu;
    Separator5: TMenuItem;
    Separator6: TMenuItem;
    Separator8: TMenuItem;
    SuchEingabe: TEdit;
    Einstellungen: TTabSheet;
    TitelDaten: TTabSheet;
    TitelDatenmatrix: TStringGrid;
    URLHomepage: TLabel;
    CancelTiteldaten: TImage;
    Vorschlagsliste: TListBox;
    Zwischenspeichern: TIdleTimer;
    ImageSWWeg: TImage;
    ImageQVWeg: TImage;
    ButtonAnlegen: TPanel;
    ScrollbarGliederung: TPanel;
    PanelKombinierterSchlagwoerter: TPanel;
    PanelUnterstrichQuer: TPanel;
    ScrollbarAnfangGliederung: TImage;
    ScrollbarEndeGliederung: TImage;
    FontDialog: TFontDialog;
    ImageHighDPIStar: TImage;
    LabelTitelNotizGliedern: TLabel;
    LabelTrefferzahl: TPanel;
    ListeNotizGliedern: TListBox;
    PanelLabelSuchen1: TPanel;
    PanelNotizGliedern: TPanel;
    PanelUnterstrichSuche1: TPanel;
    Fortschritt: TProgressBar;
    Gliederung: TTreeView;
    Herausgeberformat: TComboBox;
    imageToggleoff: TImage;

    imageToggleon: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label25: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LabelEditorNamen: TLabel;
    Label12: TLabel;
    Label7: TLabel;
    LabelFormatAnhang: TLabel;
    LabelHerausgeber1: TLabel;
    LabelNameRichtlinie: TLabel;
    LabelOriginaldatei: TLabel;
    LabelQuellenhinweise: TLabel;
    LabelTitelQuerverweis: TPanel;
    LabelVorschau: TLabel;
    LetztenNamenUmdrehen: TCheckBox;
    NamensFormat: TComboBox;
    NamensTrennzeichen: TEdit;
    LetztNamensTrennzeichen: TEdit;
    etal: TEdit;
    OptionLangesTMPZitat: TCheckBox;
    Panel35: TPanel;
    Panel37: TPanel;
    Panel38: TPanel;
    Panel39: TPanel;
    Panel4: TPanel;
    Panel40: TPanel;
    Panel41: TPanel;
    Panel42: TPanel;
    Panel43: TPanel;
    Panel44: TPanel;
    LabelTitelschlagwort: TPanel;
    Panel47: TPanel;
    PanelHintergrundLink: TPanel;
    Panelhintergrundoben: TPanel;
    PanelFormatierung: TPanel;
    Panel27: TPanel;
    Panel31: TPanel;
    Panel32: TPanel;
    Panel34: TPanel;
    PanelHintergrundSchlagwort: TPanel;
    PanelHintergrundUnten: TPanel;
    PanelManuskript: TPanel;
    Panel28: TPanel;
    Panel29: TPanel;
    Panel30: TPanel;
    QListe: TListBox;
    QSuche: TEdit;
    QuellenHinweisTyp: TComboBox;
    PTypBuch: TRadioButton;
    PTypArtikel: TRadioButton;
    PTypKapitel: TRadioButton;
    PTypWebseite: TRadioButton;
    QuerverweisAllesZeigen: TImage;
    SuchEingabe2: TEdit;
    Tabelle: TStringGrid;
    SeiteSchlagwort: TTabSheet;
    SeiteQuerverweis: TTabSheet;
    NachFormCreate: TTimer;
    HomemadeButton: TPanel;

    icon24: TImageList;
    icon16: TImageList;
    ImageNachLinks: TImage;
    ImageNavigate: TImage;
    ImageNachRechts: TImage;
    ImageNachOben: TImage;
    ImageNachUnten: TImage;
    Liste: TStringGrid;


    Panel16: TPanel;
    HintergrundVolltext: TPanel;
    HintergrundGliederung: TPanel;
    Panel33: TPanel;
    PanelMenuVolltextsuche: TPanel;
    PanelGliederungIcons: TPanel;
    PanelIconHerausnehmen: TPanel;
    PanelDrucken: TPanel;
    PanelIconNotizGliedern: TPanel;
    MenuFussnote: TMenuItem;
    MenuHilfe: TMenuItem;
    HauptMenu: TMainMenu;


    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    Separator1: TMenuItem;

    MenuDatei: TMenuItem;
    MenuQuerverweis: TMenuItem;
    MenuDateiverweis: TMenuItem;
    MenuBearbeiten: TMenuItem;
    MenuSpeichern: TMenuItem;
    MenuNeueNotiz: TMenuItem;
    MenuItemAbstandLinks: TMenuItem;
    MenuSchlagwort: TMenuItem;
    MenuNeueQuelle: TMenuItem;



    Panel49: TPanel;


    OpenDirectory: TSelectDirectoryDialog;

    MenueLock: TMenuItem;
    PanelZitierrichtlinie: TPanel;
    RegisterSuche: TPageControl;
    SeiteVolltextsuche: TTabSheet;
    SeiteGliederung: TTabSheet;
    VorschlagFensterWeg3: TImage;
    MenuPopupEinfuegen: TMenuItem;
    MenuPopupKopieren: TMenuItem;
    PanelSizer: TPanel;
    eingabeIdeenKopieren: TEdit;
    FensterEditor: TPanel;
    IdeenKopierenSeite: TTabSheet;
    IdeenSeite: TTabSheet;
    KontextListe: TListBox;
    ListeIdeenKopierenLinks: TStringGrid;
    Ausgabe:   TMemo;
    MemoIdeenKopierenLinks: TMemo;

    Panel128: TPanel;
    PanelIdeenLinks: TPanel;
    PanelStyleName: TPanel;
    Registerkarten: TPageControl;
    Resteseite: TTabSheet;
    FeldTitel2: TPanel;
    StyleSeite: TTabSheet;
    EditorLeerzeile: TMenuItem;
    Kategorie1Weg: TImage;
    LabelKategorie1: TLabel;
    DateiListe:    TFileListBox;
    FeldAuflage: TMenuItem;
    FeldAutor: TMenuItem;
    FeldBand: TMenuItem;
    FeldDatum: TMenuItem;
    FeldHerausgeber: TMenuItem;
    FeldJahr: TMenuItem;
    FeldLeer: TMenuItem;
    FeldNummer1: TMenuItem;
    FeldOrt: TMenuItem;
    FeldSammelband: TMenuItem;
    FeldSeiten: TMenuItem;
    FeldTitel1: TMenuItem;
    FeldUntertitel: TMenuItem;
    FeldVerlag: TMenuItem;
    FeldZeitschrift: TMenuItem;
    MenuFelder: TPopupMenu;
    FormatFett: TMenuItem;
    FormatKursiv: TMenuItem;
    FormatNormal: TMenuItem;
    FormatUnterstrichen: TMenuItem;
    MenuFormat: TPopupMenu;

    PopupListe: TPopupMenu;
    FeldURL: TLabel;
    FeldURL2: TLabel;
    Hintergrund: TPanel;
    OpenDialog: TOpenDialog;
    Timer: TTimer;
    NotizGliedernFensterWeg: TImage;




    procedure BaumVerweise2Click(Sender: TObject);
    procedure BaumVerweise3Click(Sender: TObject);
    procedure Bevel4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonAnlegenClick(Sender: TObject);
    procedure ButtonFettClick(Sender: TObject);
    procedure ButtonKopierenClick(Sender: TObject);
    procedure ButtonKursivClick(Sender: TObject);
    procedure ButtonListeAnfangClick(Sender: TObject);
    procedure ButtonListeVorClick(Sender: TObject);
    procedure ButtonListeZurueckClick(Sender: TObject);
    procedure ButtonNeuDialogWegClick(Sender: TObject);
    procedure ButtonNeueGliederungClick(Sender: TObject);
    procedure ButtonScrolldownClick(Sender: TObject);
    procedure ButtonSpiegelstrichClick(Sender: TObject);
    procedure ButtonTiteldatenSpeichernClick(Sender: TObject);
    procedure ButtonTrefferHochClick(Sender: TObject);
    procedure ButtonTrefferRunterClick(Sender: TObject);
    procedure CancelTiteldatenClick(Sender: TObject);
    procedure DateneingabeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DateneingabeKeyPress(Sender: TObject; var Key: char);
    procedure DateneingabeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EingabeTitelNeueNotizKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EinstellungenShow(Sender: TObject);
    procedure FeldinhaltChange(Sender: TObject);
    procedure FeldinhaltKeyPress(Sender: TObject; var Key: char);
    procedure FontDialogClose(Sender: TObject);
    procedure GrenzeSchlagwortsucheEinClick(Sender: TObject);
    procedure HomemadeButtonMouseEnter(Sender: TObject);
    procedure HomemadeButtonMouseLeave(Sender: TObject);
    procedure IconFormatierungClick(Sender: TObject);
    procedure IconQVMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure IconWeiterSpulenClick(Sender: TObject);
    procedure IconZumAnfangSpulenClick(Sender: TObject);
    procedure IconZurueckSpulenClick(Sender: TObject);
    procedure IdeenSeiteEnter(Sender: TObject);
    procedure IdeenSeiteExit(Sender: TObject);
    procedure ButtonScrollUpClick(Sender: TObject);
    procedure IconAnsEndeSpulenClick(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure ImageMenuSortierungClick(Sender: TObject);
    procedure ImageSchlagwortlisteWegClick(Sender: TObject);
    procedure Buttonscholarclick(Sender: TObject);
    procedure KMemo1Change(Sender: TObject);
    procedure Label27Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure LabelKapitelClick(Sender: TObject);
    procedure LabelOptionMitQuerverweisClick(Sender: TObject);
    procedure LabelSammelbandClick(Sender: TObject);
    procedure LabelTrefferzahlClick(Sender: TObject);
    procedure LabelVerweiseClick(Sender: TObject);
    procedure ListeGliederungen2Change(Sender: TObject);
    procedure ListeGliederungen2Click(Sender: TObject);
    procedure ListeGliederungen2DblClick(Sender: TObject);
    procedure MarkierungenloeschenClick(Sender: TObject);
    procedure MemoFilterChange(Sender: TObject);
    procedure MemoFilterClick(Sender: TObject);
    procedure MemoGliederungenChange(Sender: TObject);
    procedure MemoGliederungenClick(Sender: TObject);
    procedure MemoGliederungenMouseEnter(Sender: TObject);
    procedure MemoSchlagwoerterClick(Sender: TObject);
    procedure MenuLiteraturZeigenClick(Sender: TObject);
    procedure MenuNotizenZeigenClick(Sender: TObject);
    procedure MenuNurMarkierteClick(Sender: TObject);
    procedure MenuSortAlphaClick(Sender: TObject);
    procedure MenuSortTimeClick(Sender: TObject);
    procedure OptionRISExportChange(Sender: TObject);
    procedure PanelInhaltClick(Sender: TObject);
    procedure RegisterEinstellungenChange(Sender: TObject);
    procedure PanelhintergrundobenClick(Sender: TObject);
    procedure runderButtonRechts11Click(Sender: TObject);
    procedure runderButtonSchaltflaeche16Click(Sender: TObject);
    procedure ScrollbarGliederungHintergrundClick(Sender: TObject);
    procedure ScrollbarGliederungHintergrundObenClick(Sender: TObject);
    procedure ScrollbarListeHintergrundClick(Sender: TObject);
    procedure ScrollbarTextHintergrund(Sender: TObject);
    procedure ScrollbarAnmerkungenClick(Sender: TObject);
    procedure PanelPanikClick(Sender: TObject);
    procedure PanikButtonClick(Sender: TObject);
    procedure RichMemo1Change(Sender: TObject);
    procedure SchlagwortlisteZeigenClick(Sender: TObject);
    procedure ScrollBoxEinstellungenClick(Sender: TObject);
    procedure SeiteVolltextsucheShow(Sender: TObject);
    procedure switchMouseEnter(Sender: TObject);
    procedure ScrollbarAnfangGliederungClick(Sender: TObject);
    procedure ImageCodeClick(Sender: TObject);
    procedure ImageFontClick(Sender: TObject);
    procedure ListeGliederungenClick(Sender: TObject);
    procedure FarbSchemaClick(Sender: TObject);
    procedure fragKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IconCombobox1Click(Sender: TObject);
    procedure ImageOptionDarkModeClick(Sender: TObject);
    procedure ImageOptionMenueClick(Sender: TObject);
    procedure Label13Click(Sender: TObject);
    procedure Label14Click(Sender: TObject);
    procedure Label15Click(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure Label17Click(Sender: TObject);
    procedure Label18Click(Sender: TObject);
    procedure Label19Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label20Click(Sender: TObject);
    procedure Label21Click(Sender: TObject);
    procedure Label23Click(Sender: TObject);
    procedure Label24Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label56Click(Sender: TObject);
    procedure Label57Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure LabelEinstellungenAnzeigeClick(Sender: TObject);
    procedure LabelEinstellungenDatenaustauschClick(Sender: TObject);
    procedure LabelEinstellungenDruckenClick(Sender: TObject);
    procedure LabelEinstellungenErsetzeClick(Sender: TObject);
    procedure LabelEinstellungenUpdateClick(Sender: TObject);
    procedure LabelHerausgeber1Click(Sender: TObject);
    procedure FeldinhaltDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FeldinhaltEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure fragKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IconVolltextSucheKleinClick(Sender: TObject);
    procedure ListeNotizGliedernClick(Sender: TObject);
    procedure ListeSchlagwortsucheClick(Sender: TObject);
    procedure NachFormCreateTimer(Sender: TObject);
    procedure Panel13Click(Sender: TObject);
    procedure Panel14Click(Sender: TObject);
    procedure ButtonErsetzeClick(Sender: TObject);
    procedure ScrollbarEndeGliederungClick(Sender: TObject);
    procedure PruefeAbsturzClick(Sender: TObject);
    procedure QSucheKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure QuerverweisAllesZeigenClick(Sender: TObject);
    procedure RegisterOptionenChange(Sender: TObject);
    procedure SchlagwortmatrixClick(Sender: TObject);
    procedure SuchEingabe2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure switchMouseLeave(Sender: TObject);
    procedure NotizGliedernFensterWegClick(Sender: TObject);
    procedure TitelDatenExit(Sender: TObject);
    procedure TitelDatenmatrixClick(Sender: TObject);
    procedure TitelDatenmatrixDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure TitelDatenmatrixKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TitelDatenmatrixKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VorschlagslisteClick(Sender: TObject);
    procedure zeigealleSchlagwoerterClick(Sender: TObject);
    procedure zeigeSchlagwoerterClick(Sender: TObject);
    procedure iconaddkeywordClick(Sender: TObject);
    procedure iconremovekeywordClick(Sender: TObject);
    procedure URLHomepageClick(Sender: TObject);
    procedure LabelTitelExit(Sender: TObject);
    procedure LabelTitelKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure ListePrepareCanvas(sender: TObject; aCol, aRow: Integer;
      aState: TGridDrawState);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuNeueNotizClick(Sender: TObject);
    procedure ButtonUeberschriftClick(Sender: TObject);
    procedure PanelVergebeneKeywordsClick(Sender: TObject);
    procedure SeiteGliederungShow(Sender: TObject);
    procedure StyleSeiteExit(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure ExportObsidianClick(Sender: TObject);
    procedure CaptionSeiteGliedernClick(Sender: TObject);
    procedure FeldinhaltMouseEnter(Sender: TObject);
    procedure FeldinhaltMouseLeave(Sender: TObject);
    procedure GliedernBildClick(Sender: TObject);
    procedure IconResizeVerweiseMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image4Click(Sender: TObject);
    procedure ImageQuelle1Click(Sender: TObject);
    procedure ImageQuelleClick(Sender: TObject);
    procedure ImageUpdateClick(Sender: TObject);
    procedure Label29Click(Sender: TObject);
    procedure LabelGliederung(Sender: TObject);
    procedure Label25Click(Sender: TObject);
    procedure LabelSucheClick(Sender: TObject);


    procedure ListeMouseEnter(Sender: TObject);
    procedure MenueLockClick(Sender: TObject);
    procedure MenuZeilenumbruchClick(Sender: TObject);
    procedure AnzahlVorschlagMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; x, Y: Integer);
    procedure BaumVerweiseClick(Sender: TObject);
    procedure BaumVerweiseDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Image31Click(Sender: TObject);
    procedure ListeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure Image12Click(Sender: TObject);
    procedure ImageDatenaustauschClick(Sender: TObject);
    procedure LabelKurzzitatClick(Sender: TObject);
    procedure RegisterSucheChange(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure ButtonCutCopyClick(Sender: TObject);
    procedure Button31Click(Sender: TObject);
    procedure Button35Click(Sender: TObject);
    procedure IconPapierkorbLoeschenDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ButtonDialogAbbruchClick(Sender: TObject);
    procedure ButtonDrillDownWegClick(Sender: TObject);
    procedure Button47Click(Sender: TObject);
    procedure ButtonAusgabeClick(Sender: TObject);
    procedure ButtonGliederungLevel1Click(Sender: TObject);
    procedure ButtonGliederungLevel2Click(Sender: TObject);
    procedure ButtonGliederungLevel3Click(Sender: TObject);
    procedure ButtonGliederungLevelAllClick(Sender: TObject);
    procedure ButtonspeichernClick(Sender: TObject);
    procedure CaptionSpendeVierEuroClick(Sender: TObject);
    procedure CaptionSpendeZehnEuroClick(Sender: TObject);
    procedure FakeCaptionMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FeldinhaltDblClick(Sender: TObject);
    procedure FeldinhaltKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FeldinhaltMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FeldinhaltMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure GliederungCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure IconPapierkorbLoeschenClick(Sender: TObject);
    procedure Image15Click(Sender: TObject);
    procedure button180Click(Sender: TObject);
    procedure ImageEinstellungenClick(Sender: TObject);
    procedure IconGliederungKleinClick(Sender: TObject);
    procedure Image29Click(Sender: TObject);
    procedure Image30Click(Sender: TObject);
    procedure Image49Click(Sender: TObject);
    procedure IconRefreshClick(Sender: TObject);
    procedure Image62Click(Sender: TObject);
    procedure Image37Click(Sender: TObject);
    procedure ImageEineQuelleExportierenClick(Sender: TObject);
    procedure Image61Click(Sender: TObject);
    procedure Label96Click(Sender: TObject);
    procedure ListeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MenuListeAnheftenClick(Sender: TObject);
    procedure MenuListeFontMinusClick(Sender: TObject);
    procedure MenuListeFontPlusClick(Sender: TObject);
    procedure MenuListeMarkierenClick(Sender: TObject);
    procedure MenuListeVollzitatClick(Sender: TObject);
    procedure MenuPopupEinfuegenClick(Sender: TObject);
    procedure MenuPopupKopierenClick(Sender: TObject);
    procedure MenuPunktVerweiseDblClick(Sender: TObject);
    procedure clabel1Click(Sender: TObject);
    procedure EditorLeerzeileClick(Sender: TObject);
    procedure FeldAuflageClick(Sender: TObject);
    procedure FeldAutorClick(Sender: TObject);
    procedure FeldBandClick(Sender: TObject);
    procedure FeldDatumClick(Sender: TObject);
    procedure FeldHerausgeberClick(Sender: TObject);
    procedure FeldInhaltClick(Sender: TObject);
    procedure feldinhaltEnter(Sender: TObject);
    procedure feldinhaltExit(Sender: TObject);
    procedure FeldJahrClick(Sender: TObject);
    procedure FeldLeerClick(Sender: TObject);
    procedure FeldNummer1Click(Sender: TObject);
    procedure FeldOrtClick(Sender: TObject);
    procedure FeldSammelbandClick(Sender: TObject);
    procedure FeldSeitenClick(Sender: TObject);
    procedure FeldTitel1Click(Sender: TObject);
    procedure FeldUntertitelClick(Sender: TObject);
    procedure FeldVerlagClick(Sender: TObject);
    procedure FeldZeitschriftClick(Sender: TObject);
    procedure FormatFettClick(Sender: TObject);
    procedure FormatKursivClick(Sender: TObject);
    procedure FormatUnterstrichenClick(Sender: TObject);
    procedure IconPictureQuellenhinweisClick(Sender: TObject);
    procedure IconTitelbearbeitenClick(Sender: TObject);
    procedure Image10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageUndoClick(Sender: TObject);
    procedure MenuGroesserClick(Sender: TObject);
    procedure MenuKleinerClick(Sender: TObject);
    procedure OptionAnheftenClick(Sender: TObject);
    procedure OptionAnheftenMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OptionMarkierenClick(Sender: TObject);
    procedure OptionMarkiertMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OptionPapierkorbClick(Sender: TObject);
    procedure OptionSchreibschutzMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelHinterDenPunktenClick(Sender: TObject);
    procedure PopupListePopup(Sender: TObject);
    procedure SuchEingabeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VollTextIdleTimer(Sender: TObject);
    procedure AddKeywordsWegClick(Sender: TObject);
    procedure IconGliederungClick(Sender: TObject);
    procedure IconGliederung2Click(Sender: TObject);
    procedure LabelBibtexKeyClick(Sender: TObject);
    procedure LabelNotizenzahl1Click(Sender: TObject);
    procedure LabelTeilDerGliederungClick(Sender: TObject);
    procedure ListeDrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect;
      aState: TGridDrawState);
    procedure MenuNeueQuelleClick(Sender: TObject);
    procedure OptionLangesTMPZitatChange(Sender: TObject);
    procedure RISExportZwischenablageClick(Sender: TObject);
    procedure MenuHilfeClick(Sender: TObject);
    procedure OptionLiteraturChange(Sender: TObject);
    procedure OptionNotizenChange(Sender: TObject);
    procedure RichtLinieInternSpeichernClick(Sender: TObject);
    procedure ButtonFelderleerenClick(Sender: TObject);
    procedure DiyButtonEnter(Sender: TObject);
    procedure DIYButtonLeave(Sender: TObject);
    procedure AlleAnzeigenClick(Sender: TObject);
    procedure ausschaltenClick(Sender: TObject);
    procedure BevelLiteraturAnmerkungMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; x, Y: Integer);
    procedure eingabeIdeenKopierenKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormatNormalClick(Sender: TObject);
    procedure HerausgeberformatChange(Sender: TObject);
    procedure ListeIdeenKopierenLinksClick(Sender: TObject);
    procedure ListeIdeenKopierenLinksMouseWheel(Sender: TObject;
      Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
      var Handled: Boolean);
    procedure NamensFormatChange(Sender: TObject);
    procedure QuellenHinweisTypChange(Sender: TObject);
    procedure FormWindowStateChange(Sender: TObject);
    procedure IconEinstellungenWegClick(Sender: TObject);
    procedure IconLiteraturAnmerkungenWeg1Click(Sender: TObject);
    procedure IconNeueQuelleClick(Sender: TObject);
    procedure IconLiteraturAnmerkungenWegClick(Sender: TObject);
    procedure einschaltenClick(Sender: TObject);
    procedure IconLiteraturDateiVerweisClick(Sender: TObject);
    procedure IconAllesSpeichernClick(Sender: TObject);
    procedure IconLiteraturZitierenClick(Sender: TObject);
    procedure LabelVollzitatClick(Sender: TObject);
    procedure ListeLiteraturVerweisNotizenClick(Sender: TObject);
    procedure OptionAPAClick(Sender: TObject);
    procedure OptionMLAClick(Sender: TObject);
    procedure SeiteArtikelShow(Sender: TObject);
    procedure SeiteBuchShow(Sender: TObject);
    procedure SeiteKapitelShow(Sender: TObject);
    procedure SeiteWebseiteShow(Sender: TObject);
    procedure StandBySeiteHide(Sender: TObject);
    procedure StyleSeiteShow(Sender: TObject);
    procedure TabelleClick(Sender: TObject);
    procedure TabelleKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ZusatzLiteraturSucheClick(Sender: TObject);
    procedure ButtonNeuesKapitelClick(Sender: TObject);
    procedure GoogleSucheClick(Sender: TObject);
    procedure IconDruckenClick(Sender: TObject);
    procedure IdeenSucheClick(Sender: TObject);
    procedure IconMeinOpacClick(Sender: TObject);
    procedure PanelGliederungKopfClick(Sender: TObject);
    procedure VerweismatrixDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure FormDropFiles(Sender: TObject; const FileNames: array of string);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure GliederungDragDrop(Sender, Source: TObject; x, Y: integer);
    procedure GliederungDragOver(Sender, Source: TObject; x, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure IconSchlagwortClick(Sender: TObject);
    procedure ButtonQuellenhinweisClick(Sender: TObject);
    procedure DateiverweisClick(Sender: TObject);
    procedure FeldInhaltKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FeldTitelDblClick(Sender: TObject);
    procedure FeldURL2Click(Sender: TObject);
    procedure FeldURLClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);

    Procedure AppDeactivate(Sender: TObject);
    Procedure AppActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);

    procedure OptionMarkiertZeigenChange(Sender: TObject);
    procedure ImageNachLinksClick(Sender: TObject);
    procedure IconTitelDatenWegClick(Sender: TObject);
    procedure ImageNachRechtsClick(Sender: TObject);
    procedure ImageNachUntenClick(Sender: TObject);
    procedure ImageNachObenClick(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure LabelOptionBibtexClick(Sender: TObject);
    procedure LabelHerausnehmenClick(Sender: TObject);
    procedure LabelNachObenClick(Sender: TObject);
    procedure LabelNachUntenClick(Sender: TObject);
    procedure LabelAufnehmenClick(Sender: TObject);
    procedure MenuIdeenSchlagwortClick(Sender: TObject);
    procedure MenuSuchenVolltextClick(Sender: TObject);
    procedure LabelModulStylerClick(Sender: TObject);
    procedure ListeClick(Sender: TObject);
    procedure ListeMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
    procedure NeueKarteClick(Sender: TObject);
    procedure IdeenSpeichernClick(Sender: TObject);
    procedure SuchEingabeClick(Sender: TObject);
    procedure SuchEingabeKeyDown(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure TimerTimer(Sender: TObject);
    procedure GliederungClick(Sender: TObject);
    procedure VerweisErstellenClick(Sender: TObject);
    procedure VorschlagMittelPunktClick(Sender: TObject);
    procedure ApplicationSessionEnded(Sender: TObject);  //Wird beim Herunterfahren aufgerufen


    procedure SetCellPicture(Rect: TRect; Picture: TGraphic; Grid : TStringGrid;hoffset, voffset:integer);
    procedure ZwischenspeichernTimer(Sender: TObject);

  private
    { private declarations }
             FHTTPClient: TFPHTTPClient; // Download mit HTTP für Updates
             procedure Download(AFrom, ATo: String);
  public
    { public declarations }
  end;

  //Hier werden die Funktionen deklariert, die aus anderen Units aufgerufen werden sollen

  { Funktionen, die den Text im Anmerkungsfeld bearbeiten }
  function HolAnmerkungen():boolean;
  function formatmd(von,laenge:integer;highlightkeyword:boolean):boolean;
  function GetSelWordMemo(Memo: TRichMemo): string;
  function GetMemoSelstart(Memo: TRichMemo): integer;
  function paste(mitte:string):boolean ;                                         { etwas umständlich, weil richmemo unter Linux an
                                                                                   dieser Stelle buggy ist }
  function ScrollbarAnmerkungenPositionieren(punkt:integer):boolean;             { Soll der Schieber des Scrollbars des Anmerkungsfelds
                                                                                   oben oder unten positioniert werden ? }



  { Funktionen, die die Gliederung verwalten }
  function aufraeumen():boolean;
  function GliederungArrayEinlesen():boolean  ;
  function Gliederungspeichern(fname:string):boolean;
  function Gliederungmd():boolean;



  { Funktionen, die aus dem Array lesen }
  function GetMaxID(ofwhat:string):integer;
  function HolErstautor(Datenzeile:integer):string;
  function HolNotizIdAusNoteLink(st:string):string;
  function HolLiteraturIdAusrefLink(st:string):string;
  function HolTitelderNotizID(id: integer): string;
  function HolArrayZeileDesTitels(titel: string): integer;
  function HolIDdesNotizTitels(t:string):string;
  function HolArrayZeileDerNotizID(id: string): integer;
  function HolArrayZeileDerLiteraturID(id: string): integer;

  { Funktionen, die Zeit berechnen }
  function UpdateBearbeitungszahl():boolean;
  function VergangeneZeitBerechnen(eingabe:string):string;
  function KalenderDatum(eingabe:string):string;
  function VergangeneZeit(eingabe:string):string;


  { Funktionen, die Daten austauschen }
  function IdentifiziereImportFormat(dat:string):string ;
  function importReferDB(inputfilename:string):boolean;
  function importBibTexDB(inputfilename:string):boolean;
  function importPubMedDB(inputfilename:string):boolean;
  function importRISDB(inputfilename:string):boolean;
  function importz3950DB(inputfilename:string):boolean;
  function IncreaseMaxID(ofwhat:string):boolean;

  function LiteraturLaden(welcheDB,Dateiname:string):boolean;


  { Funktionen, die betriebssystemnah sind }
  function Busy():boolean;
  function deletefileplus(Datei:string):boolean;
  function HolOS():string;
  function MachPause():boolean;
  function MeinVerzeichnis(os:string):string;
  function NoBox(const aMsg: string): Boolean;
  function ShowMsg(s:string):boolean;  { flexibler als showmessage. Kann man umdefinieren }
  function slash(os:string):string ;
  function str2int(ein:string):integer  ;
  function YesBox(const aMsg: string): Boolean;

  { Funktionen, die Zeichenketten bearbeiten }
  function deleteFirstWord(ein:string):String;
  function deleteLastChar(ein:string):String;
  function DeleteLastWord(ein:string):String;
  function extracturl(zeile: string): string;
  function getLastWord(ein:string):String;
  function getFirstWord(ein:string):String;
  function LiteraturVolltext(az:integer):boolean;
  function NotizVolltext(i: integer): string;
  function SonderzeichenRaus(ein:string):string ;
  function trim2(ein:string) : string;
  function UmlautZeichenWeg(zeile:string):string;
  function UmlautInListe(zeile:string):string;
  function umlautRTFtoXML(zeile:string):string;
  function umlautXMLtoRTF(zeile:string):string;
  function Zahlenausfiltern(ein:string):string;



  { Funktionen, die Benutzereinstellungen verwalten }
  function SetIni(variable,wert:string):boolean;
  function SetIntegerIni(variable:string;wert:integer):integer;

  { Funktionen, die die Benutzeroberfläche formatieren }
  function Nachricht(s:string;t:integer):boolean;  { Meldung, die aber keine Programmunterbrechung wie showmessage bringen soll }
  function resizewindow():boolean;
  function ZeichensatzEinstellen():boolean;
  function FocusTo(what:string):boolean;

  { Funktionen, die das Titeldatenformular verwalten }
  function AutoComplete(feld,t:string):boolean  ;
  function FindeVerlagsOrt(verlag:string):boolean;
  function ZeigeTitelDaten():boolean;


  { Funktionen, die die Querverweise verwalten }
  function sortqlist(treffer:integer;kriterium:string):boolean ;

  { Funktionen, die die Suchfunktion verwalten      }

  function LeereListenZeilenAmEndeLoeschen():boolean; { falls es in der Trefferliste noch Müll am Ende der Liste gibt }
  function SetFilterHeight():boolean;
  function ListeSchieberHeight():boolean;


  { Funktionen, die Schlagwörter verwalten }
  function insertkeyword(sw:string):boolean;

  { Funktionen, die abspeichern }
  function DatenArrayKomplettSichern():boolean;
  function SaveChangesToArray():boolean;
  function Schreibrecht():boolean;
  function LiteraturDatenbankKomplettAbspeichern():boolean;
  function GetTopEmptyRow(ofwhat:string):integer;
  function sortDB(dbname:string):boolean;





var
  //Globale Variablen


  IdeenDatenbank:string;

  minimum: integer;



  FontKorrektur: string;
  HeruntergeladenVon:string;
  OSFontKorrektur:integer;
  OptionRIS:boolean;
  Rechnername:string;
  Gliederungsdatei:string;



  Fenster: TFenster;


  //-AAAAAAAAAAAAAAAAAAAAAAAA

  ab                             :string; //Zeitliche Eingrenzung bei Suche
  AktuelleLiteraturID            :string;
  AktuelleNotizID                :string;
  AktuelleLiteraturArrayZeile    :integer;
  AktuelleNotizenArrayZeile      :integer;
  AktuelleNotizSuche             :string;
  AlteNotizZahl                  :integer;
  AngezeigterTyp                 :string;
  AnzeigeModus                   :string;
  AnzahlIdeen                    :string;
  ArraySize_Daten                :integer; //Zahl der Reihen im Daten-Array
  ArraySize_Literatur            :integer; //Zahl der Reihen im Literatur-Array

  AusgangsSeite                  :integer;



  bis                            :string; //zeitliche Eingrenzung bei Suche
  bxinisaved                     :boolean;
  bxiniarray                     :array[1..500,1..2] of string;


  //-DDDDDDDDDDDDD__
   Daten: array of array of string;



  DBDirectory:string; //Dort liegen die Datenbanken
  DummyString:string;
  DummyInteger:integer;




  //---------FFFFFFFFFFFFFFF---------------
  FarbeTextQuerverweis:  Tcolor;
  FarbeTextSchlagwort:   TColor;
  FarbePanelKopf:        TColor;
  FarbePanelINhalt:      Tcolor;
  FarbePanelVerweise:    Tcolor;
  FarbeUnterfenster:     Tcolor;
  FormatVollzitat:       string;
  FakeCaptionX:          integer;
  FakeCaptionY:          integer;
  fsize:                 integer;

  //---GGGG--//
  GoBackFromStandby:string;     //Braucht man, weil das Programm SeiteNeu gestartet wird.
  GliederungArray:array[1..2,1..30] of string;
  GV_BibTexKey:                   string;
  GV_FeldNummer:                  string;
  GV_TextPosition:                integer; //Position des Cursors im Anmerkungstext
  GV_Titel:                       string;
  GV_TmpZitat:                    string;




   //-IIIIII----
  IDeenIDMax                   :integer;
  inifile                      :array[1..200,1..2] of string;
  IsTextChanged                :boolean;
  ichanged,lchanged            :boolean;
  ineedssorting,lneedssorting  :boolean ; //muss die DB sortiert werden?

  //-KKKKKK---
  //KlickZeit:            Integer;
  KopfZeilenFarbe:        Tcolor;
  KoordinateX:            integer;
  Kurzzitat:              string;

  //-LLLLL----
  langesTMPZitat:boolean;
  LetzteSucheHauptfenster:     string;
  LetzteSucheQuerverweise:     string;
  LetzterFokus:                string;
  LetzterEintrag:integer;
  LetzteSpeicherung:integer;
  ListeDateiEndungen:string;
  Literatur:                array of array of string;
 // LiteraturImport:          array of array of string;
  //26 = Datum
  //29 = backup
  Literatur2:array of array of string; // für Literaturimporte aus anderen Formaten
  LiteraturZeile:array[1..Spalte_Ende+1] of string; //Einzelne Zeile zur Formatierung einer Quelle
  LiteraturDatenbank:string;
  LiteraturDatensatzZahl:integer = -1;
  Literatur2DatensatzZahl:integer = -1;
  LiteraturIDMax:integer = -1;
  LiteraturFarbeNormal:TColor;
  LiteraturFarbeAuswahl:TCOlor;


  //-MMMMMMMMMM--
  MyPath:            string;
  MinusBegriff1:     string;  // für Ausschlußbegriffe beim Suchen
  MinusBegriff2:     string;


  //-NNNNNNNNNN--
  NotizfarbeNormal:Tcolor ;
  NotizfarbeAuswahl:Tcolor;
  NotizenDatensatzZahl:integer =-1;

  OS:String;

  Plattenplatz:string;

  qarray:    array[0..1001,1..4] of string;

  //RRRRR
  RegisterSeite:string;
  Richtlinie:array[1..5,1..4,1..12] of string;

  //SSSSSS
  s1,s2,s3,s4,s5:string;
  SessionTemporaryID:string;
    Skalierung:              real;  //Skalierung unter Windows
  SpeicherVolumen:           integer;
  stylechanged:              boolean;
  StopList:                  TTabStopList; //Tabulatoren für den Anmerkungstext
  swListe:                   tstringlist;

  //---- TTTTTTTTTTTTTTTTTTT -----

  TitelVorschlag:                      string;
  Titel_alt:                           string;
  Titel_neu:                           string;
  TMPHinweis:                          string;
  TMPVerzeichnisIdeen:                 string;
  TMPVerzeichnisLiteratur:             string;

  Trefferlistenlaenge:integer;

  TrefferArray:array[0..1001,1..10]  of string;
                                 {1:Markierung
                                  2:Pin
                                  3:Typ
                                  4:ID
                                  5:Zeile im Array
                                  6:Titel
                                  7:Textanfang
                                  8:Zeit
                                  9:vergangene Tage
                                  10:Volltext
                                  }


  // UUUUUUUUUUUUUUUUUU
  UndoText:                       string;
  UngespeicherteZeichen:          integer;
  Unterfensterposition:           string;
  Unterfensterfarbe:              tcolor;
  UnterUnterFensterfarbe:         tcolor;
  UnterUnterUnterFensterfarbe:    tcolor;





  //-VVVVVVV--


  var_OptionDarkMode:             boolean;
  var_OptionMenue:                boolean;
  var_OptionSchlagwortliste:      boolean;

  VerweisAnfangTyp:        string;
  VerweisAnfangTitel:      string;
  VerweisAnfangID:         string;
  VerweisAnfangZeilenNr:   integer;
  VerweisArray:            array[1..100,1..2] of string; //Querverweise
  vorJahren, vorMonaten, vorTagen, vorStunden, vorMinuten:integer;
  Win31Dialog:boolean;

  //-ZZZZZZZ --

  //Z39
  zau,zti,zyr,zloc,zpub,zut,zjour, zpage, zisbn, zaufl:   string;
  ZeilenAbstandListe:                                     integer;
  ZeilenAbstandListbox:                                   integer;
  ZeichenSatz:                                            string;


implementation

{$R *.lfm}

type
{ TDownloadStream }

  TOnWriteStream = procedure(Sender: TObject; APos: Int64) of object;
  TDownloadStream = class(TStream)
private
  FOnWriteStream: TOnWriteStream;
  FStream: TStream;
public


  constructor Create(AStream: TStream);
  destructor Destroy; override;
  function Read(var Buffer; Count: LongInt): LongInt; override;
  function Write(const Buffer; Count: LongInt): LongInt; override;
  function Seek(Offset: LongInt; Origin: Word): LongInt; override;
  procedure DoProgress;






published
  property OnWriteStream: TOnWriteStream read FOnWriteStream write FOnWriteStream;
end;



{TFenster}
Function FocusTo(what:string):boolean;
var
  compo:         tcomponent;
  Standardregel: boolean;

begin
     what:=ansilowercase(what); //Groß/Kleinschreibung beim Aufruf ignorieren
     machpause();               //sicherheitshalber.
     Standardregel:=true;
     with fenster do
     begin
          if what='sucheingabe' then
              if PanelNeueQuelle.height > 20 then standardregel:=false;
                 { Das Unterfenster für die Eingabe eines neuen Quellentitels
                   ist sichtbar. dann soll EingabeTitelNeueNotiz den Fokus
                   behalten }

          if StandardRegel then
          begin
                compo:=findcomponent(what);
                if (compo is TEdit) then
                    if TEdit(compo).canfocus then TEdit(compo).setfocus;
                if (compo is TRichMemo) then
                    if TRichMemo(compo).canfocus then TRichMemo(compo).setfocus;
                if (compo is TTreeView) then
                    if TTreeView(compo).canfocus then TTreeView(compo).setfocus;
                if (compo is TStringGrid) then
                    if TStringGrid(compo).canfocus then TStringGrid(compo).setfocus;
                if (compo is TPanel) then
                    if TPanel(compo).canfocus then TPanel(compo).setfocus;

          end;
     end;

end;
function ScrollbarAnmerkungenPositionieren(punkt:integer):boolean;
var
   kipppunkt:         integer;
begin
     { befindet sich der Cursor eher am Anfang der Anmerkung oder weiter unten?
       Den Schieber des Scrollbars anpassen}
     with fenster do
     begin
          kipppunkt:=Feldinhalt.Lines.count - 1;
          if punkt < Kipppunkt  then ScrollbarAnmerkungenSchieber.Align:=altop
                                else ScrollbarAnmerkungenSchieber.Align:=albottom;
     end;
end;


function ListeSchieberHeight():boolean  ;
var
     anzeigbareTreffer:  integer;
     h:                  integer;
begin
     with fenster do
     begin
          if liste.rowcount < 120 then
          begin
              h:= ListeScrollbar.height  ;
              AnzeigbareTreffer:=trunc(Liste.height/Liste.DefaultRowheight) ;
              h:=trunc(anzeigbareTreffer/Liste.Rowcount*h);
              if h > (ListeScrollbar.height -60) then  h:= ListeScrollbar.height -60;
          end else begin  //sehr viele Treffer. Kleiner Schieber.
               h:=40;
          end;
          ScrollbarListeSchieber.Height:=h;
          ScrollbarListeschieber.left:=5;
          ScrollbarListeSchieber.width:=ScrollbarlisteHintergrund.width - 10;
     end;

end;

function setfilterheight():boolean; // Die Höhe des Schlagwortfilters nach
var                                 // Länge der Schlagwortliste und Breite
  h:       integer;                 // des Fensters einstellen
begin
     with fenster do
     begin
          h:=trunc(150*skalierung*length(memofilter.lines.text)/memofilter.width) ;
     h:=h+70;
     PanelKombinierterSchlagwoerter.height:=h;
     resizewindow();
     end;
end;

function MachPause():boolean;
begin

Application.processmessages;     //test für linux buggy
     result:=true;
end;
function Busy():boolean;
var
  c:    string;
  i:    integer;

begin
     c:=fenster.caption;
     fenster.caption:='Das System ist gerade etwas langsam...';
     application.processmessages;
     for i:=1 to 4 do
     begin
          machpause();
          sleep(250);
     end;
     application.processmessages;
     fenster.caption:=c;
     result:=true;
end;
function deletefileplus(Datei:string):boolean;
{ manchmal funktioniert das Löschen der Datei nicht auf Anhieb. Diese Funktion
  hakt zweimal nach. Einmal mit Pause, einmal mit showmessage. }
begin
  try
     DeleteFile(Datei);
  except
        try
           busy();
           DeleteFile(Datei);
        except
              showmessage( 'Das Löschen der Datei ' + Datei  +
                           ' ist langsam...');
              Deletefile(Datei);
        end;
  end;
  machpause();
end;

function str2int(ein:string):integer  ; //filtert nichtnumerische Zeichen aus
var
   c,s:string;
   i:integer;
begin
     try
       result:=strtoint(ein);
     except
        if ein='' then ein:='0';
        s:='';
        for i:=1 to length(ein) do
        begin
           c:=copy(ein,i,1);
           if pos(c,'0123456789') > 0 then s:=s+c;
        end;
        if s='' then s:='0';
        result:=StrToInt(s);
    end;
end;
function HolOS():string;
begin
  result:='win';
  {$IFDEF LINUX} result:='linux'; {$ENDIF}
end;
function slash(os:string):string ;
begin
    result:='\';
    if os<>'win' then result:='/';
end;

function MeinVerzeichnis(os:string):string;
begin
    machpause();
    result:=extractfilepath(application.exename);
end;

function NoBox(const aMsg: string): Boolean; //Abfrage JA / NEIN mit Standard auf NEIN
var
  Flags  : Integer;
begin
      flags := QuestionDlg('Achtung', amsg + #13 + #13, mtConfirmation, [mrNo, 'Ja', mrYes, 'Nein'], 0);
      If flags=mrYes then result:=false else result:=true;
end;
function YesBox(const aMsg: string): Boolean;   //Abfrage JA / NEIN mit Standard auf JA
var
  Flags  : Integer;
begin
      flags := QuestionDlg('Achtung', amsg + #13 + #13, mtConfirmation, [mrYes, 'Ja', mrNo, 'Nein'], 0) ;
      If flags=mrYes then result:=true else result:=false;
end;




function aufraeumen():boolean;
begin

end;

function ZeigeTitelDaten():boolean;
begin
      Fenster.RegisterSuche.activepage:=Fenster.Titeldaten;
      Fenster.Titeldatenmatrix.ColWidths[0]:=trunc(110*Skalierung);
      Fenster.TitelDatenMatrix.row:=0;
      Fenster.Titeldatenmatrix.Col:=1;
      FocusTo('titeldatenmatrix');


end;





function ZeichensatzEinstellen():boolean;
begin
  with fenster do
  begin
       FeldInhalt.Font.name:=                       Zeichensatz;
       HintergrundVolltext.Font.Name:=              Zeichensatz;
       Labeltitel.font.name:=                       Zeichensatz;
       PanelInhalt.Font.Name:=                      Zeichensatz;
  end;
end;

function sortqlist(treffer:integer;kriterium:string):boolean ;
var
  ar:array[1..4] of string;
  i,j,k:     integer ;
  tauschen:  boolean;
begin
       fenster.qliste.items.clear;
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
       for i:=1 to treffer do   fenster.qliste.items.add(qarray[i,1]);
       machpause();
       i:=0;                          //leere Zeilen am Anfang der Listbox
       fenster.qliste.topindex:=0;   //wegscrollen. Ist einfacher als die
       for i:=1 to treffer do         //Zeilen zu löschen, weil es unter
       begin                          //schiedlich viele Leerzeilen geben
           if qarray[i,1]=''          //kann
           then  fenster.qliste.topindex:=fenster.qliste.topindex+1
           else break;
       end;

end;


function insertkeyword(sw:string):boolean;
var
         cp:    integer;
begin
     cp:=fenster.feldinhalt.selstart;
     fenster.feldinhalt.sellength:=0;
     if pos(ansilowercase(sw),ansilowercase(fenster.feldinhalt.text)) = 0 then
     begin
          paste(sw + ' ');

         if AngezeigterTyp='N' then
         begin
               daten[AktuelleNotizenArrayZeile,Spalte_Anmerkung]:=fenster.FeldInhalt.Lines.text;
               Daten[AktuelleNotizenArrayZeile,Spalte_Bearbeitungsdatum]:=formatdatetime('yyyymmddhhnn', now);
               ineedssorting:=true;
               ichanged:=true;
         end;

         if AngezeigterTyp='L' then
         begin
               Literatur[AktuelleLiteraturArrayZeile,Spalte_Bearbeitungsdatum]:=formatdatetime('yyyymmddhhnn', now);
               Literatur[AktuelleLiteraturArrayZeile,Spalte_Anmerkung]:=
                         fenster.FeldInhalt.Lines.Text;
               lchanged:=true;
               lneedssorting:=true;
         end;
           IsTextChanged:=true;
           machpause();
           Fenster.feldinhalt.selstart:= cp + length(sw) +1;

       end else begin
         showmsg('Das Schlagwort "' + sw + '" befindet sich schon im Anmerkungstext');
     end;


end;


function LeereListenZeilenAmEndeLoeschen():boolean;
begin
     with fenster do
     begin
          //die letzten Einträge löschen, falls sie leer sind  03/2024
          while      (Liste.Cells[ListeSpalteTitel,liste.rowcount-1]='')
                and  (Liste.Rowcount > 1)
          do
                Liste.Rowcount:=liste.rowcount-1;
     end;
end;


function resizewindow():boolean;
  { wird von formresize aufgerufen, sowie immer, wenn sich die Unteraufteilung
    ändert}
var
   anzeigbareTreffer:           integer;
   anteil:                      integer;
   h:                           integer;
   Spaltenzahl:                 integer;
   ti:                          string;
   verfuegbareHoehe:            integer;



begin
     with fenster do
     begin
            //  if istextchanged then SaveChangesToArray();

              //-----------------------
              // --- REGISTERKARTEN ---
              //-----------------------
              Registerkarten.top:=PanelHintergrundOben.height-10;
              Registerkarten.left:=-12;
              Registerkarten.width:=hintergrund.width+20;
              Registerkarten.height:= hintergrund.height
                                     - PanelHintergrundOben.height
                                     - PanelHintergrundUnten.height
                                     + 25;
              //----------------------------------------------------------------

              // ----- horizontale Fensteraufteilung ---
              // ----------------------------------------
              anteil:=3;
              if RegisterSuche.activepage = Titeldaten then anteil:=2;
              if RegisterSuche.activepage = Einstellungen then anteil:=2;
              if (RegisterSuche.activepage = SeiteGliederung)
              and  (PanelNotizGliedern.width > 10) then anteil:=2;


              panelIdeenLinks.width:=trunc(fenster.width/anteil) ;


              PanelFeldinhaltIcons.left:=PanelIdeenLinks.width + 50;

             with registersuche do
             begin
                  showtabs:=false;
                  align:=alnone;
                  top:=-10;
                  left:=-5;
                  height:=panelideenlinks.height+15;
                  width:=panelideenlinks.width+20;
             end;
             PanelSucheingabe.width:=registersuche.width - 50;

             //Höhe der Trefferliste -------------------------------------------
             //-----------------------------------------------------------------
              h:=trunc(Liste.Font.size *2)  ;
              if h< 25 then h:=25;

              h:=trunc(h*skalierung);
              liste.defaultrowheight:=h;
              //Die Höhe sollte auflösungsunabhängig funktionieren
              VerfuegbareHoehe:= HintergrundVolltext.height
                               - PanelMenuVolltextsuche.height
                               - PanelKombinierterSchlagwoerter.height
                               - PanelNeueQuelle.height
                               - LabelTrefferzahl.height
                               - Liste.Borderspacing.top
                               - 20;
              AnzeigbareTreffer:=trunc(verfuegbarehoehe/h) ;
              { evtl. ist das zu optimistisch und der letzte Eintrag wird
                abgeschnitten. Dann AnzeigbareTreffer um 1 runtersetzen }
              Liste.height:=AnzeigbareTreffer *h ;

              //Die Scrollbar positionieren
              ListeScrollbar.top:=liste.top +8;
              ListeScrollbar.height:=liste.height -16;
              ListeSchieberHeight();

              //----------------------------------------------------------------



              // Titel der Notiz
              if angezeigtertyp='N' then
              begin
                    ti := daten[AktuelleNotizenArrayZeile, Spalte_Titel];
              end else begin //Titel der Quelle
                  ti:=    Literatur[AktuelleLiteraturArrayZeile,Spalte_Erstautor]
                        + ' ('
                        + Literatur[AktuelleLiteraturArrayZeile,Spalte_Jahr]
                        + ') '
                        + Literatur[AktuelleLiteraturArrayZeile,Spalte_Titel]
                        ;

              end;
              while length(ti) > trunc(Paneltitel.width/(Skalierung*(Labeltitel.font.size-3)))
                          do ti:= deletelastword(ti)+'...';
              LabelTitel.caption:=ti;



             //---Spaltenbreite in der Liste
             //--------------------------------


            Liste.Colwidths[ListeSpalteTitel]:=
            liste.Width - (Liste.Colwidths[ListeSpalteMarkierung] +
            Liste.Colwidths[ListeSpalteNummer] +
            Liste.Colwidths[ListeSpalteIcon]
            + 0  );
      TrefferlistenLaenge:=20;
      PanelVollzitat2.top:=  PanelErstelltam.top + Panelerstelltam.height +5 ;

      //--- Infos über Erstellung und Bearbeitung unter dem Notiztitel ----
      //-------------------------------------------------------------------
      If feldinhalt.width < 500 then
      begin
          LabelErstelltam.visible:=false;
      end else begin
          LabelErstelltam.visible:=true;    //Datum stehen (02/2024)
      end;

      //--- Die Spalten in der Fusszeile formatieren ---
      if (baumverweise2.Items.count > 1)
      and (fenster.Windowstate <> wsminimized)
      and (fenster.RegisterKarten.activepage=ideenseite)
      then timer.enabled:=true;
          { Zahl und Anordnung der Spalten der Verweise muss man nur ändern, wenn
            es mehr als eine Spalte gibt und das Fenster sichbar ist (02/2024) }

     end;



end;

function paste(mitte:string):boolean ;
begin
       {
       clipboard.Clear;
       machpause();
       clipboard.AsText:=mitte;

       if os='win' then fenster.Feldinhalt.pastefromclipboard;
       if os='linux' then fenster.feldinhalt.SelText:=mitte;
           { Linux ist umständlicher, aber hier gibt es einen Bug, weil
             pastefromclipboard im richmemo nicht funktioniert. Tastatur-
             kombination schon. Der Befehl selbst nicht.  10/2025}

       }
       FocusTo('Feldinhalt');
       fenster.feldinhalt.SelText:=mitte;
       machpause();


       IsTextChanged:=true; //sonst wird evtl. nicht abgespeichert 02/2024
     //  savechangestoarray();
       formatmd(0,10000,false);
end;


function ShowMsg(s:string):boolean;
begin
     showmessage(s);
     result:=true;
end;
function Nachricht(s:string;t:integer):boolean;
var
   oldcaption:    string;
begin
     oldcaption:= Fenster.caption ;
     Fenster.Caption:=s;
     application.processmessages;
     sleep(1000*t);
     Fenster.Caption:=OldCaption;
end;




// ---------------Funktionen, die sortieren ------------//

function sortDB(dbname:string):boolean  ;
var
   i:                integer;
   j:                integer;
   k:                integer;
   KopfZeile:        string;
   zwischenspeicher: string;
begin
     //LITERATUR DB SORTIEREN
     KopfZeile:=Fenster.caption;
     Fenster.Caption:='sortiere Datenbank...';

     if dbname='literatur' then
     begin
       lchanged:=true;
       for i:= 1 to arraysize_literatur-1 do
       begin
          if Literatur[i,Spalte_ID] <> '' then //leere Spalten überspringen
          begin
              for j:=i+1 to arraysize_literatur do
              begin
                // machpause(); Das war an dieser Stelle tödlich

                 if (Literatur[i,Spalte_Bearbeitungsdatum]
                  > Literatur[j,Spalte_Bearbeitungsdatum] ) then
                 begin
                    if (Literatur[j,spalte_id] <> '') then //Leerzeile?
                    begin
                          for k:=1 to Spalte_Ende do
                          begin
                               zwischenspeicher:=Literatur[i,k];
                               Literatur[i,k]:=Literatur[j,k];
                               Literatur[j,k]:=ZwischenSpeicher;
                          end;
                    end;
                 end;
              end;
          end;
       end;
     end;
     //LITERATUR DB SORTIEREN
     if dbname='notizen' then
     begin
       //showmessage('Notiz DB sortieren');
       for i:= 1 to arraysize_daten-1 do
       begin
          if daten[i,Spalte_ID] <> '' then //leere Spalten überspringen
          begin
              for j:=i+1 to arraysize_daten do
              begin
                 // machpause();  tödlich an dieser Stelle
                 if (daten[i,Spalte_Bearbeitungsdatum]
                  > daten[j,Spalte_Bearbeitungsdatum] ) then
                 begin
                    if (daten[j,spalte_id] <> '') then //Leerzeile?
                    begin
                          for k:=1 to Spalte_Position do
                          begin
                               zwischenspeicher:=daten[i,k];
                               daten[i,k]:=daten[j,k];
                               daten[j,k]:=ZwischenSpeicher;
                          end;
                    end;
                 end;
              end;
          end;
       end;
     end;
     Fenster.Caption:=Kopfzeile;
end;




//-Funktionen für das Titeldatenfeld-------------------------------------
//-----------------------------------------------------------------------
function FindeVerlagsOrt(verlag:string):boolean;
var
  i:     integer;
begin
          for i:=GetTopEmptyRow('Literatur')  downto 1 do
          begin
               if (pos(verlag,Literatur[i,Spalte_Verlag])=1)  then
               begin
                    Fenster.Titeldatenmatrix.cells[1,12]:= Literatur[i,Spalte_Ort] ;
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
        {t ist das eingegebene Suchfragment}
        tl:=' ';
        t:=trim(t);   //man weiß ja nie...
        maxitems:=7; //Zu viel Scrollen. Wird nicht mehr angezeigt.
        with fenster.vorschlagsliste do
        begin
             Sorted:=false;
             items.clear;
        end;
        //=== AUTORFELD ===
        //=================
        if (feld='Autoren') then
        begin
              for i:=arraysize_literatur  downto 1 do
              begin
                   a:=Literatur[i,Spalte_Autor];
                   if (pos(t,a)>0) then     // Nachnamensanfang gefunden
                   begin
                      a:=copy(a,pos(t,a),1000); //auch Zweitautoren
                      while pos(';',a)> 0 do a:=copy(a,1,length(a)-1);
                      a:=trim(A);
                      { Name ist ein ganzer Name und noch nicht in der Liste }
                      if (pos(a,tl)=0)  then
                      begin
                           tl:= tl+ a + ' ';
                           Fenster.Vorschlagsliste.items.add(a);
                           if  Fenster.Vorschlagsliste.items.count > maxitems then break;
                      end;
                   end;
              end;
              if Fenster.Vorschlagsliste.items.count > 0 then
              begin
                   Fenster.Vorschlagsliste.Top:=
                     Fenster.Dateneingabe.top+Fenster.dateneingabe.height ;
                   Fenster.Vorschlagsliste.visible:=true;

              end else begin
                   Fenster.Vorschlagsliste.visible:=false;
              end;
        end;
        //====ZEITSCHRIFTEN=====
        //======================
        if (feld='Zeitschriften') then
        begin
            for i:=GetTopEmptyRow('Literatur')  downto 1 do
            begin
                 if (pos(ansilowercase(t),ansilowercase(Literatur[i,Spalte_Zeitschrift]))=1)  then
                 begin
                    a:=trim(Literatur[i,Spalte_Zeitschrift]);

                    if (pos(ansilowercase(a),tl)=0)   then //Der Name ist ein Treffer und SeiteNeu
                    begin
                         tl:= tl+ ansilowercase(a) + ' ';
                         Fenster.Vorschlagsliste.items.add(a);
                         if  Fenster.Vorschlagsliste.items.count > maxitems then break;
                    end;
                 end;
            end;
           if Fenster.Vorschlagsliste.items.count > 0 then
           begin
                Fenster.Vorschlagsliste.Top:= 320;;
                Fenster.Vorschlagsliste.visible:=true;

           end else begin
                Fenster.Vorschlagsliste.visible:=false;
           end;
        end;
        //===VERLAG===
        //============
        if (feld='Verlage') then
        begin
            for i:=GetTopEmptyRow('Literatur')  downto 1 do
            begin

                 if (pos(t,Literatur[i,Spalte_Verlag])>0)  then
                 begin
                    a:=trim(Literatur[i,Spalte_Verlag]);
                    if (pos(a,tl)=0)  then //Der Name ist ein Treffer und SeiteNeu
                    begin
                         tl:= tl+ a + ' ';
                         Fenster.Vorschlagsliste.items.add(a);
                         if  Fenster.Vorschlagsliste.items.count > maxitems then break;

                    end;
                 end;
            end;

            if Fenster.Vorschlagsliste.items.count > 0 then
            begin
                 Fenster.Vorschlagsliste.Top:= 380;;
                 Fenster.Vorschlagsliste.visible:=true;

            end else begin
                 Fenster.Vorschlagsliste.visible:=false;
            end;
        end;


        Fenster.Vorschlagsliste.scrollwidth:=100;
        result:=true;
end;









function getFirstWord(ein:string):String;
begin
    ein:=trim(ein);
    if pos(' ',ein) > 0 then  ein:=copy(ein,1,pos(' ',ein)-1);
    while (pos(#13, ein) > 0) or (pos(#10, ein) > 0) do  ein := copy(ein, 1, length(ein) - 1);
    result:=ein;
end;
function trim2(ein:string) : string;
begin
    result:=stringreplace(ein,#9,' ',[rfreplaceall]) ; //10.2020: Tab entfernen
    result:=trim(result);
end;

function extracturl(zeile: string): string;
var
  ende: string;
begin
  zeile := copy(zeile, pos('http', lowercase(zeile)), 20000); //Anfang weg  bis hin zur http
  Result := zeile;
  if pos(' ', Result) > 0 then
    Result := copy(Result, 1, pos(' ', Result));
  if pos(#13, Result) > 0 then
    Result := copy(Result, 1, pos(#13, Result)-1);
  if pos(#10, Result) > 0 then
    Result := copy(Result, 1, pos(#10, Result)-1);
  ende := copy(Result, length(Result)-1, 1);
  while (ende = '.') or (ende = ')') or  (ende = ' ') do
  begin
    Result := copy(Result, 1, length(Result) - 1);
    ende := copy(Result, length(Result), 1);
  end;
  if pos('://' ,result) = 0 then result:='';
  Result := trim(Result);
end;


function getLastWord(ein:string):String;
begin
    ein:=trim(ein);
    ein:= StringReplace(ein,#13, ' ', [rfReplaceAll]);
    ein:= StringReplace(ein,#10, ' ', [rfReplaceAll]);
    ein:= StringReplace(ein,'.', ' ', [rfReplaceAll]);
    while pos(' ',ein) > 0 do ein:=copy(ein,pos(' ',ein)+1,10000);
    result:=ein;
end;
function deleteFirstWord(ein:string):String;
begin
    ein:=trim(ein);
    if pos(' ',ein) > 0 then ein:=copy(ein,pos(' ',ein),100000) else ein:='';
    ein:=trim(ein);
    result:=ein;
end;
function deleteLastWord(ein:string):String;
var
   lastchar:   string;
begin
    //evtl. vorhandene Zeilenschaltung als Leerzeichen interpretieren
    ein:= StringReplace(ein,#13, ' ', [rfReplaceAll]);
    ein:= StringReplace(ein,#10, ' ', [rfReplaceAll]);
    ein:= StringReplace(ein,'.', ' ', [rfReplaceAll]);
    ein:=trim(ein);
    if pos(' ',ein)=0 then //das ist schon das letzte Wort
    begin
         result:='';
    end else begin
        while length(ein) > 0 do
        begin
             lastchar:= copy(ein,length(ein),1);
             ein:=copy(ein,1,length(ein)-1);
             if lastchar=' ' then break;
             if lastchar='-' then break;
             if lastchar=':' then break;
        end;

            { das Ende des Wortes ist nicht unbedingt ein Leerzeichen. Es kann
              auch ein Spiegelstrich, Unterstrich, ... sein 03/2024}
    end;
    ein:=trim(ein);
    result:=ein;
end;
function deleteLastChar(ein:string):String;
begin
     result:=copy(ein,1,length(ein)-1);
end;
function Zahlenausfiltern(ein:string):string ;
var
        i:integer;
        zeichen:string;
begin
    result:='';
    if length(ein) > 0 then
    begin
        for i:=1 to length(ein) do
        begin
                zeichen:=copy(ein,i,1);
                if pos(ansilowercase(zeichen),'1234567890') > 0 then
                result:=result + zeichen;
        end;
    end else begin
      result:='0';
    end;
end;


function ErsteZeileFiltern(ein:string):string ;
begin
    ein:=stringreplace(ein,'# ','',[rfreplaceall]) ;
    ein:=stringreplace(ein,'- ',' ',[rfreplaceall]) ;
    ein:=stringreplace(ein,'  ',' ',[rfreplaceall]) ;
    ein:=stringreplace(ein,#13,'',[rfreplaceall]) ;
    ein:=stringreplace(ein,#10,' ',[rfreplaceall]) ; //Leerzeichen
    result:=ein;


end;
function SonderzeichenRaus(ein:string):string ;
begin
    result:='';
    ein:=stringreplace(ein,'-',' ',[rfreplaceall]) ;
    ein:=stringreplace(ein,#10,' ',[rfreplaceall]) ;
    ein:=stringreplace(ein,#12,' ',[rfreplaceall]) ;
    ein:=stringreplace(ein,'¤','',[rfreplaceall]) ;
    result:=ein;
end;

function UmlautZeichenWeg(zeile:string):string; //die Umlautzeichen werden weggenommen
begin
     zeile:=stringreplace(zeile,'Ä','Ae',[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'Ö','Oe',[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'Ü','Ue',[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'ä','ae',[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'ö','oe',[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'ü','ue',[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'ß','ss',[rfreplaceall]) ;
     result:=zeile;
end;
function UmlautInListe(zeile:string):string;  //zeigt die Umlaute in einer Checklist korrekt an
                                              //ist nicht identisch mit UmlautSMLtoRTF, weil in
                                              //der Liste keine RTF-Steuercodes verwendet werden
begin
    zeile:=stringreplace(zeile,'Ã¤','ä',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,'Ã¶','ö',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,'ÃŸ','ß',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,'Ã¼','ü',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,'Ã„','Ä',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,'Ãœ','Ü',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,'Ã–','Ö',[rfreplaceall]) ;
    result:=zeile;
end;

function umlautRTFtoXML(zeile:string):string;
begin
    zeile:=stringreplace(zeile,RTFKleinAE,'Ã¤',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,RTFKleinOE,'Ã¶',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,RTFEsszett,'ÃŸ',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,RTFKleinUe,'Ã¼',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,RTFGrossAE,'Ã„',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,RTFGrossUE,'Ãœ',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,RTFGrossOE,'Ã–',[rfreplaceall]) ;

    zeile:=stringreplace(zeile,'ä','Ã¤',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,'ö','Ã¶',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,'ß','ÃŸ',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,'ü','Ã¼',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,'Ä','Ã„',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,'Ü','Ãœ',[rfreplaceall]) ;
    zeile:=stringreplace(zeile,'Ö','Ã–',[rfreplaceall]) ;

    result:=zeile;
end;
function umlautXMLtoRTF(zeile:string):string;
begin
     zeile:=stringreplace(zeile,'Ã¤',RTFKleinAE,[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'Ã¶',RTFKleinOE,[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'ÃŸ',RTFEsszett,[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'Ã¼',RTFKleinUe,[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'Ã„',RTFGrossAE,[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'Ã–',RTFGrossOE,[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'Ãœ',RTFGrossUE,[rfreplaceall]) ;

     zeile:=stringreplace(zeile,'ä',RTFKleinAE,[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'ö',RTFKleinOE,[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'ß',RTFEsszett,[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'ü',RTFKleinUe,[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'Ä',RTFGrossAE,[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'Ö',RTFGrossOE,[rfreplaceall]) ;
     zeile:=stringreplace(zeile,'Ü',RTFGrossUE,[rfreplaceall]) ;

     result:=zeile;
end;

function stripfilename(ein:string):string  ;
var
   c:     string;
   i:     integer;
   out:   string;
begin
    for i:=1 to length(ein) do
    begin
         c:=copy(ein,i,1);
         if pos(ansilowercase(c),'abcdefghijklmnopqrstuvwxyz ') > 0
         then out:=out+c;
    end;
    result:=out;
end;

function GetMemoSelstart(Memo: TRichMemo): integer;
//https://www.lazarusforum.de/viewtopic.php?t=5631
//Variante: Den selstart
var
  i:   integer;
  l:   integer;
  txt: WideString;
begin
  txt:=UTF8Decode(Memo.Text);
  i := Memo.SelStart -1;
  l:=0;
  while l < (100) do
  begin
       if (copy(txt,i+l,1) = ' ') or  (copy(txt,i+l,1) = #10) then
       begin
            break;
       end;
       l:=l+1;
  end;
  Result:=i+l+1;
end;

function GetSelWordMemo(Memo: TRichMemo): string;
//https://www.lazarusforum.de/viewtopic.php?t=5631
//Klick auf ein Memo liefert bei Umlauten nicht den korrekten selstart
//hier: In welches Wort wird geklickt?
var
  i: integer;
  txt, s, res:WideString;
begin
  txt:=UTF8Decode(Memo.Text);
  i := Memo.SelStart;
  s := '';
  Res := '';
  repeat
    Res := s + Res;
    s := Copy(txt, i, 1);
    Dec(i);
  until (s <= ' ') or (i < 0);
  i := Memo.SelStart + 1;
  s := '';
  repeat
    Res := Res + s;
    s := Copy(txt, i, 1);
    Inc(i);
  until (s <= ' ') or (s = '');
  Result:=UTF8Encode(Res);
end;





// --------------- Ende der Funktionen zum Übersetzen und Filtern von Zeichen ----- //
//
//
//
// ----------- Funktionen, die Nutzereinstellungen verwalten ------------//
{
function LoadBxIni2():boolean;
function loadbxini():boolean;
function SaveBxIni2():boolean;
function SaveBxIni():boolean;
function GetIni(variable,standard:string):string;
function GetBooleIni(variable:string;standard:boolean):boolean;
function GetIntegerIni(variable:string;standard:integer):integer;
function SetIni(variable,wert:string):boolean;
function SetBooleIni(variable:string;wert:boolean):boolean;
function SetIntegerIni(variable:string;wert:integer):boolean;
function SetLock(wert:string):boolean;
function Schreibrecht():string;
}
function TryLoadBxIni():boolean;
  { die Funktion wird mit try except von LoadBxIni aufgerufen}
var
  i:integer;
  liste:TStringlist;
  dateiname:string;
  variable,Wert,zeile:string;
begin
  //----bx.ini-----
  bxinisaved:=false;
  for i:=1 to 500 do bxiniarray[i,1]:='';
  dateiname:=DBDirectory  +  'bx_' + plattenplatz + '.ini';
  Liste:=TStringlist.Create;
  machpause();
  if fileexists(Dateiname) then
  begin
     Liste.Loadfromfile(Dateiname);
     machpause();
     for i:=0 to liste.count -1 do
     begin
        zeile:=liste[i];
         if pos('="',zeile) > 0 then
         begin
                 variable:=copy(zeile,1,pos('="',zeile)-1);
                 wert:=copy(zeile,pos('="',zeile)+2,100);
                 wert:=copy(wert,1,length(wert)-1);
                 bxiniarray[i,1]:=variable ;
                 bxiniarray[i,2]:=wert;
         end;
     end;
  end;
  liste.free;
  result:=true;
end;

function loadbxini():boolean;
begin
     try
       tryloadbxini() ;
     except
        busy() ;
        tryloadbxini() ;
     end;
     result:=true;
end;
function trySaveBxIni():boolean;
var
  i:integer;
  liste:TStringlist;
  dateiname:string;
  { die Funktion wird mit try except von SaveBxIni aufgerufen}
begin
  dateiname:=DBDirectory  +  'bx_' + plattenplatz + '.ini';
  Liste:=TStringlist.Create;
  Liste.Add('[Files]');
  for i:=1 to 500 do
       if bxiniarray[i,1]<>'' then Liste.Add(bxiniarray[i,1] + '="' + bxiniarray[i,2] + '"');
  Liste.SavetoFile(Dateiname);
  bxinisaved:=true;
  Liste.Free;
  result:=true;
end;
function SaveBxIni():boolean;
begin
         try
            trysavebxini() ;
         except
               busy() ;
               trysavebxini() ;
         end;
         result:=true;
end;
function GetIni(variable,standard:string):string;
var
  i:integer;
begin
    result:=standard;
    if pos('=',variable) > 0 then variable:=copy(variable,1,length(variable)-1);
    for i:=1 to 500 do
    begin
        if bxiniarray[i,1]=variable then
        begin
             result:=bxiniarray[i,2];
             break;
        end;
    end;
    result:=stringreplace(result,'"','',[rfreplaceall]) ;
end;
function GetBooleIni(variable:string;standard:boolean):boolean;
var
  z:string;
begin
    if standard then z:='true' else z:='false';
    z:=getini(variable,z);
    if z='true' then result:=true else result:=false;
end;
function GetIntegerIni(variable:string;standard:integer):integer;
var
  z:string;
begin
    z:=inttostr(standard);
    z:=getini(variable,z);
 //   showmessage(z);
    result:=str2int(z);
end;
function SetIni(variable,wert:string):boolean;
var
  i:integer;
begin
    if pos('=',variable) > 0 then variable:=copy(variable,1,length(variable)-1);
    for i:=1 to 500 do
    begin
         if bxiniarray[i,1]=variable then
         begin
              bxiniarray[i,1]:=''; //alten Wert löschen
              break;
         end;
    end;
    for i:=1 to 500 do if bxiniarray[i,1]='' then
    begin
        bxiniarray[i,1]:=variable;
        bxiniarray[i,2]:=wert;
        break;
    end;
    result:=true;
end;

function SetBooleIni(variable:string;wert:boolean):boolean;
begin
    if wert then SetIni(variable,'true') else SetIni(variable,'false');
    result:=wert;
end;
function SetIntegerIni(variable:string;wert:integer):integer;
begin
    SetIni(variable,inttostr(wert));
    result:=wert;
end;
function SetLock(wert:string):boolean;
var
  txt:tstringlist ;
  Verzeichnis:string;
  Minuten:integer;
begin
    machpause();
    txt:=TStringList.Create;
    Verzeichnis:=DBDirectory +  'sessionid.lock' ;
    Verzeichnis :=  utf8toansi(Verzeichnis)  ;
    machpause();
    if (wert='0')  then
    begin  //lock - Datei zurücksetzen
         txt.add('0');
    end else begin //einen Wert eintragen
        txt.add('ownerid= ' + wert);
        txt.add('ownername= ' + Rechnername);
        txt.add('previousownderid= ' + SessionTemporaryID);
        minuten:=str2int(formatdatetime('hh',now)) *60 + str2int(formatdatetime('nn',now)) ;
        machpause();
        txt.add('time= ' + inttostr(minuten));
        machpause();
    end;
    try
           txt.savetofile(verzeichnis);
           machpause();
    except
              machpause();
              busy();
              txt.savetofile(verzeichnis);
    end;
    txt.Free;
    machpause();
    result:=true;
end;
function Schreibrecht():boolean;
var
    alterliteratur:   integer;
    alternotiz:       integer;
    darfich:          boolean;
    fi :              textfile;
    jetzt:            integer;
    owner:            string;
    txt:              string;
    Verzeichnis :     string;
begin
     darfich:=false;
     Verzeichnis:=DBDirectory + 'sessionid.lock' ;
     Assignfile(fi,verzeichnis);
     if fileexists(verzeichnis) then
     begin
        reset(fi);
        readln(fi,owner);
     end else begin // die Datei ist gar nicht da
         rewrite(fi);
         owner:=plattenplatz;
         //das aufrufende System. Identifiziert an der Festplattengröße
     end;
     closefile(fi);
     // Die Informationen sind eingelesen / erzeugt

     //es gibt momentan keinen Zugriff. 0 ist der Wert dafür
     if owner='0' then owner:=plattenplatz;


     if owner=plattenplatz then darfich:=true;
     //der letzte Zugriff kam vom gleichen Rechner. Ein paralleler Zugriff dürfte
     //das nicht sein, weil uniqueinstance das erkennen würde.

     //prüfen, ob die Datenbank über eine Stunde nicht geändert wurde.
     if darfich=false then
     begin
          jetzt:=str2int(formatdatetime('hhnn',now));
          alternotiz:=str2int(formatdatetime('hhnn',FileDateToDateTime(FileAge(dbdirectory + 'ideen.xml'))));
          alterliteratur:=str2int(formatdatetime('hhnn',FileDateToDateTime(FileAge(dbdirectory + 'literatur.xml'))));
          if (abs(jetzt-alternotiz) > 100) and
             (abs(jetzt-alterliteratur) > 100) then darfich:=true;
     end;

     //letzte Änderung von einem anderen System aus vor weniger als 2 Stunden
     if darfich=false then
     begin
         txt:= 'Ein anderer Rechner hat noch Schreibzugriff auf die Datenbank.' +#10#13 +
                'Wenn Sie "Ja" klicken, übernehmen Sie das Schreibrecht.' + #10#13 +
                'Bei "Nein" wird dieses Programm jetzt beendet' ;
          if NoBox(txt) then darfich:=true else darfich:=false;
     end;


     if darfich=true then
     begin
          rewrite(fi);
          writeln(fi,plattenplatz) ;
          closefile(fi);
     end else begin
         application.terminate;
     end;
     //Die .lock Datei abspeichern, falls Schreibzugriff gewährt, sonst terminate
     result:=darfich;
end;



//------------ Funktionen zum Download für die Update-Funktion ------ //
{
constructor TDownloadStream.Create(AStream: TStream);
function TDownloadStream.Read(var Buffer; Count: LongInt): LongInt;
function TDownloadStream.Write(const Buffer; Count: LongInt): LongInt;
function TDownloadStream.Seek(Offset: LongInt; Origin: Word): LongInt;
procedure TDownloadStream.DoProgress;
procedure tfenster.Download(AFrom, ATo: String);
function tfenster.FormatSize(Size: Int64): String;
procedure TFenster.DoOnWriteStream(Sender: TObject; APosition: Int64);
function restartapp():boolean;
}




constructor TDownloadStream.Create(AStream: TStream);
begin
  inherited Create;
  FStream := AStream;
  FStream.Position := 0;
end;
destructor TDownloadStream.Destroy;
begin
  FStream.Free;
  inherited Destroy;
end;
function TDownloadStream.Read(var Buffer; Count: LongInt): LongInt;
begin
  Result := FStream.Read(Buffer, Count);
end;
function TDownloadStream.Write(const Buffer; Count: LongInt): LongInt;
begin
  Result := FStream.Write(Buffer, Count);
  DoProgress;
end;

function TDownloadStream.Seek(Offset: LongInt; Origin: Word): LongInt;
begin
  Result := FStream.Seek(Offset, Origin);
end;

procedure TDownloadStream.DoProgress;
begin

end;
procedure tfenster.Download(AFrom, ATo: String);  //wird für die Updatefunktion benutzt

var
  DS: TDownloadStream;
begin
  DS := TDownloadStream.Create(TFileStream.Create(ATo, fmCreate));
  try
   // DS.FOnWriteStream := @DoOnWriteStream;
    try
      FHTTPClient.HTTPMethod('GET', AFrom, DS, [200]);
    except
      on E: Exception do
      begin
        showmessage(e.Message)
      end;
    end;
  finally
    DS.Free
  end;
end;
//Ende der Funktionen zum Download für die Update-Funktion




// --------------- Funktionen zur ArrayDimensionierung  ----------//
function GetTopEmptyRow(ofwhat:string):integer;
var
  i:integer;
  erg:integer;
begin
     ofwhat:=ansilowercase(ofwhat);
     result:=-1;
     if ofwhat='literatur' then
     begin
          for i:= arraysize_literatur downto 1 do
               if  (Literatur[i,spalte_id]<>'')
               then   break;
          result:=i+1;
     end;
     if ofwhat='literatur2' then
     begin
          for i:=ArraySize_literatur downto 1 do
              if Literatur2[i,1]<>'' then break;
          result:=i+1;
     end;
     if ofwhat='daten' then
     begin
          for i:= ArraySize_daten downto 1 do
               if  str2int(Daten[i,Spalte_ID]) > 111
                 then
          begin
               break;
          end;
          result:=i+1 ;
     end;
end;

function GetNumberOfRecords(ofwhat:string):integer;
var
  i:integer;
begin
     ofwhat:=ansilowercase(ofwhat);
     if ofwhat='literatur' then
     begin
             LiteraturDatensatzzahl:=0;
             for i:=1 to ArraySize_literatur do if Literatur[i,1]<>'' then LiteraturDatensatzzahl:=LiteraturDatensatzzahl+1;
             result:=LiteraturDatensatzzahl;
     end;

     if ofwhat='daten' then
     begin
             NotizenDatensatzZahl:=0;
             for i:=1 to ArraySize_daten do if daten[i,1]<>'' then NotizenDatensatzZahl:=NotizenDatensatzZahl+1;
             result:=NotizenDatensatzZahl;
     end;
end;
function SetNumberOfRecords(ofwhat:string;v:integer):integer;
begin
     ofwhat:=ansilowercase(ofwhat);
     if ofwhat='literatur' then
     begin
          result:=v
     end;
end;
function IncreaseNumberOfRecords(ofwhat:string):integer;
begin
     ofwhat:=ansilowercase(ofwhat);
     if ofwhat='literatur' then
     begin
           if LiteraturDatensatzzahl < 1 then Literaturdatensatzzahl:=GetNumberOfRecords('Literatur');
           LiteraturDatensatzzahl:=LiteraturDatensatzzahl+1;
     end;
     Result:=LiteraturDatensatzzahl;
end;



// ------------- Ende Funktionen zur ArrayDimensionierung  ----------//
//
//
//
// --------------- Funktionen zur Ermittlung der ID von Literatur und Notizen ----------//
{
function GetMaxID(ofwhat:string):integer;   10x
function setMaxID(ofwhat:string; v:integer):boolean;   6x
function IncreaseMaxID(ofwhat:string):boolean; 5x
}

function HolLiteraturIdAusrefLink(st:string):string;
begin
     st:=copy(st,pos('ref://',st),10000);
     st:=stringreplace(st, '_', ' ', [rfreplaceall]);
     st:=stringreplace(st, '-', ' ', [rfreplaceall]);
     result:=getfirstword(st); // note://1234
     result:=copy(result,7,10);    // die ID

end;
function HolNotizIdAusNoteLink(st:string):string;
begin
     st:=copy(st,pos('note://',st),10000);
     st:=stringreplace(st, '_', ' ', [rfreplaceall]);
     result:=getfirstword(st); // note://1234
     result:=copy(result,8,10);    // die ID

end;

function GetMaxID(ofwhat:string):integer;
var
  i:integer;
  max:integer;
  d:integer;
begin
     ofwhat:=ansilowercase(ofwhat);
     result:=0;
     if ofwhat='literatur' then
     begin
          if literaturidmax <1  then
          begin
               max:=0;
               for i:=1 to ArraySize_literatur do
               begin
                   if Literatur[i,1]<>'' then
                   begin
                        d:=str2int(Literatur[i,1]);
                        if d > max then max:= d;
                   end;
               end;
               LiteraturIDmax:=max;
          end;
          result:=LiteraturIDMax;

     end;
     if ofwhat='daten' then result:=IdeenIDMax;
end;
function setMaxID(ofwhat:string; v:integer):boolean;
begin
     ofwhat:=ansilowercase(ofwhat);

     if ofwhat='literatur' then LiteraturIDMax:=v;
     if ofwhat='daten' then IdeenIDMax:=v;
     result:=true;
end;

function IncreaseMaxID(ofwhat:string):boolean;
begin
     ofwhat:=ansilowercase(ofwhat);
     if ofwhat='literatur' then
     begin
          if literaturidmax < 1 then LiteraturIDMax:= GetMaxID('Literatur');
          LiteraturIDMax:=LiteraturIDMax+1;

     end;
     if ofwhat='daten' then IdeenIDMax:=IdeenIDMax+1;
     result:=true;
end;
// --------------- Ende Funktionen zur Ermittlung der ID ----------//
//
//
//
//
// -------------- Funktionen die Merkmale einer Notiz holen ----------//
{

}
//Annahme: Die gesuchten Titel sind eher jüngeren Datums und daher
//eher in den unteren Zeilen des Arrays. Daher wird in den Funktionen
//runtergezählt und nicht raufgezählt. Ist etwas schneller.

function HolTitelderNotizID(id: integer): string;
var
  i: integer;
  IDasText: string;
begin
  IDasText := IntToStr(id);
  Result := '<gelöscht ...>';
  { bei den neueren Datensätzen anfangen. Der Treffer ist eher neuer als alt}
  for i :=  ArraySize_Daten downto 1  do
  begin
    if daten[i, 1] = IdAsText then
    begin
      Result := daten[i, Spalte_Titel];
      break;
    end;
  end;
end;
function HolArrayZeileDesTitels(titel: string): integer;
var
  i: integer;
begin
  Result := 0;
  { bei den neueren Datensätzen anfangen. Der Treffer ist eher neuer als alt}
  for i :=  ArraySize_daten downto 1  do
    if daten[i, Spalte_Titel] = titel then
    begin
      Result := i;
      break;
    end;

end;
function HolArrayZeileDerNotizID(id: string): integer;
var
  i: integer;
begin
  Result := 0;
  { bei den neueren Datensätzen anfangen. Der Treffer ist eher neuer als alt}
  for i :=  ArraySize_daten downto 1  do
    if daten[i, Spalte_ID] = id then
    begin
      Result := i;
      break;
    end;
end;
function HolArrayZeileDerLiteraturID(id: string): integer;
var
  i: integer;
begin
  Result := 0;
  { bei den neueren Datensätzen anfangen. Der Treffer ist eher neuer als alt}
  for i :=  ArraySize_Literatur downto 1  do
    if Literatur[i, Spalte_ID] = id then
    begin
      Result := i;
      break;
    end;
end;
function HolIDdesNotizTitels(t:string):string;
var
  i:integer;
begin
     result:='-1';
     { bei den neueren Datensätzen anfangen. Der Treffer ist eher neuer als alt}
     for i :=  ArraySize_Daten downto 1 do
     begin
          if trim(daten[i, Spalte_Titel]) = t then
          begin
               result := daten[i, 1];
               break;
          end;
     end;

end;

//
// ---------------- Funktionen, die Personennamen formatieren ------//
{
function HolErstautor(Datenzeile:integer):string;       1x
function BestimmePersonenZahl(st:string):integer;       2x
function Nachname(Zeile:string):string;                 25+ x
function Vorname(zeile:string):string;                  18x
function InitialenMitPunktLeerZeichen(zeile:string):string; 9x
function InitialenMitPunkt(zeile:string):string;            11x
function Initialen(zeile:string):string;                    10x
function FormatiereNamen(zeile, fm, namenstrennzeichen, letztnamenstrennzeichen, LNU, etalphrase, alleautoren:string):string;  6x
}
function HolErstautor(Datenzeile:integer):string;
var
   au:string;
   au2:string;
begin
  au:=Literatur[Datenzeile,Spalte_Autor];
  if pos(';',au)> 0 then au2:=copy(au,pos(';',au)+1,1000) else au2:='';
  if pos(',',au) > 0 then au:=copy(au,1,pos(',',au)-1);

  //zweitautor
  if au2<>'' then
  begin

       if pos(';',au2)> 0 then
       begin
           au:=au + ' et al.'; //mehr als zwei Autoren
       end else begin
           if pos(',',au2) > 0 then au2:=copy(au2,1,pos(',',au2)-1);
           au:=au + '/'+ trim(au2);

       end;
  end;
  if au='' then au:='o.V.' ;
  if length(au) > 20 then au:=copy(au,1,18) + '...';
  result:=UmlautZeichenWeg(trim(au));
end;
function BestimmePersonenZahl(st:string):integer;
begin
    result:= 1;
    if pos('...',st) > 0 then
    begin
        result:=1000;
    end else begin
        while pos(';',st) > 0 do
        begin
                result:=result+1;
                st:=copy(st,pos(';',st)+1,2000);
        end;
    end;
end;
function Nachname(Zeile:string):string;
begin
    if pos(' ',Zeile) = 1 then zeile:=copy(zeile,2,1000); //Leerzeichen am Anfang
    if pos(',',Zeile) > 0 then {mindestens ein Name}
    begin
         Result:=copy(Zeile,1,pos(',',Zeile)-1);
    end else begin
         if pos(' ',Zeile) > 0 then  {Mehrere Wörter aber kein Name}
         begin
              Result:=zeile ;
         end else begin   {nur ein Wort}
             Result:= Zeile  ;
         end;
    end;
    if copy(result,length(result),1)=' ' then result:=copy(result,1, length(result)-1 );
    while pos(' ',result)=1 do result:=copy(result,2,1000);
end;
function Vorname(zeile:string):string;
begin
    if pos(';',Zeile) > 0 then{mehrere Namen. Rest abschneiden}
    begin
         zeile:=copy(zeile,1,pos(';',Zeile)-1);
    end ;
    if  pos(',',Zeile) >  0 then
    begin
            Result:=copy(zeile,pos(',',Zeile)+1,1000);
            if pos(' ',result)=1 then result:=copy(result,2,1000);
    end else begin
        result :='';
    end;
end;
function InitialenMitPunktLeerZeichen(zeile:string):string;
var
   inis:string;
begin
    inis:='';
    zeile:=Vorname(Zeile);
     while length(zeile) > 0 do
     begin
         if not (copy(zeile,1,1)= ' ') then inis:=inis + copy(zeile,1,1)+ '. ';
         if pos(' ',Zeile) > 0 then {weitere Vornamen}
         begin
             zeile:= copy(zeile, pos(' ',Zeile)+1,1000);
         end else begin
                zeile :='';
         end;
     end;
     result:=inis;
end;
function InitialenMitPunkt(zeile:string):string;
var
   inis:string;
begin
    inis:='';
    zeile:=Vorname(Zeile);
     while length(zeile) > 0 do
     begin
         if not (copy(zeile,1,1)= ' ') then inis:=inis + copy(zeile,1,1)+ '.';
         if pos(' ',Zeile) > 0 then {weitere Vornamen}
         begin
             zeile:= copy(zeile, pos(' ',Zeile)+1,1000);
         end else begin
                zeile :='';
         end;
     end;
     result:=inis;
end;

function Initialen(zeile:string):string;
var
   inis:string;
begin
    inis:='';
    zeile:=Vorname(Zeile);
     while length(zeile) > 0 do
     begin
         inis:=inis+copy(zeile,1,1);
         if pos(' ',Zeile) > 0 then {weitere Vornamen}
         begin
             zeile:= copy(zeile, pos(' ',Zeile)+1,1000);
         end else begin
                zeile :='';
         end;
     end;
     result:=inis;
end;

function FormatiereNamen(zeile, fm, namenstrennzeichen, letztnamenstrennzeichen, LNU, etalphrase, alleautoren:string):string;
var
   Au:string;
   AUZ:integer;
   AusgegebeneAutoren:integer;
   aut:string;
   i:integer;

   EtAlZahl:integer;
   MittlereNamenUmdrehen:boolean;
   LetztenNamenUmdrehen:boolean;
begin
    if alleAutoren='true' then EtAlZahl := 993 else etalzahl:= 2; // 1/19: auf 2 heruntergesetzt, weil sonst 3 Autoren komplett ausgegeben werden.

    MittlereNamenUmdrehen:=false;
    if lnu='true' then LetztenNamenUmdrehen:=true else LetztenNamenUmdrehen:=false;

    if pos(',',Zeile) = 0 then {kein PersonenName}
        begin
                AU:=Zeile;
                AUZ:=1;
        end else begin
                AUZ:=BestimmePersonenZahl(Zeile);
                AusgegebeneAutoren:=AUZ;
                If Auz > EtAlZahl then
                begin
                        aut:='';
                        ausgegebeneAutoren:=1; //standardmäßig auf 1 setezen
                        aut:= aut + copy(zeile,1,pos(';',zeile)) + '  ';
                        zeile:=copy(zeile,pos('; ',zeile)+1,1000);
                        zeile:=copy(aut,1,length(aut)-1);
                end;
        {Akerlof, George A.}
               if FM = 'Akerlof, George A.' then
               begin
                     AU:= AU + NachName(Zeile) + ', ' + Vorname(Zeile);
                     if  pos(';',Zeile) > 0 then
                     begin
                        Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                     end else begin
                         Zeile:='';
                     end;
                     for i:=2 to AusgegebeneAutoren - 1 do
                     begin
                        if (MittlereNamenUmdrehen=true) then
                        begin
                             AU:=AU  + NamensTrennzeichen+ Vorname(Zeile) + ' ' +  NachName(zeile) ;
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end else begin
                             AU:= AU  + NamensTrennzeichen + NachName(Zeile) + ', ' + Vorname(Zeile);
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end;
                     end;
                     if (length(AU) > 0) and (length(Zeile)> 0) and (ausgegebeneAutoren > 1) then
                     begin
                        if auz > ausgegebeneAutoren then Au:=AU  + NamensTrennzeichen else Au:=AU  + LetztNamensTrennzeichen;

                        if LetztenNamenUmdrehen=true then  AU:=AU + Vorname(Zeile) +' ' + NachName(zeile) else AU:=AU+ NachName(Zeile) + ', ' + VorName(Zeile);
                     end;

               end;
        {Akerlof, G. A.}
               if FM = 'Akerlof, G. A.' then
               begin
                     AU:= AU + NachName(Zeile) + ', ' + InitialenMitPunktLeerZeichen(Zeile);
                     AU:=copy(Au,1,length(au)-1); // letztes Leerzeichen weg.
                     if  pos(';',Zeile) > 0 then
                     begin
                        Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                     end else begin
                         Zeile:='';
                     end;
                     for i:=2 to AusgegebeneAutoren - 1 do
                     begin
                        if (MittlereNamenUmdrehen=true) then
                        begin
                             AU:= AU   + NamensTrennzeichen + InitialenMitPunktLeerZeichen(Zeile) + NachName(Zeile);
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end else begin
                             AU:= AU  + NamensTrennzeichen + NachName(Zeile) + ', ' + InitialenMitPunktLeerZeichen(Zeile);
                             AU:=copy(Au,1,length(au)-1); // letztes Leerzeichen weg.
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end;
                     end;
                     if (length(AU) > 0) and (length(Zeile)> 0) and (ausgegebeneAutoren > 1)then
                     begin
                        if auz > ausgegebeneAutoren then Au:=AU  + NamensTrennzeichen else Au:=AU  + LetztNamensTrennzeichen;
                        if (LetztenNamenUmdrehen=true)  then
                        begin
                                AU:= AU  + InitialenMitPunktLeerZeichen(Zeile) + NachName(Zeile);
                        end else begin
                                 AU:= AU + NachName(Zeile) + ', ' + InitialenMitPunktLeerZeichen(Zeile);
                                 AU:=copy(Au,1,length(au)-1); // letztes Leerzeichen weg.
                        end;
                     end;
               end;
        {Akerlof, G.A.}
               if FM = 'Akerlof, G.A.' then
               begin
                     AU:= AU + NachName(Zeile) + ', ' + InitialenMitPunkt(Zeile);// erster Autor
                     if  pos(';',Zeile) > 0 then
                     begin
                        Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                     end else begin
                         Zeile:='';
                     end;
                     for i:=2 to AusgegebeneAutoren - 1 do
                     begin
                        if (MittlereNamenUmdrehen=true) then
                        begin
                             AU:= AU  +Namenstrennzeichen + InitialenMitPunkt(Zeile) +' ' + NachName(Zeile);//A2 umgedreht
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end else begin
                             AU:= AU + Namenstrennzeichen + NachName(Zeile) + ', ' + InitialenMitPunkt(Zeile) ;//A2 regulär
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end;
                     end;
                     if (length(AU) > 0) and (length(Zeile)> 0) and (ausgegebeneAutoren > 1) then
                     begin
                        if auz > ausgegebeneAutoren then Au:=AU  + NamensTrennzeichen else Au:=AU  + LetztNamensTrennzeichen;
                        if (LetztenNamenUmdrehen=true) then AU:= AU  + InitialenMitPunkt(Zeile) +' ' + NachName(Zeile) else AU:= AU + NachName(Zeile) + ', ' + InitialenMitPunkt(Zeile);
                     end;
               end;
        {Akerlof, GA}
               if FM = 'Akerlof, GA' then
               begin
                     AU:= AU + NachName(Zeile) + ', ' + Initialen(Zeile); // erster Autor
                     if  pos(';',Zeile) > 0 then
                     begin
                        Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                     end else begin
                         Zeile:='';
                     end;
                     for i:=2 to AusgegebeneAutoren - 1 do
                     begin
                        if (MittlereNamenUmdrehen=true) then
                        begin
                             AU:= AU +Namenstrennzeichen + Initialen(Zeile) + ' ' + NachName(Zeile);//A2 umgedreht
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end else begin
                             AU:= AU + Namenstrennzeichen + NachName(Zeile) + ', ' + Initialen(Zeile) ;//A2 regulär
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end;
                     end;
                     if (length(AU) > 0) and (length(Zeile)> 0) and (ausgegebeneAutoren > 1)then
                     begin
                        if auz > ausgegebeneAutoren then Au:=AU  + NamensTrennzeichen else Au:=AU  + LetztNamensTrennzeichen;
                        if (LetztenNamenUmdrehen=true)  then  AU:= AU  + Initialen(Zeile) +' ' + NachName(Zeile) else AU:= AU + NachName(Zeile) + ', ' + Initialen(Zeile);
                     end;
               end;
        {Akerlof GA}
               if FM = 'Akerlof GA' then
               begin
                     AU:= AU + NachName(Zeile) + ' ' + Initialen(Zeile);   // erster Autor
                     if  pos(';',Zeile) > 0 then
                     begin
                        Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                     end else begin
                         Zeile:='';
                     end;
                     for i:=2 to AusgegebeneAutoren - 1 do
                     begin
                        if (MittlereNamenUmdrehen=true) then
                        begin
                             AU:= AU + Namenstrennzeichen + Initialen(Zeile) + NachName(Zeile);//A2 umgedreht
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end else begin
                             AU:= AU + NamensTrennzeichen + NachName(Zeile) + ' ' + Initialen(Zeile) ;//A2 regulär
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end;
                     end;
                     if (length(AU) > 0) and (length(Zeile)> 0) and (ausgegebeneAutoren > 1)then
                     begin
                        if auz > ausgegebeneAutoren then Au:=AU  + NamensTrennzeichen else Au:=AU  + LetztNamensTrennzeichen;
                        if (LetztenNamenUmdrehen=true)  then  AU:= AU  + Initialen(Zeile) + NachName(Zeile) else  AU:= AU + NachName(Zeile) + ' ' + Initialen(Zeile);//An regulär
                     end;
                end;
        {George A. Akerlof}
                if FM = 'George A. Akerlof' then
                begin
                     AU:= AU + VorName(Zeile) + ' ' + Nachname(Zeile) ; // erster Autor
                     if  pos(';',Zeile) > 0 then
                     begin
                        Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                     end else begin
                         Zeile:='';
                     end;
                     for i:=2 to AusgegebeneAutoren - 1 do
                     begin
                        if (MittlereNamenUmdrehen=true) then
                        begin
                             AU:=AU + Namenstrennzeichen + Nachname(Zeile) + ', ' + VorName(zeile);//A2 umgedreht
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end else begin
                             AU:= AU + Namenstrennzeichen + VorName(Zeile) + ' ' + Nachname(Zeile);//A2 regulär
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end;
                     end;
                     if (length(AU) > 0) and (length(Zeile)> 0) and (ausgegebeneAutoren > 1)then
                     begin
                        if auz > ausgegebeneAutoren then Au:=AU  + NamensTrennzeichen else Au:=AU  + LetztNamensTrennzeichen;
                        if (LetztenNamenUmdrehen=true)  then AU:=AU + Nachname(Zeile) + ', ' + VorName(zeile) else AU:= AU + VorName(Zeile) + ' ' + Nachname(Zeile);//An regulär
                     end;

         end;
        {G. A. Akerlof}
         if FM = 'G. A. Akerlof' then
               begin
                     AU:= AU + InitialenMitPunktLeerZeichen(Zeile)  + Nachname(Zeile) ;                // erster Autor
                     if  pos(';',Zeile) > 0 then
                     begin
                        Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                     end else begin
                         Zeile:='';
                     end;
                     for i:=2 to AusgegebeneAutoren - 1 do
                     begin
                        if (MittlereNamenUmdrehen=true) then
                        begin
                             AU:= AU +Namenstrennzeichen + NachName(Zeile) + ', ' + InitialenMitPunkt(Zeile);//A2 umgedreht
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end else begin
                             AU:= AU + NamensTrennzeichen + InitialenMitPunktLeerZeichen(Zeile)  + Nachname(Zeile) ;//A2 regulär
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end;

                     end;
                     if (length(AU) > 0) and (length(Zeile)> 0) and (ausgegebeneAutoren > 1)then
                     begin
                        if auz > ausgegebeneAutoren then Au:=AU  + NamensTrennzeichen else Au:=AU  + LetztNamensTrennzeichen;
                        if (LetztenNamenUmdrehen=true)  then AU:= AU + NachName(Zeile) + ', ' + InitialenMitPunktLeerZeichen(Zeile) else AU:= AU + InitialenMitPunktLeerZeichen(Zeile) + Nachname(Zeile);//An regulär
                     end;
               end;
          {G.A. Akerlof}
               if FM = 'G.A. Akerlof' then
               begin
                     AU:= AU + InitialenMitPunkt(Zeile) + ' ' + NachName(Zeile) ;               // erster Autor
                     if  pos(';',Zeile) > 0 then
                     begin
                        Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                     end else begin
                         Zeile:='';
                     end;
                     for i:=2 to AusgegebeneAutoren - 1 do
                     begin
                        if (MittlereNamenUmdrehen=true) then
                        begin
                             AU:= AU + Namenstrennzeichen + NachName(Zeile) + ', ' + InitialenMitPunkt(Zeile);//A2 umgedreht
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end else begin
                             AU:= AU + Namenstrennzeichen + InitialenMitPunkt(Zeile) + ' ' + NachName(Zeile) ;//A2 regulär
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end;
                     end;
                     if (length(AU) > 0) and (length(Zeile)> 0) and (ausgegebeneAutoren > 1)then
                     begin
                        if auz > ausgegebeneAutoren then Au:=AU  + NamensTrennzeichen else Au:=AU  + LetztNamensTrennzeichen;
                        if (LetztenNamenUmdrehen=true) then AU:= AU + NachName(Zeile) + ', ' + InitialenMitPunkt(Zeile) else AU:= AU + InitialenMitPunkt(Zeile) + ' ' + NachName(Zeile);//An regulär
                     end;
               end;
          {GA Akerlof}
               if FM = 'GA Akerlof' then
               begin
                     AU:= AU + Initialen(Zeile)+ ' ' + NachName(Zeile)  ;               // erster Autor
                     if  pos(';',Zeile) > 0 then
                     begin
                        Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                     end else begin
                         Zeile:='';
                     end;
                     for i:=2 to AusgegebeneAutoren - 1 do
                     begin
                        if (MittlereNamenUmdrehen=true) then
                        begin
                             AU:= AU + Namenstrennzeichen  + NachName(Zeile) + ' ' + Initialen(Zeile);//A2 umgedreht
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end else begin
                             AU:= AU + Namenstrennzeichen + Initialen(Zeile)+ ' ' + NachName(Zeile)  ;//A2 regulär
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end;
                        if (length(AU) > 0) and (length(Zeile)> 0)and (ausgegebeneAutoren > 1) then
                        begin
                                if auz > ausgegebeneAutoren then Au:=AU  + NamensTrennzeichen else Au:=AU  + LetztNamensTrennzeichen;
                                if (LetztenNamenUmdrehen=true) then AU:= AU + NachName(Zeile) + ' ' + Initialen(Zeile) else AU:= AU + Initialen(Zeile)+ ' ' + NachName(Zeile);//An regulär
                        end;
                     end;
               end;
          {Akerlof}
               if FM = 'Akerlof' then
               begin
                     AU:= AU + NachName(Zeile);               // erster Autor
                     if  pos(';',Zeile) > 0 then
                     begin
                        Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                     end else begin
                         Zeile:='';
                     end;
                     for i:=2 to AusgegebeneAutoren - 1 do
                     begin
                          AU:= AU +Namenstrennzeichen + NachName(Zeile);//A2 regulär

                          Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                     end;
                     if  (length(AU) > 0) and (length(Zeile)> 0) and (ausgegebeneAutoren > 1)then
                     begin
                        if auz > ausgegebeneAutoren then Au:=AU  + NamensTrennzeichen + NachName(Zeile) else Au:=AU  + LetztNamensTrennzeichen + NachName(Zeile);
                     end;
                end;
          //Akerlof George A
                if FM = 'Akerlof George A' then
                begin
                     AU:= AU + NachName(Zeile) + ' ' + Vorname(Zeile);
                     if  pos(';',Zeile) > 0 then
                     begin
                        Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                     end else begin
                         Zeile:='';
                     end;
                     for i:=2 to AusgegebeneAutoren - 1 do
                     begin
                        if (MittlereNamenUmdrehen=true) then
                        begin
                             AU:=AU  + NamensTrennzeichen+ Vorname(Zeile) + ' ' +  NachName(zeile) ;
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end else begin
                             AU:= AU  + NamensTrennzeichen + NachName(Zeile) + ' ' + Vorname(Zeile);
                             Zeile:= copy(Zeile,pos(';',Zeile)+1, 1000);
                        end;
                     end;
                     if (length(AU) > 0) and (length(Zeile)> 0) and (ausgegebeneAutoren > 1) then
                     begin
                        if auz > ausgegebeneAutoren then Au:=AU  + NamensTrennzeichen else Au:=AU  + LetztNamensTrennzeichen;

                        if LetztenNamenUmdrehen=true then  AU:=AU + Vorname(Zeile) +' ' + NachName(zeile) else AU:=AU+ NachName(Zeile) + ' ' + VorName(Zeile);
                     end;

               end;
          end;
          au:=stringreplace(au,'_',' ',[rfreplaceall]) ;
          If Auz > EtAlZahl then Au:= Au + EtAlPhrase;
          Result:=AU;
end;


function QuelleInRTFFormatieren(rtf:boolean):string;
var
  Feld:string;
  matrixseite:integer;
  j:integer;
  spalte:integer;
  zeile:string;
begin
         //Autoren- und Herausgeberfeld präventiv formatieren. Braucht man später nicht mehr.
         LiteraturZeile[Spalte_Autor]:= FormatiereNamen(LiteraturZeile[Spalte_Autor], Richtlinie[5,1,2], Richtlinie[5,1,3], Richtlinie[5,1,4], Richtlinie[5,1,5] , Richtlinie[5,1,6], Richtlinie[5,1,8] );
         LiteraturZeile[Spalte_Herausgeber]:=
              FormatiereNamen(LiteraturZeile[Spalte_Herausgeber], Richtlinie[5,1,7], Richtlinie[5,1,3], Richtlinie[5,1,4], Richtlinie[5,1,5] , Richtlinie[5,1,6], Richtlinie[5,1,8]);
         if LiteraturZeile[Spalte_Publikationstyp]='Sammelband'
            then if pos('Hg.)',   LiteraturZeile[Spalte_Autor] )=0
               then LiteraturZeile[Spalte_Autor]:=
                    LiteraturZeile[Spalte_Autor] + ' (Hg.)'; //Hg. als Kürzel
                    { falls da schon ein Hg. steht, soll das nicht doppelt
                      erscheinen 02/2024}

         //Publikatonstyp bestimmen
         MatrixSeite:=1; // Buch = 1 = Standard
         if LiteraturZeile[Spalte_Publikationstyp]='Artikel' then MatrixSeite:=2;
         if LiteraturZeile[Spalte_Publikationstyp]='Kapitel' then MatrixSeite:=3;
         if LiteraturZeile[Spalte_Publikationstyp]='Webseite' then MatrixSeite:=4;
         if LiteraturZeile[Spalte_Publikationstyp]='article' then MatrixSeite:=2;
         if LiteraturZeile[Spalte_Publikationstyp]='chapter' then MatrixSeite:=3;
         if LiteraturZeile[Spalte_Publikationstyp]='web page' then MatrixSeite:=4;

         Zeile:='';
         for j:=1 to 10 do // die Formatierungsmatrix im Editor durchgehen
         begin
              Feld:= Richtlinie[matrixseite,3,j];
              if feld <> '' then // Das Feld im EdNachNameitor ist belegt.
              begin
                 spalte:=-1; //sollte leer sein
                 //Die Spalte bestimmen
                 if Feld='Autor' then        Spalte:=Spalte_Autor;
                 if Feld='Jahr' then         Spalte:=Spalte_Jahr;
                 if Feld='Titel' then        Spalte:=Spalte_Titel;
                 if Feld='Untertitel' then   Spalte:=Spalte_Untertitel;
                 if Feld='Zeitschrift' then  Spalte:=Spalte_Zeitschrift;
                 if Feld='Band' then         Spalte:=Spalte_Band;
                 if Feld='Datum' then        Spalte:=Spalte_Publikationsdatum;
                 if Feld='Nummer' then       Spalte:=Spalte_Nummer;
                 if Feld='Seiten' then       Spalte:=Spalte_Seiten;
                 if Feld='Herausgeber' then  Spalte:=Spalte_Herausgeber;
                 if Feld='Sammelband' then   Spalte:=Spalte_Sammelband;
                 if Feld='Verlag' then       Spalte:=Spalte_Verlag;
                 if Feld='Ort' then          Spalte:=Spalte_Ort;
                 if Feld='Auflage' then      Spalte:=Spalte_Auflage;


                if spalte > -1 then
                begin
                      if LiteraturZeile[spalte] <> '' then //Das Datenfeld ist auch ausgefüllt
                      begin
                           //Formatierungen
                           Zeile:=Zeile + Richtlinie[MatrixSeite,2,j];  // Text vor dem Feld
                           if rtf then
                           begin
                                zeile:= Zeile + '{';
                                if Richtlinie[matrixseite,1,j] = 'fett' then Zeile:=zeile + '\b ' ;
                                if Richtlinie[matrixseite,1,j] = 'kursiv' then Zeile:=zeile + '\i ' ;
                                if Richtlinie[matrixseite,1,j] = 'unterstrichen' then Zeile:=zeile + '\ul ' ;

                           end;
                           Zeile:=Zeile + LiteraturZeile[spalte]  ;
                           if rtf then   zeile:=zeile +   '}'; // Text hinter dem Feld
                           zeile:=zeile + Richtlinie[MatrixSeite,4,j] ;
                      end;
                end;

              end;
         end;

         //Vermüllte Formatierung aufräumen

         zeile:=stringreplace(zeile,'. .','. ',[rfreplaceall]) ;
         zeile:=stringreplace(zeile,'. , ','., ',[rfreplaceall]) ;
         zeile:=stringreplace(zeile,',"','"',[rfreplaceall]) ;
         zeile:=stringreplace(zeile,'  ',' ',[rfreplaceall]) ;
         zeile:=stringreplace(zeile,'..','.',[rfreplaceall]) ;

         if rtf then result:=UmlautXMLtoRTF(Zeile) else result:=zeile;
end;
// ------------ Ende Funktionen, die den Literaturanhang formatieren -----//
//
//
//
//
//
// -------------Funktionen, die temporäre Zitate analysieren -------------------//
{
function getIDfromTmpCitation(ein:string):string;            5x
function HolTmpZitatID(zeile:string):string;                 3x
function HolZitatSeite(zeile:string):string;                 1x
}


function getIDfromTmpCitation(ein:string):string;
begin
    if pos('=]',ein) = 0 then
         ein:=ein+'=]'; //jetzt ist es vollständig

    //sicherstellen, dass die ID isoliert ist
    ein:=stringreplace(ein,'-',' ',[rfreplaceall]) ;
    ein:=stringreplace(ein,'#',' ',[rfreplaceall]) ;
    ein:=getfirstword(ein) ;
    ein:=Zahlenausfiltern(ein);
    result:=trim(ein);

end;
function HolTmpZitatID(zeile:string):string;
const
        troublemaker='xxxxxxxxxxx[={\*\xmlopen\xmlns2{\factoidname Rufnummer}}2294{\*\xmlclose}';
        dreipunkte= '\' + '''' ; //um mir auch andere sonderzeichen vom Leib zu halten

var
    id:string;
    originalzeile:string ;
    zweitesWort:string;
begin
    //Die temp. Zitate kommen in der Form =1234 - bla =] an
    originalzeile:=zeile;
    if pos(dreipunkte,zeile) =1  then zeile:='';

    //Wenn kein = drin ist oder "zu spät" kommt, scheint es kein Zitat zu sein.
    if pos('=',zeile)= 0 then zeile:='';
    if pos('=',zeile)> 50 then zeile:='';

    //Falls ein [numerisches] Format gewählt wird, könnte eine [ am Anfnag stehen... Die muß raus.
    if pos('[=',zeile) = 1 then zeile:=copy(zeile,2,1000);

    //verstümmeltes Zitat in den Word-Textinformationen. Nicht wegzubekommen!
    if pos('{\creatim\yr',zeile) > 0 then
    begin
        zeile:='';
        showmsg('Fehlermeldung: exotisches Word-Problem. Bitte Handbuch lesen.');
    end;

    if pos(troublemaker,zeile) > 0 then showmsg('1: ' + zeile);
    id:=zeile;

    if pos('-',id) > 0 then
        id:=copy(id,1,pos('-',id)-1); // [=4 - Akerlof ... =] bis -

    //Problem: Wenn noch ein _N eingefügt wird, kann das Ärger geben, weil
    //noch Steuercode eingefügt wird.


        if pos('\endash',id) > 0 then //falls Word den Strich durch eine Parenthese ersetzt hat
                id:=copy(id,1,pos('\endash',id)-1);
        //Sonderfall } ganz vorn
        if pos('}',id)<3 then id:=copy(id,pos('}',id)+1, 10000);
        if pos(troublemaker,zeile) > 0 then showmsg('11: ' + id);


        //Sonderfall Smart Tage Funktion in Word
        if pos('{\*\xmlopen\xmln',id) > 0 then
        begin
               if pos('{\*\xmlopen\xmln',id) < 5 then // steht am Anfang  zwischen Klammer und ID Nummer
               begin
                        if pos('}}', id) > 0 then
                        begin
                                id:='[=' + copy(id,(pos('}}',id) +2),1000);
                        end;
               end;
        end;

        if pos(troublemaker,zeile) > 0 then showmsg('12: ' + id);
        if pos('}',id)> 0 then id:=copy(id,1,pos('}',id)-1);
        while pos('[',id) > 0 do id:=copy(id,2,10000);
        while pos('=',id) > 0 do id:=copy(id,2,10000);
        if pos(' ',id) = 1 then id:=copy(id,2,10000);
        if pos(troublemaker,zeile) > 0 then showmsg('2: ' + id);

        //Sonderfall \hich ganz vorn
        while pos('\hich',id) =1  do
        begin
                id:=deletefirstword(id);
                id:=trim(id);
                if pos(troublemaker,zeile) > 0 then showmsg('3: ' + id);
        end;
        if pos(troublemaker,zeile) > 0 then showmsg('4: ' + id);
        //Sonderfall 1\hich\....\bla 60 = ID 160
        if pos('\',id) > 0 then
        begin
                if pos(' ',id)> 0 then zweiteswort:=copy(id,pos(' ',id)+1, 100) else zweiteswort:='';
                id:=copy(id,1,pos('\',id)-1) + zweitesWort;
        end;


        if pos(troublemaker,zeile) > 0 then showmsg('5 ' + id);


        //jetzt sollte die Zahl vorn stehen

    id:=copy(id,1,8); //Falls hinter der Zahl noch RTF-Blub steht, der Zahlen enthält,
                        //wird das jetzt abgeschnitten. Annahme id < 10.000.000
                        //bzw. relativ wenig Zeichen innerhalb der ID

    // falls eine Seitenzahl in der ID ist. Raus damit
    while pos('#',id) > 0 do id:=copy(id,1,length(id)-1);
    id:=zahlenausfiltern(id);  //alles, was nicht Zahl ist raus...
    if pos('0',id)=1 then id:=''  ;
    //Das "=" stehet HINTER dem, was als ID identifiziert worden ist. Kann nicht sein.
    if pos('=',originalzeile) > pos(id,originalzeile) then zeile:='' ;
    if pos(troublemaker,zeile) > 0 then showmsg('ID= ' + id);
    result:=id;
end;

function HolZitatSeite(zeile:string):string;
   const
        troublemaker='xxxxxxxxxxx[={\*\xmlopen\xmlns2{\factoidname Rufnummer}}2294{\*\xmlclose}';
        dreipunkte= '\' + '''' ; //um mir auch andere sonderzeichen vom Leib zu halten
begin
     //Die temp. Zitate kommen in der Form =1234 - bla =] an
     if pos(dreipunkte,zeile) =1  then zeile:='';
     //Wenn kein = drin ist oder "zu spät" kommt, scheint es kein Zitat zu sein.
     if pos('=',zeile)= 0 then zeile:='';
     if pos('=',zeile)> 50 then zeile:='';
     if pos('#',zeile)=0 then
     begin
          zeile:='';
      end else begin
           zeile:=copy(zeile, pos('#',zeile)+1, 1000);
     end;
     if pos('-',zeile) > 0 then
     zeile:=copy(zeile,1,pos('-',zeile)-1);
     if pos('}',zeile)> 0 then zeile:=copy(zeile,1,pos('}',zeile)-1);
     result:=SonderzeichenRaus(zeile);
     if result='0' then result:='';
end;
// -------------Ende Funktionen, die temporäre Zitate analysieren -------------------//





// ------------- Funktionen, die Daten einlesen---------------------//
{
function xmleinlesen(SeiteNeu:string):string ;                         25x

function LiteraturLaden(welcheDB,Dateiname:string):boolean;       3x
function LiteraturVolltext(az:integer):boolean;

function NotizVolltext(i: integer): string;                       4x
function NotizarrayZeileNachOben(i:integer):boolean ;

function GliederungArrayEinlesen():boolean  ;

function IdentifiziereImportFormat(dat:string):string ;           2x
function riseinlesen(SeiteNeu:string):string ;                         25x
function refereinlesen(SeiteNeu:string):string ;                       25x
function bibtexeinlesen(SeiteNeu:string):string ;                      10x
function importReferDB(inputfilename:string):boolean;
function importBibTexDB(inputfilename:string):boolean;
function importPubMedDB(inputfilename:string):boolean;
function importRISDB(inputfilename:string):boolean;
function importz3950DB(inputfilename:string):boolean;
function VolltextKomplettieren(nr:integer):boolean;
}

function Volltext(vt:string):string;
begin
     result := vt + ' ' + ansilowercase(sonderzeichenraus(vt));
     { Das ermöglicht das Suchen, sowohl mit Großbuchstaben als auch nicht
       case sensitive. 05/2024}
end;

function NotizVolltext(i: integer): string;
var
  txt: string;
begin
  txt:=   daten[i, Spalte_Titel] + ' '
        + daten[i, Spalte_Anmerkung] + ' ';
  Daten[i,Spalte_Volltext]:= volltext(txt);
  result:=txt;
end;
function NotizarrayZeileNachOben(i:integer):boolean ;
begin
          Daten[i, Spalte_Bearbeitungsdatum] := formatdatetime('yyyymmddhhnn', now);
          ineedssorting:=true;
          AktuelleNotizenArrayZeile:=i;
          result:=true;
end;
function SaveChangesToArray():boolean;
var
   alteZeile:      integer;
   go:             boolean;
   i:              integer;
   top:            integer;
   zuweithinten:   integer;
begin
    zuweithinten:=50000;
    IsTextChanged:=false;
    if (length(fenster.feldinhalt.Text) > 0) then
    begin
          //Literaturdatensatz  abspeichern
          If  (AngezeigterTyp='L') then
          begin
               //Den Anmerkungstext abspeichern
               lneedssorting:=true;
               if Fenster.FeldInhalt.visible then
               begin
                  if Fenster.FeldInhalt.text <> Literatur[AktuelleLiteraturArrayZeile,Spalte_Anmerkung]then
                  begin
                     go:=true;
                     if length (Fenster.FeldInhalt.text) <2 then
                     go:=nobox('die Anmerkungen komplett löschen?') ;
                     if go then
                         Literatur[AktuelleLiteraturArrayZeile,Spalte_Anmerkung]:=
                         utf8encode(Fenster.FeldInhalt.text);
                  end;
               end;

               Literatur[AktuelleLiteraturArrayZeile,Spalte_Bearbeitungsdatum]:=
               formatdatetime('yyyymmddhhnn', now);
               LiteraturVolltext(AktuelleLiteraturArrayZeile);
          end else begin // es ist eine Notiz
          //Anmerkung abspeichern
           ineedssorting:=true;
           if Fenster.Feldinhalt.visible then
           begin
              if Fenster.Feldinhalt.text <> Daten[AktuelleNotizenArrayZeile,Spalte_Anmerkung] then
              begin
                 go:=true;
                 if length (Fenster.Feldinhalt.text) <2 then
                 go:=nobox('die Anmerkungen komplett löschen?') ;
                 if go then
                     Daten[AktuelleNotizenArrayZeile,Spalte_Anmerkung]:=
                     utf8encode(Fenster.FeldInhalt.text);
              end;
           end;
           Daten[AktuelleNotizenArrayZeile,Spalte_Bearbeitungsdatum]:=formatdatetime('yyyymmddhhnn', now);

          end;
    end;
end;



function riseinlesen(SeiteNeu:string):string ;
// eine Zeile bis - einlesen und Leerzeichen kürzen
var
   zeile:string;
begin
  zeile:=SeiteNeu;
  if pos('-',zeile)> 0 then
  begin
       zeile:=copy(zeile, pos('-',zeile)+1, 10000);
       zeile:=trim(zeile);
       result:=zeile;
       //result:=umlautRTFtoXML(result);  ist hier fehl am Platz (8/18)
  end else begin
       result:='';
  end;
end;
function refereinlesen(SeiteNeu:string):string ;
// eine Zeile bis %  einlesen und Leerzeichen kürzen
var
   zeile:string;
begin
  zeile:=SeiteNeu;
  if pos('%',zeile)=1 then
  begin
       zeile:=copy(zeile, 4, 10000);
       zeile:=trim(zeile);
       result:=zeile;
       result:=UmlautInListe(result);
  end else begin
       result:='';
  end;
end;
function bibtexeinlesen(SeiteNeu:string):string ;
// eine Zeile bis {  einlesen und }
var
   zeile:string;
begin
  zeile:=SeiteNeu;
  result:='';
  if pos('= {',zeile)>0 then
  begin
       zeile:=copy(zeile, pos('= {',zeile)+3, 10000);
       zeile:=trim(zeile);
       zeile:=copy(zeile,1,length(zeile)-2);
       result:=zeile;
       result:=UmlautInListe(result);
  end;
  if pos('={',zeile)>0 then  //Variante ohne Leerzeichen
  begin
       zeile:=copy(zeile, pos('={',zeile)+2, 10000);
       zeile:=trim(zeile);
       { gibt es noch folgende Zeilen, dann gibt es ein Komma. Bei der letzten
         Zeile nicht mehr und dann würde der letzte Buchstabe abgeschnitten
         Problem bei Google Scholar.}
       if pos('},',zeile) > 0 then
          zeile:=copy(zeile,1,length(zeile)-2)
       else
           zeile:=copy(zeile,1,length(zeile)-1);

       //-- evtl. vorhandene LaTeX-Umlaute übersetzen 12/2025
       zeile:=stringreplace(zeile,'{\"a}','ä',[rfreplaceall]) ;
       zeile:=stringreplace(zeile,'{\"o}','ö',[rfreplaceall]) ;
       zeile:=stringreplace(zeile,'{\"u}','ü',[rfreplaceall]) ;
       zeile:=stringreplace(zeile,'{\"A}','Ä',[rfreplaceall]) ;
       zeile:=stringreplace(zeile,'{\"O}','Ö',[rfreplaceall]) ;
       zeile:=stringreplace(zeile,'{\"s}','ß',[rfreplaceall]) ;


       result:=zeile;
       result:=UmlautInListe(result);
  end;


end;

function IdentifiziereImportFormat(dat:string):string ;
var
    z, frm:string;
    fi:textfile;
begin
     Assignfile(fi,dat);
     reset(fi);
     frm:='';
     machpause();
     while not eof(fi) do
     begin
           readln(fi,z);
           if pos('TY  ',z)>0 then frm:='ris';
           if pos('%A ',z)>0 then frm:='refer';
           if pos('<Quelle>',z)>0 then frm:='bx';
           if pos('FAU -',z)>0 then frm:='pubmed';
           if pos('= {',z)>0 then frm:='bibtex';
           if pos('={',z)>0 then  frm:='bibtex'; //Variante
           if pos(' $a',z)>0 then frm:='z3950';
           if pos('### ',z)>0 then frm:='z3950';
           if frm <> '' then break;
     end;
     closefile(fi);

     result:=frm;
end;
function xmleinlesen(SeiteNeu:string):string ;
var
   zeile:string;
begin
  zeile:=SeiteNeu;
  if length(zeile) > 0 then
  begin
       //Feldname am Anfang wegschneiden
       if (pos('<',zeile)=1) then zeile:=copy(zeile,pos('>',zeile)+1, 20000);
       //Feldname am Ende wegschneiden
       if pos('</',zeile) > 0 then zeile:=copy(zeile,1,pos('</',zeile)-1);
       result:=zeile;
  end else begin
      result:='';
  end;
end;
function LiteraturVolltext(az:integer):boolean;
var
 i:integer;
 txt:string;
begin
     for i:=1 to 3 do txt:=txt + Literatur[az,i];
     for i:=5 to Spalte_Ende do txt:=txt + Literatur[az,i];
     { 4 ist der Volltext selbst. Würde sich dann jedesmal verdoppeln}
     Literatur[az,Spalte_Volltext]:= volltext(txt);
     result:=true;
end;
function VolltextKomplettieren():boolean;
var
    i:integer;
begin
       for i:= 1 to Arraysize_Daten do  Notizvolltext(i);
       for i:= 1 to Arraysize_Literatur do  LiteraturVolltext(i);
    result:=true;
end;
function LiteraturArrayZeileNachoben(z:integer):boolean;
var
   i:integer;
begin
        LiteraturDatensatzZahl:=LiteraturDatensatzZahl+1; //an das Ende des arrays
        for i:=1 to Spalte_Ende do
        begin
             Literatur[LiteraturDatensatzZahl,i]:=Literatur[z,i];  //in den neuen Datensatz schreiben
             Literatur[z,i]:='';  //alte Zeile im Array löschen
        end;
        Literatur[LiteraturDatensatzZahl,23]:='';
        LiteraturVolltext(literaturdatensatzzahl);
        AktuelleLiteraturArrayZeile:=Literaturdatensatzzahl;
        lchanged:=true;
        result:=true;
end;
function LiteraturLaden(welcheDB,Dateiname:string):boolean; //Bibliographix Literaturdatenbank einlesen
var
  Datei:TextFile;
  LiteraturImport:          array of array of string;
  i,j, z:integer;
  ende:          boolean;
  tag, monat, jahr:string;
  Zeile:string;
  Feldname:string;
  vn:integer;
  txt:string;
  ZeilenNummer:integer;
begin
  welcheDB:=ansilowercase(welchedb);
  if fileexists(Dateiname) then
  begin
    SetLength(LiteraturImport, ArraySize_Literatur+2,Spalte_Ende+1);
       { Literaturimport ist ein lokaler Array, der geladen wird und dann in
         den Zielarray kopiert wird. Das ist einfacher, als den gleichen
         Ladevorgang für die Hauptdatenbank und die Importdatenbank zweimal
         zu programmieren. Nach dem Laden wird der Array nicht mehr gebraucht,
         muss also nicht eine globale Variable sein 02/2024 }


    if welcheDB='literatur' then
    begin
       for i:=1 to ArraySize_Literatur do
           for j:=1 to Spalte_Ende do Literatur[i,1]:='';
    end;

    if welcheDB='literatur2' then   // Import aus anderer Literaturdatenbank
    begin
         for i:=1 to ArraySize_Literatur do
              for j:=1 to Spalte_Ende do Literatur2[i,j]:='';
         SetLength(Literatur2, ArraySize_Literatur+2,Spalte_Ende+1);
    end;
    MachPause();
    Assignfile(Datei,Dateiname);
    reset(Datei);
    i:=1;
    ZeilenNummer:=0;
    SetMaxID(welcheDB,0);
    Ende:=false;
    MachPause();
    //Zuerst die .xml Datei einlesen.



     while not eof(datei) do
     begin
          readln(datei,zeile);
          if zeile='</Daten>' then ende:=true; {02/2024 defekte .xlm erkennen}
          if pos('<',zeile)=1 then  Feldname:=copy(zeile,2,pos('>',zeile)-2);
          //passen Datenbank und Version zusammen?
          if pos ('<version>',zeile)=1 then
          begin
               vn:=str2int(xmleinlesen(zeile));
               if vn > 6 then //Diese Version erwartet vn = 5
               begin
                    showmsg('Diese Datenbank ist mit einer neueren Version von Bibliographix erstellt worden und enthält Informationen, die mit dieser (älteren) Version verloren gehen würden. Bitte aktualisieren Sie die Installation');
                    Application.Terminate;
               end;
          end;
          //Anfang eines neuen Datensatzes
          if pos('<Quelle>',zeile) = 1  then
          begin
               ZeilenNummer:=ZeilenNummer + 1;
               Feldname:=''    ;
               LiteraturImport[ZeilenNummer,Spalte_Bearbeitungsdatum]:='190001010101'; //Standard, falls nichts ausgefüllt
          end;
          // Die Felder einer Quelle abklappern und in die Interne Datenbank einlesen
          if Feldname='Id'              then LiteraturImport[ZeilenNummer,Spalte_ID]:=xmleinlesen(zeile);
          if Feldname='Typ'             then LiteraturImport[ZeilenNummer,Spalte_Publikationstyp]:=xmleinlesen(zeile);
          if Feldname='Autor'           then LiteraturImport[ZeilenNummer,Spalte_Autor]:=xmleinlesen(zeile);
          if Feldname='Jahr'            then LiteraturImport[ZeilenNummer,Spalte_Jahr]:=xmleinlesen(zeile);
          if Feldname='Datum'           then LiteraturImport[ZeilenNummer,Spalte_Publikationsdatum]:=xmleinlesen(zeile);
          if Feldname='Titel'           then LiteraturImport[ZeilenNummer,Spalte_Titel]:=xmleinlesen(zeile);
          if Feldname='Untertitel'      then LiteraturImport[ZeilenNummer,Spalte_Untertitel]:=xmleinlesen(zeile);
          if Feldname='Zeitschrift'     then LiteraturImport[ZeilenNummer,Spalte_Zeitschrift]:=xmleinlesen(zeile);
          if Feldname='Band'            then LiteraturImport[ZeilenNummer,Spalte_Band]:=xmleinlesen(zeile);
          if Feldname='Nummer'          then LiteraturImport[ZeilenNummer,Spalte_Nummer]:=xmleinlesen(zeile);
          if Feldname='Seiten'          then LiteraturImport[ZeilenNummer,Spalte_Seiten]:=xmleinlesen(zeile);
          if Feldname='Herausgeber'     then LiteraturImport[ZeilenNummer,Spalte_Herausgeber]:=xmleinlesen(zeile);
          if Feldname='Sammelband'      then LiteraturImport[ZeilenNummer,Spalte_Sammelband]:=xmleinlesen(zeile);
          if Feldname='Verlag'          then LiteraturImport[ZeilenNummer,Spalte_Verlag]:=xmleinlesen(zeile);
          if Feldname='Ort'             then LiteraturImport[ZeilenNummer,Spalte_Ort]:=xmleinlesen(zeile);
          if Feldname='Auflage'         then LiteraturImport[ZeilenNummer,Spalte_Auflage]:=xmleinlesen(zeile);
          if Feldname='ISBN'            then LiteraturImport[ZeilenNummer,Spalte_ISBN]:=xmleinlesen(zeile);
          if Feldname='Anmerkung'       then
          begin
               if length(LiteraturImport[Zeilennummer,Spalte_Anmerkung]) = 0 then
               begin
                    LiteraturImport[ZeilenNummer,Spalte_Anmerkung]:=xmleinlesen(zeile);
               end else begin //Prüfen ob evtl. doppelzeile
                   if (pos(xmleinlesen(zeile), LiteraturImport[ZeilenNummer,Spalte_Anmerkung])=0) // and (length(xmleinlesen(zeile)) > 2)
                      then LiteraturImport[ZeilenNummer,Spalte_Anmerkung]:=LiteraturImport[ZeilenNummer,Spalte_Anmerkung] + #13#10 + xmleinlesen(zeile);
               end;
          end;
          if Feldname='Tag'             then
          begin
               if  LiteraturImport[ZeilenNummer,Spalte_Anmerkung]='' then
                   LiteraturImport[ZeilenNummer,Spalte_Anmerkung]:=' #tag#'
               else
                   LiteraturImport[ZeilenNummer,Spalte_Anmerkung]:=
                      LiteraturImport[ZeilenNummer,Spalte_Anmerkung] + '#tag#'
          end;

          if Feldname='Erstautor'       then LiteraturImport[ZeilenNummer,Spalte_Erstautor]:=xmleinlesen(zeile);
          if Feldname='Vollzitat'       then LiteraturImport[ZeilenNummer,Spalte_Vollzitat]:=xmleinlesen(zeile);


          if Feldname='Bearbeitung'     then LiteraturImport[ZeilenNummer,Spalte_Bearbeitungsdatum]:=xmleinlesen(zeile);  // ist der veraltet??
          if Feldname='erstellt'        then LiteraturImport[ZeilenNummer,Spalte_Erstelldatum]:=xmleinlesen(zeile);
          if Feldname='bearbeitungen'   then LiteraturImport[ZeilenNummer,Spalte_Bearbeitungszahl]:=xmleinlesen(zeile);
          if FeldName='Kurzzitat'       then LiteraturImport[ZeilenNummer,Spalte_Kurzzitat]:=xmleinlesen(zeile);
     end;
     closefile(datei);

     if not Ende then
     begin
        showmessage( 'Die Datenbank literatur.xml ist beschädigt. ' + #10#13 +
                     'Bitte verwenden Sie eine Sicherungskopie.');
        //copyfile( mypath + 'tmp' + slash(os) + 'literatur.xml',mypath + 'literatur.xml') ;

        halt;
     end;
     { Die Datenbank ist OK und wird gesichert }
     //    copyfile( mypath +  'ideen.xml',mypath + 'tmp' + slash(os) +'ideen.xml') ;

     SetNumberOfRecords(welcheDB,z+1);
     //Die Datei ist eingelesen. Jetzt Volltext

     for i:=1 to GetTopEmptyRow(welchedb) do
     begin
          if LiteraturImport[i,1] <> '' then
          begin
               txt:='';
               for j:= 1 to 24 do txt:=  txt + ' ' +  LiteraturImport[i,j];
               LiteraturImport[i,Spalte_Volltext]:=volltext(txt);
               if welcheDB='Literatur' then if str2int(LiteraturImport[i,1])>GetMaxID(welchedb) then SetMaxID(welchedb,str2int(LiteraturImport[i,1]));
          end;
     end;

     //---  UMKOPIEREN ------
     //-----------------------------------
     if welcheDB='literatur' then  { aus dem Array Literaturimport in Literatur
                                     umkopieren. Mir ist nicht ganz klar, wieso
                                     ich nicht gleich in literatur importiere
                                     02/2024 }
     begin
        for i:=1 to ArraySize_Literatur do
        begin
            if Literaturimport[i,1]<>'' then
            begin
                 for j:=1 to Spalte_Ende do Literatur[i,j]:=Literaturimport[i,j];
                 if Literatur[i,Spalte_Erstelldatum]='asdfasdfasdf' then
                 begin
                      if Literatur[i,Spalte_Bearbeitungsdatum]='' then //es gibt gar kein Datum
                      begin
                          Literatur[i,Spalte_Erstelldatum]:='-' ;
                      end  else begin //das letzte Bearbeitungsdatum ist sicher nicht zu alt
                          jahr:=copy(Literatur[i,Spalte_Bearbeitungsdatum],1,4);
                          monat:=copy(Literatur[i,Spalte_Bearbeitungsdatum],5,2);
                          tag:=copy(Literatur[i,Spalte_Bearbeitungsdatum],7,2);
                          Literatur[i,Spalte_Erstelldatum]:= 'vor/am ' + tag + '.'+ monat + '.' + jahr;
                      end;
                 end;
            end;
        end;
        GetTopEmptyRow('Literatur');
        GetMaxID('Literatur');
        GetNumberofRecords('Literatur');
     end;
     if welcheDB='literatur2' then  //In den Array Literatur2 umkopieren
     begin
        z:=1;
        for i:=1 to ArraySize_Literatur do
        begin
            if Literaturimport[i,1]<>'' then
            begin
                 Literatur2[z,1]:=inttostr(z); //Für das Importfenster ist die ID gleich der Zeilennummer
                 for j:=2 to 18 do Literatur2[z,j]:=Literaturimport[i,j];
                 Literatur2[z,Spalte_Erstautor]:=Literaturimport[i,Spalte_Erstautor];
                 txt:='' ;
                 for j:=2 to 18 do txt:= txt + ' ' + Literatur2[i,j];
                 Literatur2[i,Spalte_Volltext]:= Volltext(txt);

                 z:=z+1;
            end;
        end;
     end;
  end;

  result:=true;
end;


function GliederungArrayEinlesen():boolean  ;
var
  i,j:integer;
begin
  with fenster do
  begin
    MachPause();
    Dateiliste.mask:='*.*';
    Dateiliste.mask:='*.tree';
    Dateiliste.directory:=DBDirectory;
    j:=  (Dateiliste.items.Count) ;
    for i:=0 to j-1 do
    begin
       memozwischenablage.lines.LoadFromFile(DBDirectory + Dateiliste.Items.strings[i]);
       GliederungArray[1,i+1]:= Dateiliste.Items.strings[i];
       GliederungArray[2,i+1]:=memozwischenablage.lines.text;
       MachPause();
    end;
  end;

  result:=true;
end;
function importReferDB(inputfilename:string):boolean;
         //Einlesen einer RIS Datei in den Array Literatur2
         //Anzeige auf der Seite RIS Seite
var
  input:textfile;
  i,j:integer;
  zeilennr:integer;
  zeile:string;
begin
     zeilennr:=1;
     SetLength(Literatur2, ArraySize_Literatur+2,Spalte_Ende+1);
     for i:=1 to ArraySize_Literatur do for j:=1 to Spalte_Ende do Literatur2[i,j]:=''; //Array leeren, falls noch was drin ist
     assignfile(input,inputfilename);
     reset(input);
     while not (eof(input)) do
     begin
          readln(input,zeile);
          machpause();

          if (pos('%0 ',zeile)=1)  then //Anfang eines neuen Datensatzes erkannt. Es gibt keinen Abschluss für einen Datensatz in Refer
          begin
             //den letzten Datensatz vervollständigen
             Literatur2[zeilennr,1]:=Inttostr(ZeilenNr);
             Literatur2[ZeilenNr,Spalte_Erstautor]:=Nachname(Literatur2[ZeilenNr,Spalte_Autor]);
             for i:=3 to Spalte_Ende do Literatur2[Zeilennr,Spalte_Volltext]:=Literatur2[Zeilennr,Spalte_Volltext] + Literatur2[Zeilennr,i];
             Literatur2[Zeilennr,Spalte_Volltext]:=Sonderzeichenraus(Literatur2[Zeilennr,Spalte_Volltext]);
             Literatur2[Zeilennr,Spalte_Volltext]:=ansilowercase(Literatur2[Zeilennr,Spalte_Volltext]);

             //eins hochzählen
             ZeilenNr:=ZeilenNr+1  ;

             //Publikationstyp des neuen Datensatzes
             Literatur2[ZeilenNr,Spalte_Publikationstyp]:='Buch';
             if pos('ection',zeile) > 0 then Literatur2[Zeilennr,Spalte_Publikationstyp]:='Kapitel';
             if pos('age',zeile) > 0 then Literatur2[Zeilennr,Spalte_Publikationstyp]:='Webseite';
             if pos('ournal',zeile) > 0 then Literatur2[Zeilennr,Spalte_Publikationstyp]:='Artikel';

          end;
          if (pos('%A ',zeile)=1)  then  //Die Autoren werden einzeln aufgelistet, müssen aber in ein gemeinsames Feld
          begin
                  zeile:= refereinlesen(zeile) ;
                  if length (Literatur2[ZeilenNr,Spalte_Autor]) < 1 then Literatur2[ZeilenNr,Spalte_Autor]:=Zeile
                     else Literatur2[ZeilenNr,Spalte_Autor]:= Literatur2[ZeilenNr,Spalte_Autor] + '; ' + zeile ;
          end;
          if pos('%D ',zeile)=1 then Literatur2[ZeilenNr,Spalte_Jahr] :=refereinlesen(zeile) ;
          if pos('Y1  - ',zeile)=1 then
          begin
                  Literatur2[ZeilenNr,Spalte_Jahr] :=riseinlesen(zeile) ;
                  if Literatur2[ZeilenNr,Spalte_Autor]='' then Literatur2[ZeilenNr,Spalte_Autor]:=refereinlesen(zeile) // manchmal ist Y1 Ersatz für PY
          end;
          if pos('%T ',zeile)=1 then         Literatur2[ZeilenNr,Spalte_Titel]  :=refereinlesen(zeile) ; //Titel
          if pos('%J ',zeile)=1 then         Literatur2[ZeilenNr,Spalte_Zeitschrift]  :=refereinlesen(zeile) ; //Titel   ; //Zeitschrift
          if pos('%V ',zeile)=1 then         Literatur2[ZeilenNr,Spalte_Band]  :=refereinlesen(zeile) ;
          if pos('%N',zeile)=1 then          Literatur2[ZeilenNr,Spalte_Nummer]  :=refereinlesen(zeile) ;
          if pos('%P ',zeile)=1 then         Literatur2[ZeilenNr,Spalte_Seiten] :=refereinlesen(zeile) ;  ; //Seiten
          if pos('%E ',zeile)=1 then         Literatur2[ZeilenNr,Spalte_Herausgeber] :=refereinlesen(zeile) ; //Herausgeber
          if pos('%B ',zeile)=1 then         Literatur2[ZeilenNr,Spalte_Sammelband] :=refereinlesen(zeile) ; //Sammelband
          if pos('%I ',zeile)=1 then         Literatur2[ZeilenNr,Spalte_Verlag] :=refereinlesen(zeile) ; //Verlag
          if pos('%C ',zeile)=1 then         Literatur2[ZeilenNr,Spalte_Ort] :=refereinlesen(zeile) ; //Ort
     end;
     //den letzten Datensatz vervollständigen. der durchläuft nicht mehr die Schleife
     Literatur2[ZeilenNr,Spalte_Erstautor]:=Nachname(Literatur2[ZeilenNr,Spalte_Autor]);
     Literatur2[zeilennr,1]:=Inttostr(ZeilenNr);
     for i:=3 to 18 do Literatur2[Zeilennr,Spalte_Volltext]:=Literatur2[Zeilennr,Spalte_Volltext] + Literatur2[Zeilennr,i];
     Literatur2[Zeilennr,Spalte_Volltext]:=Sonderzeichenraus(Literatur2[Zeilennr,Spalte_Volltext]);
     Literatur2[Zeilennr,Spalte_Volltext]:=ansilowercase(Literatur2[Zeilennr,Spalte_Volltext]);
     Closefile(input);
     result:=true;
end;



function importBibTexDB(inputfilename:string):boolean;
var
  au:array[1..500] of string; //Autorenarray. 500 sollte auf jeden Fall reichen.

  input:textfile;
  i,j:integer;
  zeilennr:integer;
  zeile:string;
begin
     zeilennr:=1;
     SetLength(Literatur2, ArraySize_Literatur+2,Spalte_Ende+1);
     for i:=1 to ArraySize_Literatur do for j:=1 to Spalte_Ende do Literatur2[i,j]:=''; //Array leeren, falls noch was drin ist
     machpause();
     assignfile(input,inputfilename);
     reset(input);
     machpause();
     Literatur2[zeilennr,1]:=Inttostr(ZeilenNr);
     while not (eof(input)) do
     begin
          readln(input,zeile);
          machpause();

          if (pos('@',zeile)=1)  then //Anfang eines neuen Datensatzes erkannt
          begin
             //den letzten Datensatz vervollständigen
             Literatur2[Zeilennr,Spalte_Erstautor]:=Nachname(Literatur2[Zeilennr,Spalte_Autor]);
             for i:=1 to Spalte_Ende do Literatur2[Zeilennr,Spalte_Volltext]:=Literatur2[ZeilenNr,Spalte_Volltext] + Literatur2[Zeilennr,i];
             Literatur2[Zeilennr,Spalte_Volltext]:=Sonderzeichenraus(Literatur2[Zeilennr,Spalte_Volltext]);
             Literatur2[Zeilennr,Spalte_Volltext]:=ansilowercase(Literatur2[Zeilennr,Spalte_Volltext]);
             //eins hochzählen
             zeilennr:=zeilennr+1;
             Literatur2[zeilennr,1]:=Inttostr(ZeilenNr);

             //Ptyp bestimmen
             Literatur2[Zeilennr,Spalte_Publikationstyp]:='Buch';
             if pos('@in',zeile) > 0 then Literatur2[Zeilennr,Spalte_Publikationstyp]:='Kapitel';
             if pos('rticle',zeile) > 0 then
             begin
                  Literatur2[Zeilennr,Spalte_Publikationstyp]:='Artikel';
             end;
          end;
          if (pos('author  ',zeile)=1) or  (pos('author=',zeile)>0)   then
          begin
               for i:=1 to 500 do au[i]:=''; //Autorenarray leeren
               zeile:= bibtexeinlesen(zeile) ;   //Hier gibt es jetzt mehrere
                                                 //Varianten
               // Variante: George A Akerlof and Janet Yellen
               if pos(',',zeile) = 0  then
               begin
                   i:=1;
                   while pos(' and ',zeile)> 0 do    //Aufsplitten der Zeile in den Array au
                   begin
                         au[i]:=copy(zeile,1,pos(' and ',zeile)-1);
                         zeile:=copy(zeile, pos(' and ',zeile)+5, 10000) ;  //das AND muss mit weg
                         i:=i+1
                   end;
                   au[i]:=zeile;   //es gibt i Autoren
                   //jetzt den Namen umdehen. Leztes Wort zuerst, dann den Rest mit Komma getrennt
                   Literatur2[Zeilennr,Spalte_Autor]:=GetLastWord(au[1]) + ', ' + copy(au[1],1, length(au[1])-length(GetLastWord(au[1])));
                   trim(Literatur2[Zeilennr,Spalte_Autor]);
                   for j:=2 to i do   //Zweitautoren mit Semikolon getrennt.
                        Literatur2[Zeilennr,Spalte_Autor]:=Literatur2[Zeilennr,Spalte_Autor] + '; ' +  GetLastWord(au[j]) + ', ' + copy(au[j],1,  length(au[j])-length(GetLastWord(au[j])));
               end else begin  //Variante: Bird-David, Nurit and Abramson,
                    zeile:=stringreplace(zeile,' and ','; ',[rfreplaceall]) ;
                    Literatur2[Zeilennr,Spalte_Autor]:=trim(zeile);
               end;
          end;
          if  (pos('year  ',zeile)=1) or  (pos('year=',zeile)>0)
          then Literatur2[Zeilennr,Spalte_Jahr]:=bibtexeinlesen(zeile) ;
          if (pos('month  ',zeile)=1)    or  (pos('month=',zeile)>0)
          then Literatur2[Zeilennr,Spalte_Publikationsdatum]:=bibtexeinlesen(zeile) ;
          if (pos('title  ',zeile)=1)   or  (pos('title=',zeile)>0)
          then Literatur2[Zeilennr,Spalte_Titel]:=bibtexeinlesen(zeile) ;
          if (pos('journal  ',zeile)=1)   or  (pos('journal=',zeile)>0)
          then Literatur2[Zeilennr,Spalte_Zeitschrift]:=bibtexeinlesen(zeile) ;
          if (pos('volume  ',zeile)=1)    or  (pos('volume=',zeile)>0)
          then Literatur2[Zeilennr,Spalte_Band]:=bibtexeinlesen(zeile) ;
          if (pos('number  ',zeile)=1) or  (pos('number=',zeile)>0)
          then Literatur2[Zeilennr,Spalte_Nummer]:=bibtexeinlesen(zeile) ;
          if (pos('pages  ',zeile)=1)  or  (pos('pages=',zeile)>0)
          then Literatur2[Zeilennr,Spalte_Seiten]:=bibtexeinlesen(zeile) ;
          if (pos('editor  ',zeile)=1)  then
          begin
               for i:=1 to 500 do au[i]:=''; //Autorenarray leeren
               zeile:= bibtexeinlesen(zeile) ; //bringt George A Akerlof and Janet Yellen
               i:=1;
               while pos(' and ',zeile)> 0 do    //Aufsplitten der Zeile in den Array au
               begin
                     au[i]:=copy(zeile,1,pos(' and ',zeile)-1);
                     zeile:=copy(zeile, pos(' and ',zeile)+5, 10000) ;  //das AND muss mit weg
                     i:=i+1
               end;
               au[i]:=zeile;   //es gibt i Autoren
               //jetzt den Namen umdehen. Leztes Wort zuerst, dann den Rest mit Komma getrennt
               Literatur2[Zeilennr,Spalte_Herausgeber]:=GetLastWord(au[1]) + ', ' + copy(au[1],1, length(au[1])-length(GetLastWord(au[1])));
               trim(Literatur2[Zeilennr,Spalte_Autor]);
               for j:=2 to i do   //Zweitautoren mit Semikolon getrennt.
                    Literatur2[Zeilennr,Spalte_Herausgeber]:=Literatur2[Zeilennr,Spalte_Herausgeber] + '; ' +  GetLastWord(au[j]) + ', ' + copy(au[j],1,  length(au[j])-length(GetLastWord(au[j])));

          end;
          if (pos('series  ',zeile)=1) or  (pos('series=',zeile)>0)
          then Literatur2[Zeilennr,Spalte_Sammelband]:=bibtexeinlesen(zeile) ;
          if (pos('publisher  ',zeile)=1) or  (pos('publisher=',zeile)>0)
          then Literatur2[Zeilennr,Spalte_Verlag]:=bibtexeinlesen(zeile) ;
          if (pos('address  ',zeile)=1) or  (pos('address=',zeile)>0)
          then Literatur2[Zeilennr,Spalte_Ort]:=bibtexeinlesen(zeile) ;
          if (pos('edition  ',zeile)=1) or  (pos('edition=',zeile)>0)
          then Literatur2[Zeilennr,Spalte_Auflage]:=bibtexeinlesen(zeile) ;
          if (pos('isbn  ',zeile)=1)  or  (pos('isbn=',zeile)>0)
          then Literatur2[Zeilennr,Spalte_Verlag]:=bibtexeinlesen(zeile) ;
     end;

     //den letzten Datensatz vervollständigen. der durchläuft nicht mehr die Schleife
     Literatur2[Zeilennr,Spalte_Erstautor]:=Nachname(Literatur2[Zeilennr,Spalte_Autor]);
     for i:=2 to 18 do Literatur2[Zeilennr,Spalte_Volltext]:=Literatur2[ZeilenNr,Spalte_Volltext] + Literatur2[Zeilennr,i];
     Literatur2[Zeilennr,Spalte_Volltext]:=Sonderzeichenraus(Literatur2[Zeilennr,Spalte_Volltext]);
     Literatur2[Zeilennr,Spalte_Volltext]:=ansilowercase(Literatur2[Zeilennr,Spalte_Volltext]);

     machpause();
     closefile(input);
     result:=true;
end;

function importPubMedDB(inputfilename:string):boolean;
var
  input:textfile;
  i,j:integer;
  zeilennr:integer;
  yr:string;
  zeile:string;
begin
     zeilennr:=1;
     SetLength(Literatur2, ArraySize_Literatur+2,Spalte_Ende+1);
     for i:=1 to ArraySize_Literatur do for j:=1 to Spalte_Ende do Literatur2[i,j]:=''; //Array leeren, falls noch was drin ist
     machpause();
     assignfile(input,inputfilename);
     reset(input);
     machpause();
     Literatur2[zeilennr,1]:=Inttostr(ZeilenNr);
     while not (eof(input)) do
     begin
          readln(input,zeile);
          machpause();

          if (pos('PMID- ',zeile)=1)  then //Anfang eines neuen Datensatzes erkannt
          begin
               //den letzten Datensatz vervollständigen
               Literatur2[Zeilennr,Spalte_Erstautor]:=Nachname(Literatur2[Zeilennr,Spalte_Autor]);
               for i:=2 to  Spalte_Ende do Literatur2[Zeilennr,Spalte_Volltext]:=Literatur2[ZeilenNr,Spalte_Volltext] + Literatur2[Zeilennr,i];
               Literatur2[Zeilennr,Spalte_Volltext]:=Sonderzeichenraus(Literatur2[Zeilennr,Spalte_Volltext]);
               Literatur2[Zeilennr,Spalte_Volltext]:=ansilowercase(Literatur2[Zeilennr,Spalte_Volltext]);
               //eins hochzählen
               zeilennr:=zeilennr+1;
               Literatur2[zeilennr,1]:=Inttostr(ZeilenNr);
               Literatur2[zeilennr,Spalte_Publikationstyp]:='Artikel';
          end;
          if (pos('FAU ',zeile)=1) then //Autor
          begin
               zeile:= riseinlesen(zeile) ;
               if length (Literatur2[zeilennr,Spalte_Autor]) < 1 then
               Literatur2[zeilennr,Spalte_Autor]:=zeile else
                 Literatur2[zeilennr,Spalte_Autor]:= Literatur2[zeilennr,Spalte_Autor] + '; ' + zeile ;
          end;
          if pos('DP ',zeile)=1 then
          begin
               yr:= zahlenausfiltern(riseinlesen(zeile));
               yr:=copy(yr,1,4);
               Literatur2[zeilennr,Spalte_Jahr]:= yr;
          end;
          if pos('TI ',zeile)=1 then Literatur2[zeilennr,Spalte_Titel] :=riseinlesen(zeile) ; //Titel
          if pos('JT ',zeile)=1 then Literatur2[zeilennr,Spalte_Zeitschrift]:=riseinlesen(zeile) ; //Zeitschrift
          if pos('VI ',zeile)=1 then Literatur2[zeilennr,Spalte_Band]:=riseinlesen(zeile) ; //Zeitschrift   Band
          if pos('IP ',zeile)=1 then Literatur2[zeilennr,Spalte_Nummer]:=riseinlesen(zeile) ;
          if pos('PG ',zeile)=1 then Literatur2[zeilennr,Spalte_Seiten]:=riseinlesen(zeile) ; //Seiten
     end;
     //den letzten Datensatz vervollständigen. der durchläuft nicht mehr die Schleife
     Literatur2[Zeilennr,Spalte_Erstautor]:=Nachname(Literatur2[Zeilennr,Spalte_Autor]);
     for i:=2 to 18 do Literatur2[Zeilennr,Spalte_Volltext]:=Literatur2[ZeilenNr,Spalte_Volltext] + Literatur2[Zeilennr,i];
     Literatur2[Zeilennr,Spalte_Volltext]:=Sonderzeichenraus(Literatur2[Zeilennr,Spalte_Volltext]);
     Literatur2[Zeilennr,Spalte_Volltext]:=ansilowercase(Literatur2[Zeilennr,Spalte_Volltext]);

     machpause();
     closefile(input);
     result:=true;
end; //end RISimport


function importRISDB(inputfilename:string):boolean;
         //Einlesen einer RIS Datei in den Array Literatur2
         //Anzeige auf der Seite RIS Seite
var
  au:string;
  input:textfile;
  i,j:integer;
  zeilennr:integer;
  zeile:string;
begin
     zeilennr:=1;
     SetLength(Literatur2, ArraySize_Literatur+2,Spalte_Ende+1);
     for i:=1 to ArraySize_Literatur do for j:=1 to Spalte_Ende do Literatur2[i,j]:=''; //Array leeren, falls noch was drin ist
     machpause();
     assignfile(input,inputfilename);
     reset(input);
     machpause();
     Literatur2[zeilennr,1]:=Inttostr(ZeilenNr);
     while not (eof(input)) do
     begin
          readln(input,zeile);
          machpause();

          if pos('TY  ',zeile)=1 then //neuer Datensatz
          begin
               zeile:= riseinlesen(zeile) ;
               if zeile='' then Zeile:='Buch';
               if zeile='JOUR' then Zeile:='Artikel';
               if zeile='CHAP' then Zeile:='Kapitel';
               if zeile='ELEC' then Zeile:='Webseite';
               ZeilenNr:=ZeilenNr+1;
               Literatur2[zeilennr,1]:=Inttostr(ZeilenNr); // Die Zeilennummer als ID
               Literatur2[zeilennr,Spalte_Publikationstyp]:=Zeile;
               au:='';
          end;

          if (pos('AU  - ',zeile)=1) or (pos('A1  - ',zeile)=1) or (pos('A2  - ',zeile)=1) then
          begin
               zeile:= riseinlesen(zeile) ;
               if length(au) < 1 then Au:=zeile else Au:= Au + '; ' + zeile;
          end;

          if pos('PY  - ',zeile)=1 then Literatur2[Zeilennr,Spalte_Jahr]  := riseinlesen(Zeile);
          if pos('TI  - ',zeile)=1 then Literatur2[Zeilennr,Spalte_Titel]  := riseinlesen(Zeile);
          if pos('T1  - ',zeile)=1 then Literatur2[Zeilennr,Spalte_Titel]  := riseinlesen(Zeile);
          if pos('SP  - ',zeile)=1 then Literatur2[Zeilennr,Spalte_Seiten] := riseinlesen(Zeile);
          if pos('EP  - ',zeile)=1 then Literatur2[Zeilennr,Spalte_Seiten] := Literatur2[Zeilennr,Spalte_Seiten] + '-' + riseinlesen(Zeile);
          if pos('ED  - ',zeile)=1 then Literatur2[Zeilennr,Spalte_Herausgeber] := riseinlesen(Zeile);
          if pos('T2  - ',zeile)=1 then Literatur2[Zeilennr,Spalte_Sammelband] := riseinlesen(Zeile);
          if pos('PB  - ',zeile)=1 then Literatur2[Zeilennr,Spalte_Verlag] := riseinlesen(Zeile);
          if pos('CY  - ',zeile)=1 then Literatur2[Zeilennr,Spalte_Ort] := riseinlesen(Zeile);
          if pos('JO  - ',zeile)=1 then Literatur2[Zeilennr,Spalte_Zeitschrift] := riseinlesen(Zeile);
          if pos('Y1  - ',zeile)=1 then Literatur2[Zeilennr,Spalte_Jahr] := riseinlesen(Zeile);
          if pos('SN  - ',zeile)=1 then Literatur2[Zeilennr,Spalte_ISBN] := riseinlesen(Zeile);
          if pos('IS  - ',zeile)=1 then Literatur2[Zeilennr,Spalte_Nummer] := riseinlesen(Zeile);
          if pos('VL  - ',zeile)=1 then Literatur2[Zeilennr,Spalte_Band] := riseinlesen(Zeile);

          //Anmerkung. Alles unklare wird ebenfalls dorthin geschrieben.
          if pos('N2  - ',zeile)=1 then Literatur2[Zeilennr,Spalte_Anmerkung] := riseinlesen(Zeile);
          if (pos('  - ',zeile)= 0) and (length(zeile) > 2) then
             Literatur2[Zeilennr,Spalte_Anmerkung]:=Literatur2[Zeilennr,Spalte_Anmerkung] + ' ' + Zeile ;

          if pos('ER  -',zeile)=1 then
          begin
               Literatur2[Zeilennr,Spalte_Autor]:=au;
               Literatur2[Zeilennr,Spalte_Erstautor]:=Nachname(au);;

               for i:=1 to 18 do Literatur2[Zeilennr,Spalte_Volltext]:=Literatur2[ZeilenNr,Spalte_Volltext] + Literatur2[Zeilennr,i];
               Literatur2[Zeilennr,Spalte_Volltext]:=Sonderzeichenraus(Literatur2[Zeilennr,Spalte_Volltext]);
               Literatur2[Zeilennr,Spalte_Volltext]:=ansilowercase(Literatur2[Zeilennr,Spalte_Volltext]);
          end;

     end; // Die RIS Datei ist durchgelesen
     machpause();
     closefile(input);
     result:=true;
end;
function importz3950DB(inputfilename:string):boolean;
         //Einlesen einer RIS Datei in den Array Literatur2
         //Anzeige auf der Seite RIS Seite
var

  input:textfile;
  i,j:integer;
  zeilennr:integer;
  zeile:string;
  //globale variablen:   zau,zti,zyr,zloc,zpub,zut,zjour, zpage, zisbn, zaufl:string;
begin
     zeilennr:=1;
     SetLength(Literatur2, ArraySize_Literatur+2,Spalte_Ende+1);
     for i:=1 to ArraySize_Literatur do for j:=1 to Spalte_Ende do Literatur2[i,j]:=''; //Array leeren, falls noch was drin ist
     machpause();
     assignfile(input,inputfilename);
     reset(input);
     machpause();
     Literatur2[zeilennr,1]:=Inttostr(ZeilenNr);
     while not (eof(input)) do
     begin
          readln(input,zeile);
          machpause();

          //Seltsame Steuerzeichen ausfiltern. Nicht "sonderzeichenraus", weil noch $, # usw. vorhanden sind
          //331 ¬Die¬ Übernahme
          zeile:=stringreplace(zeile,'¬','',[rfreplaceall]) ;

          if (pos('### ',zeile)=1) or (pos('00',zeile)=1) or (pos('## ',zeile)=1)  then //neuer Datensatz. Globale Variablen rücksetzen
          begin
               zau:='';
               zti:='';
               zyr:='';
               zloc:='';
               zpub:='';
               zut:='';
               zjour:='';
               zpage:='';
               zisbn:='';
               zaufl:='';
               ZeilenNr:=ZeilenNr+1;
               Literatur2[zeilennr,1]:=Inttostr(ZeilenNr); // Die Zeilennummer als ID
               Literatur2[zeilennr,Spalte_Publikationstyp]:='Buch';

          end;

          //100 1  $a Landfester, Manfred $1==== MARC21
          //100 Kopatz, Michael ::[VerfasserIn]::
          if (pos ('100 ',zeile)=1) or (pos ('700 ',zeile)=1) or (pos ('920 ',zeile)=1) then
          begin

               zeile:=copy(zeile,4, 100);
               if pos(' $a ',zeile) > 0 then zeile:=copy(zeile,pos(' $a ',zeile)+ 4, 100);
               if pos('$',zeile)> 0 then zeile:= copy(zeile,1, pos(' $',zeile)-1);
               if pos('::',zeile)> 0 then zeile:= copy(zeile,1, pos('::',zeile)-1);
               if copy(zeile,length(zeile),1)=',' then zeile:=copy(zeile,1,length(zeile)-1);
               zau:=trim(zau);
               if zau='' then  zau:=zeile else zau:=zau  + '; ' + zeile;
          end;

          //104aArlt-Palmer, Christine //Zweitautor
          if pos ('104',zeile)=1 then
          begin
               zeile:=copy(zeile,5, 100);
               zau:=trim(zau);
               if zau='' then  zau:=zeile else zau:=zau  + '; ' + zeile;
          end;

          //200 10 $a Betrug und Selbstbetrug $e wie wir uns selbst und andere erfolgreich belügen $f Robert Trivers. Aus dem Engl. von Sebastian Vogel
          if pos ('200 ',zeile)=1 then
          begin
               zeile:=copy(zeile,pos(' $a ',zeile)+ 4, 200);
               zti:=zeile;
               if pos(' $e ',zeile) > 0 then zut :=copy(zeile,pos(' $e ',zeile) +4, 1000);
               if pos(' $',zti) > 0  then zti:=copy(zti,1,pos(' $',zti) -1);
               if pos(' $',zut) > 0  then zut:=copy(zut,1,pos(' $',zut) -1);
          end;

          //210    $a Berlin $c Ullstein $d 2013
          if pos ('210 ',zeile)=1 then
          begin
               if pos(' $a',zeile) > 0  then zloc:=copy(zeile,pos(' $a ',zeile)+ 4, 100);
               if pos(' $c',zeile) > 0  then zpub:=copy(zeile,pos(' $c ',zeile)+ 4, 100);
               if pos(' $d',zeile) > 0  then zyr:=copy(zeile,pos(' $d ',zeile)+ 4, 100);
               if pos(' $',zloc) > 0 then zloc:=copy(zloc,1,pos(' $',zloc)-1);
               if pos(' $',zpub) > 0 then zpub:=copy(zpub,1,pos(' $',zpub)-1);
               if pos(' $',zyr) > 0 then zyr:=copy(zyr,1,pos(' $',zyr)-1);
           end;

          // 245 10 $a Räuber, Rebellen, Rivalen, Rächer : $b Studien zu Latrones im römischen Reich / $c von Thomas Grünewald.
           if pos ('245 ',zeile)=1 then
           begin
                zeile:=copy(zeile,pos(' $a ',zeile)+ 4, 200);
                zti:=zeile;
                if pos(' $e ',zeile) > 0 then zut :=copy(zeile,pos(' $e ',zeile) +4, 1000);
                if pos(' $',zti) > 0  then zti:=copy(zti,1,pos(' $',zti) -1);
                if pos(' $',zut) > 0  then zut:=copy(zut,1,pos(' $',zut) -1);
           end;

          //250    $a 8. Auflage  --> 403

          //260    $a Stuttgart : $b Theiss, $c 1986.
          //419 $aBerlin$bSuhrkamp$c2019
          if (pos ('260 ',zeile)=1) or (pos ('264 ',zeile)=1) or (pos ('419 ',zeile)=1) then
          begin
                if pos('$a',zeile) > 0  then zloc:=copy(zeile,pos('$a',zeile)+ 2, 100);
                if pos('$b',zeile) > 0  then zpub:=copy(zeile,pos('$b',zeile)+ 2, 100);
                if pos('$c',zeile) > 0  then zyr:=copy(zeile,pos('$c',zeile)+ 2, 100);
                if pos('$',zloc) > 0 then zloc:=copy(zloc,1,pos('$',zloc)-1);
                if pos('$',zpub) > 0 then zpub:=copy(zpub,1,pos('$',zpub)-1);
                if pos('$',zyr) > 0 then zyr:=copy(zyr,1,pos(' $',zyr)-1);
          end;

          //331 Schluss mit der Ökomoral!
          if pos ('331',zeile)=1 then  zti:=copy(zeile,5,100);


          //335aZur Kritik des real existierenden Sozialismus
          if pos ('335',zeile)=1 then
          begin
               zut:=copy(zeile,5,100);
          end;

          //403 3. Aufl
          if (pos ('403',zeile)=1) or (pos ('250',zeile)=1) then
          begin
               zaufl:=copy(zeile,5,2);
               zaufl:=zahlenausfiltern(zaufl);
               //Manchmal wird eine erste Auflage angegeben, obwohl
               //es keine zweite gibt. Dann weg damit.
               if (ZAufl='1') then ZAufl:='';
          end;

          //410 München
          if pos ('410',zeile)=1 then  zloc:=copy(zeile,5,100);

          //412 oekom verlag
          if pos ('412',zeile)=1 then  zpub:=copy(zeile,5,100);

          //419 $aBerlin$bSuhrkamp$c2019
          // -> 260

          //425 2019  = Jahr
          //425a2019
          if pos ('425',zeile)=1 then  zyr:=copy(zeile,5,100);

          //433 542 S.
          if pos ('433',zeile)=1 then
          begin
               zpage:=copy(zeile,5,100);
               zpage:=zahlenausfiltern(zpage);
          end;

          //451bUnruhe bewahren  -- aber eher nachrangiges Feld im Vgl. zu 335
          if (pos ('451',zeile)=1) and (zut='') then zut:=copy(zeile,5,100);

          //540aISBN 3-434-00353-3
          if pos ('540',zeile)=1 then  zisbn:=copy(zeile,10,100);


          //700  1 $a Trivers $b Robert --> 100

          //701  1 $a Klein $b Bodo
          //700 1  $a Olshausen, Eckart, $d 1938-
          //700 1  $a Kostner, Sandra $0 (DE-588)1120531594 $4 edt
          //700 |300¦DNB

          //schwieriges Feld... sehr konfus.
          if ((pos ('7000 ',zeile)=1) or (pos ('701 ',zeile)=1)) and (pos ('$',zeile)>0) and  (pos ('|',zeile)=0)  then
          begin
               zeile:=copy(zeile,pos(' $a ',zeile)+ 4, 100);
               zeile:=stringreplace(zeile,' $b ',', ',[rfreplaceall]) ;
               if pos('$',zeile)> 0 then zeile:= copy(zeile,1, pos(' $',zeile)-1);
               zau:=trim(zau);
               if zau='' then zau:=zeile else zau := zau + '; ' + zeile;
          end;

          //920 1  $a Sen, Amartya $e Verfasser $4 aut --> In 100 abgehandelt
          Literatur2[Zeilennr,Spalte_Autor]:=   zau;
          Literatur2[Zeilennr,Spalte_Jahr]:=    zyr;
          Literatur2[Zeilennr,Spalte_Titel]:=   zti;
          Literatur2[Zeilennr,7]:=              zut;
          Literatur2[Zeilennr,Spalte_Seiten]:=  zpage;
          Literatur2[Zeilennr,Spalte_Verlag]:=  zpub;
          Literatur2[Zeilennr,Spalte_Ort]:=     zloc;
          Literatur2[Zeilennr,Spalte_Auflage]:= zaufl;
          Literatur2[Zeilennr,Spalte_ISBN]:=    zisbn;
          Literatur2[Zeilennr,Spalte_Erstautor]:=Nachname(zau); //Erstautor
     end; // Die Datei ist durchgelesen
     machpause();
     closefile(input);
     result:=true;
end;

// ------------- Ende Funktionen, die Daten einlesen---------------------//
//
//
//
//
//-------------- Funktionen, die Daten abspeichern -------------//
{
function xmlLiteraturzeileformatieren(zeile,spalte:integer;name:string):string; 25x
function schreibReferDB(was:string):boolean;
function schreibRISDB():boolean;
function schreibWordDB():boolean;
function schreibBibTeXDB(was:string):boolean;
function DatenArrayAenderungSichern():boolean;
function DatenArrayKomplettSichern():boolean;
function Gliederungspeichern(fname:string):boolean;
function SelbstAbschaltungEin():boolean;
function CreateFileLink(dropdatei:string):boolean;
function ZeigeEditor(ed:string):boolean;
function Speicherbedarf(was:string):boolean;
}






function CreateFileLink(dropdatei:string):boolean ;

var
  Auswahl  :               Integer;
  cursorposition:          integer;
  dropname:                string;
  FileDir:                 string;
  linkdatei:               string;
  linkanlegen:             boolean;
  LinkText:                string;
  NeuName:                 string;
  OriginalVerzeichnis:     string ;
begin
  Linktext:='';
  dropname:=extractfilename(DropDatei);
  if pos(' ',dropname) > 0 then
  begin
       if YesBox('Der Dateiname enthält ein Leerzeichen. Der Verweis wird nicht funktionieren. Soll das korrigiert werden?') then
       begin
            NeuName:= extractfilepath(Dropdatei)
                      + slash(os)
                      + stringreplace(DropName,' ','_',[rfreplaceall]);
            copyFile(Dropdatei,NeuName);
            if fileexists(neuname) then
            begin
                 deletefileplus(Dropdatei);
                 DropDatei:=Neuname;

            end;
       end;
  end ;
  linkanlegen:=false;
  OriginalVerzeichnis:=extractfilepath(DropDatei);
  FileDir:=DBDirectory + 'files' + slash(os);
  if pos(FileDir,OriginalVerzeichnis)=1 then //Die Datei liegt in
                                                       //Files oder einem
                                                       //Unterverzeichnis
  begin
       Linktext:= 'file://' +
                  copy(originalverzeichnis,length(FileDir)+1,1000) +
                  extractfilename(Dropdatei);
       LinkAnlegen:=true;
  end;

  if linktext='' then //Die Datei ist nicht im Unterverzeichnis /files
  begin
       Auswahl:=0;
       LinkDatei :=  FileDir + extractfilename(Dropdatei);


       if getkeystate(VK_SHIFT) < 0 then Auswahl:=2;
                                 //SHIFT im anderen Programm gedrückt --> verschieben
                                 //Wird in Linux nicht erkannt

       if os='linux' then  auswahl:=2;  //Ich stelle es auf verschieben ein.

       if Auswahl=0 then Auswahl := QuestionDlg( 'Achtung',
                               'Die Datei befindet sich nicht im /files - Unterverzeichnis' + #13 ,
                               mtCustom, [1, 'Kopie anlegen', 2, 'verschieben', 3, 'abbrechen'], 0) ;

         //Die Datei soll kopiert werden
         If Auswahl=1 then
         begin
              if fileexists(Linkdatei) then
              begin
                   showmsg('Diese Datei (eine Datei dieses Namens) existiert bereits');
                   Linkanlegen:=true;
              end else begin
                   copyFile(Dropdatei,Linkdatei);
                   if fileexists(Linkdatei) then LinkAnlegen:=true;
              end;
         end;

         //Die Datei soll verschoben werden
         If Auswahl=2 then
         begin
              if fileexists(Linkdatei) then
              begin
                   showmsg('Diese Datei (eine Datei dieses Namens) existiert bereits');
                   if fileexists(Linkdatei) then LinkAnlegen:=true;
              end else begin
                   copyFile(Dropdatei,Linkdatei);
                   machpause();
                   if fileexists(Linkdatei) then  deletefileplus(Dropdatei);
                   if fileexists(Linkdatei) then LinkAnlegen:=true;
              end;
         end;

  end else begin  //die Datei befindet sich bereits im Unterverzeichnis "files"
      LinkAnlegen:=true;
  end;

  if LinkAnlegen then   //Die Datei wird in //file abgelegt. Will man ein
                        //anderes Verzeichnis, muss man das händisch tun.
  begin
       if Linktext=''  then Linktext:= 'file://' + extractfilename(Dropdatei)+ ' ';

       Fenster.Feldinhalt.ReadOnly:=false; //Muss aktiv sein, damit eingefügt
                                           //werden kann


       paste(linktext);


       If AngezeigterTyp='N' then
       begin
           Daten[AktuelleNotizenArrayZeile,Spalte_Anmerkung]:=utf8encode(Fenster.FeldInhalt.text) ;
           Daten[AktuelleNotizenArrayZeile,Spalte_Bearbeitungsdatum]:=formatdatetime('yyyymmddhhnn', now);
           Daten[AktuelleNotizenArrayZeile,Spalte_Position]:=inttostr(Cursorposition);
           ichanged:=true;
           IneedsSorting:=true;
       end;
       if AngezeigterTyp='L' then
       begin
             Literatur[AktuelleLiteraturArrayZeile,Spalte_Anmerkung]:=utf8encode(Fenster.FeldInhalt.text);
             Literatur[AktuelleLiteraturArrayZeile,Spalte_Bearbeitungsdatum]:=formatdatetime('yyyymmddhhnn', now);
             Literatur[AktuelleLiteraturArrayZeile,Spalte_Position]:=inttostr(Cursorposition);
             lchanged:=true;
             LneedsSorting:=true;
       end;
       Fenster.timer.enabled:=true;
       machpause();
  end;
end;





function Gliederungspeichern(fname:string):boolean;
var
   speichern:boolean;
   alt,SeiteNeu:integer;
begin
     speichern:=false;
     if fileexists(fname) then
     begin
          fenster.memozwischenablage.lines.loadfromfile(fname);
          machpause();
          alt:=fenster.memozwischenablage.lines.count;
          SeiteNeu:=fenster.gliederung.items.count;
          if abs(alt-SeiteNeu) < 50 then speichern:=true; //bei größeren Unterschieden ist irgendetwas faul
     end else begin
         speichern:=true;
     end;

     if speichern then
     begin
         try
            Fenster.Gliederung.savetoFile(fname);
         except
            busy() ;
            Fenster.Gliederung.savetoFile(fname);
         end;
     end;




     result:=true;
end;

function xmlLiteraturzeileformatieren(zeile,spalte:integer;name:string):string;
begin
  result:='';
  if Literatur[zeile,spalte]<>'' then
  begin
      result:='<' + name + '>' + Literatur[Zeile,Spalte] + '</' + name + '>'
  end;
end;
function schreibReferDB(was:string):boolean;
 var
    au:string;
    i:integer;
    von,bis : integer;

   output:textfile;
   outputfilename:string;
   zeile:string;
 begin
    if was='alle' then
    begin
        von:=1;
        bis:=  GetTopEmptyRow('Literatur');
    end else begin
        von:=AktuelleLiteraturArrayZeile;
        bis:=von;
    end;
    screen.Cursor:=crhourglass;;
    outputfilename:= DBDirectory +  'literatur.ref' ;
    assignfile(output,outputfilename);
    rewrite(output);
    for i:=von to bis do
    begin
         if literatur[i,1]<> '' then
         begin
              //Publikationstyp
              zeile:='%0 Book';
              if literatur[i,Spalte_Publikationstyp]='Artikel' then zeile:='%0 Journal Article';
              if literatur[i,Spalte_Publikationstyp]='Sammelband' then zeile:='@inbook{';
              if literatur[i,Spalte_Publikationstyp]='Kapitel' then zeile:='%0 Book Section';
              if literatur[i,Spalte_Publikationstyp]='Webseite' then zeile:='%0 Web Page';
              writeln(output, Zeile);

              //Autorfeld
              zeile:=literatur[i,Spalte_Autor];
              while pos(';',zeile) > 0 do   //mehrere Autoren
              begin
                 au:=copy(zeile,1,pos(';',zeile)-1);
                 zeile:=copy(zeile,pos(';',zeile)+1,1000) ;
                 zeile:=trim(zeile);
                 writeln(output,'%A ' +  au)
              end;
              writeln(output,'%A ' +  Zeile);

              if Literatur[i,Spalte_Jahr] <> '' then  writeln(output,'%D ' + Literatur[i,Spalte_Jahr]);
              if Literatur[i,Spalte_Titel] <> '' then  writeln(output,'%T ' + Literatur[i,Spalte_Titel]);   //Titel
              if Literatur[i,Spalte_Zeitschrift] <> '' then  writeln(output,'%J ' + Literatur[i,Spalte_Zeitschrift]);   //Zeitschrift
              if Literatur[i,Spalte_Band] <> '' then  writeln(output,'%V ' + Literatur[i,Spalte_Band]);
              if Literatur[i,Spalte_Nummer] <> '' then  writeln(output,'%N ' + Literatur[i,Spalte_Nummer]);
              if Literatur[i,Spalte_Seiten] <> '' then  writeln(output,'%P ' + Literatur[i,Spalte_Seiten]);


              //Herausgeberfeld
              if Literatur[i,Spalte_Herausgeber] <> '' then
              begin
                   zeile:=literatur[i,Spalte_Herausgeber];
                   while pos(';',zeile) > 0 do   //mehrere Autoren
                   begin
                        au:=copy(zeile,1,pos(';',zeile)-1);
                        zeile:=copy(zeile,pos(';',zeile)+1,1000) ;
                        zeile:=trim(zeile);
                        writeln(output,'%E ' +  au)
                   end;
                   writeln(output,'%E ' +  Zeile)
              end;


              if Literatur[i,Spalte_Sammelband] <> '' then  writeln(output,'%B ' + Literatur[i,Spalte_Sammelband]);  //Sammelband
              if Literatur[i,Spalte_Verlag] <> '' then  writeln(output,'%I ' + Literatur[i,Spalte_Verlag]);       //Verlag
              if Literatur[i,Spalte_Ort] <> '' then  writeln(output,'%C ' + Literatur[i,Spalte_Ort]);       //Ort

              writeln(output,'');
         end;
    end;
    closefile(output);
    if von=bis then  //nur ein Datensatz --> kopieren in die Zwischenablage
    begin
      Fenster.Memozwischenablage.lines.loadfromfile(outputfilename);
      machpause();
      Clipboard.AsText:= Fenster.memozwischenablage.lines.text;
      nachricht('Refer - Snippet in die Zwischenablage kopiert',1);

    end;
    machpause();
    screen.cursor:=crdefault;
    result:=true;



end;
function schreibRISDB():boolean;
var
  Anzahl:integer;
  AU:string;
  input,output:textfile;
  inputfilename,outputfilename:string;


  zeile:string;
begin
   screen.Cursor:=crhourglass;;

   inputfilename:=DBDirectory +  'literatur.xml' ;
   outputfilename:= DBDirectory +  'literatur.ris' ;
   assignfile(input,inputfilename);
   assignfile(output,outputfilename);
   reset(input);
   rewrite(output);


   Anzahl:=0;
   while not (eof(input)) do
   begin
        readln(input,zeile);
        if (pos('<',zeile)=0) and (length(zeile)>2) then     //Zeile ohne Feldbezeichnung
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'      ' +  Zeile)
        end;

        if pos('<Typ>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            if zeile='' then Zeile:='BOOK';
            if zeile='Buch' then Zeile:='BOOK';
            if zeile='Artikel' then Zeile:='JOUR';
            if zeile='Kapitel' then Zeile:='CHAP';
            if zeile='Webseite' then Zeile:='ELEC';
            writeln(output,'TY  - ' +  Zeile)
        end;

        if pos('<Autor>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            while pos(';',zeile) > 0 do   //mehrere Autoren
            begin
                 au:=copy(zeile,1,pos(';',zeile)-1);
                 zeile:=copy(zeile,pos(';',zeile)+1,1000) ;
                 zeile:=trim(zeile);
                 writeln(output,'AU  - ' +  au)
            end;
            writeln(output,'AU  - ' +  Zeile)
        end;

        if pos('<Jahr>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'PY  - ' +  Zeile)
        end;

        if pos('<Titel>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'TI  - ' +  Zeile)
        end;

        if pos('<Datum>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'Y1  - ' +  Zeile)
        end;

        if pos('<Seiten>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'SP  - ' +  Zeile)
        end;

        if pos('<Zeitschrift>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'JO  - ' +  Zeile)
        end;

        if pos('<Herausgeber>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            while pos(';',zeile) > 0 do   //mehrere Herausgeber
            begin
                 au:=copy(zeile,1,pos(';',zeile)-1);
                 zeile:=copy(zeile,pos(';',zeile)+1,1000) ;
                 zeile:=trim(zeile);
                 writeln(output,'ED  - ' +  au)
            end;
            writeln(output,'ED  - ' +  Zeile)
        end;



        if pos('<Sammelband>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'T2  - ' +  Zeile)
        end;

        if pos('<Band>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'VL  - ' +  Zeile)
        end;

        if pos('<Nummer>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'IS  - ' +  Zeile)
        end;

        if pos('<Ort>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'CY  - ' +  Zeile)
        end;

        if pos('<Verlag>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'PB  - ' +  Zeile)
        end;

        if pos('<Anmerkung>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'N2  - ' +  Zeile)
        end;

        if pos('<ISBN>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'SN  - ' +  Zeile)
        end;


        if pos('</Quelle>',zeile)=1 then
        begin
             writeln(output,'ER  - ' ) ;
             writeln(output,'') ;
             Anzahl:=anzahl+1;
        end;



        machpause();
   end;



   closefile(input);
   closefile(output);
   machpause();
   screen.cursor:=crdefault;
   result:=true;
end;

function schreibWordDB():boolean;
var
  Anzahl:integer;
  AU:string;
  input,output:textfile;
  inputfilename,outputfilename:string;
  NewGUID: TGUID;
  ptyp:string;
  WordXMLPfad:string;
  zeile:string;
begin
   screen.Cursor:=crhourglass;

   //Dateipfade festlegen
   WordXMLPfad:=DBDirectory;
   {$IFDEF WINDOWS}  WordXMLPfad:=GetWindowsSpecialDir(CSIDL_APPDATA) + 'Microsoft\Bibliography\';{$ENDIF}
   inputfilename:=DBDirectory +  'literatur.xml' ;
   outputfilename:= WordXMLPfad +  'bx_db.xml' ;
   assignfile(input,inputfilename);
   assignfile(output,outputfilename);
   reset(input);
   rewrite(output);

   //Den Kopf der Word - XML-Datenbank schreiben
   writeln(output, '<?xml version="1.0" encoding="UTF-8" standalone="no"?>');
   writeln(output, '<b:Sources SelectedStyle="" xmlns:b="http://schemas.openxmlformats.org/officeDocument/2006/bibliography" xmlns="http://schemas.openxmlformats.org/officeDocument/2006/bibliography">');

   Anzahl:=0;
   //while not (eof(input)) do
   while  (Anzahl < 200) do
   begin
        readln(input,zeile);

        if pos('<Quelle>',zeile)=1 then
        begin
             Anzahl:=anzahl+1;
             writeln(output, '<b:Source>'  );
             writeln(output, '<b:Tag>' + 'Bx' + inttostr(Anzahl) + '</b:Tag>'  );
             CreateGUID(NewGUID);
             writeln(output,'<b:Guid>'+GUIDToString(NewGUID)+'</b:Guid>');

        end;
        if pos('</Quelle>',zeile)=1 then writeln(output, '</b:Source>'  );

        if pos('<Typ>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            ptyp:='Book';
            if zeile='Buch' then ptyp:='Book';
            if zeile='Artikel' then ptyp:='JournalArticle';

            writeln(output, '<b:SourceType>' + ptyp + '</b:SourceType>') ;

        end;

        if pos('<Jahr>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'<b:Year>' +  Zeile + '</b:Year>')
        end;

        if pos('<Titel>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'<b:Title>' +  Zeile +'</b:Title>'  );
        end;

        if pos('<Ort>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'<b:City>' +  Zeile+ '</b:City>');
        end;

        if pos('<Verlag>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'<b:Publisher>' +  Zeile +'</b:Publisher>' )
        end;

        if pos('<Autor>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'<b:Author><b:Author>');
            writeln(output,'<b:NameList>');
            while pos(';',zeile) > 0 do   //mehrere Autoren
            begin
                 au:=copy(zeile,1,pos(';',zeile)-1);
                 zeile:=copy(zeile,pos(';',zeile)+1,1000) ;
                 zeile:=trim(zeile);
                 writeln(output,'<b:Person>');
                 writeln(output,'<b:Last>' + Nachname(AU) + '</b:Last>');
                 writeln(output,'<b:First>' + Nachname(AU) + '</b:First>');
                 writeln(output,'</b:Person>');
            end;
            writeln(output,'<b:Person>');
            writeln(output,'<b:Last>' + Nachname(Zeile) + '</b:Last>');
            writeln(output,'<b:First>' + Vorname(Zeile) + '</b:First>');
            writeln(output,'</b:Person>');
            writeln(output,'</b:NameList>');
            writeln(output,'</b:Author></b:Author>');

           // writeln(output,'AU  - ' +  Zeile)
        end;

        if pos('<Zeitschrift>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'<b:JournalName>' +  Zeile +'</b:JournalName>' );
            //writeln(output,'<b:Month>12</b:Month><b:Day>24</b:Day> ' )   ; //Versuch

        end;

        if pos('<Seiten>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'<b:Pages>' +  Zeile +'</b:Pages>' )
        end;

        if pos('<Band>',zeile)=1 then
        begin
            zeile:= xmleinlesen(zeile) ;
            writeln(output,'<b:Volume>' +  Zeile +'</b:Volume>' )
        end;






        machpause();
   end;

   //Die Word-XML-Datei beenden
   writeln(output, '</b:Source>'  );   //? Muss ich?
   writeln(output,'</b:Sources>' ) ;


   closefile(input);
   closefile(output);
   machpause();
   screen.cursor:=crdefault;
   result:=true;
end;



function SaveSingleRecordInWordXML():boolean ;

var
   au:string;
   i:integer;
   zeile:string;
   output:textfile;
   outputfilename:string;
   NewGUID: TGUID;
   ptyp:string;
   WordXMLPfad:string;

begin
    i:=AktuelleLIteraturArrayZeile ;
    //Dateipfade festlegen
    WordXMLPfad:=DBDirectory;
    {$IFDEF WINDOWS}  WordXMLPfad:=GetWindowsSpecialDir(CSIDL_APPDATA) + 'Microsoft\Bibliography\';{$ENDIF}
    outputfilename:= WordXMLPfad +  'bx_' + Literatur[i,Spalte_Erstautor] + '.xml' ; //Erstautor
    assignfile(output,outputfilename);
    rewrite(output);

    //Den Kopf der Word - XML-Datenbank schreiben
    writeln(output, '<?xml version="1.0" encoding="UTF-8" standalone="no"?>');
    writeln(output, '<b:Sources SelectedStyle="" xmlns:b="http://schemas.openxmlformats.org/officeDocument/2006/bibliography" xmlns="http://schemas.openxmlformats.org/officeDocument/2006/bibliography">');
    writeln(output, '<b:Source>'  );
    writeln(output, '<b:Tag>' + Literatur[i,Spalte_Erstautor] + Literatur[i,1]  + '</b:Tag>'  );
    CreateGUID(NewGUID);
    writeln(output,'<b:Guid>'+GUIDToString(NewGUID)+'</b:Guid>');

    ptyp:='Book';
    if Literatur[i,Spalte_Publikationstyp] = 'Artikel' then ptyp:='JournalArticle';
    writeln(output, '<b:SourceType>' + ptyp + '</b:SourceType>') ;


    zeile:= Literatur[i,Spalte_Autor] ;
    if length(zeile)> 2 then
    begin
            writeln(output,'<b:Author><b:Author>');
            writeln(output,'<b:NameList>');
            while pos(';',zeile) > 0 do   //mehrere Autoren
            begin
                 au:=copy(zeile,1,pos(';',zeile)-1);
                 zeile:=copy(zeile,pos(';',zeile)+1,1000) ;
                 zeile:=trim(zeile);
                 writeln(output,'<b:Person>');
                 writeln(output,'<b:Last>' + Nachname(AU) + '</b:Last>');
                 writeln(output,'<b:First>' + Nachname(AU) + '</b:First>');
                 writeln(output,'</b:Person>');
            end;
            writeln(output,'<b:Person>');
            writeln(output,'<b:Last>' + Nachname(Zeile) + '</b:Last>');
            writeln(output,'<b:First>' + Vorname(Zeile) + '</b:First>');
            writeln(output,'</b:Person>');
            writeln(output,'</b:NameList>');
            writeln(output,'</b:Author></b:Author>');
    end;


    if Literatur[i,Spalte_Jahr] <> '' then  writeln(output,'<b:Year>' +  Literatur[i,Spalte_Jahr] + '</b:Year>');
    if Literatur[i,Spalte_Titel] <> '' then writeln(output,'<b:Title>' +  Literatur[i,Spalte_Titel]  +'</b:Title>'  );
    if Literatur[i,Spalte_Zeitschrift] <> '' then writeln(output,'<b:JournalName>' +  Literatur[i,Spalte_Zeitschrift] +'</b:JournalName>' );
    if Literatur[i,Spalte_Band] <> '' then writeln(output,'<b:Volume>' +  Literatur[i,Spalte_Band] +'</b:Volume>') ;
    if Literatur[i,Spalte_Seiten] <> '' then writeln(output,'<b:Pages>' +  Literatur[i,Spalte_Seiten] +'</b:Pages>' ) ;

  if Literatur[i,Spalte_Herausgeber] = 'asdfasdf4t' then
  begin
      zeile:= Literatur[i,Spalte_Herausgeber];
       while pos(';',zeile) > 0 do   //mehrere Autoren
       begin
            au:=copy(zeile,1,pos(';',zeile)-1);
            zeile:=copy(zeile,pos(';',zeile)+1,1000) ;
            zeile:=trim(zeile);

       end;

  end;
  if Literatur[i,Spalte_Verlag] <> '' then writeln(output,'<b:Publisher>' +  Literatur[i,Spalte_Verlag] +'</b:Publisher>' ) ;
  if Literatur[i,Spalte_Ort] <> '' then  writeln(output,'<b:City>' +  Literatur[i,Spalte_Ort] + '</b:City>');

     //Die Word-XML-Datei beenden
   writeln(output, '</b:Source>'  );
   writeln(output,'</b:Sources>' ) ;

   closefile(output);
  nachricht('Word XML Datei erstellt',1);
end;

function schreibBibTeXDB(was:string):boolean;
var
  i:integer;
  von,bis : integer;

  output:textfile;
  outputfilename:string;
  zeile:string;
begin
   if was='alle' then
   begin
       von:=1;
       bis:=  GetTopEmptyRow('Literatur');
   end else begin
       von:=AktuelleLiteraturArrayZeile;
       bis:=von;
   end;
   screen.Cursor:=crhourglass;;
   outputfilename:= DBDirectory +  'literatur.bib' ;
   assignfile(output,outputfilename);
   rewrite(output);
   for i:=von to bis do
   begin
        if literatur[i,1]<> '' then
        begin
             zeile:='@'+literatur[i,Spalte_Publikationstyp]+'{';
             if literatur[i,Spalte_Publikationstyp]='Artikel' then zeile:='@article{';
             if literatur[i,Spalte_Publikationstyp]='Sammelband' then zeile:='@inbook{';
             if literatur[i,Spalte_Publikationstyp]='Kapitel' then zeile:='@incollection{';
             if literatur[i,Spalte_Publikationstyp]='Artikel' then zeile:='@article{';
             if literatur[i,Spalte_Publikationstyp]='Buch' then zeile:='@book{';
             if length(zeile)< 5 then zeile:='@book{';
             zeile:=zeile+literatur[i,Spalte_Erstautor]+literatur[i,Spalte_Jahr]+'-' + literatur[i,1];
             zeile:= stringreplace(zeile, ' ', '', [rfreplaceall]);
             writeln(output,'');
             writeln(output,zeile + ',');
             //Autorfeld
             zeile:=literatur[i,Spalte_Autor];
             zeile:='author    = {'+ FormatiereNamen(zeile, 'George A. Akerlof', ' and ', ' and ', 'false', '', 'true') + '},';
             writeln(output,zeile);
             if Literatur[i,Spalte_Jahr] <> '' then  writeln(output,'year      = {' + Literatur[i,Spalte_Jahr] + '},');
             if Literatur[i,Spalte_Publikationsdatum] <> '' then  writeln(output,'month     = {' + Literatur[i,Spalte_Publikationsdatum] + '},');
             if Literatur[i,Spalte_Titel] <> '' then  writeln(output,'title     = {' + Literatur[i,Spalte_Titel] + '},');   //  Untertitel. gibt es nicht
             if Literatur[i,Spalte_Zeitschrift] <> '' then  writeln(output,'journal   = {' + Literatur[i,Spalte_Zeitschrift] + '},');
             if Literatur[i,Spalte_Band] <> '' then  writeln(output,'volume    = {' + Literatur[i,Spalte_Band] + '},');
             if Literatur[i,Spalte_Nummer] <> '' then  writeln(output,'number    = {' + Literatur[i,Spalte_Nummer] + '},');
             if Literatur[i,Spalte_Seiten] <> '' then  writeln(output,'pages     = {' + Literatur[i,Spalte_Seiten] + '},');
             //Herausgeberfeld
             if Literatur[i,Spalte_Herausgeber] <> '' then
             begin
                  zeile:=literatur[i,Spalte_Herausgeber];
                  zeile:='editor    = {'+ FormatiereNamen(zeile, 'George A. Akerlof', ' and ', ' and ', 'false', '', 'true') + '},';
                  writeln(output,zeile);
             end;
             if Literatur[i,13] <> '' then  writeln(output,'series    = {' + Literatur[i,13] + '},');
             if Literatur[i,Spalte_Verlag] <> '' then  writeln(output,'publisher = {' + Literatur[i,Spalte_Verlag] + '},');
             if Literatur[i,Spalte_Ort] <> '' then  writeln(output,'address   = {' + Literatur[i,Spalte_Ort] + '},');
             if Literatur[i,Spalte_Auflage] <> '' then  writeln(output,'edition   = {' + Literatur[i,Spalte_Auflage] + '},');
             if Literatur[i,Spalte_ISBN] <> '' then  writeln(output,'isbn      = {' + Literatur[i,Spalte_ISBN] + '},');
             writeln(output,'}');
        end;
   end;
   closefile(output);
   if von=bis then  //nur ein Datensatz --> kopieren in die Zwischenablage
   begin
     Fenster.Memozwischenablage.lines.loadfromfile(outputfilename);
     machpause();
     Clipboard.AsText:= Fenster.memozwischenablage.lines.text;
     nachricht('BibTeX - Snippet in die Zwischenablage kopiert',1);

   end;
   machpause();
   screen.cursor:=crdefault;
   result:=true;
end;
function DatenArrayKomplettSichern():boolean;
var
   i:integer;
   str:Tstringlist;
begin
     str:=Tstringlist.Create;
     with fenster do
     begin
     str.Add('<?xml version="1.0"?>');
     str.Add('<version>6</version>');
     str.Add('<datensatzzahl>' + inttostr(GetNumberOfRecords('daten')) + '</datensatzzahl>');
     str.Add('<daten>');
    for i := 1 to ArraySize_Daten  do
    begin
      if Daten[i, Spalte_ID] <> '' then
      begin
        str.Add('<karte>');
        str.Add('<nummer>' + daten[i, Spalte_ID] + '</nummer>');
        if length(daten[i,Spalte_Bearbeitungsdatum])< 10  then daten[i,Spalte_Bearbeitungsdatum]:='190001010101';
        str.Add('<datum>' + daten[i, Spalte_Bearbeitungsdatum] + '</datum>');
        str.Add('<titel>' + trim(daten[i, Spalte_Titel]) + '</titel>');
        str.Add('<inhalt>' + trim(daten[i,Spalte_Anmerkung]) + ' </inhalt>');

        if daten[i,Spalte_Bearbeitungszahl]<>'' then str.Add('<bearbeitungen>' + daten[i, Spalte_Bearbeitungszahl] + '</bearbeitungen>');
        if daten[i,Spalte_Erstelldatum]<>''then  str.Add('<erstellt>' + daten[i, Spalte_Erstelldatum] + '</erstellt>');
        str.Add('</karte>');
      end;
    end;
    str.Add('</daten>');
    machpause();
    try
       str.Savetofile(IdeenDatenbank);
    except
       str.Savetofile(IdeenDatenbank);
    end;


    machpause();
    str.free;
    result:=true;
    end;
end;



//-------------- Ende Funktionen, die Literaturdaten abspeichern -------------//




//-------------- Funktionen, die Zitierrichtlinien bearbeiten -------------//
{
function AkerlofBeispielZeigen():string;               1x
function RichtlinieLaden(d:string):boolean;            2x
}
function AkerlofBeispielZeigen():string;
var
  j:integer;
begin
    for j:=1 to Spalte_Ende do LiteraturZeile[j]:='';
    Literaturzeile[Spalte_Publikationstyp]:='Artikel';
    Literaturzeile[Spalte_Autor]:='Akerlof, George A.';
    Literaturzeile[Spalte_Titel]:='The Market for Lemons';
    Literaturzeile[Spalte_Zeitschrift]:='Quarterly Journal of Eoconomics';
    Literaturzeile[Spalte_Jahr]:='1970';
    Literaturzeile[Spalte_Seiten]:='488-500';
    Literaturzeile[Spalte_Band]:='84';
    Literaturzeile[Spalte_Nummer]:='3';
    result:=(QuelleInRTFFormatieren(false));
end;
function RichtlinieLaden(d:string):boolean;
var
  datei:textfile;
  i,j,k:integer;
begin
     assignfile(datei,d);
     reset(datei);
     for i:=1 to 5 do
         for j:=1 to 4 do
              for k:= 1 to 10 do
                  readln(Datei,Richtlinie[i,j,k]);
     closefile(datei);
     result:=true;
end;
//-------------- Ende Funktionen, die Zitierrichtlinien bearbeiten -------------//
//
//
//
// -------------- Funktionen für Einstellungen der Oberfläche -----------------//
{

function SchlagwortCheckboxes(volltext:string):boolean  ;




function MonitorCheck():boolean;

Procedure subErstelleFormularImage(Formular: TForm; out Bitmap: TBitmap);
function MakeScreenshot():boolean  ;
function HintergrundBild(img:timage):boolean ;

function ChangeFontSize(wert:integer):boolean;
function getback():boolean;


function FensterKoordinatenspeichern(os: string): boolean;
function bestimmespalte():integer;

}







function ChangeFontSize(wert:integer):boolean;
begin
     with fenster do
     begin
          if (Wert >=8) and (wert <=14) then
          begin
              Liste.Font.size:=wert;
              setintegerini('listefontsize', wert);
              Gliederung.Font.Size:=wert;
              Gliederung.invalidate;
              resizewindow();
          end;
          Feldinhalt.ZoomFactor:=1; //sonst skaliert das Objekt evtl. mit
     end;
     result:=true;
end;
function getback():boolean;
begin
      fenster.Registerkarten.Activepage:=fenster.IdeenSeite  ;
      result:=true;
end;


// -------------- Ende Funktionen für Einstellungen der Oberfläche -----------------//




//------------------------------------------------------------
//------------- Funktionen, die Daten suchen -----------------
//------------------------------------------------------------
{
function AutoComplete(feld,t:string):boolean  ;
function suchbegriffe(txt:string):boolean;
function holzahldernotizen():integer;
function holzahlderquellen():integer;
function TrefferzahlAnzeigen():boolean;

function SearchRISDB(suchtext:string):boolean ;


function HolArrayZeileDerLiteraturID(id:string):integer;
function HolIdeenIDdesTitels(titel:string):string;

function ZeigeTreeviewItemInListe(titel:string):boolean;
}
function ZeigeTreeviewItemInListe(titel:string):boolean;  //20.11.2020 erstellt
//Den angeklickten Datensatz in die oberste Zeile der Trefferliste aufnehmen.
var
   i,j:                integer;
   ZeileDerID:         integer;
   ZeileInDerListe:integer;
   TrArray:array[1..TrefferArraySpalteVolltext]  of string;

begin
    //Gibt es den in der Gliederung angeklickten Datensatz schon in der Liste / im Trefferarray?
    ZeileInDerListe:=Fenster.Liste.Rowcount +1 ;

    For i:=0 to Fenster.Liste.Rowcount do
    begin
         if (Trefferarray[i,4]=AktuelleNotizID) and (AngezeigterTyp='N')
            then ZeileInDerListe:=i;
         if (Trefferarray[i,4]=AktuelleLIteraturID) and (AngezeigterTyp='L')
            then ZeileInDerListe:=i;
    end;


    if ZeileInDerListe <=Fenster.Liste.Rowcount then //Der Gliederungspunkt ist schon in der Liste
    begin
        for j:=1 to TrefferArraySpalteVolltext do TRarray[j]:=Trefferarray[ZeileInDerListe,j] ;
        //Den obersten Datensatz freiräumen und die
        //anderen Einträge eine zeile nach unten verschieben
        for i:=ZeileInDerListe -1  downto 0 do
        begin
             for j:=1 to 7 do TrefferArray[i+1,j] := TrefferArray[i,j];
             Fenster.Liste.Cells[ListeSpalteTitel, i+1] := Trefferarray[i+1,TrefferArraySpalteTitel]  ;
        end;

        //Die erste Zeile Anpassen und den Gliederungspunkt eintragen
        for j:=1 to TrefferArraySpalteVolltext do TrefferArray[0,j] :=TrArray[j];

        Fenster.Liste.Cells[ListeSpalteTitel, 0]:= Trefferarray[0,TrefferArraySpalteTitel];

    end else begin //Der Gliederungspunkt ist noch nicht in der Liste
        //Die gesamte Liste um einen Eintrag nach unten verschieben
        Fenster.Liste.rowcount:=Fenster.Liste.Rowcount+1;
        for i:=Fenster.Liste.Rowcount-2  downto 0 do
        begin
             for j:=1 to 7 do TrefferArray[i+1,j] := TrefferArray[i,j];
             Fenster.Liste.Cells[ListeSpalteTitel, i+1] := Trefferarray[i+1,TrefferArraySpalteTitel]  ;
        end;

        //die erste Zeile leeren
        for j:=1 to TrefferArraySpalteVolltext do TrefferArray[0,j] :='';



        //Den TrefferArray mit dem neuen Datensatz füllen
        TrefferArray[0,3]:=AngezeigterTyp ;

        if (AngezeigterTyp='L') then
        begin
             TrefferArray[0,4]:=AktuelleLIteraturID ;
             ZeileDerID:=HolArrayZeileDerLiteraturID(AktuelleLiteraturID);
             Titel:= Literatur[ZeileDerID,Spalte_Erstautor] + ' (' +
                     Literatur[ZeileDerID,Spalte_Jahr] + ') ' +
                     Literatur[ZeileDerID,Spalte_Titel] ;
             TrefferArray[0,TrefferArraySpalteTitel]:=Titel ;
             Trefferarray[0,7]:=deletelastword(
                                  copy(Literatur[ZeileDerID,Spalte_Anmerkung],1,1000)) ;
        end;
        if (AngezeigterTyp='N') then
        begin
             TrefferArray[0,4]:=AktuelleNotizID ;
             TrefferArray[0,TrefferArraySpalteTitel]:=Titel ;
        end;
        Fenster.Liste.Cells[ListeSpalteTitel, 0]:=titel;
    end;
    //die Treffer durchnumerieren 12/2025 rausgeworfen
    {
    j:=0;
    for i:=0 to Fenster.Liste.Rowcount -1  do
    begin
       if (Trefferarray[i,2]<>'#') and (Trefferarray[i,4]<>'') then
       begin
            j:=j+1;
            Fenster.Liste.Cells[ListeSpalteNummer,i]:=inttostr(j) + '.';
       end;
    end;
    }
    Fenster.Liste.Invalidate;
    Fenster.Liste.Row:=0;   //die erste Zeile belegen
end;

function HolIdeenIDdesTitels(titel:string):string;
var
  i: integer;
begin
  Result := '';
  for i :=  1 to ArraySize_Daten do
    if daten[i, Spalte_Titel] = titel then
    begin
      Result := daten[i, Spalte_ID];
      break;
    end;
end;



function FindeAndereZitate(zitat:string):boolean ;


begin

end;

function suchbegriffe(txt:string):boolean;
begin
     //bis und ab
     bis:='';
     if pos('<',txt) > 0 then
     begin
       bis:=copy(txt,pos('<',txt)+1, 100);
       bis:=getfirstword(ansilowercase(bis));

       txt:=stringreplace(txt,bis,' ',[rfreplaceall]) ;
       txt:=stringreplace(txt,'<',' ',[rfreplaceall]) ;
     end;
     ab:='';
     if pos('>',txt) > 0 then
     begin
       ab:=copy(txt,pos('>',txt)+1, 100);
       ab:=getfirstword(ansilowercase(ab));
       txt:=stringreplace(txt,ab,' ',[rfreplaceall]);
       txt:=stringreplace(txt,'>',' ',[rfreplaceall]) ;
     end;
     //die globalen Variablen
     s1:=trim(txt);
     s2:='';
     s3:='';
     s4:='';
     s5:='';
     MinusBegriff1:='';
     MinusBegriff2:='';
     if pos(' ',s1) > 0 then //es gibt zwei Begriffe oder mehr
     begin
          s2:=copy(s1,pos(' ',s1)+1,100);
          s1:=copy(s1,1,pos(' ',s1)-1);
          s1:=trim(s1);
          s2:=trim(s2);
     end;
     if pos(' ',s2) > 0 then //es gibt drei Begriffe oder mehr
     begin
          s3:=copy(s2,pos(' ',s2)+1,100);
          s2:=copy(s2,1,pos(' ',s2)-1);
          s2:=trim(s2);
          s3:=trim(s3);
     end;
     if pos(' ',s3) > 0 then
     begin
          s4:=copy(s3,pos(' ',s3)+1,100);
          s3:=copy(s3,1,pos(' ',s3)-1);
          s4:=trim(s4);
          s3:=trim(s3);
     end;
     if pos(' ',s4) > 0 then
     begin
          s5:=copy(s4,pos(' ',s4)+1,100);
          s4:=copy(s4,1,pos(' ',s4)-1);
          s4:=trim(s4);
          s5:=trim(s5);
     end;
     if pos(' ',s5) > 0 then
     begin
          s5:=copy(s5,1,pos(' ',s5)-1);
          s5:=trim(s5);
     end;
     if s2='' then s2:=s1;
     if s3='' then s3:=s1;
     if s4='' then s4:=s1;
     if s5='' then s5:=s1;
                          {11/2019: das ist eigentlich ineffizient, weil bei einem/zwei/drei Begriffen
                           trotzdem alle vier geprüft werden. Der Geschwindigkeitsvorteil einer differenzierteren
                           Suche liegt aber unter einer Millisekunde. Mit gettickcount gemessen.
                          }
     s1:=trim(s1);
     s2:=trim(s2);
     s3:=trim(s3);
     s4:=trim(s4);
     s5:=trim(s5);
     s1:=stringreplace(s1, '_', ' ', [rfreplaceall]);
     s2:=stringreplace(s2, '_', ' ', [rfreplaceall]);
     s3:=stringreplace(s3, '_', ' ', [rfreplaceall]);
     s4:=stringreplace(s4, '_', ' ', [rfreplaceall]);
     s5:=stringreplace(s5, '_', ' ', [rfreplaceall]);
     if pos('-',s2)=1 then
     begin
          MinusBegriff1:=copy(s2,2,100);
          s2:=s1;
     end;
     if pos('-',s3)=1 then
     begin
          if MinusBegriff1=''
             then MinusBegriff1:=copy(s3,2,100)
             else MinusBegriff2:=copy(s3,2,100);
          s3:=s1;
     end;
     if pos('-',s4)=1 then
     begin
           if MinusBegriff1=''
              then MinusBegriff1:=copy(s4,2,100)
              else MinusBegriff2:=copy(s4,2,100);
          s4:=s1;
     end;
     result:=true;
end;
function holzahldernotizen():integer;
var
  i:integer;
begin
  result:=0;
  if fenster.sucheingabe.text ='' then //keine Suchanfrage. Alle Treffer
  begin
       result:=getNumberOfRecords('Daten');
  end else begin
       for i:=0 to maxanzeige do
       begin
            if Trefferarray[i,3]='N' then result:=result+1;
       end;

  end;
end;

function holzahlderquellen():integer;
var
  i:integer;
begin
  result:=0;
  if fenster.sucheingabe.text ='' then //keine Suchanfrage. Alle Treffer
  begin
      result:=getNumberOfRecords('Literatur');
  end else begin
     for i:=0 to Maxanzeige do
       begin
            if Trefferarray[i,3]='L' then result:=result+1
       end;
  end;
end;
function TrefferzahlAnzeigen():boolean;
var

  nz,qz:        integer;
  zahl:         string;
begin

   nz:= HolZahlDerNotizen();
   qz:= HolZahlDerQuellen();
   if abs(nz+qz - maxanzeige) < 3 then
   begin
        Zahl:= '> ' + inttostr(maxanzeige)
   end else begin
       Zahl:=inttostr(nz+qz) ;
       if length(zahl)> 3 then
          zahl:=   copy(zahl,1, length(zahl)-3) + '.'
                 + copy(zahl,length(zahl)-2,3);
   end;

   Fenster.LabelTrefferzahl.caption:=Zahl+ ' Notizen';





    result:=true;
end;
function SearchRISDB(suchtext:string):boolean ;

begin

end;


// Ende Funktionen, die Daten suchen





function UpdateBearbeitungszahl():boolean ;
var
   AktuelleStunde: integer; //string  ;
   LastChange:integer; //string;
begin

      AktuelleStunde:=str2int(formatdatetime('mmddhh', now));
      if AngezeigterTyp='N' then
      begin
           LastChange:=str2int(copy(Daten[AktuelleNotizenArrayZeile,Spalte_Bearbeitungsdatum],5,6));
           if AktuelleStunde-LastChange > 1 then
              Daten[AktuelleNotizenArrayZeile,Spalte_Bearbeitungszahl]:=
              inttostr(str2int(Daten[AktuelleNotizenArrayZeile,Spalte_Bearbeitungszahl])+1);
      end;
      if AngezeigterTyp='L' then
      begin
          LastChange:=str2int(copy(Literatur[AktuelleLiteraturArrayZeile,Spalte_Bearbeitungsdatum],5,6));
          if AktuelleStunde-LastChange > 1 then
             Literatur[AktuelleLiteraturArrayZeile,Spalte_Bearbeitungszahl]:=
                 inttostr(str2int(Literatur[AktuelleLiteraturArrayZeile,Spalte_Bearbeitungszahl])+1);
      end;

end;

function VergangeneZeitBerechnen(eingabe:string):string;
var
   JahrA,MonatA,TagA,StundeA,MinuteA:integer;
   Jahr, Monat, Tag, Stunde, Minute:integer;

   Differenz:integer;
   res:string;
begin
     vorJahren:=0;
     vorMonaten:=0;
     vorTagen:=0;
     vorStunden:=0;
     vorMinuten:=0;

     if Eingabe='' then
     begin
          Eingabe:='200001010101';  //2000.01.01.01.01
          VorJahren:=1;
     end;
     Jahra:=str2int(copy(eingabe,1,4));
     Monata:=str2int(copy(eingabe,5,2));
     Taga:=str2int(copy(eingabe,7,2));
     Stundea:=str2int(copy(eingabe,9,2));
     Minutea:=str2int(copy(eingabe,11,2));
     Jahr:= str2int(formatdatetime('yyyy',now));
     Monat:= str2int(formatdatetime('mm',now));
     Tag:= str2int(formatdatetime('dd',now));
     Stunde:= str2int(formatdatetime('hh',now));
     Minute:= str2int(formatdatetime('nn',now));

     if abs(jahr-jahra) > 0 then  //nicht im gleichen Jahr
     begin
          if abs(jahr-jahra) = 1 then  //im letzten Jahr
          begin
               if abs((monat+12)-monata) > 1 then  //vor mindestens einem Monat
               begin
                    vorMonaten:= abs((12+monat)-monata)
               end else begin //Dezember bis Januar
                   vortagen:= (tag + 31) - taga;
               end;
          end else begin
              vormonaten:=abs(jahr-jahra-1)*12; //ganze Jahre
              vorMonaten:= vormonaten + abs((12+monat)-monata)  ;
          end;

     end else begin //gleiches Jahr
         if abs(monat-monata) > 0 then  //vor mindestens einem Monat
         begin
              if abs(monat-monata) = 1 then
              begin
                   vortagen:= tag + (31-taga);
              end else begin
                  vormonaten := abs(monat-monata);
              end;
         end else begin //gleicher Monat
             if abs(tag-taga) > 0 then  //vor mindestens einem Tag
             begin
                  Differenz:= abs(tag-taga);
                  vortagen:=1;
            if differenz > 1  then vortagen:= Differenz;
            end else begin  // gleicher Tag
                if abs(Stunde-Stundea) > 1 then  //vor mindestens einer Stunde
                begin
                     if abs(Stunde-Stundea) = 2 then vorstunden:=1 else vorstunden:=abs(stunde-stundea);
                end else begin // < 120 Minuten oder weniger
                    vorminuten:=90;
                    if abs(Minute-Minutea) < 80 then vorminuten:=60;
                    if abs(Minute-Minutea) < 40 then vorminuten:=30;
                    if abs(Minute-Minutea) < 20 then vorminuten:=15;
                    if abs(Minute-Minutea) < 10 then vorminuten:=10;
                    if abs(Minute-Minutea) < 2 then vorminuten:=1;
                end;
            end;
         end;
     end;
     res:='unbekannt';
     if vorminuten =1 then res:='gerade eben';
     if vorminuten =10 then res:='vor wenigen Minuten';
     if vorminuten =15 then res:='vor einer Viertelstunde';
     if vorminuten =30 then res:='vor einer halben Stunde';
     if vorminuten =60 then res:='in der letzten Stunde';
     if vorstunden = 1 then res:='vor einer Stunde ';
     if vorstunden = 2 then res:='vor zwei Stunden';
     if vorstunden = 3 then res:='vor drei Stunden';
     if vorstunden > 3 then
     begin
          res:='heute Abend';
          if stundea < 18 then res:= 'heute Nachmittag';
          if stundea < 14 then res:= 'heute Mittag';
          if stundea < 12 then res:= 'heute Morgen';
          //Falls die Stunde fehlt...
          if stundea = 0 then res:='heute';
     end;
     if vortagen = 1 then
     begin
          res:='gestern Abend';
          if stundea < 18 then res:= 'gestern Nachmittag';
          if stundea < 14 then res:= 'gestern Mittag';
          if stundea < 12 then res:= 'gestern Morgen';
          //Falls die Stunde fehlt...
          if stundea = 0 then res:='gestern';
     end;
     if vortagen = 2 then res:='vorgestern';
     if vortagen = 3 then res:='vor drei Tagen';
     if vortagen > 3 then res:= 'vor einigen Tagen';
     if vortagen > 7 then res:= 'vor einer Woche';
     if vortagen > 14 then res:= 'vor zwei Wochen';
     if vortagen > 21 then res:= 'vor drei Wochen';
     if vortagen > 28 then res:= 'vor einem Monat';
     if vormonaten > 1 then res:= 'vor einigen Monaten';
     if vormonaten = 1 then res:='vor einem Monat';
     if vormonaten = 2 then res:='vor zwei Monaten';
     if vormonaten = 3 then res:='vor drei Monaten';
     if vormonaten > 10 then res:= 'vor einem Jahr';
     if vormonaten > 13 then res:= 'vor gut einem Jahr';

     if vormonaten > 23 then
     begin
          res:= 'vor ' + inttostr(trunc(vormonaten/12)) + ' Jahren';
     end;
     if vormonaten > 120 then
     begin
          res:= 'vor mehr als 10 Jahren';
     end;
     result:=res + ' bearbeitet';
end;

function KalenderDatum(eingabe:string):string;
var
  tag, monat, jahr:string;
begin
  tag:='01';
  monat:='01';
  jahr:='2010';
  if pos('am',eingabe)>0 then eingabe:=deletefirstword(eingabe); // am/vor raus
  if length(eingabe) > 11 then //mit Uhrzeit
  begin
       jahr:=copy(eingabe,1,4);
       monat:=copy(eingabe,5,2);
       tag:=copy(eingabe,7,2);
  end else begin //ohne Uhrzeit
    tag:=copy(eingabe,1,pos('.',eingabe)-1);
    eingabe:=copy(eingabe,pos('.',eingabe)+1,100);
    monat:=copy(eingabe,1,pos('.',eingabe)-1);
    eingabe:=copy(eingabe,pos('.',eingabe)+1,100);
    jahr:=copy(eingabe,1,4);
  end;
  if str2int(jahr) < 2000 then
  result := ' - '
  else
  result:=tag + '.' + monat + '.' + jahr;
end;

function VergangeneZeit(eingabe:string):string;
begin
     if pos('#',eingabe)=0 then //altes Format
     begin
          result:=VergangeneZeitBerechnen(eingabe);
     end else begin
         result:=copy(eingabe,1,pos('#',eingabe)-1);
     end;
end;
function ZeitSeitErstellen(eingabe:string):string;
var
   f:string;
begin
     //an/vor 01.01.2020
     eingabe:=getLastWord(eingabe);
     eingabe:= stringreplace(eingabe, '.', ' ', [rfreplaceall]);
     f:=getlastword(eingabe);
     eingabe:=deletelastword(eingabe);
     f:=f+getlastword(eingabe);
     eingabe:=deletelastword(eingabe);
     f:=f+getlastword(eingabe) + '0000';
     Result:=VergangeneZeitBerechnen(f);
end;

//Ende Funktionen, die Zeit berechnen



//BISHIER//


function LiteraturQuerverweiseAusgeben(zeile:string):boolean;
var
   zitat:string;
begin
     zitat:='';
     zeile:=copy(zeile,pos('[=',zeile),10000);
     while pos('[=',zeile) > 0 do
     begin
          zitat:= copy(zeile,1, pos('=]',zeile)+2) ;
          if pos('#',zitat) > 0 then
             zitat:= copy(zitat,1,pos('#',zitat)-1) +
                     copy(zitat,pos('-',zitat),1000);

          FindeAndereZitate(zitat);
          zeile:=copy(zeile,5,10000); //den Anfang weg.
          zeile:=copy(zeile,pos('[=',zeile), 10000);
     end;
     result:=true;
end;

function HolAnmerkungen():boolean;

var
   txt:   string;
begin
     if AngezeigterTyp='N' then
        txt:=  Daten[AktuelleNotizenArrayZeile, Spalte_Anmerkung];
     if AngezeigterTyp='L' then
        txt:=  Literatur[AktuelleLiteraturArrayZeile, Spalte_Anmerkung];
     gv_textposition:=0;
     with fenster do
     begin
          FeldInhalt.Visible:=true;
          FeldInhalt.align:=alclient;
          FeldInhalt.Text := utf8decode(txt);
          { für das Scrolling wird beim Scrolling nur auf den Anfang
            des letzten Absatzes gescrollt. Der Rest bleibt unsichtbar
            daher bei längeren Texten, die einen langen letzten Absatz
            haben, wird eine Zeile mit einem Leerzeichen angefügt.}
          if  (length(feldinhalt.Lines[Feldinhalt.Lines.Count-1]) > 60)
          and  (Feldinhalt.Lines.Count > 3)
          then  FeldInhalt.Lines.Add(' ');
          Feldinhalt.SelStart:=1;
     end;
end;

function DatensatzAufrufen(titel: string): boolean;
         //--- Eine Notiz in der Liste anklicken und Daten anzeigen--
         //----------------------------------------------------------
var
  Bearbeitungszahl:           string;
  myrow:                      integer;
  i:                          integer;
  LinkAufDieNotiz:            string;
  treffer:                    boolean;
  VerweisVonSeite:            string;
  vor:                        string;
  ZahlDerVerweise:            integer;
begin



  if titel <> '' then
  begin
    with fenster do
    begin
         for i:=1 to 100 do VerweisArray[i,1]:=''; //Array leeren
         for i:=1 to 100 do VerweisArray[i,2]:=''; //Array leeren
         ZahlDerVerweise:=0;
      AngezeigterTyp:='N';
      myrow:=HolArrayZeileDesTitels(titel);
                                                                                 //  showmessage('Datensatzaufrufen Arrayzeile durch');
      if myrow<0 then showmsg('Es gibt ein Problem mit ' + titel)  ;
      if myrow >= 0 then  //01/21: falls irgendwas schiefgeht, ist myrow = 0
      begin
            AktuelleNotizenArrayZeile:=myrow;
            AngezeigterTyp:='N';
            //Einlesen der Daten

            holAnmerkungen();
            GV_FeldNummer:= Daten[AktuelleNotizenArrayZeile, Spalte_ID];

            //Anzeige des Ideentitels
            GV_Titel := daten[AktuelleNotizenArrayZeile, Spalte_Titel];
            LabelTitel.Caption:=GV_Titel ;
            while (length(LabelTitel.Caption)*(labeltitel.font.size-2)) > Paneltitel.width do
                    LabelTitel.Caption:=DeleteLastWord(LabelTitel.Caption)+'...';

            //-----Verweise auf die Seite Anzeigen----
            //----------------------------------------
            LinkAufDieNotiz:= 'note://' +
                      Daten[AktuelleNotizenArrayZeile, Spalte_ID] ;
            If length(linkaufdienotiz)<8 then
               linkaufdienotiz:='Fehler://' ; {warum auch immer}

            //Die Datenbank durchsuchen
            for i:=1 to arraysize_Daten do
            begin
                 treffer:=false;
                 if pos(LinkaufdieNotiz + '_',Daten[i, Spalte_Anmerkung])>0
                    then treffer:= true;
                 if pos(LinkaufdieNotiz + '-',Daten[i, Spalte_Anmerkung])>0
                    then treffer:= true;

                 if (treffer) and (zahlderverweise < 90) then
                 begin
                        ZahlDerVerweise:=ZahlDerVerweise+1;
                        VerweisVonSeite:='note://' + Daten[i, Spalte_ID] + ' '
                                                  + Daten[i, Spalte_Titel];
                        VerweisArray[ZahlDerVerweise,1]:=VerweisVonSeite;
               end
            end;                                                                     //showmessage('Datensatzanzeigen vor Verweisen');
            //--Verweise aus Literaturquellen auf diese Notiz ---
            //---------------------------------------------------
            //Abklappern der LiteraturDB nach Verweisen auf diese Notiz

                                                                                   //showmessage(linkaufdienotiz);


            for i:=1 to arraysize_Literatur do
            begin
                 treffer:=false;
                 if pos(LinkaufdieNotiz,Literatur[i, Spalte_Anmerkung])>0 then
                 treffer:=true;
               if treffer and (zahlderverweise < 90)  then
               begin
                   ZahlDerVerweise:=ZahlDerVerweise+1;
                   VerweisVonSeite:='ref://' + Literatur[i, Spalte_ID] + ' '
                          + Literatur[i, Spalte_Erstautor]
                          + ' (' + Literatur[i, Spalte_Jahr] + ') '
                          + Literatur[i, Spalte_Titel]  ;
                      {Wichtig ist nur, dass ref://1234 ein Wort sind. Der Rest
                       kann Leerzeichen enthalten. Das stört bei der
                       Identifikation  des Verweises später nicht. 02/2024}
                   VerweisArray[ZahlDerVerweise,1]:=VerweisVonSeite;
               end;
            end;

                                                                                    //showmessage('Datensatzanzeigen vor Kopfzeile');
            //Kopfzeile
            vor:= ZeitSeitErstellen(Daten[AktuelleNotizenArrayZeile, Spalte_Bearbeitungsdatum]) ;
            if panelerstelltam.width > 750*skalierung then
               vor:=  vor + ' (' + KalenderDatum(Daten[AktuelleNotizenArrayZeile, Spalte_Bearbeitungsdatum]) + ')';
            LabelGeaendertAm.Caption:=  vor;
            LabelErstelltAm.caption:= KalenderDatum(Daten[AktuelleNotizenArrayZeile, Spalte_Erstelldatum]) ;

            //Zahl der Bearbeitungen prüfen

            if (length(Daten[AktuelleNotizenArrayZeile, Spalte_Bearbeitungszahl])> 4)
            or (length(Daten[AktuelleNotizenArrayZeile, Spalte_Bearbeitungszahl])<1)
            then Daten[AktuelleNotizenArrayZeile, Spalte_Bearbeitungszahl]:='1';
            Bearbeitungszahl:= Daten[AktuelleNotizenArrayZeile, Spalte_Bearbeitungszahl];

            if  (Bearbeitungszahl <>'1') and (Feldinhalt.width> 470*skalierung) then
            begin  if pos('-',LabelErstelltAm.Caption)=0 then
              begin
                 LabelErstelltAm.caption:=
                                          Bearbeitungszahl
                                        + ' Bearbeitungen seit '
                                        + LabelErstelltAm.caption
              end else begin
                  LabelErstelltAm.caption:= Bearbeitungszahl + ' Bearbeitungen';

              end;


          end;
        end;
      end;
  end;
                                                                                    // showmessage('Datensatzaufrufen Ende');
  Result := True;

end;




function trefferlistesortieren(kriterium:string):boolean;
const
     zukunft='301610171745' ;
var
    ar:array[0..TrefferArraySpalteVolltext] of string;
    maxzeile:integer;
    maxwert:string;
    zeilenzahl:integer;
    i,j,k:integer;
begin
                                                                                // showmessage('sortieren anfang');
     machpause();
     zeilenzahl:=0;
     for i:=0 to MaxAnzeige do
       if Trefferarray[i,3] <> ''
          then Zeilenzahl:=Zeilenzahl+1;
     for i:=0 to zeilenzahl  do
       if TrefferArray[i,2]='#'
       then  Trefferarray[i,TrefferArraySpalteBearbeitung]:=zukunft;

     //--- Kriterium ZEIT----
     //------------------------
     if kriterium='zeit' then
     begin
          for i:=0 to zeilenzahl -1 do
          begin
               maxwert:=TrefferArray[i,TrefferArraySpalteBearbeitung];
               maxzeile:=i;
               for j:=i+1 to zeilenzahl do
               begin
                    if TrefferArray[j,TrefferArraySpalteBearbeitung] > maxwert then //weiter hinten gibt es einen noch neueren Datensatz
                    begin
                         maxwert:= TrefferArray[j,TrefferArraySpalteBearbeitung];
                         maxzeile:= j;
                    end;
               end;
               if i<>maxzeile then
               begin
                    for k:=1 to TrefferArraySpalteVolltext do ar[k]:=TrefferArray[i,k]; ;
                    for k:=1 to TrefferArraySpalteVolltext do TrefferArray[i,k]:=TrefferArray[maxzeile,k];
                    for k:=1 to TrefferArraySpalteVolltext do TrefferArray[maxzeile,k]:=ar[k];
               end;
          end;
          //Die Liste ist nach der Zeit sortiert. Jetzt die vergangenen Tage berechnen
          for i:=0 to zeilenzahl -1 do
          begin
               vergangeneZeitBerechnen(Trefferarray[i,TrefferArraySpalteBearbeitung]);
               trefferArray[i,9]:= inttostr(vorstunden + 24*vorTagen + 720*Vormonaten + 7200*VorJahren);
          end;
     end;

     //---Kriterium alphabetisch sortieren
     //-------------------------------------
     if kriterium='alphabet' then
     begin
          for i:=0 to zeilenzahl-1  do
          begin
               maxwert:=Ansilowercase(TrefferArray[i,TrefferArraySpalteTitel]);
               if maxwert='' then maxwert:='zzz';
               maxzeile:=i;
               for j:=i+1 to zeilenzahl do
               begin
                    if  TrefferArray[j,TrefferArraySpalteTitel] <> '' then
                    begin
                        if (Ansilowercase(TrefferArray[j,TrefferArraySpalteTitel]) < maxwert)
                        then
                        begin
                             maxwert:= Ansilowercase(TrefferArray[j,TrefferArraySpalteTitel]);
                             maxzeile:= j;
                        end;
                    end;
               end;
               if i<>maxzeile then
               begin
                    for k:=1 to TrefferArraySpalteBearbeitung do ar[k]:=TrefferArray[i,k]; ;
                    for k:=1 to TrefferArraySpalteBearbeitung do TrefferArray[i,k]:=TrefferArray[maxzeile,k];
                    for k:=1 to TrefferArraySpalteBearbeitung do TrefferArray[maxzeile,k]:=ar[k];
               end;
          end;
     end;
                                                                                      //   showmessage('trefferlistesortieren ende');
     result:=true;
end;

function AlleZettelAnzeigen(): boolean;
const
     MindestZahl = 50;
var
   AnzahlFixierte:            integer;
   ArrayFixierte:             array[1..100] of string;
   gefunden:                  integer; //Zahl der Treffer
   heute:                     string;
   i,j,k:                     integer;
   lang,kurz:                 string;
   zeile:                     string;
   treffer:                   boolean;

begin
  AnzahlFixierte:=0;
  heute:=formatdatetime('yyyymmdd', now);


  //TrefferArray leeren
  for i:=0 to maxanzeige do for j:=1 to TrefferArraySpalteVolltext do Trefferarray[i,j]:='';

  { Vereinfacht. Statt eines irgendwie berechneten Mindestdatums die letzten
    Mindestzhal Treffer.}

  with fenster do
  begin
       //Die Notizen durchsuchen
       //------------------------
       if MenuNotizenZeigen.checked then
       begin
             gefunden:=0;
             for i := ArraySize_Daten downto 1  do
             begin
                  treffer:=false;
                  if  (daten[i,Spalte_ID]<>'') then treffer:=true;
                  { Bedingungen, unter denen ein Treffer doch keiner ist}
                  if treffer then
                    if (pos('#hide#', Daten[i, Spalte_Anmerkung])>0)
                    then treffer:=false;
                  if treffer then
                    if (pos('#tag#', Daten[i, Spalte_Anmerkung])=0)
                    and (MenuNurMarkierte.Checked)
                     then treffer:=false;
                  if (gefunden > Mindestzahl) then treffer:=false;
                  if (pos(heute,daten[i,Spalte_Bearbeitungsdatum])=1)
                     then treffer:=true;
                     // so finde ich auch ältere, heute bearbeiten Datensätze)
                  if  treffer then
                  begin
                       gefunden:=gefunden+1;
                       if pos('#tag#',daten[i,Spalte_Anmerkung]) > 0
                       then  Trefferarray[gefunden,1]:='*';
                       Trefferarray[gefunden,3]:='N';                    //Typ
                       Trefferarray[gefunden,4]:=daten[i,Spalte_ID];             //ID
                       Trefferarray[gefunden,5]:=inttostr(i);            //Zeile im Array
                       Trefferarray[gefunden,TrefferArraySpalteTitel]:=daten[i,Spalte_Titel];             //Titel
                       Trefferarray[gefunden,7]:=trim(copy(daten[i,Spalte_Anmerkung],1,10000)) ;  //Textanfang
                       Trefferarray[gefunden,7]:=StringReplace(Trefferarray[gefunden,7],#13, ' ',[rfreplaceall]);
                       Trefferarray[gefunden,TrefferArraySpalteBearbeitung]:=daten[i,Spalte_Bearbeitungsdatum];             //Zeit

                       //fixierte Notizen in die Liste eingragen
                       if pos('#pin#',daten[i, Spalte_Anmerkung]) > 0
                       then Trefferarray[gefunden,TrefferArraySpalteBearbeitung]:='999';
                  end;
             end;
       end;

       if menuLiteraturzeigen.checked then
       begin
             for  i:=ArraySize_Literatur  downto 1 do
             begin
                  treffer:=false;
                  if  (Literatur[i,Spalte_ID]<>'') then treffer:=true;
                  { Bedingungen, unter denen ein Treffer doch keiner ist}
                  if treffer then
                    if (pos('#hide#', Literatur[i, Spalte_Anmerkung])>0)
                    then treffer:=false;
                  if treffer then
                    if (pos('#tag#', Literatur[i, Spalte_Anmerkung])=0)
                    and (MenuNurMarkierte.Checked)
                     then treffer:=false;
                  if (gefunden > Mindestzahl*2) then treffer:=false;
                  if (pos(heute,Literatur[i,Spalte_Bearbeitungsdatum])=1)
                     then treffer:=true;
                     // so finde ich auch ältere, heute bearbeiten Datensätze)

                  if treffer then
                  begin
                        gefunden:=gefunden+1;
                        if pos('#tag#',Literatur[i,Spalte_Anmerkung]) > 0 then
                        Trefferarray[gefunden,1]:='*';
                        Trefferarray[gefunden,3]:='L';                              //Typ
                        Trefferarray[gefunden,4]:=Literatur[i,Spalte_ID];
                        Trefferarray[gefunden,5]:=inttostr(i);                      //Zeile im Array
                        Trefferarray[gefunden,TrefferArraySpalteTitel]:=Literatur[i,Spalte_Erstautor] + ' ('+  Literatur[i,Spalte_Jahr] + ') '  +  Literatur[i,Spalte_Titel] ;           //Titel
                        Trefferarray[gefunden,7]:=copy(Literatur[i,Spalte_Anmerkung],1,10000) ;  //Textanfang
                        Trefferarray[gefunden,TrefferArraySpalteBearbeitung]:=Literatur[i,Spalte_Bearbeitungsdatum];             //Zeit

                       //Fixierter
                       if pos('#pin#',Literatur[i, Spalte_Anmerkung]) > 0
                       then Trefferarray[gefunden,TrefferArraySpalteBearbeitung]:='999';
                  end;
             end;
        end;
        //----Ausgabe und Formatierung der Fixierten
        //------------------------------------------
        //nach Länge sortieren. Die langen in die linke Spalte
        for j:=1 to AnzahlFixierte-1 do
        begin
             for k:=j+1 to AnzahlFixierte do
                 if length(Arrayfixierte[j])<length(Arrayfixierte[k]) then
                 begin
                    kurz:= Arrayfixierte[j];
                    lang:=Arrayfixierte[k];
                    ArrayFixierte[j]:=lang;
                    ArrayFixierte[k]:=kurz;
                 end;
        end;
      Trefferlistesortieren('zeit');
      Liste.rowcount :=0;
      ListeNotizGliedern.items.clear;
      Liste.rowcount :=gefunden+2;     //Die letzten 4 Wochen Bearbeiteten Datensätze
                                       //Das sind nicht alle Treffer der Datenbank



      j:=0;
      for i:=0 to gefunden do
      begin
           Liste.Cells[ListeSpalteTitel, i] := Trefferarray[i,TrefferArraySpalteTitel]  ;
           ListeNotizGliedern.items.Add( Trefferarray[i,TrefferArraySpalteTitel]);
      end;

      Liste.Row := 0;

      machpause();

      LeereListenZeilenAmEndeLoeschen() ;
      ListeSchieberHeight();

  end;

  Result := True;

end;

function ErzeugeBidirektoralesLink(arrow1, arrow2:string):boolean  ;
//--erwartet die beiden Zeilen im Array im format L1234 / N1234
//--nicht die ID !
var
  idUrsprung, idziel:             string;
  Linktextursprung, linktextziel: string;
  titelursprung,titelziel:        string;
  TypUrsprung, TypZiel:           string;
  zeileUrsprung, zeileZiel:       integer;
begin
   TypUrsprung:=Copy(arrow1,1,1);
   TypZiel:=  Copy(arrow2,1,1);
   zeileUrsprung:=str2int(copy(arrow1,2,100));
   zeileZiel:=str2int(copy(arrow2,2,100));


   //-- Der Ursprung des Links ist eine Notiz
   if TypUrsprung='N' then
   begin
       idUrsprung:=daten[ZeileUrsprung,Spalte_ID];
       titelUrsprung:=daten[ZeileUrsprung,Spalte_Titel];
       LinktextUrsprung:='note://' + idUrsprung + ' ' + titelUrsprung;
       LinktextUrsprung:= StringReplace(LinktextURsprung,' ' , '_', [rfReplaceAll]);
   end;

   if TypUrsprung='L' then
   begin
         LinkTextUrsprung:= 'ref://' + Literatur[ZeileUrsprung,Spalte_ID] +
                           ' ' +       Literatur[ZeileUrsprung,Spalte_Erstautor] +
                           ' (' +      Literatur[ZeileUrsprung,Spalte_Jahr] +
                           ') ' +      Literatur[ZeileUrsprung,Spalte_Titel] ;
         if length(LinkTextUrsprung) > 50 then
         begin
              LinkTextUrsprung:=copy(linktextursprung,1,53);
              LinkTextUrsprung:=deleteLastword(LinktextUrsprung);
         end;
         LinktextUrsprung:= StringReplace(LinktextURsprung,' ' , '_', [rfReplaceAll]);
   end;


    //-- Das Ziel des Links ist eine Notiz
   if TypZiel='N' then
   begin
       idZiel:=daten[ZeileZiel,Spalte_ID];
       titelZiel:=daten[ZeileZiel,Spalte_Titel];
       LinktextZiel:='note://' + idZiel + ' ' + titelZiel;
       LinktextZiel:= StringReplace(LinktextZiel,' ' , '_', [rfReplaceAll]);
   end;

   if TypZiel='L' then
   begin
        LinkTextZiel:= 'ref://' + Literatur[ZeileZiel,Spalte_ID] +
                           ' ' +  Literatur[ZeileZiel,Spalte_Erstautor] +
                           ' (' + Literatur[ZeileZiel,Spalte_Jahr] +
                           ') ' + Literatur[ZeileZiel,Spalte_Titel] ;
         if length(LinkTextZiel) > 50 then
         begin
              LinkTextZiel:=copy(LinkTextZiel,1,53);
              LinkTextZiel:=deleteLastword(LinkTextZiel);
         end;
         LinkTextZiel:= StringReplace(LinkTextZiel,' ' , '_', [rfReplaceAll]);
   end;

   machpause();
   if TypUrsprung='N' then
   begin
        if pos(LinktextZiel,Daten[ZeileUrsprung,Spalte_Anmerkung])=0 then
        begin
           Daten[ZeileUrsprung,Spalte_Anmerkung]:=
              Daten[ZeileUrsprung,Spalte_Anmerkung]+  #10#13 +  LinktextZiel;


           Daten[zeileUrsprung,Spalte_Bearbeitungsdatum]:= formatdatetime('yyyymmddhhnn', now);
           NotizVolltext(ZeileUrsprung);
           ichanged:=true;
           ineedssorting:=true;
        end;

   end;
   if TypUrsprung='L' then
   begin
        if pos(LinktextZiel, Literatur[ZeileUrsprung,Spalte_Anmerkung])=0 then
        begin
               Literatur[ZeileUrsprung,Spalte_Anmerkung]:=
                  Literatur[ZeileUrsprung,Spalte_Anmerkung] + #10#13 +  LinktextZiel;

               Literatur[ZeileUrsprung,Spalte_Bearbeitungsdatum]:= formatdatetime('yyyymmddhhnn', now);
               lneedssorting:=true;
               LiteraturVolltext(ZeileUrsprung);
               lchanged:=true;
        end;
   end;
   if TypZiel='N' then
   begin
        if pos(LinktextUrsprung,Daten[ZeileZiel,Spalte_Anmerkung])=0 then
        begin
           Daten[ZeileZiel,Spalte_Anmerkung]:=
              Daten[ZeileZiel,Spalte_Anmerkung] + #10#13 + LinktextUrsprung + ' ';
           Daten[zeileZiel,Spalte_Bearbeitungsdatum]:= formatdatetime('yyyymmddhhnn', now);
           NotizVolltext(ZeileZiel);
           ichanged:=true;
           ineedssorting:=true;
        end;
   end;
   if TypZiel='L' then
   begin
        if pos(LinktextUrsprung,Literatur[ZeileZiel,Spalte_Anmerkung])=0 then
        begin
           Literatur[ZeileZiel,Spalte_Anmerkung]:=
              Literatur[ZeileZiel,Spalte_Anmerkung] + #10#13 + LinktextUrsprung+ ' ';
           Literatur[zeileZiel,Spalte_Bearbeitungsdatum]:= formatdatetime('yyyymmddhhnn', now);
           lneedssorting:=true;
           LiteraturVolltext(ZeileZiel);
           lchanged:=true;
        end;
   end;
   machpause();

   result:=true;
end;

function QuerverweisLiteraturLiteratur(id1,id2:string):boolean;
var
  arraynr1,arraynr2:integer ;
  zitat1,zitat2:string;

begin
  machpause();
  arraynr1:=HolArrayZeileDerLiteraturID(id1);
  arraynr2:=HolArrayZeileDerLiteraturID(id2);
  machpause();
  zitat1:= ' [='+  id1 + '-' + Literatur[arraynr1,Spalte_Erstautor] + ' (' +  Literatur[arraynr1,Spalte_Jahr] + ')=] ';
  zitat2:= ' [='+  id2 + '-' + Literatur[arraynr2,Spalte_Erstautor] + ' (' +  Literatur[arraynr2,Spalte_Jahr] + ')=] ';
  Literatur[arraynr1,Spalte_Anmerkung]:= Literatur[arraynr1,Spalte_Anmerkung] + zitat2;
  Literatur[arraynr2,Spalte_Anmerkung]:= Literatur[arraynr2,Spalte_Anmerkung] + zitat1;
  Literatur[arraynr1,Spalte_Volltext]:= Literatur[arraynr1,Spalte_Volltext] + zitat2 + ansilowercase(zitat2);
  Literatur[arraynr2,Spalte_Volltext]:= Literatur[arraynr2,Spalte_Volltext] + zitat2 + ansilowercase(zitat2);
  Literatur[arraynr1,Spalte_Bearbeitungsdatum]:=formatdatetime('yyyymmddhhnn', now);
  machpause();
  Literatur[arraynr2,Spalte_Bearbeitungsdatum]:=formatdatetime('yyyymmddhhnn', now);
  machpause();

  lchanged:=true;
  lneedssorting:=true;
  result:=true;
end;









function LiteraturDatenbankKomplettAbspeichern():boolean;
var
         i:               integer;
         pt:              string;
         str:             Tstringlist;
begin
     screen.cursor:=crhourglass;

     if Schreibrecht() then
     begin
          if fenster.OptionBibTeX.checked then SchreibBibTeXDB('alle');
          with fenster do
          begin
             str:=Tstringlist.create;
             str.Add('<?xml version="1.0"?>');
             str.Add('<version>6</version>');
             str.Add('<datensatzzahl>' + inttostr(GetNumberOfRecords('literatur')) + '</datensatzzahl>');
             str.Add('<Daten>');
          for i:= 1 to Arraysize_Literatur do
          begin
               if Literatur[i,1] <>'' then  //Zeile ist besetzt;
               begin
                     str.Add('');
                     str.Add('<Quelle>');
                     xmlLiteraturZeileFormatieren(i,1,'Id');
                     str.Add(xmlLiteraturZeileFormatieren(i,1,'Id'));
                     xmlLiteraturZeileFormatieren(i,1,'Id');
                     pt:=Literatur[i,Spalte_Publikationstyp];
                     if pt='' then pt:='Buch';
                     str.Add('<Typ>' + pt +'</Typ>');
                     if Literatur[i,Spalte_Kurzzitat] <> '' then str.Add(xmlLiteraturZeileFormatieren          (i,Spalte_Kurzzitat,'Kurzzitat'));
                     if Literatur[i,Spalte_Autor] <> '' then str.Add(xmlLiteraturZeileFormatieren              (i,Spalte_Autor,'Autor'));
                     if Literatur[i,Spalte_Jahr] <> '' then str.Add(xmlLiteraturZeileFormatieren               (i,Spalte_Jahr,'Jahr'));
                     if Literatur[i,Spalte_Publikationsdatum] <> '' then str.Add(xmlLiteraturZeileFormatieren  (i,Spalte_Publikationsdatum,'Datum'));
                     if Literatur[i,Spalte_Titel] <> '' then str.Add(xmlLiteraturZeileFormatieren              (i,Spalte_Titel,'Titel'));
                     if Literatur[i,Spalte_Untertitel] <> '' then str.Add(xmlLiteraturZeileFormatieren         (i,Spalte_Untertitel,'Untertitel'));
                     if Literatur[i,Spalte_Zeitschrift] <> '' then str.Add(xmlLiteraturZeileFormatieren        (i,Spalte_Zeitschrift,'Zeitschrift'));
                     if Literatur[i,Spalte_Band] <> '' then str.Add(xmlLiteraturZeileFormatieren               (i,Spalte_Band,'Band'));
                     if Literatur[i,Spalte_Nummer] <> '' then str.Add(xmlLiteraturZeileFormatieren             (i,Spalte_Nummer,'Nummer'));
                     if Literatur[i,Spalte_Seiten] <> '' then str.Add(xmlLiteraturZeileFormatieren             (i,Spalte_Seiten,'Seiten'));
                     if Literatur[i,Spalte_Herausgeber] <> '' then str.Add(xmlLiteraturZeileFormatieren        (i,Spalte_Herausgeber,'Herausgeber'));
                     if Literatur[i,Spalte_Sammelband] <> '' then str.Add(xmlLiteraturZeileFormatieren         (i,Spalte_Sammelband,'Sammelband'));
                     if Literatur[i,Spalte_Verlag] <> '' then str.Add(xmlLiteraturZeileFormatieren             (i,Spalte_Verlag,'Verlag'));
                     if Literatur[i,Spalte_Ort] <> '' then str.Add(xmlLiteraturZeileFormatieren                (i,Spalte_Ort,'Ort'));
                     if Literatur[i,Spalte_Auflage] <> '' then str.Add(xmlLiteraturZeileFormatieren            (i,Spalte_Auflage,'Auflage'));
                     if Literatur[i,Spalte_ISBN] <> '' then str.Add(xmlLiteraturZeileFormatieren               (i,Spalte_ISBN,'ISBN'));
                     if Literatur[i,Spalte_Anmerkung]     <> '' then str.Add(xmlLiteraturZeileFormatieren      (i,Spalte_Anmerkung,'Anmerkung'));
                     if Literatur[i,Spalte_Erstautor] <> '' then str.Add(xmlLiteraturZeileFormatieren          (i,Spalte_Erstautor,'Erstautor'));
                     if Literatur[i,Spalte_Bearbeitungsdatum] <> '' then str.Add(xmlLiteraturZeileFormatieren  (i,Spalte_Bearbeitungsdatum,'Bearbeitung'));
                     if Literatur[i,Spalte_Erstelldatum]<>'' then  str.Add(xmlLiteraturZeileFormatieren        (i,Spalte_Erstelldatum,'erstellt'));
                     if Literatur[i,Spalte_Bearbeitungszahl] <> '' then str.Add(xmlLiteraturZeileFormatieren   (i,Spalte_Bearbeitungszahl,'bearbeitungen'));
                     str.Add('</Quelle>');
               end;

          end;
          str.Add('</Daten>');
          try
             str.savetofile(LiteraturDatenbank);

          except
                busy() ;
                machpause();
                try
                   str.savetofile(LiteraturDatenbank );
                   machpause();
                except
                    busy();
                    str.savetofile(LiteraturDatenbank );
                end;
          end;

      end;
   end;
   machpause();
   str.free;
   LneedsSorting:=true;
   if lchanged then
    begin
         lchanged:=false;
    end;
   result:=true;



    { Speichern hat geklappt. Jetzt TMP Verzeichnis leeren}
    {
    ListOfFiles := TStringList.Create;
    FileUtil.FindAllFiles(ListOfFiles, TMPVerzeichnisLiteratur, '*', False);
    for i:=0 to ListOfFiles.Count -1 do
    begin
         Datei:=ListOfFiles.Strings[i];
         DeleteFilePlus(Datei);
         machpause();
    end;
    ListOfFiles.free;
    }

   screen.cursor:=crdefault;
end;






function VollZitatbx(i:integer):string;
var
   zeile:string;
begin
  if Literatur[i,23]='' then
  begin
       // Buch als Standard  Chicago
       Zeile:=Literatur[i,Spalte_Autor]  ;
       if copy(zeile,length(zeile),1)<>'.' then Zeile:=Zeile + '.' ;
       if Literatur[i,Spalte_Titel]<>'' then Zeile:= Zeile + ' "' + Literatur[i,Spalte_Titel]  ; //Titel;
       if Literatur[i,Spalte_Untertitel]<>'' then Zeile:= Zeile + ' - ' + Literatur[i,Spalte_Untertitel]  ; //Untertitel;
       Zeile := Zeile + '". ';
       if Literatur[i,Spalte_Ort]<>'' then Zeile:= Zeile + ' ' +  Literatur[i,Spalte_Ort]; //Ort
       if Literatur[i,Spalte_Verlag]<>'' then
       begin
            if Literatur[i,Spalte_Ort]<>'' then zeile:= zeile + ':';
            Zeile:= Zeile +  ' ' + Literatur[i,Spalte_Verlag];
       end;
       if Literatur[i,Spalte_Auflage]<>'' then zeile:= zeile + ', ' + Literatur[i,Spalte_Auflage] + '. Aufl. ';
       if Literatur[i,Spalte_Jahr]<>'' then Zeile:= Zeile + ', ' +  Literatur[i,Spalte_Jahr];
       // Buch als Standard ist Fertig

       if Literatur[i,Spalte_Publikationstyp]='Artikel' then  // Zeitschriftenartikel
       begin
              Zeile:=Literatur[i,Spalte_Autor]  ;
              if copy(zeile,length(zeile),1)<>'.' then Zeile:=Zeile + '.' ;
              if Literatur[i,Spalte_Titel]<>'' then Zeile:= Zeile + ' "' + Literatur[i,Spalte_Titel]  ; //Titel;
              if Literatur[i,Spalte_Untertitel]<>'' then Zeile:= Zeile + ' - ' + Literatur[i,Spalte_Untertitel]  ;
              Zeile := Zeile + '". ';
              if Literatur[i,Spalte_Zeitschrift]<>'' then Zeile:= Zeile + ' ' +  Literatur[i,Spalte_Zeitschrift] ;
              if Literatur[i,Spalte_Publikationsdatum]<>'' then Zeile:= Zeile + ' ' +  Literatur[i,Spalte_Publikationsdatum] ;
              if Literatur[i,Spalte_Jahr]<>'' then Zeile:= Zeile + ' ' +  Literatur[i,Spalte_Jahr];
              if Literatur[i,Spalte_Band]<>'' then Zeile:= Zeile + ' ' + Literatur[i,Spalte_Band]  ; //Band;
              if Literatur[i,Spalte_Nummer]<>'' then Zeile:= Zeile +  ' (' + Literatur[i,Spalte_Nummer] + ')'  ; //Nummer;
              if Literatur[i,Spalte_Seiten]<>'' then Zeile:= Zeile +  ', S. ' + Literatur[i,Spalte_Seiten]  ; //Seiten;
       end;
       if Literatur[i,Spalte_Publikationstyp]='Kapitel' then  // Kapitel in Sammelband
       begin
                Zeile:=Literatur[i,Spalte_Autor]  ;
                if copy(zeile,length(zeile),1)<>'.' then Zeile:=Zeile + '.' ;
                if Literatur[i,Spalte_Titel]<>'' then Zeile:= Zeile + ' "' + Literatur[i,Spalte_Titel]  ; //Titel;
                if Literatur[i,Spalte_Untertitel]<>'' then Zeile:= Zeile + ' - ' + Literatur[i,Spalte_Untertitel]; //Untertitel;
                Zeile := Zeile + '". ';

                if Literatur[i,Spalte_Herausgeber]<>'' then Zeile:= Zeile + ' ' +  Literatur[i,Spalte_Herausgeber] + ' (Hg.)' ; //Herausgeber;
                if Literatur[i,13]<>'' then Zeile:= Zeile + ' ' +  Literatur[i,13] ; // Sammelbandtitel
                if Literatur[i,Spalte_Ort]<>'' then Zeile:= Zeile + ', ' +  Literatur[i,Spalte_Ort]; //Ort
                if Literatur[i,Spalte_Verlag]<>'' then
                begin
                     if Literatur[i,Spalte_Ort]<>'' then zeile:= zeile + ':';
                     Zeile:= Zeile +  ' ' + Literatur[i,Spalte_Verlag]; //Verlag
                end;
                if Literatur[i,Spalte_Jahr]<>'' then Zeile:= Zeile + ' ' +  Literatur[i,Spalte_Jahr];
                if Literatur[i,Spalte_Seiten]<>'' then Zeile:= Zeile +  ', S. ' + Literatur[i,Spalte_Seiten]  ; //Seiten;
       end;
       if Literatur[i,Spalte_Publikationstyp]='Sammelband' then  //
       begin
            if Literatur[i,Spalte_Autor]='' then // Herausgeber im Herausgeberfeld
            begin
                 Zeile:=Literatur[i,Spalte_Herausgeber]  ; //Hg;
            end else begin // Herausgeber im Autorenfeld
                Zeile:=Literatur[i,Spalte_Autor]  ; //Autor;
            end;
            if copy(zeile,length(zeile),1)<>'.' then Zeile:=Zeile + '.' ;

            Zeile:= Zeile + ' (Hg.)';

            //Titelfeld abklären
            if Literatur[i,Spalte_Titel]='' then // Titel im Sammelbandfeld
            begin
                 Zeile:= Zeile + ' "' + Literatur[i,13] + '."'  ;
            end else begin
                Zeile:= Zeile + ' "' + Literatur[i,Spalte_Titel] + '."' ;
            end;
            if Literatur[i,Spalte_Untertitel]<>'' then Zeile:= Zeile + ' - ' + Literatur[i,Spalte_Untertitel]   ;
            if Literatur[i,Spalte_Ort]<>'' then Zeile:= Zeile + ' ' +  Literatur[i,Spalte_Ort]; //Ort
            if Literatur[i,Spalte_Verlag]<>'' then
            begin
                 if Literatur[i,Spalte_Ort]<>'' then zeile:= zeile + ':';
                 Zeile:= Zeile +  ' ' + Literatur[i,Spalte_Verlag]; //Verlag
            end;
            if Literatur[i,Spalte_Jahr]<>'' then Zeile:= Zeile + ', ' +  Literatur[i,Spalte_Jahr]; //Jahr
       end;
       if Literatur[i,Spalte_Publikationstyp]='Webseite'  then  //  url kommt extra
       begin
            Zeile:=Literatur[i,Spalte_Autor]  ; //Autor;
            if copy(zeile,length(zeile),1)<>'.' then Zeile:=Zeile + '.' ;
            if Literatur[i,Spalte_Titel]<>'' then Zeile:= Zeile + ' "' + Literatur[i,Spalte_Titel]  ; //Titel;
            if Literatur[i,Spalte_Untertitel]<>'' then Zeile:= Zeile + ' - ' + Literatur[i,Spalte_Untertitel] + '."' ; //Untertitel;
            Zeile := Zeile + '". ';
            if Literatur[i,Spalte_Zeitschrift]<>'' then Zeile:= Zeile + ' ' +  Literatur[i,Spalte_Zeitschrift] ;
            if Literatur[i,Spalte_Publikationsdatum]<>'' then Zeile:= Zeile + ' ' +  Literatur[i,Spalte_Publikationsdatum] ;
            if Literatur[i,Spalte_Jahr]<>'' then Zeile:= Zeile + ' ' +  Literatur[i,Spalte_Jahr]; //Jahr
       end;
       Zeile:=zeile + '.'; // Punkt am Ende
       Literatur[i,23]:=zeile;
  end ;
  result:=Literatur[i,23];

end;









function CreateTMPCitation(arrayzeile:integer):string;
var
    t:string;
begin
     t:=literatur[AktuelleLiteraturArrayZeile,Spalte_Titel]; //Der Titel.Vielleicht notwendig
     t:=copy(t,1,30);
     while (copy(t,length(t),1) <> ' ') and (pos(' ',t)> 0)  do t:=copy(t,1,length(t)-1);

     //Autor und Titel sind nur Deko. Umlaute werden evtl. nicht richtig übersetzt
     //und mit einem ? ausgegeben. Um das zu verhindern, werden die Umlaute
     //entfernt und Ä=Ae formatiert. 03/2022

     t:=UmlautZeichenWeg(trim(t));

    result:='[=' +
                 literatur[AktuelleLiteraturArrayZeile,1] + '-' +
                 UmlautZeichenWeg( literatur[AktuelleLiteraturArrayZeile,Spalte_Erstautor]) + ' (' +
                 literatur[AktuelleLiteraturArrayZeile,Spalte_Jahr] + ')' ;
    if langesTMPZitat then result:=result + ' ' +   t;
    result:=result+ '=]' ;
end;

function LiteraturIdAnzeigen(id:string):boolean;
var
  Bearbeitungszahl                :String;
  LinkDieserSeite                 :string;
  i                               :integer;
  j:                              integer;
  Treffer:                        boolean;
  VerweisVonSeite:                string;
  VerweisGefunden:                boolean;
  vor:                            string;
  ZahlDerVerweise:                integer;
begin
     machpause();
    ZahlDerVerweise:=0;
    for i:=1 to 100 do VerweisArray[i,1]:=''; //Array leeren
    for i:=1 to 100 do VerweisArray[i,2]:=''; //Array leeren
    AktuelleLiteraturArrayZeile:=HolArrayZeileDerLiteraturId(zahlenausfiltern(id));
    AngezeigterTyp:='L';
    if AktuelleLiteraturArrayZeile > 0 then
    begin
    with fenster do
        begin
             for j:=1 to Spalte_Ende do LiteraturZeile[j]:=Literatur[aktuelleLiteraturArrayZeile,j]; // in eine zweite Variable kopiert, die als globale Variable an eine Funktion übergeben werden kann

             LabelVollzitat.caption:=QuelleInRTFFormatieren(false);

             LabelVollzitat.Align:=alclient;

             //Die temporären Quellenhinweise
             if length(literatur[AktuelleLiteraturArrayZeile,Spalte_Kurzzitat]) >3 then
             //es gibt ein geändertes Kurzzitat
             begin
                 GV_TmpZitat:= literatur[AktuelleLiteraturArrayZeile,Spalte_Kurzzitat]  ;
             end else begin //das Standard-Kurzzitat verwenden
                 GV_TmpZitat:= createTMPCitation(AktuelleLiteraturArrayZeile);

             end;

             //Die Titelzeile, die  über Feldinhalt angezeigt wird
             DummyString:= literatur[AktuelleLiteraturArrayZeile,Spalte_Erstautor] +
                           ' (' + literatur[AktuelleLiteraturArrayZeile,Spalte_Jahr]+
                           ') ' + literatur[AktuelleLiteraturArrayZeile,Spalte_Titel] ;



             while (length(dummystring)*(labeltitel.font.size-3)) > Paneltitel.width do
             begin
                    Dummystring:=DeleteLastWord(Dummystring)+'...';
             end;

             LabelTitel.Caption:=DummyString;
             GV_Titel:=LabelTitel.Caption;
             GV_FeldNummer:= literatur[AktuelleLiteraturArrayZeile,1];
             GV_BibTeXKey:= '\cite{'+
                            literatur[AktuelleLiteraturArrayZeile,Spalte_Erstautor] +
                            literatur[AktuelleLiteraturArrayZeile,Spalte_Jahr] + '-' +
                            literatur[AktuelleLiteraturArrayZeile,1] + '}';
                                       //\cite{Brauck2016-4518}

             GV_BibTeXKey := stringreplace(GV_BibTeXKey, ' ', '', [rfreplaceall]);



             //========Notizen, die auf die Quelle Bezug nehmen==========
             //==========================================================
             LinkDieserSeite:= Literatur[AktuelleLiteraturArrayZeile,1] ;
             for i := 1 to ArraySize_Daten  do  //Notizen DB durchsuchen
             begin
                   VerweisGefunden:=False;
                   if (pos(LinkDieserSeite, Daten[i, Spalte_Anmerkung]) > 0) then
                   begin
                        if (pos('ref://'+linkdieserseite , Daten[i, Spalte_Anmerkung]) > 0)
                        or (pos('[='+linkdieserseite , Daten[i, Spalte_Anmerkung]) > 0)
                        then Verweisgefunden:=true;
                   end;
                   if Verweisgefunden then
                   begin
                        if  (pos(linkdieserseite + ' ', Daten[i, Spalte_Anmerkung]) = 0)
                        and (pos(linkdieserseite + '#', Daten[i, Spalte_Anmerkung]) = 0)
                        and (pos(linkdieserseite + '_', Daten[i, Spalte_Anmerkung]) = 0)
                        and (pos(linkdieserseite + '-', Daten[i, Spalte_Anmerkung]) = 0)
                        then verweisgefunden:=false;
                   end;

                   //Vorfiltern auf ref://1234 geht schneller. Falls ja-ganzes Wort

                  If VerweisGefunden then
                  begin
                       ZahlDerVerweise:=ZahlDerVerweise+1;
                       VerweisVonSeite:='note://' + Daten[i, Spalte_ID]
                                        + ' '
                                        + Daten[i, Spalte_Titel];
                       VerweisArray[ZahlDerVerweise,1]:=VerweisVonSeite;
                  end;
             end;
             //========Quellen, die auf die Quelle Bezug nehmen==========
             //==========================================================
             for i := 1 to ArraySize_Literatur  do
             begin
                  Treffer:=false;
                  if (pos(LinkDieserSeite, Literatur[i, Spalte_Anmerkung]) > 0) then
                  begin
                       //Die ID taucht im Anmerkungstext einer anderen Quelle auf
                        if (pos('ref://'+linkdieserseite ,  Literatur[i, Spalte_Anmerkung]) > 0)
                        or (pos('[='+linkdieserseite , Literatur[i, Spalte_Anmerkung]) > 0)
                        then treffer:=true;
                   end;
                   if treffer then
                   begin
                       if  (pos(LinkDieserSeite + '#', Literatur[i, Spalte_Anmerkung]) = 0)
                       and (pos(LinkDieserSeite + '_', Literatur[i, Spalte_Anmerkung]) = 0)
                       and (pos(LinkDieserSeite + ' ', Literatur[i, Spalte_Anmerkung]) = 0)
                       and (pos(LinkDieserSeite + '-', Literatur[i, Spalte_Anmerkung]) = 0)
                       then treffer:=false;
                   end;

                   if Treffer then
                   begin
                           ZahlDerVerweise:=ZahlDerVerweise+1;
                           VerweisVonSeite:='ref://'
                               + Literatur[i, Spalte_ID] + ' '
                               + Literatur[i, Spalte_Erstautor]
                               + ' (' + Literatur[i, Spalte_Jahr]
                               + ') '
                               + Literatur[i, Spalte_Titel];
                           VerweisArray[ZahlDerVerweise,1]:=VerweisVonSeite;
                    end;

             end;




             //Anmerkung anzeigen
             HolAnmerkungen() ;



        //Fußzeile;
                   vor:= ZeitSeitErstellen(Literatur[AktuelleLiteraturArrayZeile, Spalte_Bearbeitungsdatum])  ;
            if panelerstelltam.width > 750*skalierung then
               vor:=  vor + ' ('+ Kalenderdatum(Literatur[AktuelleLiteraturArrayZeile, Spalte_Bearbeitungsdatum]) +')';
            LabelGeaendertAm.Caption:=  vor;

             LabelErstelltAm.caption:= KalenderDatum(Literatur[AktuelleLiteraturArrayZeile, Spalte_Erstelldatum]) ;

             //Zahl der Bearbeitungen prüfen
             if
               (length(Literatur[AktuelleLiteraturArrayZeile, Spalte_Bearbeitungszahl])> 4)
             or
               (length(Literatur[AktuelleLiteraturArrayZeile, Spalte_Bearbeitungszahl])< 1)
             then
                 Literatur[AktuelleLiteraturArrayZeile, Spalte_Bearbeitungszahl]:='1';
             Bearbeitungszahl:=Literatur[AktuelleLiteraturArrayZeile, Spalte_Bearbeitungszahl];
             if (bearbeitungszahl<> '1')
             and (Feldinhalt.width> 470) then
             begin
                  if pos('-',LabelErstelltAm.Caption)=0 then
                  begin
                       LabelErstelltAm.caption:=
                                          Bearbeitungszahl
                                        + ' Bearbeitungen seit '
                                        + LabelErstelltAm.caption
                  end else begin
                      LabelErstelltAm.caption:= Bearbeitungszahl + ' Bearbeitungen';
                  end;
              end;
        end; // ende with Fenster
    end else begin

        AktuelleLiteraturArrayZeile:=1; //sicherheitshalber
    end;

    result:=true;
end;


function LiteraturTiteldatenFormular(litid:string):boolean ;
var
  i:    integer ;
  typ:  string;
begin
      with Fenster do
      begin
          i:=HolArrayZeileDerLiteraturId(zahlenausfiltern(litid));

          RadioBuch.Checked:=true;
          typ:=Literatur[i,Spalte_Publikationstyp];
          if typ='Artikel' then RadioArtikel.checked:=true;
          if typ='Kapitel' then RadioKapitel.checked:=true;
          if typ='Sammelband' then RadioSammelband.checked:=true;

          TitelDatenmatrix.Cells[1,0]:=Literatur[i,Spalte_autor];
          TitelDatenmatrix.Cells[1,1]:=Literatur[i,Spalte_titel];
          TitelDatenmatrix.Cells[1,2]:=Literatur[i,Spalte_Untertitel];
          TitelDatenmatrix.Cells[1,3]:=Literatur[i,Spalte_Jahr];
          TitelDatenmatrix.Cells[1,4]:=Literatur[i,Spalte_Publikationsdatum];
          TitelDatenmatrix.Cells[1,5]:=Literatur[i,Spalte_Band];
          TitelDatenmatrix.Cells[1,6]:=Literatur[i,Spalte_Nummer];
          TitelDatenmatrix.Cells[1,7]:=Literatur[i,Spalte_Seiten];
          TitelDatenmatrix.Cells[1,8]:=Literatur[i,Spalte_Zeitschrift];
          TitelDatenmatrix.Cells[1,9]:=Literatur[i,Spalte_Herausgeber];
          TitelDatenmatrix.Cells[1,10]:=Literatur[i,Spalte_Sammelband];
          TitelDatenmatrix.Cells[1,11]:=Literatur[i,Spalte_Verlag];
          TitelDatenmatrix.Cells[1,12]:=Literatur[i,Spalte_Ort];
          TitelDatenmatrix.Cells[1,13]:=Literatur[i,Spalte_Auflage];
          TitelDatenmatrix.Cells[1,14]:=Literatur[i,Spalte_ISBN];



          tmphinweis:=                 '[=' + Literatur[i,Spalte_ID]+ '-abc=]';
      end;

      result:=true;
end;

function verweisaufrufen(link:string):boolean ;
var
  typ:integer;
  titel:string;
begin
  Fenster.timer.enabled:=False;
  with fenster do
  begin
       if istextchanged then savechangestoarray();
       if Fenster.ActiveControl=Feldinhalt then typ:=0 else typ:=1 ;
          //Doppeklick in Feldinhalt beim ersten Klick abfangen
       link:=trim2(link); //sollte eigentlich nicht nötig sein, aber....
       if pos('<gelöscht ...>',link)> 0 then typ:=999;
       if pos('http',ansilowercase(link))=1 then typ:=2; //URL
       if pos('file://',link)=1 then typ:=3;
       if pos('[=',link)=1 then typ:=4; // Literaturquelle
       if pos('note://',link)=1 then typ:=5; //Notiz
       if pos('ref://',link)=1 then typ:=6; //Quelle alternatives Format
       if pos('[[',link)=1 then typ:=7; // Notiz



      if typ=1 then  //Aufruf aus der Verweisliste
      begin
           AktuelleNotizID:=HolIdeenIDdesTitels(trim(link));
           DatensatzAufrufen(trim(link));
           ZeigeTreeviewItemInListe(link);
      end;
      if typ=2 then OpenURL(link);

      //===Aufruf einer Datei===
      //========================
      if typ=3 then
      begin
           link:=trim(link);
           link:=copy(link,8,199);
           if os='win' then link:= StringReplace(Link,'/' , '\', [rfReplaceAll]);
           if os='linux' then link:= StringReplace(Link,'\' , '/', [rfReplaceAll]);
           link:= DBDirectory + 'files' + slash(os) +  link   ;
           if fileexists(link) then OpenDocument(link) else showmsg('Hier stimmt etwas nicht. Diese Datei existiert nicht (mehr)');

      end;
      if typ=4 then //Literaturquelle [=1234
      begin
           AktuelleLiteraturID:=GetIdfromTmpCitation(link);
           AngezeigterTyp:='L';
           LiteraturIdAnzeigen(AktuelleLiteraturID);
           ZeigeTreeviewItemInListe(link);
      end;
      if typ=5 then  //Notizaufruf aus dem Feldinhalt mit note://
      begin
           link:= StringReplace(Link,'_' , ' ', [rfReplaceAll]);
           //Sicherheitshalber falls Zahlen im Titel
           link:=GetFirstWord(link);
           link:=ZahlenAusfiltern(link);
           AktuelleNotizID:=link;
           titel:= HolTitelderNotizID(str2int(link));
           if pos('<gelöscht',titel)=0 then
           begin
                DatensatzAufrufen(titel);
                ZeigeTreeviewItemInListe(titel);
           end else begin
               showmsg('Hier stimmt etwas nicht. Diese Notiz existiert nicht (mehr)');
           end;

      end;
      if typ=6 then //Literaturquelle ref://1234 kann am Anfang stehen oder
                    //am Ende oder irgendwo
      begin
           titel:=link;
           link:=copy(link,pos('ref://',link), 14);
           link:= copy(link,7,7);  //sollte ausreichen
           while  (pos('#',link)>0) or
                  (pos('-',link)>0) or
                  (pos('_',link)>0)
                do
                   link:=deletelastchar(link);
           link:=getfirstword(link);
           //link hat jetzt die ID der angeklickten Quelle
           if HolArrayZeileDerLiteraturID(link) > 0 then //existiert die ID?
           begin
                AktuelleLiteraturid:=link ;
                AngezeigterTyp:='L';
                LiteraturIdAnzeigen(AktuelleLiteraturID);
                ZeigeTreeviewItemInListe(titel);
                Feldinhalt.sellength:=0;
           end else begin
               showmsg('Hier stimmt etwas nicht. Diese Literaturquelle existiert nicht (mehr)');
           end;

      end;


      if typ=7 then //Notiz [[1234
      begin

           link:= StringReplace(Link,'_' , ' ', [rfReplaceAll]);
           //Sicherheitshalber falls Zahlen im Titel
           link:=GetFirstWord(link);
           link:=ZahlenAusfiltern(link);
           AktuelleNotizID:=link;
           titel:= HolTitelderNotizID(str2int(link));
           if pos('<gelöscht',titel)=0 then
           begin
                DatensatzAufrufen(titel);
                ZeigeTreeviewItemInListe(titel);
           end else begin
               showmsg('Hier stimmt etwas nicht. Diese Notiz existiert nicht (mehr)');
           end;

      end;


      machpause();
      Feldinhalt.sellength:=0;
  end;

  Fenster.Timer.enabled:=true;
  result:=true;
end;

function Gliederungmd():boolean;
var
  anfang:                 integer;
  StandardZeichen:        TFontParams;
  titel:                  string ;
begin
     titel:=GetIni('gliederungsdatei','ideen.tree');
     titel:=copy(titel,1,length(titel)-5);
     with Standardzeichen do //normaler Text ohne Formatierungen
     begin
         Size:=12;
         Color:=Fenster.FeldInhalt.font.color;
      //   BkColor:=Fenster.Gliederung.color;
         hasBkClr:=false;
         Style:=[];
     end;
     with fenster.memogliederungen do
     begin
          SetRangeparams(0,1000,[ tmm_backcolor,
                                  tmm_Size,
                                  tmm_Color,
                                  tmm_styles],
                                  Standardzeichen,
                                  [],                //Attribute dazu
                                  [fsbold,fsunderline]); //Attribute weg
          anfang:= Search(titel,0,1000,[]);
          SetRangeParams(anfang, length(titel), [tmm_styles], '',0,  0, [fsbold,fsunderline], []);
     end;
end;

function formatmd(von,laenge:integer;highlightkeyword:boolean):boolean;
var
    Absatz:                 TParaRange;
    Abstand:                integer;
    Absatzformatieren:      boolean;
    anfang:                 integer;
    Anmerkung:              tparametric;
    code:                   boolean;
    ende:                   integer;
    Hintergrund:            TFontParams;
    i:                      integer;
    Ueberschrift:           tparametric;
    nummer:                 tparametric;
    StandardAbsatz:         tparametric;
    StandardZeichen:        TFontParams;
    tabulator:              integer;
    txt:                    string;
    windowsliste:           tparametric;
    urlcolor:               tcolor;
    wort:                   string;

begin
     if pos('#nowordwrap#',fenster.feldinhalt.lines.Text) > 0
     then code:=true else code:=false;

     if abstand <6 then Abstand:=6;
     if var_optiondarkmode
     then urlcolor:=clAqua //clgray
     else   urlcolor:=clblue;
     Fenster.Feldinhalt.font.size:=fsize;

     // #nowordwrap# prüfen. Ggf Format und Tabulatoren anpassen
     // --------------------------------------------------------
     if code then
     begin
          fenster.Feldinhalt.Font.Name:='Courier';
          if fenster.feldinhalt.wordwrap <> false then fenster.Feldinhalt.WordWrap:=false;
          fenster.feldinhalt.ScrollBars:=sshorizontal;
          InitTabStopList(StopList, [25]  );
          Abstand:= 0 ;
     end else begin  // Text, für den eine Tabulatorliste definiert wird
         fenster.Feldinhalt.Font.Name:=Zeichensatz;
         if fenster.feldinhalt.wordwrap <> true then fenster.Feldinhalt.WordWrap:=true;
         fenster.feldinhalt.ScrollBars:=ssnone;

         { unterschiedliche Auflösungen. Ein Multiplikator?
           Mac Mini mit Linux: 10
         }
         tabulator:= trunc(fsize *10 * skalierung);
         InitTabStopList(StopList, [ tabulator,
                                     tabulator+ fsize*2*skalierung,
                                     tabulator+ fsize*4*skalierung,
                                     tabulator+ fsize*8*skalierung
                                     ]);
         Abstand:= trunc(fsize/4) ;
     end;


     fenster.Feldinhalt.SetParaTabs(1, 9999, StopList);


     if laenge > length(Fenster.Feldinhalt.text) then
        laenge:= length(Fenster.Feldinhalt.text);


     // --- DEFINITION DER ABSATZFORMATE -----
     // --------------------------------------
     with Standardzeichen do //normaler Text ohne Formatierungen
     begin
         Size:=Fenster.Feldinhalt.Font.Size;
         name:= Zeichensatz;
         Color:=Fenster.FeldInhalt.font.color;
         BkColor:=Fenster.Feldinhalt.color;
         hasBkClr:=true;
         Style:=[];
     end;
     with Standardabsatz do
     begin
         SpaceBefore:=Abstand;
         SpaceAfter:=Abstand;
         Headindent := 0;
         Tailindent := 10; {Abstand vom Scrollbar 02/2024}
         FirstLine := 0;
     end;
     with Anmerkung do
     begin
         SpaceBefore:=Abstand;
         SpaceAfter:=Abstand;
         Headindent := 20;
         Tailindent := 20;
         FirstLine := 20;
     end;

     with WindowsListe do
     begin
         SpaceBefore:=0;
         SpaceAfter:=0;
         Headindent := 10;
         Tailindent := 10;
         FirstLine := 0;
     end;
     with Nummer do
     begin
         SpaceBefore:=0;
         SpaceAfter:=0;
         Headindent := 15;
         Tailindent := 10;
         FirstLine := 0;
     end;
     with Ueberschrift do
     begin
         SpaceAfter:=Abstand;
         SpaceBefore:=Abstand*5;
         Headindent := 0;
         Tailindent := 10;
         FirstLine := 0;
     end;

                                        { Wie soll der Hintergrund von hervor-
                                          gehobenem Text aussehen? Das hängt
                                          vom light/dark mode ab }
     if var_optiondarkmode then
        Hintergrund.BkColor:=$000095FF //clteal
     else
        Hintergrund.BkColor:=clyellow;

     Hintergrund.HasBkClr:=true;



     //Ist der Absatz ein Standardabsatz?
     Absatzformatieren:=true;
     if Fenster.FeldInhalt.Search('- ',von,laenge,[]) - von +1 = 1
     then Absatzformatieren := false;
     if Fenster.FeldInhalt.Search('# ',von,laenge,[]) - von +1 = 1
     then Absatzformatieren := false;
       { Bei a. oder 3. ist der Punkt erst der zweite Buchstabe.
         03/2024 }
     if Fenster.FeldInhalt.Search('. ',von,laenge,[]) - von +1 = 2
     then Absatzformatieren := false;
     if von=0 then Absatzformatieren:=true;
       { Der ganze Text soll von Anfang an formatiert werden 03/2024}


     if Absatzformatieren then Fenster.Feldinhalt.SetParametric(von,laenge,Standardabsatz);

     Fenster.Feldinhalt.SetRangeparams(von,laenge,[ tmm_backcolor,
                                                 tmm_Size,
                                                 tmm_Color,
                                                 tmm_styles],
                                                 Standardzeichen,
                                                 [],                //Attribute dazu
                                                 [fsbold,fsunderline,fsitalic]); //Attribute weg



     //------ fette und kursive Formatierung mit * bzw. **----
     //-------------------------------------------------------
     anfang:=Fenster.FeldInhalt.Search('*',von,laenge,[]);
     while anfang > -1 do
     begin
          if Fenster.Feldinhalt.gettext(anfang+1,1) = '*' then
          begin  //fett
               ende:= Fenster.FeldInhalt.Search('**',anfang+1,von+laenge-anfang,[]);
               if ende > 0 then
               begin
                 Fenster.FeldInhalt.SetRangeParams(anfang +2, ende-anfang-2, [tmm_styles], '',0,  0, [fsbold], []);
                 anfang:=ende+3; //ein Zeichen weiter als das zweite *
              end else begin
                  anfang:=-100;
              end;
          end else begin // kursiv
               ende:= Fenster.FeldInhalt.Search('*',anfang+1,von + laenge - anfang,[]);
               if ende > 0 then
               begin
                      Fenster.FeldInhalt.SetRangeParams(anfang +1, ende-anfang-1, [tmm_styles], '',0,  0, [fsitalic], []);
                      anfang:=ende+1;
               end else begin
                   anfang:=-100;
               end;
          end;
          if (anfang < ((von+laenge)-10)) and (anfang>0) then
             anfang:=Fenster.FeldInhalt.Search('*',anfang,von+laenge-anfang,[])
          else anfang:=-1;
     end;


     // ------------  Anmerkungen  ----------------
     //--------------------------------------------
     { Ein Absatz, der kursiv anfägt, wird beidseitig eingerückt. Ausnahme:
       Das Sternchen wird als Aufzählungszeichen verwendet.}
     anfang:=Fenster.FeldInhalt.Search('*',von,laenge,[]);
     while anfang > -1 do
     begin
          Fenster.FeldInhalt.GetParaRange(anfang,Absatz.start,Absatz.length);
          //prüfen, ob # am Absatzanfang steht...
          if   (Fenster.Feldinhalt.gettext(absatz.start,1) = '*')
          and  (Fenster.Feldinhalt.gettext(absatz.start,2) <> '* ')
          then  Fenster.Feldinhalt.SetParametric(anfang,1,Anmerkung);
          anfang:=Fenster.FeldInhalt.Search('*',anfang+1 ,von+laenge-anfang,[]);
     end;

     // ------------ Überschriften ----------------
     //--------------------------------------------
     anfang:=Fenster.FeldInhalt.Search('# ',von,laenge,[]);
     while anfang > -1 do
     begin
          Fenster.FeldInhalt.GetParaRange(anfang,Absatz.start,Absatz.length);
          //prüfen, ob # am Absatzanfang steht...
          if Fenster.Feldinhalt.gettext(absatz.start,2) = '# ' then
          begin
                //Absatzabstände
                Fenster.Feldinhalt.SetParametric(anfang,1,Ueberschrift);
                //Zeichensatz
                Fenster.FeldInhalt.SetRangeParams(Absatz.start, Absatz.length ,
                         [tmm_size, tmm_styles, tmm_color],
                         Zeichensatz,
                         fsize+2, fenster.Feldinhalt.font.color,
                         [fsbold], [fsunderline, fsStrikeOut]);
                //nächste Überschrift
          end;
          anfang:=Fenster.FeldInhalt.Search('# ',anfang+1 ,von+laenge-anfang,[]);
     end;

     // ------------ Spiegelstrich ----------------
     //--------------------------------------------
     anfang:=Fenster.FeldInhalt.Search('- ',von,laenge,[]);
     while anfang > -1 do
     begin
          Fenster.FeldInhalt.GetParaRange(anfang,Absatz.start,Absatz.length);
          if Fenster.Feldinhalt.gettext(absatz.start,2) = '- ' then
             Fenster.Feldinhalt.SetParametric(anfang,1,WindowsListe) ;
          anfang:=Fenster.FeldInhalt.Search('- ',anfang+1 ,von+laenge-anfang,[])
;
     end;


     // --------- Nummerierungen ----------------
     //------------------------------------------
     anfang:=Fenster.FeldInhalt.Search('. ',von,laenge,[]);
     while anfang > -1 do
     begin
          Fenster.FeldInhalt.GetParaRange(anfang,Absatz.start,Absatz.length);
          if Fenster.Feldinhalt.gettext(absatz.start+1,2) = '. ' then
          begin
             Fenster.Feldinhalt.SetParametric(anfang,1,Nummer);
          end ;
          anfang:=Fenster.FeldInhalt.Search('. ',anfang+1 ,von+laenge-anfang,[]);
     end;


     //------------------ HTTP -------------
     //-------------------------------------
     anfang:=Fenster.FeldInhalt.Search('http',von,laenge,[]);
     while anfang > -1 do
     begin
          txt:=Fenster.Feldinhalt.gettext(anfang,150);
          while pos(#10,txt) > 0 do txt:=copy(txt,1,length(txt)-1);
          while pos(' ',txt) > 0 do txt:=copy(txt,1,length(txt)-1);
          Fenster.FeldInhalt.SetRangeParams( anfang, length(txt),
                                             [tmm_styles, tmm_color], '',0,
                                             urlcolor,[fsunderline], []);

          anfang:=Fenster.FeldInhalt.Search('http',anfang+1 ,von+laenge-anfang,[]);
     end;

     //------------------ FILE -------------
     //-------------------------------------
     anfang:=Fenster.FeldInhalt.Search('file://',von,laenge,[]);
     while anfang > -1 do
     begin
          txt:=Fenster.Feldinhalt.gettext(anfang,150);
          while pos(#10,txt) > 0 do txt:=copy(txt,1,length(txt)-1);
          while pos(#13,txt) > 0 do txt:=copy(txt,1,length(txt)-1);
          while pos(' ',txt) > 0 do txt:=copy(txt,1,length(txt)-1);

          Fenster.FeldInhalt.SetRangeParams( anfang, length(txt),
                                             [tmm_styles, tmm_color], '',0,
                                             urlcolor,[fsunderline], []);
          anfang:=Fenster.FeldInhalt.Search('file://',anfang+1 ,von+laenge-anfang,[]);
     end;

     //------------------ ref:// -------------
     //---------------------------------------
     anfang:=Fenster.FeldInhalt.Search('ref://',von,laenge,[]);
     while anfang > -1 do
     begin
         txt:=Fenster.Feldinhalt.gettext(anfang,150);
         while pos(#10,txt) > 0 do txt:=copy(txt,1,length(txt)-1);
         while pos(#13,txt) > 0 do txt:=copy(txt,1,length(txt)-1);
         while pos(' ',txt) > 0 do txt:=copy(txt,1,length(txt)-1);
         Fenster.FeldInhalt.SetRangeParams( anfang, length(txt),
                                            [tmm_styles, tmm_color], '',0,
                                            urlcolor,[fsunderline], []);

          anfang:=Fenster.FeldInhalt.Search('ref://',anfang+1 ,von+laenge-anfang,[]);
     end;

     //------------------ note:// -------------
     //---------------------------------------
     anfang:=Fenster.FeldInhalt.Search('note://',von,laenge,[]);
     while anfang > -1 do
     begin
         txt:=Fenster.Feldinhalt.gettext(anfang,150);
         while pos(#10,txt) > 0 do txt:=copy(txt,1,length(txt)-1);
         while pos(#13,txt) > 0 do txt:=copy(txt,1,length(txt)-1);
         while pos(' ',txt) > 0 do txt:=copy(txt,1,length(txt)-1);
         Fenster.FeldInhalt.SetRangeParams( anfang, length(txt),
                                            [tmm_styles, tmm_color], '',0,
                                            urlcolor,[fsunderline], []);

        anfang:=Fenster.FeldInhalt.Search('note://',anfang+1 ,von+laenge-anfang,[]);
     end;
     //------------------ [= =] -------------
     //---------------------------------------
     anfang:=Fenster.FeldInhalt.Search('[=',von,laenge,[]);
     while anfang > -1 do
     begin
     txt:=Fenster.Feldinhalt.gettext(anfang,150);
     while pos(']',txt) > 0 do txt:=copy(txt,1,length(txt)-1);
     Fenster.FeldInhalt.SetRangeParams( anfang, length(txt)+1,
                                        [tmm_styles, tmm_color], '',0,
                                        urlcolor,[fsunderline], []);

          anfang:=Fenster.FeldInhalt.Search('[=',anfang+1 ,von+laenge-anfang,[]);
     end;

     //------------------ [[ ]] -------------
     //---------------------------------------
     anfang:=Fenster.FeldInhalt.Search('[[',von,laenge,[]);
     while anfang > -1 do
     begin
     txt:=Fenster.Feldinhalt.gettext(anfang,150);
     while pos(']',txt) > 0 do txt:=copy(txt,1,length(txt)-1);
     Fenster.FeldInhalt.SetRangeParams( anfang, length(txt)+2,
                                        [tmm_styles, tmm_color], '',0,
                                        urlcolor,[fsunderline], []);

          anfang:=Fenster.FeldInhalt.Search('[[',anfang+1 ,von+laenge-anfang,[]);
     end;


     //------------------ #pin# #lock# usw.  -------------
     //---------------------------------------------------

       { Bei den #...# gibt es maximal einen Eintrag. Man kann also gleich
         den ganzen Text durchsuchen.
         Problem: Wenn der Tag ganz am Ende ist, wird das letzte # nicht
         erkannt. Daher nur #pin und nicht #pin#. 02/2024 }
     anfang:=Fenster.FeldInhalt.Search('#pin',0,10000,[]);
     if anfang > -1 then
          Fenster.FeldInhalt.SetRangeParams( anfang+1, 3,
                                             [tmm_styles, tmm_color], '',0,
                                             clred,[fsunderline], [fsbold,fsitalic]);
     anfang:=Fenster.FeldInhalt.Search('#lock',0,10000,[]);
     if anfang > -1 then
          Fenster.FeldInhalt.SetRangeParams( anfang+1, 4,
                                             [tmm_styles, tmm_color], '',0,
                                             clred,[fsunderline], [fsbold,fsitalic]);
     anfang:=Fenster.FeldInhalt.Search('#tag',0,10000,[]);
     if anfang > -1 then
          Fenster.FeldInhalt.SetRangeParams( anfang+1, 3,
                                             [tmm_styles, tmm_color], '',0,
                                             clred,[fsunderline], [fsbold,fsitalic]);
     anfang:=Fenster.FeldInhalt.Search('#hide',0,10000,[]);
     if anfang > -1 then
          Fenster.FeldInhalt.SetRangeParams( anfang+1, 4,
                                             [tmm_styles, tmm_color], '',0,
                                             clred,[fsunderline], [fsbold,fsitalic]);



     //------------------ Suchbegriffe im text hervorheben ---
     //-------------------------------------------------------
     if fenster.RegisterSuche.Activepage = Fenster.SeiteVolltextSuche then
     begin
         txt:=Fenster.Sucheingabe.text;
         while length(txt) > 0 do
         begin
             wort:=getfirstword(txt);
             txt:=deletefirstword(txt);
             anfang:=Fenster.FeldInhalt.Search(wort,von,laenge,[]);
             while anfang > -1 do

             begin
                  Fenster.Feldinhalt.SetRangeParams(anfang,length(wort),[tmm_BackColor],Hintergrund, [], []);
                  anfang:=Fenster.FeldInhalt.Search(wort,anfang+1 ,von+laenge-anfang,[]);
              end;
         end;
     end;

    //------------- Schlagwörter --------------
    //-----------------------------------------
         //08/2024: Wird jetzt in Fußzeile angezeigt.
    if highlightkeyword then
    begin
          for i:=0 to swliste.count -1 do
          begin
               anfang:=von;
               wort:=swliste[i];
               anfang:= Fenster.FeldInhalt.Search(wort,0,laenge,[]) ;
                   { ganz am Ende des Textes wird der Begriff nicht gefunden. Das hat
                     nichts mit Umlauten zu tun. Es scheint ein Fehler in richmemo zu
                     sein. Mir fällt keine Lösung ein 03/2024}
               while anfang > -1 do
               begin
               Fenster.Feldinhalt.SetRangeParams(anfang,length(wort),[tmm_BackColor],Hintergrund, [], []);

                   anfang:= Fenster.FeldInhalt.Search(wort,anfang+2,von+laenge-anfang,[]);
               end;
          end;
   end;

end;

//--- ENDE DER FUNKTIONEN -----------------
//-----------------------------------------



procedure TFenster.OptionMarkiertZeigenChange(Sender: TObject);
begin
  if sucheingabe.Text = '' then
    AlleAnzeigenClick(self)
  else
    SucheingabeClick(self);
end;

procedure TFenster.ImageNachLinksClick(Sender: TObject);
var
  Unten, Oben, drei: TTreeNode;
  //03/2021 Bugs behoben, die bei Einträgen mit Untereinträgen auftraten
begin
  if gliederung.selected <> nil then
  begin
    Unten := Gliederung.Selected;
    if Unten.Parent <> nil then
    begin
      if unten.HasChildren then
      begin
           oben := unten.parent;
           unten.MoveTo(oben, naInsert);
           oben.Expand(True);
      end else begin
          oben := unten.parent;
          drei := Gliederung.items.add(oben, Gliederung.Selected.Text);
          unten.Delete;
          oben.Expand(True);
          drei.Selected := True;
      end;
    end;
    Gliederung.savetoFile(DBDirectory + Gliederungsdatei);
  end;

end;

procedure TFenster.IconTitelDatenWegClick(Sender: TObject);
begin
     Registerkarten.Activepage:=Ideenseite;
end;

procedure TFenster.ImageNachRechtsClick(Sender: TObject);
var
  Unten, Oben, drei: TTreeNode;
  //03/2021 Bugs behoben, die bei Einträgen mit Untereinträgen auftauchen
begin
  if Gliederung.selected <> nil then
  begin
    Unten := Gliederung.Selected;
    if Unten.GetnextSibling <> nil then  //es gibt einen Eintrag auf glelicher Ebene weiter unten
    begin
          if unten.HasChildren then
          begin
               oben := unten.getnextsibling;
               if oben <> nil then unten.MoveTo(oben, naAddChild);
               oben.Expand(True);
          end else begin
              oben := unten.getnextsibling;
              if oben <> nil then
              begin
                   drei := Gliederung.items.addChild(oben, Gliederung.Selected.Text);
                   unten.Delete;

              end;
              oben.Expand(True);
              drei.Selected := True;
          end;
    end;
    GliederungSpeichern(DBDirectory + Gliederungsdatei);
  end;

end;

procedure TFenster.ImageNachUntenClick(Sender: TObject);
var
  tmpNode,  drei: TTreeNode;
  l: integer;
begin
  if Gliederung.selected <> nil then
  begin
    tmpNode := Gliederung.Selected;
    l := tmpnode.level;
    if tmpnode.getnextsibling <> nil then //Es gibt noch Punkte weiter unten
    begin
      if tmpnode.getnextsibling.getnextsibling <> nil then
        // noch mindestens zwei
      begin
        tmpNode.MoveTo(tmpNode.getNextSibling.getNextSibling, naInsert);
        if Gliederung.selected.level > 0 then
          Gliederung.selected.Parent.Expand(True);
      end
      else
      begin  // es ist der vorletzte und muss jetzt auf den letzten Platz
        drei := Gliederung.Items.Add(tmpnode.GetnextSibling, 'xxx');
        tmpNode.MoveTo(drei, naInsert);
        drei.Delete;
        if Gliederung.selected.level > 0 then
          Gliederung.selected.Parent.Expand(True);
      end;
    end
    else
    begin // letzter Eintrag auf der Ebene
      if l > 0 then
      begin
        if tmpnode.parent.getnext <> nil then
        begin
          if tmpnode.Parent.GetNext.Getnext <> nil then
            // noch mindestens zwei
          begin
            drei :=
              Gliederung.Items.AddChild(tmpnode.Parent.GetnextSibling, Gliederung.selected.Text);
            tmpNode.MoveTo(drei, naInsert);
            drei.Delete;
            if Gliederung.selected.level > 0 then
              Gliederung.selected.Parent.Expand(True);
          end
          else
          begin //der letzte Unterpunkt des letzten Oberpunkts
            //nix tun, weil nichts mehr weiter unten ist.

          end;
        end;

      end;

    end;
    GliederungSpeichern(DBDirectory + Gliederungsdatei);
  end;

end;

procedure TFenster.ImageNachObenClick(Sender: TObject);
var
  tmpNode, drei: TTreeNode;
begin
  if gliederung.selected <> nil then
  begin
    tmpNode := Gliederung.Selected;
    if tmpNode.getPrevSibling <> nil then
    begin
      tmpNode.MoveTo(tmpNode.getPrevSibling, naInsert);
    end
    else
    begin   // erster Punkt auf der Ebene
      if tmpnode.Parent <> nil then  //  Gibt es einen Oberpunkt?
      begin
        if tmpnode.parent.GetPrev <> nil then
          //Hat der Oberpunkt noch einen Vorgänger?
        begin
          drei := Gliederung.Items.addchild(
            tmpnode.parent.GetPrev, Gliederung.selected.Text);
          tmpNode.MoveTo(drei, naInsert);
          drei.Delete;
          Gliederung.selected.Parent.Expand(True);
        end;
      end;
    end;
    GliederungSpeichern(DBDirectory + Gliederungsdatei);
  end;

end;

procedure TFenster.Label10Click(Sender: TObject);
begin
  PtypWebseite.checked:=not PTypWebseite.Checked;
end;

procedure TFenster.LabelOptionBibtexClick(Sender: TObject);

begin

end;

procedure TFenster.LabelHerausnehmenClick(Sender: TObject);
begin

  if Gliederung.selected <> nil then
  begin
                                //Unterpunkte löschen, falls vorhanden (03/2023)
   if Gliederung.selected.count > 0 then
          Gliederung.Selected.DeleteChildren;
                                //
   Gliederung.Items.Delete(Gliederung.Selected);
   if gliederung.items.count > 1 then
      GliederungSpeichern(DBDirectory + Gliederungsdatei);
   GliederungArrayEinlesen();

   timer.Enabled:=true;
  end;
end;

procedure TFenster.LabelNachObenClick(Sender: TObject);
var
  tmpNode, drei: TTreeNode;
begin
  if gliederung.selected <> nil then
  begin
    tmpNode := Gliederung.Selected;
    if tmpNode.getPrevSibling <> nil then
    begin
      tmpNode.MoveTo(tmpNode.getPrevSibling, naInsert);
    end
    else
    begin   // erster Punkt auf der Ebene
      if tmpnode.Parent <> nil then  //  Gibt es einen Oberpunkt?
      begin
        if tmpnode.parent.GetPrev <> nil then
          //Hat der Oberpunkt noch einen Vorgänger?
        begin
          drei := Gliederung.Items.addchild(
            tmpnode.parent.GetPrev, Gliederung.selected.Text);
          Gliederung.selected.Delete;
          drei.selected := True;
          Gliederung.selected.Parent.Expand(True);

        end;

      end;
    end;

  end;

end;

procedure TFenster.LabelNachUntenClick(Sender: TObject);
var
  tmpNode, nxt, drei: TTreeNode;
begin
  if Gliederung.selected <> nil then
  begin
    tmpNode := Gliederung.Selected;
    if tmpNode.getNextSibling <> nil then
    begin

      tmpNode.MoveTo(tmpNode.getNextSibling.getNextSibling, naInsert);
    end
    else
    begin  //letzter Punkt auf der Ebene
      if tmpnode.parent.getnextsibling <> nil then
        // es gibt noch einen weiteren Unterpunkt
      begin
        nxt := tmpnode.parent;
        nxt := nxt.GetNextSibling;
        drei := Gliederung.Items.AddChild(nxt, Gliederung.selected.Text);
        Gliederung.selected.Delete;
        drei.selected := True;
        Gliederung.selected.Parent.Expand(True);
      end;
    end;

  end;
end;

procedure TFenster.LabelAufnehmenClick(Sender: TObject);
var
  punkt: Ttreenode;
  zit:string;
begin

  //Eintrag in die Gliederung
  zit:=GV_Titel ;//+ abstand + '(#' + GV_FeldNummer;
  if  AngezeigterTyp='N'       then
       zit:=GV_Titel + abstand + '(#' + GV_FeldNummer
  else
       zit:=GV_Titel + abstand + '(LI' + GV_FeldNummer ;

  if (RegisterSuche.Activepage=SeiteGliederung)  then
       begin
              if gliederung.selected <> nil then
              begin
                   punkt := Gliederung.Items.AddChild(Gliederung.Selected, zit );
                   Gliederung.selected.Expand(True);
              end else begin  // kein Eintrag ausgewählt, also ans ende
                  punkt := Gliederung.Items.Add(nil, zit );
                  Gliederung.Fullexpand;
                  GliederungArrayEinlesen();
                  timer.Enabled:=true;
              end;
              GliederungSpeichern(DBDirectory + Gliederungsdatei);
  end else begin //das Gliederungsfenster ist nicht sichbar
           IconGliederungClick(self);
           punkt := Gliederung.Items.Add(nil,zit );
           Gliederung.Fullexpand;

  end;
  GliederungArrayEinlesen();
  punkt.Selected := True;
  Registerkarten.Activepage:=IdeenSeite;
end;

procedure TFenster.MenuIdeenSchlagwortClick(Sender: TObject);
begin
  IconSchlagwortClick(self);
end;

procedure TFenster.MenuSuchenVolltextClick(Sender: TObject);
begin
  Registerkarten.ActivePage := IdeenSeite;
  FocusTo('Sucheingabe');
end;

procedure TFenster.LabelModulStylerClick(Sender: TObject);
begin
  Registerkarten.Activepage:=StyleSeite;
end;


procedure TFenster.ListeClick(Sender: TObject);
var
  ArrayZeileUrsprung: integer;
  LinkUrsprung:       string;
  LinkZiel:           string;
begin
    timer.enabled:=false;
    if (RegisterSuche.Activepage=SeiteGliederung) then
    begin
               Gliederung.SelectionColor:=clgray;
               gliederung.Refresh;
    end;



    //---ein Link erzeugen
    //--------------------
    if GetkeyState(VK_SHIFT) < 0  then
    begin
         LinkZiel:=TrefferArray[liste.row,3] + TrefferArray[liste.row,5]; //L1234
         if AngezeigterTyp='N' then   //die Variable ist noch nicht angepasst
         begin
              ArrayZeileUrsprung:=HolArrayZeileDerNotizID(AktuelleNotizID);
              LinkUrsprung:= 'N' + IntToStr(ArrayZeileUrsprung);
         end;
         if AngezeigterTyp='L' then
         begin
              ArrayZeileUrsprung:=HolArrayZeileDerLiteraturID(AktuelleLiteraturID);
              LinkUrsprung:= 'L' +  InttoStr(ArrayZeileUrsprung);
         end;
         ErzeugeBidirektoralesLink(LinkUrsprung,LinkZiel);

    end;



    if trefferarray[liste.row,4] = '' then //leerer Datensatz
    begin
         liste.row:=0;
    end;
    LetzterFokus:='Liste';
    AnzeigeModus:='volltextsuche';
    timer.enabled:=true;
end;

procedure TFenster.ListeMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
begin
  FocusTo('Liste');
  timer.Enabled := false;
  timer.Enabled := True;


end;




procedure TFenster.NeueKarteClick(Sender: TObject);


begin
     if schreibrecht() then
     begin
           if istextchanged then  saveChangestoArray();
           RegisterSuche.activepage:=SeiteVolltextsuche;
           machpause();
           EingabeTitelneueNotiz.text:='';
           OptionMitverweis.checked:=false;
           PanelNeueQuelle.height:= trunc(165*Skalierung);
           resizewindow();
           FocusTo('EingabeTitelNeueNotiz');


           VerweisAnfangTyp:=TrefferArray[Liste.Row,3] ;
     end;



end;



procedure TFenster.IdeenSpeichernClick(Sender: TObject);

begin
  if RegisterSuche.Activepage=SeiteVolltextsuche then  ListeClick(self);
  if Schreibrecht() then
  begin
      if ichanged then
      begin
           DatenArrayKomplettSichern();
           IneedsSorting:=true;

      end;

  end;

  ichanged:=false;
end;

procedure TFenster.SuchEingabeClick(Sender: TObject);
var
  begriff: string;
  i,j: integer;
  trefferzahl: integer;
  treffer:boolean;
begin

  trefferzahl := 1;
  if Registersuche.activepage=SeiteVolltextsuche then
     Begriff:=Sucheingabe.text;
  if Registersuche.activepage=SeiteGliederung then
     Begriff:=Sucheingabe2.text;
  begriff:=trim(begriff);
  if length(begriff) >1 then
  begin
       VollTextKomplettieren();  //Muss der Volltext noch zu ende erstellt werden?
       for i:=0 to 1000 do for j:=1 to TrefferArraySpalteVolltext do TrefferArray[i,j]:='';
       suchbegriffe(begriff);
       AktuelleNotizSuche:=begriff;
       Liste.Rowcount := maxanzeige+1;

     //--Notizen durchsuchen--
     //-----------------------
     if length(bis) + length(ab) < 2 then  { bei Einschränkung der Jahreszahl
                                             sind die Notizen sofort raus }
     begin
           if menunotizenzeigen.checked then
           begin
               for i := ArraySize_Daten downto 1  do
               begin
                    Treffer:=true;
                    if Treffer then if Trefferzahl >= (MaxAnzeige/2) then Treffer:=false;
                    if Treffer then if (pos(s1, daten[i, Spalte_Volltext]) = 0) then Treffer:=false;
                    if Treffer then if (pos(s2, daten[i, Spalte_Volltext]) = 0) then Treffer:=false;
                    if Treffer then if (pos(s3, daten[i, Spalte_Volltext]) = 0) then Treffer:=false;
                    if Treffer then if (pos(s4, daten[i, Spalte_Volltext]) = 0) then Treffer:=false;
                    if Treffer then if (pos(s5, daten[i, Spalte_Volltext]) = 0) then Treffer:=false;
                    if Treffer then
                       if length(MinusBegriff1)>2 then
                          if (pos(MinusBegriff1, daten[i, Spalte_Volltext]) > 0)
                          then Treffer:=false;
                    if Treffer then
                       if length(MinusBegriff2)>2 then
                          if (pos(MinusBegriff2, daten[i, Spalte_Volltext]) > 0)
                          then Treffer:=false;
                    if Treffer then if  (pos('#tag#',Daten[i, Spalte_Anmerkung]) =0 ) and   (MenuNurMarkierte.Checked)  then Treffer:=false;
                    if pos('#pin#', Daten[i, Spalte_Anmerkung])> 0 then treffer:=true;
                    //Aufruf auf der Hauptseite
                    if treffer  then
                    begin
                         if pos('#tag#', Daten[i, Spalte_Anmerkung]) > 0 then
                            Trefferarray[trefferzahl,1]:='*';
                         Trefferarray[trefferzahl,3]:='N';                    //Typ
                         Trefferarray[trefferzahl,4]:=daten[i,1];             //ID
                         Trefferarray[trefferzahl,5]:=inttostr(i);            //Zeile im Array
                         Trefferarray[trefferzahl,TrefferArraySpalteTitel]:= daten[i,Spalte_Titel];
                         Trefferarray[trefferzahl,7]:= copy(daten[i,Spalte_Anmerkung],1,10000) ;  //Inhalt der Anmerkung
                         Trefferarray[trefferzahl,TrefferArraySpalteBearbeitung]:= daten[i,Spalte_Bearbeitungsdatum];             //Zeit

                           { damit die angepinnten ganz oben angezeigt werden liegt das
                             letzte Bearbeitungsatum in der Zukunft. Das wird in knapp
                             8.000 Jahren Ärger geben. 03/2024    }
                         if pos('#pin#', Daten[i, Spalte_Anmerkung])> 0 then
                            Trefferarray[trefferzahl,TrefferArraySpalteBearbeitung]:= '999';

                         trefferzahl := trefferzahl + 1;
                    end;

               end;
           end;

     end;
     //--Literatur durchsuchen--
     //-----------------------
     if menuLiteraturzeigen.checked then
     begin
           for i:= arraysize_Literatur downto 1 do
           begin
                  Treffer:=true;
                  if Trefferzahl >= Maxanzeige then Treffer:=false;
                  if Treffer then if (pos(s1, Literatur[i, Spalte_Volltext]) = 0) then Treffer:=false;
                  if Treffer then if (pos(s2, Literatur[i, Spalte_Volltext]) = 0) then Treffer:=false;
                  if Treffer then if (pos(s3, Literatur[i, Spalte_Volltext]) = 0) then Treffer:=false;
                  if Treffer then if (pos(s4, Literatur[i, Spalte_Volltext]) = 0) then Treffer:=false;
                  if Treffer then if (pos(s5, Literatur[i, Spalte_Volltext]) = 0) then Treffer:=false;
                  if Treffer then
                     if length(MinusBegriff1)>1 then
                        if (pos(MinusBegriff1, Literatur[i, Spalte_Volltext]) > 0)
                        then Treffer:=false;
                  if Treffer then
                     if length(MinusBegriff2)>1 then
                        if (pos(MinusBegriff1, Literatur[i, Spalte_Volltext]) > 0)
                        then Treffer:=false;
                  if Treffer then if (pos('#tag#',Literatur[i, Spalte_Anmerkung]) =0 )
                                  and (MenuNurMarkierte.Checked)  then Treffer:=false;
                  if pos('#pin#',Literatur[i, Spalte_Anmerkung]) > 0 then Treffer:=true;
                  if Treffer then
                  begin
                       if length(ab)=4 then
                       begin
                            if Literatur[i,Spalte_Jahr] <= ab then Treffer:=false;
                       end;
                  end;
                  if (Treffer) and  (length(bis)=4) then
                       if Literatur[i,Spalte_Jahr] >= bis then Treffer:=false;



                  if treffer then
                  begin
                       if pos('#tag#',Literatur[i, Spalte_Anmerkung]) > 0 then
                          Trefferarray[trefferzahl,1]:='*';
                       Trefferarray[trefferzahl,3]:='L';                    //Typ
                       Trefferarray[trefferzahl,4]:=Literatur[i,1];         //ID
                       Trefferarray[trefferzahl,5]:=inttostr(i);            //Zeile im Array
                       Trefferarray[trefferzahl,TrefferArraySpalteTitel]:=Literatur[i,Spalte_Erstautor] + ' ('+  Literatur[i,Spalte_Jahr] + ') '  +  Literatur[i,Spalte_Titel] ;           //Titel
                       Trefferarray[trefferzahl,7]:=copy(Literatur[i,Spalte_Anmerkung],1,1000) ;  //Textanfang
                       Trefferarray[trefferzahl,TrefferArraySpalteBearbeitung]:=Literatur[i,Spalte_Bearbeitungsdatum];

                       //damit die angepinnten ganz oben angezeigt werden 03/2024
                       if pos('#pin#',Literatur[i, Spalte_Anmerkung]) > 0 then
                        Trefferarray[trefferzahl,TrefferArraySpalteBearbeitung]:= '999';

                       trefferzahl := trefferzahl + 1;

                  end;
           end;

     end;





        //Liste sortieren
        if (trefferzahl  <= maxanzeige) and (trefferzahl > 1) then
           if (not MenuSortAlpha.checked) then
              TrefferlisteSortieren('zeit')
           else
             TrefferlisteSortieren('alphabet');
        MachPause();

        //in die Kompaktliste übertragen
        Liste.rowcount:=1;
        Liste.rowcount :=Trefferzahl+1;


        for i:=0 to Trefferzahl-1 do  Liste.Cells[ListeSpaltetitel, i] := Trefferarray[i,TrefferArraySpalteTitel]  ;  //der Rest sind Bilder

        LeereListenZeilenAmEndeLoeschen(); //falls das notwendig ist.

        if registerkarten.activepage=IdeenKopierenSeite then
          ListeIdeenKopierenLinks.rowcount:=  liste.rowcount;

      if Registerkarten.activepage=IdeenSeite then
      begin
          TrefferzahlAnzeigen();
      end;



      if PanelKombinierterSchlagwoerter.height > 100 then GrenzeSchlagwortsucheEinClick(self);
      { In die Liste auf der Gliederungsseite übertragen. Brauch ich
        vielleicht nicht, kostet aber nix.}
      ListeNotizGliedern.Items.clear;
      for i:=0 to liste.rowcount do
           listeNotizGliedern.Items.Add(Trefferarray[i, TrefferArraySpalteTitel]);
      ListeSchieberHeight();
      Scrollbarlisteschieber.top:=10;

  end else begin //die Suchanfrage ist leer
      //  AlleAnzeigenClick(self);
  end;

end;

procedure TFenster.SuchEingabeKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);

begin
  timer.enabled:=false;   //muss wechseln, sonst springt der timer sofort an

  if   registerkarten.activepage <> ideenseite
  then registerkarten.activepage := ideenseite  ;
  if (Registersuche.activepage <> SeiteVolltextsuche)
  then registersuche.activepage:=SeiteVolltextsuche;

  if key = VK_DOWN    then liste.row:=liste.row+1;
  if key = VK_UP      then liste.row:=liste.row-1;


  if key in [vk_f1..vk_f9] then
  begin
       machpause();
       FocusTo('PanelHintergrundOben');
       formkeydown(self,key,shift);
       key:=0;
  end;
  if key = vk_return  then SucheingabeClick(self);

  LetzterFokus:='Sucheingabe';

end;

procedure TFenster.TimerTimer(Sender: TObject);


var
  DatensatzTitel:    string;
  focussuche:        boolean;
  h,i,j:             integer;
  idltime:           integer;
  meintext:          string;
  scrollbaroben:     integer;
  spaltenzahl:       integer;
  textlaenge:        integer;
  wort:              string;
  ZahlDerVerweise:   integer;
begin
  Timer.Enabled := False;
  Timer.Interval:=500;



  { idle time für Zwischenspeichern }
  idltime:= trunc(100000/ungespeicherteZeichen); //500 Zeichen = 200 sekunden
  if idltime < 10 then idltime := 1000; // falls Null
  if idltime < 10 then idltime:=10; { 10 Sek. als Minimalintervall }
  if idltime < 180 then
  begin
       zwischenspeichern.Enabled:=false;
       Zwischenspeichern.interval:=idltime * 1000;
       zwischenspeichern.enabled:=true;
  end else begin
       if zwischenspeichern.enabled=true then zwischenspeichern.enabled:=false;
  end;




  //Suche sollte immer aufgerufen werden.
  //SuchAnfragefiltern(sucheingabe.text);
  if (length(sucheingabe.Text) > 2) then
  begin
      if (trim(ansilowercase(AktuelleNotizsuche))) <>
          (trim(ansilowercase(sucheingabe.text))) then
      begin
            //suchanfrage starten, aber nur bei Änderung.
            //Sonst wird jedesmal SeiteNeu gefiltert
            SucheingabeClick(self);
            UndoText:='';
       end;
  end;

  //Von wo aus wird aufgerufen?


  if (AnzeigeModus='volltextsuche') then
  begin
      if liste.width-Liste.Colwidths[ListeSpalteTitel]>100 then formresize(self);
         { aus irgendwelchen Gründen wird bei einigen Nutzern die Spaltenbreite
           beim Start nicht korrekt angepasst und ist viel zu schmal. Ein Resize
           funktioniert aber. Hier wird abgetestet, ob das notwendig ist.
           02/2024}

      if Trefferarray[liste.row,3]='N' then
      begin
           AngezeigterTyp:='N';
           DatensatzTitel:=Trefferarray[liste.row,TrefferArraySpalteTitel];
           AktuelleNotizID:=Trefferarray[liste.row,4];
      end;
      if Trefferarray[liste.row,3]='L' then
      begin
           AngezeigterTyp:='L';
           AktuelleLiteraturID:=Trefferarray[liste.row,4] ;
      end;
      machpause();
  end;




  //---- GLIEDERUNG----
  //-------------------
  if AnzeigeModus='gliederung' then
  begin
        Gliederung.Refresh; // In GliederungCustomDrawItem wird der
                            // (falls vorhanden)
                            // Gliederungseintrag dieser Notiz fettgedruckt
        ListeNotizGliedern.items.Clear;
        for i:=0 to liste.rowcount do
            ListeNotizGliedern.items.add(Trefferarray[i,TrefferArraySpalteTitel]);

  end;

  //-- VOLLTEXTSUCHE ---
  //--------------------
  if (RegisterKarten.ActivePage = IdeenSeite)
  then
  begin
        PanelFeldinhaltIcons.visible:=true;
        UnterstrichPin.visible:=false;
        UnterstrichStern.visible:=false;
        machpause();

        //showmessage('100');


         // Finetuning der Position des Scrollbar-Schiebers
         ScrollbarOben:= trunc( ScrollbarlisteHintergrund.Height *
                                Liste.row / liste.rowcount);
         If Scrollbaroben > ScrollbarlisteHintergrund.Height -
                            ScrollbarListeSchieber.height
         then ScrollbarOben := ScrollbarlisteHintergrund.Height -
                               ScrollbarListeSchieber.height;
         ScrollbarListeSchieber.top:=ScrollbarOben ;

        //---- NOTIZ ----
        //---------------
        if AngezeigterTyp='N' then   //Notiz aufgerufen
        begin
            DatensatzAufrufen(DatenSatzTitel); //mit dem Titel aufrufen

            feldinhalt.borderspacing.top:=trunc(30*Skalierung) ;
            feldinhalt.borderspacing.right:=trunc(30*Skalierung);
            PanelVollzitat2.Visible:=false;

            machpause();
        end;
        //---- LITERATURQUELLE ----
        //-------------------------
        if AngezeigterTyp='L' then
        begin
              if length(AktuelleLiteraturID) > 0 then
              begin
                   LiteraturIdAnzeigen(AktuelleLiteraturID);

                   //Anzeige des formatierten Zitats über den Anmerkungen
                   LabelVollzitat.Font.name:=Zeichensatz;
                   LabelVollzitat.caption:=QuelleInRTFFormatieren(false);
                   LabelVollzitat.Font.size:=fsize;
                   LabelVollzitat.font.color:=Feldinhalt.font.color;

                   //Höhe der Vollzitatanzeige
                   textlaenge:= trunc(length(labelvollzitat.caption)*Feldinhalt.font.size/12);
                   h:= trunc(140*Skalierung);
                   if textlaenge < 140 then  h:=  trunc(120*Skalierung)  ;
                   if textlaenge < 90 then   h:=  trunc(110*Skalierung);

                   PanelVollzitat2.height:= h;
                   feldinhalt.borderspacing.top:=PanelVollzitat2.height+trunc(20*Skalierung);

                   PanelVollzitat2.width:=PanelInhalt.width ;
                   PanelVollzitat2.Visible:=true;

                   LabelVollzitat.align:=alclient;
                   LabelFussnote.Caption:='[=' + AktuelleLiteraturID + '=]';
                   if Literatur[AktuelleLiteraturArrayZeile,Spalte_Position]<>'' then
                   machpause();


              end;

         end;

         //den Text nach Merkmalen durchsuchen. 12/2025 mit Titel und Vollzitat
         meintext:=ansilowercase(Feldinhalt.Lines.text + ' ' +  labeltitel.text );
         if LabelVollzitat.visible
         then meintext:=meintext + ' ' + ansilowercase(LabelVollzitat.Caption);

         //für die Unterstriche
         if pos('#tag#',meintext)>0 then UnterstrichStern.visible:=true;
         if pos('#pin#',meintext)>0 then UnterstrichPin.visible:=true;


         //Scrollbar der Anmerkungen positionieren. Bei Notizen und Literatur gleich
         ScrollbarAnmerkungen.borderspacing.top:=feldinhalt.borderspacing.top+trunc(10*Skalierung);
         ScrollbarAnmerkungenSchieber.align:=altop;
         ScrollbarAnmerkungenSchieber.height := ScrollbarAnmerkungen.height - 125;

         machpause();

        if feldinhalt.visible then formatmd(0,10000,false);

        UndoText:=Feldinhalt.Lines.text;
        IconUndo.Visible:=False;
        IsTextChanged:=false;




        //Falls nicht viel Text im Feld steht, zum Ende springen
        if length(Feldinhalt.Lines.text) < 450 then Feldinhalt.selstart:= 450;




        //------------------------
        //---FUSSZEILE MIT VERWEISEN FORMATIEREN
        //------------------------
          { Die Formatierung der Querverweise ist relativ aufwändig. Es sollen
            einerseits möglichst drei Spalten angezeigt werden, die aber nicht
            zu gedrängt aussehen sollen. Bei zwei Spalten sollen die Spalten
            nicht zu weit auseinanderstehen, sondern halbwegs dicht beieinander
            Die Querverweise werden eingekürzt, damit die Einträge in einer
            Spalte jeweils nicht allzu unterschiedlich lang und die Spalten
            nicht unnötig breit sind             02/2024 }

        ZahlDerVerweise:=0;
        for i:=1 to 100 do
            if length(Verweisarray[i,1]) > 2
               then ZahlDerVerweise:=ZahlDerVerweise + 1
               else Verweisarray[i,1]:='';

          { jetzt weiß ich, wie viele Verweise es unterzubringen gilt
            maximal 100 }


                                 { reicht der Platz für 3 Spalten ?}
        if Paneltitel.width > 800 then spaltenzahl:=3
        else spaltenzahl:=2;
        if ZahlDerVerweise < 7 then Spaltenzahl:=2;
        if ZahlDerVerweise < 4 then Spaltenzahl:=1;

        {jetzt weiß ich, wie viele Spalten zu füllen sind}




        //In der zweiten Spalte des Verweisarrays steht das formatierte Link
        for i:=1 to zahlderverweise do
        begin
             verweisarray[i,2]:=deletefirstword(verweisarray[i,1]);

             if length(verweisarray[i,1]) < 4 then   //irgendwas ist faul
             begin
                  Verweisarray[i,1]:='';
                  Verweisarray[i,2]:='';
             end;
        end;

        //Verweise alphabetisch sortieren (02/2024)
        if ZahlDerVerweise > 0 then
        begin
              for i:=1 to ZahlDerVerweise -1 do
              begin
                  for j:=i+1 to ZahlDerVerweise do
                  begin

                       if ansilowercase(VerweisArray[i,2]) > ansilowercase(VerweisArray[j,2]) then
                       begin
                            DummyString:=Verweisarray[i,1];
                            VerweisArray[i,1]:=verweisarray[j,1];
                            Verweisarray[j,1]:=dummystring;
                            DummyString:=Verweisarray[i,2];
                            VerweisArray[i,2]:=verweisarray[j,2];
                            Verweisarray[j,2]:=dummystring;
                       end;
                  end;
              end;
        end;

        Fenster.Baumverweise.items.clear;
        Fenster.Baumverweise2.items.clear;
        Fenster.BaumVerweise3.items.clear;
        { Abklären, wie viele Spalten man braucht und die Spalten entsprechend
          füllen}

        { 1-3 Verweise}
        if (ZahlDerVerweise > 0)  and (ZahlDerVerweise < 4) then
        begin
            BaumVerweise.Items.Add(nil, Verweisarray[1,2]);
            BaumVerweise.Items.Add(nil, Verweisarray[2,2]);
            BaumVerweise.Items.Add(nil, Verweisarray[3,2]);
        end;
        { 4-6 Verweise}
        if (ZahlDerVerweise > 3) and (ZahlDerVerweise < 7) then
        begin
            BaumVerweise.Items.Add(nil, Verweisarray[1,2]);
            BaumVerweise.Items.Add(nil, Verweisarray[2,2]);
            BaumVerweise.Items.Add(nil, Verweisarray[3,2]);
            BaumVerweise2.Items.Add(nil, Verweisarray[4,2]);
            BaumVerweise2.Items.Add(nil, Verweisarray[5,2]);
            BaumVerweise2.Items.Add(nil, Verweisarray[6,2]);
        end;
        { 7 bis 9 Verweise}
        if (ZahlDerVerweise > 6) and (ZahlDerVerweise < 10) then
        begin
             if Spaltenzahl=3 then
             begin
                  for i:=1 to 3 do
                      BaumVerweise.Items.Add(nil, Verweisarray[i,2]);
                  for i:=4 to 6  do
                      BaumVerweise2.Items.Add(nil, Verweisarray[i,2]);
                  for i:=7 to ZahlDerVerweise do
                      BaumVerweise3.Items.Add(nil, Verweisarray[i,2]);
             end else begin
                  for i:=1 to 5 do
                      BaumVerweise.Items.Add(nil, Verweisarray[i,2]);
                  for i:=6 to ZahlDerVerweise  do
                      BaumVerweise2.Items.Add(nil, Verweisarray[i,2]);
            end;
        end;
        { 10 bis 12 Verweise}
        if (ZahlDerVerweise > 9) and (ZahlDerVerweise < 13) then
        begin
         //    showmessage('10 bis elf');
             if Spaltenzahl=3 then
             begin
                  for i:=1 to 4 do
                      BaumVerweise.Items.Add(nil, Verweisarray[i,2]);
                  for i:=5 to 8  do
                      BaumVerweise2.Items.Add(nil, Verweisarray[i,2]);
                  for i:=9 to ZahlDerVerweise do
                      BaumVerweise3.Items.Add(nil, Verweisarray[i,2]);
             end else begin
                  for i:=1 to 6 do
                      BaumVerweise.Items.Add(nil, Verweisarray[i,2]);
                  for i:=7 to ZahlDerVerweise  do
                      BaumVerweise2.Items.Add(nil, Verweisarray[i,2]);
            end;
        end;

        { mehr als 12 Verweise. Klären, ob die dritte Spalte verwendet werden kann}
        if ZahlDerVerweise > 12 then
        begin
             for i:=1 to 6 do BaumVerweise.Items.Add(nil, Verweisarray[i,2]);
             if spaltenzahl= 3 then
             begin
                for i:=7 to 12 do BaumVerweise2.Items.Add(nil, Verweisarray[i,2]);
                for i:=13 to ZahlDerVerweise do BaumVerweise3.Items.Add(nil, Verweisarray[i,2]);
             end else begin
                 for i:=7 to ZahlDerVerweise do BaumVerweise2.Items.Add(nil, Verweisarray[i,2]);
             end;


        end;

        // die Verweise sind jetzt auf die Spalten verteilt.
        // jetzt kommt die Breite


        if spaltenzahl=1 then
        begin
             BaumVerweise2.width:=1;
             BaumVerweise3.width:=1;
             Baumverweise.Width:=feldinhalt.width -100;
        end;
        if spaltenzahl=2 then
        begin

           Baumverweise.Width:=trunc(paneltitel.width/2)-75;
           BaumVerweise2.width:=Baumverweise.width;
           BaumVerweise3.width:=1;
        end;
        if spaltenzahl=3 then
        begin
             Baumverweise.Width:=trunc(paneltitel.width/3)-55;
             BaumVerweise2.width:=Baumverweise.width;
             BaumVerweise3.width:=Baumverweise.width;
        end;

        { jetzt muss die Höhe der Verweisliste an die Zahl der Verweise
          angepasst werden }

        if ZahlDerVerweise = 0 then
        begin
             h:=1;
             IconResizeVerweise.shape:=bsSpacer;
        end else begin
            IconResizeVerweise.shape:=bsTopLine  ;
            h:= (Baumverweise.items.count * (Baumverweise.DefaultItemHeight+2)) +1;
        end;
        if os='win' then h:=h+10;
        { sonst zu niedrig und ein Scrollbar wird angezeigt}
        PanelUnterDemText.height:=h;

        {Jetzt ist die Fußzeile fertig formatiert}




        //Schlagwortzeile formatieren
        panelVergebeneKeywords.caption:='';
        for i:=0 to swliste.count -1 do
        begin
             wort:=swliste[i];
             if pos(ansilowercase(wort),meintext)>0 then
                   panelVergebeneKeywords.caption:=
                   panelVergebeneKeywords.caption + wort + ' ';
        end;
        if  panelVergebeneKeywords.caption = '' then
            panelVergebeneKeywords.visible:=False
        else
            panelVergebeneKeywords.visible:=true;

  end; // Feldinhalt etc herrichten

  If Anzeigemodus='volltextsuche' then
         if letzterEintrag<>Liste.Row then  LetzterEintrag:=Liste.Row;


  //Wo soll der Fokus sein? Umständlich, weil Linux beim Start Ärger macht.
  focussuche:=false;
  if Registerkarten.activepage=IdeenSeite then focussuche:= true;
  if Fenster.activecontrol=sucheingabe then    focussuche:= true;
  if Fenster.Activecontrol=liste then          focussuche:=false;
  if RegisterSuche.activepage<>SeiteVolltextsuche then focussuche := false;
  if length(feldinhalt.Lines.Text) < 1 then focussuche:=false;

  if focussuche then
  begin
       FocusTo('Sucheingabe');
       sucheingabe.SelStart:=1000;
  end else begin


  end;


end; //Ende Timer

procedure TFenster.GliederungClick(Sender: TObject);

var
   nummer:       string;
   t:            string;
   titel:        string;
   typ:          string;


begin
         aufraeumen();
   timer.enabled:=False;
  if (Gliederung.Selected <> nil)  then
  begin
    t:=trim(Gliederung.selected.Text);
    nummer:='x';
    typ:='?';
    if pos('[=',t)=1      then typ:='kurzzitat'  ;
    if pos(' (LI',t) > 0  then typ:= 'langzitat'  ;
    if pos(' (#',t) > 0   then typ:= 'notiz';


    if typ='kurzzitat' then  //eine Literaturquelle ist angeklickt worden
    begin
         AngezeigterTyp:='L';
         AktuelleLiteraturID:=getIDfromTmpCitation(t);
         LiteraturIdAnzeigen(AktuelleLiteraturID);
         titel:=Literatur[AktuelleLiteraturArrayZeile,Spalte_Erstautor]
                 + ' (' + Literatur[AktuelleLiteraturArrayZeile,Spalte_Jahr] + ') '
                 +  Literatur[AktuelleLiteraturArrayZeile,Spalte_Titel] ;
    end;

    if typ='langzitat' then   //eine Quelle, aber ohne Kurzzitat
    begin
         AngezeigterTyp:='L';
         AktuelleLiteraturID:=GetLastword(t);
         AktuelleLiteraturID:=copy(AktuelleLiteraturID,4,6);
        LiteraturIdAnzeigen(AktuelleLiteraturID);
        titel:=Literatur[AktuelleLiteraturArrayZeile,Spalte_Erstautor]
                + ' (' + Literatur[AktuelleLiteraturArrayZeile,Spalte_Jahr] + ') '
                +  Literatur[AktuelleLiteraturArrayZeile,Spalte_Titel] ;
    end;

    if typ='notiz' then   //eine Notiz - ID ist vorhanden
    begin
         AngezeigterTyp:='N';
         titel:=copy(t,1,pos(' (#',t)-1);
         titel:=umlautRTFtoXML(titel);
         titel:=trim(titel);

         nummer:=trim(getlastword(t));
         nummer:=zahlenausfiltern(nummer);


        if titel <> GV_Titel  then //die Notiz ist gelöscht oder umbenannt worden
        begin
                 if nummer='x' then showmsg('Die Notiz ist umbenannt oder gelöscht worden');
                 if nummer <> 'x' then
                 begin
                      titel:=HolTitelderNotizID (str2int(nummer));
                      Gliederung.selected.text:= titel + abstand + '(#' + nummer;  //3/18 war auskommentiert. Weiß nicht, warum
                      DatensatzAufrufen(titel);

                      Gliederung.Refresh;  //den ausgewählten Eintrag fett drucken
                      GliederungSpeichern(DBDirectory+Gliederungsdatei);
                      AktuelleNotizID:=Nummer ;
                      //showmessage('aktuelle ' + AktuelleNotizID) ;
                      machpause();
                 end;
         end else begin   // alles ist glattgegangen
                 if nummer = 'x' then  //es gab keine Nummer
                    Gliederung.selected.text:= titel + abstand + '(#' + GV_FeldNummer;
                 AktuelleNotizID:=Nummer ;
         end;
    end;

    if typ='?' then showmsg('Der Gliederungspunkt ist beschädigt. Bitte löschen Sie ihn und fügen ihn noch einmal ein');
    If RegisterSuche.Activepage=SeiteVolltextsuche
     then  ZeigeTreeviewItemInListe(titel);



    Timer.enabled:=true;

    machpause() ;

  end;
end;

procedure TFenster.VerweisErstellenClick(Sender: TObject);

begin
     machpause();
     timer.enabled:=false;  { ich bin noch auf der Suche nach dem cannot
                              focus error. Könnte das die Stelle sein? }
     if   Registerkarten.Activepage <> Ideenseite
     then Registerkarten.Activepage:=Ideenseite;
     machpause();
     Registersuche.activepage:=SeiteQuerverweis;
     machpause();
     QuerverweisAllesZeigenClick(self);
end;

procedure TFenster.VorschlagMittelPunktClick(Sender: TObject);

begin
  Registerkarten.ActivePage := IdeenSeite;
end;
procedure TFenster.AppDeactivate(Sender: TObject);
begin
    { Wenn per Drag and Drop etwas aus einem anderen Programm auf Feldinhalt
      gezogen wird und Feldinhalt nicht readonly ist, wird ein Bildchen
      importiert }
    //SaveChangesToArray();      //buggy?

    Fenster.FeldInhalt.ReadOnly:=true;

end;
procedure TFenster.AppActivate(Sender: TObject);
begin
    { Wenn per Drag and Drop etwas aus einem anderen Programm auf Feldinhalt
      gezogen wird und Feldinhalt nicht readonly ist, wird ein Bildchen
      importiert }
      Fenster.FeldInhalt.ReadOnly:=false;

end;

procedure TFenster.FormCreate(Sender: TObject);
var
  datei:         textfile;
  dateiname:     string;
  i:             integer;
  inhalt:        string;
  vn:            integer;
  zeile:         string;
  ZeilenZahl:    integer;
  t, m, y:       string;

begin
  fenster.visible:=false;
  SpeicherVolumen:=0;
  swliste := TStringList.Create;  // erst mal erzeugen. Geht sonst nicht
  Skalierung:=screen.pixelsperinch/100; //Für Windows
  if Skalierung < 1 then Skalierung:=1;
  UngespeicherteZeichen:=1;
  machpause();



  //Die Ausgangs-Registerkarten aufrufen
  RegisterKarten.Activepage:=IdeenSeite ;
  RegisterSuche.Activepage:=SeiteVolltextsuche;
  //brauche ich das noch?
  Application.OnDeactivate:=@AppDeactivate;
  Application.OnActivate:=@AppActivate;
  FHTTPClient := TFPHTTPClient.Create(nil);
   //beim Runterfahren des Systems. Funktioniert unter Linux nicht
  application.OnEndSession := @self.ApplicationSessionEnded;

  //Ereignis erzeugen, das beim Herunterfahren des Betriebssystems aufgerufen wird.
  machpause() ;
  os := holos();
  TitelVorschlag:='';
  NotizenDatensatzzahl:=0;
  LiteraturDatensatzzahl:=0;
 // Mindestdatum:=''; // damit es bei der ersten Suche ermittelt wird



  mypath := MeinVerzeichnis(os);;
  machpause();
  DBDirectory:=MyPath;
  machpause();
  plattenplatz:= inttostr(disksize(0)); //für die .ini Datei
  machpause();

  if instancerunning() then
  begin
       if yesbox('Es sieht so aus, als würde die Anwendung schon laufen. Abbrechen?') then
        Application.terminate;
  end   ;

      ichanged:=False;
      lchanged:=false;
      IneedsSorting:=false;
      LneedsSorting:=false;
      letzteSpeicherung:= str2int(formatdatetime('nn',now));

      AnzeigeVersion.Caption:='Version: ' + myversion;

      if os='win' then
         LetzterFokus:='SuchEingabe' //Es ist sinnvoll, dort zu starten
      else
          LetzterFokus:='x'; //Linux zickt, weil Fenster noch nicht aufgebaut
      loadbxini();

      LiteraturDatenbank := DBDirectory + 'literatur.xml';
      IdeenDatenbank := DBDirectory+ 'ideen.xml';
      //--- MinimalDateien erstellen
      if (not fileexists(IdeenDatenbank)) then copyfile(mypath + 'i.xml', IdeenDatenbank);
      if (not fileexists(LiteraturDatenbank)) then copyfile(mypath + 'l.xml', LiteraturDatenbank);

      //Datenbanken dimensionieren

      assignfile(datei, DBDirectory + 'literatur.xml');
      reset(datei);
      while not eof(datei) do
         begin
               readln(datei,zeile);
               if pos('<Id>',zeile)=1 then LiteraturDatensatzZahl:=LiteraturDatensatzZahl +1;
               if pos('<datensatzzahl>',zeile)=1 then
               begin
                    LiteraturDatensatzZahl:=str2int(zeile);
                    break;
               end ;

         end;
       closefile(datei);
       if Literaturdatensatzzahl=0 then showmessage('literatur.xml ist beschädigt');
       ArraySize_Literatur:=Literaturdatensatzzahl +100;
       machpause();
       assignfile(datei, DBDirectory + 'ideen.xml');
       reset(datei);


       while not eof(datei) do
       begin
               readln(datei,zeile);
               if pos('<nummer>',zeile)=1 then NotizenDatensatzZahl:=NotizenDatensatzZahl +1;
               if pos('<datensatzzahl>',zeile)=1 then
               begin
                    NotizenDatensatzZahl:=str2int(zeile);
                    break;
               end ;

       end;
       closefile(datei);
       machpause();
       if NotizenDatensatzZahl=0 then showmessage('ideen.xml ist beschädigt');


      ArraySize_Daten:= NotizenDatensatzzahl + 100 ;
      SetLength(Daten, ArraySize_Daten+2,Spalte_Position+1); // ist schmaler als Literatur
      SetLength(Literatur, ArraySize_Literatur+2,Spalte_Ende+1);
      SetLength(Literatur2,1,1); { wird nur beim Import aus anderen Formaten
                                   benötigt. Also wahrscheinlich gar nicht
                                   daher kurz halten 02/2024}
      //Gliederung
      Gliederungsdatei:=GetIni('gliederungsdatei','ideen.tree');

      //-- Schreibzugriff prüfen
      Randomize;
      if SessionTemporaryID='' then SessionTemporaryID := IntToStr(random(9998) + 1) ;
      //Prüfen, ob die Datenbank geladen werden muss.

      fenster.visible:=false;
      if Schreibrecht()  then
      begin
           machpause();

          //----Farbschema----
          //--------------------
          literaturfarbenormal:= $a4a4a4;// $00EAEAEA;//$00F3F3F3;
          FarbeTextQuerverweis:=clblue;
          FarbeTextSchlagwort:=clred;
          with fenster.liste do
          begin
               options:=options - [gofixedhorzline];
               options:=options - [gofixedvertline];
               options:=options - [gohorzline];
               options:=options - [govertline];
               fixedcolor:=literaturfarbenormal;//clwhite;
               selectedcolor:=literaturFarbeNormal;
               FocusRectVisible:=false; { blendet die Markierung des
                                          ausgewählten Satzes mit einem
                                          punktierten Rahmen aus. 01/2021 }
          end;


          //-- Hauptmenuleiste  -------
          //---------------------------
          Var_OptionMenue:=GetBooleIni('optionmenu',true);
          if Var_OptionMenue then
          begin
             Fenster.Menu:=Hauptmenu;
             RegisterSuche.Borderspacing.Bottom:=46;
             ImageOptionMenue.picture:=ImageToggleOn.picture;
          end else begin
              Fenster.Menu:=nil;
              RegisterSuche.Borderspacing.Bottom:=32;
              ImageOptionMenue.picture:=ImageToggleOff.picture;
          end;
          var_OptionSchlagwortliste:=false;
          PanelKombinierterSchlagwoerter.height:=1;





          //Registerkarten formatieren
          //---------------------------
          Registerkarten.showtabs:=false;
          FeldInhalt.align:=alclient;

          { unter Linux können Tabs nicht in multiline dargestellt werden
            Bei den Einstellungen gibt es aber zu viele Tabs. Daher dann
            links }
          if os='win'
          then RegisterEinstellungen.TabPosition:=tptop
          else RegisterEinstellungen.TabPosition:=tpleft;





          if getini('optionris','false')='true' then OptionRIS:=true else OptionRIS:=false;;

          dummystring:=  getini('optionanhang','rtf');

          if dummystring='bibtex' then fenster.OptionBibTeX.checked:=true ;
          if dummystring='rtf' then fenster.Optionrtf.checked:=true ;




          //-----Zeichensatz------------
          //----------------------------
          fsize:=getintegerini('fontsize',12);  //03/2024

          if fsize < 8 then fsize:=8;
          if fsize > 18 then fsize:=18;

          FeldInhalt.font.Size:=fsize;
          if fsize > 13
          then Liste.Font.Size:=fsize-2
          else Liste.Font.Size:=12;
          Gliederung.Font.Size:=Liste.font.size;

          //Tabulatoren für Feldinhalt
          InitTabStopList(StopList, [fsize * 14 / Skalierung]  );

          ZeichenSatz:=GetIni('feldinhaltfont','Arial');
          zeichensatzeinstellen();   { Die Benutzeroberfläche auf den Zeichen-
                                       satz einstellen }

          Fenster.Caption := 'Bibliographix ' + DBDirectory;

          //------- Liste -----------
          //-------------------------
            Liste.Colwidths[ListeSpaltePin]:=              0 ;
            Liste.Colwidths[ListeSpalteNummer]:=           4 ;
            Liste.Colwidths[ListeSpalteMarkierung]:=       4 ;
            Liste.Colwidths[ListeSpalteIcon]:=             0 ;
            Liste.columns[1].Layout:=tltop;
            Liste.columns[2].Layout:=tltop;
            Liste.columns[3].Layout:=tltop;

            //----Die Daten einlesen
            //----------------------
            i := 50;  //bisher 1, aber die ersten n sollen freibleiben, damit man andere nach hinten schieben kann
            SetMaxID('daten',0);
            inhalt := '';
            machpause() ;
            if os='linux' then sleep(100); { Linux verschluckt sich an dieser
                                             Stelle gern 02/2024 }


            //===IDEENDATENBANK EINLESEN===//
            //-------------------------------
            AlteNotizzahl:=i-50; // ich zähle i immer hoch
                                 //und am Anfang sind 50 Leerzeilen

            assignfile(datei, IdeenDatenbank);
            try
                reset(datei);
            except
                  busy();
                  reset(datei);
            end;
            while not EOF(Datei) do
            begin
              readln(datei, zeile);
              //Die Kopfinformationen in der Datenbank
              //passen Datenbank und Version zusammen?
              if pos('<version>', zeile) = 1 then
              begin
                vn := str2int(XMLEinlesen(zeile));
                if (vn > 6) then
                begin
                    showmsg(
                      'Diese Datenbank ist mit einer neueren Version von Bibliographix erstellt worden und enthält Informationen, die mit dieser (älteren) Version verloren gehen würden. Bitte aktualisieren Sie die Installation') ;
                    Application.Terminate;
                end;
              end;

              if pos('<karte>', zeile) = 1 then
              begin
                i := i + 1;  // Die Zeile des Datensatzes
                Zeilenzahl:=0;
                while zeile <> '</karte>' do
                begin
                  readln(datei, zeile);
                  Zeilenzahl:=zeilenzahl +1;
                  if zeilenzahl < 10000 then
                  begin
                        if pos('<nummer>', zeile) = 1 then
                        begin
                          daten[i, 1] := XMLEinlesen(zeile);
                          if str2int(daten[i, 1]) > GetMaxID('daten') then
                            SetMaxID('daten',str2int(daten[i, 1]));
                        end;
                        if pos('<datum>', zeile) = 1 then
                        begin
                          daten[i, Spalte_Bearbeitungsdatum] := XMLEinlesen(zeile);
                          if length(daten[i,Spalte_Bearbeitungsdatum]) < 10 then daten[i,Spalte_Bearbeitungsdatum]:='190001010101';
                        end;
                        if pos('<titel>', zeile) = 1 then
                          daten[i, Spalte_Titel] := XMLEinlesen(zeile);

                        // -- ältere Fassung, in der tag noch ein eigenes Feld war 06/2023 geändert
                        if pos('<tag>', zeile) = 1 then
                        begin
                             if daten[i, Spalte_Anmerkung] = '' then
                                daten[i, Spalte_Anmerkung]:= ' #tag#'
                             else
                                 daten[i, Spalte_Anmerkung]:= daten[i, Spalte_Anmerkung] + ' #tag#'
                        end;
                        if pos('<inhalt>', zeile) = 1 then
                        begin
                             if daten[i, Spalte_Anmerkung] = '' then
                                daten[i, Spalte_Anmerkung] :=  XMLEinlesen(zeile)
                             else
                                daten[i, Spalte_Anmerkung] := XMLEinlesen(zeile) +
                                                              daten[i, Spalte_Anmerkung];
                        end;
                        if pos('<bearbeitungen>', zeile) = 1 then
                          daten[i, Spalte_Bearbeitungszahl] := XMLEinlesen(zeile);
                        if pos('<erstellt>', zeile) = 1 then
                          daten[i, Spalte_Erstelldatum] := XMLEinlesen(zeile);

                        if pos('<', zeile) <> 1 then  //Folgezeile des Inhaltfelds
                        begin
                          if (pos('</inhalt>', zeile) > 0) then
                            zeile := copy(zeile, 1, pos('</i', zeile) - 1);
                          daten[i, Spalte_Anmerkung] := daten[i, Spalte_Anmerkung]
                                                        + #13#10 + zeile;
                        end;

                        //Zwei Felder aus älteren Fassungen, die es nicht mehr geben
                        //sollte und die, falls doch, ins Anmerkungsfeld geschrieben
                        //werden
                        if pos('<verweise>', zeile) = 1 then
                           daten[i, Spalte_Anmerkung] :=
                             ' ' + daten[i, Spalte_Anmerkung]+ XMLEinlesen(zeile) + ' ';
                        if pos('<datei>', zeile) = 1 then
                           daten[i, Spalte_Anmerkung] :=
                             ' ' + daten[i, Spalte_Anmerkung]+ XMLEinlesen(zeile) + ' ';
                  end else begin  { Der Datensatz ist unplausibel lang. Also ist
                                    die Datenbank wohl beschädigt. 02/2024}
                        showmessage( 'Die Datenbank ideen.xml ist beschädigt.'
                                    +#10#13
                                    + 'Bitte verwenden Sie eine Sicherungskopie.');

                                    { nach der letzten Sicherung schauen und
                                      die verwenden}
                                    closefile(datei);
                                  //  copyfile( mypath + 'tmp' + slash(os) + 'ideen.xml' ,
                                  //            mypath + 'ideen.xml') ;
                        halt;
                  end;
                end;
              end;
            end;
            closefile(datei);
            machpause();



            fenster.visible:=false;
            //---- Die Felder ausfüllen ----
            //------------------------------
            machpause();
            if length(inhalt) > 1 then
              Daten[i, Spalte_Anmerkung] := inhalt;
             //Erstelldatum prüfen, falls die Datenbank zu alt ist
             if vn <6 then
             begin

                 for i:= 1 to ArraySize_Daten  do
                 begin
                      if Daten[i,Spalte_Erstelldatum]='' then
                      begin
                           if Daten[i,Spalte_Bearbeitungsdatum]='' then //es gibt gar kein Datum
                           begin
                                Daten[i,Spalte_Erstelldatum]:='-' ;
                           end  else begin //das letzte Bearbeitungsdatum ist sicher nicht zu alt
                                y:=copy(Daten[i,Spalte_Bearbeitungsdatum],1,4);
                                m:=copy(Daten[i,Spalte_Bearbeitungsdatum],5,2);
                                t:=copy(Daten[i,Spalte_Bearbeitungsdatum],7,2);
                                Daten[i,Spalte_Erstelldatum]:= 'vor/am ' + t + '.'+ m + '.' + y;
                           end;
                      end;
                 end;
             end;
             machpause();
            //======Literaturdatenbank================
            //========================================
            LiteraturDatenbank:=DBDirectory + 'literatur.xml';
            LiteraturLaden('Literatur',Literaturdatenbank);
            machpause();
            Fenster.OptionLangesTMPZitat.checked :=GetBooleini('langestmpzitat',false);
            langestmpzitat:= Fenster.OptionLangesTMPZitat.checked;
             //Zitierrichtlinie
            dummystring:=mypath + 'bxstyles' + slash(os) + Getini('bxstyle','AER.bxstyle') ;
            if fileexists(dummystring) then RichtlinieLaden(dummystring) ;
            MachPause();
            GliederungArrayEinlesen();
            LabelOriginaldatei.Caption:= 'Manuskript: ' + extractfilename(Getini('Manuskriptdatei',''));
            machpause();
        end;  //Ende Schreibrecht

        machpause();
        VollTextKomplettieren();

        machpause();

        swliste.sorted:=false;
        Dateiname := DBDirectory + 'key.dat';

        if fileexists(Dateiname) then
        begin
           try
             swliste.LoadFromFile(Dateiname);
           except
             busy();
             swliste.LoadFromFile(Dateiname);
             end
        end else begin
               swliste.add('dummy');
        end;
        machpause();

        for i:=0 to swliste.count-1 do  //falls da noch Häufigkeiten herumschwirren
            swliste[i]:=getfirstword(swliste[i]);
        swliste.sorted:=true;
        machpause();
        icongliederungclick(self);
        machpause();

        machpause();
        AlleAnzeigenClick(self);
        machpause();
        var_OptionDarkMode:= getbooleini('optiondarkmode',false);
        if var_optionDarkMode then FarbschemaClick(self);

        PanelNeueQuelle.height:=2;

        //Dinge, die in der Windows-Oberfläche anders aussehen als unter Linux
        //und angepasst werden müssen
        if os='win' then
        begin
             Sucheingabe.BorderSpacing.top:=16;
             { ist sonst nicht vertikal zentriert }
        end ;



        NachFormCreate.enabled:=true;

end;  //ende Formcreate

procedure Tfenster.ApplicationSessionEnded(Sender: TObject);
begin
  //Beim Shutdown/Herunterfahren des Betriebssystems soll abgespeichert werden.
  //FormClose springt nur beim händischen Beenden an.
  //Dieser Befehl springt beim händischen Beenden NICHT an
  //Dieser Befehl springt beim Shutdown IMMER an, wenn Bx noch läuft.
  //die Showmessage verhindert das Runterfahren und gibt die Meldung aus.
  //showmessage('Bibliographix muss die Daten noch abspeichern') ;

  //if os='linux' then showmessage('ApplicationSessionEnded');
  ausschaltenclick(self);
  setlock('0');
  Application.terminate;
end;

procedure TFenster.FormResize(Sender: TObject);

begin
      resizewindow();
            { steht hier so ein bischen einsam, aber der Code dahinter
              ist recht umfangreich und soll evtl. über einen IdleTimer
              aufgerufen werden können, der anspringt, wenn man fertig mit
              dem Fenstergrößeändern ist. }
end;

procedure TFenster.AlleAnzeigenClick(Sender: TObject);
begin

  if istextchanged then savechangestoarray();
  machpause();
  if Registerkarten.ActivePage <> IdeenSeite
  then Registerkarten.ActivePage:=IdeenSeite;

  if RegisterSuche.activepage <> SeiteVolltextsuche
  then RegisterSuche.activepage:= SeiteVolltextsuche  ;
  sucheingabe.Text := '';
  TrefferzahlAnzeigen();
  AlleZettelAnzeigen();
  machpause();

  if PanelKombinierterSchlagwoerter.height > 10  // falls der Schlagwortfilter
  then ZeigeAlleSchlagwoerterClick(self);        // sichbar ist, alle
                                                 // Schlagwörter anzeigen
  timer.enabled:=false;
  timer.enabled:=true;

end;

procedure TFenster.DIYButtonEnter(Sender: TObject);

begin

end;


procedure TFenster.BaumVerweiseClick(Sender: TObject);
var
   link:string;
begin

     if BaumVerweise.Selected <> nil then
     begin
          //link:= BaumVerweise.selected.Text;
          //Der VerweisArray ist global. man kann das note:// in der Darstellung
          //weglassen und Platz sparen
          link:=Verweisarray[BaumVerweise.Selected.Index+1,1];
          VerweisAufrufen(link);
     end;

end;

procedure TFenster.BaumVerweiseDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if source=Liste then accept:=true;
end;

procedure TFenster.Image31Click(Sender: TObject);
begin

end;

procedure TFenster.ListeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
    if (key=vk_up) or
       (key=vk_down) or
       (key=vk_next) or
       (key=vk_prior) or
       (key=vk_home)then
    begin
         timer.Enabled := false;
         timer.Enabled := True;
    end;
end;



procedure TFenster.Image12Click(Sender: TObject);
begin

end;

procedure TFenster.ImageDatenaustauschClick(Sender: TObject);
begin

end;

procedure TFenster.LabelKurzzitatClick(Sender: TObject);
var
  AltesKurzZitat:string;
  IdDesDatensatzes:string;
  NeuesKurzZitat:String;
  InOrdnung:boolean;
begin
     IdDesDatensatzes:=copy(TmpHinweis,2,100);
     AltesKurzZitat:= KurzZitat;
     if (length(IdDesDatensatzes) > 0) and (length(AltesKurzzitat) > 0) then  //es gibt eine ID
     begin
          neuesKurzzitat := inputbox('Kurzzitat ändern', 'Kurzzitat:', altesKurzZitat);
          InOrdnung:=true;
          if pos('[=' + IDDesDatensatzes,NeuesKurzzitat) <> 1 then InOrdnung:=false;
             //der Anfang stimmt
          if pos('=]',NeuesKurzzitat) <> length(NeuesKurzZitat)-1 then InOrdnung:=false;
             //das Ende stimmt auch. Dazwischen ist weitgehend egal.
          if InOrdnung then
          begin
               literatur[AktuelleLiteraturArrayZeile,Spalte_Kurzzitat] := NeuesKurzzitat ;
               LabelTitel.Caption:=NeuesKurzZitat;
               KurzZitat:=NeuesKurzZitat;
               GV_TmpZitat :=NeuesKurzZitat;
          end;

     end;
end;

procedure TFenster.RegisterSucheChange(Sender: TObject);
begin

     if RegisterSuche.Activepage= SeiteVollTextSuche then
     begin
          FocusTo('Sucheingabe');
        PanelFeldinhaltIcons.visible:=true;
     end;
     if RegisterSuche.activepage=SeiteGliederung then
     begin
         if Gliederung.selected <> nil then
         begin
              if pos(LabelTitel.caption,Gliederung.selected.text)<>1
              then Gliederung.selected:=nil;
         end;
     end;
     ResizeWindow();

end;

procedure TFenster.AnzahlVorschlagMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; x, Y: Integer);
begin
  timer.enabled:=true;
end;





procedure TFenster.ListeMouseEnter(Sender: TObject);
begin
  LetzterFokus:='Liste';
end;

procedure TFenster.MenueLockClick(Sender: TObject);
var
   t1,t2:string;
begin
    If AngezeigterTyp='L' then
    begin
         t1:=  Literatur[AktuelleLiteraturArrayZeile,Spalte_Anmerkung];
         if pos('#lock#',t1) = 0 then
         begin
              t2:=t1 + ' #lock#';
         end else  begin
             t2:=copy(t1,1,pos('#lock',t1)-1)  + copy(t1,pos('#lock',t1)+6,100000) ;

         end;
         Literatur[AktuelleLiteraturArrayZeile,Spalte_Anmerkung]:=t2;
         lchanged:=true;

    end;
    If AngezeigterTyp='N' then
    begin
         t1:=  Daten[AktuelleNotizenArrayZeile,Spalte_Anmerkung];
         if pos('#lock#',t1) = 0 then
         begin
              t2:=t1 + ' #lock#';
         end else  begin
             t2:=copy(t1,1,pos('#lock',t1)-1) + copy(t1,pos('#lock',t1)+6,100000) ;
         end;
         Daten[AktuelleNotizenArrayZeile,Spalte_Anmerkung]:=t2;
         ichanged:=true;
    end;

    Feldinhalt.text:=t2;



    if istextchanged then savechangestoarray();
    ichanged:=true;
    lchanged:=true;
    Liste.Invalidate;
    Timer.Enabled:=False;
    Timer.Enabled:=true;

end;

procedure TFenster.MenuZeilenumbruchClick(Sender: TObject);
var
   t1,t2:string;
begin

    t1:= FeldInhalt.Lines.text ;
    if pos('#nowordwrap#',t1) = 0 then
    begin
        t2:=t1 + ' #nowordwrap#';
    end else  begin
        t2:=copy(t1,1,pos('#nowordwrap',t1)-1) + copy(t1,pos('#nowordwrap',t1)+12,100000) ;
    end;
    If AngezeigterTyp='L' then
    begin
         Literatur[AktuelleLiteraturArrayZeile,Spalte_Anmerkung]:=t2;
         lchanged:=true;
    end;
    If AngezeigterTyp='N' then
    begin
         Daten[AktuelleNotizenArrayZeile,Spalte_Anmerkung]:=t2;
         ichanged:=true;
    end;
    FeldInhalt.Lines.text:=t2;
    //Die Anzeige aktualisieren
    if trefferarray[liste.row,2]='#' then trefferarray[liste.row,2]:='' else trefferarray[liste.row,2]:='#';

    if istextchanged then savechangestoarray();

    ichanged:=true;
    lchanged:=true;
    Liste.Invalidate;

    Timer.Enabled:=False;
    Timer.Enabled:=true;

end;



procedure TFenster.IconResizeVerweiseMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (GetKeyState(VK_LBUTTON) < 0) then  PanelUnterDemText.height:=PanelUnterDemText.height - y;
end;

procedure TFenster.Image4Click(Sender: TObject);
begin
  openurl('https://www.paypal.com/paypalme/olafwinkelhake');
end;

procedure TFenster.ImageQuelle1Click(Sender: TObject);
begin

end;

procedure TFenster.ImageQuelleClick(Sender: TObject);
begin
     PanelFeldInhaltIcons.Visible:=false;
     Registerkarten.activepage:=styleseite;


end;

procedure TFenster.ImageUpdateClick(Sender: TObject);
var
   Dateiname:    string;
   URL:          string;
begin
  if os='win' then
  begin
         Dateiname:=extractfilepath(application.exename) + 'bxsetup.exe';
         MemoZwischenAblage.Lines.Text:=MyVersion ;
         MemoZwischenAblage.Lines.SavetoFile(extractfilepath(application.exename) + 'localwindowsversion.ini');
  end else begin
         Dateiname:=extractfilepath(application.exename) + 'bxsetup';
         MemoZwischenAblage.Lines.Text:=MyVersion ;
         MemoZwischenAblage.Lines.SavetoFile(extractfilepath(application.exename) + 'locallinuxversion.ini');
  end;
  machpause();
  if fileexists(Dateiname) then  //Der Updater ist da
  begin
       {$IFDEF LINUX}
           fpChmod(extractfilepath(application.exename)+'bxsetup',&777)    ;
           fpsystem(extractfilepath(application.exename)+'bxsetup') ;
           //die Datei als Programmdatei einrichten
           //fpsystem(extractfilepath(application.exename)+'bxsetup') ;
           // opendocument funktioniert nicht als Programmaufruf
           //fpsystem pausiert das Hauptprogramm, so lange das andere läuft
           //eine bessere Lösung habe ich nicht gefunden.
           //AProcess.Execute fährt das Hauptprogramm herunter, aber auch
           //den Installer  (02/2024)
       {$ENDIF}
       {$IFDEF WINDOWS}
           opendocument(dateiname);
       {$ENDIF}

  end else begin // der Updater muss noch heruntergeladen werden
      if os='win'
         then
             url:='http://www.bibliographix.net/latest/bxsetup.exe'
         else
             url:='http://www.bibliographix.net/latest/bxsetup' ;
        screen.cursor:=crhourglass;
        Download(url, dateiname );
                           machpause();
        screen.cursor:=crdefault;
        showmsg('Setup-Programm heruntergeladen... wird jetzt gestartet...');
        {$IFDEF LINUX}
           fpChmod(extractfilepath(application.exename)+'bxsetup',&777)    ;
           fpsystem(extractfilepath(application.exename)+'bxsetup') ;
       {$ENDIF}
       {$IFDEF WINDOWS}
           opendocument(dateiname);
       {$ENDIF}

  end;
  machpause();
  ApplicationSessionEnded(self);
  machpause() ;
  Application.terminate;
end;

procedure TFenster.Label29Click(Sender: TObject);
begin
    RegisterSuche.Activepage:= SeiteVolltextsuche;

end;

procedure TFenster.LabelGliederung(Sender: TObject);
begin
      if registerSuche.activepage <> SeiteGliederung then
      begin
         RegisterSuche.Activepage:= SeiteGliederung;
         GliederungClick(self);
      end;

end;

procedure TFenster.Label25Click(Sender: TObject);
begin
   RegisterSuche.Activepage:= SeiteVolltextSuche;
end;

procedure TFenster.LabelSucheClick(Sender: TObject);
begin
     if registerSuche.activepage <> SeiteVolltextsuche then
       registerSuche.activepage:=SeiteVolltextsuche
end;

procedure TFenster.GliedernBildClick(Sender: TObject);
begin
     Registerkarten.Activepage:= IdeenSeite;
end;

procedure TFenster.BaumVerweise2Click(Sender: TObject);
var
   link:string;
begin

     if BaumVerweise2.Selected <> nil then
     begin
          //link:= BaumVerweise2.selected.Text;
          link:=Verweisarray[BaumVerweise.items.count + BaumVerweise2.Selected.Index +1 ,1];
         // BaumVerweise.items.clear;
          VerweisAufrufen(link);

     end;

end;

procedure TFenster.BaumVerweise3Click(Sender: TObject);
var
   link:string;
begin
  
     if BaumVerweise3.Selected <> nil then
     begin
          //link:= BaumVerweise3.selected.Text;
          link:=Verweisarray[BaumVerweise.items.count +
                             BaumVerweise2.items.count +
                             BaumVerweise3.Selected.Index +1,1 ];
          VerweisAufrufen(link);

     end;
end;

procedure TFenster.Bevel4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  { falls man oberhalb von Feldinhalt klickt, aber noch nicht das Vollzitat
    wird der Fokus auf die Anmerkungen gesetzt }
  feldinhalt.selstart:=0;
  feldinhalt.sellength:=0;
  FocusTo('Feldinhalt');
end;

procedure TFenster.ButtonAnlegenClick(Sender: TObject);
var
   cp:   integer;
   i:    integer;
   l:    string;

begin
     l:='';
     if qliste.ItemIndex > -1 then
     begin
           cp:=FeldInhalt.selstart;
           i:=qliste.itemindex +1 ;
           if Qarray[i,2]='N' then
           begin
             l:='note://' + Qarray[i,3] + ' ' + Qarray[i,1];
           end;

           if Qarray[i,2]='L' then
           begin
             l:='ref://' + Qarray[i,3] + ' ' + Qarray[i,1];
           end;

           //Das Link in die Anmerkungen
           l:=trim(l);
           l:=' ' + StringReplace(l,' ' , '_', [rfReplaceAll])+ ' ';
           machpause();
           clipboard.Clear;
           machpause();
           paste(l);
           machpause();
           IsTextChanged:=true; //sonst wird evtl. nicht abgespeichert 02/2024
           if istextchanged then savechangestoarray();
           machpause();
           { die gesamten Anmerkungen formatieren, falls der Absatz nicht richtig
             erkannt wird.}
           formatmd(0,10000,false);
           machpause();
           qliste.ItemIndex :=-1;
           { Fokus auf den Feldinhalt an die Stelle hinter dem neuen Querverweis }
           focusto('Feldinhalt');
           Feldinhalt.selstart:=cp + length(l);


     end;

end;

procedure TFenster.ButtonFettClick(Sender: TObject);
var
   absatz:  tpararange;
begin
      if Fenster.Feldinhalt.SelLength=0 then
      begin
           paste('****');
           Fenster.Feldinhalt.SelStart:=Fenster.Feldinhalt.selstart-2;
      end else begin
          paste('**' + trim(Fenster.feldinhalt.seltext) + '** ');
          FeldInhalt.GetParaRange(feldinhalt.SelStart,absatz.start,absatz.length);
          formatmd(absatz.start,absatz.length,false);
      end;
end;

procedure TFenster.ButtonKopierenClick(Sender: TObject);
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

procedure TFenster.ButtonKursivClick(Sender: TObject);
var
   absatz:  tpararange;
begin
      if Fenster.Feldinhalt.SelLength=0 then
      begin
           paste('**');
           Fenster.Feldinhalt.SelStart:=Fenster.Feldinhalt.selstart-1;
      end else begin
          paste('*' + trim(Fenster.feldinhalt.seltext) + '* ');
          FeldInhalt.GetParaRange(feldinhalt.SelStart,absatz.start,absatz.length);
          formatmd(absatz.start,absatz.length,false);
      end;
end;

procedure TFenster.ButtonListeAnfangClick(Sender: TObject);
begin
    liste.toprow:=0 ;
end;

procedure TFenster.ButtonListeVorClick(Sender: TObject);
var
   i:     integer;
begin
   i:=trunc(liste.height/liste.defaultrowheight)-1;
      liste.toprow:=liste.toprow + i ;

end;

procedure TFenster.ButtonListeZurueckClick(Sender: TObject);
var
   i:     integer;
begin
   i:=trunc(liste.height/liste.defaultrowheight)-1;
   if i < liste.toprow then
      liste.toprow:=liste.toprow - i else liste.toprow:=0;

end;

procedure TFenster.ButtonNeuDialogWegClick(Sender: TObject);
begin
  PanelNeueQuelle.height:=1;
  resizeWindow();
end;

procedure TFenster.ButtonNeueGliederungClick(Sender: TObject);
var
          p1,p2,titel:string;
begin
    if gliederung.items.count> 1
    then GliederungSpeichern(DBDirectory + Gliederungsdatei);
     p1:='neue Gliederung';
     p2:='Name der Datei:';
     titel := inputbox(p1, p2, '');
     if length(titel) > 2 then
     begin
          Gliederungsdatei:=titel + '.tree';
          Gliederung.Items.Clear;
          SetIni('gliederungsdatei',gliederungsdatei);
          GliederungSpeichern(DBDirectory + Gliederungsdatei);
          IconGliederungClick(self);
          //die neue Gliederung kommt in die Liste
     end;
end;

procedure TFenster.ButtonScrolldownClick(Sender: TObject);
begin

end;

procedure TFenster.ButtonSpiegelstrichClick(Sender: TObject);
var
   absatz:       tpararange;
   altepos:      integer;
begin
  altepos:=fenster.feldinhalt.SelStart;
  Fenster.FeldInhalt.GetParaRange( altePos,
                                   Absatz.start,Absatz.length );
  if Fenster.Feldinhalt.gettext(absatz.start,1) = '-' then
  begin // Spiegelstrich ist schon da und kommt weg
      Fenster.feldinhalt.selstart:=absatz.start;
      Fenster.feldinhalt.sellength:=2;
      Fenster.feldinhalt.CutToClipboard;
      Fenster.feldinhalt.selstart:=altepos-2;;
  end else begin
      //Clipboard.AsText:= '- ' ;
      Fenster.feldinhalt.selstart:=absatz.start;
      paste('- ');
      Fenster.feldinhalt.selstart:=altepos+2;;
  end;
    formatmd(absatz.start,absatz.length,false);
end;

procedure TFenster.ButtonTiteldatenSpeichernClick(Sender: TObject);
const
     //Die Spalten in der Titeldatenmatrix
     Seiten      = 7;
     Zeitschrift = 8;
     Sammelband  = 10 ;
     Verlag=       11;
var
   erstautor:  string;
   gefunden:   boolean;
   i:          integer;
   neu:        boolean;
   typ:        string;

begin
      MachPause();
      Vorschlagsliste.visible:=False;
      if istextchanged then savechangestoarray();
      if schreibrecht() then      // Schreibrecht vorhanden. Ohne geht gar nichts
      begin

            { prüfen, ob es sich um einen neuen Datensatz handelt }
            neu:=true;
            if AktuelleLiteraturID<>'' then neu:=false;
            if neu then
            begin
               increaseMaxID('Literatur');
               AktuelleLiteraturArrayZeile:=
                      getTopEmptyRow('Literatur');  //Dahin wird geschrieben werden  // ID erzeugen und schreiben

              // showmessage(Literatur[AktuelleLiteraturArrayZeile,Spalte_autor])  ;

               Literatur[AktuelleLiteraturArrayZeile,1]:= IntToStr(GetMaxID('Literatur'));
               Fenster.Feldinhalt.lines.clear;
               IsTextChanged:=false;
           end;

           // ----------------------------------
           //falschen Publikatonstyp korrigieren
           // ----------------------------------
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
           If (RadioSammelband.checked)  and (Titeldatenmatrix.cells[1,5]<>'')
            then RadioArtikel.checked:=true;

           // ist es ein Buch?
           if  (Titeldatenmatrix.cells[1,Verlag]<>'')
           and (Titeldatenmatrix.cells[1,Zeitschrift]='')
           and (Titeldatenmatrix.cells[1,Sammelband]='')
           and (Titeldatenmatrix.cells[1,Seiten]='')
           and (RadioSammelband.checked=false)
           then  RadioBuch.checked:=true;

           // ist es eine Zeitschrift?
           If (Titeldatenmatrix.cells[1,Zeitschrift]<>'') then RadioArtikel.checked:=true;




           //fehlende Angaben im Autoren- und Jahresfeld
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
           Erstautor:=Literatur[AktuelleLiteraturArrayZeile,Spalte_Erstautor];

           Literatur[AktuelleLiteraturArrayZeile, Spalte_Bearbeitungsdatum] :=   formatdatetime('yyyymmddhhnn', now);
           if Literatur[AktuelleLiteraturArrayZeile, Spalte_Erstelldatum] ='' then
              Literatur[AktuelleLiteraturArrayZeile, Spalte_Erstelldatum]:= formatdatetime('dd.mm.yyyy', now);


           LiteraturVolltext(AktuelleLiteraturArrayZeile); // Volltext muß SeiteNeu angelegt werden.
           MachPause();
           UpdateBearbeitungszahl();
           lchanged:=true;

      end;

      machpause();
      //Die Sortierung hat sich evtl. geändert. Vielleicht ein neuer Datensatz
      with fenster do
      begin
            fenster.AlleAnzeigenClick(self);
            timer.enabled:=true;
            TimerTimer(self);
            machpause();
            FocusTo('Liste');
            // Den (neuen) Datensatz in der Liste aufrufen
            gefunden:=false;
            For i:=0 to Fenster.Liste.Rowcount-1 do
            begin
                 if  pos(Erstautor,Trefferarray[i,TrefferArraySpalteTitel])>0
                 then gefunden:=true;
                 if (Trefferarray[i,TrefferArraySpalteTyp]<>'L')
                 then gefunden:=false;
                 if gefunden then
                 begin
                      Fenster.Liste.Row:=i;
                      timer.enabled:=true;
                      break;
                 end;
            end;
        end;
      CancelTiteldatenclick(self);
end;

procedure TFenster.ButtonTrefferHochClick(Sender: TObject);
var
          i:   integer;
begin
       i:=liste.row - trunc(liste.height/liste.defaultrowheight);
       if i<0 then i:=0;
       liste.row:=i;
end;

procedure TFenster.ButtonTrefferRunterClick(Sender: TObject);
begin

end;

procedure TFenster.CancelTiteldatenClick(Sender: TObject);
begin
  RegisterSuche.ActivePage:=SeiteVolltextsuche;
  ResizeWindow();
end;

procedure TFenster.DateneingabeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

begin

      if key in [vk_return] then
      begin
             if Vorschlagsliste.items.count > 0 then Vorschlagsliste.ItemIndex:=0;
             if Vorschlagsliste.visible then VorschlagslisteClick(self);
             Vorschlagsliste.visible:=False;
             // das nächste Feld aufrufen
             if (titeldatenmatrix.row < 15) and (titeldatenmatrix.row > 0)  then
              titeldatenmatrix.row :=titeldatenmatrix.row +1;
             key:=0;
      end;
      if key in [vk_tab] then
      begin
           TiteldatenMatrix.cells[1,Titeldatenmatrix.row]:=Dateneingabe.text;
           if (ssShift in Shift)  then { so kann ich SHIFT+TAB abfragen }
           begin
               if titeldatenmatrix.row >1  then
               titeldatenmatrix.row :=titeldatenmatrix.row -1;
           end else begin
               if titeldatenmatrix.row < 15 then
               titeldatenmatrix.row :=titeldatenmatrix.row +1;
           end;
           key:=0;
           Dateneingabe.text:=Titeldatenmatrix.cells[1,TiteldatenMatrix.row];
           FocusTo('Dateneingabe');
           Dateneingabe.SelStart:=1000;
           Vorschlagsliste.visible:=false;
      end;
      UngespeicherteZeichen:=UngespeicherteZeichen+1;
end;

procedure TFenster.DateneingabeKeyPress(Sender: TObject; var Key: char);
var
       f:string;
begin
     if key<>#8 then
     begin
         f:=Dateneingabe.text;
         f:=f+key;
         f:=trim(f);
         { 01/20236 f ist das Namensfragment des letzten Namens }
         while pos(';',f) > 0 do
               f:=copy(f,2,1000);
         f:=trim(f);
         if (length(f) > 1)  then AutoComplete('Autoren',f);
     end;

end;

procedure TFenster.DateneingabeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     {kommt erst hier, weil bei keypress oder keydown nicht aktualisiert wird}
     TiteldatenMatrix.cells[1,Titeldatenmatrix.row]:=trim(Dateneingabe.text);
end;

procedure TFenster.EingabeTitelNeueNotizKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then runderButtonSchaltflaeche16Click(self);
  if key = vk_escape then ButtonNeuDialogWegClick(self);
end;

procedure TFenster.EinstellungenShow(Sender: TObject);
begin

end;

procedure TFenster.FeldinhaltChange(Sender: TObject);
begin

end;

procedure TFenster.FeldinhaltKeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TFenster.FontDialogClose(Sender: TObject);
var
   standardzeichen: tfontparams;
begin
  Feldinhalt.Font.Name:=FontDialog.Font.name;
  Feldinhalt.font.size:=fontDialog.font.size;

  SetIni('feldinhaltfont',feldinhalt.font.name);
  SetIntegerIni('fontsize',feldinhalt.font.size);
  fsize:= feldinhalt.font.size;
  Zeichensatz:=FeldInhalt.Font.Name;
  ZeichenSatzEinstellen();
   with Standardzeichen do //normaler Text ohne Formatierungen
   begin
       Size:=fsize;
       name:=FontDialog.font.name;
       Color:=Feldinhalt.font.color;
       BkColor:=feldinhalt.color;
       hasBkClr:=true;
       Style:=[];
   end;
   Liste.Font.Size:=fsize;
   Fenster.Feldinhalt.SetRangeparams(0,10000,[ tmm_backcolor,
                                     tmm_Size,
                                     tmm_Name,
                                     tmm_color,
                                     tmm_styles],
                                     Standardzeichen,
                                     [],                //Attribute dazu
                                     []); //Attribute weg

end;

procedure TFenster.GrenzeSchlagwortsucheEinClick(Sender: TObject);
var
   anzahlkombinationen:    integer;
   anfang:                 integer;
   h:                      integer;
   i:                      integer;
   j:                      integer;
   w:                      string;
   wort:                   string;
   wortliste:              string;
   z:                      integer;

begin
     AnzahlKombinationen:=0;
      //-- Das Memo leeren und füllen --
      //--------------------------------
      Memofilter.lines.clear;
      for i:=0 to swliste.count -1 do
      begin
         w:=  ansilowercase(getfirstword(swliste[i])); //das Schlagwort
         for j := 0 to liste.rowcount -1 do  //die bisherigen Treffer
         begin
              z:=str2int(Trefferarray[j,TrefferArraySpalteArrayZeile]) ;
              if Trefferarray[j,TrefferArraySpalteTyp]='L' then
              begin
                   if  (pos(w,Literatur[z,spalte_volltext]) > 0) then
                   begin
                        AnzahlKombinationen:=AnzahlKombinationen +1;
                        MemoFilter.Lines.text:= MemoFilter.lines.text
                            + getfirstword(swliste[i]) + '  ' ;                                    ;
                        break;
                   end;
              end else begin // die Notizen durchsuchen
                  if  (pos(w,Daten[z,spalte_volltext]) > 0) then
                   begin
                        AnzahlKombinationen:=AnzahlKombinationen +1;
                        MemoFilter.Lines.text:= MemoFilter.lines.text
                            + getfirstword(swliste[i]) + '  ' ;                                    ;
                        break;
                   end;
              end;
         end;

      end;




      { Die Liste kombinierter Schlagwörter ist jetzt vollständig. Jetzt noch
        die ausgewählten Schlagwörter aus der Sucheingabe im Memo fett
        markieren }
      Wortliste:=Sucheingabe.text;
      while length(wortliste) > 1 do
      begin
           wort:=getfirstword(wortliste);
           wortliste:=deletefirstword(wortliste);

           anfang:=Fenster.MemoFilter.Search(wort,0,10000,[]);
           if anfang > -1 then
                     Fenster.MemoFilter.SetRangeParams( anfang, length(wort),
                                             [tmm_styles, tmm_color], '',0,
                                             blau,[fsbold], []);


      end;
   resizewindow();

end;

procedure TFenster.HomemadeButtonMouseEnter(Sender: TObject);
begin
      if sender is tpanel then Tpanel(sender).font.style:=[fsbold];
end;

procedure TFenster.HomemadeButtonMouseLeave(Sender: TObject);
begin
        if sender is tpanel then Tpanel(sender).font.style:=[];
end;

procedure TFenster.IconFormatierungClick(Sender: TObject);
begin
    PopupTextFormatierung.PopUp;
end;

procedure TFenster.IconQVMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   link:     string;
begin
     if (GetKeyState(VK_shift) = 0) then
     begin
         link:= copy(Labeltitel.Text,1,60);
         if length(link) > 40 then link:=deletelastword(link) ;
         link:=StringReplace(link,' ' , '_', [rfReplaceAll]);
         if AngezeigterTyp='L' then  // Datensatz ist eine Quelle
         begin
             link:='ref://' + AktuelleLiteraturid + '_'+link
         end else begin  //Datensatz ist eine Notiz
             link:='note://' + AktuelleNotizid + '_'+link
         end;
         Clipboard.AsText:= link;
         Nachricht('Querverweis in die Zwischenablage kopiert',1);
     end else begin
          Registerkarten.Activepage:=Ideenseite;
          Registersuche.activepage:=SeiteQuerverweis;
          QuerverweisAllesZeigenClick(self);
     end;

end;

procedure TFenster.IconWeiterSpulenClick(Sender: TObject);
begin

end;

procedure TFenster.IconZumAnfangSpulenClick(Sender: TObject);
begin

end;

procedure TFenster.IconZurueckSpulenClick(Sender: TObject);
begin

end;

procedure TFenster.IdeenSeiteEnter(Sender: TObject);
begin
    PanelFeldInhaltIcons.visible:=true

end;

procedure TFenster.IdeenSeiteExit(Sender: TObject);
begin

end;

procedure TFenster.ButtonScrollUpClick(Sender: TObject);
begin

end;

procedure TFenster.IconAnsEndeSpulenClick(Sender: TObject);
begin

end;

procedure TFenster.Image5Click(Sender: TObject);
begin
     if registersuche.activepage <> SeiteVolltextsuche
     then registersuche.activepage:=SeiteVolltextsuche;
     Sucheingabe.Text:='';;
     SchlagwortlisteZeigenClick(self);
end;

procedure TFenster.ImageMenuSortierungClick(Sender: TObject);
begin
    MenuSortierung.Popup;
end;

procedure TFenster.ImageSchlagwortlisteWegClick(Sender: TObject);
begin
         PanelKombinierterSchlagwoerter.BorderStyle:=bsnone;
         PanelKombinierterSchlagwoerter.height:=1;
         resizewindow();
end;

procedure TFenster.Buttonscholarclick(Sender: TObject);

var
 datname:string;
 form:string;
 nr:integer;
begin
     datname:=DBDirectory + 'import.tmp';
     fenster.MemoZwischenablage.lines.clear;
     if os='win'
     then  fenster.MemoZwischenablage.PasteFromClipboard
     else  fenster.MemoZwischenablage.Lines.text:=clipboard.astext;

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
           for nr:=1 to arraysize_Literatur do
              if Literatur2[nr,Spalte_Autor]<> '' then break;
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

           SetLength(Literatur2, 1,1);  //Die Datenbank verkleinern
           Dateneingabe.text:= Titeldatenmatrix.cells[1,0];
     end else begin
           showmessage('Das Format konnte nicht erkannt werden...');
           Dateneingabe.visible:=false;
     end;


end;

procedure TFenster.KMemo1Change(Sender: TObject);
begin

end;

procedure TFenster.Label27Click(Sender: TObject);
begin

end;

procedure TFenster.Label5Click(Sender: TObject);
begin
end;

procedure TFenster.LabelKapitelClick(Sender: TObject);
begin

end;

procedure TFenster.LabelOptionMitQuerverweisClick(Sender: TObject);
begin
  { umständlich, aber unter Windows kann die Fontfarbe einer checkbox
    nicht verändert werden. Unter Linux geht das. Daher eine Aufteilung
    in Checkbox ohne Caption und ein Label }
  OptionMitverweis.checked:=not OptionMitverweis.checked;

end;

procedure TFenster.LabelSammelbandClick(Sender: TObject);
begin

end;

procedure TFenster.LabelTrefferzahlClick(Sender: TObject);
var
   z:integer ;
begin
  z:=GetTopemptyrow('Daten');
  showmessage(inttostr(z) + ' -- ' + Daten[z, Spalte_ID]);
end;

procedure TFenster.LabelVerweiseClick(Sender: TObject);
begin

end;

procedure TFenster.ListeGliederungen2Change(Sender: TObject);
begin

end;

procedure TFenster.ListeGliederungen2Click(Sender: TObject);
begin

end;

procedure TFenster.ListeGliederungen2DblClick(Sender: TObject);
begin

end;

procedure TFenster.MarkierungenloeschenClick(Sender: TObject);
var
   i:integer;
begin
     if nobox('Markierungen löschen?') then
     begin
           for i:=1 to arraysize_Literatur do
           begin
                if pos('#tag#',Literatur[i,Spalte_Anmerkung]) > 0 then
                begin
                     Literatur[i,Spalte_Anmerkung]:=
                       stringreplace(Literatur[i,Spalte_Anmerkung],'#tag#','',[rfreplaceall]) ;
                     LiteraturVolltext(i);
                     lchanged:=true;
                end ;
           end;
           for i:=1 to arraysize_Daten do
           begin
                if pos('#tag#',Daten[i,Spalte_Anmerkung]) > 0 then
                begin
                     Daten[i,Spalte_Anmerkung]:=
                        stringreplace(Daten[i,Spalte_Anmerkung],'#tag#','',[rfreplaceall]) ;
                     NotizVolltext(i);
                     ichanged:=true;
                end;
           end;
           AlleAnzeigenClick(self);
     end;
end;

procedure TFenster.MemoFilterChange(Sender: TObject);
begin

end;

procedure TFenster.MemoFilterClick(Sender: TObject);
      var
        i: integer;
        txt, s, res:WideString;
        titel:  string;
begin
       //--das angeklickte Wort ermitteln --
        //-----------------------------------
        // aus: https://www.lazarusforum.de/viewtopic.php?t=5631
        txt:=UTF8Decode(MemoFilter.Text);
        i := MemoFilter.SelStart;
        s := '';
        Res := '';
        repeat
          Res := s + Res;
          s := Copy(txt, i, 1);
          Dec(i);
        until (s <= ' ') or (i < 0);
        i := MemoFilter.SelStart + 1;
        s := '';
        repeat
          Res := Res + s;
          s := Copy(txt, i, 1);
          Inc(i);
        until (s <= ' ') or (s = '');
        titel:= UTF8Encode(Res);
        if pos(ansilowercase(titel),ansilowercase(Sucheingabe.text)) = 0
        then sucheingabe.text:= sucheingabe.text + ' ' + titel
        else sucheingabe.text:= StringReplace(sucheingabe.text,titel , '', [rfReplaceAll]);
        sucheingabeclick(self);
        machpause();

        GrenzeSchlagwortsucheEinClick(self);
        SetFilterHeight();
        FocusTo('Sucheingabe'); { damit der Fokus vom Memo weg ist und der
                                  Cursor kein Beam ist.  }



end;

procedure TFenster.MemoGliederungenChange(Sender: TObject);
begin

end;

procedure TFenster.MemoGliederungenClick(Sender: TObject);
var
        i: integer;
        txt, s, res:WideString;
        titel:  string;
begin
        //--das angeklickte Wort ermitteln --
        //-----------------------------------
        // aus: https://www.lazarusforum.de/viewtopic.php?t=5631
        txt:=UTF8Decode(MemoGliederungen.Text);
        i := MemoGliederungen.SelStart;
        s := '';
        Res := '';
        repeat
          Res := s + Res;
          s := Copy(txt, i, 1);
          Dec(i);
        until (s <= ' ') or (i < 0);
        i := MemoGliederungen.SelStart + 1;
        s := '';
        repeat
          Res := Res + s;
          s := Copy(txt, i, 1);
          Inc(i);
        until (s <= ' ') or (s = '');
        titel:= UTF8Encode(Res);

        //--angeklickte Gliederung aufrufen --
        //------------------------------------
        if length(titel) > 1 then
        begin
              Gliederung.items.clear; // Gliederungsanzeige löschen;
              Gliederungsdatei:=titel + '.tree' ;
              SetIni('gliederungsdatei',Gliederungsdatei);
              if fileexists(DBDirectory + Gliederungsdatei) then
              Gliederung.LoadFromFile(DBDirectory + Gliederungsdatei);
              //Gliederungsinhalt laden
              if Gliederung.Items.Count > 20
                 then ButtonGliederunglevel1click(self)
                 else Gliederung.fullexpand;
              LabelComboboxGliederung.caption:=titel;

              //Icons setzen
              for i:=0 to Gliederung.Items.Count -1 do
                  Gliederung.Items[i].ImageIndex:=0;
              //angeklickte Gliederung fett
              GliederungMd();

          end;

          FocusTo('Gliederung');



end;

procedure TFenster.MemoGliederungenMouseEnter(Sender: TObject);
begin
  Screen.Cursor:=crhandpoint;
end;

procedure TFenster.MemoSchlagwoerterClick(Sender: TObject);
var
   i:             integer;
   r:             widestring;
   res:           widestring;
   s:             widestring;
   sw:            string;
   txt:           widestring;
begin
        //--das angeklickte Wort ermitteln --
        //-----------------------------------
        // aus: https://www.lazarusforum.de/viewtopic.php?t=5631
        with MemoSchlagwoerter do
        begin
            txt:=UTF8Decode(Text);
            i := SelStart;
            s := '';
            Res := '';
            repeat
              Res := s + Res;
              s := Copy(txt, i, 1);
              Dec(i);
            until (s <= ' ') or (i < 0);
            i := SelStart + 1;
            s := '';
            repeat
              Res := Res + s;
              s := Copy(txt, i, 1);
              Inc(i);
            until (s <= ' ') or (s = '');
            sw:= UTF8Encode(Res);
        end;
        insertkeyword(sw);
        FocusTo('Feldinhalt');
        IconSchlagwortClick(self);
end;

procedure TFenster.MenuLiteraturZeigenClick(Sender: TObject);
begin
  MenuLiteraturZeigen.checked:=not MenuLiteraturzeigen.checked;
  if not MenuNotizenzeigen.checked then  MenuNotizenzeigen.checked:=true;
  { Mindestens eine Kategorie muss angezeigt werden.}
end;

procedure TFenster.MenuNotizenZeigenClick(Sender: TObject);
begin
   MenuNotizenZeigen.checked:=not MenuNotizenzeigen.checked;
  if not MenuLiteraturZeigen.checked then  MenuLiteraturZeigen.checked:=true;
  { Mindestens eine Kategorie muss angezeigt werden.}
end;

procedure TFenster.MenuNurMarkierteClick(Sender: TObject);
begin
  MenuNurMarkierte.checked:=not MenuNurMarkierte.checked;
end;

procedure TFenster.MenuSortAlphaClick(Sender: TObject);
begin
  MenuSortAlpha.Checked:=true;;
end;

procedure TFenster.MenuSortTimeClick(Sender: TObject);
begin
  MenuSortTime.checked:=true;
end;

procedure TFenster.OptionRISExportChange(Sender: TObject);
begin

end;

procedure TFenster.PanelInhaltClick(Sender: TObject);
begin

end;

procedure TFenster.RegisterEinstellungenChange(Sender: TObject);
begin

end;

procedure TFenster.PanelhintergrundobenClick(Sender: TObject);
begin

end;

procedure TFenster.runderButtonRechts11Click(Sender: TObject);
begin

end;

procedure TFenster.runderButtonSchaltflaeche16Click(Sender: TObject);
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




     neuertitel := trim(EingabeTitelNeueNotiz.text)   ;
     anlegen:=true;
     if length(neuertitel) = 0  then  anlegen:=false;

     // prüfen, ob es den Titel schon gibt
     if anlegen then
     begin
          for i := Arraysize_Daten downto 1 do
          begin
               if ansilowercase(Daten[i, Spalte_Titel]) = ansilowercase(neuerTitel)    then
               begin
                    showmsg('Eine Notiz mit diesem Titel gibt es schon') ;
                    anlegen:=false;
               end;
          end;
     end;
     // Der Titel ist ok und existiert noch nicht
     if anlegen  then
     begin
           IncreaseMaxID('Daten');
           NeueZeile:=getTopEmptyRow('daten');
           Daten[NeueZeile, Spalte_ID]:= inttostr(IdeenIDMax);
           Daten[NeueZeile, Spalte_Bearbeitungsdatum] := formatdatetime('yyyymmddhhnn', now);
           Daten[NeueZeile, Spalte_Erstelldatum] :=      formatdatetime('yyyymmddhhnn', now);
           Daten[NeueZeile, Spalte_Titel] := Neuertitel;
           LabelTitel.caption:=NeuerTitel;
     //      Feldinhalt.Lines.Clear;


           // Verweis einfügen -----
           linkalt:= StringReplace(linkalt,' ' , '_', [rfReplaceAll])+ ' ';
           if Optionmitverweis.checked
           then Daten[NeueZeile, Spalte_Anmerkung]:=
                 Daten[NeueZeile, Spalte_Anmerkung] + ' ' + linkalt;
           linkneu:='note://' + neueID+ ' ' + neuertitel;
           linkneu:= ' ' + StringReplace(linkneu,' ' , '_', [rfReplaceAll])+ ' ';

          if Optionmitverweis.checked then
          begin
               paste(linkneu);
               if Altertyp='N' then
               begin
                  Daten[AlteZeile,Spalte_Anmerkung]:=Daten[AlteZeile,Spalte_Anmerkung] + linkneu;
                  Daten[AlteZeile, Spalte_Bearbeitungsdatum] :=      formatdatetime('yyyymmddhhnn', now);
               end;
               if Altertyp='L' then
               begin
                  Literatur[AlteZeile,Spalte_Anmerkung]:=Literatur[AlteZeile,Spalte_Anmerkung] + linkneu;
                  Literatur[AlteZeile, Spalte_Bearbeitungsdatum] :=      formatdatetime('yyyymmddhhnn', now);
                  lchanged:=true;
               end;
          end;

          ichanged:=true;  //sowieso
          ButtonNeuDialogWegClick(self);

          //ist der Array noch groß genug?
          if Arraysize_daten - GetTopEmptyRow('daten') < 100 then
          begin
             SetLength(Daten, ArraySize_Daten+102,Spalte_Position+1);
             Arraysize_daten:=Arraysize_daten+100;
          end;



          AlleAnzeigenClick(self);
          // auf den neuen Datensatz fokussieren
          for i:=0 to  Liste.Rowcount-1    do
          begin
              if TrefferArray[i,TrefferArraySpalteTitel]=NeuerTitel then
              begin
                   Liste.Row:=i;
                   break;
              end;
          end;
          FocusTo('Feldinhalt');
          Feldinhalt.SelStart:=1000;
          formatmd(0,100,false);




    end;


end;

procedure TFenster.ScrollbarGliederungHintergrundClick(Sender: TObject);


begin
       Gliederung.items[Gliederung.Items.Count-1].selected:=true  ;
       GliederungClick(self);
       ScrollbarGliederungHintergrundOben.height:=ScrollbarGliederung.height-100;

end;

procedure TFenster.ScrollbarGliederungHintergrundObenClick(Sender: TObject);
begin
     Gliederung.items[0].selected:=true;
     GliederungClick(self);
      ScrollbarGliederungHintergrundOben.height:=12;
end;

procedure TFenster.ScrollbarListeHintergrundClick(Sender: TObject);
var
   m:    integer;
begin
   m:= (Sender as TPanel).ScreenToControl(Mouse.CursorPos).y;
   if m < scrollbarlisteschieber.top then // nach oben scrollen
   begin
      Liste.Row:=liste.row - trunc(liste.height/liste.defaultrowheight)-1;
      if scrollbarlisteschieber.top >  scrollbarlisteschieber.height  then
      begin
          scrollbarlisteschieber.top:=  scrollbarlisteschieber.top  -
                                        scrollbarlisteschieber.height  ;
      end else begin
         scrollbarlisteschieber.top:= ScrollbarListeHintergrund.top;
         Liste.Row:=0;
      end;
   end else begin; //nach unten scrollen
      Liste.Row:=liste.row + trunc(liste.height/liste.defaultrowheight)+1;
      if scrollbarlisteschieber.top +  50 +
         scrollbarlisteschieber.height +
         scrollbarlisteschieber.height <  ScrollbarListeHintergrund.height then
      begin

             scrollbarlisteschieber.top:=  scrollbarlisteschieber.top  +
                                           scrollbarlisteschieber.height
      end else begin // Schieber am Ende
           scrollbarlisteschieber.top:=  ScrollbarListeHintergrund.height -
                                         (scrollbarlisteschieber.height +20) ;
           liste.row:=liste.rowcount-1;
      end;


   end;


end;

procedure TFenster.ScrollbarTextHintergrund(Sender: TObject);
var
   m:    integer;
   wo:   real;
begin
   m:=  Mouse.CursorPos.y;
   m:=m-fenster.top;
   m:=m-feldinhalt.top -trunc(140*skalierung);
   wo:=m/PanelAnmerkungenScrollbarButton.height;
   FocusTo('Feldinhalt');
   if wo<0.3 then
   begin
        Feldinhalt.SelStart:=0;
        ScrollbarAnmerkungenSchieber.align:=altop;
   end;
   if wo>0.5 then
   begin
        Feldinhalt.SelStart:=10000;
        ScrollbarAnmerkungenSchieber.align:=albottom;
   end;


end;

procedure TFenster.ScrollbarAnmerkungenClick(Sender: TObject);
begin

end;

procedure TFenster.PanelPanikClick(Sender: TObject);
begin

end;

procedure TFenster.PanikButtonClick(Sender: TObject);
begin

end;

procedure TFenster.RichMemo1Change(Sender: TObject);
begin

end;

procedure TFenster.SchlagwortlisteZeigenClick(Sender: TObject);
begin
         if PanelKombinierterSchlagwoerter.height < 50 then
         begin
            if sucheingabe.text = ''
            then ZeigeAlleSchlagwoerterClick(self)
            else GrenzeSchlagwortsucheEinClick(self);
        end else begin
            ImageSchlagwortlisteWegClick(self);
        end;

     resizewindow();
end;

procedure TFenster.ScrollBoxEinstellungenClick(Sender: TObject);
begin

end;

procedure TFenster.SeiteVolltextsucheShow(Sender: TObject);
begin
     AnzeigeModus:='volltextsuche';
end;

procedure TFenster.switchMouseEnter(Sender: TObject);
begin

  // FarbeGrosseltern:=(((sender as timage).parent as tpanel).Parent as tpanel).Color;


     ((sender as timage).parent as tpanel).Font.style:=[fsbold] ;

end;

procedure TFenster.ScrollbarAnfangGliederungClick(Sender: TObject);
begin
     Gliederung.items[0].selected:=true;
     GliederungClick(self);
end;

procedure TFenster.ImageCodeClick(Sender: TObject);
var
   t1,t2:string;
begin
    If AngezeigterTyp='L' then
    begin
         t1:=  Literatur[AktuelleLiteraturArrayZeile,Spalte_Anmerkung];
         if pos('#lock#',t1) = 0 then
         begin
              t2:=t1 + ' #nowordwrap#';
         end else  begin
             t2:=copy(t1,1,pos('#nowordwrap',t1)-1)  + copy(t1,pos('#nowordwrap',t1)+6,100000) ;

         end;
         Literatur[AktuelleLiteraturArrayZeile,Spalte_Anmerkung]:=t2;
         lchanged:=true;

    end;
    If AngezeigterTyp='N' then
    begin
         t1:=  Daten[AktuelleNotizenArrayZeile,Spalte_Anmerkung];
         if pos('#nowordwrap#',t1) = 0 then
         begin
              t2:=t1 + ' #nowordwrap#';
         end else  begin
             t2:=copy(t1,1,pos('#nowordwrap',t1)-1) + copy(t1,pos('#nowordwrap',t1)+6,100000) ;
         end;
         Daten[AktuelleNotizenArrayZeile,Spalte_Anmerkung]:=t2;
         ichanged:=true;
    end;

    Feldinhalt.text:=t2;

    if istextchanged then savechangestoarray();

    Timer.Enabled:=False;
    Timer.Enabled:=true;

end;

procedure TFenster.ImageFontClick(Sender: TObject);
begin
     FontDialog.Font.name:=Feldinhalt.Font.name;
     FontDialog.font.size:=Feldinhalt.font.size;
     FontDialog.Execute;
end;

procedure TFenster.ListeGliederungenClick(Sender: TObject);

begin


end;

procedure TFenster.FarbSchemaClick(Sender: TObject);
var
     fc:   tcolor;
     bc:   tcolor;

     ufc:  tcolor;   //Unterfenster;
     uufc: tcolor; //UnterUnterfenster
     buf:  tcolor; //Button in einem Unterfenster
     urlcolor: tcolor;
begin

     if var_optiondarkmode then
     begin  //dark mode
          bc:=$121212;//clblack;    282828
          LiteraturFarbeNormal:=$004C4C4C;   //$003b1c32 zu dunkel, man erkennt nichts
          ufc:=$3f3f3f3f  ;
          uufc:=$00717171 ;
          buf:=$00515151;
          fc:=clwhite;
          urlcolor:=claqua;// clsilver;
     end else begin  //light mode
         bc:=clwhite;
         buf:= $00EAF2F9;

         literaturfarbenormal:= $00EAEAEA;
         ufc:=  $F7F8F9;              //      $00F7F8F9
         uufc:=  $00ECEDE3;
         fc:=clblack;
         urlcolor:=clblue;
     end;


     //Hintergründe
     Fenster.color:=bc;
     hintergrund.color:=bc;

     Fenster.font.color:=fc;
     fenstereditor.color:=bc;
     fenstereditor.font.Color:=fc;
     Gliederung.font.color:=fc;

     //--- alphabetische Reihenfolge --

     ButtonAnlegen.color:=buf;
     BaumVerweise.font.color:=urlcolor;
     BaumVerweise2.font.color:=urlcolor;
     BaumVerweise3.font.color:=urlcolor;

     EingabeTitelNeueNotiz.font.color:=fc;

     feldinhalt.font.color:=fc;




     hintergrund.font.color:=fc;
     hintergrundVolltext.color:=ufc;
     hintergrundVolltext.font.color:=fc;
     hintergrundGliederung.color:=ufc;
     hintergrundGliederung.font.color:=fc;

     Label41.font.color:=fc;

     LabelComboboxGliederung.Font.color:=fc;
     LabelEditorNamen.Font.color:=fc;



     LabelErstelltam.Font.color:=fc;
     LabelFormatAnhang.Font.Color:=fc;
     LabelFussnote.font.Color:=fc;;
     LabelGeaendertam.Font.color:=fc;
     LabelGliederungName.Font.color:=fc;
     LabelGliederungLevel1.font.color:=fc;
     LabelGliederungLevel2.font.color:=fc;
     LabelGliederungLevel3.font.color:=fc;
     LabelGliederungLevelAll.font.color:=fc;
     LabelNameRichtlinie.font.color:=fc;
     LabelOriginalDatei.Font.color:=fc;
     LabelQuellenhinweise.Font.color:=fc;


     LabelSyntax.font.color:=fc;
     LabelTitelNotizGliedern.font.color:=fc;
     LabelTitelSchlagwort.font.Color:=fc;
     LabelTitelQuerverweis.font.Color:=fc;
     LabelTitelFilter.font.Color:=fc;
     LabelTitelNeu.font.Color:=fc;

     LabelVerweise.color:=bc;
     LabelVerweise.font.color:=fc;

     labelvollzitat.font.color:=fc;
     labelVollzitat.color:=bc;


     liste.font.color:=fc;

     MemoGliederungen.font.color:=fc;
     MemoGliederungen.Font.Style:=[fsunderline];

     OptionMitVerweis.font.color:=fc;

     PanelF2.font.color:=fc;
     PanelF3.font.color:=fc;
     PanelFeldinhalt.color:=bc;
     PanelFeldinhalt.font.color:=fc;
     PanelFormatierung.color:=ufc;
     PanelFormatierung.font.color:=fc;
     ScrollbarGliederung.color:=uufc;
     PanelHintergrundSchlagwort.color:=ufc;
     PanelHintergrundSchlagwort.Font.color:=fc;
     PanelHintergrundLink.color:=ufc;
     PanelHintergrundLink.Font.color:=fc;
     PanelIdeenlinks.Color:=ufc;
     PanelIconNotizGliedern.color:=buf;
     PanelIconHerausnehmen.color:=buf;
     PanelDrucken.color:=buf;
     PanelIconEineQuelle.color:=buf;
     PanelKombinierterSchlagwoerter.font.color:=fc;
     PanelManuskript.color:=ufc;
     PanelMenuVolltextsuche.font.Color:=fc;
     PanelMenuVolltextSuche.color:=bc;
     PanelNeueQuelle.font.color:=fc;
     PanelNotizGliedern.Color:=ufc;
     PanelNotizGliedern.font.color:=fc;
     PanelPTyp.font.color:=fc;
     PanelTiteldaten.color:=ufc;
     PanelTiteldaten.font.color:=fc;
     PanelUnterstrichQuer.color:=fc;
     PanelUnterstrich.color:=fc;
     PanelUnterstrichSuche1.color:=fc;
     PanelUnterstrichTitel.color:=fc;

     PanelVergebeneKeywords.font.color:=urlcolor;


     PanelZitierrichtlinie.color:=ufc;
     PanelZitierrichtlinie.font.color:=fc;
     PanelStyleName.font.color:=fc;

     QListe.Font.Color:=fc;
     QSuche.Font.Color:=fc;

     SuchEingabe2.font.color:=fc;

     labeltitel.font.color:=fc;




     //Toggle-Switches einstellen


     if var_optionDarkMode
     then imageOptionDarkMode.picture:=ImageToggleOn.picture
     else imageOptionDarkMode.picture:=ImageToggleOff.picture;



     if var_OptionMenue
     then imageOptionMenue.picture:=ImageToggleOn.picture
     else imageOptionMenue.picture:=ImageToggleOff.picture;





end;

procedure TFenster.fragKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TFenster.IconCombobox1Click(Sender: TObject);
begin

end;

procedure TFenster.ImageOptionDarkModeClick(Sender: TObject);

begin
     var_OptionDarkMode:=not var_OptionDarkMode ;
     setbooleini('optiondarkmode',var_optiondarkmode);
     FarbSchemaClick(self);
     IconRefreshClick(self);
end;

procedure TFenster.ImageOptionMenueClick(Sender: TObject);
begin
     var_optionMenue:=not var_optionMenue;
     if var_optionMenue then
     begin
          ImageOptionMenue.picture:=imagetoggleon.picture ;
          Fenster.Menu:=Hauptmenu;
          RegisterSuche.Borderspacing.Bottom:=46;
     end else begin
         imageOptionMenue.picture:=imagetoggleoff.picture ;
         Fenster.Menu:=nil;
         RegisterSuche.Borderspacing.Bottom:=32;
     end;
     formresize(self);
end;

procedure TFenster.Label13Click(Sender: TObject);
begin

end;

procedure TFenster.Label14Click(Sender: TObject);
begin

end;

procedure TFenster.Label15Click(Sender: TObject);
begin

end;

procedure TFenster.Label16Click(Sender: TObject);
begin

end;

procedure TFenster.Label17Click(Sender: TObject);
begin

end;

procedure TFenster.Label18Click(Sender: TObject);
begin

end;

procedure TFenster.Label19Click(Sender: TObject);
begin

end;

procedure TFenster.Label1Click(Sender: TObject);
begin
  PTypBuch.checked:= not ptypbuch.checked;
end;

procedure TFenster.Label20Click(Sender: TObject);
begin

end;

procedure TFenster.Label21Click(Sender: TObject);
begin

end;

procedure TFenster.Label23Click(Sender: TObject);
begin

end;

procedure TFenster.Label24Click(Sender: TObject);
begin

end;

procedure TFenster.Label2Click(Sender: TObject);
begin
  PtypArtikel.checked:=not PtypArtikel.checked;
end;

procedure TFenster.Label56Click(Sender: TObject);
begin

end;

procedure TFenster.Label57Click(Sender: TObject);
begin

end;

procedure TFenster.Label6Click(Sender: TObject);
begin

end;

procedure TFenster.Label7Click(Sender: TObject);
begin
  letztenNamenUmdrehen.checked:=not letztenNamenUmdrehen.checked;
end;

procedure TFenster.Label8Click(Sender: TObject);
begin
  OptionLangesTMPZitat.checked:=not OptionLangesTMPZitat.checked;
end;

procedure TFenster.Label9Click(Sender: TObject);
begin
  PTypKapitel.checked:=not PTypKapitel.checked;

end;

procedure TFenster.LabelEinstellungenAnzeigeClick(Sender: TObject);
begin

end;

procedure TFenster.LabelEinstellungenDatenaustauschClick(Sender: TObject);
begin

end;

procedure TFenster.LabelEinstellungenDruckenClick(Sender: TObject);
begin


end;

procedure TFenster.LabelEinstellungenErsetzeClick(Sender: TObject);
begin

end;

procedure TFenster.LabelEinstellungenUpdateClick(Sender: TObject);
begin

end;

procedure TFenster.LabelHerausgeber1Click(Sender: TObject);
begin
  AnhangAlleAutoren.checked:= not AnhangAlleAutoren.checked;
end;

procedure TFenster.FeldinhaltDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  showmessage('dragdrop');
end;

procedure TFenster.FeldinhaltEndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  showmessage('Enddrag');
end;

procedure TFenster.fragKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );

begin

end;

procedure TFenster.IconVolltextSucheKleinClick(Sender: TObject);
begin
  Registerkarten.Activepage:=IdeenSeite;
  RegisterSuche.activepage:= SeiteVolltextsuche;
end;

procedure TFenster.ListeNotizGliedernClick(Sender: TObject);
var
         aus:           string;
         LetzterKnoten: TTreeNode;
         n:             ttreenode;
         zeilennr:      integer;
begin
     aufraeumen();
     Zeilennr:=ListeNotizGliedern.ItemIndex;
     if trefferarray[zeilennr,TrefferArraySpalteTyp]='N' then
     begin
          aus:=  trefferarray[zeilennr,TrefferArraySpalteTitel]  +
                 abstand + '(#' + trefferarray[zeilennr,TrefferArraySpalteid];
     end else begin
         aus:= '[=' +
               trefferarray[zeilennr,TrefferArraySpalteid] +
               '-' +
               trefferarray[zeilennr,TrefferArraySpalteTitel];
         aus:=copy(aus,1,55);
         aus:=deletelastword(aus);
         aus:=aus + '=]';
     end;
     { bei einem versehntlichen Doppelklick wird der letzte Gliederungspunkt
       nicht ein weiteres Mal eingefügt. Achtung: Bei einer noch leeren
       Gliederung gibt es keinen lastnde}
     if gliederung.Items.Count > 0 then
     begin
           n:= Gliederung.Items.GetLastNode;
           if aus <> n.text  then  n := Gliederung.Items.AddChild(nil, aus);
     end else  begin
          n := Gliederung.Items.AddChild(nil, aus);
     end;
     GliederungSpeichern(DBDirectory + Gliederungsdatei);
end;

procedure TFenster.ListeSchlagwortsucheClick(Sender: TObject);

begin


end;

procedure TFenster.NachFormCreateTimer(Sender: TObject);
var
         val: integer;
begin
       //   showmessage('11196');
  NachFormCreate.enabled:=false;
    machpause();
    { Kommt nicht in Formresize, weil die Fensterskalierung da noch nicht
      abgeschlossen ist}
    val:=GetIntegerIni('prozentlinks' , 10);
    val:=trunc(screen.width*val/100);
    if val > screen.width then val:=10;
    Fenster.left:=val;


    val:=GetIntegerIni('prozentbreite' , 60);
    val:=trunc(screen.width*val/100);
    if val> screen.width then val:=800;
    if val < 800 then val:=800;
    Fenster.width:=val;

    val:=GetIntegerIni('prozentoben' , 10);
    val:=trunc(screen.height*val/100);
    if val> screen.height then val:=100;
    Fenster.top:=val;

    val:=GetIntegerIni('prozenthoehe' , 60);
    val:=trunc(screen.height*val/100);
    if val> screen.height then val:=600;
    if val<600 then val:=600 ;
    Fenster.height:=val;


  //  showmessage('11232');
end;

procedure TFenster.Panel13Click(Sender: TObject);
begin
  ListeNotizGliedern.Font.size:=Feldinhalt.font.size ;
  Gliederung.Font.Size:=Feldinhalt.font.size;
  registersuche.activepage:=SeiteGliederung;
  if (Gliederung.Selected <> nil)  then   gliederungclick(self);

end;

procedure TFenster.Panel14Click(Sender: TObject);
begin
   registersuche.activepage:=SeiteVolltextsuche;
   if (liste.row > -1 )  then   listeclick(self);
   FocusTo('Sucheingabe');
end;

procedure TFenster.ButtonErsetzeClick(Sender: TObject);
var
   i,j:integer;
   a, n:string;
   fehler:boolean;
begin
  if yesbox('Diesen Befehl können Sie nicht rückgängig machen. Sie sollten die Daten vorher gesichtert haben. Weitermachen?') then
  begin
      fehler:=false;
      a:=FeldSuchText.text;
      n:=ErsatzText.text;
      if length(a)=0 then fehler:=true;
      if length(n)=0 then fehler:=true;
      if pos(a,n)> 0 then fehler:=true;
      if fehler=false then //ersetzen
      begin
          screen.cursor:=crhourglass;
          if OptionSucheLiteratur.checked then
          begin
             for i:=1 to arraysize_Literatur do
             begin
                  if AuswahlFeld.Text='alle' then
                     for j:=1 to 24 do
                           Literatur[i,j]:=
                               stringreplace(Literatur[i,j],a,n,[rfreplaceall]) ;
                  if AuswahlFeld.Text='Zeitschrift' then
                      Literatur[i,Spalte_Zeitschrift]:=
                          stringreplace(Literatur[i,Spalte_Zeitschrift],a,n,[rfreplaceall]) ;
                  if AuswahlFeld.Text='Verlag' then
                      Literatur[i,Spalte_Verlag]:=
                          stringreplace(Literatur[i,Spalte_Verlag],a,n,[rfreplaceall]) ;

                  if AuswahlFeld.Text='Ort' then
                      Literatur[i,Spalte_Ort]:=
                          stringreplace(Literatur[i,Spalte_Ort],a,n,[rfreplaceall]) ;
                  if AuswahlFeld.Text='Autor' then
                      Literatur[i,Spalte_Autor]:=
                          stringreplace(Literatur[i,Spalte_Autor],a,n,[rfreplaceall]) ;
                  //Der Volltext wird aktualisiert, damit die geänderten
                  //Datensätze auch im Volltext gefunden werden  12/2021
                  LiteraturVolltext(i);
             end;
             lchanged:=true;
          end;
          if OptionSucheNotizen.checked then
          begin
               for i := 1 to arraysize_Daten do //NotizArrayLaenge  do
               begin
                    for j:=1 to 6 do daten[i,j]:=stringreplace(daten[i,j],a,n,[rfreplaceall]) ;
               end;
          end;
          FeldSuchText.text:='';
          ersatztext.text:='';

          ButtonDialogAbbruchClick(self);
          screen.cursor:=crdefault;
      end else begin //Fehler aufgetreten

          showmsg('Bitte prüfen Sie Ihre Eingaben und probieren Sie es noch einmal'   );
      end;
  end;


end;

procedure TFenster.ScrollbarEndeGliederungClick(Sender: TObject);
begin

end;

procedure TFenster.PruefeAbsturzClick(Sender: TObject);
var
   ArrayZeile:  integer;
   Datei:       string;
   i:           integer;
   ID:          string;
   j:           integer;
   ListOfFiles: TStringList;
   titel_alt:   string;
   titel_neu:   string;
   txt_alt:     string;
   txt_neu:     string;
begin
      { Falls das Programm das letzte Mal abgestürzt war und es Dateien in
        den TMP Verzeichnissen gibt, werden die jetzt abgeklappert }

      //---- IDEEN AUF UNGESPEICHERTE ÄNDERUNGEN PRÜFEN ------
      ListOfFiles := TStringList.Create;
      FileUtil.FindAllFiles(ListOfFiles, TMPVerzeichnisIdeen, '*', False);
      for i:=0 to ListOfFiles.Count -1 do
      begin
           Datei:=ListOfFiles.Strings[i];
           if pos('.',Datei) > 0 then //es gibt eine Dateiendung
           begin
                 ID:=getlastWord(datei);
                 ArrayZeile:=HolArrayZeileDerNotizID(id);


                 Titel_Neu:=extractfilename(Datei);
                 Titel_Neu:=DeleteLastWord(Titel_Neu);
                 memoZwischenablage.Lines.loadfromfile(datei);
                 txt_neu:= memoZwischenablage.Lines.text;

                 if ArrayZeile=0 then  //die Notiz gibt es in der alten DB noch nicht
                 begin
                      for j:= arraysize_Daten downto 1 do
                      begin
                           //finde die erste leere Zeile
                           if  Daten[j, Spalte_ID]='' then
                           begin
                                ArrayZeile:=j;
                                break;
                           end;
                      end;
                      if str2int(id) < IdeenIDMax then IdeenIDMax:=str2int(id);
                      Daten[ArrayZeile, Spalte_ID]:= id;   ;
                      Daten[ArrayZeile, Spalte_Bearbeitungsdatum] :=  formatdatetime('yyyymmddhhnn', now);
                      Daten[ArrayZeile, Spalte_Erstelldatum] :=   formatdatetime('yyyymmddhhnn', now);
                      Daten[ArrayZeile, Spalte_Titel]:=titel_neu;
                      Daten[ArrayZeile, Spalte_Anmerkung]:=txt_neu;
                 end else begin // Die ID der Notiz existiert schon.
                     Titel_Alt:=Daten[ArrayZeile,Spalte_Titel];

                     if stripfilename(titel_alt) <> stripfilename(titel_neu) then
                     begin
                         Daten[ArrayZeile,Spalte_Titel]:=Titel_Neu;
                         ichanged:=true;
                     end;
                     machpause();
                     txt_alt:=Daten[ArrayZeile,Spalte_Anmerkung];

                     if (txt_alt <> txt_neu) and (length(txt_neu) > length(txt_alt)) then
                     begin
                         Daten[ArrayZeile,Spalte_Anmerkung]:=txt_Neu;
                         ichanged:=true;
                     end;
                     machpause();

                 end;
           end;
      end;
      //---- LITERATUR AUF UNGESPEICHERTE ÄNDERUNGEN PRÜFEN -------
      ListOfFiles.Clear;
      FileUtil.FindAllFiles(ListOfFiles, TMPVerzeichnisLiteratur, '*', False);
      for i:=0 to ListOfFiles.Count -1 do
      begin
           Datei:=ListOfFiles.Strings[i];
           if pos('.',Datei) > 0 then //es gibt eine Dateiendung
           begin
                 ID:=getlastWord(datei);
                 ArrayZeile:=HolArrayZeileDerLiteraturID(id);

                 Titel_Neu:=extractfilename(Datei);
                 Titel_Neu:=DeleteLastWord(Titel_Neu);
                 memoZwischenablage.Lines.loadfromfile(datei);
                 txt_neu:= memoZwischenablage.Lines.text;

                 if ArrayZeile=0 then  //die Notiz gibt es in der alten DB noch nicht
                 begin
                      for j:= arraysize_Literatur downto 1 do
                      begin
                           //finde die erste leere Zeile
                           if  Literatur[j, Spalte_ID]='' then
                           begin
                                ArrayZeile:=j;
                                break;
                           end;
                      end;
                      if str2int(id) < LiteraturIDMax then LiteraturIDMax:=str2int(id);
                      Literatur[ArrayZeile, Spalte_ID]:= id;   ;
                      Literatur[ArrayZeile, Spalte_Bearbeitungsdatum] :=  formatdatetime('yyyymmddhhnn', now);
                      Literatur[ArrayZeile, Spalte_Erstelldatum] :=   formatdatetime('yyyymmddhhnn', now);
                      Literatur[ArrayZeile, Spalte_Titel]:=titel_neu;
                      Literatur[ArrayZeile, Spalte_Autor]:='o.V.';
                      Literatur[ArrayZeile, Spalte_ErstAutor]:='o.V.' ;
                      Literatur[ArrayZeile, Spalte_Jahr]:=formatdatetime('yyyy', now);
                      Literatur[ArrayZeile, Spalte_Anmerkung]:=txt_neu;
                 end else begin
                     Titel_Alt:=Literatur[ArrayZeile,Spalte_Titel];

                     if titel_alt='' then  //nur wenn der Titel nicht besetzt ist
                     begin
                         Literatur[ArrayZeile,Spalte_Titel]:=Titel_Neu;
                         lchanged:=true;
                     end;

                     machpause();
                     txt_alt:=Literatur[ArrayZeile,Spalte_Anmerkung];

                     if (txt_alt <> txt_neu) and (length(txt_neu) > length(txt_alt)) then
                     begin
                         Literatur[ArrayZeile,Spalte_Anmerkung]:=txt_Neu;
                         lchanged:=true;
                     end;
                     machpause();

                 end;
           end;
      end;

      ListOfFiles.Free;






end;

procedure TFenster.QSucheKeyUp(Sender: TObject; var Key: Word;
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
   if registersuche.activepage= SeiteQuerverweis
   then  begriff1:=ansilowercase(QSuche.Text) ;

   max:=500;
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
         for i:=arraysize_daten downto 1 do
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
                 if treffer > max then break;
             end;
         end ;
             //Jetzt die Literatur
         for i:=arraysize_literatur downto 1 do
         begin
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
                 if treffer > max*2 then break;
             end;


          end;

         //Liste mit bubblesort sortieren und ausgeben

         qliste.ItemHeight:=16;
         if MenuSortAlpha.checked then  sortqlist(treffer+1,'az')
                                       else  sortqlist(treffer+1,'zeit');
                                       {02/2024}


   end;

end;

procedure TFenster.QuerverweisAllesZeigenClick(Sender: TObject);
const
     max=50;
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
     { 02/2026: Vereinfacht. Statt eines Mindestdatums jetzt die 50 letzten }
     for i:=GetTopEmptyRow('daten') downto 1 do
     begin
         if  (daten[i,Spalte_id]<>'') then
         begin
                qarray[treffer,1]:= daten[i,Spalte_Titel];
                qarray[treffer,2]:= 'N';
                qarray[treffer,3]:= daten[i,Spalte_ID]  ;
                qarray[treffer,4]:= daten[i,Spalte_Bearbeitungsdatum]  ;
                treffer:=treffer+1;
          end;
          if treffer > max then break;
     end;
     for i:=GetTopEmptyRow('literatur') downto 1 do
     begin
         if  (Literatur[i,Spalte_id]<>'') then
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
          if treffer > max*2 then break;
     end;
     machpause();
     sortqlist(treffer,'zeit');
     machpause();
     FocusTo('QSuche');
end;

procedure TFenster.RegisterOptionenChange(Sender: TObject);
begin
       if RegisterSuche.Activepage= SeiteGliederung then
     begin
          OptionGliederungDrucken.checked:=true;
          OptionNotizenDrucken.checked:=true;
          OptionLiteraturDrucken.checked:=true;
          OptionAnmerkungenDrucken.Checked:=true;
     end;
     if RegisterSuche.Activepage= SeiteVolltextsuche then
     begin
          OptionEineSeiteDrucken.checked:=true;
          OptionNotizenDrucken.checked:=true;
          OptionLiteraturDrucken.checked:=true;
          OptionAnmerkungenDrucken.Checked:=true;
     end;





end;

procedure TFenster.SchlagwortmatrixClick(Sender: TObject);

begin


end;

procedure TFenster.SuchEingabe2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  SucheingabeClick(self);
  machpause();
  timer.enabled:=false;

  timer.enabled:=true;
end;

procedure TFenster.switchMouseLeave(Sender: TObject);
begin
       ((sender as timage).parent as tpanel).Font.style:=[] ;
       ((sender as timage).parent as tpanel).ParentFont:=true ;
end;

procedure TFenster.NotizGliedernFensterWegClick(Sender: TObject);
begin

end;

procedure TFenster.TitelDatenExit(Sender: TObject);
begin
         resizewindow();
end;

procedure TFenster.TitelDatenmatrixClick(Sender: TObject);
begin
     // evtl. vorhandenen Text in das Dateneingabefeld kopieren
     Dateneingabe.text:=Titeldatenmatrix.cells[1,TiteldatenMatrix.row];

     if (titeldatenmatrix.row > 0)
     then
     begin
          Dateneingabe.visible:=false; // das ist der Standard
           Titeldatenmatrix.Options:=
              Titeldatenmatrix.Options + [goAlwaysShowEditor, goEditing];
           FocusTo('Titeldatenmatrix');
     end;
           if (titeldatenmatrix.row in [0])  then
           begin
                Titeldatenmatrix.Options:=
                    Titeldatenmatrix.Options - [goAlwaysShowEditor,goEditing];
                Dateneingabe.visible:=true;
                FocusTo('Dateneingabe');
                Dateneingabe.SelStart:=1000;
           end;



end;

procedure TFenster.TitelDatenmatrixDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin

end;

procedure TFenster.TitelDatenmatrixKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if  (Vorschlagsliste.visible)
     and (Vorschlagsliste.items.count >0)
     and (key=vk_return)
     and (Titeldatenmatrix.row > 0)  then
     begin
          Titeldatenmatrix.Cells[1,Titeldatenmatrix.row]
            :=Vorschlagsliste.Items[0];
          if Titeldatenmatrix.row < Titeldatenmatrix.rowcount then
             Titeldatenmatrix.row :=Titeldatenmatrix.row+1;
          Vorschlagsliste.visible:=false;
     end;
     if key=vk_tab then Vorschlagsliste.visible:=false;
end;

procedure TFenster.TitelDatenmatrixKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if Titeldatenmatrix.Row = 8 then
        autocomplete('Zeitschriften', Titeldatenmatrix.Cells[1,8]);
     if Titeldatenmatrix.Row =11 then
     begin
        autocomplete('Verlage', Titeldatenmatrix.Cells[1,11]);
        findeVerlagsOrt(Titeldatenmatrix.Cells[1,11]);
     end;
end;

procedure TFenster.VorschlagslisteClick(Sender: TObject);
var
       a, f:      string;
begin
     with fenster do
     begin
         If Titeldatenmatrix.row= 0 then
         begin
              f:=Vorschlagsliste.Items[Vorschlagsliste.ItemIndex];
              a:=trim(a);
              a:=Dateneingabe.text;
              a:=deletelastword(a);
              if pos(' ',a) = 0 then a:=''; //den Anfang des ersten Autors weg
              f:=a + ' ' + f   ;
              f:=trim(f);
              Titeldatenmatrix.cells[1,0]:=f;
              Dateneingabe.text:=f;
              FocusTo('Dateneingabe');
              Dateneingabe.selstart:=1000;

         end;


         If Titeldatenmatrix.row=  8 then
         begin
              f:=Vorschlagsliste.Items[Vorschlagsliste.ItemIndex];
              Dateneingabe.text:=f;
              Titeldatenmatrix.cells[1,8]:=f;
              Titeldatenmatrix.row :=Titeldatenmatrix.row +1;
         end;
         If Titeldatenmatrix.row= 11 then
         begin
              f:=Vorschlagsliste.Items[Vorschlagsliste.ItemIndex];
              Titeldatenmatrix.cells[1,11]:=f;
              Dateneingabe.Text:=f;;

              findeVerlagsOrt(f);
              Titeldatenmatrix.row :=Titeldatenmatrix.row +1;

         end;
         Vorschlagsliste.visible:=False;

     end;

end;

procedure TFenster.zeigealleSchlagwoerterClick(Sender: TObject);
var
   h:         integer;
   i :        integer;
   w        : string;

begin
     MemoFilter.lines.clear;
     //Alle Schlagwörter anzeigen
     if Sucheingabe.text = '' then
     begin
          for i:=0 to swliste.count -1 do
          begin
                w:= getfirstword(swliste[i]);
                MemoFilter.lines.text:=Memofilter.lines.text + w + ' ';
          end;
     end;
     //Höhe des Schlagwortfilterfensters
     SetFilterHeight() ;



end;

procedure TFenster.zeigeSchlagwoerterClick(Sender: TObject);

begin
     var_OptionSchlagwortliste:=not var_OptionSchlagwortliste ;

     if var_OptionSchlagwortliste then
     begin




            if sucheingabe.text = ''
            then ZeigeAlleSchlagwoerterClick(self)
            else GrenzeSchlagwortsucheEinClick(self);
         //   PanelKombinierterSchlagwoerter.BorderStyle:=bssingle;
            PanelKombinierterSchlagwoerter.height:=199;
     end else begin

         PanelKombinierterSchlagwoerter.BorderStyle:=bsnone;
         PanelKombinierterSchlagwoerter.height:=1;
     end;

     resizewindow();

end;

procedure TFenster.iconaddkeywordClick(Sender: TObject);
var
    datei:       string;
    i:           integer;
    Neu:         boolean;
    w:           string;

begin

  w := inputbox('Schlagwort', 'neues Schlagwort:', '');
  if length(w) > 1 then
  begin
    Neu:=true;
    for i:=0 to swliste.count -1 do
         if ansilowercase(w)=ansilowercase(swliste[i]) then Neu:=false ;
           {doppelte Schlagwörter vermeiden}
    if Neu then
    begin
         swliste.Add(w);
         Datei := DBDirectory + 'key.dat';
         swliste.savetofile(datei);
         fenster.IconSchlagwortclick(self);
    end;
  end;

end;

procedure TFenster.iconremovekeywordClick(Sender: TObject);
var
  b, w: string;
  datei: string;
  i: integer;
begin

  w := inputbox('Schlagwort aus der Liste nehmen','Schlagwort:', '');

 // w := umlautinliste(w);
  w := ansilowercase(w);
  for i := 0 to swliste.Count - 1 do
  begin
       b := getfirstword(swliste[i]);
      // b:=umlautinliste(b);
       b := ansilowercase(b);
    if w = b then
    begin
      swliste.Delete(i);
      break;
    end;
  end;
  Datei := DBDirectory + 'key.dat';
  swliste.savetofile(datei);

  fenster.IconSchlagwortclick(self);

end;

procedure TFenster.URLHomepageClick(Sender: TObject);
begin
    openurl('http://bibliographix.de');
end;

procedure TFenster.LabelTitelExit(Sender: TObject);
var
   su, er:     string;
   i:          integer;
   oldcaption: string;
begin
    if AngezeigterTyp='N' then // nur bei Ideen soll der Datensatz geändert werden
    begin
       FeldTitelDBLClick(self);
       { falls der Titel geändert worden ist, werden alle Datensätze durchsucht
         und dort, wo es Querverweise gibt, der Titel geändert }
       if Titel_alt <>labeltitel.text then
       begin
            oldcaption:=Fenster.caption;
            Fenster.Caption:='Der neue Titel wird in der Datenbank aktualisiert';
            su:='note://' + aktuelleNotizid + ' ' + titel_alt;
            su:=StringReplace(su,' ' , '_', [rfReplaceAll]);
            su:=trim(su);
            er:= 'note://' + aktuelleNotizid + ' ' + titel_neu;
            er:=trim(er);
            er:=StringReplace(er,' ' , '_', [rfReplaceAll]);

            for i := 1 to arraysize_daten do
            begin
                 if pos(su, daten[i,Spalte_Anmerkung]) > 0 then
                 begin
                      daten[i,Spalte_Anmerkung]:=
                         stringreplace(daten[i,Spalte_Anmerkung],su,er,[rfreplaceall]) ;
                      NotizVolltext(i);
                      ichanged:=true;
                 end;
            end;
            for i := 1 to arraysize_literatur do
            begin
                 if pos(su, Literatur[i,Spalte_Anmerkung]) > 0 then
                 begin

                      Literatur[i,Spalte_Anmerkung]:=
                         stringreplace(Literatur[i,Spalte_Anmerkung],su,er,[rfreplaceall]) ;
                      LiteraturVolltext(i);
                      lchanged:=true;
                 end;
            end;
            Fenster.Caption:=OldCaption;
       end;
    end;
end;

procedure TFenster.LabelTitelKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
       // nur bei Ideen soll der Datensatz geändert werden
    if (AngezeigterTyp='N') and (key=vk_return) then
       FeldTitelDBLClick(self);
      Titel_neu:=labeltitel.text;
end;

procedure TFenster.ListePrepareCanvas(sender: TObject; aCol, aRow: Integer;
  aState: TGridDrawState);
begin
  { Farbe und Hintergrund des ausgewählten Eintrags in der Trefferliste }
  if not (gdFixed in aState) and  (gdSelected in aState)  then begin
      TStringGrid(Sender).Canvas.Brush.Color:= Liste.SelectedColor;


  end;
end;

procedure TFenster.MenuItem3Click(Sender: TObject);
begin
  IconAllesSpeichernClick(self);
end;

procedure TFenster.MenuNeueNotizClick(Sender: TObject);
begin
  NeueKarteClick(self);
end;

procedure TFenster.ButtonUeberschriftClick(Sender: TObject);
var
   absatz:       tpararange;
   altepos:      integer;
begin
  if fenster.feldinhalt.visible then
  begin
        altepos:=fenster.feldinhalt.SelStart;
        Fenster.FeldInhalt.GetParaRange( altePos,
                                         Absatz.start,Absatz.length );
        if Fenster.Feldinhalt.gettext(absatz.start,1) = '#' then
        begin // # ist schon da und kommt weg
            Fenster.feldinhalt.selstart:=absatz.start;
            Fenster.feldinhalt.sellength:=2;
            Fenster.feldinhalt.CutToClipboard;
            Fenster.feldinhalt.selstart:=altepos-2;;
        end else begin
            Fenster.feldinhalt.selstart:=absatz.start;
             paste('# ');
          Fenster.feldinhalt.selstart:=altepos+2;;
        end;
        formatmd(absatz.start,absatz.length,false);
  end else begin
      showmessage('Diese Funktion gibt es nur für MarkDown');
  end;
end;

procedure TFenster.PanelVergebeneKeywordsClick(Sender: TObject);
begin
  formatmd(0,10000,true);
end;

procedure TFenster.SeiteGliederungShow(Sender: TObject);
begin
  letzterfokus:='FeldInhalt' ; { damit nicht versehentlich die Sucheingabe
                                 den Fokus bekommt
                               }
  AnzeigeModus:='gliederung';
end;

procedure TFenster.StyleSeiteExit(Sender: TObject);
begin
     if stylechanged then
     begin
          if yesbox( 'Sie haben die Zitierrichtlinie verändert.' +
                     'Sollen die Änderungen gespeichert werden?')
          then
              ButtonspeichernClick(self);
     end;
end;

procedure TFenster.Button8Click(Sender: TObject);
var
   i:               integer;
   inhalt:          string;
   j:               integer;
   fn:              string;
   neueID:          string;
   neueZeile:       integer;
begin

    OpenDirectory.InitialDir:=DBDirectory;
    OpenDirectory.Filter:='*.*';
    OpenDirectory.Execute;
    showmsg('Vault öffnen...');
    Dateiliste.mask:='*.*';
    Dateiliste.mask:='*.md';
    Dateiliste.directory:=opendirectory.filename + slash(os) ;
    j:=  (Dateiliste.items.Count) ;
    showmsg('Datensätze einlesen...');
    for i:=0 to j-1 do
    begin
        fn:=dateiliste.directory + Dateiliste.Items[i];
        if fileexists(fn) then
        begin
             memozwischenablage.lines.loadfromfile(fn);
             neueZeile :=getTopEmptyRow('daten');
             NeueID:= IntToStr(GetMaxID('Daten'));
             Daten[NeueZeile, Spalte_ID]:= NeueID ;
             Daten[NeueZeile, Spalte_Bearbeitungsdatum] :=  formatdatetime('yyyymmddhhnn', now);
             Daten[NeueZeile, Spalte_Erstelldatum] :=   formatdatetime('yyyymmddhhnn', now);
             Daten[NeueZeile, Spalte_Titel] :=
                copy(Dateiliste.Items[i],1, length(Dateiliste.Items[i])-3);
             inhalt:= MemoZwischenablage.lines.text ;
             //gibt es einen Verweis?
             inhalt:=StringReplace(inhalt,'![[' , 'file://', [rfReplaceAll]);
             inhalt:=StringReplace(inhalt,']]' , ' ', [rfReplaceAll]);
             Daten[NeueZeile, Spalte_Anmerkung] :=  inhalt;

             NotizenDatensatzZahl:=NotizenDatensatzZahl +1;
             machpause();
        end;
        if Arraysize_daten - Notizendatensatzzahl < 100 then
        begin
             SetLength(Daten, ArraySize_Daten+102,Spalte_Position+1);
             Arraysize_daten:=Arraysize_daten+100;
        end;
    end;
    showmsg('Dateiverweise verarbeiten');
    Dateiliste.mask:='*.*';
    Dateiliste.mask:='*.jpg;*.pdf';               // '*.pas;*.pp;*.inc'.
    Dateiliste.directory:=opendirectory.filename + slash(os) ;
    j:=  (Dateiliste.items.Count) ;
    for i:=0 to j-1 do
         copyfile( Dateiliste.directory + Dateiliste.Items[i],
                   dbdirectory + 'files' + slash(os) +  Dateiliste.Items[i]);




    showmsg('Datenbank sortieren..');
    sortdb('notizen');
    machpause();
    showmsg('Volltext erstellen...');
    VolltextKomplettieren();
    showmsg('Fertig. Bitte neu starten...');
                       machpause();
    ApplicationSessionEnded(self);
                       machpause();
    Application.terminate;
end;

procedure TFenster.ExportObsidianClick(Sender: TObject);
var
   f:        textfile;
   fn:       string;
   i:        integer;
   inhalt:   string;
   inhalt2:  string;
   j:        integer ;
   zeile:    string;
begin
   screen.cursor:=crhourglass;
   fn:= DBDirectory  +'obsidian' ;
   if not(directoryexists(fn))
        then CreateDir(fn);

   //---- Die Notizen exportieren--
   //------------------------------
   for i:=1 to arraysize_daten do    //arraysize
   begin
        if daten[i,spalte_titel]<> '' then
        begin
             machpause();
             fn:= daten[i,spalte_titel] + '.md';
             fn:=StringReplace(fn,'/' , ' ', [rfReplaceAll]);
             fn:=StringReplace(fn,'\' , ' ', [rfReplaceAll]);
             fn:= dbdirectory + 'obsidian' + slash(os) + fn ;
             machpause();
             Assignfile(f,fn);
             machpause();
             rewrite(f);
             machpause();
             inhalt:= daten[i,spalte_anmerkung];
             //Verweise übersetzen
             if pos('file://',inhalt)> 0 then
             begin
                 inhalt2:='';
                 while pos('file://',inhalt)> 0 do
                 begin
                      inhalt2:=inhalt2 + copy(inhalt,1,pos('file://',inhalt)) + '![['; //bis vor file
                      inhalt:=copy(inhalt,pos('file://',inhalt)+8, 10000);
                      inhalt2:=getfirstword(inhalt)+']] ';
                      inhalt:=deletefirstword(inhalt)
                 end;
             end;
             writeln(f,  inhalt);
             closefile(f);
             machpause();
        end;
   end;

   //--------------- JETZT DIE LITERATUR IN BIBTEX
   //---------------------------------------------
   for i:=1 to arraysize_literatur do   //arraysize
   begin
         if literatur[i,1]<> '' then
         begin
             fn:= literatur[i,Spalte_Erstautor]+ ' (' + literatur[i,Spalte_Jahr]+') ' +
                     literatur[i,Spalte_Titel];
             fn:=StringReplace(fn,'/' , ' ', [rfReplaceAll]);
             fn:=StringReplace(fn,'\' , ' ', [rfReplaceAll]);
             fn:=copy(fn,1,40);
             fn:=deletelastword(fn);
             fn:= fn + '.md';

             fn:= dbdirectory + 'obsidian' + slash(os) + fn ;
             Assignfile(f,fn);
             machpause();
             rewrite(f);
             machpause();

             zeile:='@'+literatur[i,Spalte_Publikationstyp]+'{';
             if literatur[i,Spalte_Publikationstyp]='Artikel' then zeile:='@article{';
             if literatur[i,Spalte_Publikationstyp]='Sammelband' then zeile:='@inbook{';
             if literatur[i,Spalte_Publikationstyp]='Kapitel' then zeile:='@incollection{';
             if literatur[i,Spalte_Publikationstyp]='Artikel' then zeile:='@article{';
             if literatur[i,Spalte_Publikationstyp]='Buch' then zeile:='@book{';
             if length(zeile)< 5 then zeile:='@book{';
             zeile:=zeile+literatur[i,Spalte_Erstautor]+literatur[i,Spalte_Jahr]+'-' + literatur[i,1];
             zeile:= stringreplace(zeile, ' ', '', [rfreplaceall]);
             writeln(f,'');
             writeln(f,zeile + ',');
             //Autorfeld
             zeile:=literatur[i,Spalte_Autor];
             zeile:='author    = {'+ FormatiereNamen(zeile, 'George A. Akerlof', ' and ', ' and ', 'false', '', 'true') + '},';
             writeln(f,zeile);
             if Literatur[i,Spalte_Jahr] <> '' then  writeln(f,'year      = {' + Literatur[i,Spalte_Jahr] + '},');
             if Literatur[i,Spalte_Publikationsdatum] <> '' then  writeln(f,'month     = {' + Literatur[i,Spalte_Publikationsdatum] + '},');
             if Literatur[i,Spalte_Titel] <> '' then  writeln(f,'title     = {' + Literatur[i,Spalte_Titel] + '},');   //  Untertitel. gibt es nicht
             if Literatur[i,Spalte_Zeitschrift] <> '' then  writeln(f,'journal   = {' + Literatur[i,Spalte_Zeitschrift] + '},');
             if Literatur[i,Spalte_Band] <> '' then  writeln(f,'volume    = {' + Literatur[i,Spalte_Band] + '},');
             if Literatur[i,Spalte_Nummer] <> '' then  writeln(f,'number    = {' + Literatur[i,Spalte_Nummer] + '},');
             if Literatur[i,Spalte_Seiten] <> '' then  writeln(f,'pages     = {' + Literatur[i,Spalte_Seiten] + '},');
             //Herausgeberfeld
             if Literatur[i,Spalte_Herausgeber] <> '' then
             begin
                  zeile:=literatur[i,Spalte_Herausgeber];
                  zeile:='editor    = {'+ FormatiereNamen(zeile, 'George A. Akerlof', ' and ', ' and ', 'false', '', 'true') + '},';
                  writeln(f,zeile);
             end;
             if Literatur[i,13] <> '' then  writeln(f,'series    = {' + Literatur[i,13] + '},');
             if Literatur[i,Spalte_Verlag] <> '' then  writeln(f,'publisher = {' + Literatur[i,Spalte_Verlag] + '},');
             if Literatur[i,Spalte_Ort] <> '' then  writeln(f,'address   = {' + Literatur[i,Spalte_Ort] + '},');
             if Literatur[i,Spalte_Auflage] <> '' then  writeln(f,'edition   = {' + Literatur[i,Spalte_Auflage] + '},');
             if Literatur[i,Spalte_ISBN] <> '' then  writeln(f,'isbn      = {' + Literatur[i,Spalte_ISBN] + '},');
             writeln(f,'}');
             writeln(f, '');
             inhalt:= Literatur[i,Spalte_Anmerkung];
             //Prüfen auf Dateiverweise
             if pos('file://',inhalt)> 0 then
             begin
                 inhalt2:='';
                 while pos('file://',inhalt)> 0 do
                 begin
                      inhalt2:=inhalt2 + copy(inhalt,1,pos('file://',inhalt)-1) + '![['; //bis vor file
                      inhalt:=copy(inhalt,pos('file://',inhalt)+7, 10000);
                      inhalt2:=inhalt2 + getfirstword(inhalt)+']] ';
                      inhalt:=deletefirstword(inhalt)
                 end;
                 inhalt2:=inhalt2 + inhalt;
                 inhalt:=inhalt2;
             end;
             writeln(f,  inhalt);
             closefile(f);
        end;



   end;
    //---jetzt die Dateien aus /files kopieren
    //----------------------------------------

    Dateiliste.mask:='*.*';
    Dateiliste.directory:=dbdirectory + slash(os) + 'files' + slash(os) ;
    j:=  (Dateiliste.items.Count) ;
    j:=2 ;
    for i:=0 to j-1 do
     copyfile( dbdirectory + slash(os) + 'files' + slash(os) + Dateiliste.Items[i],
               dbdirectory + slash(os) + 'obsidian' + slash(os) + Dateiliste.Items[i]);

   screen.cursor:=crdefault;
end;

procedure TFenster.CaptionSeiteGliedernClick(Sender: TObject);

begin
     with fenster do
     begin
         if PanelNotizGliedern.width < 11 then
         begin
              // Panel zeigen
              PanelIdeenLinks.width:=  trunc(fenster.width/2) ;
              PanelNotizGliedern.width:=trunc(fenster.width/5);
              PanelNotizGliedern.borderstyle:=bssingle;
              PanelNotizGliedern.borderspacing.Around:=5;
              PanelNotizGliedern.borderspacing.right:=20;
         end else begin
              PanelNotizGliedern.width:=10;
              PanelNotizGliedern.borderstyle:=bssingle;
              PanelNotizGliedern.borderspacing.Around:=0;
              PanelNotizGliedern.borderspacing.right:=0;
         end;
     end;
     resizewindow();

end;

procedure TFenster.FeldinhaltMouseEnter(Sender: TObject);
begin
  screen.cursor:=crIBeam;
end;

procedure TFenster.FeldinhaltMouseLeave(Sender: TObject);
begin
  screen.cursor:=crdefault;
end;

procedure TFenster.Button24Click(Sender: TObject);
begin
  getback();
end;

procedure TFenster.Button27Click(Sender: TObject);
begin
  OpenDialog.InitialDir:=DBDirectory;
  OpenDialog.Filter:='Rich Text Format|*.rtf|LyX|*.lyx|LaTeX|*.tex';
  OpenDialog.Execute;
  if OpenDialog.Filename <> '' then
  begin
       LabelOriginaldatei.Caption:= 'Manuskript: ' + extractfilename(OpenDialog.Filename);
       SetIni('Manuskriptdatei',OpenDialog.Filename);
       Setini('letztesmanuskript',OpenDialog.Filename);
  end;
end;

procedure TFenster.ButtonCutCopyClick(Sender: TObject);
var
    StandardAbsatz:         tparametric;
    StandardZeichen:        TFontParams;
begin
     with Standardzeichen do //normaler Text ohne Formatierungen
     begin
         Size:=Fenster.Feldinhalt.Font.Size;
         Color:=clblack;
         BkColor:=clwhite;
         hasBkClr:=true;
         Style:=[];
     end;
     with Standardabsatz do
     begin
         SpaceBefore:=6;
         SpaceAfter:=6;
         Headindent := 0;
         Tailindent := 0;
         FirstLine := 0;
     end;

     Fenster.Feldinhalt.SetParametric(feldinhalt.selstart,feldinhalt.sellength,Standardabsatz);
     Fenster.Feldinhalt.SetRangeparams(feldinhalt.selstart,feldinhalt.sellength,[ tmm_backcolor,
                                                 tmm_Size,
                                                 tmm_Color,
                                                 tmm_styles],
                                                 Standardzeichen,
                                                 [],                //Attribute dazu
                                                 [fsbold,fsunderline,fsitalic]); //Attribute weg


  Clipboard.AsText:= FeldInhalt.SelText ;


end;

procedure TFenster.Button31Click(Sender: TObject);
var
   allesda:boolean;
   i,j,k:integer;


   verwendeteQuellen: array of array of string;
   tausch:array[1..2,1..Spalte_Quellenhinweis] of string;

   Anzahl:integer;
   AutorenZahl:integer;
   Buchstabe:char;
   DateiOriginalName:string;
   DateiKopieName:string;
   Dateiformat:string;
   dummy:string;
   DateiAnhangName:String;
   Feld:string;
   Gefunden:boolean;

   idtest:string;
   IDListe:string;

   Matrixseite:integer;

   original,Kopie,anhang:textfile;
   pp:string;
   QuellenhinweisAutor:string;

   Spalte:integer;
   tmpzitat:string;
   zeichen:char;
   zeile:string;

begin
   AllesDa:=true;

   Dateiformat:='rtf';
   DateioriginalName:= Getini('Manuskriptdatei','');
   dummy:=ansilowercase(DateiOriginalname);
   if      (pos('ä',dummy) > 0)
      or   (pos('ö',dummy) > 0)
      or   (pos('ü',dummy) > 0)
      or   (pos('ß',dummy) > 0)
   then showmsg('Der Dateiname enthält Umlaute. Das kann zu Problemen führen');

   if not fileexists(Dateioriginalname) then
   begin
        showmsg('Die Manuskriptdatei existiert nicht.');
        allesDa:=false;
   end;


   if allesda=true then
   begin
        screen.cursor:=crhourglass;
        Fortschritt.Visible:=true;
        Fortschritt.position:=1;
        if pos('.lyx',Dateioriginalname)>0 then Dateiformat:='lyx' ;
        if pos('.tex',Dateioriginalname)>0 then Dateiformat:='tex' ;
        assignfile(original,DateiOriginalName);
        try
           reset(Original);
        except
              showmsg('Einen Moment bitte. Die Datei ist etwas größer.');
              reset(Original);
        end;
        // Die Originaldatei nach temporären Quellenhinweisen durchsuchen
        machpause();
        idliste:=' ';
        Anzahl:=0;
        while not (eof(Original)) do
        begin
             //Anfang eines temp. Zitats finden
             tmpzitat:='';
             while not (Zeichen = '[') and not (eof(Original)) do read(Original,Zeichen);
             while not (zeichen = ']') and not (eof(Original)) and not (length(tmpzitat) > 200) do
             begin
                  read(Original,Zeichen);
                  TmpZitat := TmpZitat + Zeichen;
             end;
             tmpzitat:= holtmpzitatid(tmpzitat);

             Fortschritt.position:=Fortschritt.position+1;
             if Fortschritt.position > 98 then fortschritt.position:=0;
             if length(tmpzitat) > 0  then
             begin
                  if pos(' '+tmpzitat + ' ',idliste)=0 then
                  begin
                       idliste:=idliste + tmpzitat + ' ';    // eine bisher noch nicht zitierte Quelle
                       Anzahl:=anzahl+1;
                  end;
             end;
        end;
        closefile(Original);
        // in IDListe sind alle verwendeten IDs in der Reihenfolge des Erscheinens.
        Fortschritt.position:=10;



        // jetzt VerwandteQuellen mit den Literaturdaten füllen
        setlength(verwendeteQuellen,Anzahl+10,Spalte_Quellenhinweis+1); //array dimensionieren
        for i:=1 to anzahl do
        begin
             VerwendeteQuellen[i,1]:=getfirstword(idliste);
             idliste:=deletefirstword(idliste);

             AktuelleLiteraturArrayZeile:=HolArrayZeileDerLiteraturId(VerwendeteQuellen[i,Spalte_ID]);

             for j:=2 to Spalte_Ende do VerwendeteQuellen[i,j]:=Literatur[AktuelleLiteraturArrayzeile,j];
        end;
        //LiteraturDaten sind in Verwendete Quellen

        //Jetzt: Quellenhinweise im Text in Spalte_Quellenhinweis
        if Richtlinie[5,1,1]='[1]'  then
           for i:= 1 to Anzahl do
           begin
                verwendeteQuellen[i,Spalte_Quellenhinweis]:='[' + inttostr(i) + ']';   //Numerierung in der Reihenfolge des Erscheinens.
           end;
        if Richtlinie[5,1,1]<> '[1]'  then //eine der alphabetischen Sortierungen. Erst die Quellenhinweise
        begin
             for i:=1 to anzahl do
             begin
                  Zeile:= verwendeteQuellen[i,Spalte_Autor];
                  if zeile <>'' then
                  begin
                       AutorenZahl:=BestimmePersonenZahl(zeile) ;
                       if AutorenZahl=1 then
                       begin
                            if pos(',',zeile) > 0 then QuellenhinweisAutor:=copy(zeile,1,pos(',',zeile)-1) else QuellenhinweisAutor:=zeile;
                            if length(QuellenhinweisAutor) > 20 then QuellenhinweisAutor:=copy(QuellenhinweisAutor,1,12) + '...';
                       end;
                       if Autorenzahl=2 then
                       begin
                            QuellenhinweisAutor:=copy(zeile,1,pos(',',zeile)-1)  + '/' ;
                            zeile:=copy(zeile,pos(';',zeile)+1, 1000);
                            zeile:=trim(zeile);
                            QuellenhinweisAutor:=Quellenhinweisautor + copy(zeile,1,pos(',',zeile)-1);
                       end;
                       if AutorenZahl>2 then
                       begin
                            QuellenhinweisAutor:=copy(zeile,1,pos(',',zeile)-1) + ' et al.';
                       end;

                       QuellenhinweisAutor:=trim(QuellenhinweisAutor);
                       if QuellenHinweisAutor='' then Quellenhinweisautor:='#Achtung: Quelle konnte nicht identifiziert werden#';
                       if Richtlinie[5,1,1]='Akerlof (1970)' then verwendeteQuellen[i,Spalte_Quellenhinweis]:=QuellenHinweisautor + ' (' + verwendeteQuellen[i,Spalte_Jahr] ;
                       if Richtlinie[5,1,1]='(Akerlof 1970)' then verwendeteQuellen[i,Spalte_Quellenhinweis]:= '(' + QuellenHinweisautor + ' ' + verwendeteQuellen[i,Spalte_Jahr];
                       if Richtlinie[5,1,1]='Akerlof 1970' then verwendeteQuellen[i,Spalte_Quellenhinweis]:=  QuellenHinweisautor + ' ' + verwendeteQuellen[i,Spalte_Jahr];
                  end;
             end;
             //die Quellenhinweise liegen in Spalte Quellenhinweis. Jetzt muss noch alphabetisch sortiert werden.
             for i:=1 to anzahl do
             begin
                  for j:=i+1 to Anzahl do
                  begin
                       if VerwendeteQuellen[j,Spalte_Quellenhinweis]<VerwendeteQuellen[i,Spalte_Quellenhinweis] then
                       begin
                            for k:=1 to Spalte_Quellenhinweis do
                            begin
                                 tausch[1,k]:=VerwendeteQuellen[j,k];
                                 tausch[2,k]:=VerwendeteQuellen[i,k];
                                 VerwendeteQuellen[i,k]:=tausch[1,k];
                                 VerwendeteQuellen[j,k]:=tausch[2,k];
                            end;
                       end;
                  end;
             end;
             //VerwendeteQuellen ist für nicht numerische Quellenhinweise jetzt alphabetisch sortiert

             //Jetzt: Verwechselungssicherheit prüfen
             for i:=1 to Anzahl  do
             begin
                  for j:=i +1 to Anzahl do
                  begin
                       buchstabe:='b';
                       If VerwendeteQuellen[i,Spalte_Quellenhinweis] = VerwendeteQuellen[j,Spalte_Quellenhinweis] then
                       begin
                            VerwendeteQuellen[j,Spalte_Quellenhinweis]:= VerwendeteQuellen[j,Spalte_Quellenhinweis] + buchstabe;
                            VerwendeteQuellen[j,Spalte_Erstelldatum]:=Buchstabe;
                            VerwendeteQuellen[j,Spalte_Jahr]:= VerwendeteQuellen[j,Spalte_Jahr] + buchstabe; // Buchtaben auch hinter das Jahresfeld
                            buchstabe:=succ(buchstabe);
                       end;
                  end;
             end;
             //Die Quellenhinweise sind jetzt mit Buchstaben hinter der Jahreszahl versehen. Die Buchstaben sind in Spalte 30
        end; //Die alphabetischen Varianten sind jetzt fertig
        //jetzt: Formatierung der Literaturangaben für den Anhang in Spalte_Vollzitat
        for i:=1 to anzahl do
        begin
             //Autoren und Herausgebernamen
             VerwendeteQuellen[i,Spalte_Erstelldatum]:= FormatiereNamen(VerwendeteQuellen[i,Spalte_Autor], Richtlinie[5,1,2], Richtlinie[5,1,3], Richtlinie[5,1,4], Richtlinie[5,1,5] , Richtlinie[5,1,6], Richtlinie[5,1,8]);
             VerwendeteQuellen[i,Spalte_Vollzitat]:= FormatiereNamen(VerwendeteQuellen[i,Spalte_Herausgeber], Richtlinie[5,1,7], Richtlinie[5,1,3], Richtlinie[5,1,4], Richtlinie[5,1,5] , Richtlinie[5,1,6], Richtlinie[5,1,8]);

             //Publikatonstyp bestimmen
             MatrixSeite:=1; // Buch = 1 = Standard
             if VerwendeteQuellen[i,Spalte_Publikationstyp]='Artikel' then MatrixSeite:=2;
             if VerwendeteQuellen[i,Spalte_Publikationstyp]='Kapitel' then MatrixSeite:=3;
             if VerwendeteQuellen[i,Spalte_Publikationstyp]='Webseite' then MatrixSeite:=4;
             if VerwendeteQuellen[i,Spalte_Publikationstyp]='article' then MatrixSeite:=2;
             if VerwendeteQuellen[i,Spalte_Publikationstyp]='chapter' then MatrixSeite:=3;
             if VerwendeteQuellen[i,Spalte_Publikationstyp]='web page' then MatrixSeite:=4;

             Zeile:='';
             for j:=1 to 10 do // die Formatierungsmatrix im Editor durchgehen
             begin
                  Feld:= Richtlinie[matrixseite,3,j];
                  if feld <> '' then // Das Feld im Editor ist belegt.
                  begin
                       spalte:=40; //sollte leer sein
                       //Die Spalte, in Literatur[i,?] bestimmen
                       if Feld='Autor' then       Spalte:=Spalte_Autor;      //3
                       if Feld='Jahr' then        Spalte:=Spalte_Jahr;
                       if Feld='Datum' then       Spalte:=Spalte_Publikationsdatum;
                       if Feld='Titel' then       Spalte:=Spalte_Titel;
                       if Feld='Untertitel' then  Spalte:=Spalte_Untertitel;
                       if Feld='Zeitschrift' then Spalte:=Spalte_Zeitschrift;
                       if Feld='Band' then        Spalte:=Spalte_Band;
                       if Feld='Nummer' then      Spalte:=Spalte_Nummer;
                       if Feld='Seiten' then      Spalte:=Spalte_Seiten;
                       if Feld='Herausgeber' then Spalte:=Spalte_Herausgeber;   //12
                       if Feld='Sammelband' then  Spalte:=Spalte_Sammelband;
                       if Feld='Verlag' then      Spalte:=Spalte_Verlag;
                       if Feld='Ort' then         Spalte:=Spalte_Ort;
                       if Feld='Auflage' then     Spalte:=Spalte_Auflage;




                       if VerwendeteQuellen[i,spalte] <> '' then //Das Datenfeld ist auch ausgefüllt
                       begin

                            //Formatierungen in RTF
                            if Dateiformat<> '' then
                            begin
                                 Zeile:=Zeile + Richtlinie[MatrixSeite,2,j];  // Text vor dem Feld
                                 zeile:= Zeile + '{';
                                 if Richtlinie[matrixseite,1,j] = 'fett' then Zeile:=zeile + '\b ' ;
                                 if Richtlinie[matrixseite,1,j] = 'kursiv' then Zeile:=zeile + '\i ' ;
                                 if Richtlinie[matrixseite,1,j] = 'unterstrichen' then Zeile:=zeile + '\ul ' ;
                                 if Richtlinie[matrixseite,1,j] = 'bold' then Zeile:=zeile + '\b ' ;
                                 if Richtlinie[matrixseite,1,j] = 'italics' then Zeile:=zeile + '\i ' ;
                                 if Richtlinie[matrixseite,1,j] = 'italic' then Zeile:=zeile + '\i ' ;
                                 if Richtlinie[matrixseite,1,j] = 'underline' then Zeile:=zeile + '\ul ' ;
                                 Zeile:=Zeile + VerwendeteQuellen[i,spalte] +  Richtlinie[MatrixSeite,4,j]  +   '}'; // Text hinter dem Feld

                            end else begin

                                zeile:=zeile + Richtlinie[MatrixSeite,4,j] ;

                            end;

                       end;
                  end;
             end;

             VerwendeteQuellen[i,Spalte_Vollzitat]:= UmlautXMLtoRTF(Zeile);
             if Richtlinie[5,1,1]='[1]' then VerwendeteQuellen[i,Spalte_Vollzitat] := '[' + inttostr(i) + '] ' + VerwendeteQuellen[i,Spalte_Vollzitat]; // bei Numerierung die Zahl an den Anfang setzen
             //Das Formatierte Zitat wird in Spalte Vollzitat abgelegt.
        end; // VerwendeteQuellen ist jetzt komplett fertig
        Fortschritt.position:=20;

        //Jetzt: Die Originaldatei lesen und in der Kopie umformatieren
        DateikopieName:=copy(Dateioriginalname,1,length(DateioriginalName) - 4) + '_compiled.' + DateiFormat;
        assignfile (Kopie,DateiKopieName);
        try
           rewrite(Kopie);
        except
              showmsg('Einen Moment bitte. Die Datei ist etwas größer.');
              rewrite(Kopie);
        end;

        try
           reset(Original);
        except
              showmsg('Einen Moment bitte. Die Datei ist etwas größer.');
              reset(Original);
        end;
        while not (eof(Original)) do
        begin
              //Anfang eines temp. Zitats finden
              tmpzitat:='';
              while not (Zeichen = '[') and not (eof(Original)) do
              begin
                   read(Original,Zeichen);
                   if zeichen <> '[' then write(Kopie,Zeichen); // Das Zeichen in die Compiled-Version schreiben
              end;
              while not (zeichen = ']') and not (eof(Original)) and not (length(tmpzitat) > 200) do
              begin
                   read(Original,Zeichen);
                   TmpZitat := TmpZitat + Zeichen;
              end;

              idtest:=tmpzitat;
              pp:=HolZitatSeite(tmpzitat);
              tmpzitat:= holtmpzitatid(tmpzitat);

              // den formatierten Hinweis aus i,28 holen
              gefunden:=false;
              for i:=1 to Anzahl do
              begin
                   if tmpzitat = VerwendeteQuellen[i,Spalte_ID] then
                   begin
                        write(Kopie, VerwendeteQuellen[i,Spalte_Quellenhinweis]);
                        if (pp<>'') and (pp<>'0') then write(Kopie, ', ' + pp);   //Seitenzahl hinzufügen, falls vorhanden
                        if pos(')',richtlinie[5,1,1])> 0  then    write(Kopie, ')');
                        gefunden:=true;
                        Fortschritt.position:=  Fortschritt.position+1;
                        break;
                   end;
              end;
              if gefunden=false then  write(Kopie,'[' + idtest ); // falls es den Datensatz nicht gibt, den temp. Quellenhinweis übernehmen

        end; // Das Manuskript ist durchgelesen und die Kopie ist umformatiert.
        closefile(Original);
        closefile(Kopie);

        //jetzt / Die appendix Datei erstellen
        DateiAnhangName:=copy(Dateioriginalname,1,length(DateioriginalName) - 4) + '_appendix.rtf';
        assignfile(anhang,DateiAnhangName);
        rewrite(Anhang);
        writeln(Anhang,'{\rtf1\ansi ');
        for i:=1 to Anzahl do writeln(Anhang, '\par ' +  VerwendeteQuellen[i,Spalte_Vollzitat]);
        writeln(Anhang,'\par }}');
        CloseFile(Anhang);
        OpenDocument(DateiKopieName);
        OpenDocument(DateiAnhangName);
    end;
    Fortschritt.visible:=false;
    screen.cursor:=crdefault;






end;

procedure TFenster.Button35Click(Sender: TObject);
begin
  registerkarten.activepage:=Ideenseite;
end;

procedure TFenster.IconPapierkorbLoeschenDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if source=Liste then accept:=true;
end;

procedure TFenster.ButtonDialogAbbruchClick(Sender: TObject);

begin
     registerkarten.activepage:=ideenseite;
     RegisterSuche.Activepage:=SeiteVolltextsuche;
     PanelFeldInhaltIcons.visible:=true;
     timer.enabled:=false;
     timer.enabled:=true;
end;

procedure TFenster.ButtonDrillDownWegClick(Sender: TObject);
begin
  Registerkarten.activepage:=ideenseite;
end;

procedure TFenster.Button47Click(Sender: TObject);
begin
  registerkarten.activepage:=ideenseite;
end;

procedure TFenster.ButtonAusgabeClick(Sender: TObject);
var
   anhang:textfile;
   DateiAnhangName:String;
   i:integer;
   j:integer;

begin
   //Die Dateien herrichten
   DateiAnhangName:=DBDirectory + 'appendix.rtf';
   assignfile(anhang,DateiAnhangName);


    //Jetzt: Autorenfeld umformatieren
    for i:=1 to Literaturdatensatzzahl do // ALLE durchformatieren...
    begin
         for j:=1 to 18 do LiteraturZeile[j]:=Literatur[i,j]; // in eine zweite Variable kopiert, die als globale Variable an eine Funktion übergeben werden kann
         Literatur[i,Spalte_Ende]:= QuelleInRTFFormatieren(true);
     end;
    //Jetzt: Die appendix Datei erstellen
    j:=0;

    try
       rewrite(Anhang);

    except
          busy();
          rewrite(Anhang);
    end;



    writeln(Anhang,'{\rtf1\ansi ');
    for i:=Literaturdatensatzzahl downto 1 do
    begin
        if (PTypBuch.Checked) and (Literatur[i,Spalte_Publikationstyp]='Buch') then
        begin
             writeln(Anhang, '\par ' +  Literatur[i,Spalte_Ende]);
             j:=j+1;
        end;
        if (PTypArtikel.Checked) and (Literatur[i,Spalte_Publikationstyp]='Artikel') then
        begin
           writeln(Anhang, '\par ' +  Literatur[i,Spalte_Ende]);
           j:=j+1;
        end;
        if (PtypKapitel.Checked) and (Literatur[i,Spalte_Publikationstyp]='Kapitel')   then
        begin
           writeln(Anhang, '\par ' +  Literatur[i,Spalte_Ende]);
           j:=j+1;
        end;
        if (PtypWebSeite.checked) and (Literatur[i,Spalte_Publikationstyp]='Webseite') then
        begin
            writeln(Anhang, '\par ' +  Literatur[i,Spalte_Ende]);
            j:=j+1;
        end;
        if j > 50 then break;

    end;
    writeln(Anhang,'\par }}');
    CloseFile(Anhang);
    MachPause();
    OpenDocument(DateiAnhangName);



end;

procedure TFenster.ButtonGliederungLevel1Click(Sender: TObject);

begin
   Gliederung.fullcollapse;
   LabelGliederungLevel1.Font.style:=[fsBold];
   LabelGliederungLevel2.Font.style:= [];
   LabelGliederungLevel3.Font.style:=[];
   LabelGliederungLevelAll.Font.style:=[];
   LabelGliederungLevel1.Font.Size:=12;
   LabelGliederungLevel2.Font.Size:=10;
   LabelGliederungLevel3.Font.Size:=10;
   LabelGliederungLevelAll.Font.Size:=10;

end;

procedure TFenster.ButtonGliederungLevel2Click(Sender: TObject);
var
   i:integer;
begin
   Gliederung.fullexpand;
    for i:=0 to gliederung.items.count -1 do
    begin
         if gliederung.Items[i].Level=1 then gliederung.Items[i].Collapse(true);
    end;
    LabelGliederungLevel1.Font.style:= [];
    LabelGliederungLevel2.Font.style:=[fsBold];
    LabelGliederungLevel3.Font.style:=[];
    LabelGliederungLevelAll.Font.style:=[];
    LabelGliederungLevel1.Font.Size:=10;
    LabelGliederungLevel2.Font.Size:=12;
    LabelGliederungLevel3.Font.Size:=10;
    LabelGliederungLevelAll.Font.Size:=10;
end;

procedure TFenster.ButtonGliederungLevel3Click(Sender: TObject);
var
   i:integer;
begin
   Gliederung.fullexpand;
    for i:=0 to gliederung.items.count -1 do
    begin
         if gliederung.Items[i].Level=2 then gliederung.Items[i].Collapse(true);
    end;
    LabelGliederungLevel1.Font.style:=[];
    LabelGliederungLevel2.Font.style:=[];
    LabelGliederungLevel3.Font.style:=[fsBold];
    LabelGliederungLevelAll.Font.style:=[];
    LabelGliederungLevel1.Font.Size:=10;
    LabelGliederungLevel2.Font.Size:=10;
    LabelGliederungLevel3.Font.Size:=12;
    LabelGliederungLevelAll.Font.Size:=10;
end;

procedure TFenster.ButtonGliederungLevelAllClick(Sender: TObject);
begin
     Gliederung.fullexpand;
     LabelGliederungLevel1.Font.style:=[];
     LabelGliederungLevel2.Font.style:=[];
     LabelGliederungLevel3.Font.style:=[];
     LabelGliederungLevelAll.Font.style:=[fsBold];
     LabelGliederungLevel1.Font.Size:=10;
     LabelGliederungLevel2.Font.Size:=10;
     LabelGliederungLevel3.Font.Size:=10;
     LabelGliederungLevelAll.Font.Size:=12;
end;

procedure TFenster.ButtonspeichernClick(Sender: TObject);
var
  i,j,k:integer;
  datei:textfile;
  dateiname:string;

begin
  //Format der Namen abspeichern

  Richtlinie[5,1,1]:=QuellenHinweistyp.text;
  Richtlinie[5,1,2]:=NamensFormat.text ;
  Richtlinie[5,1,3]:=NamensTrennzeichen.Text  ;
  Richtlinie[5,1,4]:=LetztNamensTrennzeichen.Text ;
  if  LetztenNamenUmdrehen.checked=true then Richtlinie[5,1,5]:='true' else   Richtlinie[5,1,5]:='false';
  Richtlinie[5,1,6]:=etal.Text ;
  Richtlinie[5,1,7]:=Herausgeberformat.text;
  if  AnhangAlleAutoren.checked=true then Richtlinie[5,1,8]:='true' else   Richtlinie[5,1,8]:='false';

  Dateiname:= inputbox('Zitierrichtlinie', 'Name:', GetIni('bxstyle','AER.bystyle'));


  if Dateiname='' then
  begin
       showmsg ('Bitte benennen Sie diese Richtlinie');
       dateiname:='noname';
  end;
  if pos('.bxstyle',dateiname) = 0 then
  begin
     dateiname:=Dateiname + '.bxstyle';


  end ;
  LabelNameRichtlinie.caption:=Dateiname;

  assignfile(datei,DBDirectory+ 'bxstyles' + slash(os) +  dateiname);
  rewrite(datei);
   for i:=1 to 5 do
       for j:=1 to 4 do
           for k:= 1 to 10 do
               writeln(Datei,Richtlinie[i,j,k]);
   closefile(datei);
  SetIni('bxstyle',Dateiname);

  StyleSeiteShow(self);


end;

procedure TFenster.CaptionSpendeVierEuroClick(Sender: TObject);
begin
      OpenURL('https://www.paypal.me/olafwinkelhake/4');
end;

procedure TFenster.CaptionSpendeZehnEuroClick(Sender: TObject);
begin
  OpenURL('https://www.paypal.me/olafwinkelhake/10');
end;

procedure TFenster.FakeCaptionMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     FakeCaptionX:=x ;
     FakeCaptionY:=y;
end;

procedure TFenster.FeldinhaltDblClick(Sender: TObject);
var
   zeile:string;
begin
     zeile:= GetSelWordMemo(Feldinhalt); { Problem: Setzt voraus, dass das Link
                                           aus einem Wort besteht. }


     //Abklären, ob es sich um ein Link handelt....
     if (pos('http://',zeile)=1) or
        (pos('https://',zeile)=1) or
        (pos('file://',zeile)=1) or
        (pos('note://',zeile)=1) or
        (pos('ref://',zeile)=1) or
        (pos('[[',zeile)=1) or
        (pos('[=',zeile)=1)  then
     begin
          machpause();
          FeldInhalt.sellength:=0;
          VerweisAufrufen(zeile );
          machpause();
          formatmd(0,10000,false);

          machpause();
     end;
     machpause();
end;

procedure TFenster.FeldinhaltKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
    ab:                     tpararange;
begin
     // -- Funktionstasten abfragen. Scheint nicht anders zu gehen
     if key in [vk_f1..vk_f9] then
     begin
          MachPause();
          FocusTo('PanelHintergrundOben');
          formkeydown(self,key,shift);
          key:=0;
     end;



     if os='linux' then //Zwischenablage funktioniert sonst nicht
     begin
       if (GetKeyState(VK_LControl) < 0) then
       begin
            if (key=vk_x) and (feldinhalt.sellength > 0) then
            begin
                 ButtonCutCopyClick(self);
                 Feldinhalt.seltext:='';
            end;
            if (key=vk_c) and (feldinhalt.sellength > 0) then
            begin
                 ButtonCutcopyClick(self);
                 FeldInhalt.GetParaRange(feldinhalt.SelStart,ab.start,ab.length);
                 formatmd(ab.start,ab.length,false);
            end;

       end;
     end;
     If (pos('#lock#',Feldinhalt.text) > 0) then
     begin
       Showmsg('Diese Anmerkungen sind schreibgeschützt!');
     end;
     IconUndo.Visible:=true;


     if IsTextChanged=false then UpdateBearbeitungszahl()   ;

end;

procedure TFenster.FeldinhaltMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
    absatz:  integer;
begin
     absatz:=Feldinhalt.CaretPos.y;
     absatz:=absatz+1;

     Feldinhalt.Caretpos:=point(0,absatz);
     if absatz > Feldinhalt.Lines.Count
     then Feldinhalt.Caretpos:=point(80,absatz);
     ScrollbarAnmerkungenPositionieren(absatz);

end;

procedure TFenster.FeldinhaltMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
    absatz:  integer;
begin
     absatz:=Feldinhalt.CaretPos.y;
     absatz:=absatz-1;
     if absatz < 0 then absatz:=0;
     Feldinhalt.Caretpos:=point(0,absatz);
     ScrollbarAnmerkungenPositionieren(absatz);
end;

procedure TFenster.GliederungCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  LFont: TFont;
begin
  LFont := Sender.Canvas.Font;
    if Fenster.ActiveControl= gliederung then
       gliederung.selectioncolor:= clnavy
    else
       gliederung.selectioncolor:= clsilver;

    LFont.Style := LFont.Style - [fsBold];
    lfont.Size:=Gliederung.font.size;
    if node.level=0 then
    begin
       // LFont.Style := LFont.Style + [fsBold];
    end;




end;

procedure TFenster.IconPapierkorbLoeschenClick(Sender: TObject);
var
   i     :integer;
begin
  if nobox('Datensatz "' + LabelTitel.caption + '" (unwideruflich) löschen?') then
  begin
      if AngezeigterTyp='L' then
      begin
           for i:=1 to Spalte_Ende do
               Literatur[AktuelleLiteraturArrayZeile,i]:='';
           lchanged:=true;
      end;
      if AngezeigterTyp='N' then
      begin
           for i:=1 to Spalte_Position do
               Daten[AktuelleNotizenArrayZeile,i]:= '';
               ichanged:=true;
      end;
      AlleAnzeigenClick(self);
  end;
end;

procedure TFenster.Image15Click(Sender: TObject);
var
   zeile:integer;
begin
   zeile:=liste.row;
   if length(sucheingabe.text) > 1 then SuchEingabeClick(self) else AlleAnzeigenClick(self);
   liste.row:=zeile;
end;

procedure TFenster.button180Click(Sender: TObject);
begin
      OpenDialog.Filter:='Bx. Richtlinien|*.bxstyle';
      OpenDialog.InitialDir:=  DBDirectory + 'bxstyles' + slash(os) ;
      OpenDialog.Execute;
      if pos('.bxstyle',OpenDialog.filename) > 0 then
      begin
           Setini('bxstyle',Extractfilename(OpenDialog.Filename)) ;
           StyleSeiteShow(self);
      end;

end;

procedure TFenster.ImageEinstellungenClick(Sender: TObject);
begin
  if    RegisterSuche.Activepage<>Einstellungen
  then  RegisterSuche.Activepage:=Einstellungen
  else  RegisterSuche.Activepage:=SeiteVolltextSuche;
  RegisterEinstellungen.activepage:=SeiteEinstellungenAnzeige;
  resizeWindow();
end;

procedure TFenster.IconGliederungKleinClick(Sender: TObject);
begin
  Registerkarten.Activepage:=IdeenSeite;
  RegisterSuche.activepage:= SeiteGliederung;
end;

procedure TFenster.Image29Click(Sender: TObject);
begin
      application.Minimize;
end;

procedure TFenster.Image30Click(Sender: TObject);
begin
   windowstate := wsFullScreen;
end;

procedure TFenster.Image49Click(Sender: TObject);
begin
  windowstate:=wsnormal
end;

procedure TFenster.IconRefreshClick(Sender: TObject);
var
   cur:   integer;
begin
    if istextchanged then saveChangestoArray();
    If AngezeigterTyp='L' then
      begin
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Bearbeitungsdatum]:=formatdatetime('yyyymmddhhnn', now);
           lchanged:=true;
      end;
      If AngezeigterTyp='N' then
      begin
           Daten[AktuelleNotizenArrayZeile,Spalte_Bearbeitungsdatum]:=formatdatetime('yyyymmddhhnn', now);
           ichanged:=true;
      end;
      cur:=Feldinhalt.selstart;
      FocusTo('Feldinhalt');

      machpause();
      formatmd(0,10000,false);
      machpause();


      Feldinhalt.Selstart:=cur;
      Timer.Enabled:=true;

end;

procedure TFenster.Image62Click(Sender: TObject);
begin
      case QuestionDlg('Änderungen rückgängig machen', 'welche Änderungen?', mtCustom, [mrYes, 'nur dieser Datensatz', mrNo, 'Not-Aus (alle Datensätze)', mrCancel, 'Abbruch'], '') of
    mrYes: begin
      ImageUndoClick(self);
    end;
    mrNo: begin
          if nobox('Die Anwendung wird - ohne abzuspeichern - geschlossen.' + #10#13 +
             'Sie müssen Sie dann "per Hand" neu starten' + #10#13 +
             'und sind dann auf dem Stand der letzten Speicherung.' + #10#13 +
             'Weitermachen?') then
            application.terminate;
    end;
  end;
end;

procedure TFenster.Image37Click(Sender: TObject);
begin
  if optionbibtexexport.checked then schreibBibTeXDB('alle');
  if optionrisexport.checked then SchreibRISDB();
  if optionreferexport.checked then SchreibReferDB('alle');
  if optionWordexport.checked then SchreibWordDB();
  if optionObsidianexport.checked then ExportObsidianClick(self);
  nachricht('Datenbank exportiert',1);
end;

procedure TFenster.ImageEineQuelleExportierenClick(Sender: TObject);
begin
  if OptionWordExport.Checked then
  begin
     SaveSingleRecordInWordXML();
  end else begin
    if OptionRISExport.checked=true then RISExportZwischenablageClick(self) ;
    if OptionBibTeXExport.checked=true then SchreibBibTeXDB('einen');
    if OptionReferExport.checked=true then SchreibReferDB('einen');
    if (OptionWordExport.checked=true) then
       showmsg('Der Export eines Datensatzes in die Zwischenablage wird derzeit in diesem Format nicht unterstützt');
  end;

end;

procedure TFenster.Image61Click(Sender: TObject);
var
   e,d,h,mi,mo,t,y:string;
   out:string;
begin
  if AngezeigterTyp='N' then
  begin
       t:=Daten[AktuelleNotizenArrayZeile, Spalte_Bearbeitungsdatum] ;
       e:=Daten[AktuelleNotizenArrayZeile, Spalte_Erstelldatum] ;
  end else begin
       t:=Literatur[AktuelleLiteraturArrayZeile,Spalte_Bearbeitungsdatum];
       e:=Literatur[AktuelleLiteraturArrayZeile,Spalte_Erstelldatum];
  end;
 // showmsg(t + ' --- ' +e);
  y:=copy(t,1,4);
  mo:=copy(t,5,2);
  d:=copy(t,7,2);
  h:= copy(t,9,2);
  mi:= copy(t,11,2);
  out:= 'zuletzt bearbeitet'+ ': '  + d + '.' + mo + '.' + y + '  ' + h + ':' + mi + #13#10 + 'erstellt' + ': ' + e ;

 // y:=copy(e,1,4);
 // mo:=copy(e,5,2);
 // d:=copy(e,7,2);
 // if t=e then out:=out + 'am oder vor dem ';
 // out := out  + d + '.' + mo + '.' + y ;
  showmsg(out);
end;

procedure TFenster.Label96Click(Sender: TObject);
var
   DateiOriginalName:string;
begin
     DateioriginalName:= Getini('Manuskriptdatei','');
     if not fileexists(Dateioriginalname) then
     begin
        showmsg('Die Manuskriptdatei ' + Dateioriginalname + ' existiert nicht.');
     end else begin
         OpenDocument(DateiOriginalname);
     end;
end;





procedure TFenster.ListeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     //Abfrage des Buttons muss sein, weil der nicht unterschieden wird
     if Button = mbRight then
     begin
         // PopupListe.PopUp;
     end else begin // Linker Button
             Timer.Enabled:=False;
             Liste.BeginDrag(False); //Drag erst nach Mausbewegung

     end;
end;

procedure TFenster.ListeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   col, row:integer;
begin
     //rechter Mausklick wechselt den Datensatz
     if (mbright = Button) then
     begin
       liste.MouseToCell(X, Y, Col, Row);
       liste.Row:=row;
     end;

end;

procedure TFenster.MenuListeAnheftenClick(Sender: TObject);
begin
  OptionAnheftenClick(self);
end;

procedure TFenster.MenuListeFontMinusClick(Sender: TObject);
begin
     ChangeFontSize(Liste.Font.Size - 1);
end;

procedure TFenster.MenuListeFontPlusClick(Sender: TObject);
begin
     ChangeFontSize(Liste.Font.Size + 1);
end;

procedure TFenster.MenuListeMarkierenClick(Sender: TObject);
begin
  OptionMarkierenClick(self);
end;

procedure TFenster.MenuListeVollzitatClick(Sender: TObject);
var
j:integer;
begin
 Clipboard.AsText:= LabelVollzitat.caption;
 for j:=1 to 18 do LiteraturZeile[j]:=Literatur[aktuelleLiteraturArrayZeile,j]; // in eine zweite Variable kopiert, die als globale Variable an eine Funktion übergeben werden kann
 nachricht('Vollzitat in die Zwischenablage kopiert',1);

end;

procedure TFenster.MenuPopupEinfuegenClick(Sender: TObject);
begin
       if pos('#lock#',FeldInhalt.Text)= 0 then
       begin
          paste(clipboard.AsText) ;
          iconRefreshClick(self);

       end else begin
           showmsg('Die Anmerkung ist schreibgeschützt');
       end;


end;

procedure TFenster.MenuPopupKopierenClick(Sender: TObject);
begin
  if os='win' then Clipboard.AsText:= FeldInhalt.SelText
              else Feldinhalt.CopyToClipboard;
end;

procedure TFenster.MenuPunktVerweiseDblClick(Sender: TObject);
var
   zeile:string;
begin
     zeile:=Feldinhalt.Lines[Feldinhalt.CaretPos.Y];
     if pos('://',zeile)=0 then
     begin




          if registerkarten.activepage <>ideenseite then
             Registerkarten.activepage:=ideenseite;
          if (RegisterSuche.Activepage=SeiteGliederung)   then
             Datensatzaufrufen(GV_Titel ) //reicht aus und umgeht das Problem
                                                  //daß unklar ist, ob Gliederung oder Liste
                                                  //angeklickt worden ist
             else
             timer.enabled:=true;  //Neuer Aufbau, damit die Verweise angezeigt werden
      end else begin
          zeile:=Feldinhalt.seltext;
          Feldinhalt.sellength:=0;
          VerweisAufrufen(zeile);
      end;

end;

procedure TFenster.clabel1Click(Sender: TObject);
begin
  showmsg((Sender as tlabel).caption);
end;

procedure TFenster.EditorLeerzeileClick(Sender: TObject);
var
  i,j:integer;
  meineZeile:integer;
begin
     meineZeile:= Tabelle.Row;
     for i:=Tabelle.rowcount -2  downto meinezeile do
     begin
          for j:=1 to 4 do tabelle.Cells[j,i+1]:= tabelle.Cells[j,i]
     end;
     for j:=1 to 4 do tabelle.Cells[j,meinezeile]:='';
   //  tabelle.Cells[3,Tabelle.Row]:='Verlag';
    RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FeldAuflageClick(Sender: TObject);
begin
    tabelle.Cells[3,Tabelle.Row]:='Auflage';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FeldAutorClick(Sender: TObject);
begin
  tabelle.Cells[3,Tabelle.Row]:='Autor';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FeldBandClick(Sender: TObject);
begin
    tabelle.Cells[3,Tabelle.Row]:='Band';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FeldDatumClick(Sender: TObject);
begin
    tabelle.Cells[3,Tabelle.Row]:='Datum';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FeldHerausgeberClick(Sender: TObject);
begin
    tabelle.Cells[3,Tabelle.Row]:='Herausgeber';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FeldInhaltClick(Sender: TObject);

begin
  //Muss so umständlich sein, weil Feldinhalt ein TRichMemo ist und dort
  //draganddrop nicht gut funktioniert, wenn readonly:=false ist. Das ist
  //aber nur ein Problem, wenn man von einem anderen Programm zu Bx. wechselt.
  //01/2022

  aufraeumen();
  if FeldInhalt.Readonly then
  begin
       if GV_textposition <0 then GV_textposition:=0;
       Feldinhalt.SelStart:=GV_textposition;
       FeldInhalt.Sellength:=0;
       FeldInhalt.ReadOnly:=False;

  end else begin
       GV_textposition:=FeldInhalt.Selstart;
       if Trefferarray[liste.row,3]='N' then   //Notiz aufgerufen
          Daten[AktuelleNotizenArrayZeile,Spalte_Position]:=inttostr(GV_textposition);
       if Trefferarray[liste.row,3]='L' then   //Literatur aufgerufen
          Literatur[AktuelleLiteraturArrayZeile,Spalte_Position]:=inttostr(GV_textposition);
  end;
  feldinhalt.Cursor:=crIBeam;
  FocusTo('Feldinhalt');
  ScrollbarAnmerkungenPositionieren(Feldinhalt.CaretPos.y); { wo soll der Schieber
                                                              des Scrollbars
                                                              positioniert werden? }

end;

procedure TFenster.feldinhaltEnter(Sender: TObject);
begin
  feldinhalt.Cursor:=crIBeam;
  schreibrecht();
  LetzterFokus:='FeldInhalt';
end;

procedure TFenster.feldinhaltExit(Sender: TObject);
begin
  //   showmessage('exit');
   if istextchanged then SaveChangesToArray();

end;

procedure TFenster.FeldJahrClick(Sender: TObject);
begin
    tabelle.Cells[3,Tabelle.Row]:='Jahr';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FeldLeerClick(Sender: TObject);
begin
  tabelle.Cells[3,Tabelle.Row]:='';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FeldNummer1Click(Sender: TObject);
begin
    tabelle.Cells[3,Tabelle.Row]:='Nummer';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FeldOrtClick(Sender: TObject);
begin
    tabelle.Cells[3,Tabelle.Row]:='Ort';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FeldSammelbandClick(Sender: TObject);
begin
    tabelle.Cells[3,Tabelle.Row]:='Sammelband';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FeldSeitenClick(Sender: TObject);
begin
    tabelle.Cells[3,Tabelle.Row]:='Seiten';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FeldTitel1Click(Sender: TObject);
begin
    tabelle.Cells[3,Tabelle.Row]:='Titel';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FeldUntertitelClick(Sender: TObject);
begin
    tabelle.Cells[3,Tabelle.Row]:='Untertitel';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FeldVerlagClick(Sender: TObject);
begin
    tabelle.Cells[3,Tabelle.Row]:='Verlag';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FeldZeitschriftClick(Sender: TObject);
begin
    tabelle.Cells[3,Tabelle.Row]:='Zeitschrift';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FormatFettClick(Sender: TObject);
begin
     tabelle.Cells[1,Tabelle.Row]:='fett';
     RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FormatKursivClick(Sender: TObject);
begin
       tabelle.Cells[1,Tabelle.Row]:='kursiv';
     RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FormatUnterstrichenClick(Sender: TObject);
begin
       tabelle.Cells[1,Tabelle.Row]:='unterstrichen';
     RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.IconPictureQuellenhinweisClick(Sender: TObject);
var
   zit:string;
begin
     if AngezeigterTyp='L' then
     begin
         if OptionBibTeX.Checked then zit:= GV_BibTeXKey
         else
          zit:= '[=' +
                     literatur[AktuelleLiteraturArrayZeile,1] + '-' +
                     UmlautZeichenWeg( literatur[AktuelleLiteraturArrayZeile,Spalte_Erstautor]) + ' (' +
                     literatur[AktuelleLiteraturArrayZeile,Spalte_Jahr] + ')=]' ;
          Clipboard.AsText:=zit;
          nachricht(zit + ' in die Zwischenablage kopiert',1);

     end;
end;

procedure TFenster.IconTitelbearbeitenClick(Sender: TObject);
begin

  if AngezeigterTyp='L' then    //Titeldaten einer Quelle ändern
  begin
       aufraeumen();
       SaveChangesToArray();
       KurzZitat:=LabelTitel.Caption;
       LiteraturTiteldatenFormular(AktuelleLiteraturID);
       Titeldatenmatrix.selectedcolor:=clblue;
       ZeigeTiteldaten();

       TitelDatenMatrix.row:=0;
       Titeldatenmatrix.Col:=1;
       FocusTo('Titeldatenmatrix');
       Titel_alt:='';

       //SeiteNeu: Registerkarte links
       RegisterSuche.Activepage:=Titeldaten;
       resizewindow();

  end else begin
      Titel_alt:=LabelTitel.Caption;
  end;
end;

procedure TFenster.Image10MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  screen.cursor:=crSizeNWSE
end;

procedure TFenster.ImageUndoClick(Sender: TObject);
begin
     FeldInhalt.text:=UndoText;
     formatmd(0,10000,false);
end;

procedure TFenster.MenuGroesserClick(Sender: TObject);
begin
  changeFontSize(fsize +1);
  SetIntegerIni('fontsize',fsize);
  Liste.Invalidate;
end;

procedure TFenster.MenuKleinerClick(Sender: TObject);

begin
  changeFontSize(fsize-1);
  SetIntegerIni('fontsize',fsize);
  Liste.Invalidate;

end;

procedure TFenster.OptionAnheftenClick(Sender: TObject);
var
   t1,t2:string;
begin
    //Kontrolle FeldInhalt

    if RegisterSuche.Activepage=SeiteGliederung then
    begin
        t1:=  Feldinhalt.Lines.text;
        if pos('#pin#',t1) = 0 then
        begin
            t2:=t1 + ' #pin#';
        end else
        begin
            t2:=copy(t1,1,pos('#pin',t1)-1) + copy(t1,pos('#pin',t1)+5,100000);
        end;
        Feldinhalt.Lines.text:=t2;
        istextchanged:=true;
        machpause();
        if istextchanged then savechangestoarray();
        If AngezeigterTyp='L' then lchanged:=true;
        If AngezeigterTyp='N' then ichanged:=true;
        Timer.Enabled:=true;

    end;


    if RegisterSuche.Activepage=SeiteVolltextsuche then
    begin
          if istextchanged then savechangestoarray();
          If AngezeigterTyp='L' then
          begin
               t1:=  Literatur[AktuelleLiteraturArrayZeile,Spalte_Anmerkung];
               if pos('#pin#',t1) = 0 then
               begin
                    t2:=t1 + ' #pin#';
               end else  begin
                   t2:= copy(t1,1,pos('#pin',t1)-1) +
                        copy(t1,pos('#pin',t1)+5,100000) ;
               end;

               Literatur[AktuelleLiteraturArrayZeile,Spalte_Anmerkung]:=t2;
               Literatur[AktuelleLiteraturArrayZeile,Spalte_Bearbeitungsdatum]:=
                   formatdatetime('yyyymmddhhnn', now);
               LiteraturVolltext(AktuelleLiteraturArrayZeile);
               lchanged:=true;
          end;
          If AngezeigterTyp='N' then
          begin
               t1:=  Daten[AktuelleNotizenArrayZeile,Spalte_Anmerkung];
               if pos('#pin#',t1) = 0 then
               begin
                    t2:=t1 + ' #pin#';
               end else  begin
                   t2:=copy(t1,1,pos('#pin',t1)-1) + copy(t1,pos('#pin',t1)+5,100000) ;
               end;
               Daten[AktuelleNotizenArrayZeile,Spalte_Anmerkung]:=t2;
               Daten[AktuelleNotizenArrayZeile,Spalte_Bearbeitungsdatum]:=
                   formatdatetime('yyyymmddhhnn', now);
               NotizVolltext(AktuelleNotizenArrayZeile);
               ichanged:=true;
          end;

          //Die Anzeige aktualisieren
          // Kennzeichen der angepinnten Einträge: letztes Bearbeitungsdatum in
          // derZukunft  {02/2024}
          if pos('999',TrefferArray[Liste.row,TrefferArraySpalteBearbeitung])=1 then
          begin
                TrefferArray[Liste.row,TrefferArraySpalteBearbeitung]:='000';
          end else begin
              TrefferArray[Liste.row,TrefferArraySpalteBearbeitung]:='999';
              //Die letzte Bearbeitung ist in der Zukunft
          end;
          machpause();
          Liste.Invalidate;
          liste.repaint;
          timer.enabled:=false;
          timer.enabled:=true;
    end;


end;

procedure TFenster.OptionAnheftenMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

begin
    OptionAnheftenClick(self);

end;

procedure TFenster.OptionMarkierenClick(Sender: TObject);
var
   t1,t2 :string;
begin

    If AngezeigterTyp='L' then
      begin
           t1:=  Literatur[AktuelleLiteraturArrayZeile,Spalte_Anmerkung];
           if pos('#tag#',t1) = 0 then
           begin
                t2:=t1 + ' #tag#';
                Literatur[AktuelleLiteraturArrayZeile,Spalte_Bearbeitungsdatum]:=formatdatetime('yyyymmddhhnn', now);
           end else  begin
               t2:=copy(t1,1,pos('#tag',t1)-1) + copy(t1,pos('#tag',t1)+5,100000) ;
           end;
           Literatur[AktuelleLiteraturArrayZeile,Spalte_Anmerkung]:=t2;
           LiteraturVolltext(AktuelleLiteraturArrayZeile);

           lchanged:=true;

      end;
      If AngezeigterTyp='N' then
      begin
           t1:=  Daten[AktuelleNotizenArrayZeile,Spalte_Anmerkung];
           if pos('#tag#',t1) = 0 then
           begin
                t2:=t1 + ' #tag#';
                Daten[AktuelleNotizenArrayZeile,Spalte_Bearbeitungsdatum]:=formatdatetime('yyyymmddhhnn', now);
           end else  begin
               t2:=copy(t1,1,pos('#tag',t1)-1) + copy(t1,pos('#tag',t1)+5,100000) ;
           end;
           Daten[AktuelleNotizenArrayZeile,Spalte_Anmerkung]:=t2;
           Notizvolltext(AktuelleNotizenArrayZeile);
           ichanged:=true;
      end;

      //für die gerade angezeigte Liste, damit die Anzeige korrekt ist.
      //bei der nächsten Suche wird das Sternchen sowieso gesetzt.
      if Trefferarray[Liste.row,1]='*'
         then Trefferarray[Liste.row,1]:=''
         else Trefferarray[Liste.row,1]:='*';

     if istextchanged then savechangestoarray();
      liste.Invalidate;
      liste.Repaint;
    timer.enabled:=true;

end;

procedure TFenster.OptionMarkiertMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  OptionMarkierenClick(self);
end;

procedure TFenster.OptionPapierkorbClick(Sender: TObject);
begin
  If sucheingabe.text='' then AlleAnzeigenClick(self) else SucheingabeClick(self);
end;

procedure TFenster.OptionSchreibschutzMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   t1,t2:string;
begin
    //Ist im MouseDOWN, weil der Mac kein MouseUP hat

    If AngezeigterTyp='L' then
    begin
         t1:=  Literatur[AktuelleLiteraturArrayZeile,Spalte_Anmerkung];
         if pos('#lock#',t1) = 0 then
         begin
              t2:=t1 + ' #lock#';
         end else  begin
             t2:=copy(t1,1,pos('#lock',t1)-1) + copy(t1,pos('#lock',t1)+6,100000) ;
         end;
         Literatur[AktuelleLiteraturArrayZeile,Spalte_Anmerkung]:=t2;
    end;
    If AngezeigterTyp='N' then
    begin
         t1:=  Daten[AktuelleNotizenArrayZeile,Spalte_Anmerkung];
         if pos('#lock#',t1) = 0 then
         begin
              t2:=t1 + ' #lock#';
         end else  begin
             t2:=copy(t1,1,pos('#lock',t1)-1) + copy(t1,pos('#lock',t1)+6,100000) ;
         end;
         Daten[AktuelleNotizenArrayZeile,Spalte_Anmerkung]:=t2;
    end;


    if istextchanged then savechangestoarray();

    ichanged:=true;
    lchanged:=true;
    Liste.Invalidate;

    Timer.Enabled:=False;
    Timer.Enabled:=true;

end;

procedure TFenster.PanelHinterDenPunktenClick(Sender: TObject);
begin

end;

procedure TFenster.PopupListePopup(Sender: TObject);
begin
     if (PopupListe.PopupComponent=FeldInhalt) then
     begin
           MenuPopUpKopieren.visible:=true ;
           MenuPopUpEinfuegen.visible:=true;
     end else begin
           MenuPopUpKopieren.visible:=false;
           MenuPopUpEinfuegen.visible:=false;
     end;



end;

procedure TFenster.SuchEingabeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if length(Sucheingabe.text) > 1 then SucheingabeClick(self);
   timer.enabled:=true;
end;


procedure TFenster.VollTextIdleTimer(Sender: TObject);
begin


end;

procedure TFenster.AddKeywordsWegClick(Sender: TObject);
begin
  if AnzeigeModus='volltextsuche' then
  begin
       RegisterSuche.ActivePage:=SeiteVolltextsuche;
       IconRefreshClick(self);
       FocusTo('Sucheingabe');
  end else begin
       RegisterSuche.ActivePage:=Seitegliederung;
  end;
  PanelFeldinhaltIcons.visible:=true;
end;

procedure TFenster.IconGliederung2Click(Sender: TObject);
begin
  aufraeumen();
  if registersuche.activepage=seiteGliederung then
  begin
    registersuche.activepage:=SeiteVolltextsuche;
  end else begin
      PanelNotizGliedern.width:= 5;
      registersuche.activepage:=SeiteGliederung;
      if (Gliederung.Selected <> nil)  then   gliederungclick(self);
      Gliederungmd()
  end;
  ResizeWindow();
end;

procedure TFenster.LabelBibtexKeyClick(Sender: TObject);

begin
    Clipboard.AsText:= GV_BibTeXKey;

end;

procedure TFenster.LabelNotizenzahl1Click(Sender: TObject);
begin



end;

procedure TFenster.LabelTeilDerGliederungClick(Sender: TObject);
begin
  IconGliederungClick(self);
end;

procedure TFenster.SetCellPicture(Rect: TRect; Picture: TGraphic; Grid : TStringGrid; hoffset, voffset:integer);

begin
  grid.Canvas.Draw(Rect.Left + HOffset,Rect.Top + Voffset ,Picture);   //draw vs. stretchdraw
  //grid.Canvas.StretchDraw(Rect,Picture);   //draw vs. stretchdraw
end;

procedure TFenster.ZwischenspeichernTimer(Sender: TObject);
begin
     ZwischenSpeichern.Enabled:=false;
     IconAllesSpeichernClick(self);
     ungespeicherteZeichen:=1;
end;



procedure TFenster.ListeDrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
var
   titel:             string;


begin
       { die erste Spalte bei #pin# rot markieren }
       if acol=ListeSpalteNummer then
       begin
           if pos('999',TrefferArray[arow,TrefferarraySpalteBearbeitung])=1  then
           begin
                Liste.Canvas.brush.color:= blau; //clred ;
                liste.Canvas.FillRect(ClientRect);
           end;
       end;
       { die zweite Spalte bei #tag# gelb markieren }
       if acol= ListeSpalteMarkierung then
       begin
            if TrefferArray[arow,1]<>'' then
            begin
                 Liste.Canvas.brush.color:=$0000FFCC ;   //gelb
                 liste.Canvas.FillRect(ClientRect);
            end;
       end;





       if acol=ListeSpalteTitel then
       begin
            //Der Titel des Treffers
            liste.Canvas.FillRect(aRect);  //paint the backgorund
            if liste.width > 6000 then
            begin
                  if arow <9 then
                     Titel:= '0' + inttostr(arow+1)+ '. ' + liste.Cells[Acol, ARow]
                  else
                     Titel:= inttostr(arow+1)+ '. ' + liste.Cells[Acol, ARow];
            end else begin
                titel := liste.Cells[Acol, ARow];
            end;
            liste.Canvas.TextRect(aRect, aRect.Left+5, aRect.Top+2, titel);

     end;




end;

procedure TFenster.MenuNeueQuelleClick(Sender: TObject);
begin
  IconNeueQuelleClick(self);
end;

procedure TFenster.OptionLangesTMPZitatChange(Sender: TObject);
begin
      langestmpzitat:=OptionLangesTmpZitat.checked;
end;

procedure TFenster.RISExportZwischenablageClick(Sender: TObject);
var
   au:string;
   i:integer;
   zeile:string;
begin
  MemoZwischenablage.Lines.clear;
  i:=AktuelleLIteraturArrayZeile ;
  if Literatur[i,Spalte_Publikationstyp] = 'Buch' then MemoZwischenablage.Lines.text:='TY  - BOOK';
  if Literatur[i,Spalte_Publikationstyp] = 'Artikel' then MemoZwischenablage.Lines.text:='TY  - JOUR';
  if Literatur[i,Spalte_Publikationstyp] = 'Kapitel' then MemoZwischenablage.Lines.text:='TY  - CHAP';
  if Literatur[i,Spalte_Publikationstyp] = 'Webseite' then MemoZwischenablage.Lines.text:='TY  - ELEC';
  if Literatur[i,Spalte_Autor] <> '' then
  begin
      zeile:= Literatur[i,Spalte_Autor];
       while pos(';',zeile) > 0 do   //mehrere Autoren
       begin
            au:=copy(zeile,1,pos(';',zeile)-1);
            zeile:=copy(zeile,pos(';',zeile)+1,1000) ;
            zeile:=trim(zeile);
            MemoZwischenablage.Lines.add('AU  - ' +  au) ;
       end;
       MemoZwischenablage.Lines.add('AU  - ' +  zeile) ;
  end;
  if Literatur[i,Spalte_Jahr] <> '' then MemoZwischenablage.Lines.add('PY  - ' +  Literatur[i,Spalte_Jahr]) ;
  if Literatur[i,Spalte_Publikationsdatum] <> '' then MemoZwischenablage.Lines.add('Y1  - ' +  Literatur[i,Spalte_Publikationsdatum]) ;
  if Literatur[i,Spalte_Titel] <> '' then MemoZwischenablage.Lines.add('TI  - ' +  Literatur[i,Spalte_Titel]) ;
  if Literatur[i,Spalte_Zeitschrift] <> '' then MemoZwischenablage.Lines.add('JO  - ' +  Literatur[i,Spalte_Zeitschrift]) ;
  if Literatur[i,Spalte_Band] <> '' then MemoZwischenablage.Lines.add('VL  - ' +  Literatur[i,Spalte_Band]) ;
  if Literatur[i,Spalte_Nummer] <> '' then MemoZwischenablage.Lines.add('IS  - ' +  Literatur[i,Spalte_Nummer]) ;
  if Literatur[i,Spalte_Seiten] <> '' then MemoZwischenablage.Lines.add('SP  - ' +  Literatur[i,Spalte_Seiten]) ;
  if Literatur[i,Spalte_Herausgeber] <> '' then
  begin
      zeile:= Literatur[i,Spalte_Herausgeber];
       while pos(';',zeile) > 0 do   //mehrere Autoren
       begin
            au:=copy(zeile,1,pos(';',zeile)-1);
            zeile:=copy(zeile,pos(';',zeile)+1,1000) ;
            zeile:=trim(zeile);
            MemoZwischenablage.Lines.add('ED  - ' +  au) ;
       end;
       MemoZwischenablage.Lines.add('ED  - ' +  zeile) ;
  end;
  if Literatur[i,Spalte_Sammelband] <> '' then MemoZwischenablage.Lines.add('T2  - ' +  Literatur[i,Spalte_Sammelband]) ;
  if Literatur[i,Spalte_Verlag] <> '' then MemoZwischenablage.Lines.add('PB  - ' +  Literatur[i,Spalte_Verlag]) ;
  if Literatur[i,Spalte_Ort] <> '' then MemoZwischenablage.Lines.add('CY  - ' +  Literatur[i,Spalte_Ort]) ;
  if Literatur[i,Spalte_ISBN] <> '' then MemoZwischenablage.Lines.add('SN  - ' +  Literatur[i,Spalte_ISBN]) ;
  if Literatur[i,Spalte_Anmerkung] <> '' then MemoZwischenablage.Lines.add('N2  - ' +  Literatur[i,Spalte_Anmerkung]) ;
  MemoZwischenablage.Lines.add('ER  - ')  ;
  Clipboard.AsText:= memozwischenablage.lines.text;
  nachricht('RIS - Snippet in die Zwischenablage kopiert',1);
end;

procedure TFenster.MenuHilfeClick(Sender: TObject);
var
   datei:   string;
begin
  datei:= mypath +  'handbuch.pdf';    //03/2024
  if fileexists(datei)
  then opendocument(datei)
  else openurl('http://bibliographix.net/manual.html');

end;

procedure TFenster.OptionLiteraturChange(Sender: TObject);
begin
     //Die Logik an dieser Stelle ist, dass OptionLiteratur noch checked ist, aber gerade abgewählt wird
     if length(sucheingabe.text)< 1 then
        AlleanzeigenClick(self) else SucheingabeClick(self);

end;

procedure TFenster.OptionNotizenChange(Sender: TObject);
begin
     //Die Logik ist, dass Option notizen weggeklickt wird, aber noch angekreuzt ist
     if length(sucheingabe.text)< 1 then
        AlleanzeigenClick(self) else  SucheingabeClick(self);

end ;

procedure TFenster.RichtLinieInternSpeichernClick(Sender: TObject);
var
  i,spalte,zeile:integer;
begin
  if PtypBuch.checked then i:=1;
  if PtypArtikel.checked then i:=2;
  if PtypKapitel.checked then i:=3;
  if PtypWebseite.checked then i:=4;
  for zeile:=1 to 10 do
  begin
      for spalte:=1 to 4 do
      begin
          Richtlinie[i,spalte,zeile] :=Tabelle.cells[spalte,zeile] ;
      end;
  end;
  styleChanged:=true;

end;

procedure TFenster.ButtonFelderleerenClick(Sender: TObject);
var
   zeile,spalte:integer;
begin
    for zeile:=1 to 10 do
    begin
      for spalte:=1 to 4 do
      begin
          Tabelle.cells[spalte,zeile] := '';
      end;
    end;
    LabelNameRichtlinie.caption:='Zitierrichtlinie';
    Setini('bxstyle','') ;
end;

procedure TFenster.DIYButtonLeave(Sender: TObject);
var
  FarbeGrossEltern:TColor;
begin

  if Sender is tlabel then
  begin
    FarbeGrosseltern:=(((sender as Tlabel).parent as TPanel).Parent as tpanel).Color;
    ((sender as tlabel).parent as tpanel).color:=FarbeGrossEltern;
  end;
  if Sender is timage then
  begin
       FarbeGrosseltern:=(((sender as timage).parent as tpanel).Parent as tpanel).Color;
       ((sender as timage).parent as tpanel).color:=FarbeGrossEltern;
  end;
  if Sender is tcheckbox then
  begin
       FarbeGrosseltern:=(((sender as tcheckbox).parent as tpanel).Parent as tpanel).Color;
       ((sender as tcheckbox).parent as tpanel).color:=FarbeGrossEltern;
  end;

end;

procedure TFenster.ausschaltenClick(Sender: TObject);

begin
  screen.cursor:=crhourglass;
  if schreibrecht() then  {Der Nutzer hat das Schreibrecht
                           und speichert die Datenbanken}
  begin
       Registerkarten.Activepage:=IdeenSeite;
       RegisterSuche.Activepage:=SeiteVolltextSuche; //sonst Fehler
       screen.cursor:=crhourglass;
       if ineedssorting or lneedssorting



       then  Fenster.caption:='... sortiere Datenbank ...';

       if ineedssorting then sortdb('notizen');
       if lneedssorting then sortdb('literatur');
       screen.cursor:=crhourglass;

       IconAllesSpeichernClick(self);
       machpause();


       Fenster.caption:='... Programmeinstellungen speichern ...';
       screen.cursor:=crhourglass;

       if optionbibtex.checked     then  setini('optionanhang','bibtex');
       if optionrtf.checked        then  setini('optionanhang','rtf') ;

       SetBooleIni('optiondarkmode',var_OptionDarkMode);

       screen.cursor:=crhourglass;




       SetBooleIni('langestmpzitat=', Fenster.OptionLangesTMPZitat.checked) ;
       //Fontsize
       SetIntegerIni('listfontsize=',Liste.Font.Size);
       SetIntegerIni('fontsize=',Feldinhalt.Font.Size);
       SetBooleIni('optionmenu',Var_OptionMenue); { soll das Menu angezeigt
                                                       werden oder nicht?
                                                       02/2024 }


       //Fensterkoordinaten abspeichern
       setintegerini('prozenthoehe', trunc(100*Fenster.height/screen.height));
       setintegerini('prozentbreite', trunc(100*Fenster.width/screen.width));
       setintegerini('prozentoben', trunc(100*Fenster.top/screen.height));
       setintegerini('prozentlinks', trunc(100*Fenster.left/screen.width));


       //Die Dinge sauber hinterlassen
       SetLock('0'); //Schreibrecht abgeben
       screen.cursor:=crhourglass;
       MachPause();
       SaveBxIni();

       screen.cursor:=crhourglass;
       Registerkarten.ActivePage:=ideenseite;
      // FeldInhalt.Enabled:=false;
       MachPause();
  end;
  screen.cursor:=crdefault;
end;

procedure TFenster.BevelLiteraturAnmerkungMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; x, Y: Integer);
begin
     FocusTo('Feldinhalt');
end;

procedure TFenster.eingabeIdeenKopierenKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Sucheingabe.text:=eingabeIdeenKopieren.text;
  timer.enabled:=true;

end;

procedure TFenster.FormatNormalClick(Sender: TObject);
begin
  tabelle.Cells[1,Tabelle.Row]:='';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.HerausgeberformatChange(Sender: TObject);
begin
  Richtlinie[5,1,7]:=Herausgeberformat.text;
end;



procedure TFenster.ListeIdeenKopierenLinksClick(Sender: TObject);
begin
  DatensatzAufrufen(ListeIdeenKopierenLinks.Cells[1, ListeIdeenKopierenLinks.Row]);
end;

procedure TFenster.ListeIdeenKopierenLinksMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
    timer.Enabled := false;
  timer.Enabled := True;
end;

procedure TFenster.NamensFormatChange(Sender: TObject);
begin
  Richtlinie[5,1,2]:=NamensFormat.text;
end;

procedure TFenster.QuellenHinweisTypChange(Sender: TObject);
begin
  Richtlinie[5,1,1]:=QuellenHinweisTyp.text;
end;

procedure TFenster.FormWindowStateChange(Sender: TObject);
begin

  formresize(self);

end;

procedure TFenster.IconEinstellungenWegClick(Sender: TObject);
begin
  GetBack()
end;

procedure TFenster.IconLiteraturAnmerkungenWeg1Click(Sender: TObject);
begin
    registerkarten.activepage:=Ideenseite;
end;

procedure TFenster.IconNeueQuelleClick(Sender: TObject);
var
i:        integer;
begin
  if schreibrecht() then
  begin

       if istextchanged then SaveChangesToArray();

       //Ist der Array groß genug?
       if Arraysize_Literatur - GetTopEmptyRow('Literatur') < 100 then
       begin
            SetLength(Literatur, ArraySize_Literatur+102,Spalte_Ende+1);
            ArraySize_Literatur:=ArraySize_Literatur+100;
       end;


       LabelFussnote.caption:='';

                { 11/2025: Soll verhindern, dass Datensätze versehendlich
                  überschrieben werden }
       TmpHinweis:='';
       AktuelleLiteraturID:= '';// inttostr(GetMaxId('Literatur') + 1);
       ZeigeTiteldaten();

       // die Anzeige aufräumen
       resizewindow();
       timer.enabled:=false;  //brauche ich, damit die Felder leer bleiben
       Feldinhalt.Lines.Clear;
       LabelVollzitat.Caption:='';
       LabelTitel.caption:='';
       LabelGeaendertam.caption:='';
       LabelErstelltam.caption:='';
       PanelVergebeneKeywords.caption:='';
       BaumVerweise.items.clear;
       BaumVerweise2.items.clear;
       BaumVerweise3.items.clear;

       for i:=0 to 14 do Titeldatenmatrix.cells[1,i]:='';
       Dateneingabe.Text:='';
       TitelDatenMatrix.Row:=0;
       TitelDatenmatrixclick(self);
       Vorschlagsliste.visible:=false;

       lchanged:=true;
  end;


end;

procedure TFenster.IconLiteraturAnmerkungenWegClick(Sender: TObject);
begin
  getback();
end;


procedure TFenster.einschaltenClick(Sender: TObject);

begin
  screen.cursor:=crhourglass;
  Registerkarten.Activepage:=ideenseite;
  MachPause();
  formcreate(self);  //noch mal die ganze Startprozedur durchlaufen

  ListeClick(self); //Die Anzeige aktualisieren. Für die vergangene Zeit wichtig.
  if Sucheingabe.visible then
  FocusTo('Sucheingabe');
  FeldInhalt.Enabled:=true;
  screen.cursor:=crdefault;

end;

procedure TFenster.IconLiteraturDateiVerweisClick(Sender: TObject);
var
   Datei,dir:string;


begin

    //Open-Dialog vorbereiten, falls er gebraucht wird
    //LiteraturLinkDatei.caption:='';
    OpenDialog.InitialDir:='';
    dir:=DBDirectory + 'files';
    if not(directoryexists(dir)) then createdir(dir);
    OpenDialog.InitialDir := dir;
    OpenDialog.Title:='Dateiverweis';
    OpenDialog.Filter:='*.*|*.*';

    if OpenDialog.Execute then
    begin
              Datei:=OpenDialog.filename;
              if pos(dir,datei)=1 then
              begin
                   datei:= 'file://' + copy(datei,length(dir) + 2 , 1000);

                       Feldinhalt.text:=utf8decode(Feldinhalt.text + datei);
                       Literatur[aktuelleLiteraturArrayZeile,Spalte_Anmerkung]:=utf8encode(FeldInhalt.text);

              end else begin
                  if length(datei) > 0 then showmsg('Dateien, auf die Sie verweisen wollen, müssen im Unterverzeichnis \files der Datenbank liegen.');
              end;
    end;

    lchanged:=true;
    LiteraturArrayZeileNachoben(aktuelleLiteraturArrayZeile);

end;

procedure TFenster.IconAllesSpeichernClick(Sender: TObject);
var
   i:                      integer;
   maxbackups:             integer;
   Sicherungsname:         string;
begin
   screen.cursor:=crhourglass;
   maxbackups:=10;
   if istextchanged then savechangestoarray();
   machpause();

   if ichanged then
   begin
        { zuerst die alte .xml sichern, bevor die neue geschrieben wird }
        sicherungsname:= mypath + 'ideen_backup_' + formatdatetime('yyyymmdd', now) + '.xml';
        copyfile(mypath + 'ideen.xml', sicherungsname);
        MachPause();
        IdeenSpeichernClick(self);
        machpause();
        { bei zu vielen alten Sicherungen die ältesten davon löschen }
        Dateiliste.mask:='*.*';
        Dateiliste.mask:='ideen_backup_*.xml';
        DateiListe.Directory:=mypath;
        if dateiliste.items.count > maxbackups then
            for i:= 0 to 2 do
                deletefile(mypath + Dateiliste.Items.strings[i]);
   end;
   machpause() ;
   if lchanged then
   begin
       { zuerst die alte .xml sichern, bevor die neue geschrieben wird }
       sicherungsname:= mypath + 'literatur_backup_' + formatdatetime('yyyymmdd', now) + '.xml';
       copyfile(mypath + 'literatur.xml', sicherungsname);
       MachPause();
       LiteraturDatenbankkomplettabspeichern();
       machpause();
       { bei zu vielen alten Sicherungen die ältesten davon löschen }
       Dateiliste.mask:='*.*';
       Dateiliste.mask:='literatur_backup_*.xml';
       DateiListe.Directory:=mypath;
       if dateiliste.items.count > maxbackups then
           for i:= 0 to 2 do
               deletefilePlus(mypath + Dateiliste.Items.strings[i]);
   end;
   ungespeicherteZeichen:=1; { sonst /div 0  Gefahr }
   if  (Registerkarten.activepage=Ideenseite)
   and (RegisterSuche.activepage=SeiteVolltextSuche)
   then FocusTo('Feldinhalt');
   screen.cursor:=crdefault;
end;

procedure TFenster.IconLiteraturZitierenClick(Sender: TObject);
var

   i:integer;
   S:string;
   z:string;
begin
     i:=Liste.Row;
     z:=GV_TmpZitat;
     if (Trefferarray[i,3]='L') and (Literatur[AktuelleLiteraturArrayZeile,Spalte_Publikationstyp]='Buch') then
     begin
         s:=inputbox('Quelle zitieren', 'Seitennummer:', '');
         if length(s)>0 then
         begin
              z:= copy(z,1,pos('-',z)-1) + '#'+S + copy(z,pos('-',z),100);
         end;
    end;
    Clipboard.AsText:= z;
end;



procedure TFenster.LabelVollzitatClick(Sender: TObject);

begin
    aufraeumen();
    nachricht('Zitat in die Zwischenablage kopiert',1);
    clipboard.asText:=LabelVollzitat.caption;
end;

procedure TFenster.ListeLiteraturVerweisNotizenClick(Sender: TObject);
var
   typ:integer;
   link:string;
begin
  if BaumVerweise.Selected <>nil then
  begin
       typ:=1;
       link:= BaumVerweise.selected.text;
       if pos('http',link)=1 then
       begin
         typ:=2;
       end;
       if pos('file://',link)=1 then
       begin
            typ:=3;
            link:=deletefirstword(link);
            link:=trim(link);
            link:=copy(link,3,200);
            link:= DBDirectory + 'files' + slash(os) +  link
       end;

       if typ=1 then
       begin
            DatensatzAufrufen(link);

       end;
       if typ=2 then OpenURL(link);
       if typ=3 then OpenDocument(link)
  end;

end;

procedure TFenster.OptionAPAClick(Sender: TObject);
var
          i:integer;
begin
  SetIni('formatvollzitat','APA');
  for i:=1 to literaturdatensatzzahl do Literatur[i,23]:='';
end;

procedure TFenster.OptionMLAClick(Sender: TObject);
var
   i:integer;
begin
  SetIni('formatvollzitat','MLA');
  for i:=1 to literaturdatensatzzahl do Literatur[i,23]:='';
end;

procedure TFenster.SeiteArtikelShow(Sender: TObject);
var
  i,spalte,zeile:integer;
begin
  i:=2; //Artikel
  for zeile:=1 to 10 do
  begin
      for spalte:=1 to 4 do
      begin
          Tabelle.cells[spalte,zeile] := Richtlinie[i,spalte,zeile];
      end;
  end;

end;

procedure TFenster.SeiteBuchShow(Sender: TObject);
var
  i,spalte,zeile:integer;
begin
  i:=1; //Buch
  for zeile:=1 to 10 do
  begin
      for spalte:=1 to 4 do
      begin
          Tabelle.cells[spalte,zeile] := Richtlinie[i,spalte,zeile];
      end;
  end;

end;

procedure TFenster.SeiteKapitelShow(Sender: TObject);
var
  i,spalte,zeile:integer;
begin
  i:=3; //Kapitel
  for zeile:=1 to 10 do
  begin
      for spalte:=1 to 4 do
      begin
          Tabelle.cells[spalte,zeile] := Richtlinie[i,spalte,zeile];
      end;
  end;

end;

procedure TFenster.SeiteWebseiteShow(Sender: TObject);
var
  i,spalte,zeile:integer;
begin
  i:=4; //Webseite
  for zeile:=1 to 10 do
  begin
      for spalte:=1 to 4 do
      begin
          Tabelle.cells[spalte,zeile] := Richtlinie[i,spalte,zeile];
      end;
  end;

end;


procedure TFenster.StandBySeiteHide(Sender: TObject);
begin
      formcreate(self);
end;



procedure TFenster.StyleSeiteShow(Sender: TObject);

begin


  machpause();
  PTypBuch.checked:=true;

  LabelNameRichtlinie.caption:='Zitierrichtlinie: ' + Getini('bxstyle','AER.bxstyle') ;
  dummystring:=DBDirectory + 'bxstyles' + slash(os) + Getini('bxstyle','AER.bxstyle') ;
  if fileexists(dummystring) then RichtlinieLaden(dummystring) ;




  //Tabelle herrichten
  Tabelle.Cells[1,0]:='Format';
  Tabelle.Cells[2,0]:='Text';
  Tabelle.Cells[3,0]:='Feld';
  Tabelle.Cells[4,0]:='Text';


  QuellenHinweistyp.text:=Richtlinie[5,1,1];
  NamensFormat.text:=Richtlinie[5,1,2];
  NamensTrennzeichen.Text:=Richtlinie[5,1,3]  ;
  LetztNamensTrennzeichen.Text:=Richtlinie[5,1,4] ;



  if Richtlinie[5,1,5]='true' then LetztenNamenUmdrehen.checked:=true else  LetztenNamenUmdrehen.checked:=false;
  etal.Text:=Richtlinie[5,1,6] ;
  Herausgeberformat.text:= Richtlinie[5,1,7] ;
  if Richtlinie[5,1,8]='true' then AnhangAlleAutoren.checked:=true else  AnhangAlleAutoren.checked:=false;



  SeiteBuchShow(self);

  //Beispieldatensatz formatieren
  LabelVorschau.caption:=AkerlofbeispielZeigen();
  stylechanged:=false;
  machpause();

end;

procedure TFenster.TabelleClick(Sender: TObject);
begin
  if tabelle.col = 3 then menufelder.PopUp;
  if tabelle.col = 1 then menuformat.PopUp;

end;

procedure TFenster.TabelleKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.ZusatzLiteraturSucheClick(Sender: TObject);
begin
  Suchbegriffe(sonderzeichenraus(Sucheingabe.text))  ;
  screen.cursor:=crdefault;
end;

procedure TFenster.ButtonNeuesKapitelClick(Sender: TObject);
var
  tit: string;
begin
  tit := Inputbox('Neues Kapitel', 'Titel:', '');
  if tit <> '' then  Gliederung.Items.Add(nil, tit);
end;

procedure TFenster.GoogleSucheClick(Sender: TObject);
var
  SuchText:string;
begin
    openurl('https://www.google.de/search?q=' + SuchText);

end;

procedure TFenster.IconDruckenClick(Sender: TObject);
var
  i,j,z:                    integer;
  fn:                       string;


  flag2  :                  Integer;

  AnmerkungstextDrucken:    boolean;
  fontsize:                 integer;
  lev:                      integer;
  t:                        string;

begin
     //Erst einmal alles formatieren
     for i:=1 to arraysize_literatur do // ALLE Quellen durchformatieren...
     begin
         for j:=1 to Spalte_Ende do LiteraturZeile[j]:=Literatur[i,j]; // in eine zweite Variable kopiert, die als globale Variable an eine Funktion übergeben werden kann
         Literatur[i,Spalte_Ende]:= QuelleInRTFFormatieren(true);
     end;

     //Was soll gedruckt werden?
    flag2:=1;
    AnmerkungstextDrucken:=OptionAnmerkungenDrucken.checked;

    // nur eine Seite ausdrucken
     If OptionEineSeiteDrucken.checked then
     begin
         ausgabe.lines.clear;
         ausgabe.lines.add('{\rtf1\ansi ');
         if AngezeigterTyp='N' then  //eine Notiz wird als einzige Seite ausgegeben
         begin
               Ausgabe.Lines.Add('\par {\b ' + UmLautXMLtoRTF(GV_Titel ) + '}');
               Ausgabe.Lines.Add('\par ');
               MemoZwischenablage.lines.text:=utf8encode(FeldInhalt.text) ;

               for j:=0 to MemoZwischenablage.lines.count-1 do
                     Ausgabe.Lines.Add('\par ' + UmLautXMLtoRTF(MemoZwischenablage.Lines[j]) );
               Ausgabe.Lines.Add('\par ');
               Ausgabe.Lines.Add('\par ');
               ausgabe.lines.add('\par }}');
         end;
         if AngezeigterTyp='L' then  //die EINE Literaturquelle ausdrucken
         begin
              Ausgabe.Lines.Add('\par ' + Literatur[str2int(Trefferarray[Liste.row,5]),Spalte_Ende]);
              if AnmerkungstextDrucken then
              begin
                   MemoZwischenablage.lines.text:= Literatur[str2int(Trefferarray[Liste.row,5]),Spalte_Anmerkung];
                   if length(MemoZwischenablage.Lines.text) > 1 then Ausgabe.Lines.Add('\par ' + UmLautXMLtoRTF(MemoZwischenablage.Lines.text) );
              end;
              Ausgabe.Lines.Add('\par ');
         end;
     end;
    if optionalleseiten.checked then // alle Seiten ausdrucken
    begin
        z:= liste.rowcount-1  ;
        if z > 100 then  flag2 := QuestionDlg('Achtung', 'Sie sind im Begriff, sehr viele Seiten zu drucken. Wollen Sie das wirklich', mtConfirmation, [mrNo, 'nein', mrYes, 'ja'], 0);
        if flag2<>mrno then
        begin
            ausgabe.lines.clear;
            ausgabe.lines.add('{\rtf1\ansi ');
            for i:=0 to z  do  //alle Zeilen der Liste durchgehen und je nach Typ ausgeben
            begin
                 if (Trefferarray[i,3]='N') and (OptionNotizenDrucken.Checked) then
                 begin
                      DatensatzAufrufen(Trefferarray[i,Spalte_Titel]); //mit dem Titel aufrufen
                      Ausgabe.Lines.Add('\par {\b ' + UmLautXMLtoRTF(GV_Titel ) + '}');
                      MemoZwischenablage.Lines.text:=utf8encode(Feldinhalt.text) ;

                      for j:=0 to MemoZwischenablage.lines.count-1 do
                          Ausgabe.Lines.Add('\par ' + UmLautXMLtoRTF(MemoZwischenablage.Lines[j]) );
                      Ausgabe.Lines.Add('\par ');
                      Ausgabe.Lines.Add('\par ');
                 end;
                 if (Trefferarray[i,3]='L') and (OptionLiteraturDrucken.Checked) then
                 begin
                      Ausgabe.Lines.Add('\par ' + Literatur[str2int(Trefferarray[i,5]),Spalte_Ende]);
                      if AnmerkungstextDrucken then
                      begin
                           MemoZwischenablage.lines.text:= Literatur[str2int(Trefferarray[i,5]),20];
                           if length(MemoZwischenablage.Lines.text) > 1 then Ausgabe.Lines.Add('\par ' + UmLautXMLtoRTF(MemoZwischenablage.Lines.text) );
                     end;
                     Ausgabe.Lines.Add('\par ');
                 end;
            end;
        end;
    end;
    // Die Gliederung drucken
    if OptionGliederungDrucken.Checked then
    begin
         ausgabe.lines.clear;
         ausgabe.lines.add('{\rtf1\ansi ');
         for i:=0 to gliederung.Items.count -1 do
         begin
              t:=gliederung.items[i].text;
              if pos('(#',t)> 0 then   //der Gliederungseintrag ist eine Notiz
              begin
                    lev:=gliederung.items[i].Level;
                    fontsize:=36;
                    if lev>0 then fontsize:=28;
                    if lev>1 then fontsize:=24;
                    t:=copy(t,1,pos('(#',t)-1);
                    t:=trim(t);
                    z:=HolArrayZeileDesTitels(t);
                    MemoZwischenablage.Lines.Text:=Daten[z,Spalte_Anmerkung];
                    Ausgabe.Lines.Add('\par \fs' + inttostr(fontsize) + ' \outlinelevel' + inttostr(lev) + ' {\b ' + UmLautXMLtoRTF(Daten[z,Spalte_Titel]) + '}');
                    Ausgabe.Lines.Add('\par \outlinelevel9');
                    for j:=0 to MemoZwischenablage.lines.count-1 do
                    Ausgabe.Lines.Add('\par \fs24 \outlinelevel9 ' + UmLautXMLtoRTF(MemoZwischenablage.Lines[j]) );
                    Ausgabe.Lines.Add('\par \outlinelevel9');
                    Ausgabe.Lines.Add('\par \outlinelevel9');
              end;
              if pos('[=',t)=1 then   //der Gliederungseintrag ist eine Quelle
              begin
                    lev:=gliederung.items[i].Level;
                    fontsize:=36;
                    if lev>0 then fontsize:=28;
                    if lev>1 then fontsize:=24;
                    AktuelleLiteraturID:=getIDfromTmpCitation(t);
                    LiteraturIdAnzeigen(AktuelleLiteraturID);
                    MemoZwischenablage.Lines.Text:=Literatur[AktuelleLiteraturArrayZeile,Spalte_Anmerkung];
                    Ausgabe.Lines.Add('\par \fs' + inttostr(fontsize) + ' \outlinelevel' + inttostr(lev) + ' {\b ' + QuelleInRTFFormatieren(true)  + '}');
                    Ausgabe.Lines.Add('\par \outlinelevel9');
                    for j:=0 to MemoZwischenablage.lines.count-1 do
                    Ausgabe.Lines.Add('\par \fs24 \outlinelevel9 ' + UmLautXMLtoRTF(MemoZwischenablage.Lines[j]) );
                    Ausgabe.Lines.Add('\par \outlinelevel9');
                    Ausgabe.Lines.Add('\par \outlinelevel9');
              end;
         end;
    end;


   //Ausgabe in die Datei und Anzeige der Datei
   ausgabe.lines.add('\par }}');
   fn:= DBDirectory + 'output.rtf' ;
   ausgabe.Lines.SaveToFile(fn);
   opendocument(fn);
   registerkarten.activepage:=ideenseite;


end;


procedure TFenster.IdeenSucheClick(Sender: TObject);
begin
     SucheingabeClick(self);
end;

procedure TFenster.IconMeinOpacClick(Sender: TObject);
begin

  dummystring:= getini('meinopac','');
  if pos('http',dummystring)=0 then dummystring:=  inputbox('Mein OPAC', 'URL des OPACs', 'http://');
  Setini('meinopac',dummystring);
  OpenURL(dummystring);
end;

procedure TFenster.PanelGliederungKopfClick(Sender: TObject);

begin

end;

procedure TFenster.VerweismatrixDrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
const
  hGap = 20;
  vGap = 0;
begin
  with Sender as TStringGrid do
  begin
    Canvas.FillRect(ARect);
    TextOut(Canvas.Handle, ARect.Left + hGap, ARect.Top + vGap,
      PAnsiChar(Cells[ACol, ARow]), Length(Cells[ACol, ARow]));
  end;
end;

procedure TFenster.FormDropFiles(Sender: TObject; const FileNames: array of string);

begin
     //Ziehen einer Datei auf das Bx - Fenster
     //Grundsätzlich funktioniert das unter Linux, aber nicht auf Richmemo

     if Registerkarten.Activepage<> IdeenSeite then Registerkarten.Activepage:=IdeenSeite;
     CreateFileLink(Filenames[0]);
     FocusTo('Feldinhalt');
     //Der Fokus wechselt auf Bibliographix
     machpause();
     SetForegroundWindow(Application.MainForm.Handle);

end;

procedure TFenster.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
          machzu:     boolean;
begin

  //if Registerkarten.activepage=SeiteStandby then  Fenster.einschaltenclick(self);
  //Globale Tastaturbefehle  und Shortcuts

  //Falls das Fenster den Fokus abgegeben hat und jetzt wiederbekommt, ist
  //Feldinhalt.Readonly false, damit drag and drop auf das Fenster funktioniert.
  //Das wird jetzt abgeschaltet.
  if Feldinhalt.ReadOnly then FeldInhalt.Readonly:=false;





  //==================================================Escape - Taste
  if key=VK_ESCAPE then
  begin
       { Falls noch eines der Unterfenster sichbar ist, das Hauptfenster aber
         trotzdem schon den Fokus hat }
       machzu:=true;

       if registersuche.activepage<> SeiteVolltextsuche then
       begin
           RegisterSuche.activepage:=SeiteVolltextSuche  ;
           machzu:=false;
           timer.enabled:=true;
       end;



       { Die Seite mit den Anmerkungen ist aufgerufen. Volltextsuche oder
         Gliederung }
       if (Registerkarten.activepage=Ideenseite) and machzu then
       begin
            if RegisterSuche.Activepage=SeiteVollTextSuche then
            begin
                  // ist das NEUE QUELLE Formular offen?
                  if PanelNeueQuelle.height > 10
                  then ButtonNeuDialogWegClick(self);


                  LetzterFokus:='SuchEingabe'; //Dahin soll gesprungen werden
                  FocusTo('Sucheingabe');
                  if sucheingabe.visible then
                  begin
                     alleanzeigenclick(self);
                  end;
            end;
            if RegisterSuche.Activepage=SeiteGliederung then
            begin
                 if activecontrol=Gliederung then
                 begin
                      RegisterSuche.Activepage:=SeiteVollTextSuche ;
                      LetzterFokus:='SuchEingabe'; //Dahin soll gesprungen werden
                      if sucheingabe.visible then
                      begin
                           FocusTo('Sucheingabe');
                           alleanzeigenclick(self);
                      end;
                 end;
            end;
       end;

       key := 0;
  end;
  //================================================ LEERTASTE ====
  if key=VK_SPACE then
  begin
      if ActiveControl=Liste then OptionMarkierenClick(self);
  end;

  //===================================================STRG - Taste
  if Shift=[ssCtrl, ssshift] then
  begin
       if Registerkarten.activepage=Ideenseite then  //Tastaturkürzel auf der Notizenseite
       begin

            if key=VK_G then IconGliederungClick(self);
            if key=VK_N then NeueKarteClick(self);
            if key=VK_Q then VerweisErstellenClick(self);
            if key=VK_S then IconSchlagwortClick(self);

       end;
  end;

  //Pfeiltasten bei der Titeldateneingabe


    if key=vk_f1 then  MenuHilfeClick(self);

    if key=vk_f2 then
    begin
         NeueKarteClick(self);
    end;
    if key=vk_f3 then
    begin
         if schreibrecht() then
         begin
            RegisterSuche.activepage:=SeiteVolltextsuche;
            IconNeueQuelleClick(self);
            key:=0;  // sonst wird das Formular noch mal aufgerufen.

         end;
    end;
    if key=vk_f4 then
       if Registersuche.activepage=SeiteVolltextsuche then
         IconGliederungKleinClick(self) else IconVolltextsucheKleinClick(self);
    if key=vk_f5 then
    begin
         if Registersuche.activepage=Titeldaten  then
         begin
             ButtonTiteldatenSpeichernClick(self);
             machpause() ;
         end;
         IconAllesSpeichernClick(self);
    end;
    if key=vk_f6 then IconSchlagwortClick(self);
    if key=vk_f7 then OptionMarkierenClick(self);
    if key=vk_f8 then IconPapierkorbLoeschenClick(self);
    if key=vk_f9 then
    begin
         machpause();
         VerweisErstellenClick(self);

    end;



  if Shift=[ssCtrl] then
  begin
     if key=VK_S then  IconAllesSpeichernClick(self);
     //Standardseite ist geöffnet
     if Registerkarten.Activepage=Ideenseite then
     begin
          if (key=VK_W)     then IconSchlagwortClick(self);

          if (key=VK_F)     then
          begin
               Registerkarten.activepage:=Ideenseite;
               RegisterSuche.Activepage:=SeiteVollTextSuche;
               FocusTo('Sucheingabe');
          end;
     end;
  end;


end;  //Ende Formkeydown

procedure TFenster.GliederungDragDrop(Sender, Source: TObject; x, Y: integer);
var
  Src, Dst: TTreeNode;
begin
    if (Source = Liste) then //Aus der Trefferliste auf die Gliederung gezogen
    begin
        Dst := Gliederung.GetNodeAt(x, Y);
        if dst <> nil then
        begin
             Gliederung.Selected:=Dst;
             LabelAufnehmenClick(self); //Das Icon anklicken
        end
    end else begin
        //Innerhalb der Gliederung gezogen
        if gliederung.selected <> nil then
        begin
             Src := Gliederung.Selected;
             Dst := Gliederung.GetNodeAt(x, Y);
             if (src <> dst) and (dst <> nil) then  //7/19 ausprobiert, um gelegentliche Abstürze zu vermeiden
             begin
                Src.MoveTo(Dst, nainsert);
                try
                   GliederungSpeichern(DBDirectory+Gliederungsdatei);
                except
                      busy() ;
                      GliederungSpeichern(DBDirectory+Gliederungsdatei);
                end;
                machpause();
                GliederungArrayEinlesen();
             end
        end;
    end

end;

procedure TFenster.GliederungDragOver(Sender, Source: TObject;
  x, Y: integer; State: TDragState; var Accept: boolean);
begin
  //Ein Objekt wird von einem anderen Objekt auf die Gliederung gezogen
  if source=Liste then accept:=true;

end;

procedure TFenster.IconGliederungClick(Sender: TObject);
var
   i,j:     integer;
begin

     if fileexists(DBDirectory + Gliederungsdatei) then
     begin
              Gliederung.LoadFromFile(DBDirectory + Gliederungsdatei);
              if Gliederung.Items.Count > 20
                 then ButtonGliederunglevel1click(self)
                 else Gliederung.fullexpand;

     end;
     //Speicherbedarf('i');

      //Die .tree Dateien einlesen
      Dateiliste.mask:='*.tee';
      Dateiliste.mask:='*.tree';
      Dateiliste.directory:=DBDirectory;


      MemoGliederungen.lines.clear;

      j:=  (Dateiliste.items.Count-1) ;

      for i:=0 to j do
      begin
           dummystring:=Dateiliste.Items.strings[i];
           dummystring:=copy(dummystring,1,(length(dummystring)-5)); //.tree weg
           //in die Liste
           if length(dummystring) > 1 then MemoGliederungen.lines.text:=
              MemoGliederungen.lines.text + '   ' +dummystring;
      end;
      dummystring:=copy(gliederungsdatei,1,length(gliederungsdatei)-5);
   //   MemoGliederungen.lines.text:=MemoGliederungen.lines.text + #10 + '|neue Gliederung anlegen|';
      MemoGliederungen.lines.text:=trim(MemoGliederungen.lines.text);
      LabelComboboxGliederung.caption:=dummystring;
      Gliederungmd();




end;

procedure TFenster.IconSchlagwortClick(Sender: TObject);

var
   anfang:      integer;
   c:           integer; //column der Schlagwortmatrix
   i:           integer;
   meintext:    string;
   mindesthoehe:integer;
   r:           integer; //row der Schlagwortmatrix
   StandardAbsatz:  tParametric;
   StandardZeichen: TFontParams;
   w:               string;
begin
        if istextchanged then saveChangestoArray();

        Mindesthoehe:=700; // Bei kleineren Fenstern muss die Darstellung
                           // kompakter sein
        //-- Das Memo füllen --
        //---------------------
        MemoSchlagwoerter.Lines.Clear;
        MemoSchlagwoerter.Color:=LabelTitelschlagwort.color;
        meintext:=ansilowercase(Feldinhalt.Lines.text + ' ' +  labeltitel.text );
        with Standardzeichen do //normaler Text ohne Formatierungen
        begin
             if fenster.height > Mindesthoehe then Size:=12 else size:=11;
             Color:=Fenster.FeldInhalt.font.color;
          //   BkColor:=Fenster.Panel3.color;
             hasBkClr:=false;
             Style:=[];
        end;

        with Standardabsatz do // für die Formatierung
        begin
             SpaceBefore:=0;
             { bei geringer Fensterhöhe muss die Darstellung kompakter sein }
             if fenster.height > Mindesthoehe then SpaceAfter:=4
                                              else spaceafter:=1;
             Headindent := 0;
             Tailindent := 0;
             FirstLine := 0;
         end;



        for i:=0 to swliste.count -1 do
        begin
            w:= getfirstword(swliste[i]);
            if i>1 then
            begin
                 if ansilowercase(copy(w,1,1)) <>
                    ansilowercase(copy(swliste[i-1],1,1))
                 then MemoSchlagwoerter.lines.text:=
                      MemoSchlagwoerter.lines.Text + #13
            end;
            MemoSchlagwoerter.lines.text:=MemoSchlagwoerter.lines.Text + w + '  ';
        end;



        with fenster.MemoSchlagwoerter do
        begin
              SetRangeparams(0,1000,[ tmm_backcolor,
                                  tmm_Size,
                                  tmm_Color,
                                  tmm_styles],
                                  Standardzeichen,
                                  [],                //Attribute dazu
                                  [fsbold,fsunderline]); //Attribute weg
              for i:=0 to swliste.count -1 do
              begin
                   w:= getfirstword(swliste[i]);
                   if pos(ansilowercase(w),meintext) > 0 then
                   begin
                       anfang:= Search(w,0,1000,[]);
                       SetRangeParams(anfang, length(w), [tmm_styles,tmm_color], '',0,  blau, [fsbold], []);
                   end
              end;
              SetParametric(1,10000,Standardabsatz);
          end;


         RegisterSuche.Activepage:=SeiteSchlagwort;
         FocusTo('Suchanfrage');

end;

procedure TFenster.ButtonQuellenhinweisClick(Sender: TObject);
var
   clp:string;
begin
     IconLiteraturZitierenClick(self);
     ichanged:=true;
     lchanged:=true;
     clp:=Clipboard.AsText;
     neueKarteClick(self);
     timertimer(self);
     if  AngezeigterTyp='N'       then  //falls nicht, ist abgebrochen worden.
     begin
          feldinhalt.text:= utf8decode(clp);

     end;

end;

procedure TFenster.DateiverweisClick(Sender: TObject);
var
  dir: string;
  datei: string;

begin
  //Den Dateidialog vorbereiten
  if ListeDateiendungen='' then ListeDateiendungen:= '*.*|*.*';
  dir := DBDirectory + 'files' + slash(os);
  OpenDialog.filename:='';
  OpenDialog.filterindex:=0;
  if not (directoryexists(dir)) then  createdir(dir);
  dir:=getini('letztesverzeichnis',dir);


  OpenDialog.initialdir := dir;
  OpenDialog.Title:='Dateiverweis';
  OpenDialog.Filter:=ListeDateiEndungen;

  OpenDialog.Execute;

  Datei := OpenDialog.filename;
  CreateFileLink(Datei);
  dir:= Opendialog.initialdir;
  setini('letztesverzeichnis',dir);

end;


procedure TFenster.FeldInhaltKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
var
   ab:                     tpararange;
   DetailsAktualisieren:   boolean;
   FeldText:               string;

begin

        DetailsAktualisieren:=false;  { sollen die Details in der angezeigten
                                        Liste  aktualisiert werden? 03/2024}

        UngespeicherteZeichen:=UngespeicherteZeichen +1;
        if (Registersuche.activepage=Seiteschlagwort)
        or (Registersuche.activepage=SeiteQuerverweis)
        then RegisterSuche.Activepage:=SeiteVolltextsuche;
        IsTextChanged:=true;
        if Angezeigtertyp='L' then lchanged:=true else ichanged:=true;

        // neuer Absatz -> den alten formatieren
        if (key=vk_return) and (feldinhalt.visible) then
        begin
             //den letzten Absatz formatieren
             FeldInhalt.GetParaRange(feldinhalt.SelStart-2,ab.start,ab.length);
             formatmd(ab.start,ab.length,false);
             //den neuen Absatz als Standardabsatz formatieren
             FeldInhalt.GetParaRange(feldinhalt.SelStart,ab.start,ab.length);
             formatmd(ab.start,ab.length,false);
             DetailsAktualisieren:=true;
             if istextchanged then saveChangestoArray();

        end;

        if     (key=vk_multiply)
            or (key=VK_oem_plus)

        then
        begin
           if feldinhalt.visible then
           begin
                FeldInhalt.GetParaRange(feldinhalt.SelStart,ab.start,ab.length);
                formatmd(ab.start,ab.length,false);
           end;
           DetailsAktualisieren:=true;
        end;


        If (Feldinhalt.SelStart > 80) and (feldinhalt.visible) then Detailsaktualisieren:=false;
        if DetailsAktualisieren then
        begin
             If      (Trefferarray[Liste.row,3] = 'L')
                and  (Trefferarray[Liste.row,4] <> AktuelleLiteraturID)
                then Detailsaktualisieren:=false;
             If      (Trefferarray[Liste.row,3] = 'N')
                and  (Trefferarray[Liste.row,4] <> AktuelleNotizID)
                then Detailsaktualisieren:=false;
        end;
        if (DetailsAktualisieren)then
        begin
              FeldText:= Copy(Feldinhalt.text,1,80);
              if pos(Feldtext,Trefferarray[Liste.row,7])<>1 then
              begin
                   Trefferarray[Liste.row,7]:=FeldText; //Der Text im Feld
                   Trefferarray[Liste.row,7]:=StringReplace(Trefferarray[liste.row,7],#13, ' ',[rfreplaceall]);
                   Liste.Refresh;
              end;
        end;
        if feldinhalt.visible then
           GV_textposition:=FeldInhalt.Selstart; //globale Variable

        if (key = vk_escape) and istextchanged then
        begin
             saveChangestoArray();
             FocusTo('Sucheingabe');

        end;


           { Formatierung wiederherstellen, die als Workaround für Linux
             abgestellt worden ist, damit die Zwischenablage funktioniert.  }
        if (os='linux') and (feldinhalt.visible) then
        begin
            if (key=VK_Control) and (GetKeyState(VK_v) < 0) then
            begin
                 FeldInhalt.GetParaRange(feldinhalt.SelStart-2,ab.start,ab.length);
                 formatmd(ab.start,ab.length,false);
            end;
            if (key=VK_Control) and (GetKeyState(VK_c) < 0) then
            begin
                 FeldInhalt.GetParaRange(feldinhalt.SelStart-2,ab.start,ab.length);
                 formatmd(ab.start,ab.length,false);
            end;
        end;
end;

procedure TFenster.FeldTitelDblClick(Sender: TObject);
var
  AlterTitel, neuerTitel: string;
  i:integer;
begin

  AlterTitel := GV_Titel ;
  //neuerTitel := inputbox('Titel der Notiz ändern', 'Titel der Notiz', alterTitel);
  neuertitel:=LabelTitel.text;
  if (length(neuerTitel) > 0) and (altertitel <> neuertitel) then
  begin
        Daten[AktuelleNotizenarrayzeile,Spalte_Titel]:=neuerTitel    ;
        Daten[AktuelleNotizenarrayzeile,Spalte_Volltext]:=
          Daten[AktuelleNotizenarrayzeile,Spalte_Volltext] +
          SonderzeichenRaus(ansilowercase(neuerTitel)); //02/2022 Gab Fehler, wenn Umlaut im Titel
        Daten[AktuelleNotizenarrayzeile, Spalte_Bearbeitungsdatum]:= formatdatetime('yyyymmddhhnn', now);
         savechangestoarray();
        ichanged:=true;
        GV_Titel  := neuerTitel;
        LabelTitel.Caption := neuerTitel;
        If RegisterSuche.Activepage=SeiteVolltextsuche then AlleAnzeigenClick(self);
        //jetzt noch den Eintrag finden...
        If RegisterSuche.Activepage=SeiteVolltextsuche then
        begin

            For i:=0 to Fenster.Liste.Rowcount do
            begin
                 if (Trefferarray[i,TrefferArraySpalteTitel]=NeuerTitel) and (AngezeigterTyp='N') then
                 begin
                      Fenster.Liste.Row:=i;
                      timer.enabled:=true;
                      break;
                 end;
            end;
        end;
  end;

end;

procedure TFenster.FeldURL2Click(Sender: TObject);
var
  URL: string;
begin
  URL := Feldurl2.Caption;
  URL := trim(URL);
  if pos('http', URL) = 1 then
    openurl(URL);

end;

procedure TFenster.FeldURLClick(Sender: TObject);

begin
  tabelle.Cells[3,Tabelle.Row]:='URL';
  RichtlinieInternSpeichernClick(self);
end;

procedure TFenster.FormClose(Sender: TObject; var CloseAction: TCloseAction);

begin
     timer.enabled:=false;
     if istextchanged then savechangestoarray();
     FHTTPClient.Free;;
     machpause();
     RegisterKarten.ActivePage:=IdeenSeite;
     ausschaltenclick(self);
     machpause();

     setlock('0');
     machpause();  //12.18: Sicherstellen, daß der Schreibzugriff freigegeben wird, wenn der Computer
                   //heruntergefahren wird und Bx. noch läuft


end;

end.
