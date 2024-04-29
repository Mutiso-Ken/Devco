report 50026 StatementProfitorloss
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Statementoflossorloss.rdlc';

    dataset
    {
        dataitem("Sacco Information"; "Sacco Information")
        {
            column(Code; Code)
            {

            }
            column(PersonalExpenses; PersonalExpenses)
            {

            }
            column(LPersonalExpenses; LPersonalExpenses)
            {

            }
            column(InterestonLoans; InterestonLoans)
            {

            }
            column(InvestmentIncome; InvestmentIncome)
            {

            }
            column(InterestExpenses; InterestExpenses)
            {

            }
            column(NetFeeandcommission; NetFeeandcommission)
            {

            }
            column(OtherOperatingincome; OtherOperatingincome)
            {

            }
            column(Gainloassasrisongfromderecongnition; Gainloassasrisongfromderecongnition)
            {

            }
            column(ImpairmentLosses; ImpairmentLosses)
            {

            }
            column(Governanceexpenses; Governanceexpenses)
            {

            }
            column(Makertingexpenses; Makertingexpenses)
            {

            }

            column(staffcosts; staffcosts)
            {

            }
            column(OperatingExpenses; OperatingExpenses)
            {

            }
            column(LOperatingExpenses; LOperatingExpenses)
            {

            }
            column(administrativeexpenses; administrativeexpenses)
            {

            }
            column(profitorLossbeforetax; profitorLossbeforetax)
            {

            }
            column(NotRecGainLossonPropertyandequipmenrevaluation; NotRecGainLossonPropertyandequipmenrevaluation)
            {

            }
            column(NotRecGainlossonequityinstatFVTOCI; NotRecGainlossonequityinstatFVTOCI)
            {

            }
            column(NotRecRemeasurementofdefinedassetLiability; NotRecRemeasurementofdefinedassetLiability)
            {

            }
            column(NotRecEffectofchangeinrareofdefferedtax; NotRecEffectofchangeinrareofdefferedtax)
            {

            }
            column(NotDefferedtax; NotDefferedtax)
            {

            }
            column(RecGainlossonequityinstatFVTOCI; RecGainlossonequityinstatFVTOCI)
            {

            }
            column(RecEffectofchangeinrateofdefferedtax; RecEffectofchangeinrateofdefferedtax)
            {

            }
            column(RecDefferedtax; RecDefferedtax)
            {

            }
            column(OthercomprehensiveIncome; OthercomprehensiveIncome)
            {

            }
            column(DepreciationAmmortisation; DepreciationAmmortisation)
            {

            }
            column(LDepreciationAmmortisation; LDepreciationAmmortisation)
            {

            }


            ///last year but One
            column(LInterestonLoans; LInterestonLoans)
            {

            }
            column(LInvestmentIncome; LInvestmentIncome)
            {

            }
            column(LInterestExpenses; LInterestExpenses)
            {

            }
            column(LNetFeeandcommission; LNetFeeandcommission)
            {

            }
            column(LOtherOperatingincome; LOtherOperatingincome)
            {

            }

            column(LGainloassasrisongfromderecongnition; LGainloassasrisongfromderecongnition)
            {

            }
            column(LImpairmentLosses; LImpairmentLosses)
            {

            }
            column(LGovernanceexpenses; LGovernanceexpenses)
            {

            }
            column(LMakertingexpenses; LMakertingexpenses)
            {

            }
            column(FinancialExpense; FinancialExpense)
            {

            }
            column(LFinancialExpense; LFinancialExpense)
            {

            }
            column(Lstaffcosts; Lstaffcosts)
            {

            }
            column(Ladministrativeexpenses; Ladministrativeexpenses)
            {

            }
            column(LprofitorLossbeforetax; LprofitorLossbeforetax)
            {

            }
            column(LNotRecGainLossonPropertyandequipmenrevaluation; LNotRecGainLossonPropertyandequipmenrevaluation)
            {

            }
            column(LNotRecGainlossonequityinstatFVTOCI; LNotRecGainlossonequityinstatFVTOCI)
            {

            }
            column(LNotRecRemeasurementofdefinedassetLiability; LNotRecRemeasurementofdefinedassetLiability)
            {

            }
            column(LNotRecEffectofchangeinrareofdefferedtax; LNotRecEffectofchangeinrareofdefferedtax)
            {

            }
            column(LNotDefferedtax; LNotDefferedtax)
            {

            }
            column(LRecGainlossonequityinstatFVTOCI; LRecGainlossonequityinstatFVTOCI)
            {

            }
            column(LRecEffectofchangeinrateofdefferedtax; LRecEffectofchangeinrateofdefferedtax)
            {

            }
            column(LRecDefferedtax; LRecDefferedtax)
            {

            }
            column(LOthercomprehensiveIncome; LOthercomprehensiveIncome)
            {

            }
            column(EndofLastyear; EndofLastyear)
            {

            }
            column(CurrentYear; CurrentYear)
            {

            }
            column(PreviousYear; PreviousYear)
            {

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                DateFormula: Text;
                DateExpr: Text;
                InputDate: Date;

            begin
                DateFormula := '<-CY-1D>';
                DateExpr := '<-1y>';
                InputDate := Asat;

                EndofLastyear := InputDate;
                CurrentYear := Date2DMY(EndofLastyear, 3);
                LastYearButOne := CalcDate(DateExpr, EndofLastyear);
                PreviousYear := CurrentYear - 1;


                //Revenues
                //Interest on Loans
                InterestonLoans := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::InterestOnLoans);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1>', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            InterestonLoans += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                LInterestonLoans := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::InterestOnLoans);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LInterestonLoans += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                //Interest Exepenses
                InterestExpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::InterestExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            InterestExpenses += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                LInterestExpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::InterestExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LInterestExpenses += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;



                //Otheroperatingincome
                OtherOperatingincome := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::OtherOperatingincome);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            OtherOperatingincome += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                OtherOperatingincome := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::OtherOperatingincome);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LOtherOperatingincome += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                //OtherInterestIncome
                InvestmentIncome := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::InvestmentIncome);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            InvestmentIncome += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                LInvestmentIncome := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::InvestmentIncome);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LInvestmentIncome += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                Governanceexpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::GorvernanceExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Governanceexpenses += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                LGovernanceexpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::GorvernanceExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LGovernanceexpenses += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                administrativeexpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::AdministrationExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            administrativeexpenses += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                Ladministrativeexpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::AdministrationExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Ladministrativeexpenses += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                PersonalExpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::PersonelExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            PersonalExpenses += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                LPersonalExpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::PersonelExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LPersonalExpenses += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                OperatingExpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::OperatingExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            OperatingExpenses += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                LOperatingExpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::OperatingExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LOperatingExpenses += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                FinancialExpense := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::FinancialExpense);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            FinancialExpense += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                LFinancialExpense := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::FinancialExpense);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LFinancialExpense += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                Makertingexpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::MarketingExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Makertingexpenses += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                LMakertingexpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::MarketingExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LMakertingexpenses += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;


                DepreciationAmmortisation := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::DepreciationAmmortisation);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            DepreciationAmmortisation += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                LDepreciationAmmortisation := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::DepreciationAmmortisation);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LDepreciationAmmortisation += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                // Date := CalcDate('-CY -1D', AsAt);
                // DateFilter := Format(Date) + '..' + Format(AsAt);
                // DateFilter11 := Format(Date) + '..' + Format(AsAt);
                // FinancialYear := Date2dmy(AsAt, 3);
            end;
        }

    }


    requestpage
    {

        layout
        {
            area(content)
            {
                field(Asat; Asat)
                {
                    ApplicationArea = Basic;
                    Caption = 'Asat';
                }
            }
        }

        actions
        {
        }
    }
    var
        DepreciationAmmortisation: Decimal;
        LDepreciationAmmortisation: Decimal;
        PersonalExpenses: Decimal;
        LPersonalExpenses: Decimal;
        FinancialExpense: Decimal;
        LFinancialExpense: Decimal;
        DateFilter: Text;
        LDatefilter: Text;
        Date: Date;
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
        myInt: Integer;
        Asat: Date;
        EndofLastyear: Date;
        LastYearButOne: Date;
        CurrentYear: Integer;
        PreviousYear: Integer;
        InterestonLoans: Decimal;
        InvestmentIncome: Decimal;
        InterestExpenses: Decimal;
        NetFeeandcommission: Decimal;
        OtherOperatingincome: Decimal;
        OperatingExpenses: Decimal;
        Gainloassasrisongfromderecongnition: Decimal;
        ImpairmentLosses: Decimal;
        Governanceexpenses: Decimal;
        Makertingexpenses: Decimal;
        staffcosts: Decimal;
        administrativeexpenses: Decimal;
        profitorLossbeforetax: Decimal;
        NotRecGainLossonPropertyandequipmenrevaluation: Decimal;
        NotRecGainlossonequityinstatFVTOCI: Decimal;
        NotRecRemeasurementofdefinedassetLiability: Decimal;
        NotRecEffectofchangeinrareofdefferedtax: Decimal;
        NotDefferedtax: Decimal;
        RecGainlossonequityinstatFVTOCI: Decimal;
        RecEffectofchangeinrateofdefferedtax: Decimal;
        RecDefferedtax: Decimal;
        OthercomprehensiveIncome: Decimal;

        //Last Year
        LInterestonLoans: Decimal;
        LInvestmentIncome: Decimal;
        LInterestExpenses: Decimal;
        LNetFeeandcommission: Decimal;
        LOtherOperatingincome: Decimal;
        LOperatingExpenses: Decimal;
        LGainloassasrisongfromderecongnition: Decimal;
        LImpairmentLosses: Decimal;
        LGovernanceexpenses: Decimal;
        LMakertingexpenses: Decimal;
        Lstaffcosts: Decimal;
        Ladministrativeexpenses: Decimal;
        LprofitorLossbeforetax: Decimal;
        LNotRecGainLossonPropertyandequipmenrevaluation: Decimal;
        LNotRecGainlossonequityinstatFVTOCI: Decimal;
        LNotRecRemeasurementofdefinedassetLiability: Decimal;
        LNotRecEffectofchangeinrareofdefferedtax: Decimal;
        LNotDefferedtax: Decimal;
        LRecGainlossonequityinstatFVTOCI: Decimal;
        LRecEffectofchangeinrateofdefferedtax: Decimal;
        LRecDefferedtax: Decimal;
        LOthercomprehensiveIncome: Decimal;
}