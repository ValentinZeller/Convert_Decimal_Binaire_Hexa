unit conver;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SpinEx, Forms, Controls, Graphics, Dialogs,
  StdCtrls, math;

type

  { TFconvert }

  TFconvert = class(TForm)
    BtnConv: TButton;
    BtnRAZ: TButton;
    BtnQuit: TButton;
    LbDec: TLabel;
    LbBin: TLabel;
    LbHex: TLabel;
    EditDec: TSpinEditEx;
    ValHex: TLabel;
    ValBin: TLabel;
    procedure BtnConvClick(Sender: TObject);
    procedure BtnQuitClick(Sender: TObject);
    procedure BtnRAZClick(Sender: TObject);
  private

  public

  end;

var
  Fconvert: TFconvert;

function dectobin(decimal : integer):string;

implementation

{$R *.lfm}

{ TFconvert }

function dectobin(decimal : integer):string;
//BUT : Convertir un décimal en binaire
//ENTREE : decimal : nombre décimal
//SORTIE : Le nombre binaire
var i: integer;
  bin: string;
begin
    bin := '';
    i:=7;
    for i:=0 to 7 do
     begin
       bin:= inttostr(decimal MOD 2)+bin;
       decimal := decimal div 2;
     end;
    dectobin := bin;
end;

function hex(bin:string):string;
//BUT: Convertir 4bit en hexadécimal
//ENTREE : Nombre binaire sur 4bit
//SORTIE : Hexadécimal
var i,nb:integer;
  temp:string;
begin
    nb:= 0;
    for i:=1 to 4 do
     begin
        nb:=nb+ round(intpower(2,4-i))*strtoint(bin[i]);
     end;
    case nb of
    10: temp:='A';
    11: temp:='B';
    12: temp:='C';
    13: temp:='D';
    14: temp:='E';
    15: temp:='F';
    else temp:=inttostr(nb);
    end;
    hex:=temp;
end;

function bintohex(bin:string):string;
//BUT: Convertir un décimal en hexadécimal
//ENTREE : decimal : nombre décimal
//SORTIE : Le nombre hexadécimal
var temp,bin1,bin2:string;
begin
    temp:='';
    bin1:=copy(bin,1,4);
    bin2:=copy(bin,5,4);
    temp:= temp+hex(bin1);
    temp:= temp+hex(bin2);
    bintohex:= temp;

end;

procedure TFconvert.BtnConvClick(Sender: TObject);
var dec: integer;
begin
    dec := EditDec.Value;
    ValBin.Caption := dectobin(dec);
    ValHex.Caption := bintohex(ValBin.Caption);
end;

procedure TFconvert.BtnQuitClick(Sender: TObject);
begin
      case QuestionDlg ('Caption','Voulez-vous quitter ?',mtCustom,[mrYes,'Oui', mrNo, 'Non', 'IsDefault'],'') of
        mrYes: Close;
    end;
end;

procedure TFconvert.BtnRAZClick(Sender: TObject);
begin
  EditDec.Value := 0;
  ValBin.Caption := '00000000';
  ValHex.Caption := '00';
end;

end.

