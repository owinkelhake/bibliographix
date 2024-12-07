unit unitsplash;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TFormSplash }

  TFormSplash = class(TForm)
    ButtonShowMsg: TButton;
    Image1: TImage;
    MemoSprechblase: TLabel;
    Panel1: TPanel;
    procedure ButtonShowMsgClick(Sender: TObject);
  private

  public

  end;

var
  FormSplash: TFormSplash;

implementation
uses unit1;
{$R *.lfm}

{ TFormSplash }

procedure TFormSplash.ButtonShowMsgClick(Sender: TObject);
begin
  close;
end;

end.

