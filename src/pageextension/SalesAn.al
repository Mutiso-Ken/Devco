pageextension 51516884 "Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Blanket Order Nos.")
        {
            field("BOSA Transfer Nos"; "BOSA Transfer Nos")
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