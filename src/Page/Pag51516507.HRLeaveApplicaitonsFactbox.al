#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516507 "HR Leave Applicaitons Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Employee";
    Caption = 'Employee Leave Details';

    layout
    {
        area(content)
        {
            field("No."; "No.")
            {
                ApplicationArea = Basic;
            }
            field("First Name"; "First Name")
            {
                ApplicationArea = Basic;
            }
            field("Middle Name"; "Middle Name")
            {
                ApplicationArea = Basic;
            }
            field("Job Title"; Position)
            {
                ApplicationArea = Basic;
            }
            field(Status; Status)
            {
                ApplicationArea = Basic;
                Caption = 'Employee Status';
                Style = Ambiguous;
            }
            field("E-Mail"; "E-Mail")
            {
                ApplicationArea = Basic;
                Caption = 'Company Email';
            }
            field("Email Address"; "Email Address")
            {
                ApplicationArea = Basic;
                Caption = 'Personal Email';
            }
            field("Allocated Leave Days"; "Allocated Leave Days")
            {
                ApplicationArea = Basic;
                Caption = 'Total Leave Days Allocated';
                Style = Ambiguous;
                StyleExpr = true;
            }
            field("Total Leave Taken"; "Total Leave Taken")
            {
                ApplicationArea = Basic;
                Caption = 'Total Leave Days Taken';
                Style = Ambiguous;
                StyleExpr = true;
            }
            field("Annual Leave Account"; "Annual Leave Account")
            {
                ApplicationArea = Basic;
                Caption = 'Remaining Annual Leave Days';
                Style = Ambiguous;
                StyleExpr = true;
            }
            field("Compassionate Leave Acc."; "Compassionate Leave Acc.")
            {
                ApplicationArea = Basic;
                Caption = 'Remaining Compassionate Leave Days';
                Style = Ambiguous;
                StyleExpr = true;
            }
            field("Maternity Leave Acc."; "Maternity Leave Acc.")
            {
                ApplicationArea = Basic;
                Caption = 'Remaining Maternity Leave Days';
                Style = Ambiguous;
                StyleExpr = true;
            }
            field("Paternity Leave Acc."; "Paternity Leave Acc.")
            {
                ApplicationArea = Basic;
                Caption = 'Remaining Paternity Leave Days';
                Style = Ambiguous;
                StyleExpr = true;
            }
            field("Sick Leave Acc."; "Sick Leave Acc.")
            {
                ApplicationArea = Basic;
                Caption = 'Remaining Sick Leave Days';
                Style = Ambiguous;
                StyleExpr = true;
            }
        }
    }

    actions
    {
    }

    var
        Text1: label 'Employee Details';
        Text2: label 'Employeee Leave Details';
    //Text3: ;
}

