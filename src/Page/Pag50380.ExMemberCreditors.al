page 50380 "Ex_MemberCreditors"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Ex_Member Creditors';
    CardPageID = "Vendor Card";
    Editable = false;
    PageType = List;
    SourceTable = Vendor;
    UsageCategory = Lists;
    SourceTableView = sorting("No.") order(ascending) where("Vendor Posting Group" = const('MCREDITOR'));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique number that identifies the vendor. You can assign numbers automatically based on a number series or assign them manually.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor''s name that appears on all related documents. For companies, specify the company''s name here, and then add the relevant people as contacts that you link to this vendor.';
                }
                field(Balance; Balance)
                {
                    ApplicationArea = All;
                }


            }
        }
    }
}

