XmlPort 51516449 "Import Tea"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Salary Processing Lines";"Salary Processing Lines")
            {
                XmlName = 'SalaryImport';
                fieldelement(account;"Salary Processing Lines"."Grower No.")
                {
                }
                fieldelement(Amount;"Salary Processing Lines".Amount)
                {
                }
                fieldelement(lineno;"Salary Processing Lines"."No.")
                {
                }
                fieldelement(Type;"Salary Processing Lines".Type)
                {
                }
            }
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
}

