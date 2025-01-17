#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516920 "Loans Reschedule  List"
{
    ApplicationArea = Basic;
    CardPageID = "Loan Reschedule Card";
    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Loans Register";
    SourceTableView = where(Posted=filter(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan  No.";"Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type";"Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code";"Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member  No';
                }
                field("Group Code";"Group Code")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name";"Client Name")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount";"Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount";"Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status";"Loan Status")
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date";"Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Date of Completion";"Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                }
                field(Installments;Installments)
                {
                    ApplicationArea = Basic;
                }
                field(Repayment;Repayment)
                {
                    ApplicationArea = Basic;
                }
                field("Rejection  Remark";"Rejection  Remark")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance";"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Oustanding Interest";"Oustanding Interest")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000001;"Loans Sub-Page List")
            {
                SubPageLink = "No. Series"=field("Client Code");
            }
        }
    }

    actions
    {
    }
}

