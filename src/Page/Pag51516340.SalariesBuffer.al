#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516340 "Salaries Buffer"
{
    ApplicationArea = Basic;
    Editable = true;
    PageType = List;
    SourceTable = "Salary Processing Lines";
    SourceTableView = where(Processed = const(false));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Staff No."; "Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Grower No."; "Grower No.")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Branch Reff."; "Branch Reff.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Original Account No."; "Original Account No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Not Found"; "Account Not Found")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Date; Date)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Blocked Accounts"; "Blocked Accounts")
                {
                    ApplicationArea = Basic;
                    Caption = 'Blocked Accounts';
                    Editable = false;
                    Visible = true;
                }
                field("Multiple Salary"; "Multiple Salary")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field(USER; USER)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Salaries)
            {
                Caption = 'Salaries';
                action(Import)
                {
                    ApplicationArea = Basic;
                    Caption = 'Import';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = XMLport "Import Salaries";
                }
                separator(Action1102760018)
                {
                }
                action("Import Tea")
                {
                    ApplicationArea = Basic;
                    Caption = 'Import Tea';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = XMLport "Import Tea";
                }
                action("Confirm Account Names")
                {
                    ApplicationArea = Basic;
                    Caption = 'Confirm Account Names';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Report "Confirm Account Names";
                }
                separator(Action1102760032)
                {
                }
                action("Generate Salaries Batch")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generate Salaries Batch';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Report "Generate Salaries Batch";
                }
                separator(Action1000000009)
                {
                }
                action("Process Tea")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "Tea Batch";
                }
                action("Process Tea Bonus")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "Process Tea Bonus";
                }
                separator(Action1102760024)
                {
                }
                action("Generate Milk Batch")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generate Milk Batch';
                    Image = "report";
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Report "Milk Batch";
                }
                separator(Action1000000007)
                {
                }
                separator(Action1102760042)
                {
                }
                action("Mark as processed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mark as processed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Report "Mark as Processed";
                }
                separator(Action1102760043)
                {
                }
                
            }
        }
    }

    trigger OnOpenPage()
    begin

        SetRange(USER, UserId);
    end;
}

