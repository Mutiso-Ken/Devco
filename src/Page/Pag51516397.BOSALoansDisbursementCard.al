#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516397 "BOSA Loans Disbursement Card"
{
    DeleteAllowed = false;
    // Editable = false;
    ModifyAllowed = false;
    PageType = Card;
    InsertAllowed = false;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Source = const(BOSA),
                            Posted = const(false));

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
                    Caption = 'Member No';
                    Editable = MNoEditable;
                    ShowMandatory = true;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                    Style = StrongAccent;
                }
                field("Client Name"; "Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Member Deposits"; "Member Deposits")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    Editable = LProdTypeEditable;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin

                    end;
                }
                field(Installments; Installments)
                {
                    ApplicationArea = Basic;
                    Editable = InstallmentEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field(Interest; Interest)
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                    Caption = 'Interest Rate';
                }
                field("Requested Amount"; "Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = AppliedAmountEditable;
                    ShowMandatory = true;
                    Style = Strong;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = false;
                    ShowMandatory = true;


                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Main Sector"; "Main Sector")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Style = Ambiguous;
                    Editable = MNoEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Sub-Sector"; "Sub-Sector")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Style = Ambiguous;
                    Editable = MNoEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Specific Sector"; "Specific Sector")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Style = Ambiguous;
                    Editable = MNoEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = MNoEditable;
                    Visible = true;
                }
                field("Repayment Method"; "Repayment Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Principle Repayment"; "Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Interest Repayment"; "Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Repayment; Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Status"; "Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        UpdateControl();
                    end;
                }
                field("Approval Status"; "Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Repayment Frequency"; "Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = RepayFrequencyEditable;
                    Style = StrongAccent;
                    ShowMandatory = true;
                }
                field("Recovery Mode"; "Recovery Mode")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    ShowMandatory = true;
                    Editable = MNoEditable;
                    OptionCaption = 'Checkoff,Standing Order,Salary,Pension,Direct Debits,Tea,Milk,Tea Bonus,Dividend,Christmas';
                }
                field("Mode of Disbursement"; "Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = MNoEditable;
                    ShowMandatory = true;
                }
                field("Paying Bank Account No"; "Paying Bank Account No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Batch No."; "Batch No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Editable = MNoEditable;
                    Style = StrongAccent;
                    ShowMandatory = true;
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
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000004; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
                Editable = MNoEditable;
            }
            part(Control1000000005; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                SubPageLink = "Loan No" = field("Loan  No.");
                Editable = MNoEditable;
            }
            part(Control1000000002; "Loan Appraisal Salary Details")
            {
                Caption = 'Salary Details';
                Editable = MNoEditable;
                SubPageLink = "Loan No" = field("Loan  No."),
                              "Client Code" = field("Client Code");
            }

        }
        area(factboxes)
        {
            part("Member Statistics FactBox"; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                action("POST")
                {
                    Caption = 'POST LOAN';
                    Enabled = true;

                    Image = PrepaymentPostPrint;
                    PromotedIsBig = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        If FnCanPostLoans(UserId) = false then begin
                            Error('Prohibited ! You are not allowed to POST this Loan');
                        end;
                        // if "Mode of Disbursement" <> "Mode of Disbursement"::Cheque then begin
                        //     Error('Prohibited ! Mode of disbursement cannot be ' + Format("Mode of Disbursement"));
                        // end;
                        if Posted = true then begin
                            Error('Prohibited ! The loan is already Posted');
                        end;
                        if "Loan Status" <> "Loan Status"::Approved then begin
                            Error('Prohibited ! The loan is Status MUST be Approved');
                        end;
                        if Confirm('Are you sure you want to POST Loan Approved amount of Ksh. ' + Format("Approved Amount") + ' to member -' + Format("Client Name") + ' ?', false) = false then begin
                            exit;
                        end else begin
                            TemplateName := 'GENERAL';
                            BatchName := 'LOANS';
                            FnInsertBOSALines();


                            GenJournalLine.RESET;
                            GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
                            GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
                            if GenJournalLine.Find('-') then begin
                                // CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
                                FnSendNotifications();//Send Notifications
                                "Loan Status" := "Loan Status"::Issued;
                                Posted := true;
                                "Posted By" := UserId;
                                "Posting Date" := Today;
                                "Issued Date" := "Loan Disbursement Date";
                                "Approval Status" := "Approval Status"::Approved;
                                "Loans Category-SASRA" := "Loans Category-SASRA"::Perfoming;
                                Modify();
                                //...................Recover Overdraft Loan On Loan
                                SFactory.FnRecoverOnLoanOverdrafts("Client Code");
                                //.................................................
                                Message('Loan has successfully been posted and member notified');
                                CurrPage.close();
                            end;

                        end;
                    end;
                }

                action("Send Approvals")
                {
                    Caption = 'Send For Approval';
                    Visible = false;
                    Enabled = (not OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist AND (not RecordApproved);

                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        FnCheckForTestFields();
                        if Confirm('Send Approval Request For Loan Application of Ksh. ' + Format("Approved Amount") + ' applied by ' + Format("Client Name") + ' ?', false) = false then begin
                            exit;
                        end else begin
                            SrestepApprovalsCodeUnit.SendLoanApplicationsRequestForApproval(rec."Loan  No.", Rec);
                            FnSendLoanApprovalNotifications();
                            CurrPage.close();
                        end;
                    end;
                }
                action("Cancel Approvals")
                {
                    Caption = 'Cancel For Approval';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    visible = false;
                    trigger OnAction()
                    begin
                        if Confirm('Cancel Approval?', false) = false then begin
                            exit;
                        end else begin
                            SrestepApprovalsCodeUnit.CancelLoanApplicationsRequestForApproval(rec."Loan  No.", Rec);
                            CurrPage.Close();
                        end;
                    end;
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if ("Repayment Start Date" = 0D) then
                            Error('Please enter Disbursement Date to continue');

                        SFactory.FnGenerateRepaymentSchedule("Loan  No.");

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(51516477, true, false, LoanApp);
                        end;
                    end;
                }
                action("Loans to Offset")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans to Offset';
                    //Enabled = (not OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist AND (not RecordApproved);
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(REC.RecordId);//Return No and allow sending of approval request.

        EnabledApprovalWorkflowsExist := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        LoansR.Reset;
        LoansR.SetRange(LoansR.Posted, false);
        LoansR.SetRange(LoansR."Captured By", UserId);
        if LoansR."Client Name" = '' then begin
            if LoansR.Count > 1 then begin
                if Confirm('There are still some Unused Loan Nos. Continue?', false) = false then begin
                    Error('There are still some Unused Loan Nos. Please utilise them first');
                end;
            end;
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Source := Source::BOSA;
        "Mode of Disbursement" := "mode of disbursement"::Cheque;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin


    end;

    trigger OnOpenPage()
    begin
        SetRange(Posted, false);

    end;

    var
        VarAmounttoDisburse: Decimal;
        LoanGuar: Record "Loans Guarantee Details";
        SMSMessages: Record "SMS Messages";
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
        //  Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
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
        SMSMessage: Record "SMS Messages";
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
        Text001: label 'Status Must Be Open';
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","FOSA Opening","Loan Batching",Leave,"Imprest Requisition","Imprest Surrender","Stores Requisition","Funds Transfer","Change Request","Staff Claims","BOSA Transfer","Loan Tranche","Loan TopUp","Memb Opening","Member Withdrawal";
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
        Table_id: Integer;
        Doc_No: Code[20];
        PepeaShares: Decimal;
        SaccoDeposits: Decimal;
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        compinfo: Record "Company Information";
        iEntryNo: Integer;
        eMAIL: Text;
        "Telephone No": Integer;
        Text002: label 'The Loan has already been approved';
        LoanSecurities: Integer;
        EditableField: Boolean;
        SFactory: Codeunit "SURESTEP Factory";
        OpenApprovalEntriesExist: Boolean;
        TemplateName: Code[50];
        BatchName: Code[50];

        EnabledApprovalWorkflowsExist: Boolean;
        RecordApproved: Boolean;
        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
        CanCancelApprovalForRecord: Boolean;


    procedure UpdateControl()
    begin

        if "Loan Status" = "loan status"::Application then begin
            RecordApproved := false;
            MNoEditable := true;
            ApplcDateEditable := false;
            LoanStatusEditable := true;
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
            CanCancelApprovalForRecord := false;

        end;

        if "Loan Status" = "loan status"::Appraisal then begin
            RecordApproved := true;
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
            CanCancelApprovalForRecord := true;
        end;

        if "Loan Status" = "loan status"::Rejected then begin
            RecordApproved := true;
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
            RejectionRemarkEditable := false;
            CanCancelApprovalForRecord := false;
        end;

        if "Approval Status" = "approval status"::Approved then begin
            RecordApproved := true;
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
            RecordApproved := true;
            CanCancelApprovalForRecord := false;
        end;
    end;


    procedure LoanAppPermisions()
    begin
    end;


    procedure SendSMS()
    begin


        GenSetUp.Get;
        compinfo.Get;


        if GenSetUp."Send SMS Notifications" = true then begin


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
            SMSMessage."Batch No" := "Batch No.";
            SMSMessage."Document No" := "Loan  No.";
            SMSMessage."Account No" := "Account No";
            SMSMessage."Date Entered" := Today;
            SMSMessage."Time Entered" := Time;
            SMSMessage.Source := 'LOANS';
            SMSMessage."Entered By" := UserId;
            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
            SMSMessage."SMS Message" := 'Your Loan Application of amount ' + Format("Requested Amount") + ' for ' +
            "Client Code" + ' ' + "Client Name" + ' has been received and is being Processed ' + compinfo.Name + ' ' + GenSetUp."Customer Care No";
            Cust.Reset;
            Cust.SetRange(Cust."No.", "Client Code");
            if Cust.Find('-') then begin
                SMSMessage."Telephone No" := Cust."Mobile Phone No";
            end;
            SMSMessage.Insert;

        end;
    end;


    procedure SendMail()
    begin
        GenSetUp.Get;

        if Cust.Get(LoanApps."Client Code") then begin
            eMAIL := Cust."E-Mail (Personal)";
        end;

        if GenSetUp."Send Email Notifications" = true then begin

            Notification.CreateMessage('Dynamics NAV', GenSetUp."Sender Address", eMAIL, 'Loan Receipt Notification',
                            'Loan application ' + LoanApps."Loan  No." + ' , ' + LoanApps."Loan Product Type" + ' has been received and is being processed'
                           + ' (Dynamics NAV ERP)', true, false);

            Notification.Send;

        end;
    end;

    local procedure FnCheckForTestFields()
    var
        LoanType: Record "Loan Products Setup";
        LoanGuarantors: Record "Loans Guarantee Details";
    begin
        //--------------------
        if "Approval Status" = "Approval Status"::Approved then begin
            Error('The loan has already been approved');
        end;
        if "Approval Status" <> "Approval Status"::Open then begin
            Error('Approval status MUST be Open');
        end;
        TestField("Requested Amount");
        TestField("Main Sector");
        TestField("Sub-Sector");
        TestField("Specific Sector");
        TestField("Loan Product Type");
        TestField("Mode of Disbursement");
        //----------------------
        if LoanType.get("Loan Product Type") then begin
            if LoanType."Appraise Guarantors" = true then begin
                LoanGuarantors.Reset();
                LoanGuarantors.SetRange(LoanGuarantors."Loan No", "Loan  No.");
                if LoanGuarantors.find('-') then begin
                    Error('Please Insert Loan Applicant Guarantor Details!');
                end;
            end;
        end;
    end;

    local procedure FnSendLoanApprovalNotifications()
    var
    begin
        //...........................Notify Loaner
        SMSMessages.RESET;
        IF SMSMessages.FIND('+') THEN BEGIN
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        END
        ELSE BEGIN
            iEntryNo := 1;
        END;

        SMSMessages.RESET;
        SMSMessages.INIT;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Account No" := "Client Code";
        SMSMessages."Date Entered" := TODAY;
        SMSMessages."Time Entered" := TIME;
        SMSMessages.Source := 'LOAN APPL';
        SMSMessages."Entered By" := USERID;
        SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
        SMSMessages."SMS Message" := 'Your loan application of KSHs.' + FORMAT("Requested Amount") +
                                  ' has been received. Devco Sacco Ltd.';
        Cust.RESET;
        IF Cust.GET("Client Code") THEN
            if Cust."Mobile Phone No" <> '' then begin
                SMSMessages."Telephone No" := Cust."Mobile Phone No";
            end else
                if (Cust."Mobile Phone No" = '') and (Cust."Mobile Phone No." <> '') then begin
                    SMSMessages."Telephone No" := Cust."Mobile Phone No.";
                end;
        SMSMessages.INSERT;
        //.......................................Notify Guarantors
        LoanGuar.RESET;
        LoanGuar.SETRANGE(LoanGuar."Loan No", "Loan  No.");
        IF LoanGuar.FIND('-') THEN BEGIN
            REPEAT

                Cust.RESET;
                Cust.SETRANGE(Cust."No.", LoanGuar."Member No");
                IF Cust.FIND('-') THEN BEGIN
                    SMSMessages.RESET;
                    IF SMSMessages.FIND('+') THEN BEGIN
                        iEntryNo := SMSMessages."Entry No";
                        iEntryNo := iEntryNo + 1;
                    END
                    ELSE BEGIN
                        iEntryNo := 1;
                    END;

                    SMSMessages.INIT;
                    SMSMessages."Entry No" := iEntryNo;
                    SMSMessages."Account No" := LoanGuar."Member No";
                    SMSMessages."Date Entered" := TODAY;
                    SMSMessages."Time Entered" := TIME;
                    SMSMessages.Source := 'LOAN GUARANTORS';
                    SMSMessages."Entered By" := USERID;
                    SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
                    IF LoanApp.GET(LoanGuar."Loan No") THEN
                        SMSMessages."SMS Message" := 'You have guaranteed an amount of ' + FORMAT(LoanGuar."Amont Guaranteed")
                        + ' to ' + "Client Name" + '  ' +
                        'Loan Type ' + "Loan Product Type" + ' ' + 'of ' + FORMAT("Requested Amount") + ' at Devco Sacco Ltd. Call 0726050260 if in dispute';
                    ;
                    SMSMessages."Telephone No" := Cust."Phone No.";
                    SMSMessages.INSERT;
                END;
            UNTIL LoanGuar.NEXT = 0;
        END;
    end;

    local procedure FnMemberHasAnExistingLoanSameProduct(): Boolean
    var
        LoansReg: Record "Loans Register";
        Balance: Decimal;
    begin
        Balance := 0;
        LoansReg.Reset();
        LoansReg.SetRange(LoansReg."Client Code", "Client Code");
        LoansReg.SetRange(LoansReg."Loan Product Type", "Loan Product Type");
        LoansReg.SetRange(LoansReg.Posted, true);
        LoansReg.SetAutoCalcFields(LoansReg."Outstanding Balance", LoansReg."Oustanding Interest");
        if LoansReg.Find('-') then begin
            repeat
                Balance += LoansReg."Outstanding Balance" + LoansReg."Oustanding Interest";
            until LoansReg.Next = 0;
        end;
        if Balance > 0 then begin
            exit(true)
        end else
            if Balance <= 0 then begin
                exit(false);
            end;
    end;

    local procedure FnGetProductOutstandingBal(): Decimal
    var
        LoansReg: Record "Loans Register";
        Balance: Decimal;
    begin
        Balance := 0;
        LoansReg.Reset();
        LoansReg.SetRange(LoansReg."Client Code", "Client Code");
        LoansReg.SetRange(LoansReg."Loan Product Type", "Loan Product Type");
        LoansReg.SetRange(LoansReg.Posted, true);
        LoansReg.SetAutoCalcFields(LoansReg."Outstanding Balance", LoansReg."Oustanding Interest");
        if LoansReg.Find('-') then begin
            repeat
                Balance += LoansReg."Outstanding Balance" + LoansReg."Oustanding Interest";
            until LoansReg.Next = 0;
        end;
        exit(Balance);
    end;

    local procedure FnInsertBOSALines()
    var
        EndMonth: Date;
        RemainingDays: Integer;
        TMonthDays: Integer;
        Sfactorycode: Codeunit "SURESTEP Factory";
    begin
        //--------------------Generate Schedule
        Sfactorycode.FnGenerateRepaymentSchedule("Loan  No.");
        VarAmounttoDisburse := "Approved Amount";
        //....................PRORATED DAYS
        EndMonth := CALCDATE('-1D', CALCDATE('1M', DMY2DATE(1, DATE2DMY(Today, 2), DATE2DMY(Today, 3))));
        RemainingDays := (EndMonth - Today) + 1;
        TMonthDays := DATE2DMY(EndMonth, 1);
        //....................Ensure that If Batch doesnt exist then create
        IF NOT GenBatch.GET(TemplateName, BatchName) THEN BEGIN
            GenBatch.INIT;
            GenBatch."Journal Template Name" := TemplateName;
            GenBatch.Name := BatchName;
            GenBatch.INSERT;
        END;
        //....................Reset General Journal Lines
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
        GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
        GenJournalLine.DELETEALL;
        //....................Loan Posting Lines
        GenSetUp.GET;
        DActivity := '';
        DBranch := '';
        IF Cust.GET(LoanApps."Client Code") THEN BEGIN
            DActivity := Cust."Global Dimension 1 Code";
            DBranch := Cust."Global Dimension 2 Code";
        END;
        //**************Loan Principal Posting**********************************
        LineNo := LineNo + 10000;
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := "Client Code";
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Document No." := "Loan  No.";
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'Loan Principle Amount' + Format("Loan  No.");
        GenJournalLine.Amount := "Amount Disburse";
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Loan;
        GenJournalLine."Loan No" := "Loan  No.";
        GenJournalLine."Group Code" := "Group Code";
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        IF GenJournalLine.Amount <> 0 THEN
            GenJournalLine.INSERT;

        //--------------------------------RECOVER OVERDRAFT()-------------------------------------------------------
        //Code Here
        //***************************Loan Product Charges code
        PCharges.Reset();
        PCharges.SETRANGE(PCharges."Product Code", "Loan Product Type");
        IF PCharges.FIND('-') THEN BEGIN
            REPEAT
                PCharges.TESTFIELD(PCharges."G/L Account");
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := TemplateName;
                GenJournalLine."Journal Batch Name" := BatchName;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                GenJournalLine."Account No." := PCharges."G/L Account";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No." := "Loan  No.";
                GenJournalLine."External Document No." := "Loan  No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := PCharges.Description + '-' + Format("Loan  No.");
                IF PCharges."Use Perc" = TRUE THEN BEGIN
                    GenJournalLine.Amount := ("Approved Amount" * (PCharges.Percentage / 100)) * -1
                END ELSE
                    IF PCharges."Use Perc" = false then begin
                        GenJournalLine.Amount := PCharges.Amount * -1;
                    end;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                GenJournalLine."Bal. Account No." := PCharges."Balancing Account";
                GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;
            UNTIL PCharges.NEXT = 0;
        END;

        //...................Cater for Loan Offset Now !
        CalcFields("Top Up Amount");
        if "Top Up Amount" > 0 then begin
            LoanTopUp.RESET;
            LoanTopUp.SETRANGE(LoanTopUp."Loan No.", "Loan  No.");
            IF LoanTopUp.FIND('-') THEN BEGIN
                REPEAT//Maybe there are multiple topup loans
                    //Principle
                    LineNo := LineNo + 10000;
                    GenJournalLine.INIT;
                    GenJournalLine."Journal Template Name" := TemplateName;
                    GenJournalLine."Journal Batch Name" := BatchName;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Loan  No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine."External Document No." := "Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                    GenJournalLine."Account No." := "Client Code";
                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Loan OffSet By - ' + "Loan  No.";
                    GenJournalLine.Amount := LoanTopUp."Principle Top Up" * -1;
                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Repayment;
                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    IF GenJournalLine.Amount <> 0 THEN
                        GenJournalLine.INSERT;

                    //..................Recover Interest On Top Up
                    LineNo := LineNo + 10000;
                    GenJournalLine.INIT;
                    GenJournalLine."Journal Template Name" := TemplateName;
                    GenJournalLine."Journal Batch Name" := BatchName;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::Customer;
                    GenJournalLine."Account No." := "Client Code";
                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := "Loan  No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Interest Due Paid on top up';
                    GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                    GenJournalLine."External Document No." := "Loan  No.";
                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Interest Paid";
                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    IF GenJournalLine.Amount <> 0 THEN
                        GenJournalLine.INSERT;
                    VarAmounttoDisburse := VarAmounttoDisburse - LoanTopUp."Outstanding Balance";
                UNTIL LoanTopUp.NEXT = 0;
            END;
        end;
        //If there is top up commission charged write it here start
        //If there is top up commission charged write it here end
        //end of code


        //------------------------------------2. CREDIT MEMBER BANK A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, "Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ",
        GenJournalLine."Account Type"::"Bank Account", LoanApps."Paying Bank Account No", LoanApps."Loan Disbursement Date", VarAmounttoDisburse * -1, 'BOSA', LoanApps."Loan  No.",
        'Loan Disbursement - ' + LoanApps."Loan Product Type" + ' - ' + LoanApps."Loan  No.", '');
    end;



    local procedure FnSendNotifications()
    var
        msg: Text[250];
        PhoneNo: Text[250];
    begin
        LoansR.Reset();
        LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
        if LoansR.Find('-') then begin
            msg := '';
            msg := 'Dear Member, Your ' + Format(LoansR."Loan Product Type") + ' loan application of KSHs.' + Format("Requested Amount") + ' has been processed and it will be deposited to your Bank Account.';
            PhoneNo := FnGetPhoneNo("Client Code");
            SendSMSMessage("Client Code", msg, PhoneNo);
        end;
    end;

    local procedure SendSMSMessage(BOSANo: Code[20]; msg: Text[250]; PhoneNo: Text[250])
    begin
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        //--------------------------------------------------
        SMSMessages.Reset;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Account No" := BOSANo;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'MOBILETRAN';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := msg;
        SMSMessages."Telephone No" := PhoneNo;
        SMSMessages.Insert;
    end;

    local procedure FnGetPhoneNo(ClientCode: Code[50]): Text[250]
    var
        Member: Record Customer;
        Vendor: Record Vendor;
    begin
        Member.Reset();
        Member.SetRange(Member."No.", ClientCode);
        if Member.Find('-') = true then begin
            if (Member."Mobile Phone No." <> '') and (Member."Mobile Phone No." <> '0') then begin
                exit(Member."Mobile Phone No.");
            end;
            if (Member."Mobile Phone No" <> '') and (Member."Mobile Phone No" <> '0') then begin
                exit(Member."Mobile Phone No");
            end;
            if (Member."Phone No." <> '') and (Member."Phone No." <> '0') then begin
                exit(Member."Phone No.");
            end;
            Vendor.Reset();
            Vendor.SetRange(Vendor."BOSA Account No", ClientCode);
            if Vendor.Find('-') then begin
                if (Vendor."Mobile Phone No." <> '') or (Vendor."Mobile Phone No." <> '0') then begin
                    exit(Vendor."Mobile Phone No.");
                end;
                if (Vendor."Mobile Phone No" <> '') or (Vendor."Mobile Phone No" <> '0') then begin
                    exit(Vendor."Mobile Phone No");
                end;
                if (Vendor."MPESA Mobile No" <> '') or (Vendor."MPESA Mobile No" <> '0') then begin
                    exit(Vendor."MPESA Mobile No");
                end;
            end;

        end else
            if Member.find('-') = false then begin
                Vendor.Reset();
                Vendor.SetRange(Vendor."BOSA Account No", ClientCode);
                if Vendor.Find('-') then begin
                    if (Vendor."Mobile Phone No." <> '') or (Vendor."Mobile Phone No." <> '0') then begin
                        exit(Vendor."Mobile Phone No.");
                    end;
                    if (Vendor."Mobile Phone No" <> '') or (Vendor."Mobile Phone No" <> '0') then begin
                        exit(Vendor."Mobile Phone No");
                    end;
                    if (Vendor."MPESA Mobile No" <> '') or (Vendor."MPESA Mobile No" <> '0') then begin
                        exit(Vendor."MPESA Mobile No");
                    end;
                end;
            end;
    end;

    local procedure FnCanPostLoans(UserId: Text): Boolean
    var
        UserSetUp: Record "User Setup";
    begin
        if UserSetUp.get(UserId) then begin
            if UserSetUp."Can POST Loans" = true then begin
                exit(true);
            end;
        end;
        exit(false);
    end;
}

