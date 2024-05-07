report 51516347 "REPORT OF THE DIRECTORS"

{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Reportofthedirectors.rdlc';

    dataset
    {
        dataitem("Sacco Information"; "Sacco Information")
        {
            column(Code; Code)
            {

            }
            column(Independent_Auditor; "Independent Auditor")
            {

            }
            column(Asat; Asat)
            {


            }
            column(CurrentYear; CurrentYear)
            {

            }
            column(PreviousYear; PreviousYear)
            {

            }
            column(ThisYear; ThisYear)
            {

            }
            column(Sacco_Principal_Activities; "Sacco Principal Activities")
            {

            }
            column(IntCurrentDeposits; IntCurrentDeposits)
            {

            }

            column(IntShareCapital; IntShareCapital)
            {

            }
            column(InterestonMemberdeposits; InterestonMemberdeposits * -1)
            {

            }
            column(LInterestonMemberdeposits; LInterestonMemberdeposits * -1)
            {

            }
            column(ShareCapital; ShareCapital)
            {

            }
            column(LShareCapital; LShareCapital)
            {

            }
            column(RetainedEarnings; RetainedEarnings) { }
            column(LRetainedEarnings; LRetainedEarnings) { }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                InputDate: Date;
                DateFormula: Text;
                DateExpr: Text;
            begin
                DateFormula := '<-CY-1D>';
                DateExpr := '<-1y>';
                InputDate := Asat;
                ThisYear := Asat;
                CurrentYear := Date2DMY(ThisYear, 3);
                LastYear := CalcDate(DateExpr, ThisYear);
                PreviousYear := CurrentYear - 1;
                GenSetup.Get();
                IntCurrentDeposits := (GenSetup."Interest on Share Capital(%)" * 0.01);
                IntShareCapital := (GenSetup."Interest On Current Shares" * 0.01);



                //Dividends
                InterestonMemberdeposits := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::dividendsandInterestPayable);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            InterestonMemberdeposits += 1 * GLEntry.Amount;

                        end;
                    until GLAccount.Next = 0;
                end;
                LInterestonMemberdeposits := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::dividendsandInterestPayable);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LInterestonMemberdeposits += 1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //End Of Dividends
                //Sharecapital
                ShareCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ShareCapital += 1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                LShareCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LShareCapital += 1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //Endofsharecapital


                //Retained Earnings
                RetainedEarnings := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::RevenueReserves);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            RetainedEarnings += 1 * GLEntry.Amount;
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
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LRetainedEarnings += 1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //End Of Retained Earnings


                //Income Tax Expense


                //End of Income Tax Expense

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
                    field(Asat; Asat)
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
        ShareCapital: Decimal;
        LShareCapital: Decimal;
        RetainedEarnings: Decimal;
        LRetainedEarnings: Decimal;
        IntCurrentDeposits: Decimal;
        InterestonMemberdeposits: Decimal;
        LInterestonMemberdeposits: Decimal;
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
        IntShareCapital: Decimal;
        myInt: Integer;
        LastYear: Date;
        Asat: Date;
        CurrentYear: Integer;
        PreviousYear: Integer;
        ThisYear: date;
        GenSetup: Record "Sacco General Set-Up";
}
