page 51901 "Basic Pay Changes"
{
    Editable = false;
    PageType = List;
    SourceTable = "Basic Pay Changes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payroll No"; Rec."Payroll No")
                {
                }
                field("Old Pay"; Rec."Old Pay")
                {
                }
                field("New Pay"; Rec."New Pay")
                {
                }
                field("Date effected"; Rec."Date effected")
                {
                }
                field("Effected By"; Rec."Effected By")
                {
                }
            }
        }
    }

    actions
    {
    }
}

