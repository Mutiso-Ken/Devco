#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516107 "Employees List"
{
    Caption = 'Employee List';
    CardPageID = "Employees Card";
    Editable = false;
    DeleteAllowed = false;
    //InsertAllowed = false;
    PageType = List;
    SourceTable = "HR Employee";
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(FullName; "Full Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Full Name';
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = Basic;
                }
                field(Initials; Initials)
                {
                    ApplicationArea = Basic;
                }
                field("Job Title"; Title)
                {
                    ApplicationArea = Basic;
                }
                field("Post Code"; "Postal Code")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; "Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No."; "Mobile Number")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail"; "Email Address")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1900383207; HrEmployeePictureFactbox)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {

        }
        area(processing)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                Image = Employee;
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = const(Employee),
                                  "No." = field("No.");
                    ToolTip = 'Make comment about employee';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                }
                action("&Picture")
                {
                    ApplicationArea = Basic;
                    Caption = '&Passport';
                    Image = Picture;
                    RunObject = Page "Employee Picture";
                    RunPageLink = "No." = field("No.");
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                }
                action("&Alternative Addresses")
                {
                    ApplicationArea = Basic;
                    Caption = '&Alternative Addresses';
                    Image = Addresses;
                    RunObject = Page "Alternative Address List";
                    RunPageLink = "Employee No." = field("No.");
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                }
                action("Relati&ves")
                {
                    ApplicationArea = Basic;
                    Caption = 'Relati&ves';
                    Image = Relatives;
                    RunObject = Page "Employee Relatives";
                    RunPageLink = "Employee No." = field("No.");
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                }
            }


            group(EmploymentRecords)
            {
                Visible = false;
                action("Absence Registration")
                {
                    ApplicationArea = Basic;
                    Caption = 'Absence Registration';
                    Image = Absence;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Absence Registration";
                }
                action("A&bsences")
                {
                    ApplicationArea = Basic;
                    Caption = 'A&bsences';
                    Image = Absence;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = field("No.");
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                }

                separator(Action51)
                {
                }
                action("Absences b&y Categories")
                {
                    ApplicationArea = Basic;
                    Caption = 'Absences b&y Categories';
                    Image = AbsenceCategory;
                    RunObject = Page "Empl. Absences by Categories";
                    RunPageLink = "No." = field("No."),
                                  "Employee No. Filter" = field("No.");
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                }

                action("Con&fidential Information")
                {
                    ApplicationArea = Basic;
                    Caption = 'Con&fidential Information';
                    Image = Lock;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = field("No.");
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                }

                action("Confidential Info. Overvie&w")
                {
                    ApplicationArea = Basic;
                    Caption = 'Confidential Info. Overvie&w';
                    Image = ConfidentialOverview;
                    RunObject = Page "Confidential Info. Overview";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                }
                group(EmployeeQualifications)
                {
                    action("Q&ualifications")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Q&ualifications';
                        Image = Certificate;
                        RunObject = Page "Employee Qualifications";
                        RunPageLink = "Employee No." = field("No.");
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                    }
                }
            }


        }

    }
    trigger OnOpenPage()
    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Accessed and read the Employee List page.');
    end;

    trigger OnClosePage()
    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Closed Employee List page.');
    end;

    var
        AuditLog: Codeunit "Audit Log Codeunit";
}


