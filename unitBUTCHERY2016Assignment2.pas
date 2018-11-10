unit unitBUTCHERY2016Assignment2;

interface

uses Vcl.Controls, Vcl.StdCtrls, Vcl.Menus, Vcl.Samples.Spin,
  System.Classes, Vcl.ExtCtrls,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Graphics,
  Vcl.Forms, Vcl.Dialogs, Printers, dxGDIPlusClasses;

type
  TfrmBUTCHERY2016Assignment2 = class(TForm)
    listMeat: TListBox;
    lblStep1: TLabel;
    lblStep2: TLabel;
    spinCuts: TSpinEdit;
    lblStep3: TLabel;
    spinPerBox: TSpinEdit;
    btnCalc: TButton;
    btnStartReport: TButton;
    btnEndReport: TButton;
    memReport: TMemo;
    groupMeatSelected: TGroupBox;
    lblMeatSelected: TLabel;
    lblMaintainance: TLabel;
    edtMaintainance: TEdit;
    btnMeatAdd: TButton;
    btnMeatDelete: TButton;
    btnMeatReplace: TButton;
    imgButchery: TImage;
    procedure btnStartReportClick(Sender: TObject);
    procedure listMeatClick(Sender: TObject);
    procedure btnCalcClick(Sender: TObject);
    procedure btnEndReportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBUTCHERY2016Assignment2: TfrmBUTCHERY2016Assignment2;

implementation

{$R *.dfm}

procedure TfrmBUTCHERY2016Assignment2.btnCalcClick(Sender: TObject);
Var
  strMeat     : String;
  intNoCuts   : Integer;
  intPerBox   : Integer;
  intNoBoxes  : Integer;
begin
  // Assign Meat selected to Var
  strMeat := frmBUTCHERY2016Assignment2.listMeat.Items[listMeat.ItemIndex];
  // Assign Number of Cuts to Var
  intNoCuts := frmBUTCHERY2016Assignment2.spinCuts.Value; // Not going to check if < 1, SpinEdit min Value set to 1
  // Assign Number of Cuts Per Box to Var
  intPerBox := frmBUTCHERY2016Assignment2.spinPerBox.Value; // Not going to check if < 1, SpinEdit min Value set to 1
  // Check If No of Cuts is  smaller than cuts per box
  If (intNoCuts < intPerBox) Then Begin
    // Warn User
    MessageDlg('Number of Cuts cannot be smaller than cuts per box. Only full boxes are sent to customers!',mtWarning,[mbOK],0);
  // Else Add transaction to Report
  End Else Begin
    // Calculate Number of Boxes
    intNoBoxes := Trunc(intNoCuts/intPerBox); //Trunc Becuase only full boxes are sent to customers
    // Add new Line to Report  // IntToStr Required to convert Type Integer into Type String
    memReport.Lines.Add(IntToStr(intNoBoxes) + ' boxes of ' + strMeat + ' (' + IntToStr(intNoCuts) + ' cuts per box)');
  End;
end;

procedure TfrmBUTCHERY2016Assignment2.btnEndReportClick(Sender: TObject);
Var
  dateReportDate  : TDate;
  timeReportTime  : TTime;
  wstrSavePath : WideString; //Widestring becuase string has a char limit that could be problems for long file path
begin
  // Force User to Click New Report
  // Disable Meat Listbox
  listMeat.Enabled := False;
  // Disable Cuts SpinEdit
  spinCuts.Enabled := False;
  // Disable Per Box SpinEdit
  spinPerBox.Enabled := False;
  // Disable End Report Button
  btnEndReport.Enabled := False;
  // Add Report Footer
  memReport.Lines.Add('**** END OF REPORT ****');
  // Assign Date To Var
  dateReportDate := Now;
  // Assign Time To Var // This can be done using TDateTime var but for easy reading & Understanding purpose I split it
  timeReportTime := Now;
  // Add Date to Report Footer
  memReport.Lines.Add('DATE: ' + DateToStr(dateReportDate));
  // Add Time to Report Footer
  memReport.Lines.Add('TIME: ' + TimeToStr(timeReportTime));
  // Assign location to save Reports
  wstrSavePath := 'C:\ButcheryReports\';
  // Check if folder Exist, if not create
  If Not DirectoryExists(wstrSavePath) then CreateDir(wstrSavePath);
  // Add Report Name to SavePath
  // Date                                                             // Replace all '/' with '_'
  wstrSavePath := wstrSavePath + 'ButcheryReport_' + StringReplace(DateToStr(Now),'/','_',[rfReplaceAll]);  // Fowardslah in filename will cause errors
  // Time
  wstrSavePath := wstrSavePath + '_' + StringReplace(TimeToStr(Now),':','_',[rfReplaceAll]);
  // Add File Extention
  wstrSavePath := wstrSavePath + '.txt';
  // Save Report
  memReport.Lines.SaveToFile(wstrSavePath);
end;

procedure TfrmBUTCHERY2016Assignment2.btnStartReportClick(Sender: TObject);
begin
  // Force User to Click New Report
  // Clear Report
  memReport.Clear;
  // Enable Meat Listbox
  listMeat.Enabled := True;
  // Enable Cuts SpinEdit
  spinCuts.Enabled := True;
  // Enbable Per Box SpinEdit
  spinPerBox.Enabled := True;
  // Enable End Report Button
  btnEndReport.Enabled := True;
  // Add Report Header
  memReport.Lines.Add('**** START OF REPORT ****');
end;

procedure TfrmBUTCHERY2016Assignment2.listMeatClick(Sender: TObject);
begin
  // Check if Item actually selected
  If (frmBUTCHERY2016Assignment2.listMeat.ItemIndex > -1) Then Begin
    // If Item Selected - Display for user selected item
    frmBUTCHERY2016Assignment2.lblMeatSelected.Caption := frmBUTCHERY2016Assignment2.listMeat.Items[listMeat.ItemIndex];
    // Enable button to allow user to continue
    frmBUTCHERY2016Assignment2.btnCalc.Enabled := True;
  End;
end;

End.
