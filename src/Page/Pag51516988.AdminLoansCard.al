
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 51516988 AdminLoansCard
{

    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    // SourceTableView = where(Posted = filter(true),
    //  Source = const(FOSA));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Loan  No."; Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff No';

                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Account No';
                    // Editable = MNoEditable;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;

                }
                field("ID NO"; Rec."ID NO")
                {
                    ApplicationArea = Basic;

                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = ApplcDateEditable;

                    // trigger OnValidate()
                    // begin
                    //     TestField(Posted, false);
                    // end;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = LProdTypeEditable;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                    Editable = InstallmentEditable;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic;
                    Editable = Interrest;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = AppliedAmountEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = ApprovedAmountEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Main Sector"; Rec."Main Sector")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Sub-Sector"; Rec."Sub-Sector")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Specific Sector"; Rec."Specific Sector")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = Basic;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    // Editable = LoanStatusEditable;

                    // trigger OnValidate()
                    // begin

                    // end;
                }
                field("Loans Category-SASRA"; Rec."Loans Category-SASRA")
                {
                    ApplicationArea = Basic;
                    Editable = BatchNoEditable;
                    Style = Ambiguous;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;

                }
                field("Total TopUp Commission"; Rec."Total TopUp Commission")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    // Editable = RepayFrequencyEditable;
                }
                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;

                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic;

                }
                field("Transacting Branch"; Rec."Transacting Branch")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field(Posted; Rec.Posted)
                {

                }
                field("Approval Status"; Rec."Approval Status")
                {

                }

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

                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin


                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(51516477, true, false, LoanApp);
                        end;
                    end;
                }
                action("Update Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Update Schedule';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        SurestepFactory: Codeunit "SURESTEP Factory";
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            SurestepFactory.FnGenerateRepaymentSchedule(Rec."Loan  No.");
                        end;
                    end;
                }

                separator(Action4)
                {
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //UpdateControl();
        CurrPage.Editable := false;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //  LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin

        //  CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    begin

    end;

    var
        iEntryNo: Integer;
        VEND1: Record Vendor;
        LoanGuar: Record "Loans Guarantee Details";
        SMSMessage: Record "SMS Messages";
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
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[15];
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
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
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
        LoanG: Record "Loans Register";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "File Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Offset Details";
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loan Disburesment-Batching";
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
        Interrest: Boolean;
        InterestSal: Decimal;
        NetIncome: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        compinfo: Record "Company Information";
        Text002: label 'The Loan has already been approved';
        ApprovalEntries: Record "Approval Entry";
        ApprovalEntry: Record "Approval Entry";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan;
        SFactory: Codeunit "SURESTEP Factory";


    // procedure UpdateControl()
    // begin
    //     if "Loan Status" = "loan status"::Application then begin
    //         MNoEditable := true;
    //         ApplcDateEditable := true;
    //         LoanStatusEditable := false;
    //         LProdTypeEditable := true;
    //         InstallmentEditable := true;
    //         NetIncome := true;
    //         Interrest := false;
    //         AppliedAmountEditable := true;
    //         ApprovedAmountEditable := true;
    //         RepayMethodEditable := true;
    //         RepaymentEditable := true;
    //         BatchNoEditable := false;
    //         RepayFrequencyEditable := true;
    //         ModeofDisburesmentEdit := true;
    //         DisbursementDateEditable := false;
    //     end;

    //     if "Loan Status" = "loan status"::Appraisal then begin
    //         MNoEditable := true;
    //         ApplcDateEditable := true;
    //         LoanStatusEditable := true;
    //         LProdTypeEditable := true;
    //         Interrest := true;
    //         NetIncome := true;
    //         InstallmentEditable := true;
    //         AppliedAmountEditable := true;
    //         ApprovedAmountEditable := true;
    //         RepayMethodEditable := true;
    //         RepaymentEditable := true;
    //         BatchNoEditable := true;
    //         RepayFrequencyEditable := true;
    //         ModeofDisburesmentEdit := true;
    //         DisbursementDateEditable := true;
    //     end;

    //     if "Loan Status" = "loan status"::Rejected then begin
    //         MNoEditable := true;
    //         ApplcDateEditable := true;
    //         LoanStatusEditable := true;
    //         LProdTypeEditable := true;
    //         InstallmentEditable := true;
    //         AppliedAmountEditable := true;
    //         NetIncome := true;
    //         Interrest := true;
    //         ApprovedAmountEditable := true;
    //         RepayMethodEditable := true;
    //         RepaymentEditable := true;
    //         BatchNoEditable := true;
    //         RepayFrequencyEditable := true;
    //         ModeofDisburesmentEdit := true;
    //         DisbursementDateEditable := true;
    //     end;

    //     if "Loan Status" = "loan status"::Approved then begin
    //         MNoEditable := true;
    //         LoanStatusEditable := true;
    //         ApplcDateEditable := true;
    //         Interrest := true;
    //         LProdTypeEditable := true;
    //         NetIncome := true;
    //         InstallmentEditable := true;
    //         AppliedAmountEditable := true;
    //         ApprovedAmountEditable := true;
    //         RepayMethodEditable := true;
    //         RepaymentEditable := true;
    //         BatchNoEditable := true;
    //         RepayFrequencyEditable := true;
    //         ModeofDisburesmentEdit := true;
    //         DisbursementDateEditable := true;
    //     end;
    // end;


    procedure LoanAppPermisions()
    begin
    end;
}

