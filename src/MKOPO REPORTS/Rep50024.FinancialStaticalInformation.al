report 50024 FinancialStaticalInformation
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/FinancialStaticalInformation.rdlc';


    dataset
    {
        dataitem("Sacco Information"; "Sacco Information")
        {
            column(Code; Code) { }
            column(Active; Active) { }
            column(Dormant; Dormant) { }
            column(LActive; LActive) { }
            column(LDormant; LDormant) { }
            column(FemaleLNumberofEmployees; FemaleLNumberofEmployees) { }
            column(FemaleNumberofEmployees; FemaleNumberofEmployees) { }
            column(MaleLNumberofEmployees; MaleLNumberofEmployees) { }
            column(MaleNumberofEmployees; MaleNumberofEmployees) { }
            column(TotalAssets; TotalAssets) { }
            column(LTotalAssets; LTotalAssets) { }
            column(DepositAmount; (DepositAmount * -1)) { }
            column(LDepositAmount; (LDepositAmount * -1)) { }
            column(LoanandAdvances; LoanandAdvances) { }
            column(LLoanandAdvances; LLoanandAdvances) { }
            column(InterestonMemberdeposits; InterestonMemberdeposits) { }
            column(LInterestonMemberdeposits; LInterestonMemberdeposits) { }

            column(FinancialAssets; FinancialAssets) { }
            column(LFinancialAssets; LFinancialAssets) { }
            column(TotalRevenue; TotalRevenue) { }
            column(LTotalRevenue; LTotalRevenue) { }
            column(TotalInteresstIncome; TotalInteresstIncome) { }
            column(LTotalInteresstIncome; LTotalInteresstIncome) { }
            column(TotalExpenses; TotalExpenses) { }
            column(LTotalExpenses; LTotalExpenses) { }
            column(ShareCapital; ShareCapital) { }
            column(LShareCapital; LShareCapital) { }
            column(Nonwithdrawabledeposits; Nonwithdrawabledeposits) { }
            column(LNonwithdrawabledeposits; LNonwithdrawabledeposits) { }
            column(CorecapitaltoAssetsRatio; CorecapitaltoAssetsRatio) { }
            column(LCorecapitaltoAssetsRatio; LCorecapitaltoAssetsRatio) { }
            column(Corecapital; Corecapital) { }
            column(LCorecapital; LCorecapital) { }
            column(CorecapitaltoDepositsRatio; CorecapitaltoDepositsRatio) { }
            column(LCorecapitaltoDepositsRatio; LCorecapitaltoDepositsRatio) { }
            column(LExternalBorrowingtoAssetsRatio; LExternalBorrowingtoAssetsRatio) { }
            column(ExternalBorrowingtoAssetsRatio; ExternalBorrowingtoAssetsRatio) { }
            column(LiquidAssetstoTotalassetsshorttermliabilities; LiquidAssetstoTotalassetsshorttermliabilities) { }
            column(LLiquidAssetstoTotalassetsshorttermliabilities; LLiquidAssetstoTotalassetsshorttermliabilities) { }
            column(LiquidAssetsTotalAssets; LiquidAssetsTotalAssets) { }
            column(LLiquidAssetsTotalAssets; LLiquidAssetsTotalAssets) { }

            column(GrossLoansTotalAssets; GrossLoansTotalAssets) { }
            column(LGrossLoansTotalAssets; LGrossLoansTotalAssets) { }
            column(GrossLoansdeposits; GrossLoansdeposits) { }
            column(LGrossLoansdeposits; LGrossLoansdeposits) { }
            column(TotalExpensesTotalRevenue; TotalExpensesTotalRevenue) { }
            column(LTotalExpensesTotalRevenue; LTotalExpensesTotalRevenue) { }
            column(TotalExpensesTotalAssets; TotalExpensesTotalAssets) { }
            column(LTotalExpensesTotalAssets; LTotalExpensesTotalAssets) { }
            column(DividendsTotalRevenue; DividendsTotalRevenue) { }
            column(NoSaccoBraches; NoSaccoBraches)
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
                //Date := DMY2DATE(Day,Month,Year);

                TotalAssets := 0;
                LTotalAssets := 0;

                FemaleLNumberofEmployees := 0;
                FemaleNumberofEmployees := 0;
                Active := 0;
                Dormant := 0;
                LActive := 0;
                LDormant := 0;
                LLoanBalance := 0;
                Equityinvestment := 0;

                SubsidiaryandRelated := 0;
                cust.Reset();
                cust.SetFilter(Cust."Customer Type", '=%1', Cust."Customer Type"::Member);
                if Cust.Find('-') then begin
                    Cust.SetFilter(Cust.Status, '=%1', Cust.Status::Active);
                    Cust.SetFilter(Cust."Registration Date", '<=%1', EndofLastyear);
                    if FindSet() then
                        Active := Cust.Count;
                    Cust.SetFilter(Cust.Status, '=%1', Cust.Status::Dormant);
                    Cust.SetFilter(Cust."Registration Date", '<=%1', EndofLastyear);
                    if FindSet() then
                        Dormant := Cust.Count;

                    Cust.SetFilter(Cust.Status, '=%1', Cust.Status::Active);
                    Cust.SetFilter(Cust."Registration Date", '<=%1', LastYearButOne);
                    if FindSet() then
                        LActive := Cust.Count;

                    Cust.SetFilter(Cust.Status, '=%1', Cust.Status::Dormant);
                    Cust.SetFilter(Cust."Registration Date", '<=%1', LastYearButOne);
                    if FindSet() then
                        LDormant := Cust.Count;
                end;
                //Number of Female Sacco Employees
                Emp.reset;
                Emp.SetFilter(Emp.Status, '%1', Emp.Status::Active);
                Emp.SetFilter(Emp.Gender, '%1', Emp.Gender::Female);
                if FindSet() then begin
                    Emp.SetFilter(Emp."Employment Date", '<=%1', EndofLastyear);
                    if FindSet() then
                        FemaleNumberofEmployees := Emp.Count;

                    Emp.SetFilter(Emp."Employment Date", '<=%1', LastYearButOne);
                    if FindSet() then
                        FemaleLNumberofEmployees := Emp.Count;//LNumberofEmployees
                end;


                //Number of male Sacco Employees
                Emp.reset;
                Emp.SetFilter(Emp.Status, '%1', Emp.Status::Active);
                Emp.SetFilter(Emp.Gender, '%1', Emp.Gender::Male);
                if FindSet() then begin
                    Emp.SetFilter(Emp."Employment Date", '<=%1', EndofLastyear);
                    if FindSet() then
                        maleNumberofEmployees := Emp.Count;

                    Emp.SetFilter(Emp."Employment Date", '<=%1', LastYearButOne);
                    if FindSet() then
                        maleLNumberofEmployees := Emp.Count;//LNumberofEmployees
                end;
                //End ofNumber of male Sacco Employees



                //Financials
                //Total Assets
                Cashatbank := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::CashAndEquivalents);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Cashatbank += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                end;
                LCashatbank := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::CashAndEquivalents);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LCashatbank += GLEntry.Amount;

                        end;
                    until GLAccount.Next = 0;

                end;

                //End of Cash and Cash Equivalents
                //Receivables And Prepayments
                ReceivableandPrepayments := 0;
                LReceivableandPrepayments := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::ReceivablesAndPrepayements);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ReceivableandPrepayments += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::ReceivablesAndPrepayements);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LReceivableandPrepayments += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                //End of Receivables and Prepayments
                //LoanandAdvances
                LoanandAdvances := 0;
                LLoanandAdvances := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::LoansAndAdvances);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LoanandAdvances += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::LoansAndAdvances);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LLoanandAdvances += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                //EndofLoanandAdavances
                //Financial Assets
                FinancialAssets := 0;
                LFinancialAssets := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::FinancialAssets);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            FinancialAssets += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::FinancialAssets);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LFinancialAssets += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                //End Of Financial Assets


                //Property,Plant and equipment
                PropertyEquipment := 0;
                LPropertyEquipment := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::propertyplantandEquipment);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            PropertyEquipment += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::propertyplantandEquipment);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LPropertyEquipment += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                //End of propert plant and Equipments
                //intangible assets
                IntangibleAssets := 0;
                LIntangibleAssets := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::Intangiableassets);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            IntangibleAssets += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                end;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::Intangiableassets);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LIntangibleAssets += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                end;
                TotalAssets := Cashatbank + ReceivableandPrepayments + LoanandAdvances + FinancialAssets + PropertyEquipment + IntangibleAssets;
                LTotalAssets := LCashatbank + LReceivableandPrepayments + LLoanandAdvances + LFinancialAssets + LPropertyEquipment + LIntangibleAssets;


                //End of Total assets

                //Member Deposits

                Nonwithdrawabledeposits := 0;
                LNonwithdrawabledeposits := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::MemberDeposits);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Nonwithdrawabledeposits += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                end;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::MemberDeposits);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LNonwithdrawabledeposits += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                end;
                //end of Member deposits

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

                //End of Member Dividends
                //LoanandAdvances
                LoanandAdvances := 0;
                LLoanandAdvances := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::LoansAndAdvances);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LoanandAdvances += GLEntry.Amount;

                        end;

                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::LoansAndAdvances);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LLoanandAdvances += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                //EndofLoanandAdavances
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
                //Total Revenue
                TotalRevenue := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Financials, '%1', GLAccount.Financials::Expenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TotalRevenue += 1 * GLEntry.Amount;

                        end;
                    until GLAccount.Next = 0;
                end;
                LTotalRevenue := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Financials, '%1', GLAccount.Financials::Expenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LTotalRevenue += 1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //End Total Revenue
                //Total interest Income
                TotalInteresstIncome := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Financials, '%1', GLAccount.Financials::InterestIncome);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TotalInteresstIncome += 1 * GLEntry.Amount;

                        end;
                    until GLAccount.Next = 0;
                end;
                LTotalInteresstIncome := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Financials, '%1', GLAccount.Financials::InterestIncome);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LTotalInteresstIncome += 1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //End Total Interest Income
                //Total Expenses
                TotalExpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Financials, '%1', GLAccount.Financials::Expenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TotalExpenses += 1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                LTotalExpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Financials, '%1', GLAccount.Financials::Expenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LTotalExpenses += 1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //End Total Interest Income


                //short term Liabilities
                //LIABILITIES
                //Member Deposits
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::MemberDeposits);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Nonwithdrawabledeposits += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                end;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::MemberDeposits);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LNonwithdrawabledeposits += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                end;

                // EmdMember deposits
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

                //End of Dividends
                //TradeandOtherPayables
                TradeandOtherPayables := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::TradeandotherPayables);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TradeandOtherPayables += -1 * GLEntry.Amount;

                        end;
                    until GLAccount.Next = 0;
                end;
                LTradeandOtherPayables := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::TradeandotherPayables);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LTradeandOtherPayables += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //EndofTradeAndotherPayables


                //Honoraria
                Hononaria := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::Honoria);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Hononaria += -1 * GLEntry.Amount;

                        end;
                    until GLAccount.Next = 0;
                end;
                LHononaria := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::Honoria);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LHononaria += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //EndofHonaria
                //TaxPayable
                TaxPayable := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::Taxpayable);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TaxPayable += -1 * GLEntry.Amount;

                        end;
                    until GLAccount.Next = 0;
                end;
                LTaxPayable := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::Taxpayable);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LTaxPayable += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //EndofTaxpayable
                shortTermLiabilities := Nonwithdrawabledeposits + InterestonMemberdeposits + TradeandOtherPayables + Hononaria + TaxPayable;
                LshortTermLiabilities := LNonwithdrawabledeposits + LInterestonMemberdeposits + LTradeandOtherPayables + LHononaria + LTaxPayable;
                //End of short term Liabliies


                Cashatbank := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::CashAndEquivalents);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Cashatbank += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                end;
                LCashatbank := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::CashAndEquivalents);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LCashatbank += GLEntry.Amount;

                        end;
                    until GLAccount.Next = 0;

                end;

                LiquidAssetstoTotalassetsshorttermliabilities := (Cashatbank / shortTermLiabilities) * 100;
                LLiquidAssetstoTotalassetsshorttermliabilities := (LCashatbank / LshortTermLiabilities) * 100;
                LiquidAssetsTotalAssets := (Cashatbank / TotalAssets) * 100;
                LLiquidAssetsTotalAssets := (LCashatbank / LTotalAssets) * 100;

                GrossLoansdeposits := (LoanandAdvances / Nonwithdrawabledeposits) * 100;
                LGrossLoansdeposits := (LLoanandAdvances / LNonwithdrawabledeposits) * 100;

                LGrossLoansTotalAssets := (LLoanandAdvances / LTotalAssets) * 100;
                GrossLoansTotalAssets := (LoanandAdvances / TotalAssets) * 100;

                TotalExpensesTotalRevenue := (TotalExpenses / TotalRevenue) * 100;
                LTotalExpensesTotalRevenue := (LTotalExpenses / LTotalRevenue) * 100;

                TotalExpensesTotalAssets := (TotalExpenses / TotalAssets) * 100;
                LTotalExpensesTotalAssets := (LTotalExpenses / LTotalAssets) * 100;

                DividendsTotalRevenue := (InterestonMemberdeposits / TotalRevenue) * 100;
                LDividendsTotalRevenue := (LInterestonMemberdeposits / LTotalRevenue) * 100;



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
    }

    var
        TotalRevenue: Decimal;
        DividendsTotalRevenue: Decimal;
        LDividendsTotalRevenue: Decimal;
        LTotalRevenue: Decimal;
        TotalInteresstIncome: Decimal;
        LTotalInteresstIncome: Decimal;
        TotalExpenses: Decimal;
        LTotalExpenses: Decimal;
        LiquidAssetsTotalAssets: Decimal;
        LLiquidAssetsTotalAssets: Decimal;
        GrossLoansTotalAssets: Decimal;
        LGrossLoansTotalAssets: Decimal;
        GrossLoansdeposits: Decimal;
        LGrossLoansdeposits: Decimal;


        Cust: Record Customer;
        Active: Integer;
        Dormant: Integer;
        LActive: Integer;
        LDormant: Integer;
        LongtermLiablities: Decimal;

        TotalExpensesTotalRevenue: Decimal;
        LTotalExpensesTotalRevenue: Decimal;
        TotalExpensesTotalAssets: Decimal;
        LTotalExpensesTotalAssets: Decimal;

        LLongtermliabilities: Decimal;
        CorecapitaltoAssetsRatio: Decimal;
        CorecapitaltoDepositsRatio: Decimal;
        ExternalBorrowingtoAssetsRatio: Decimal;
        LExternalBorrowingtoAssetsRatio: Decimal;
        LCorecapitaltoDepositsRatio: Decimal;
        LCorecapitaltoAssetsRatio: Decimal;
        LiquidAssetstoTotalassetsshorttermliabilities: Decimal;
        LLiquidAssetstoTotalassetsshorttermliabilities: Decimal;
        LiquidAssets: Decimal;
        LLiquidAssets: Decimal;
        GLEntry: Record "G/L Entry";
        Asat: Date;
        CoreCapitalOldLastyear: Decimal;
        CoreCapitalOldLastyearButone: Decimal;
        Corecapital: Decimal;
        LCorecapital: Decimal;
        NetSurplusaftertax: Decimal;
        LNetSurplusaftertax: Decimal;
        InvestmentsinSubsidiary: Decimal;
        LInvestmentsinSubsidiary: Decimal;
        FinancialAssets: Decimal;
        LFinancialAssets: Decimal;
        Otherinvestments: Decimal;
        StartDate: Date;
        CurrentYear: Integer;
        shortTermLiabilities: Integer;
        LshortTermLiabilities: Integer;
        PreviousYear: Integer;
        EndofLastyear: date;
        LastYearButOne: Date;
        FemaleNumberofEmployees: Integer;
        FemaleLNumberofEmployees: Integer;
        MaleNumberofEmployees: Integer;
        MaleLNumberofEmployees: Integer;
        Emp: Record Employee;
        TotalAssets: Decimal;
        LTotalAssets: Decimal;
        SubsidiaryandRelated: Decimal;
        GL: Record "G/L Account";
        DepositAmount: Decimal;
        LDepositAmount: Decimal;
        LoanBalance: Decimal;
        LLoanBalance: Decimal;
        Equityinvestment: Decimal;
        StatutoryReserves: Decimal;
        LStatutoryReserves: Decimal;
        RevenueReservers: Decimal;
        LRevenueReservers: Decimal;

        LInvestmentProperties: Decimal;
        Hononaria: Decimal;
        LHononaria: Decimal;
        ShareCapitalValue: Decimal;
        LPropertyEquipment: Decimal;
        LPrepaidLeaseentals: Decimal;
        LIntangibleAssets: Decimal;
        LOtherAssets: Decimal;

        LInterestonMemberDeposits: Decimal;
        InterestonMemberdeposits: Decimal;

        ReceivableandPrepayments: Decimal;
        LReceivableandPrepayments: Decimal;
        LoanandAdvances: Decimal;
        LLoanandAdvances: Decimal;

        PropertyPlantandequipment: Decimal;
        LPropertyPlantandequipment: Decimal;
        CompanyInformation: Record "Company Information";
