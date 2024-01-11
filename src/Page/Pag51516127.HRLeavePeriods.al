page 51516127 "HR Leave Periods"
{
    ApplicationArea = All;
    Caption = 'HR Leave Periods';
    PageType = List;
    SourceTable = "HR Leave Periods";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field("Period Code"; Rec."Period Code")
                {
                    ToolTip = 'Specifies the value of the Period Code field.';
                }
                field("Period Description"; Rec."Period Description")
                {
                    ToolTip = 'Specifies the value of the Period Description field.';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field("Date Closed"; Rec."Date Locked")
                {
                    ToolTip = 'Specifies the value of the Date Locked field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }

            }
        }
    }
}
