tableextension 51516044 "GlAccountExt" extends "G/L Account"
{
    fields
    {
        field(1000; "Budget Controlled"; Boolean)
        {
            Caption = 'Budget Controlled';
            DataClassification = ToBeClassified;
        }
        field(1002; "Expense Code"; Code[100])
        {
            Caption = 'Expense Code';
            DataClassification = ToBeClassified;
        }
        field(1003; "GL Account Balance"; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}
