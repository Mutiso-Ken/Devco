#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516253 "Loans Posted List"
{
    ApplicationArea = Basic;
    CardPageID = "Loans Posted Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Source = filter(BOSA), Posted = const(true));

    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Loan  No."; "Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }

                field("Expected Date of Completion"; "Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Name"; "Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field("BOSA No"; "BOSA No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Unfavorable;
                }

                field("Issued Date"; "Issued Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    visible = false;
                }


                field(Repayment; Repayment)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Principle Repayment"; "Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Interest Repayment"; "Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount"; "Requested Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    visible = false;
                }

                field("Outstanding Balance"; "Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                    Style = Ambiguous;
                }
                field("Oustanding Interest"; "Oustanding Interest")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                    Style = Ambiguous;
                }

                field("Special Loan Amount"; "Special Loan Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Other Commitments Clearance"; "Other Commitments Clearance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Commitements Offset"; "Commitements Offset")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Installments; Installments)
                {
                    ApplicationArea = Basic;
                    Caption = 'Installments';
                    Editable = false;
                }
                field(Interest; Interest)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Status"; "Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Last Pay Date"; "Last Pay Date")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Recovery Mode"; "Recovery Mode")
                {
                    ApplicationArea = Basic;
                    Style = StandardAccent;
                }
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Repayment Start Date"; "Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }

                field("Months in Arrears"; "No of Months in Arrears")
                {
                    ApplicationArea = Basic;
                }
                field("Principal In Arrears"; "Principal In Arrears")
                {
                    ApplicationArea = Basic;
                }
                field("Interest In Arrears"; "Interest In Arrears")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount In Arrears"; "Amount in Arrears")
                {
                    ApplicationArea = Basic;
                }
                field("Loans Status"; "Loans Category-SASRA")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
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
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = Aging;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(50039, true, false, LoanApp);
                        end;
                    end;
                }
                action("Member Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    image = report;
                    PromotedCategory = Process;

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
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

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
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(51516477, true, false, LoanApp);
                        end;
                    end;
                }
                separator(Action8)
                {
                }
                action("View Guarantorship")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Guarantorship';
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(51516205, true, false, LoanApp);
                        end;
                    end;
                }
                separator(Action6)
                {
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

    end;

    var
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
        // GLPosting: Codeunit "Gen. Jnl.-Post Line";
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


    procedure GetVariables(var LoanNo: Code[20]; var LoanProductType: Code[20])
    begin
        LoanNo := "Loan  No.";
        LoanProductType := "Loan Product Type";
    end;


    procedure FormatField(Rec: Record "Loans Register") OK: Boolean
    begin
        if "Outstanding Balance" > 0 then begin
            if (Rec."Expected Date of Completion" < Today) then
                exit(true)
            else
                exit(false);
        end;
    end;


    procedure CalledFrom()
    begin
        Overdue := Overdue::" ";
    end;
}

