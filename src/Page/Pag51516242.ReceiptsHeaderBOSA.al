#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516242 "Receipts Header-BOSA"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "Receipts & Payments";

    layout
    {
        area(content)
        {
            Description = 'ContentArea';
            group(Transaction)
            {
                Caption = 'Transaction';
                field("Transaction No."; "Transaction No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Payment"; "Mode of Payment")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                }
                field("Allocated Amount"; "Allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Un allocated Amount"; "Un allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Employer No."; "Employer No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Teller Till / Bank  No.';
                }
                field("Cheque Date"; "Cheque Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque / Slip  Date';
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque / Slip  No.';
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Transaction Time"; "Transaction Time")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Insurance; Insuarance)
                {
                    ApplicationArea = Basic;
                }
                field("Old receipt No"; "Old receipt No")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Suggest)
            {
                Caption = 'Suggest';

                separator(Action1102760032)
                {
                }
                action("Suggest Payments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Monthy Repayments';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        TestField(Posted, false);
                        TestField("Account No.");
                        TestField(Amount);

                        ReceiptAllocations.Reset;
                        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", "Transaction No.");
                        ReceiptAllocations.DeleteAll;


                        if "Account Type" = "account type"::Customer then begin

                            BosaSetUp.Get();
                            RunBal := Amount;

                            if RunBal > 0 then begin

                                if Cust.Get("Account No.") then begin
                                    Cust.CalcFields(Cust."Registration Fee Paid");
                                    if Cust."Registration Fee Paid" = 0 then begin
                                        ReceiptAllocations.Init;
                                        ReceiptAllocations."Document No" := "Transaction No.";
                                        ReceiptAllocations."Member No" := "Account No.";
                                        ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Registration Fee";
                                        ReceiptAllocations."Loan No." := '';
                                        ReceiptAllocations.Amount := BosaSetUp."Registration Fee";
                                        ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount;
                                        ReceiptAllocations."Global Dimension 1 Code" := GenJournalLine."Shortcut Dimension 1 Code";
                                        ReceiptAllocations."Global Dimension 2 Code" := GenJournalLine."Shortcut Dimension 2 Code";
                                        ReceiptAllocations.Insert;
                                        RunBal := RunBal - ReceiptAllocations.Amount;
                                    end;
                                end;
                                //********** Mpesa Charges
                                if "Mode of Payment" = "mode of payment"::Mpesa then begin
                                    ReceiptAllocations.Init;
                                    ReceiptAllocations."Document No" := "Transaction No.";
                                    ReceiptAllocations."Member No" := "Account No.";
                                    ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"M Pesa Charge ";
                                    ReceiptAllocations."Loan No." := '';

                                    // M Pesa Tarriff

                                    if Amount <= 2499 then
                                        ReceiptAllocations."Total Amount" := 55
                                    else
                                        if Amount <= 4999 then
                                            ReceiptAllocations."Total Amount" := 75
                                        else
                                            if Amount <= 9999 then
                                                ReceiptAllocations."Total Amount" := 105
                                            else
                                                if Amount <= 19999 then
                                                    ReceiptAllocations."Total Amount" := 130
                                                else
                                                    if Amount <= 34999 then
                                                        ReceiptAllocations."Total Amount" := 185
                                                    else
                                                        if Amount <= 49999 then
                                                            ReceiptAllocations."Total Amount" := 220
                                                        else
                                                            if Amount <= 70000 then
                                                                ReceiptAllocations."Total Amount" := 240
                                                            else
                                                                if Amount > 70000 then
                                                                    Error('Sorry the Maximum M - Pesa transaction Amount is Ksha. 70,000');


                                    ReceiptAllocations.Amount := ReceiptAllocations."Total Amount";
                                    ReceiptAllocations."Global Dimension 1 Code" := GenJournalLine."Shortcut Dimension 1 Code";
                                    ReceiptAllocations."Global Dimension 2 Code" := GenJournalLine."Shortcut Dimension 2 Code";
                                    ReceiptAllocations.Insert;
                                end;
                                //********** END Mpesa Charges

                                if RunBal > 0 then begin
                                    //Loan Repayments
                                    Loans.Reset;
                                    Loans.SetCurrentkey(Loans.Source, Loans."Client Code");
                                    Loans.SetRange(Loans."Client Code", "Account No.");
                                    Loans.SetRange(Loans.Source, Loans.Source::BOSA);
                                    if Loans.Find('-') then begin
                                        repeat

                                            //Insurance Charge
                                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due", Loans."Loans Insurance", Loans."Oustanding Interest");
                                            if (Loans."Outstanding Balance" > 0) and (Loans."Approved Amount" > 100000) and
                                            (Loans."Loans Insurance" > 0) then begin



                                                ReceiptAllocations.Init;
                                                ReceiptAllocations."Document No" := "Transaction No.";
                                                ReceiptAllocations."Member No" := "Account No.";
                                                ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Insurance Paid";
                                                ReceiptAllocations."Loan No." := Loans."Loan  No.";
                                                ReceiptAllocations."Loan ID" := Loans."Loan Product Type";
                                                ReceiptAllocations.Amount := Loans."Loans Insurance";
                                                ReceiptAllocations."Amount Balance" := Loans."Outstanding Balance";
                                                ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount;
                                                ReceiptAllocations."Global Dimension 1 Code" := GenJournalLine."Shortcut Dimension 1 Code";
                                                ReceiptAllocations."Global Dimension 2 Code" := GenJournalLine."Shortcut Dimension 2 Code";
                                                ReceiptAllocations.Insert;
                                            end;


                                            if (Loans."Outstanding Balance") > 0 then begin
                                                LOustanding := 0;
                                                ReceiptAllocations.Init;
                                                ReceiptAllocations."Document No" := "Transaction No.";
                                                ReceiptAllocations."Member No" := "Account No.";
                                                ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::Repayment;
                                                ReceiptAllocations."Loan No." := Loans."Loan  No.";
                                                ReceiptAllocations."Loan ID" := Loans."Loan Product Type";
                                                ReceiptAllocations.Amount := Loans."Loan Principle Repayment";
                                                ReceiptAllocations."Amount Balance" := Loans."Outstanding Balance";
                                                ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                                                ReceiptAllocations."Global Dimension 1 Code" := GenJournalLine."Shortcut Dimension 1 Code";
                                                ReceiptAllocations."Global Dimension 2 Code" := GenJournalLine."Shortcut Dimension 2 Code";
                                                ReceiptAllocations.Insert;
                                            end;

                                            if (Loans."Oustanding Interest" > 0) then begin
                                                ReceiptAllocations.Init;
                                                ReceiptAllocations."Document No" := "Transaction No.";
                                                ReceiptAllocations."Member No" := "Account No.";
                                                ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Interest Paid";
                                                ReceiptAllocations."Loan No." := Loans."Loan  No.";
                                                ReceiptAllocations.Amount := Loans."Oustanding Interest";
                                                ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                                                ReceiptAllocations."Global Dimension 1 Code" := GenJournalLine."Shortcut Dimension 1 Code";
                                                ReceiptAllocations."Global Dimension 2 Code" := GenJournalLine."Shortcut Dimension 2 Code";
                                                ReceiptAllocations.Insert;
                                            end;

                                            RunBal := RunBal - ReceiptAllocations.Amount;

                                        until Loans.Next = 0;
                                    end;
                                end;
                            end;


                            //Deposits Contribution
                            if Cust.Get("Account No.") then begin
                                if Cust."Monthly Contribution" > 0 then begin
                                    ReceiptAllocations.Init;
                                    ReceiptAllocations."Document No" := "Transaction No.";
                                    ReceiptAllocations."Member No" := "Account No.";
                                    ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Deposit Contribution";
                                    ReceiptAllocations."Loan No." := '';
                                    ReceiptAllocations.Amount := ROUND(Cust."Monthly Contribution", 0.01);
                                    ;
                                    ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount;
                                    ReceiptAllocations."Global Dimension 1 Code" := GenJournalLine."Shortcut Dimension 1 Code";
                                    ReceiptAllocations."Global Dimension 2 Code" := GenJournalLine."Shortcut Dimension 2 Code";
                                    ReceiptAllocations.Insert;
                                end;
                            end;

                            //Shares Contribution
                            if Cust.Get("Account No.") then begin
                                Cust.CalcFields(Cust."Shares Retained");

                                if Cust."Shares Retained" < 6000 then begin
                                    BosaSetUp.Get();
                                    if BosaSetUp."Monthly Share Contributions" > 0 then begin
                                        ReceiptAllocations.Init;
                                        ReceiptAllocations."Document No" := "Transaction No.";
                                        ReceiptAllocations."Member No" := "Account No.";
                                        ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Shares Capital";
                                        ReceiptAllocations."Loan No." := '';
                                        ReceiptAllocations.Amount := ROUND(BosaSetUp."Monthly Share Contributions", 0.01);
                                        ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount;
                                        ReceiptAllocations."Global Dimension 1 Code" := GenJournalLine."Shortcut Dimension 1 Code";
                                        ReceiptAllocations."Global Dimension 2 Code" := GenJournalLine."Shortcut Dimension 2 Code";
                                        ReceiptAllocations.Insert;
                                    end;
                                end;
                            end;
                        end;

                        if "Account Type" = "account type"::Vendor then begin
                            if "Mode of Payment" = "mode of payment"::Mpesa then begin
                                ReceiptAllocations.Init;
                                ReceiptAllocations."Document No" := "Transaction No.";
                                ReceiptAllocations."Member No" := "Account No.";

                                ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"M Pesa Charge ";
                                ReceiptAllocations."Total Amount" := Amount;
                                ReceiptAllocations."Loan No." := '';


                                // M Pesa Tarriff
                                MpesaCharge := 0;
                                if Amount <= 2499 then
                                    ReceiptAllocations."Total Amount" := 55
                                else
                                    if Amount <= 4999 then
                                        ReceiptAllocations."Total Amount" := 75
                                    else
                                        if Amount <= 9999 then
                                            ReceiptAllocations."Total Amount" := 105
                                        else
                                            if Amount <= 19999 then
                                                ReceiptAllocations."Total Amount" := 130
                                            else
                                                if Amount <= 34999 then
                                                    ReceiptAllocations."Total Amount" := 185
                                                else
                                                    if Amount <= 49999 then
                                                        ReceiptAllocations."Total Amount" := 220
                                                    else
                                                        if Amount <= 70000 then
                                                            ReceiptAllocations."Total Amount" := 240
                                                        else
                                                            if Amount > 70000 then
                                                                Error('Sorry the Maximum M - Pesa transaction Amount is Ksha. 70,000');
                                MpesaCharge := ReceiptAllocations."Total Amount";
                                ReceiptAllocations.Amount := ReceiptAllocations."Total Amount";

                                //ReceiptAllocations."Total Amount":=Amount;
                                ReceiptAllocations."Global Dimension 1 Code" := GenJournalLine."Shortcut Dimension 1 Code";
                                ReceiptAllocations."Global Dimension 2 Code" := GenJournalLine."Shortcut Dimension 2 Code";
                                ReceiptAllocations.Insert;
                            end;

                            //********** END Mpesa Charges


                            ReceiptAllocations.Init;
                            ReceiptAllocations."Document No" := "Transaction No.";
                            ReceiptAllocations."Member No" := "Account No.";
                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"FOSA Account";
                            ReceiptAllocations."Loan No." := ' ';
                            ReceiptAllocations."Total Amount" := Amount;
                            ReceiptAllocations."Global Dimension 1 Code" := GenJournalLine."Shortcut Dimension 1 Code";
                            ReceiptAllocations."Global Dimension 2 Code" := GenJournalLine."Shortcut Dimension 2 Code";
                            ReceiptAllocations.Amount := ReceiptAllocations."Total Amount";
                            ReceiptAllocations.Insert;



                        end;
                        CalcFields("Allocated Amount");
                        "Un allocated Amount" := (Amount - "Allocated Amount");
                        Modify;

                    end;
                }
            }
        }
        area(processing)
        {
            action(Refresh)
            {
                ApplicationArea = Basic;
                Caption = 'Refresh Page';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Post (F11)';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin


                    if Remarks = '' then begin
                        Error('Please specify description for this transaction')
                    end;

                    //IF CONFIRM('Are you sure you want to post this receipt?');
                    if Confirm('Are you sure you want to post this receipt?', true) = false then
                        exit;


                    //-----------Check to Avoid Double Posting-------------------------
                    MemberLedg.Reset;
                    MemberLedg.SetRange(MemberLedg."Document No.", "Transaction No.");
                    if MemberLedg.Find('-') then begin
                        if Posted = false then begin
                            Posted := true;
                            Modify;
                            Error('This Receipt has been Posted to the Members Account');
                        end;
                        exit
                    end;


                    //-----------Check to Avoid Double Posting-------------------------

                    if FundsUser.Get(UserId) then begin
                        FundsUser.TestField(FundsUser."Receipt Journal Template");
                        FundsUser.TestField(FundsUser."Receipt Journal Batch");
                        JournalTemplate := FundsUser."Receipt Journal Template";
                        JournalBatch := FundsUser."Receipt Journal Batch";
                    end else begin
                        Error('User Account Not Setup for Posting');
                    end;

                    if Posted then
                        Error('This receipt is already posted');

                    TestField("Account No.");
                    TestField(Amount);
                    TestField("Employer No.");

                    if ("Account Type" = "account type"::"G/L Account") or
                       ("Account Type" = "account type"::Debtor) then
                        TransType := 'Withdrawal'
                    else
                        TransType := 'Deposit';

                    BOSABank := "Employer No.";
                    if ("Account Type" = "account type"::Customer) or ("Account Type" = "account type"::"FOSA Loan") then begin

                        if Amount <> "Allocated Amount" then
                            Error('Receipt amount must be equal to the allocated amount.');
                    end;
                    ReceiptAllocations.Reset;
                    ReceiptAllocations.SetRange(ReceiptAllocations."Document No", "Transaction No.");
                    if ReceiptAllocations.Find('-') then begin

                        Branch := ReceiptAllocations."Global Dimension 2 Code";
                        Activity := ReceiptAllocations."Global Dimension 1 Code";

                    end;
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                    GenJournalLine.DeleteAll;


                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := JournalTemplate;
                    GenJournalLine."Journal Batch Name" := JournalBatch;
                    GenJournalLine."Document No." := "Transaction No.";
                    GenJournalLine."External Document No." := "Cheque No.";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := "Employer No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Source No." := "Old receipt No";
                    GenJournalLine."Posting Date" := "Transaction Date";
                    GenJournalLine.Description := Remarks;
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    // GenJournalLine."Shortcut Dimension 1 Code":=Activity;
                    // GenJournalLine."Shortcut Dimension 2 Code":=Branch;

                    if TransType = 'Withdrawal' then
                        GenJournalLine.Amount := -Amount
                    else
                        GenJournalLine.Amount := Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    if ("Account Type" <> "account type"::Customer) and ("Account Type" <> "account type"::"FOSA Loan") and ("Account Type" <> "account type"::Vendor) then begin
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := JournalTemplate;
                        GenJournalLine."Journal Batch Name" := JournalBatch;
                        GenJournalLine."Document No." := "Transaction No.";
                        GenJournalLine."External Document No." := "Cheque No.";
                        GenJournalLine."Line No." := LineNo;
                        if "Account Type" = "account type"::"G/L Account" then
                            GenJournalLine."Account Type" := "Account Type"
                        else
                            if "Account Type" = "account type"::Debtor then
                                GenJournalLine."Account Type" := "Account Type"
                            else
                                if "Account Type" = "account type"::Vendor then
                                    GenJournalLine."Account Type" := "Account Type"
                                else
                                    if "Account Type" = "account type"::Customer then
                                        GenJournalLine."Account Type" := "Account Type";
                        GenJournalLine."Account No." := "Account No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := "Transaction Date";
                        GenJournalLine.Description := Remarks;//'BT-'+Name+'-'+"Account No."+'-'+
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        if TransType = 'Withdrawal' then
                            GenJournalLine.Amount := Amount
                        else
                            GenJournalLine.Amount := -Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                        GenJournalLine."Shortcut Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch("Account No.");
                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                    end;

                    GenSetup.Get();

                    if ("Account Type" = "account type"::Customer) or ("Account Type" = "account type"::"FOSA Loan") or ("Account Type" = "account type"::Vendor) then begin

                        ReceiptAllocations.Reset;
                        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", "Transaction No.");
                        if ReceiptAllocations.Find('-') then begin
                            repeat

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := JournalTemplate;
                                GenJournalLine."Journal Batch Name" := JournalBatch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := "Transaction No.";
                                GenJournalLine."External Document No." := "Cheque No.";
                                //GenJournalLine."Posting Date":="Cheque Date";
                                GenJournalLine."Posting Date" := "Transaction Date";
                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"FOSA Account" then begin
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;

                                    if Cust.Get("Account No.") then
                                        GenJournalLine."Account No." := Cust."FOSA Account";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine.Description := Remarks;//'BT-'+Name+'-'+"Account No."+'-'+
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch("Account No.");
                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");

                                end else begin
                                    if "Account Type" = "account type"::Vendor then begin
                                        GenJournalLine."Posting Date" := "Transaction Date";
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch("Account No.");
                                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;

                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := ReceiptAllocations."Member No";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");

                                        if ("Mode of Payment" = "mode of payment"::Mpesa) and (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"M Pesa Charge ") then begin
                                            GenJournalLine.Amount := -Amount;
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                            GenJournalLine."Account No." := GenSetup."FOSA MPESA COmm A/C";
                                            GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type") + '-' + Remarks;
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                                            GenJournalLine."Bal. Account No." := "Account No.";

                                        end;
                                    end;

                                    if "Account Type" = "account type"::Customer then begin
                                        GenJournalLine."Posting Date" := "Transaction Date";
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch("Account No.");
                                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                        GenJournalLine."Account No." := ReceiptAllocations."Member No";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        if ("Mode of Payment" = "mode of payment"::Mpesa) and (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"M Pesa Charge ") then begin
                                            GenJournalLine.Amount := -Amount;
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                            GenJournalLine."Account No." := GenSetup."FOSA MPESA COmm A/C";
                                            GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type") + '-' + Remarks;
                                        end;
                                    end;
                                end;

                                GenJournalLine.Amount := -ReceiptAllocations.Amount;
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine."Shortcut Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch("Account No.");
                                // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                //description
                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Interest Paid" then
                                    GenJournalLine.Description := 'Interest' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                else
                                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Insurance Paid" then
                                        GenJournalLine.Description := 'L-Insurance' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                    else
                                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Benevolent Fund" then
                                            GenJournalLine.Description := 'Insurance' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                        else
                                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
                                                GenJournalLine.Description := 'Registration' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                            else
                                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Repayment then
                                                    GenJournalLine.Description := 'Repayment' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                else
                                                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Unallocated Funds" then
                                                        GenJournalLine.Description := 'Unallocated' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                    else
                                                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Deposit Contribution" then //Unwithdrawable Shares
                                                            GenJournalLine.Description := 'Unwithdrawable Shares' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                        else
                                                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Lukenya then // Preferencial Shares
                                                                GenJournalLine.Description := 'Preferencial Shares' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                            else
                                                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Housing Main" then //Housing Deposits
                                                                    GenJournalLine.Description := 'Housing Deposits' + '-' + Remarks + '-'//+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                                else
                                                                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Withdrawable Deposits" then //ord. build shares
                                                                        GenJournalLine.Description := 'Ord. building shares(2)' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                                    else
                                                                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Juja then // Bus Shares
                                                                            GenJournalLine.Description := 'Bus Shares' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                                        else
                                                                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Housing Title" then //Ordinary Building Shares
                                                                                GenJournalLine.Description := 'Ord. building shares' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                                            else
                                                                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Housing Water" then //Computer Shares
                                                                                    GenJournalLine.Description := 'Computer Shares' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                                                else
                                                                                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Shares Capital" then //Institutional Capital
                                                                                        GenJournalLine.Description := 'Institutional Capital' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                                                    else
                                                                                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"PassBook Fee" then  //Kuscco Shares
                                                                                            GenJournalLine.Description := 'Kuscco Shares' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                                                        else
                                                                                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Benevolent Fund" then
                                                                                                GenJournalLine.Description := 'Benevolent' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                                                            else
                                                                                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"SchFee Shares" then //COOP Shares
                                                                                                    GenJournalLine.Description := 'COOP Shares' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                                                                else
                                                                                                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"FOSA Shares" then  //FOSA Shares
                                                                                                        GenJournalLine.Description := 'FOSA Shares' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                                                                    else
                                                                                                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Pepea Shares" then // Pepea Shares
                                                                                                            GenJournalLine.Description := 'Pepea Shares' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                                                                        else
                                                                                                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Normal shares" then // CIC Shares
                                                                                                                GenJournalLine.Description := 'CIC Shares' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                                                                            else
                                                                                                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Konza then // Van Shares
                                                                                                                    GenJournalLine.Description := 'Van Shares' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                                                                                else
                                                                                                                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Lift Shares" then // Lift Shares
                                                                                                                        GenJournalLine.Description := 'Lift Shares' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."
                                                                                                                    else
                                                                                                                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Changamka Shares" then // Changamka Shares
                                                                                                                            GenJournalLine.Description := 'Changamka Shares' + '-' + Remarks//+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No."


                                                                                                                        else
                                                                                                                            GenJournalLine.Description := Remarks;  //+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No.";

                                //description
                                GenJournalLine."Transaction Type" := ReceiptAllocations."Transaction Type";
                                GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                                //MESSAGE('%',ReceiptAllocations."Transaction Type");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                            until ReceiptAllocations.Next = 0;
                        end;


                    end;

                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                    if GenJournalLine.Find('-') then begin


                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                    end;
                    //Post New

                    Posted := true;
                    Modify;
                    Commit;

                    BOSARcpt.Reset;
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.", "Transaction No.");
                    if BOSARcpt.Find('-') then
                        BOSARcpt.Reset;
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.", "Transaction No.");
                    if BOSARcpt.Find('-') then
                        Report.Run(51516247, true, false, BOSARcpt);

                    //END;
                    CurrPage.Close;

                end;
            }
            action("Reprint recipts")
            {
                ApplicationArea = Basic;
                Caption = 'Reprint Receipt';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    TestField(Posted);

                    BOSARcpt.Reset;
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.", "Transaction No.");
                    if BOSARcpt.Find('-') then
                        Report.Run(51516247, true, false, BOSARcpt)
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        /*Rcpt.RESET;
         Rcpt.SETRANGE(Rcpt.Posted,FALSE);
         Rcpt.SETRANGE(Rcpt."User ID",USERID);

         IF Rcpt.COUNT >0 THEN BEGIN
                 ERROR('You have an Unposted Receipt. Please utilise it first');
           END;
            */

    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        InterestPaid: Decimal;
        PaymentAmount: Decimal;
        RunBal: Decimal;
        Recover: Boolean;
        Cheque: Boolean;
        ReceiptAllocations: Record "Receipt Allocation";
        Loans: Record "Loans Register";
        Commision: Decimal;
        LOustanding: Decimal;
        TotalCommision: Decimal;
        TotalOustanding: Decimal;
        Cust: Record Customer;
        BOSABank: Code[20];
        LineNo: Integer;
        BOSARcpt: Record "Receipts & Payments";
        TellerTill: Record "Bank Account";
        CurrentTellerAmount: Decimal;
        TransType: Text[30];
        RCPintdue: Decimal;
        Text001: label 'This member has reached a maximum share contribution of Kshs. 6,000/=. Do you want to post this transaction as shares contribution?';
        BosaSetUp: Record "Sacco General Set-Up";
        MpesaCharge: Decimal;
        CustPostingGrp: Record "Customer Posting Group";
        MpesaAc: Code[30];
        GenSetup: Record "Sacco General Set-Up";
        JournalTemplate: Code[20];
        JournalBatch: Code[20];
        FundsUser: Record "Funds User Setup";
        Branch: Text;
        Activity: Text;
        Rcpt: Record "Receipts & Payments";
        MemberLedg: Record "Cust. Ledger Entry";
        SURESTEPFactory: Codeunit "SURESTEP Factory";

    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update := true;
    end;
}

