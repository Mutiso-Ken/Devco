#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516371 "Member Statistics FactBox"
{
    Caption = 'Member FactBox';
    Editable = false;
    PageType = CardPart;
    SaveValues = true;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            field(Image; Image)
            {
                ApplicationArea = Basic;
                Caption = 'Member No.';
            }
            group("Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                Editable = false;

                field("Current Shares"; "Current Shares")
                {
                    Caption = 'Non-withdrawable Deposits';
                    Style = StrongAccent;
                }

                field("Outstanding Balance"; "Outstanding Balance")
                {
                    Style = StrongAccent;
                }
                field("Outstanding Interest"; "Outstanding Interest")
                {
                    Style = StrongAccent;
                }

                field("Principal Arrears"; "Principal Arrears")
                {
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Interest Arrears"; "Interest Arrears")
                {
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Registration Fee Paid"; "Registration Fee Paid")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Ambiguous;
                }
                field("Shares Retained"; rec."Shares Retained")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Ambiguous;

                }
                field("Housing Contribution"; "Housing Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Alpha Savings"; "Alpha Savings")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field("Likizo Contribution"; "Likizo Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Holiday Savings';

                }
                field("Property Savings"; "Property Savings")
                {
                    ApplicationArea = Basic;
                    Editable = false;


                }
                field("Junior Savings One"; "Junior Savings One")
                {
                    ApplicationArea = Basic;
                    Editable = false;


                }
                field("Junior Savings Two"; "Junior Savings Two")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field("Junior Savings Three"; "Junior Savings Three")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                // field("School Fees Shares"; "School Fees Shares")
                // {
                //     Caption = 'CO- OP Shares';
                //     Style = Ambiguous;
                // }
                // field("Preferencial Building Shares"; "Preferencial Building Shares")
                // {
                //     Editable = false;
                //     Style = Ambiguous;
                // }
                // field("FOSA  Account Bal"; "FOSA  Account Bal")
                // {
                //     Style = Ambiguous;
                // }
                // field("Executive Deposits"; "Executive Deposits")
                // {
                //     Style = Ambiguous;
                // }
                // field("Changamka Shares"; "Changamka Shares")
                // {
                //     Style = Ambiguous;
                // }
                // field("Kussco Shares"; "Kussco Shares")
                // {
                //     Style = Ambiguous;
                // }
                // field("Tamba Shares"; "Tamba Shares")
                // {
                //     Style = Ambiguous;
                // }
                // field("CIC Shares"; "CIC Shares")
                // {
                //     Style = Ambiguous;
                // }
                field("Housing Deposits"; "Housing Deposits")
                {
                    Style = Ambiguous;
                }

                field("Dividend Amount"; "Dividend Amount")
                {
                    style = Strong;
                }

                field("Un-allocated Funds"; "Un-allocated Funds")
                {
                    style = Strong;
                }

                field("Benevolent Fund"; "Benevolent Fund")
                {
                    visible = false;
                }


            }
            group("File Movement FactBox")
            {
                Caption = 'File Movement FactBox';
                visible = false;
                field("Currect File Location"; "Currect File Location")
                {
                }
                field("Loc Description"; "Loc Description")
                {
                }
                field(User; User)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        "Loan Arrears" := FnGetLoanArrears(Rec."No.");
    end;

    trigger OnOpenPage()
    begin

    end;

    var
        LatestCustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry: array[4] of Record "Cust. Ledger Entry";
        AgingTitle: array[4] of Text[30];
        AgingPeriod: DateFormula;
        I: Integer;
        PeriodStart: Date;
        PeriodEnd: Date;
        Text002: label 'Not Yet Due';
        Text003: label 'Over %1 Days';
        Text004: label '%1-%2 Days';


    procedure CalculateAgingForPeriod(PeriodBeginDate: Date; PeriodEndDate: Date; Index: Integer)
    var
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        NumDaysToBegin: Integer;
        NumDaysToEnd: Integer;
    begin
        // Calculate the Aged Balance for a particular Date Range
        if PeriodEndDate = 0D then
            CustLedgerEntry[Index].SetFilter("Due Date", '%1..', PeriodBeginDate)
        else
            CustLedgerEntry[Index].SetRange("Due Date", PeriodBeginDate, PeriodEndDate);

        CustLedgerEntry2.Copy(CustLedgerEntry[Index]);
        CustLedgerEntry[Index]."Remaining Amt. (LCY)" := 0;
        if CustLedgerEntry2.Find('-') then
            repeat
                CustLedgerEntry2.CalcFields("Remaining Amt. (LCY)");
                CustLedgerEntry[Index]."Remaining Amt. (LCY)" :=
                  CustLedgerEntry[Index]."Remaining Amt. (LCY)" + CustLedgerEntry2."Remaining Amt. (LCY)";
            until CustLedgerEntry2.Next = 0;

        if PeriodBeginDate <> 0D then
            NumDaysToBegin := WorkDate - PeriodBeginDate;
        if PeriodEndDate <> 0D then
            NumDaysToEnd := WorkDate - PeriodEndDate;
        if PeriodEndDate = 0D then
            AgingTitle[Index] := Text002
        else
            if PeriodBeginDate = 0D then
                AgingTitle[Index] := StrSubstNo(Text003, NumDaysToEnd - 1)
            else
                AgingTitle[Index] := StrSubstNo(Text004, NumDaysToEnd, NumDaysToBegin);
    end;


    procedure CalculateAging()
    begin
        // Calculate the Entire Aging (four Periods)
        for I := 1 to ArrayLen(CustLedgerEntry) do begin
            case I of
                1:
                    begin
                        PeriodEnd := 0D;
                        PeriodStart := WorkDate;
                    end;
                ArrayLen(CustLedgerEntry):
                    begin
                        PeriodEnd := PeriodStart - 1;
                        PeriodStart := 0D;
                    end;
                else begin
                    PeriodEnd := PeriodStart - 1;
                    PeriodStart := CalcDate('-' + Format(AgingPeriod), PeriodStart);
                end;
            end;
            CalculateAgingForPeriod(PeriodStart, PeriodEnd, I);
        end;
    end;


    procedure GetLatestPayment()
    begin
        // Find the Latest Payment
        if LatestCustLedgerEntry.FindLast then
            LatestCustLedgerEntry.CalcFields("Amount (LCY)")
        else
            LatestCustLedgerEntry.Init;
    end;


    procedure ChangeCustomer()
    begin
        // Change the Customer Filters
        LatestCustLedgerEntry.SetRange("Customer No.", "No.");
        for I := 1 to ArrayLen(CustLedgerEntry) do
            CustLedgerEntry[I].SetRange("Customer No.", "No.");
    end;


    procedure DrillDown(Index: Integer)
    begin
        if Index = 0 then
            Page.RunModal(Page::"Customer Ledger Entries", LatestCustLedgerEntry)
        else
            Page.RunModal(Page::"Customer Ledger Entries", CustLedgerEntry[Index]);
    end;

    local procedure FnGetLoanArrears(No: Code[20]): Decimal
    var
        LoansReg: Record "Loans Register";
        Amount: Decimal;
    begin
        Amount := 0;
        LoansReg.reset;
        LoansReg.SetRange(LoansReg."Client Code", no);
        LoansReg.SetAutoCalcFields(LoansReg."Outstanding Balance");
        LoansReg.SetFilter(LoansReg."Outstanding Balance", '>%1', 0);
        LoansReg.SetRange(LoansReg.Posted, true);
        if LoansReg.Find('-') then begin
            repeat
                Amount += LoansReg."Amount in Arrears";
            until LoansReg.Next = 0;
            exit(Amount);
        end;
    end;
}

