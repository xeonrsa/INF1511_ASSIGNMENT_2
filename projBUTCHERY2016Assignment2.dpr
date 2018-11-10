program projBUTCHERY2016Assignment2;

uses
  Vcl.Forms,
  unitBUTCHERY2016Assignment2 in 'unitBUTCHERY2016Assignment2.pas' {frmBUTCHERY2016Assignment2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmBUTCHERY2016Assignment2, frmBUTCHERY2016Assignment2);
  Application.Run;
end.
