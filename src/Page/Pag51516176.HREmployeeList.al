#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516176 "HR Employee List"
{
    CardPageID = "Employees Card";
    DeleteAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Employee';
    SourceTable = "HR Employee";
    SourceTableView = where(Status = const(Active),
                            IsCommette = const(false),
                            IsBoard = const(false));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = true;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(Grade; Grade)
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Grade';
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Cell Phone Number"; "Cell Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
        }
    }

    actions
    {
        area(navigation)
        {
            group(Employee)
            {
                Caption = 'Employee';
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                }
                action("Kin/Beneficiaries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Kin/Beneficiaries';
                    Image = Relatives;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                }
                action("Employee Attachments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;
                }
                action("Employement History")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employement History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                }
                action("Employee Qualifications")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                }
                action("Assigned Assets")
                {
                    ApplicationArea = Basic;
                    Caption = 'Assigned Assets';
                    Image = ResourceJournal;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                }
                action("HR Leave Journal Lines")
                {
                    ApplicationArea = Basic;
                    Caption = 'HR Leave Journal Lines';
                    Image = ResourceJournal;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                }
            }
        }
    }

    trigger OnInit()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Post Leave Days Allocations" then
                Error('Denied Access');
        end else begin
            Error('Denied Access');
        end;

    end;

    var
        HREmp: Record "HR Employee";
        EmployeeFullName: Text;
        PayrollEmployee: Record "Payroll Employee";
        User: Record User;
}

