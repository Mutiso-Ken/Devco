#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516200 "Payroll Calender"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Payroll Calender";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date Opened"; "Date Opened")
                {
                    ApplicationArea = Basic;
                    NotBlank=true;
                }
                field("Period Name"; "Period Name")
                {
                    ApplicationArea = Basic;
                }
                field("Period Month"; "Period Month")
                {
                    ApplicationArea = Basic;
                }
                field("Period Year"; "Period Year")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = Basic;
                }
                field("Date Closed"; "Date Closed")
                {
                    ApplicationArea = Basic;
                }
                field("Tax Paid"; "Tax Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Tax Paid(LCY)"; "Tax Paid(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Basic Pay Paid"; "Basic Pay Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Basic Pay Paid(LCY)"; "Basic Pay Paid(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Code"; "Payroll Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Close Period")
            {
                ApplicationArea = Basic;
                image = ClosePeriod;
                Caption = 'Close Period';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    fnGetOpenPeriod;

                    Question := 'Once a period has been closed it can NOT be opened.\It is assumed that you have PAID out salaries.\'
                    + 'Do still want to close [' + strPeriodName + ']';
                    Answer := Dialog.Confirm(Question, false);
                    if Answer = true then begin
                        Clear(objOcx);
                        objOcx.fnClosePayrollPeriod(dtOpenPeriod, PayrollCode);
                        Message('Process Complete');
                    end else begin
                        Message('You have selected NOT to Close the period');
                    end;
                end;
            }
        }
    }

    var
        PayPeriod: Record "Payroll Calender";
        strPeriodName: Text[30];
        Question: Text[250];
        Answer: Boolean;
        objOcx: Codeunit "Sacco Payroll Management";
        dtOpenPeriod: Date;
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Control-Information";
        Text000: label '''Leave without saving changes?''';
        Text001: label '''You selected %1.''';


    procedure fnGetOpenPeriod()
    begin

        //Get the open/current period
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then begin
            strPeriodName := PayPeriod."Period Name";
            dtOpenPeriod := PayPeriod."Date Opened";
        end;
    end;
}

