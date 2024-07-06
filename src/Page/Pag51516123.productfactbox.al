
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 51516123 "productfactbox"
{
    Caption = 'FOSA Statistics FactBox';
    Editable = false;
    PageType = CardPart;
    SaveValues = true;
    SourceTable = Vendor;

    layout
    {
        area(content)
        {
            group("Member Picture")
            {
                field(Image; Rec.Image)
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                }
            }

            group("Account Statistics FactBox")
            {
                Caption = 'Account Statistics FactBox';
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Book Balance';
                }
                field("""Account Balance""-(""Uncleared Cheques""+""ATM Transactions""+""EFT Transactions""+MinBalance+1100)"; Rec."Account Balance" - (Rec."Uncleared Cheques" + Rec."ATM Transactions" + Rec."EFT Transactions" + MinBalance + 1100))
                {
                    ApplicationArea = Basic;
                    Caption = 'Withdrawable Balance';
                }
                field("Uncleared Cheques"; Rec."Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Overdraft"; Rec."Outstanding Overdraft")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Oustanding Overdraft interest"; Rec."Oustanding Overdraft interest")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Overdraft amount"; Rec."Overdraft amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                    visible = false;
                }
                field(AvaialableOD; AvaialableOD)
                {
                    ApplicationArea = Basic;
                    Caption = 'Available Overdraft';
                    Style = Favorable;
                    StyleExpr = true;
                    Visible = false;
                }
                field("Outstanding Okoa Biz"; Rec."Outstanding Loans")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Loans"; Rec."Outstanding Loans")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Arrears"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }

            }

            group("Member Signature")
            {
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ChangeCustomer;
        GetLatestPayment;
        CalculateAging;
        Rec.CalcFields(Balance);
        AdjustmentAmount := 0;
        if ((Rec.Balance < 1090) and (Rec.Balance > 0)) then begin
            AdjustmentAmount := 1090 - Rec.Balance;
            //AvaialableOD:=AvaialableOD-AdjustmentAmount;
        end;
        if Rec.Balance < 0 then begin
            AdjustmentAmount := 1090 + Abs(Rec.Balance);
            //AvaialableOD:=AvaialableOD-AdjustmentAmount;
        end;
    end;

    trigger OnOpenPage()
    begin
        // Default the Aging Period to 30D
        Evaluate(AgingPeriod, '<30D>');
        // Initialize Record Variables
        LatestCustLedgerEntry.Reset;
        LatestCustLedgerEntry.SetCurrentkey("Document Type", "Customer No.", "Posting Date");
        LatestCustLedgerEntry.SetRange("Document Type", LatestCustLedgerEntry."document type"::Payment);
        for I := 1 to ArrayLen(CustLedgerEntry) do begin
            CustLedgerEntry[I].Reset;
            CustLedgerEntry[I].SetCurrentkey("Customer No.", Open, Positive, "Due Date");
            CustLedgerEntry[I].SetRange(Open, true);
        end;
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
        MinBalance: Decimal;
        AvaialableOD: Decimal;
        AdjustmentAmount: Decimal;


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
        LatestCustLedgerEntry.SetRange("Customer No.", Rec."No.");
        for I := 1 to ArrayLen(CustLedgerEntry) do
            CustLedgerEntry[I].SetRange("Customer No.", Rec."No.");
    end;


    procedure DrillDown(Index: Integer)
    begin
        if Index = 0 then
            Page.RunModal(Page::"Customer Ledger Entries", LatestCustLedgerEntry)
        else
            Page.RunModal(Page::"Customer Ledger Entries", CustLedgerEntry[Index]);
    end;
}


