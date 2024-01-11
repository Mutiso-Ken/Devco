#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516119 "Hr Training Projection List"
{
    CardPageID = "Hr Training Projections Card";
    PageType = List;
    SourceTable = "Hr Training Projections";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Training Code"; "Training Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Name of Program"; "Name of Program")
                {
                    ApplicationArea = Basic;
                }
                field("Target Group"; "Target Group")
                {
                    ApplicationArea = Basic;
                }
                field("No of Employees"; "No of Employees")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Duration)
                {
                    ApplicationArea = Basic;
                }
                field(Trainer; Trainer)
                {
                    ApplicationArea = Basic;
                }
                field(Quater; Quater)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control11; Outlook)
            {
            }
            systempart(Control12; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

