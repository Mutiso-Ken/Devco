page 51796 "Payroll Bank Details"
{
    DeleteAllowed = true;
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Bank deatails";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    ApplicationArea = All;
                }
                field("Bank Location"; Rec."Bank Location")
                {
                    ApplicationArea = All;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

