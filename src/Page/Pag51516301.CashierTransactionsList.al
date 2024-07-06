#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516301 "Cashier Transactions - List"
{
    ApplicationArea = Basic;
    CardPageID = "Cashier Transactions Card";
    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Transactions;
    SourceTableView = where(Posted = filter(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;

                }
                field("Transaction Description"; Rec."Transaction Description")
                {

                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                }
                field("Expected Maturity Date"; Rec."Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                }

                field("Amount Discounted"; Rec."Amount Discounted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {

                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //SETRANGE("Transaction Date",TODAY);
        Rec.SetRange(Cashier, UserId);
        Rec.Ascending(false)

    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        //GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Account Types-Saving Products";
        LineNo: Integer;
        ChequeType: Record "Cheque Types";
        DimensionV: Record "Dimension Value";
        ChargeAmount: Decimal;
        DiscountingAmount: Decimal;
        Loans: Record "Loans Register";
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        Vend: Record Vendor;
        LoanType: Record "Loan Products Setup";
        BOSABank: Code[20];
        ReceiptAllocations: Record "Receipt Allocation";
        StatusPermissions: Record "Status Change Permision";


    procedure PostBOSAEntries()
    var
        ReceiptAllocation: Record "Receipt Allocation";
    begin
        //BOSA Cash Book Entry
        if Rec."Account No" = '502-00-000300-00' then
            BOSABank := '13865'
        else
            if Rec."Account No" = '502-00-000303-00' then
                BOSABank := '070006';


        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := BOSABank;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := Rec.Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        ReceiptAllocations.Reset;
        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", Rec.No);
        if ReceiptAllocations.Find('-') then begin
            repeat

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."External Document No." := Rec."Cheque No";
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Repayment then begin
                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    if Rec."Account No" = '502-00-000303-00' then
                        GenJournalLine."Account No." := '080023'
                    else
                        GenJournalLine."Account No." := '045003';
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := Rec.Payee;
                end else begin
                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                    GenJournalLine."Account No." := ReceiptAllocations."Member No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type");
                end;
                GenJournalLine.Amount := ReceiptAllocations.Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Interest Due" then
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Benevolent Fund"
                else
                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Loan then
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution"
                    else
                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Benevolent Fund" then
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Unallocated Funds"
                        else
                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment
                            else
                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Withdrawal then
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee";
                GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee") and
                   (ReceiptAllocations."Interest Amount" > 0) then begin
                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := Rec.No;
                    GenJournalLine."External Document No." := Rec."Cheque No";
                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                    GenJournalLine."Account No." := ReceiptAllocations."Member No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Interest Paid';
                    GenJournalLine.Amount := ReceiptAllocations."Interest Amount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                    GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                end;

            until ReceiptAllocations.Next = 0;
        end;
    end;
}

