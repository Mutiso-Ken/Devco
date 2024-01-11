#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516256 "Loan Disburesment Batch Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Disburesment-Batching";
    SourceTableView = where(Posted = const(false), Source = const(MICRO));

    layout
    {
        area(content)
        {
            field("Batch No."; "Batch No.")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field(Source; Source)
            {
                ApplicationArea = Basic;
                Editable = SourceEditable;
            }
            field("Batch Type"; "Batch Type")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Description/Remarks"; "Description/Remarks")
            {
                ApplicationArea = Basic;
                Editable = DescriptionEditable;
            }
            field(Status; Status)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Total Loan Amount"; "Total Loan Amount")
            {
                ApplicationArea = Basic;
            }
            field("No of Loans"; "No of Loans")
            {
                ApplicationArea = Basic;
            }
            field("Mode Of Disbursement"; "Mode Of Disbursement")
            {
                ApplicationArea = Basic;
                Editable = ModeofDisburementEditable;

                trigger OnValidate()
                begin
                    if "Mode Of Disbursement" <> "mode of disbursement"::Cheque then
                        "Cheque No." := "Batch No.";
                    Modify;

                end;
            }
            field("Document No."; "Document No.")
            {
                ApplicationArea = Basic;
                Editable = DocumentNoEditable;

                trigger OnValidate()
                begin

                end;
            }
            field(o; "Posting Date")
            {
                ApplicationArea = Basic;
                Caption = 'Posting Date';
                Editable = PostingDateEditable;
            }
            field("BOSA Bank Account"; "BOSA Bank Account")
            {
                ApplicationArea = Basic;
                Caption = 'Paying Bank';
                Editable = PayingAccountEditable;
            }
            field("Cheque No."; LoansBatch."Cheque No.")
            {
                ApplicationArea = Basic;
                Editable = ChequeNoEditable;
            }
            part("`"; "Loans Sub-Page List")
            {
                Editable = false;
                SubPageLink = "Batch No." = field("Batch No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(LoansB)
            {
                Caption = 'Batch';
                action("Loans Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Schedule';
                    Image = SuggestPayment;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Posted = true then
                            Error('Batch already posted.');


                        LoansBatch.Reset;
                        LoansBatch.SetRange(LoansBatch."Batch No.", "Batch No.");
                        if LoansBatch.Find('-') then begin
                            if LoansBatch."Batch Type" = LoansBatch."batch type"::"Personal Loans" then
                                Report.Run(51516232, true, false, LoansBatch)
                            else
                                if LoansBatch."Batch Type" = LoansBatch."batch type"::"Branch Loans" then
                                    Report.Run(51516232, true, false, LoansBatch)
                                else
                                    if LoansBatch."Batch Type" = LoansBatch."batch type"::"Appeal Loans" then
                                        Report.Run(51516232, true, false, LoansBatch)
                                    else
                                        Report.Run(51516232, true, false, LoansBatch);
                        end;
                    end;
                }
                separator(Action1102760034)
                {
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    Enabled = SendApprovalEditable;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
                    begin
                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
                        if LoanApps.Find('-') = false then
                            Error('You cannot send an empty batch for approval');
                        TestField("Description/Remarks");
                        if Status <> Status::Open then
                            Error(Text001);
                        if Confirm('Send Approval Request?', false) = true then begin
                            Status := Status::Approved;
                            rec.Modify(true);
                            Message('Approved');
                            //SrestepApprovalsCodeUnit.SendLoanBatchRequestForApproval(rec."Batch No.", Rec);
                        end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = CancelApprovalEditable;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
                    begin
                        if Confirm('Cancel Approval?', false) = true then begin
                            SrestepApprovalsCodeUnit.CancelLoanBatchRequestForApproval(rec."Batch No.", Rec);
                        end;
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Batch';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = PostEnabled;

                    trigger OnAction()
                    var
                        Text001: label 'The Batch need to be approved.';
                        ProcessingFees: Decimal;
                        ExciseGL: Code[50];
                        PepeaShares: Decimal;
                        SaccoDeposits: Decimal;
                    begin

                        if Posted = true then
                            Error('Batch already posted.');

                        if Status <> Status::Approved then
                            Error(Format(Text001));

                        if Confirm('Are you sure you want to post this batch?', false) = false then begin
                            exit;
                        end else begin
                            if "Mode Of Disbursement" = "mode of disbursement"::Cheque then begin
                                TestField("Description/Remarks");
                                TestField("Posting Date");
                                TestField("Document No.");
                                //PRORATED DAYS
                                EndMonth := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy("Posting Date", 2), Date2dmy("Posting Date", 3))));
                                RemainingDays := (EndMonth - "Posting Date") + 1;
                                TMonthDays := Date2dmy(EndMonth, 1);
                                //PRORATED DAYS
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                                GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                                GenJournalLine.DeleteAll;
                                GenSetUp.Get;
                                DActivity := '';
                                DBranch := '';
                                LoanApps.Reset;
                                LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
                                LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
                                if LoanApps.Find('-') then begin
                                    repeat
                                        TCharges := 0;
                                        DActivity := '';
                                        DBranch := '';
                                        if Cust.Get(LoanApps."Client Code") then begin
                                            DActivity := Cust."Global Dimension 1 Code";
                                            DBranch := Cust."Global Dimension 2 Code";
                                        end;
                                        LoanDisbAmount := LoanApps."Approved Amount";
                                        LoanApps.CalcFields(LoanApps."Top Up Amount");
                                        RunningDate := "Posting Date";
                                        SFactory.FnGenerateRepaymentSchedule(LoanApps."Loan  No.");
                                        //Generate and post Approved Loan Amount
                                        if not GenBatch.Get('PAYMENTS', 'LOANS') then begin
                                            GenBatch.Init;
                                            GenBatch."Journal Template Name" := 'PAYMENTS';
                                            GenBatch.Name := 'LOANS';
                                            GenBatch.Insert;
                                        end;

                                        //----------------Principle--------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                        GenJournalLine."Account No." := LoanApps."Client Code";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Document No." := "Document No.";
                                        GenJournalLine."External Document No." := LoanApp."Loan  No.";
                                        GenJournalLine."Posting Date" := "Posting Date";
                                        GenJournalLine.Description := 'Principle Amount';
                                        GenJournalLine.Amount := LoanDisbAmount;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                        GenJournalLine."Group Code" := LoanApps."Group Code";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                        //Abel-------------------Interest Accrued all of it
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                        GenJournalLine."Account No." := LoanApps."Client Code";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Document No." := "Document No.";
                                        GenJournalLine."External Document No." := LoanApp."Loan  No.";
                                        GenJournalLine."Posting Date" := "Posting Date";
                                        GenJournalLine.Description := 'Loan Interest Charged';
                                        GenJournalLine.Amount := LoanApps."Loan Interest Repayment";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
                                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                        GenJournalLine."Group Code" := LoanApps."Group Code";
                                        IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                            GenJournalLine."Bal. Account No." := LoanType."Loan Interest Account";
                                            GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                        END;
                                        GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranch(LoanApps."Client Code");
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                        //-------------------End of principle amount--------------------------------------
                                        BatchTopUpAmount := TotalTopupComm;

                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Document No." := "Document No.";
                                        GenJournalLine."Posting Date" := "Posting Date";
                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Vendor;
                                        GenJournalLine."Account No." := LoanApps."Account No";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        if (LoanApps."Account No" = '350011') or (LoanApps."Account No" = '350012') then begin
                                            GenJournalLine.Description := LoanApps."Client Name";
                                            if Cust.Get(LoanApps."Client Code") then begin
                                                GenJournalLine."External Document No." := Cust."ID No.";
                                                GenJournalLine.Description := Cust."Payroll/Staff No" + ' - ' + GenJournalLine.Description;
                                            end;
                                        end else
                                            GenJournalLine.Description := LoanApps."Loan Product Type Name";
                                        GenJournalLine.Amount := (LoanDisbAmount - (LoanApps."Discount Amount")) * -1;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                        //***********************
                                        PCharges.Reset;
                                        PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                                        if PCharges.Find('-') then begin
                                            repeat
                                                //TCharges:=0;
                                                PCharges.TestField(PCharges."G/L Account");

                                                LineNo := LineNo + 10000;
                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                                GenJournalLine."Account No." := PCharges."G/L Account";
                                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                                GenJournalLine."Document No." := "Document No.";
                                                GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                GenJournalLine."Posting Date" := "Posting Date";
                                                GenJournalLine.Description := PCharges.Description;
                                                if PCharges."Use Perc" = true then begin
                                                    GenJournalLine.Amount := (LoanDisbAmount * (PCharges.Percentage / 100)) * -1;
                                                    if PCharges.Code = 'PROCESSING' then
                                                        ProcessingFees := LoanDisbAmount * (PCharges.Percentage / 100);
                                                end else
                                                    GenJournalLine.Amount := PCharges.Amount * -1;
                                                if ((PCharges.Code = 'CREDITINGFEE') and (LoanApps."Batch Source" = LoanApps."batch source"::BOSA)) then begin
                                                    ProcessingFees := SFactory.FnGetBosaTransferFeeBudding(LoanDisbAmount);
                                                    GenJournalLine.Amount := ProcessingFees * -1;
                                                end;
                                                GenJournalLine.Validate(GenJournalLine.Amount);
                                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                                                GenJournalLine."Bal. Account No." := LoanApps."Account No";
                                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                                GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;
                                            until PCharges.Next = 0;
                                        end;
                                        //Added For Ceep Opening Charge
                                        if (LoanApps."Approved Amount" > 300) then
                                            Membz.Reset;
                                        Membz.SetRange(Membz."No.", LoanApps."Client Code");
                                        Membz.SetRange(Membz."Customer Type", Membz."customer type"::MicroFinance);
                                        if Membz.Find('-') then begin
                                            if (AccountOpening.FnCheckIfCeepPaid(LoanApps."Account No") = false) then
                                                AccountOpening.FnCeepReg('PAYMENTS', 'LOANS', LineNo, LoanApps."Account No", LoanApps."Approved Amount", DActivity, DBranch, "Batch No.", LoanApps."Loan  No.");
                                        end;
                                        //-------------------------RECOVER OD-----------------------------------------------------------------
                                        BATCH_TEMPLATE := 'PAYMENTS';
                                        BATCH_NAME := 'LOANS';
                                        DOCUMENT_NO := "Document No.";
                                        ShareAmount := 0;
                                        Scharge := 0;
                                        LoanType.Reset;
                                        LoanType.SetRange(LoanType.Code, LoanApps."Loan Product Type");
                                        if LoanType.Find('-') then begin
                                            PepeaShares := LoanType."Pepea Deposits" * LoanApps."Approved Amount";
                                            SaccoDeposits := LoanType."Sacco Deposits" * LoanApps."Approved Amount";
                                        end;

                                        //Startof recover FOSA Shares

                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := LoanApps."Account No";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Document No." := "Document No.";
                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                        GenJournalLine."Posting Date" := "Posting Date";
                                        GenJournalLine.Description := 'FOSA Shares Recovered ';
                                        GenJournalLine.Amount := (PepeaShares) / 100;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                        GenJournalLine."Account No." := LoanApps."Client Code";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Document No." := "Document No.";
                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                        GenJournalLine."Posting Date" := "Posting Date";
                                        GenJournalLine.Description := 'FOSA Shares Recovered ';
                                        GenJournalLine.Amount := (PepeaShares * -1) / 100;
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"FOSA Shares";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                        //End of recover FOSA Shares
                                        Commitm := 0;
                                        EftAmount := EftAmount + GenJournalLine.Amount;
                                        //Generate Data Sheet Advice
                                        PTEN := '';

                                        if StrLen(LoanApps."Staff No") = 10 then begin
                                            PTEN := CopyStr(LoanApps."Staff No", 10);
                                        end else
                                            if StrLen(LoanApps."Staff No") = 9 then begin
                                                PTEN := CopyStr(Loans."Staff No", 9);
                                            end else
                                                if StrLen(LoanApps."Staff No") = 8 then begin
                                                    PTEN := CopyStr(LoanApps."Staff No", 8);
                                                end else
                                                    if StrLen(LoanApps."Staff No") = 7 then begin
                                                        PTEN := CopyStr(LoanApps."Staff No", 7);
                                                    end else
                                                        if StrLen(LoanApps."Staff No") = 6 then begin
                                                            PTEN := CopyStr(LoanApps."Staff No", 6);
                                                        end else
                                                            if StrLen(LoanApps."Staff No") = 5 then begin
                                                                PTEN := CopyStr(LoanApps."Staff No", 5);
                                                            end else
                                                                if StrLen(LoanApps."Staff No") = 4 then begin
                                                                    PTEN := CopyStr(LoanApps."Staff No", 4);
                                                                end else
                                                                    if StrLen(LoanApps."Staff No") = 3 then begin
                                                                        PTEN := CopyStr(LoanApps."Staff No", 3);
                                                                    end else
                                                                        if StrLen(LoanApps."Staff No") = 2 then begin
                                                                            PTEN := CopyStr(LoanApps."Staff No", 2);
                                                                        end else
                                                                            if StrLen(LoanApps."Staff No") = 1 then begin
                                                                                PTEN := CopyStr(LoanApps."Staff No", 1);
                                                                            end;

                                        if LoanApps."Top Up Amount" > 0 then begin
                                            LoanTopUp.Reset;
                                            LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                                            if LoanTopUp.Find('-') then begin
                                                repeat
                                                    //Principle
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Document No." := "Document No.";
                                                    GenJournalLine."Posting Date" := "Posting Date";
                                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                                    GenJournalLine."Account No." := LoanApps."Client Code";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                                    GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                                                    GenJournalLine.Amount := LoanTopUp."Principle Top Up" * -1;
                                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";

                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;
                                                    BatchTopUpAmount := BatchTopUpAmount + (GenJournalLine.Amount * -1);



                                                    //****************************Debit Vendor*******************************

                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Document No." := "Document No.";
                                                    GenJournalLine."Posting Date" := "Posting Date";
                                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                                    GenJournalLine."Account No." := LoanApps."Account No";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                                    GenJournalLine.Description := LoanTopUp."Loan Type" + '-Loan Principle Recovered ';
                                                    GenJournalLine.Amount := LoanTopUp."Principle Top Up";
                                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";

                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;
                                                    //BatchTopUpAmount:=BatchTopUpAmount+(GenJournalLine.Amount*-1);

                                                    //Interest (Reversed if top up)
                                                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                                                        LineNo := LineNo + 10000;
                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                                                        GenJournalLine."Account No." := LoanApps."Client Code";
                                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                                        GenJournalLine."Document No." := "Document No.";
                                                        GenJournalLine."Posting Date" := "Posting Date";
                                                        GenJournalLine.Description := 'Interest Due Paid on top up ';
                                                        GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                        GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                        if GenJournalLine.Amount <> 0 then
                                                            GenJournalLine.Insert;
                                                        BatchTopUpAmount := BatchTopUpAmount + (GenJournalLine.Amount * -1);

                                                    end;


                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Vendor;
                                                    GenJournalLine."Account No." := LoanApps."Account No";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                                    GenJournalLine."Document No." := "Document No.";
                                                    GenJournalLine."Posting Date" := "Posting Date";
                                                    GenJournalLine.Description := LoanTopUp."Loan Type" + '-Loan Interest Recovered ';
                                                    GenJournalLine.Amount := LoanTopUp."Interest Top Up";
                                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;

                                                    //Commission
                                                    TopUpComm := 0;
                                                    TotalTopupComm := 0;
                                                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                                                        LineNo := LineNo + 10000;
                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                        GenJournalLine."Account No." := LoanType."Top Up Commision Account";
                                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                                        GenJournalLine."Document No." := "Document No.";
                                                        GenJournalLine."Posting Date" := "Posting Date";
                                                        GenJournalLine.Description := 'Commission on Loan Top Up';
                                                        TopUpComm := LoanTopUp.Commision;
                                                        TotalTopupComm := TotalTopupComm + TopUpComm;
                                                        GenJournalLine.Amount := TopUpComm * -1;
                                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                        if GenJournalLine.Amount <> 0 then
                                                            GenJournalLine.Insert;
                                                        BatchTopUpAmount := BatchTopUpAmount + (GenJournalLine.Amount * -1);
                                                    end;

                                                    //--------------------Debit Vendor-------------------------------
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                                    GenJournalLine."Account No." := LoanApps."Account No";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                                    GenJournalLine."Document No." := "Document No.";
                                                    GenJournalLine."Posting Date" := "Posting Date";
                                                    GenJournalLine.Description := LoanTopUp."Loan Type" + '-Top Up Commission Recovered';
                                                    TopUpComm := LoanTopUp.Commision;
                                                    TotalTopupComm := TotalTopupComm + TopUpComm;
                                                    GenJournalLine.Amount := TopUpComm;
                                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;
                                                until LoanTopUp.Next = 0;

                                            end;
                                        end;
                                        TotBoost := 0;
                                        LoanApps."Issued Date" := "Posting Date";
                                        LoanApps.Advice := true;
                                        LoanApps."Advice Type" := LoanApps."advice type"::"Fresh Loan";
                                        LoanApps.Posted := true;
                                        LoanApps."Loan Status" := LoanApps."loan status"::Issued;
                                    // LoanApps.Modify;
                                    until LoanApps.Next = 0;
                                end;
                                //Accrue Loan Interest On Constant Basis

                                LoanApps.Reset;
                                LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
                                LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
                                if LoanApps.Find('-') then begin
                                    repeat
                                        LoanDisbAmount := LoanApps."Approved Amount";

                                        //Top Up Commission
                                        TopUpComm := 0;
                                        TotalTopupComm := 0;
                                        BatchTopUpAmount := 0;

                                        LoanApps.CalcFields(LoanApps."Top Up Amount");
                                        if LoanApps."Top Up Amount" > 0 then begin
                                            LoanTopUp.Reset;
                                            LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                                            if LoanTopUp.Find('-') then begin
                                                TopUpComm := LoanTopUp.Commision;
                                                repeat
                                                    TotalTopupComm := TotalTopupComm + LoanTopUp.Commision + LoanTopUp."Principle Top Up" + LoanTopUp."Interest Top Up";
                                                until LoanTopUp.Next = 0;
                                                //BatchTopUpAmount:=TotalTopupComm+lo;
                                            end;
                                        end;

                                        if LoanApps."Top Up Amount" > 0 then begin
                                            //Split entries to FOSA*****
                                            //Total Top up
                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Document No." := "Document No.";
                                            GenJournalLine."Posting Date" := "Posting Date";
                                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                            GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Vendor;
                                            GenJournalLine."Account No." := LoanApps."Account No";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine.Description := 'Total Top up recovery';
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;

                                            //Total Top up
                                        end;
                                    until LoanApps.Next = 0;
                                end;
                                exit;
                                //>>>>>>>>>>>>>>>>>>>Post for FOSA Transfer Disbursement method
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                                GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                                if GenJournalLine.Find('-') then begin
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                    Posted := true;
                                    Modify;
                                    Message('Batch posted successfully.');
                                    CurrPage.Close();
                                end;
                            end else begin
                                Error(Format("Mode Of Disbursement") + ' Is currently Not Supported');
                                exit;
                            end;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    var
        Text001: label 'Status must be open';
        MovementTracker: Record "File Movement Tracker";
        FileMovementTracker: Record "File Movement Tracker";
        NextStage: Integer;
        EntryNo: Integer;
        NextLocation: Text[100];
        LoansBatch: Record "Loan Disburesment-Batching";
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repayment Schedule";
        PeriodInterval: Code[10];
        CustomerRecord: Record Customer;
        Gnljnline: Record "Gen. Journal Line";
        // Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        Loans: Record "Loans Register";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        //GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        TotalTopupComm: Decimal;
        Notification: Codeunit Mail;
        CustE: Record Customer;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        LoanApps: Record "Loans Register";
        Banks: Record "Bank Account";
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        TotalSpecialLoan: Decimal;
        SpecialLoanCl: Record "Loan Special Clearance";
        Loans2: Record "Loans Register";
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        Refunds: Record "Loan Products Setup";
        TotalRefunds: Decimal;
        WithdrawalFee: Decimal;
        NetPayable: Decimal;
        NetRefund: Decimal;
        FWithdrawal: Decimal;
        OutstandingInt: Decimal;
        TSC: Decimal;
        LoanDisbAmount: Decimal;
        NegFee: Decimal;
        DValue: Record "Dimension Value";
        ChBank: Code[20];
        Trans: Record Transactions;
        TransactionCharges: Record "Transaction Charges";
        BChequeRegister: Record "Banker Cheque Register";
        OtherCommitments: Record "Other Commitements Clearance";
        BoostingComm: Decimal;
        BoostingCommTotal: Decimal;
        BridgedLoans: Record "Loan Special Clearance";
        InterestDue: Decimal;
        ContractualShares: Decimal;
        BridgingChanged: Boolean;
        BankersChqNo: Code[20];
        LastPayee: Text[100];
        RunningAmount: Decimal;
        BankersChqNo2: Code[20];
        BankersChqNo3: Code[20];
        EndMonth: Date;
        RemainingDays: Integer;
        PrincipalRepay: Decimal;
        InterestRepay: Decimal;
        TMonthDays: Integer;
        SMSMessage: Record "Loan Appraisal Salary Details";
        iEntryNo: Integer;
        Temp: Record Customer;
        Jtemplate: Code[30];
        JBatch: Code[30];
        LBatches: Record "Loan Disburesment-Batching";
        ///ApprovalMgt: Codeunit "Export F/O Consolidation";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","FOSA Opening","Loan Batching",Leave,"Imprest Requisition","Imprest Surrender","Stores Requisition","Funds Transfer","Change Request","Staff Claims","BOSA Transfer","Loan Tranche","Loan TopUp","Memb Opening","Member Withdrawal";
        DescriptionEditable: Boolean;
        ModeofDisburementEditable: Boolean;
        DocumentNoEditable: Boolean;
        PostingDateEditable: Boolean;
        SourceEditable: Boolean;
        PayingAccountEditable: Boolean;
        ChequeNoEditable: Boolean;
        ChequeNameEditable: Boolean;
        upfronts: Decimal;
        EmergencyInt: Decimal;
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan,"Loan Batch";
        Deductions: Decimal;
        BatchBoostingCom: Decimal;
        HisaRepayment: Decimal;
        HisaLoan: Record "Loans Register";
        BatchHisaRepayment: Decimal;
        BatchFosaHisaComm: Decimal;
        BatchHisaShareBoostComm: Decimal;
        BatchShareCap: Decimal;
        BatchIntinArr: Decimal;
        Loaninsurance: Decimal;
        TLoaninsurance: Decimal;
        ProductCharges: Record "Loan Product Charges";
        InsuranceAcc: Code[20];
        PTEN: Code[20];
        LoanTypes: Record "Loan Products Setup";
        Customer: Record Customer;
        DataSheet: Record "Data Sheet Main";
        TotBoost: Decimal;
        ShareAmount: Decimal;
        Commitm: Decimal;
        Scharge: Decimal;
        EftAmount: Decimal;
        EFTDeduc: Decimal;
        linecharges: Decimal;
        AccountOpening: Codeunit SureAccountCharges;
        Membz: Record Customer;
        SFactory: Codeunit "SURESTEP Factory";
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        BalanceCutOffDate: Date;
        SMSMessages: Record "SMS Messages";
        compinfo: Record "Company Information";
        SendApprovalEditable: Boolean;
        CancelApprovalEditable: Boolean;
        PostEnabled: Boolean;


    procedure UpdateControl()
    begin
        if Status = Status::Open then begin
            DescriptionEditable := true;
            ModeofDisburementEditable := false;
            DocumentNoEditable := false;
            PostingDateEditable := false;
            SourceEditable := true;
            PayingAccountEditable := true;
            ChequeNoEditable := false;
            ChequeNameEditable := false;
            SendApprovalEditable := true;
            CancelApprovalEditable := false;
            PostEnabled := false;
        end;

        if Status = Status::"Pending Approval" then begin
            DescriptionEditable := false;
            ModeofDisburementEditable := false;
            DocumentNoEditable := false;
            PostingDateEditable := false;
            SourceEditable := false;
            PayingAccountEditable := false;
            ChequeNoEditable := false;
            ChequeNameEditable := false;
            SendApprovalEditable := false;
            CancelApprovalEditable := true;
            PostEnabled := false;

        end;

        if Status = Status::Rejected then begin
            DescriptionEditable := false;
            ModeofDisburementEditable := false;
            DocumentNoEditable := false;
            PostingDateEditable := false;
            SourceEditable := false;
            PayingAccountEditable := false;
            ChequeNoEditable := false;
            ChequeNameEditable := false;
            SendApprovalEditable := true;
            CancelApprovalEditable := false;
            PostEnabled := false;
        end;

        if Status = Status::Approved then begin
            DescriptionEditable := false;
            ModeofDisburementEditable := true;
            DocumentNoEditable := true;
            SourceEditable := false;
            PostingDateEditable := true;
            PayingAccountEditable := true;//FALSE;
            ChequeNoEditable := true;
            ChequeNameEditable := true;
            SendApprovalEditable := false;
            CancelApprovalEditable := false;
            PostEnabled := true;

        end;
    end;

    procedure FnSendDisburesmentSMS(LoanNo: Code[20]; AccountNo: Code[20])
    begin
        GenSetUp.Get;
        compinfo.Get;

        //SMS MESSAGE
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Batch No" := "Batch No.";
        SMSMessages."Document No" := LoanNo;
        SMSMessages."Account No" := AccountNo;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        //SMSMessages.Source:='BATCH';
        SMSMessages.Source := 'DISBURSE';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := 'Dear Member,Your Loan has been Approved and posted to your Bank Account,'
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        Cust.Reset;
        Cust.SetRange(Cust."No.", AccountNo);
        if Cust.Find('-') then begin
            SMSMessages."Telephone No" := Cust."Phone No.";
        end;
        if Cust."Phone No." <> '' then
            SMSMessages.Insert;
    end;

    local procedure FnGetMemberBranch(MemberNo: Code[50]): Code[100]
    var
        MemberBranch: Code[100];
    begin
        Cust.Reset;
        Cust.SetRange(Cust."No.", MemberNo);
        if Cust.Find('-') then begin
            MemberBranch := Cust."Global Dimension 2 Code";
        end;
        exit(MemberBranch);
    end;

    trigger OnAfterGetRecord()
    begin
        CurrPage.Editable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin

        if "Batch No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField(SalesSetup."Loans Batch Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Loans Batch Nos", xRec."No. Series", 0D, "Batch No.", "No. Series");
            "Document No." := "Batch No.";
            "Prepared By" := UserId;
            Source := Source::MICRO;
            xRec."Date Created" := Today;

        end;
    end;
}

