Page 51516508 "HR Leave Applications List"
{
    CardPageID = "HR Leave Application Card";
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HR Leave Application";
    SourceTableView = where(Status = filter(<> Posted));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                field("Application Code"; "Application Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                    StyleExpr = true;
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Type"; "Leave Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Days Applied"; "Days Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Return Date"; "Return Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Reliever Name"; "Reliever Name")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755006; "HR Leave Applicaitons Factbox")
            {
                SubPageLink = "No." = field("Employee No");
            }
            systempart(Control1102755004; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
    }

    trigger OnOpenPage()
    begin
        SetRange("User ID", UserId);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        LeaveAppTable: Record "HR Leave Application";
    begin
        LeaveAppTable.Reset();
        LeaveAppTable.SetRange(LeaveAppTable."User ID", "User ID");
        if LeaveAppTable.Find('-') then begin
            repeat
                if (LeaveAppTable.Status = LeaveAppTable.Status::New) or (LeaveAppTable.Status = LeaveAppTable.Status::Approved) or (LeaveAppTable.Status = LeaveAppTable.Status::"Pending Approval") then begin
                    Error('You have a ' + Format(LeaveAppTable.Status) + ' card that is not posted. Utilise it FIRST!');
                end;
            until LeaveAppTable.Next = 0;
        end;
    end;

    var
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        ApprovalEntries: Page "Approval Entries";
        ApprovalComments: Page "Approval Comments";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application";
        HRLeaveApp: Record "HR Leave Application";
        HREmp: Record "HR Employee";

}

