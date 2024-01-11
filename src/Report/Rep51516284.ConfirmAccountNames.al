#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516284 "Confirm Account Names"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ConfirmAccountNames.rdlc';

    dataset
    {
        dataitem("Salary Processing Buffer"; "Salary Processing Lines")
        {
            DataItemTableView = sorting("No.") where(Processed = const(false));
            RequestFilterFields = "Account No.";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(NO; "Salary Processing Buffer"."No.")
            {
            }
            column(Account_No; "Salary Processing Buffer"."Account No.")
            {
            }
            column(Staff_No; "Salary Processing Buffer"."Staff No.")
            {
            }
            column(Account_Name; "Salary Processing Buffer"."Account Name")
            {
            }
            column(Amount; "Salary Processing Buffer".Amount)
            {
            }
            column(Account_Not_Found; "Salary Processing Buffer"."Account Not Found")
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ProcessingUser := '';
                ProcessingUser := UserId;

                if "Salary Processing Buffer".USER = ProcessingUser then begin




                    if "Salary Processing Buffer"."Staff No." = '' then begin
                        Account.Reset;
                        Account.SetCurrentkey(Account."No.");
                        Account.SetRange(Account."No.", "Salary Processing Buffer"."Account No.");
                        if Account.Find('-') then begin
                            "Salary Processing Buffer"."Account No." := Account."No.";
                            "Salary Processing Buffer"."Account Name" := Account.Name;
                            "Salary Processing Buffer"."Client Code" := Account."BOSA Account No";
                            if (Account.Blocked = Account.Blocked::All) or (Account.Status = Account.Status::Closed) then
                                "Salary Processing Buffer"."Blocked Accounts" := true
                            else
                                "Salary Processing Buffer"."Blocked Accounts" := false;
                            "Salary Processing Buffer"."Account Not Found" := false;
                        end else begin
                            "Salary Processing Buffer"."Account Not Found" := true;
                        end;
                        "Salary Processing Buffer".Modify;

                    end else begin
                        Account.Reset;
                        Account.SetCurrentkey(Account."Staff No");
                        Account.SetRange(Account."Staff No", "Salary Processing Buffer"."Staff No.");
                        Account.SetRange(Account."Account Type", 'ORDINARY');
                        if Account.Find('-') then begin
                            "Salary Processing Buffer"."Account No." := Account."No.";
                            "Salary Processing Buffer"."Account Name" := Account.Name;
                            "Salary Processing Buffer"."Client Code" := Account."BOSA Account No";

                            if (Account.Blocked = Account.Blocked::All) or (Account.Status = Account.Status::Closed) then
                                "Salary Processing Buffer"."Blocked Accounts" := true
                            else
                                "Salary Processing Buffer"."Blocked Accounts" := false;
                            "Salary Processing Buffer"."Account Not Found" := false;
                        end else begin
                            "Salary Processing Buffer"."Account Not Found" := true;
                        end;
                        "Salary Processing Buffer".Modify;

                    end;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        STORegister: Record "Standing Orders";
        AmountDed: Decimal;
        DedStatus: Option Successfull,"Partial Deduction",Failed;
        Charges: Record charges;
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        SalFee: Decimal;
        SalGLAccount: Code[20];
        Loans: Record "Loans Register";
        LRepayment: Decimal;
        RunBal: Decimal;
        Interest: Decimal;
        SittingAll: Boolean;
        CompInfo: Record "Company Information";
        ProcessingUser: Code[50];
}

