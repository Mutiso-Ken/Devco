page 50381 EmployerReceivables
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customer;

    SourceTableView = sorting("No.")
                      order(ascending)
                      where("Customer Type" = filter(Checkoff));



    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Balance (LCY)"; "Balance (LCY)")
                {
                    Caption = 'Balance';
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
}