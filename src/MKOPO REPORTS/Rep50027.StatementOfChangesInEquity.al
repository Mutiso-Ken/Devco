report 50027 StatementOfChangesInEquity
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Statement of Changes in Equity';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Statementofchangesinequity.rdlc';

    dataset
    {
        dataitem("Sacco Information"; "Sacco Information")
        {
            column(Code; Code)
            {

            }
            column(ShareCapital; ShareCapital)
            {
            }
            column(LShareCapital; LShareCapital)
            { }

            column(contShareCapital; contShareCapital)
            { }
            column(contLShareCapital; contLShareCapital)
            { }
            column(PriorYearAdjustment; PriorYearAdjustment) { }
            column(LPriorYearAdjustment; LPriorYearAdjustment) { }
            column(TransfertoStatury; TransfertoStatury) { }
            column(LTransfertoStatury; LTransfertoStatury) { }
            column(StatutoryReserve; StatutoryReserve) { }
            column(LStatutoryReserve; LStatutoryReserve) { }
            column(RetainedEarnings; RetainedEarnings) { }
            column(LRetainedEarnings; LRetainedEarnings) { }

            column(ThisYear; ThisYear)
            {

            }
            column(EndofLastyear; EndofLastyear)
            {

            }
            column(PreviousYear; PreviousYear)
            {

            }
            column(CurrentYear; CurrentYear)
            {

            }
            column(StartofPreviousyear; StartofPreviousyear) { }
            column(StartofThisYear; StartofThisYear) { }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                DateExpr: Text;
                DateFormula: Text;
                DateFormulaOne: text;
                DateFormulaTwo: Text;

            begin
                DateFormula := '<-CY-1D>';
                DateExpr := '<-1y>';
                DateFormulaOne := '<-CY>';

                ThisYear := AsAt;
                StartofThisYear := CalcDate(DateFormulaOne, AsAt);
                StartofPreviousyear := CalcDate(DateExpr, StartofThisYear);
                CurrentYear := Date2DMY(AsAt, 3);
                EndofLastyear := CalcDate(DateFormula, AsAt);
                PreviousYear := CurrentYear - 1;



                //Sharecapital
                ShareCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', StartofThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ShareCapital += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //contribution during the Year

                contShareCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofThisYear, AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            contShareCapital += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //end of contributiosn during the year

                contLShareCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofPreviousyear, EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            contLShareCapital += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //Endofsharecapital

                //contribution as at end of Last year
                LShareCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', StartofPreviousyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LShareCapital += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //contribution as at end of last year

                //Prior Year Adjustments
                PriorYearAdjustment := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Others, '%1', GLAccount.Others::PriorYearAdjustments);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            PriorYearAdjustment += 1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                LPriorYearAdjustment := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Others, '%1', GLAccount.Others::PriorYearAdjustments);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', StartofPreviousyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LPriorYearAdjustment += 1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //End of prior Year Adjustments



                //Retained Earnings
                RetainedEarnings := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::RevenueReserves);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            RetainedEarnings += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                LRetainedEarnings := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::RevenueReserves);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', StartofPreviousyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LRetainedEarnings += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //End Of Retained Earnings
                //Statutory Reserves
                StatutoryReserve := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::StatutoryReserves);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            StatutoryReserve += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                LStatutoryReserve := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::StatutoryReserves);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', StartofPreviousyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LStatutoryReserve += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //End of Statutory Reserves

                //End Of Retained Earnings

                //Transfer to Statutory
                TransfertoStatury := -1 * (RetainedEarnings * 0.2);
                LTransfertoStatury := -1 * (LRetainedEarnings * 0.2);


                //End of Transfer to Statutory

                //calculate surplus for the year

                //calculate surplus for the year

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(AsAt; AsAt)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }



    var
        AsAt: Date;
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
        TransfertoStatury: Decimal;
        LTransfertoStatury: Decimal;
        StatutoryReserve: Decimal;
        LStatutoryReserve: Decimal;
        RetainedEarnings: Decimal;
        LRetainedEarnings: Decimal;
        PreviousYear: Integer;
        CurrentYear: Integer;
        StartofPreviousyear: Date;
        EndofLastyear: date;
        ThisYear: Date;
        StartofThisYear: Date;
        ShareCapital: Decimal;
        LShareCapital: Decimal;
        contShareCapital: Decimal;
        contLShareCapital: Decimal;
        PriorYearAdjustment: Decimal;
        LPriorYearAdjustment: Decimal;



}