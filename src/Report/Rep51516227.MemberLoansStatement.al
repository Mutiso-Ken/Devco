#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516227 "Member Loans Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/MemberLoansStatement.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Loan Product Filter", "Outstanding Balance";
            column(Payroll_Staff_No; "Payroll/Staff No")
            {
            }
            column(Employer_Name; "Employer Name")
            {
            }
            column(PayrollStaffNo_Members; Customer."Payroll/Staff No")
            {
            }
            column(No_Members; Customer."No.")
            {
            }
            column(MobilePhoneNo_MembersRegister; Customer."Mobile Phone No")
            {
            }
            column(Name_Members; Customer.Name)
            {
            }
            column(EmployerCode_Members; Customer."Employer Code")
            {
            }
            column(EmployerName; EmployerName)
            {
            }
            column(PageNo_Members; CurrReport.PageNo)
            {
            }
            column(Shares_Retained; Customer."Shares Retained")
            {
            }
            column(ShareCapBF; ShareCapBF)
            {
            }
            column(IDNo_Members; Customer."ID No.")
            {
            }
            column(GlobalDimension2Code_Members; Customer."Global Dimension 2 Code")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Phone; Company."Phone No.")
            {
            }
            column(Company_SMS; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }

            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Client Code" = field("No."), "Loan Product Type" = field("Loan Product Filter"), "Date filter" = field("Date Filter");
                DataItemTableView = sorting("Loan  No.") where(Posted = const(true), "Loan  No." = filter(<> ''));
                ;

                column(PrincipleBF; PrincipleBF)
                {
                }
                column(Outstanding_Balance; "Outstanding Balance")
                {
                }
                column(Oustanding_Interest; "Oustanding Interest")
                {
                }
                column(LoanNumber; Loans."Loan  No.")
                {
                }
                column(ProductType; LoanName)
                {
                }
                column(RequestedAmount; Loans."Requested Amount")
                {
                }
                column(Interest; Loans.Interest)
                {
                }
                column(Installments; Loans.Installments)
                {
                }
                column(LoanPrincipleRepayment; Loans."Loan Principle Repayment")
                {
                }
                column(ApprovedAmount_Loans; Loans."Approved Amount")
                {
                }
                column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
                {
                }
                column(Repayment_Loans; Loans.Repayment)
                {
                }
                column(ModeofDisbursement_Loans; Loans."Mode of Disbursement")
                {
                }
                dataitem(loan; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("Client Code"), "Loan No" = field("Loan  No."), "Posting Date" = field("Date filter");
                    DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter(Loan | Repayment), "Loan No" = filter(<> ''), Reversed = filter(false));
                    column(PostingDate_loan; loan."Posting Date")
                    {
                    }
                    column(DocumentNo_loan; loan."Document No.")
                    {
                    }
                    column(Description_loan; loan.Description)
                    {
                    }
                    column(DebitAmount_Loan; loan."Debit Amount")
                    {
                    }
                    column(CreditAmount_Loan; loan."Credit Amount")
                    {
                    }
                    column(Amount_Loan; RunningBal)
                    {
                    }
                    column(openBalance_loan; OpenBalanceLoan)
                    {
                    }
                    column(CLosingBalance_loan; ClosingBalanceLoan)
                    {
                    }
                    column(TransactionType_loan; loan."Transaction Type")
                    {
                    }
                    column(LoanNo; loan."Loan No")
                    {
                    }
                    column(PrincipleBF_loans; PrincipleBF)
                    {
                    }
                    column(LoanType_loan; loan."Loan Type")
                    {
                    }
                    column(Loan_Description; loan.Description)
                    {
                    }
                    column(BalAccountNo_loan; loan."Bal. Account No.")
                    {
                    }
                    column(BankCodeLoan; BankCodeLoan)
                    {
                    }
                    column(User7; loan."User ID")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        BankCodeLoan := GetBankCode(loan);
                        //.................................
                        if loan."Amount Posted" < 0 then begin
                            loan."Credit Amount" := (loan."Amount Posted" * -1);
                        end else
                            if loan."Amount Posted" > 0 then begin
                                loan."Debit Amount" := (loan."Amount Posted");
                            end;
                        //....................................Get Balance Ya corner
                        RunningBal := RunningBal + loan."Amount Posted";
                    end;

                    trigger OnPreDataItem()
                    begin
                        ClosingBalanceLoan := PrincipleBF;
                        OpenBalanceLoan := PrincipleBF;
                        OpeningBalInt := InterestBF;
                    end;
                }
                dataitem(Interests; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("Client Code"), "Loan No" = field("Loan  No."), "Posting Date" = field("Date filter");
                    DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter("Interest Due" | "Interest Paid"), "Loan No" = filter(<> ''), Reversed = filter(false));

                    column(PostingDate_Interest; Interests."Posting Date")
                    {
                    }

                    column(DocumentNo_Interest; Interests."Document No.")
                    {
                    }
                    column(Description_Interest; Interests.Description)
                    {
                    }
                    column(DebitAmount_Interest; Interests."Debit Amount")
                    {
                    }
                    column(CreditAmount_Interest; Interests."Credit Amount")
                    {
                    }
                    column(Amount_Interest; runningInt)
                    {
                    }
                    column(OpeningBalInt; OpeningBalInt)
                    {
                    }
                    column(ClosingBalInt; ClosingBalInt)
                    {
                    }
                    column(TransactionType_Interest; Interests."Transaction Type")
                    {
                    }
                    column(LoanNo_Interest; Interests."Loan No")
                    {
                    }
                    column(InterestBF; InterestBF)
                    {
                    }
                    column(BalAccountNo_Interest; Interests."Bal. Account No.")
                    {
                    }
                    column(BankCodeInterest; BankCodeInterest)
                    {
                    }
                    column(User8; Interests."User ID")
                    {
                    }
                    column(LoanNo_ApprovedAMount; ApprovedAmount_Interest)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        ClosingBalInt := ClosingBalInt + Interests.Amount;
                        BankCodeInterest := GetBankCode(Interests);
                        //...................Get TotalInterestDue
                        ApprovedAmount_Interest := 0;

                        LonRepaymentSchedule.Reset();
                        LonRepaymentSchedule.SetRange(LonRepaymentSchedule."Loan No.", Interests."Loan No");
                        if LoansR.find('-') then begin
                            repeat
                                ApprovedAmount_Interest += LonRepaymentSchedule."Monthly Interest";
                            until LonRepaymentSchedule.Next = 0;
                        end;
                        //..................
                        if Interests."Amount Posted" < 0 then begin
                            Interests."Credit Amount" := (Interests."Amount Posted" * -1);
                        end else
                            if Interests."Amount Posted" > 0 then begin
                                Interests."Debit Amount" := (Interests."Amount Posted");
                            end;
                        runningInt := 0;
                        runningInt := runningInt + "Amount Posted";
                    end;

                    trigger OnPreDataItem()
                    begin
                        ClosingBalInt := InterestBF;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if LoanSetup.Get(Loans."Loan Product Type") then
                        LoanName := LoanSetup."Product Description";
                    if DateFilterBF <> '' then begin
                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
                        LoansR.SetFilter(LoansR."Date filter", DateFilterBF);
                        if LoansR.Find('-') then begin
                            LoansR.CalcFields(LoansR."Outstanding Balance");
                            LoansR.CalcFields(LoansR."Oustanding Interest");
                            PrincipleBF := LoansR."Outstanding Balance";
                            InterestBF := LoansR."Oustanding Interest";
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    //Loans.CALCFIELDS("Outstanding Balance");
                    //Loans.SETFILTER("Outstanding Balance",'<>%1',0);

                    Loans.SetFilter(Loans."Date filter", Customer.GetFilter(Customer."Date Filter"));
                end;
            }


            trigger OnAfterGetRecord()
            begin
                SaccoEmp.Reset;
                SaccoEmp.SetRange(SaccoEmp.Code, Customer."Employer Code");
                if SaccoEmp.Find('-') then
                    EmployerName := SaccoEmp.Description;

                HolidayBF := 0;
                SharesBF := 0;
                InsuranceBF := 0;
                ShareCapBF := 0;
                RiskBF := 0;
                HseBF := 0;
                Dep1BF := 0;
                Dep2BF := 0;
                if DateFilterBF <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."Customer No.", "No.");
                    //ABEL COMMENT
                    Cust.SetFilter(Cust."Date Filter", DateFilterBF);
                    //ABEL COMMENT
                    if Cust.Find('-') then begin
                        // Cust.CalcFields(Cust.sha, Cust."Current Shares", Cust."Insurance Fund", Cust."Holiday Savings");
                        // SharesBF := Cust."Current Shares";
                        // ShareCapBF := Cust."Shares Retained";
                        // RiskBF := Cust."Insurance Fund";
                        // HolidayBF := Cust."Holiday Savings";
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                /*
                IF Customer.GETFILTER(Customer."Date Filter") <> '' THEN
                DateFilterBF:='..'+ FORMAT(CALCDATE('-1D',Customer.GETRANGEMIN(Customer."Date Filter")));
                */

                if Customer.GetFilter(Customer."Date Filter") <> '' then
                    DateFilterBF := '..' + Format(CalcDate('-1D', Customer.GetRangeMin(Customer."Date Filter")));
                //DateFilterBF:='..'+ FORMAT(Customer.GETRANGEMIN(Customer."Date Filter"));

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var
        OpenBalance: Decimal;
        RunningBal: Decimal;
        CLosingBalance: Decimal;
        OpenBalanceXmas: Decimal;
        CLosingBalanceXmas: Decimal;
        Cust: Record "Cust. Ledger Entry";
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        FirstRec: Boolean;
        PrevBal: Integer;
        BalBF: Decimal;
        LoansR: Record "Loans Register";
        DateFilterBF: Text[150];
        SharesBF: Decimal;
        InsuranceBF: Decimal;
        LoanBF: Decimal;
        PrincipleBF: Decimal;
        InterestBF: Decimal;
        ShowZeroBal: Boolean;
        ClosingBalSHCAP: Decimal;
        ShareCapBF: Decimal;
        runningInt: Decimal;
        RiskBF: Decimal;
        DividendBF: Decimal;
        Company: Record "Company Information";
        OpenBalanceHse: Decimal;
        CLosingBalanceHse: Decimal;
        OpenBalanceDep1: Decimal;
        CLosingBalanceDep1: Decimal;
        OpenBalanceDep2: Decimal;
        CLosingBalanceDep2: Decimal;
        HseBF: Decimal;
        Dep1BF: Decimal;
        Dep2BF: Decimal;
        OpeningBalInt: Decimal;
        ClosingBalInt: Decimal;
        InterestPaid: Decimal;
        SumInterestPaid: Decimal;
        OpenBalanceRisk: Decimal;
        CLosingBalanceRisk: Decimal;
        OpenBalanceDividend: Decimal;
        ClosingBalanceDividend: Decimal;
        OpenBalanceHoliday: Decimal;
        ClosingBalanceHoliday: Decimal;
        LoanSetup: Record "Loan Products Setup";
        LoanName: Text[50];
        SaccoEmp: Record "Sacco Employers";
        EmployerName: Text[100];
        OpenBalanceLoan: Decimal;
        ClosingBalanceLoan: Decimal;
        BankCodeShares: Text;
        BankCodeDeposits: Text;
        BankCodeDividend: Text;
        BankCodeRisk: Text;
        BankCodeInsurance: Text;
        BankCodeLoan: Text;
        BankCodeInterest: Text;
        HolidayBF: Decimal;
        BankCodeHoliday: Code[50];
        ClosingBalHoliday: Decimal;
        OpeningBalHoliday: Decimal;
        BankCodeFOSAShares: Code[50];
        ClosingBalanceFOSAShares: Decimal;
        OpenBalanceFOSAShares: Decimal;
        OpenBalancesPepeaShares: Decimal;
        ClosingBalancePepeaShares: Decimal;
        BankCodePepeaShares: Code[50];
        OpenBalancesVanShares: Decimal;
        ClosingBalanceVanShares: Decimal;
        BankCodeVanShares: Code[50];
        ApprovedAmount_Interest: Decimal;
        LonRepaymentSchedule: Record "Loan Repayment Schedule";


    local procedure GetBankCode(MembLedger: Record "Cust. Ledger Entry"): Text
    var
        BankLedger: Record "Bank Account Ledger Entry";
    begin
        BankLedger.Reset;
        BankLedger.SetRange("Posting Date", MembLedger."Posting Date");
        BankLedger.SetRange("Document No.", MembLedger."Document No.");
        if BankLedger.FindFirst then
            exit(BankLedger."Bank Account No.");
        exit('');
    end;
}

