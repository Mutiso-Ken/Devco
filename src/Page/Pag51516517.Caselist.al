#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516517 "Case list"
{
    ApplicationArea = Basic;
    CardPageID = "Cases Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Cases Management";
    SourceTableView = where(Status = filter(Open));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Complaint"; Rec."Date of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Type of cases"; Rec."Type of cases")
                {
                    ApplicationArea = Basic;
                }
                field("Recommended Action"; Rec."Recommended Action")
                {
                    ApplicationArea = Basic;
                }
                field("Case Description"; Rec."Case Description")
                {
                    ApplicationArea = Basic;
                }
                field("Resource#1"; Rec."Resource#1")
                {
                    ApplicationArea = Basic;
                }
                field("Resource #2"; Rec."Resource #2")
                {
                    ApplicationArea = Basic;
                }
                field("Action Taken"; Rec."Action Taken")
                {
                    ApplicationArea = Basic;
                }
                field("Date To Settle Case"; Rec."Date To Settle Case")
                {
                    ApplicationArea = Basic;
                }
                field("Document Link"; Rec."Document Link")
                {
                    ApplicationArea = Basic;
                }
                field("solution Remarks"; Rec."solution Remarks")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
                field("Case Solved"; Rec."Case Solved")
                {
                    ApplicationArea = Basic;
                }
                field("Body Handling The Complaint"; Rec."Body Handling The Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(Recomendations; Rec.Recomendations)
                {
                    ApplicationArea = Basic;
                }
                field(Implications; Rec.Implications)
                {
                    ApplicationArea = Basic;
                }
                field("Support Documents"; Rec."Support Documents")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Lodging the Complaint"; Rec."Mode of Lodging the Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Resource Assigned"; Rec."Resource Assigned")
                {
                    ApplicationArea = Basic;
                }
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = Basic;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Fosa Account"; Rec."Fosa Account")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("loan no"; Rec."loan no")
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

