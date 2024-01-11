#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516202 "Loans Defaulters Aging - SASRA"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loans Defaulters Aging - SASRA.rdlc';

    dataset
    {
        dataitem(Loans; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where("Outstanding Balance" = filter(<> 0), Posted = const(true));
            RequestFilterFields = Source, "Branch Code", "Loan Product Type", "Outstanding Balance", "Date filter", "Issued Date", "Employer Code", "Loan  No.";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(BOSANo_Loans; Loans."BOSA No")
            {
            }
            column(AmountInArrears; AmountInArrears)
            {
            }
            column(No_of_Months_in_Arrears; "No of Months in Arrears")
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Loans__Loan__No__; "Loan  No.")
            {
            }
            column(Loans__Loan_Product_Type_; "Loan Product Type")
            {
            }
            column(Loans_Loans__Staff_No_; Loans."Staff No")
            {
            }
            column(Loans__Client_Name_; "Client Name")
            {
            }
            column(Loans_Loans__Outstanding_Balance_; Loans."Outstanding Balance")
            {
            }
            column(V2Month_; "2Month")
            {
            }
            column(V3Month_; "3Month")
            {
            }
            column(Over3Month; Over3Month)
            {
            }
            column(V1Month_; "1Month")
            {
            }
            column(V0Month_; "0Month")
            {
            }
            column(Loans_Loans__Outstanding_Balance__Control1000000016; Loans."Outstanding Balance")
            {
            }
            column(Loans__Approved_Amount_; "Approved Amount")
            {
            }
            column(Loans_Loans__Interest_Due_; Loans."Interest Due")
            {
            }
            column(V1MonthC_; "1MonthC")
            {
            }
            column(V2MonthC_; "2MonthC")
            {
            }
            column(V3MonthC_; "3MonthC")
            {
            }
            column(Over3MonthC; Over3MonthC)
            {
            }
            column(NoLoans; NoLoans)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(V0Month__Control1102760031; "0Month")
            {
            }
            column(V1Month__Control1102760032; "1Month")
            {
            }
            column(V2Month__Control1102760033; "2Month")
            {
            }
            column(V3Month__Control1102760034; "3Month")
            {
            }
            column(Over3Month_Control1102760035; Over3Month)
            {
            }
            column(V0MonthC_; "0MonthC")
            {
            }
            column(Loans_Aging_Analysis__SASRA_Caption; Loans_Aging_Analysis__SASRA_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption; FieldCaption("Loan  No."))
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(Staff_No_Caption; Staff_No_CaptionLbl)
            {
            }
            column(Loans__Client_Name_Caption; FieldCaption("Client Name"))
            {
            }
            column(Oustanding_BalanceCaption; Oustanding_BalanceCaptionLbl)
            {
            }
            column(PerformingCaption; PerformingCaptionLbl)
            {
            }
            column(V1___30_Days_Caption; V1___30_Days_CaptionLbl)
            {
            }
            column(V0_Days_Caption; V0_Days_CaptionLbl)
            {
            }
            column(WatchCaption; WatchCaptionLbl)
            {
            }
            column(V31___180_Days_Caption; V31___180_Days_CaptionLbl)
            {
            }
            column(SubstandardCaption; SubstandardCaptionLbl)
            {
            }
            column(V181___360_Days_Caption; V181___360_Days_CaptionLbl)
            {
            }
            column(DoubtfulCaption; DoubtfulCaptionLbl)
            {
            }
            column(Over_360_DaysCaption; Over_360_DaysCaptionLbl)
            {
            }
            column(LossCaption; LossCaptionLbl)
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(CountCaption; CountCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(Lbal; LBalance)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Evaluate(DFormula, '1Q');

                Cust.Reset;
                if Loans.Source = Loans.Source::FOSA then
                    Cust.SetRange(Cust."No.", Loans."BOSA No")
                else
                    Cust.SetRange(Cust."No.", Loans."Client Code");
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Current Shares");
                    "StaffNo." := Cust."Payroll/Staff No";
                    Deposits := Cust."Current Shares";
                end;
                //-------------------------------------------------------------------
                "0Month" := 0;
                "1Month" := 0;
                "2Month" := 0;
                "3Month" := 0;
                Over3Month := 0;
                Loans.CalcFields(Loans."Last Pay Date", Loans."Outstanding Balance");

                if Repayment < 0 then begin
                    Loans.Validate("Approved Amount");
                end;
                //--------------------------------------------------------------------
                LoanRec.Reset;
                LoanRec.SetFilter(LoanRec."Date filter", '..%1', AsAt);
                LoanRec.SetRange(LoanRec."Loan  No.", Loans."Loan  No.");
                if LoanRec.Find('-') then begin
                    LoanRec.CalcFields(LoanRec."Outstanding Balance", LoanRec."Oustanding Interest", LoanRec."Schedule Repayments");
                    if LoanRec."Outstanding Balance" > 0 then begin
                        PrPaid := LoanRec."Approved Amount" - LoanRec."Outstanding Balance";//Get Principle already paid
                        PrExp := LoanRec."Schedule Repayments";//Get Expected Principle To have been paid
                        outInt := LoanRec."Oustanding Interest"//Get Outstanding interest
                    end;
                end;
                //--------------------------------------------------------------------Variance=No of Months In Arrears
                Variance := (PrExp - PrPaid) + outInt;
                Variance := ROUND(Variance / Repayment, 1, '<');

                if Variance < 0 then
                    Variance := 0;

                AmountInArrears := 0;
                AmountInArrears := PrExp - PrPaid;

                NoOfMonthsInArrears := 0;
                NoOfMonthsInArrears := Variance;
                //---------------------------------------------------------------------
                case Variance of
                    0:
                        begin
                            "0Month" := Loans."Outstanding Balance";
                            "0MonthC" := "0MonthC" + 1;
                            Loans."Loans Category-SASRA" := Loans."loans category-sasra"::Perfoming;
                            loans."Amount in Arrears" := AmountInArrears;
                            Loans."No of Months in Arrears" := NoOfMonthsInArrears;
                            //Loans.Modify;
                        end;
                    1:
                        begin
                            "1Month" := Loans."Outstanding Balance";
                            "1MonthC" := "1MonthC" + 1;
                            Loans."Loans Category-SASRA" := Loans."loans category-sasra"::Watch;
                            loans."Amount in Arrears" := AmountInArrears;
                            Loans."No of Months in Arrears" := NoOfMonthsInArrears;
                            //Loans.Modify;
                        end;
                    2, 3, 4, 5, 6:
                        begin
                            "2Month" := Loans."Outstanding Balance";
                            "2MonthC" := "2MonthC" + 1;
                            Loans."Loans Category-SASRA" := Loans."loans category-sasra"::Substandard;
                            loans."Amount in Arrears" := AmountInArrears;
                            Loans."No of Months in Arrears" := NoOfMonthsInArrears;
                            //Loans.Modify;
                        end;
                    7, 8, 9, 10, 11, 12:
                        begin
                            "3Month" := Loans."Outstanding Balance";
                            "3MonthC" := "3MonthC" + 1;
                            Loans."Loans Category-SASRA" := Loans."loans category-sasra"::Doubtful;
                            loans."Amount in Arrears" := AmountInArrears;
                            Loans."No of Months in Arrears" := NoOfMonthsInArrears;
                            // Loans.Modify;
                        end
                    else begin
                        Over3Month := Loans."Outstanding Balance";
                        Over3MonthC := Over3MonthC + 1;
                        Loans."Loans Category-SASRA" := Loans."loans category-sasra"::Loss;
                        loans."Amount in Arrears" := AmountInArrears;
                        Loans."No of Months in Arrears" := NoOfMonthsInArrears;
                        //Loans.Modify;
                    end;

                end;
                LBalance := Loans."Outstanding Balance";

                GrandTotal := GrandTotal + Loans."Outstanding Balance";

                if ("0Month" = 0) and ("1Month" = 0) and ("2Month" = 0) and ("3Month" = 0) and (Over3Month = 0) then
                    CurrReport.Skip
                else
                    NoLoans := NoLoans + 1;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals("0Month", "1Month", "2Month", "3Month", Over3Month);
                GrandTotal := 0;

                if GetFilter("Date filter") = '' then
                    AsAt := Today
                else
                    AsAt := GetRangemax("Date filter");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AsAt; AsAt)
                {
                    ApplicationArea = Basic;
                    Caption = 'As At';
                    Visible = false;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        AsAt: Date;
        LastDueDate: Date;
        DFormula: DateFormula;
        "0MonthC": Integer;
        "1MonthC": Integer;
        "2MonthC": Integer;
        "3MonthC": Integer;
        Over3MonthC: Integer;
        NoLoans: Integer;
        PhoneNo: Text[30];
        Cust: Record Customer;
        "StaffNo.": Text[30];
        Deposits: Decimal;
        GrandTotal: Decimal;
        "0Month": Decimal;
        LoanProduct: Record "Loan Products Setup";
        FirstMonthDate: Date;
        EndMonthDate: Date;
        Loans_Aging_Analysis__SASRA_CaptionLbl: label 'Loans Aging Analysis (SASRA)';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Staff_No_CaptionLbl: label 'Staff No.';
        Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
        PerformingCaptionLbl: label 'Performing';
        V1___30_Days_CaptionLbl: label '(1 - 30 Days)';
        V0_Days_CaptionLbl: label '(0 Days)';
        WatchCaptionLbl: label 'Watch';
        V31___180_Days_CaptionLbl: label '(31 - 180 Days)';
        SubstandardCaptionLbl: label 'Substandard';
        V181___360_Days_CaptionLbl: label '(181 - 360 Days)';
        DoubtfulCaptionLbl: label 'Doubtful';
        Over_360_DaysCaptionLbl: label 'Over 360 Days';
        LossCaptionLbl: label 'Loss';
        TotalsCaptionLbl: label 'Totals';
        CountCaptionLbl: label 'Count';
        Grand_TotalCaptionLbl: label 'Grand Total';
        CustLedger: Record "Cust. Ledger Entry";
        LBalance: Decimal;
        Criteria: Option " ","Use Date","Use Schedule";
        LoanRec: Record "Loans Register";
        PrPaid: Decimal;
        PrExp: Decimal;
        outInt: Decimal;
        Variance: Decimal;
        LowerLimit: Date;
        UpperLimit: Date;
        Expected: Decimal;
        Paid: Decimal;
        AmountInArrears: Decimal;
        NoOfMonthsInArrears: Decimal;
}