#pragma warning restore AL0275
        Cashinhand: Decimal;
        FinancialYear: Integer;

        Cashatbank: Decimal;
        LCashatbank: Decimal;
        LCashinhand: Decimal;
        CashCashEquivalent: Decimal;
        LCashCashEquivalent: Decimal;
#pragma warning disable AL0275

        LGrossLoanPortfolio: Decimal;
        GLAccount: Record "G/L Account";
#pragma warning restore AL0275
        DateFilter: Text;
        Date: Date;
        DateFilter11: Text;

        PrepaymentsSundryReceivables: Decimal;
        FinancialInvestments: Decimal;
        LFinancialInvestments: Decimal;
        GovernmentSecurities: Decimal;
        Placement: Decimal;
        CommercialPapers: Decimal;
        CollectiveInvestment: Decimal;
        Derivatives: Decimal;
        EquityInvestments: Decimal;
        Investmentincompanies: Decimal;
        LInvestmentincompanies: Decimal;
        GrossLoanPortfolio: Decimal;
        PropertyEquipment: Decimal;
        AllowanceforLoanLoss: Decimal;
        Nonwithdrawabledeposits: Decimal;
        LNonwithdrawabledeposits: Decimal;
        TaxPayable: Decimal;
        LTaxPayable: Decimal;
        RetirementBenefitsLiability: Decimal;
        OtherLiabilities: Decimal;
        DeferredTaxLiability: Decimal;
        ExternalBorrowings: Decimal;
        TotalLiabilities: Decimal;
        ShareCapital: Decimal;
        LShareCapital: Decimal;
        StatutoryReserve: Decimal;
        LStatutoryReserve: Decimal;
        OtherReserves: Decimal;
        RevaluationReserves: Decimal;
        ProposedDividends: Decimal;
        AdjustmenttoEquity: Decimal;
        PrioryarRetainedEarnings: Decimal;
        CurrentYearSurplus: Decimal;
        TaxRecoverable: Decimal;
        DeferredTaxAssets: Decimal;
        RetirementBenefitAssets: Decimal;
        OtherAssets: Decimal;
        IntangibleAssets: Decimal;
        PrepaidLeaseentals: Decimal;
        InvestmentProperties: Decimal;
        DividendPayable: Decimal;
        LDividendPayable: Decimal;
        TradeandOtherPayables: Decimal;
        LTradeandOtherPayables: Decimal;
        NetLoanPortfolio: Decimal;
        AccountsReceivables: Decimal;
        PropertyEquipmentOtheassets: Decimal;
        LPropertyEquipmentOtheassets: Decimal;
        AccountsPayableOtherLiabilities: Decimal;
        CapitalGrants: Decimal;
        EQUITY: Decimal;
        RetainedEarnings: Decimal;
        OtherEquityAccounts: Decimal;
        TotalEquity: Decimal;
        TotalLiabilitiesandEquity: Decimal;
        TotalLiabilitiesNew: Decimal;



}