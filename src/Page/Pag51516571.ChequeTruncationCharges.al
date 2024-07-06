#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516571 "Cheque Truncation Charges"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Cheque Processing Charges";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = Basic;
                }
                field(Charges; Rec.Charges)
                {
                    ApplicationArea = Basic;
                }
                field(Range; Rec.Range)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

