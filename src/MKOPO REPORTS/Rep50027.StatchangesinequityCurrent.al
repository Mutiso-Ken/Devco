report 50027 StatchangesinequityCurrent
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'satement of changes in equity Current Period';
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
            column(EndofLastyear; EndofLastyear)
            {

            }
            column(LastYearButOne; LastYearButOne)
            {

            }
            column(PreviousYear; PreviousYear)
            {

            }
            column(CurrentYear; CurrentYear)
            {

            }
            column(StartofPreviousyear; StartofPreviousyear) { }
            column(StartofLastYearButOne; StartofLastYearButOne) { }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                DateExpr: Text;
                InputDate: Date;
                DateFormula: Text;
                DateFormulaOne: text;
                DateFormulaTwo: Text;

            begin
                DateFormula := '<-CY-1D>';
                DateExpr := '<-1y>';
                InputDate := Asat;
                DateFormulaOne := '<-CY>';

                EndofLastyear := InputDate;
                StartofPreviousyear := CalcDate(DateFormulaOne, AsAt);
                StartofLastYearButOne := CalcDate(DateFormulaTwo, AsAt);
                CurrentYear := Date2DMY(EndofLastyear, 3);
                LastYearButOne := CalcDate(DateExpr, EndofLastyear);
                PreviousYear := CurrentYear - 1;
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
        PreviousYear: Integer;
        CurrentYear: Integer;
        StartofPreviousyear: Date;
        EndofLastyear: date;
        LastYearButOne: Date;
        StartofLastYearButOne: Date;


}