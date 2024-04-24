#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516517 "Case list"
{
    ApplicationArea = Basic;
    CardPageID = "Cases Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Cases Management";
    SourceTableView = where(Status=filter(Open));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case Number";"Case Number")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Complaint";"Date of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Type of cases";"Type of cases")
                {
                    ApplicationArea = Basic;
                }
                field("Recommended Action";"Recommended Action")
                {
                    ApplicationArea = Basic;
                }
                field("Case Description";"Case Description")
                {
                    ApplicationArea = Basic;
                }
                field("Resource#1";"Resource#1")
                {
                    ApplicationArea = Basic;
                }
                field("Resource #2";"Resource #2")
                {
                    ApplicationArea = Basic;
                }
                field("Action Taken";"Action Taken")
                {
                    ApplicationArea = Basic;
                }
                field("Date To Settle Case";"Date To Settle Case")
                {
                    ApplicationArea = Basic;
                }
                field("Document Link";"Document Link")
                {
                    ApplicationArea = Basic;
                }
                field("solution Remarks";"solution Remarks")
                {
                    ApplicationArea = Basic;
                }
                field(Comments;Comments)
                {
                    ApplicationArea = Basic;
                }
                field("Case Solved";"Case Solved")
                {
                    ApplicationArea = Basic;
                }
                field("Body Handling The Complaint";"Body Handling The Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(Recomendations;Recomendations)
                {
                    ApplicationArea = Basic;
                }
                field(Implications;Implications)
                {
                    ApplicationArea = Basic;
                }
                field("Support Documents";"Support Documents")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Lodging the Complaint";"Mode of Lodging the Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Resource Assigned";"Resource Assigned")
                {
                    ApplicationArea = Basic;
                }
                field(Selected;Selected)
                {
                    ApplicationArea = Basic;
                }
                field("Closed By";"Closed By")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Fosa Account";"Fosa Account")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("loan no";"loan no")
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

