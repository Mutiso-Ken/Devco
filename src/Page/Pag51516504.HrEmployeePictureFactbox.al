page 51516504 "HrEmployeePictureFactbox"
{
    Caption = 'Employee Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "HR Employee";

    layout
    {
        area(content)
        {
            field(Photo; Photo)
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the picture of the employee.';
                ShowMandatory = true;
            }
        }
    }
}

