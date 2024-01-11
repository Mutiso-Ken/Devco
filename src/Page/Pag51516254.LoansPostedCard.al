#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516254 "Loans Posted Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Source = filter(BOSA),
                            Posted = const(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Loan  No."; "Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member';
                    Editable = MNoEditable;
                    Style = StrongAccent;

                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                    Style = StrongAccent;
                    Visible = false;
                }
                field("Client Name"; "Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;

                }
                field("ID NO"; "ID NO")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                    Visible = false;
                }
                field("Member Deposits"; "Member Deposits")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                }
                field("Staff No"; "Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff No';
                    Editable = false;
                    Visible = false;

                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = LProdTypeEditable;
                    Style = StrongAccent;
                }
                field("Requested Amount"; "Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = AppliedAmountEditable;
                    Style = Unfavorable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }

                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = ApplcDateEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }

                field(Installments; Installments)
                {
                    ApplicationArea = Basic;
                    Editable = InstallmentEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Approved Repayment"; "Approved Repayment")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Interest; Interest)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Recommended Amount"; "Recommended Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = ApprovedAmountEditable;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Repayment Method"; "Repayment Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field(Repayment; Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = RepaymentEditable;
                }

                field("Loan Principle Repayment"; "Loan Principle Repayment")
                {

                }

                field("Loan Interest Repayment"; "Loan Interest Repayment")
                {

                }
                field("Outstanding Balance"; "Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                }
                field("Oustanding Interest"; "Oustanding Interest")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                }
                field("Principal In Arrears"; "Principal In Arrears")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                }
                field("Interest In Arrears"; "Interest In Arrears")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                }

                field("Appeal Amount"; "Appeal Amount")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Appeal Date"; "Appeal Date")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Loan Purpose"; "Loan Purpose")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;

                }

                field("Loan Status"; "Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = LoanStatusEditable;

                    trigger OnValidate()
                    begin
                        UpdateControl();


                    end;
                }
                field("Batch No."; "Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = BatchNoEditable;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Top Up Amount"; "Top Up Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bridged Amount';
                }
                field("Repayment Frequency"; "Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = RepayFrequencyEditable;
                }
                field("Mode of Disbursement"; "Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = ModeofDisburesmentEdit;
                }
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;


                    trigger OnValidate()
                    begin
                        if StrLen("Cheque No.") > 6 then
                            Error('Document No. cannot contain More than 6 Characters.');
                    end;
                }
                field("Repayment Start Date"; "Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Date of Completion"; "Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("External EFT"; "External EFT")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Approval Status"; "Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("partially Bridged"; "partially Bridged")
                {
                    ApplicationArea = Basic;

                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Total TopUp Commission"; "Total TopUp Commission")
                {
                    ApplicationArea = Basic;
                }
                field("Rejection  Remark"; "Rejection  Remark")
                {
                    ApplicationArea = Basic;
                    Editable = RejectionRemarkEditable;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1000000002; "Loan Appraisal Salary Details")
            {
                Caption = 'Salary Details';
                SubPageLink = "Loan No" = field("Loan  No."),
                              "Client Code" = field("Client Code");
            }
            part(Control1000000004; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control1000000005; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                Caption = 'Loan';
                Image = AnalysisView;
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = Aging;
                    Promoted = true;
                    visible = false;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(51516244, true, false, LoanApp);
                        end;
                    end;
                }
                action("Member Page")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Page';
                    Image = Planning;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Account Card";
                    RunPageLink = "No." = field("BOSA No");
                }
                action("Member Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "process";
                    Image = report;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "Client Code");
                        Report.Run(51516223, true, false, Cust);
                    end;
                }
                action("Loan Statement")
                {
                    ApplicationArea = Basic;
                    Image = Report2;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = process;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "Client Code");
                        Cust.SetFilter(Cust."Loan Product Filter", "Loan Product Type");
                        Cust.SetFilter(Cust."Loan No. Filter", "Loan  No.");
                        Report.Run(51516609, true, false, Cust);
                    end;
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = "process";
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        if not Posted then
                            SFactory.FnGenerateRepaymentSchedule("Loan  No.");

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(51516477, true, false, LoanApp);
                        end;
                    end;
                }
                action("Appeal Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Top Up Loan';
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page "Loan Appeal Application BOSA";
                    // RunPageLink = "Loan  No."=field("Loan  No.");
                    ShortCutKey = 'Ctrl+F7';
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.","Loan  No.");
                        IF LoanApp.FIND('-') THEN
                        REPORT.RUN(51516264,TRUE,FALSE,LoanApp);
                        */

                    end;
                }
                action("Assign Appeal Batch No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Assign Appeal Batch No.';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F7';
                    visible = false;

                    trigger OnAction()
                    begin
                        /*LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.","Loan  No.");
                        IF LoanApp.FIND('-') THEN
                        REPORT.RUN(51516290,TRUE,FALSE,LoanApp);
                        */

                    end;
                }
                separator(Action1102755012)
                {
                }
                action("Loans to Offset")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans to Offset';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Payroll Employee List";
                    // RunPageLink = Field1=field("Loan  No."),
                    //               Field3=field("Client Code");
                }
                separator(Action1102760039)
                {
                }
                action("Post Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Loan';
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Posted = true then
                            Error('Loan already posted.');


                        "Loan Disbursement Date" := Today;
                        TestField("Loan Disbursement Date");
                        "Posting Date" := "Loan Disbursement Date";


                        if Confirm('Are you sure you want to post this loan?', true) = false then
                            exit;

                        /*//PRORATED DAYS
                        EndMonth:=CALCDATE('-1D',CALCDATE('1M',DMY2DATE(1,DATE2DMY("Posting Date",2),DATE2DMY("Posting Date",3))));
                        RemainingDays:=(EndMonth-"Posting Date")+1;
                        TMonthDays:=DATE2DMY(EndMonth,1);
                        //PRORATED DAYS
                        
                        */
                        // if "Mode of Disbursement" = "mode of disbursement"::"Bank Transfer" then begin

                        //     GenJournalLine.Reset;
                        //     GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        //     GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        //     GenJournalLine.DeleteAll;


                        //     GenSetUp.Get();

                        //     DActivity := 'BOSA';
                        //     DBranch := '';//PKKS'NAIROBI';
                        //     LoanApps.Reset;
                        //     LoanApps.SetRange(LoanApps."Loan  No.", "Loan  No.");
                        //     LoanApps.SetRange(LoanApps."System Created", false);
                        //     LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
                        //     if LoanApps.Find('-') then begin
                        //         repeat
                        //             LoanApps.CalcFields(LoanApps."Special Loan Amount");
                        //             DActivity := '';
                        //             DBranch := '';
                        //             if Vend.Get(LoanApps."Client Code") then begin
                        //                 DActivity := Vend."Global Dimension 1 Code";
                        //                 DBranch := Vend."Global Dimension 2 Code";
                        //             end;

                        //             LoanDisbAmount := LoanApps."Approved Amount";

                        //             if (LoanApps."Special Loan Amount" > 0) and (LoanApps."Bridging Loan Posted" = false) then
                        //                 Error('Bridging Loans must be posted before the loans are disbursed. ' + LoanApps."Loan  No.");

                        //             TCharges := 0;
                        //             TopUpComm := 0;
                        //             TotalTopupComm := 0;


                        //             if LoanApps."Loan Status" <> LoanApps."loan status"::Approved then
                        //                 Error('Loan status must be Approved for you to post Loan. - ' + LoanApps."Loan  No.");

                        //             if LoanApps.Posted = true then
                        //                 Error('Loan has already been posted. - ' + LoanApps."Loan  No.");


                        //             LoanApps.CalcFields(LoanApps."Top Up Amount");


                        //             RunningDate := "Posting Date";


                        //             //Generate and post Approved Loan Amount
                        //             if not GenBatch.Get('PAYMENTS', 'LOANS') then begin
                        //                 GenBatch.Init;
                        //                 GenBatch."Journal Template Name" := 'PAYMENTS';
                        //                 GenBatch.Name := 'LOANS';
                        //                 GenBatch.Insert;
                        //             end;

                        //             PCharges.Reset;
                        //             PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                        //             if PCharges.Find('-') then begin
                        //                 repeat
                        //                     PCharges.TestField(PCharges."G/L Account");

                        //                     LineNo := LineNo + 10000;

                        //                     GenJournalLine.Init;
                        //                     GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        //                     GenJournalLine."Journal Batch Name" := 'LOANS';
                        //                     GenJournalLine."Line No." := LineNo;
                        //                     GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        //                     GenJournalLine."Account No." := PCharges."G/L Account";
                        //                     GenJournalLine.Validate(GenJournalLine."Account No.");
                        //                     GenJournalLine."Document No." := "Loan  No.";
                        //                     GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        //                     GenJournalLine."Posting Date" := "Posting Date";
                        //                     GenJournalLine.Description := PCharges.Description;
                        //                     if PCharges."Use Perc" = true then begin
                        //                         GenJournalLine.Amount := (LoanDisbAmount * PCharges.Percentage / 100) * -1;
                        //                     end else begin
                        //                         GenJournalLine.Amount := PCharges.Amount * -1;

                        //                     end;


                        //                     GenJournalLine.Validate(GenJournalLine.Amount);
                        //                     //Don't top up charges on principle
                        //                     GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                        //                     GenJournalLine."Bal. Account No." := LoanApps."Account No";
                        //                     //Don't top up charges on principle
                        //                     GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        //                     GenJournalLine.Validate(GenJournalLine.Amount);
                        //                     GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        //                     GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        //                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        //                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        //                     if GenJournalLine.Amount <> 0 then
                        //                         GenJournalLine.Insert;

                        //                     TCharges := TCharges + (GenJournalLine.Amount * -1);


                        //                 until PCharges.Next = 0;
                        //             end;




                        //             //Don't top up charges on principle
                        //             TCharges := 0;

                        //             LineNo := LineNo + 10000;

                        //             GenJournalLine.Init;
                        //             GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        //             GenJournalLine."Journal Batch Name" := 'LOANS';
                        //             GenJournalLine."Line No." := LineNo;
                        //             GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                        //             GenJournalLine."Account No." := "Client Code";
                        //             GenJournalLine.Validate(GenJournalLine."Account No.");
                        //             GenJournalLine."Document No." := "Loan  No.";
                        //             GenJournalLine."External Document No." := "ID NO";
                        //             GenJournalLine."Posting Date" := "Posting Date";
                        //             GenJournalLine.Description := 'Principal Amount';
                        //             GenJournalLine.Amount := LoanDisbAmount + TCharges;
                        //             GenJournalLine.Validate(GenJournalLine.Amount);
                        //             GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                        //             GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        //             GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        //             GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        //             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        //             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        //             if GenJournalLine.Amount <> 0 then
                        //                 GenJournalLine.Insert;




                        //             if LoanType.Get(LoanApps."Loan Product Type") then begin
                        //                 if LoanApps."Top Up Amount" > 0 then begin
                        //                     LoanTopUp.Reset;
                        //                     LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                        //                     if LoanTopUp.Find('-') then begin
                        //                         repeat
                        //                             //Principle
                        //                             LineNo := LineNo + 10000;
                        //                             GenJournalLine.Init;
                        //                             GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        //                             GenJournalLine."Journal Batch Name" := 'LOANS';
                        //                             GenJournalLine."Line No." := LineNo;
                        //                             GenJournalLine."Document No." := "Loan  No.";
                        //                             GenJournalLine."Posting Date" := "Posting Date";
                        //                             GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        //                             GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                        //                             GenJournalLine."Account No." := LoanApps."Client Code";
                        //                             GenJournalLine.Validate(GenJournalLine."Account No.");
                        //                             GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                        //                             GenJournalLine.Amount := LoanTopUp."Principle Top Up" * -1;
                        //                             GenJournalLine.Validate(GenJournalLine.Amount);
                        //                             GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                        //                             GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                        //                             GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        //                             GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        //                             //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                        //                             //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                        //                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        //                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        //                             if GenJournalLine.Amount <> 0 then
                        //                                 GenJournalLine.Insert;
                        //                             //Principle
                        //                             LineNo := LineNo + 10000;
                        //                             GenJournalLine.Init;
                        //                             GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        //                             GenJournalLine."Journal Batch Name" := 'LOANS';
                        //                             GenJournalLine."Line No." := LineNo;
                        //                             GenJournalLine."Document No." := "Loan  No.";
                        //                             GenJournalLine."Posting Date" := "Posting Date";
                        //                             GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        //                             GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        //                             GenJournalLine."Account No." := LoanApps."Account No";
                        //                             GenJournalLine.Validate(GenJournalLine."Account No.");
                        //                             GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                        //                             GenJournalLine.Amount := LoanTopUp."Principle Top Up";
                        //                             GenJournalLine.Validate(GenJournalLine.Amount);
                        //                             GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                        //                             GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                        //                             GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        //                             GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        //                             //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                        //                             //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                        //                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        //                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        //                             if GenJournalLine.Amount <> 0 then
                        //                                 GenJournalLine.Insert;


                        //                             //Interest (Reversed if top up)
                        //                             if LoanType.Get(LoanApps."Loan Product Type") then begin
                        //                                 LineNo := LineNo + 10000;
                        //                                 GenJournalLine.Init;
                        //                                 GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        //                                 GenJournalLine."Journal Batch Name" := 'LOANS';
                        //                                 GenJournalLine."Line No." := LineNo;
                        //                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                        //                                 GenJournalLine."Account No." := LoanApps."Client Code";
                        //                                 GenJournalLine.Validate(GenJournalLine."Account No.");
                        //                                 GenJournalLine."Document No." := "Loan  No.";
                        //                                 GenJournalLine."Posting Date" := "Posting Date";
                        //                                 GenJournalLine.Description := 'Interest paid ' + LoanApps."Loan  No.";
                        //                                 GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                        //                                 GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        //                                 GenJournalLine.Validate(GenJournalLine.Amount);
                        //                                 GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        //                                 GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                        //                                 GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                        //                                 GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        //                                 GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        //                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        //                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        //                                 if GenJournalLine.Amount <> 0 then
                        //                                     GenJournalLine.Insert;


                        //                             end;
                        //                             if LoanType.Get(LoanApps."Loan Product Type") then begin
                        //                                 LineNo := LineNo + 10000;
                        //                                 GenJournalLine.Init;
                        //                                 GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        //                                 GenJournalLine."Journal Batch Name" := 'LOANS';
                        //                                 GenJournalLine."Line No." := LineNo;
                        //                                 GenJournalLine.Validate(GenJournalLine."Account No.");
                        //                                 GenJournalLine."Document No." := "Loan  No.";
                        //                                 GenJournalLine."Posting Date" := "Posting Date";
                        //                                 GenJournalLine.Description := 'Interest paid ' + LoanApps."Loan  No.";
                        //                                 GenJournalLine.Amount := LoanTopUp."Interest Top Up";
                        //                                 GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        //                                 GenJournalLine.Validate(GenJournalLine.Amount);
                        //                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        //                                 GenJournalLine."Account No." := LoanApps."Account No";
                        //                                 GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        //                                 GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                        //                                 GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                        //                                 GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        //                                 GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        //                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        //                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        //                                 if GenJournalLine.Amount <> 0 then
                        //                                     GenJournalLine.Insert;


                        //                             end;

                        //                             //Commision
                        //                             if LoanType.Get(LoanApps."Loan Product Type") then begin
                        //                                 if LoanType."Top Up Commision" > 0 then begin
                        //                                     LineNo := LineNo + 10000;
                        //                                     GenJournalLine.Init;
                        //                                     GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        //                                     GenJournalLine."Journal Batch Name" := 'LOANS';
                        //                                     GenJournalLine."Line No." := LineNo;
                        //                                     GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        //                                     GenJournalLine."Account No." := LoanApps."Account No";

                        //                                     GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        //                                     GenJournalLine."Bal. Account No." := LoanType."Top Up Commision Account";
                        //                                     GenJournalLine.Validate(GenJournalLine."Account No.");
                        //                                     GenJournalLine."Document No." := "Loan  No.";
                        //                                     GenJournalLine."Posting Date" := "Posting Date";
                        //                                     GenJournalLine.Description := 'Commision on Loan Top Up';
                        //                                     TopUpComm := (LoanTopUp."Principle Top Up") * (LoanType."Top Up Commision" / 100);
                        //                                     TotalTopupComm := TotalTopupComm + TopUpComm;
                        //                                     GenJournalLine.Amount := TopUpComm * -1;
                        //                                     GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        //                                     GenJournalLine.Validate(GenJournalLine.Amount);
                        //                                     GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        //                                     GenJournalLine."Shortcut Dimension 2 Code" := DBranch;

                        //                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        //                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        //                                     if GenJournalLine.Amount <> 0 then
                        //                                         GenJournalLine.Insert;

                        //                                 end;
                        //                             end;
                        //                         until LoanTopUp.Next = 0;
                        //                     end;
                        //                 end;
                        //             end;

                        //             BatchTopUpAmount := BatchTopUpAmount + LoanApps."Top Up Amount";
                        //             BatchTopUpComm := BatchTopUpComm + TotalTopupComm;
                        //         until LoanApps.Next = 0;
                        //     end;

                        //     LineNo := LineNo + 10000;
                        //     GenJournalLine.Init;
                        //     GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        //     GenJournalLine."Journal Batch Name" := 'LOANS';
                        //     GenJournalLine."Line No." := LineNo;
                        //     GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        //     GenJournalLine."Account No." := LoanApps."Account No";
                        //     GenJournalLine.Validate(GenJournalLine."Account No.");
                        //     GenJournalLine."Document No." := "Loan  No.";
                        //     GenJournalLine."External Document No." := "ID NO";
                        //     GenJournalLine."Posting Date" := "Posting Date";
                        //     GenJournalLine.Description := 'Principal Amount';
                        //     GenJournalLine.Amount := (LoanApps."Approved Amount") * -1;
                        //     GenJournalLine.Validate(GenJournalLine.Amount);
                        //     GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        //     GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        //     if GenJournalLine.Amount <> 0 then
                        //         GenJournalLine.Insert;
                        // end;



                        // if "Mode of Disbursement" = "mode of disbursement"::Cheque then begin

                        //     GenJournalLine.Reset;
                        //     GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        //     GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        //     GenJournalLine.DeleteAll;


                        //     GenSetUp.Get();

                        //     DActivity := 'BOSA';
                        //     DBranch := '';//PKKS'NAIROBI';
                        //     LoanApps.Reset;
                        //     LoanApps.SetRange(LoanApps."Loan  No.", "Loan  No.");
                        //     LoanApps.SetRange(LoanApps."System Created", false);
                        //     LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
                        //     if LoanApps.Find('-') then begin
                        //         repeat
                        //             LoanApps.CalcFields(LoanApps."Special Loan Amount");



                        //             DActivity := '';
                        //             DBranch := '';
                        //             if Vend.Get(LoanApps."Client Code") then begin
                        //                 DActivity := Vend."Global Dimension 1 Code";
                        //                 DBranch := Vend."Global Dimension 2 Code";
                        //             end;



                        //             LoanDisbAmount := LoanApps."Approved Amount";

                        //             if (LoanApps."Special Loan Amount" > 0) and (LoanApps."Bridging Loan Posted" = false) then
                        //                 Error('Bridging Loans must be posted before the loans are disbursed. ' + LoanApps."Loan  No.");

                        //             TCharges := 0;
                        //             TopUpComm := 0;
                        //             TotalTopupComm := 0;


                        //             if LoanApps."Loan Status" <> LoanApps."loan status"::Approved then
                        //                 Error('Loan status must be Approved for you to post Loan. - ' + LoanApps."Loan  No.");

                        //             if LoanApps.Posted = true then
                        //                 Error('Loan has already been posted. - ' + LoanApps."Loan  No.");


                        //             LoanApps.CalcFields(LoanApps."Top Up Amount");


                        //             RunningDate := "Posting Date";


                        //             //Generate and post Approved Loan Amount
                        //             if not GenBatch.Get('PAYMENTS', 'LOANS') then begin
                        //                 GenBatch.Init;
                        //                 GenBatch."Journal Template Name" := 'PAYMENTS';
                        //                 GenBatch.Name := 'LOANS';
                        //                 GenBatch.Insert;
                        //             end;

                        //             PCharges.Reset;
                        //             PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                        //             if PCharges.Find('-') then begin
                        //                 repeat
                        //                     PCharges.TestField(PCharges."G/L Account");

                        //                     LineNo := LineNo + 10000;

                        //                     GenJournalLine.Init;
                        //                     GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        //                     GenJournalLine."Journal Batch Name" := 'LOANS';
                        //                     GenJournalLine."Line No." := LineNo;
                        //                     GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        //                     GenJournalLine."Account No." := PCharges."G/L Account";
                        //                     GenJournalLine.Validate(GenJournalLine."Account No.");
                        //                     GenJournalLine."Document No." := "Loan  No.";
                        //                     GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        //                     GenJournalLine."Posting Date" := "Posting Date";
                        //                     GenJournalLine.Description := PCharges.Description;
                        //                     if PCharges."Use Perc" = true then begin
                        //                         GenJournalLine.Amount := (LoanDisbAmount * PCharges.Percentage / 100) * -1;
                        //                     end else begin
                        //                         GenJournalLine.Amount := PCharges.Amount * -1;

                        //                     end;


                        //                     GenJournalLine.Validate(GenJournalLine.Amount);
                        //                     //Don't top up charges on principle
                        //                     //Don't top up charges on principle
                        //                     GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        //                     GenJournalLine.Validate(GenJournalLine.Amount);
                        //                     GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        //                     GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        //                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        //                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        //                     if GenJournalLine.Amount <> 0 then
                        //                         GenJournalLine.Insert;

                        //                     TCharges := TCharges + (GenJournalLine.Amount * -1);


                        //                 until PCharges.Next = 0;
                        //             end;




                        //             //Don't top up charges on principle
                        //             TCharges := 0;

                        //             LineNo := LineNo + 10000;

                        //             GenJournalLine.Init;
                        //             GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        //             GenJournalLine."Journal Batch Name" := 'LOANS';
                        //             GenJournalLine."Line No." := LineNo;
                        //             GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                        //             GenJournalLine."Account No." := "Client Code";
                        //             GenJournalLine.Validate(GenJournalLine."Account No.");
                        //             GenJournalLine."Document No." := "Loan  No.";
                        //             GenJournalLine."External Document No." := "ID NO";
                        //             GenJournalLine."Posting Date" := "Posting Date";
                        //             GenJournalLine.Description := 'Principal Amount';
                        //             GenJournalLine.Amount := LoanDisbAmount + TCharges;
                        //             GenJournalLine.Validate(GenJournalLine.Amount);
                        //             GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                        //             GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        //             GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        //             GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        //             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        //             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        //             if GenJournalLine.Amount <> 0 then
                        //                 GenJournalLine.Insert;




                        //             if LoanType.Get(LoanApps."Loan Product Type") then begin
                        //                 if LoanApps."Top Up Amount" > 0 then begin
                        //                     LoanTopUp.Reset;
                        //                     LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                        //                     if LoanTopUp.Find('-') then begin
                        //                         repeat
                        //                             //Principle
                        //                             LineNo := LineNo + 10000;
                        //                             GenJournalLine.Init;
                        //                             GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        //                             GenJournalLine."Journal Batch Name" := 'LOANS';
                        //                             GenJournalLine."Line No." := LineNo;
                        //                             GenJournalLine."Document No." := "Loan  No.";
                        //                             GenJournalLine."Posting Date" := "Posting Date";
                        //                             GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        //                             GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                        //                             GenJournalLine."Account No." := LoanApps."Client Code";
                        //                             GenJournalLine.Validate(GenJournalLine."Account No.");
                        //                             GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                        //                             GenJournalLine.Amount := LoanTopUp."Principle Top Up" * -1;
                        //                             GenJournalLine.Validate(GenJournalLine.Amount);
                        //                             GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                        //                             GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                        //                             GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        //                             GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        //                             // GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                        //                             //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                        //                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        //                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        //                             if GenJournalLine.Amount <> 0 then
                        //                                 GenJournalLine.Insert;


                        //                             //Interest (Reversed if top up)
                        //                             if LoanType.Get(LoanApps."Loan Product Type") then begin
                        //                                 LineNo := LineNo + 10000;
                        //                                 GenJournalLine.Init;
                        //                                 GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        //                                 GenJournalLine."Journal Batch Name" := 'LOANS';
                        //                                 GenJournalLine."Line No." := LineNo;
                        //                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                        //                                 GenJournalLine."Account No." := LoanApps."Client Code";
                        //                                 GenJournalLine.Validate(GenJournalLine."Account No.");
                        //                                 GenJournalLine."Document No." := "Loan  No.";
                        //                                 GenJournalLine."Posting Date" := "Posting Date";
                        //                                 GenJournalLine.Description := 'Interestpaid ' + LoanApps."Loan  No.";
                        //                                 GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                        //                                 GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        //                                 GenJournalLine.Validate(GenJournalLine.Amount);
                        //                                 //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                        //                                 //GenJournalLine."Bal. Account No.":=LoanType."Receivable Interest Account";
                        //                                 GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        //                                 GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                        //                                 GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                        //                                 GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        //                                 GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        //                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        //                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        //                                 if GenJournalLine.Amount <> 0 then
                        //                                     GenJournalLine.Insert;


                        //                             end;

                        //                             //Commision
                        //                             if LoanType.Get(LoanApps."Loan Product Type") then begin
                        //                                 if LoanType."Top Up Commision" > 0 then begin
                        //                                     LineNo := LineNo + 10000;
                        //                                     GenJournalLine.Init;
                        //                                     GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        //                                     GenJournalLine."Journal Batch Name" := 'LOANS';
                        //                                     GenJournalLine."Line No." := LineNo;
                        //                                     GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        //                                     GenJournalLine."Account No." := LoanType."Top Up Commision Account";
                        //                                     GenJournalLine.Validate(GenJournalLine."Account No.");
                        //                                     GenJournalLine."Document No." := "Loan  No.";
                        //                                     GenJournalLine."Posting Date" := "Posting Date";
                        //                                     GenJournalLine.Description := 'Commision on Loan Top Up';
                        //                                     TopUpComm := (LoanTopUp."Principle Top Up") * (LoanType."Top Up Commision" / 100);
                        //                                     TotalTopupComm := TotalTopupComm + TopUpComm;
                        //                                     GenJournalLine.Amount := TopUpComm * -1;
                        //                                     GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        //                                     GenJournalLine.Validate(GenJournalLine.Amount);
                        //                                     GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        //                                     GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        //                                     //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                        //                                     //GenJournalLine."Bal. Account No.":=LoanApps."Account No";

                        //                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        //                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        //                                     if GenJournalLine.Amount <> 0 then
                        //                                         GenJournalLine.Insert;

                        //                                 end;
                        //                             end;
                        //                         until LoanTopUp.Next = 0;
                        //                     end;
                        //                 end;
                        //             end;

                        //             BatchTopUpAmount := BatchTopUpAmount + LoanApps."Top Up Amount";
                        //             BatchTopUpComm := BatchTopUpComm + TotalTopupComm;
                        //         until LoanApps.Next = 0;
                        //     end;

                        //     LineNo := LineNo + 10000;
                        //     /*Disbursement.RESET;
                        //     Disbursement.SETRANGE(Disbursement."Loan Number","Loan  No.");
                        //     Disbursement.SETRANGE(Disbursement."Disbursement Date","Loan Disbursement Date");
                        //     IF Disbursement.FIND('-') THEN BEGIN
                        //     REPEAT
                        //     Disbursement.Posted:=TRUE;
                        //     Disbursement.MODIFY;
                        //     GenJournalLine.INIT;
                        //     GenJournalLine."Journal Template Name":='PAYMENTS';
                        //     GenJournalLine."Journal Batch Name":='LOANS';
                        //     GenJournalLine."Line No.":=LineNo;
                        //     GenJournalLine."Account Type":=Disbursement."Disbursement Account Type";
                        //     GenJournalLine."Account No.":=Disbursement."Disbursement Account No.";
                        //     GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        //     GenJournalLine."Document No.":="Loan  No.";
                        //     GenJournalLine."External Document No.":="ID NO";
                        //     GenJournalLine."Posting Date":="Posting Date";
                        //     GenJournalLine.Description:='Principal Amount';
                        //     GenJournalLine.Amount:=((LoanApps."Approved Amount")-(BatchTopUpAmount+BatchTopUpComm+TCharges))*-1;
                        //     GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        //     GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        //     GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        //     GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                        //     GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                        //     IF GenJournalLine.Amount<>0 THEN
                        //     GenJournalLine.INSERT;
                        //     UNTIL Disbursement.NEXT=0;
                        //     END;*/
                        // end;



                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        if GenJournalLine.Find('-') then begin
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            ;
                        end;

                        //Post New

                        Posted := true;
                        Modify;



                        Message('Loan posted successfully.');

                        //Post

                        LoanAppPermisions()
                        //CurrForm.EDITABLE:=TRUE;
                        //end;

                    end;
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    visible = false;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        /*
                        LBatches.RESET;
                        LBatches.SETRANGE(LBatches."Loan  No.","Loan  No.");
                        IF LBatches.FIND('-') THEN BEGIN
                            ApprovalEntries.SetRecordFilters(DATABASE::Loans,17,LBatches."Loan  No.");
                              ApprovalEntries.RUN;
                        END;
                        */

                        DocumentType := Documenttype::Loan;
                        ApprovalEntries.SetRecordFilters(Database::"Absence Preferences", DocumentType, "Loan  No.");
                        ApprovalEntries.Run;

                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    visible = false;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                    //ApprovalMgt: Codeunit "Export F/O Consolidation";
                    begin
                        /*
                       SalDetails.RESET;
                       SalDetails.SETRANGE(SalDetails."Loan No","Loan  No.");
                       IF SalDetails.FIND('-')=FALSE THEN BEGIN
                       ERROR('Please Insert Loan Applicant Salary Information');
                       END;
                          */
                        if "Loan Product Type" <> 'SDV' then begin
                            LGuarantors.Reset;
                            LGuarantors.SetRange(LGuarantors."Loan No", "Loan  No.");
                            if LGuarantors.Find('-') = false then begin
                                Error('Please Insert Loan Applicant Guarantor Information');
                            end;
                        end;
                        //TESTFIELD("Approved Amount");
                        TestField("Loan Product Type");
                        TestField("Mode of Disbursement");

                        /*
                  IF "Mode of Disbursement"="Mode of Disbursement"::Cheque THEN
                  ERROR('Mode of disbursment cannot be cheque, all loans are disbursed through FOSA')

                  ELSE IF  ("Mode of Disbursement"="Mode of Disbursement"::"Bank Transfer") AND
                   ("Account No"='') THEN
                   ERROR('Member has no FOSA Savings Account linked to loan thus no means of disbursing the loan,')

                  ELSE IF  (Source=Source::BOSA) AND ("Mode of Disbursement"="Mode of Disbursement"::"FOSA Loans")  THEN
                   ERROR('This is not a FOSA loan thus select correct mode of disbursement')

                  ELSE IF ("Mode of Disbursement"="Mode of Disbursement"::" ")THEN
                  ERROR('Kindly specify mode of disbursement');
                            */


                        /*
                        RSchedule.RESET;
                        RSchedule.SETRANGE(RSchedule."Loan No.","Loan  No.");
                        IF NOT RSchedule.FIND('-') THEN
                        ERROR('Loan Schedule must be generated and confirmed before loan is attached to batch');
                          */

                        /*
                        LBatches.RESET;
                        LBatches.SETRANGE(LBatches."Loan  No.","Loan  No.");
                        IF LBatches.FIND('-') THEN BEGIN
                           IF LBatches."Approval Status"<>LBatches."Approval Status"::Open THEN
                              ERROR(Text001);
                        END;
                        */
                        //End allocate batch number
                        //ApprovalMgt.SendLoanApprRequest(LBatches);
                        //ApprovalMgt.SendLoanApprRequest(Rec);
                        /* LGuarantors.RESET;
                         LGuarantors.SETRANGE(LGuarantors."Loan No","Loan  No.");
                         IF LGuarantors.FINDFIRST THEN BEGIN
                         REPEAT
                         IF Cust.GET(LGuarantors."Member No") THEN
                         IF  Cust."Mobile Phone No"<>'' THEN
                         Sms.SendSms('Guarantors' ,Cust."Mobile Phone No",'You have guaranteed '+ "Client Name" + ' ' + "Loan Product Type" +' of KES. '+FORMAT("Approved Amount")+
                         '. Call 0720000000 if in dispute. Ekeza Sacco.',Cust."No.");
                         UNTIL LGuarantors.NEXT =0;
                         END
                          */

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    visible = false;
                    trigger OnAction()
                    var
                    // ApprovalMgt: Codeunit "Export F/O Consolidation";
                    begin
                        //ApprovalMgt.SendLoanApprRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Source := Source::BOSA;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        /*IF "Loan Status"="Loan Status"::Approved THEN
        CurrPage.EDITABLE:=FALSE; */

    end;

    trigger OnOpenPage()
    begin
        SetRange(Posted, true);
        /*IF "Loan Status"="Loan Status"::Approved THEN
        CurrPage.EDITABLE:=FALSE;*/

    end;

    var
        Text001: label 'Status Must Be Open';
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
        //Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
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
        GenSetUp: Record "Sales & Receivables Setup";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        LoansR: Record "Loans Register";
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
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Special Clearance";
        SMSMessage: Record Customer;
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record "Loan Disburesment-Batching";
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
        CurrpageEditable: Boolean;
        LoanStatusEditable: Boolean;
        MNoEditable: Boolean;
        ApplcDateEditable: Boolean;
        LProdTypeEditable: Boolean;
        InstallmentEditable: Boolean;
        AppliedAmountEditable: Boolean;
        ApprovedAmountEditable: Boolean;
        RepayMethodEditable: Boolean;
        RepaymentEditable: Boolean;
        BatchNoEditable: Boolean;
        RepayFrequencyEditable: Boolean;
        ModeofDisburesmentEdit: Boolean;
        DisbursementDateEditable: Boolean;
        AccountNoEditable: Boolean;
        LNBalance: Decimal;
        ApprovalEntries: Record "Approval Entry";
        RejectionRemarkEditable: Boolean;
        ApprovalEntry: Record "Approval Entry";
        Overdue: Option Yes," ";
        SFactory: Codeunit "SURESTEP Factory";


    procedure UpdateControl()
    begin

        if "Loan Status" = "loan status"::Application then begin
            MNoEditable := true;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := true;
            InstallmentEditable := true;
            AppliedAmountEditable := true;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := true;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
        end;

        if "Loan Status" = "loan status"::Appraisal then begin
            MNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
        end;

        if "Loan Status" = "loan status"::Rejected then begin
            MNoEditable := false;
            AccountNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := false;
            DisbursementDateEditable := false;
            RejectionRemarkEditable := false
        end;

        if "Approval Status" = "approval status"::Approved then begin
            MNoEditable := false;
            AccountNoEditable := false;
            LoanStatusEditable := false;
            ApplcDateEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := true;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := true;
            RejectionRemarkEditable := false;
        end;
    end;


    procedure LoanAppPermisions()
    begin
    end;
}

