page 51516108 "HR General Setup"
{
    ApplicationArea = All;
    Caption = 'HR General Setup';
    PageType = List;
    SourceTable = "HR General Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Leave Application Nos."; Rec."Leave Application Nos.")
                {
                    ToolTip = 'Specifies the value of the Leave Application Nos. field.';
                }
                field("Base Calendar"; Rec."Base Calendar")
                {
                    ToolTip = 'Specifies the value of the Base Calendar field.';
                }
                field("Default Leave Posting Template"; Rec."Default Leave Posting Template")
                {
                    ToolTip = 'Specifies the value of the Default Leave Posting Template field.';
                }
                field("Employee Nos"; Rec."Employee Nos")
                {
                    ToolTip = 'Specifies the value of the Employee Nos field.';
                }
                field("Job Nos"; Rec."Job Nos")
                {
                    ToolTip = 'Specifies the value of the Job Nos field.';
                }

                field("Leave Batch"; Rec."Leave Batch")
                {
                    ToolTip = 'Specifies the value of the Leave Batch field.';
                }
                field("Leave Posting Period[FROM]"; Rec."Leave Posting Period[FROM]")
                {
                    ToolTip = 'Specifies the value of the Leave Posting Period[FROM] field.';
                }
                field("Leave Posting Period[TO]"; Rec."Leave Posting Period[TO]")
                {
                    ToolTip = 'Specifies the value of the Leave Posting Period[TO] field.';
                }
                field("Leave Reimbursment Nos."; Rec."Leave Reimbursment Nos.")
                {
                    ToolTip = 'Specifies the value of the Leave Reimbursment Nos. field.';
                }
                field("Leave Template"; Rec."Leave Template")
                {
                    ToolTip = 'Specifies the value of the Leave Template field.';
                }
                field("Min. Leave App. Months"; Rec."Min. Leave App. Months")
                {
                    ToolTip = 'Specifies the value of the Min. Leave App. Months field.';
                }
                field("Payroll Nos"; Rec."Payroll Nos")
                {
                    ToolTip = 'Specifies the value of the Payroll Nos field.';
                }
                field("Positive Leave Posting Batch"; Rec."Positive Leave Posting Batch")
                {
                    ToolTip = 'Specifies the value of the Positive Leave Posting Batch field.';
                }
                field("Primary Key"; Rec."Primary Key")
                {
                    ToolTip = 'Specifies the value of the Primary Key field.';
                }
            }
        }
    }
}
