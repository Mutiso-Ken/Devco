pageextension 51516886 "Fixed Asset List" extends "Fixed Asset List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}