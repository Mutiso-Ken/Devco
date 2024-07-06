#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516900 "Micro Finance Trans Posted"
{
    ApplicationArea = Basic;
    CardPageID = Micro_Fin_Transactions;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Micro_Fin_Transactions;
    SourceTableView = where(Posted = filter(true));
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if UserId <> 'MMHSACCO\SWAWERU' then begin
            Rec.SetRange("Posted By", UserId)
        end;

    end;
}

