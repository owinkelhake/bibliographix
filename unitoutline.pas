unit unitoutline;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  RichMemo;

type

  { TOutline }

  TOutline = class(TForm)
    Anzeige: TRichMemo;
    TreeView1: TTreeView;
  private

  public

  end;

var
  Outline: TOutline;

implementation

{$R *.lfm}

end.

