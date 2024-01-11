#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516511 "Membership Exit Card"
{
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption';
    SourceTable = "Membership Exist";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No."; "Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = MNoEditable;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closing Date"; "Closing Date")
                {
                    ApplicationArea = Basic;
                    Editable = ClosingDateEditable;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closure Type"; "Closure Type")
                {
                    ApplicationArea = Basic;
                    Editable = ClosureTypeEditable;
                }
                field("Exit Type"; "Exit Type")
                {
                    ApplicationArea = Basic;
                }
                field("Total Loan"; "Total Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Loans';
                    Editable = false;
                }
                field("Total Interest"; "Total Interest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Interest Due';
                    Editable = false;
                }
                field("Member Deposits"; "Member Deposits")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Share Capital"; "Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("FOSA Account No."; "FOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Payee; Payee)
                {
                    ApplicationArea = Basic;
                }
                field("Mode Of Disbursement"; "Mode Of Disbursement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment mode';
                    trigger OnValidate()
                    begin
                        UpdateControl();
                    end;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque No';
                    Enabled = EnableCheque;
                }
                field("Reason For Withdrawal"; "Reason For Withdrawal")
                {
                    ApplicationArea = Basic;
                }
                field("Closed By"; "Closed By")
                {
                    ApplicationArea = Basic;
                }
                field("Closed On"; "Closed On")
                {
                    ApplicationArea = Basic;
                }
                field("Notice Date"; "Notice Date")
                {
                    ApplicationArea = Basic;
                }
                field("Muturity Date"; "Muturity Date")
                {
                    ApplicationArea = Basic;
                }

            }
        }
        area(factboxes)
        {
            part(Control24; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("Member No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Member is  a Guarantor")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin

                        cust.Reset;
                        cust.SetRange(cust."No.", "Member No.");
                        if cust.Find('-') then begin
                            //Report.run(50503, true, false, cust);
                        end;

                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        TESTFIELD("FOSA Account No.");
                        if "Mode Of Disbursement" = "Mode Of Disbursement"::Cheque then begin
                            TestField("Cheque No.");
                        end;
                        if Status <> Status::Open then
                            Error(text001);
                        GenSetUp.Get();
                        //..................Send Withdrawal Approval request
                        //FnSendWithdrawalApplicationSMS();
                        //...................................................
                        Status := Status::Approved;
                        Modify();
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel A&pproval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                    begin
                        if Status <> Status::Open then
                            Error(text001);

                    end;
                }
                action("Account closure Slip")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        cust.Reset;
                        cust.SetRange(cust."No.", "Member No.");
                        if cust.Find('-') then
                            Report.run(51516250, true, false, cust);
                    end;
                }
                action("Post Membership Exit")
                {
                    ApplicationArea = Basic;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                    begin
                        case "Closure Type" of
                            "closure type"::"Member Exit - Normal":
                                FnRunPostNormalExitApplication("Member No.");
                            "closure type"::"Member Exit - Deceased":
                                FnRunPostExitDeceasedApplication("Member No.");
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

    trigger OnAfterGetRecord()
    begin
        UpdateControl();
        ShareCapitalTransferVisible := false;
        ShareCapSellPageVisible := false;
        if "Sell Share Capital" = true then begin
            ShareCapitalTransferVisible := true;
            ShareCapSellPageVisible := true;
        end;

        UpdateControl();
    end;

    trigger OnOpenPage()
    begin
        UpdateControl();
    end;

    var
        Closure: Integer;
        Text001: label 'Not Approved';
        cust: Record Customer;
        UBFRefund: Decimal;
        Generalsetup: Record "Sacco General Set-Up";
        Totalavailable: Decimal;
        UnpaidDividends: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        value2: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Totalrecovered: Decimal;
        Advice: Boolean;
        TotalDefaulterR: Decimal;
        AvailableShares: Decimal;
        Loans: Record "Loans Register";
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        Vendno: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        MNoEditable: Boolean;
        ClosingDateEditable: Boolean;
        ClosureTypeEditable: Boolean;
        PostingDateEditable: Boolean;
        TotalFOSALoan: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[30];
        DBranch: Code[30];
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        "Remaining Amount": Decimal;
        LoansR: Record "Loans Register";
        "AMOUNTTO BE RECOVERED": Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        ClosureR: Record "Membership Exist";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        PTEN: Text;
        DataSheet: Record "Data Sheet Main";
        Customer: Record Customer;
        GenSetUp: Record "Sacco General Set-Up";
        compinfo: Record "Company Information";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        ShareCapitalTransferVisible: Boolean;
        ShareCapSellPageVisible: Boolean;
        // ObjShareCapSell: Record "Share Capital Sell";
        SurestepFactory: Codeunit "SURESTEP Factory";
        JVTransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares";
        JVAccountType: Enum "Gen. Journal Account Type";
        TemplateName: Code[20];
        BatchName: Code[20];
        JVBalAccounttype: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        JVBalAccountNo: Code[20];
        TransferFee: Decimal;
        AvailableBal: Decimal;
        ObjMember: Record Customer;
        VarMemberAvailableAmount: Decimal;
        ObjCust: Record Customer;
        ObjGensetup: Record "Sacco General Set-Up";
        VarWithdrawalFee: Decimal;
        VarTaxonWithdrawalFee: Decimal;
        VarShareCapSellFee: Decimal;
        VarTaxonShareCapSellFee: Decimal;
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        VarShareCapitalFee: Decimal;
        VarShareCapitaltoSell: Decimal;
        EnableCheque: Boolean;

    procedure UpdateControl()
    begin
        if "Mode Of Disbursement" = "Mode Of Disbursement"::Cheque then begin
            EnableCheque := true;
        end else
            if "Mode Of Disbursement" <> "Mode Of Disbursement"::Cheque then begin
                EnableCheque := false;
            end;
        if Status = Status::Open then begin
            MNoEditable := true;
            ClosingDateEditable := false;
            ClosureTypeEditable := true;
            PostingDateEditable := false;
        end;

        if Status = Status::Pending then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            ClosureTypeEditable := false;
            PostingDateEditable := false;
        end;

        if Status = Status::Rejected then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            ClosureTypeEditable := false;
            PostingDateEditable := false;
        end;

        if Status = Status::Approved then begin
            MNoEditable := false;
            ClosingDateEditable := true;
            ClosureTypeEditable := false;
            PostingDateEditable := true;
        end;
    end;


    procedure FnSendWithdrawalApplicationSMS()
    begin

        GenSetUp.Get;
        compinfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := "No.";
        SMSMessage."Document No" := "No.";
        SMSMessage."Account No" := "Member No.";
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBERSHIPWITH';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Membership Withdrawal Application has been received and is being Processed '
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        cust.Reset;
        cust.SetRange(cust."No.", "Member No.");
        if cust.Find('-') then begin
            SMSMessage."Telephone No" := cust."Mobile Phone No";
        end;
        if cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure FnRunPostNormalExitApplication(MemberNo: Code[20])
    Var
        Gnljnline: Record "Gen. Journal Line";
        TotalAmount: Decimal;
        NetMemberAmounts: Decimal;
        Vendor: Record Vendor;
        FOSAAccountBal: Decimal;
        DActivity: code[20];
        DBranch: Code[50];
        Cust: Record customer;
        Generalsetup: Record "Sacco General Set-Up";
        RunningBal: Decimal;
    begin
        IF Cust.get("Member No.") then begin
            if Confirm('Proceed With Account Closure ?', false) = false then begin
                exit;
            end else begin
                //Delete journal line
                Gnljnline.RESET;
                Gnljnline.SETRANGE("Journal Template Name", 'GENERAL');
                Gnljnline.SETRANGE("Journal Batch Name", 'Closure');
                Gnljnline.DELETEALL;
                //End of deletion
                NetMemberAmounts := 0;
                Vendor.Reset();
                Vendor.SetRange(Vendor."No.", "FOSA Account No.");
                Vendor.SetAutoCalcFields(Vendor."FOSA Balance");
                if Vendor.Find('-') then begin
                    FOSAAccountBal := 0;
                    FOSAAccountBal := Vendor."FOSA Balance";
                end;
                //................................................
                DActivity := Cust."Global Dimension 1 Code";
                DBranch := Cust."Global Dimension 2 Code";
                //.................................
                RunningBal := 0;
                RunningBal := "Member Deposits";

                //...........................Recover Loan Interest

                //...........................Recover Loan
                //...........................Post Balance deposit amount to FOSA
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'Closure';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."External Document No." := "No.";
                GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::Vendor;
                GenJournalLine."Account No." := "FOSA Account No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Deposits transferred from withdrawal';
                GenJournalLine.Amount := -RunningBal;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;
                //...............................................
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'Closure';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."External Document No." := "No.";
                GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::Customer;
                GenJournalLine."Account No." := "Member No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Deposits transferred to FOSA withdrawal';
                GenJournalLine.Amount := RunningBal;
                GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;
                //.......................................................
                ///Saundry Income
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'Closure';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."External Document No." := "No.";
                GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::Vendor;
                GenJournalLine."Account No." := "FOSA Account No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Membership Withdrawal Fee';
                GenJournalLine.Amount := (RunningBal * 4 / 100);
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                GenJournalLine."Bal. Account No." := '5534';
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;
                ///Excise Duty
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'Closure';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."External Document No." := "No.";
                GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::Vendor;
                GenJournalLine."Account No." := "FOSA Account No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Excise Duty on Membership Withdrawal Fee';
                GenJournalLine.Amount := ((RunningBal * 4 / 100) * (20 / 100));
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                GenJournalLine."Bal. Account No." := '3326';
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;
                ///Transfer fee
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'Closure';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."External Document No." := "No.";
                GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::Vendor;
                GenJournalLine."Account No." := "FOSA Account No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Transfer fee';
                GenJournalLine.Amount := 100;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                GenJournalLine."Bal. Account No." := '5421';
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;
                ///Excise Duty
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'Closure';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."External Document No." := "No.";
                GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::Vendor;
                GenJournalLine."Account No." := "FOSA Account No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Excise Duty on Transfer fee';
                GenJournalLine.Amount := (100 * (20 / 100));
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                GenJournalLine."Bal. Account No." := '3326';
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;
            end;
            //............................Post Lines
            GenJournalLine.RESET;
            GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
            GenJournalLine.SETRANGE("Journal Batch Name", 'Closure');
            IF GenJournalLine.FIND('-') THEN BEGIN
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                //Exit Member
                Cust.Reset();
                cust.SETRANGE(cust."No.", "Member No.");
                IF cust.FIND('-') THEN BEGIN
                    cust.Status := cust.Status::Withdrawal;
                    cust.Blocked := cust.Blocked::All;
                    if cust.Modify(true) then begin
                        //Send SMS Alert To member on exiting
                        //Send Email
                        //............Close Records
                        Posted := true;
                        "Closed By" := UserId;
                        "Closing Date" := Today;
                        "Branch Code" := Cust."Global Dimension 2 Code";
                        "Closed On" := Today;
                        Status := Status::Closed;
                        Modify(true);
                        Message('Member Account Closure was successful');
                        CurrPage.Close();
                    end;
                END;
            end;
        END;
    END;

    local procedure FnRunPostExitDeceasedApplication(MemberNo: Code[20])
    Var
        Gnljnline: Record "Gen. Journal Line";
        TotalAmount: Decimal;
        NetMemberAmounts: Decimal;
        Vendor: Record Vendor;
        FOSAAccountBal: Decimal;
        DActivity: code[20];
        DBranch: Code[50];
        Cust: Record customer;
        Generalsetup: Record "Sacco General Set-Up";
        RunningBal: Decimal;
    begin
        IF Cust.get("Member No.") then begin
            if Confirm('Proceed With Account Closure ?', false) = false then begin
                exit;
            end else begin
                //Delete journal line
                Gnljnline.RESET;
                Gnljnline.SETRANGE("Journal Template Name", 'GENERAL');
                Gnljnline.SETRANGE("Journal Batch Name", 'Closure');
                Gnljnline.DELETEALL;
                //End of deletion
                NetMemberAmounts := 0;
                Vendor.Reset();
                Vendor.SetRange(Vendor."No.", "FOSA Account No.");
                Vendor.SetAutoCalcFields(Vendor."FOSA Balance");
                if Vendor.Find('-') then begin
                    FOSAAccountBal := 0;
                    FOSAAccountBal := Vendor."FOSA Balance";
                end;
                //................................................
                DActivity := Cust."Global Dimension 1 Code";
                DBranch := Cust."Global Dimension 2 Code";
                //.................................
                RunningBal := 0;
                RunningBal := "Member Deposits";

                //...........................Recover Loan Interest

                //...........................Recover Loan
                //...........................Post Balance deposit amount to FOSA
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'Closure';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."External Document No." := "No.";
                GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::Vendor;
                GenJournalLine."Account No." := "FOSA Account No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Deposits transferred from withdrawal(deceased member)';
                GenJournalLine.Amount := -RunningBal;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;
                //...............................................
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'Closure';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."External Document No." := "No.";
                GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::Customer;
                GenJournalLine."Account No." := "Member No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Deposits transferred to FOSA withdrawal(member deceased)';
                GenJournalLine.Amount := RunningBal;
                GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;
                //.......................................................
                ///Saundry Income
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'Closure';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."External Document No." := "No.";
                GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::Vendor;
                GenJournalLine."Account No." := "FOSA Account No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Membership Withdrawal Fee';
                GenJournalLine.Amount := (RunningBal * 4 / 100);
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                GenJournalLine."Bal. Account No." := '5534';
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;
                ///Excise Duty
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'Closure';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."External Document No." := "No.";
                GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::Vendor;
                GenJournalLine."Account No." := "FOSA Account No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Excise Duty on Membership Withdrawal Fee';
                GenJournalLine.Amount := ((RunningBal * 4 / 100) * (20 / 100));
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                GenJournalLine."Bal. Account No." := '3326';
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;
                ///Transfer fee
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'Closure';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."External Document No." := "No.";
                GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::Vendor;
                GenJournalLine."Account No." := "FOSA Account No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Transfer fee';
                GenJournalLine.Amount := 100;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                GenJournalLine."Bal. Account No." := '5421';
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;
                ///Excise Duty
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'Closure';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."External Document No." := "No.";
                GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::Vendor;
                GenJournalLine."Account No." := "FOSA Account No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Excise Duty on Transfer fee';
                GenJournalLine.Amount := (100 * (20 / 100));
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                GenJournalLine."Bal. Account No." := '3326';
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;
            end;
            //............................Post Lines
            GenJournalLine.RESET;
            GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
            GenJournalLine.SETRANGE("Journal Batch Name", 'Closure');
            IF GenJournalLine.FIND('-') THEN BEGIN
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                //Exit Member
                Cust.Reset();
                cust.SETRANGE(cust."No.", "Member No.");
                IF cust.FIND('-') THEN BEGIN
                    cust.Status := cust.Status::Deceased;
                    cust.Blocked := cust.Blocked::All;
                    if cust.Modify(true) then begin
                        //Send SMS Alert To member on exiting
                        //Send Email
                        //............Close Records
                        Posted := true;
                        "Closed By" := UserId;
                        "Closing Date" := Today;
                        "Branch Code" := Cust."Global Dimension 2 Code";
                        "Closed On" := Today;
                        Status := Status::Closed;
                        Modify(true);
                        Message('Member Account Closure was successful');
                        CurrPage.Close();
                    end;
                END;
            end;
        END;
    END;


    //......................................

}

