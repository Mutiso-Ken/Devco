#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516344 "loans Cuess"
{

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
        }
        field(2; "Applied Loans"; Integer)
        {
            CalcFormula = COUNT("Loans Register" WHERE("Approval Status" = CONST(Open), "Approved Amount" = filter(> 0), "Loan Status" = const(Application), Source = const(BOSA)));
            FieldClass = FlowField;

        }
        field(3; "Active Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), Source = const(BOSA)));
            FieldClass = FlowField;
        }
        field(4; "Pending Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Pending), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), Source = const(BOSA)));
            FieldClass = FlowField;
        }

        // field(5; "Applied FOSA Loans"; Integer)
        // {
        //     CalcFormula = COUNT("Loans Register" WHERE("Approval Status" = CONST(Open), "Approved Amount" = filter(> 0), "Loan Status" = const(Application), Source = const(FOSA)));
        //     FieldClass = FlowField;

        // }
        // field(6; "Active FOSA Loans"; Integer)
        // {
        //     CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), Source = const(FOSA)));
        //     FieldClass = FlowField;
        // }
        // field(7; "Pending FOSA Loans"; Integer)
        // {
        //     CalcFormula = count("Loans Register" where("Approval Status" = const(Pending), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), Source = const(FOSA)));
        //     FieldClass = FlowField;
        // }


        field(8; "Applied MICRO Loans"; Integer)
        {
            CalcFormula = COUNT("Loans Register" WHERE("Approval Status" = CONST(Open), "Approved Amount" = filter(> 0), "Loan Status" = const(Application), Source = const(MICRO)));
            FieldClass = FlowField;

        }
        field(9; "Active MICRO Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), Source = const(MICRO)));
            FieldClass = FlowField;
        }
        field(10; "Pending MICRO Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Pending), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), Source = const(MICRO)));
            FieldClass = FlowField;
        }


    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


