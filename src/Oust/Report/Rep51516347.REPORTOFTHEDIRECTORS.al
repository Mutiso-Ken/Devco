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
            column(EndofLastyear; EndofLastyear)
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
                EndofLastyear := CalcDate(DateFormula, Asat);
                CurrentYear := Date2DMY(EndofLastyear, 3);
                LastYearButOne := CalcDate(DateExpr, EndofLastyear);
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
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
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
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
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
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
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
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LShareCapital += 1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //Endofsharecapital

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
        IntCurrentDeposits: Decimal;
        InterestonMemberdeposits: Decimal;
        LInterestonMemberdeposits: Decimal;
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
        IntShareCapital: Decimal;
        myInt: Integer;
        LastYearButOne: Date;
        Asat: Date;
        CurrentYear: Integer;
        PreviousYear: Integer;
        EndofLastyear: date;
        GenSetup: Record "Sacco General Set-Up";
}
