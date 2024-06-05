#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516207 "SASRA Loans Classification"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SASRA Loans Classification.rdlc';
    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = sorting("Client Code") order(ascending) where(Posted = const(true));
            RequestFilterFields = "Client Code","Loan Product Type", "Loan  No.", "Issued Date";
            column(ReportForNavId_1120054000; 1120054000)
            {
            }
            column(PerformingDisplay; PerformingDisplay)
            {
            }
            column(InterestArrears; InterestArrears)
            {
            }
            column(Last_Pay_Date; "Last Pay Date")
            {
            }
            column(Expected_Date_of_Completion; "Expected Date of Completion")
            {
            }
            column(WatchDisplay; WatchDisplay)
            {
            }
            column(StandardDisplay; StandardDisplay)
            {
            }
            column(DoubtfulDisplay; DoubtfulDisplay)
            {
            }
            column(LossDisplay; LossDisplay)
            {
            }
            column(AmountInArrearsDisplay; AmountInArrearsDisplay)
            {
            }
            column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(RequestedAmount_LoansRegister; "Loans Register"."Requested Amount")
            {
            }
            column(ApprovedAmount_LoansRegister; "Loans Register"."Schedule Loan Amount Issued")
            {
            }
            column(OutstandingBalance_LoansRegister; "Loans Register"."Outstanding Balance")
            {
            }
            column(OustandingInterest_LoansRegister; "Loans Register"."Oustanding Interest")
            {
            }
            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }
            column(IssuedDate_LoansRegister; "Loans Register"."Issued Date")
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Client Name")
            {
            }
            column(NextCount; NextCount)
            {
            }


            trigger OnAfterGetRecord()
            begin
                LoansReg.Reset();
                LoansReg.SetFilter(LoansReg."Date filter", DateFilter);
                LoansReg.SetRange(LoansReg."Loan  No.", "Loans Register"."Loan  No.");
                LoansReg.SetAutocalcFields(LoansReg."Scheduled Principle Payments", LoansReg."Schedule Loan Amount Issued", LoansReg."Schedule Installments", LoansReg."Outstanding Balance", LoansReg."Oustanding Interest", LoansReg."Scheduled Interest Payments", LoansReg."Interest Paid");
                if LoansReg.Find('-') then begin

                    //...........Current Loan Balance
                    CurrentLoanBalance := 0;
                    CurrentLoanBalance := LoansReg."Outstanding Balance";
                    //...........Calculate Principle Arrears
                    LoanArrears := 0;
                    LoanArrears := LoansReg."Principal In Arrears";
                    if LoanArrears < 0 then begin
                        LoanArrears := 0;
                    end;
                    //...........................Interest Arrears
                    if LoansReg.Source = LoansReg.Source::BOSA then begin
                        InterestArrears := 0;
                        InterestArrears := LoansReg."Oustanding Interest";
                        if InterestArrears < 0 then begin
                            InterestArrears := 0;
                        end;


                        DaysInArrears := 0;
                        DaysInArrears := ROUND((LoansReg."No of Months in Arrears" * 30), 1, '>');
                        //...........................Classify Loan
                        PerformingDisplay := 0;
                        WatchDisplay := 0;
                        StandardDisplay := 0;
                        DoubtfulDisplay := 0;
                        LossDisplay := 0;
                        AmountInArrearsDisplay := 0;

                        if (LoansReg."Expected Date of Completion" <> 0D) and (DateBD <= LoansReg."Expected Date of Completion") then begin
                            case NoOfMonthsInArrears of
                                0:
                                    begin
                                        PerformingDisplay := CurrentLoanBalance;
                                        WatchDisplay := 0;
                                        StandardDisplay := 0;
                                        DoubtfulDisplay := 0;
                                        LossDisplay := 0;
                                        AmountInArrearsDisplay := LoanArrears;
                                    end;
                                1:
                                    begin
                                        PerformingDisplay := 0;
                                        WatchDisplay := CurrentLoanBalance;
                                        StandardDisplay := 0;
                                        DoubtfulDisplay := 0;
                                        LossDisplay := 0;
                                        AmountInArrearsDisplay := LoanArrears;
                                    end;
                                2, 3, 4, 5, 6:
                                    begin
                                        PerformingDisplay := 0;
                                        WatchDisplay := 0;
                                        StandardDisplay := CurrentLoanBalance;
                                        DoubtfulDisplay := 0;
                                        LossDisplay := 0;
                                        AmountInArrearsDisplay := LoanArrears;
                                    end;
                                7, 8, 9, 10, 11, 12:
                                    begin
                                        PerformingDisplay := 0;
                                        WatchDisplay := 0;
                                        StandardDisplay := 0;
                                        DoubtfulDisplay := CurrentLoanBalance;
                                        LossDisplay := 0;
                                        AmountInArrearsDisplay := LoanArrears;
                                    end
                                else begin
                                    PerformingDisplay := 0;
                                    WatchDisplay := 0;
                                    StandardDisplay := 0;
                                    DoubtfulDisplay := 0;
                                    LossDisplay := CurrentLoanBalance;
                                    AmountInArrearsDisplay := LoanArrears;
                                end;
                            end;
                        end
                        else
                            if (LoansReg."Expected Date of Completion" <> 0D) and (DateBD > LoansReg."Expected Date of Completion") then begin
                                PerformingDisplay := 0;
                                WatchDisplay := 0;
                                StandardDisplay := 0;
                                DoubtfulDisplay := 0;
                                LossDisplay := CurrentLoanBalance;
                                AmountInArrearsDisplay := LoanArrears;
                            end;
                        if (PerformingDisplay = 0) and (WatchDisplay = 0) and (StandardDisplay = 0)
                          and (DoubtfulDisplay = 0) and (LossDisplay = 0) OR (LoansReg."Schedule Installments" = 0) then begin
                            CurrReport.Skip;
                        end;
                        NextCount := NextCount + 1;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                "Loans Register".SetFilter("Loans Register"."Loan Disbursement Date", DateFilter);
                "Loans Register".CalcFields("Loans Register"."Schedule Installments");
                "Loans Register".SetFilter("Loans Register"."Schedule Installments", '>%1', 0);
                ExpectedLoanBal := 0;
                NoOfMonthsInArrears := 0;
                LoanArrears := 0;
                CurrentLoanBalance := 0;
                DaysInArrears := 0;
                NextCount := 0;
                InterestArrears := 0;
                PerformingDisplay := 0;
                WatchDisplay := 0;
                StandardDisplay := 0;
                DoubtfulDisplay := 0;
                LossDisplay := 0;
                AmountInArrearsDisplay := 0;

                if CopyStr(DateFilter, 1, 2) <> '..' then begin
                    DateFilter := '..' + Format(Today);
                end;
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
    var
        RegenerateOldLoansData: Codeunit "Regenerate Schedule for loans";
    begin
        //..........................................................
        DateFilter := "Loans Register".GetFilter("Loans Register"."Date filter");
        if DateFilter = '' then begin
            DateFilter := '..' + Format(Today);
        end;
        Evaluate(DateBD, CopyStr(DateFilter, 3, 100));

    end;

    var
        LoansReg: Record "Loans Register";
        DateFilter: Text;
        ExpectedLoanBal: Decimal;
        CurrentLoanBalance: Decimal;
        LoanArrears: Decimal;
        NoOfMonthsInArrears: Decimal;
        DaysInArrears: Decimal;
        LoanBalanceDisplay: Decimal;
        InterestArrears: Decimal;
        DaysInArrearsDisplay: Integer;
        AmountInArrearsDisplay: Decimal;
        InterestInArrearsDisplay: Decimal;
        LoanCategoryDisplay: Text;
        DateBD: Date;
        PerformingDisplay: Decimal;
        WatchDisplay: Decimal;
        StandardDisplay: Decimal;
        DoubtfulDisplay: Decimal;
        LossDisplay: Decimal;
        NextCount: Integer;
        AsAt: Date;
        Day: Integer;
        Month: Integer;
        Year: Integer;
}

