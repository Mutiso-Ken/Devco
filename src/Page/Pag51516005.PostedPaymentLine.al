#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516005 "Posted Payment Line"
{
    PageType = List;
    SourceTable = "Payment Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payment Type"; "Payment Type")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type Description"; "Transaction Type Description")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Description"; "Payment Description")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount(LCY)"; "Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Code"; "VAT Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("VAT Amount"; "VAT Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }

                field("VAT Amount(LCY)"; "VAT Amount(LCY)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("W/TAX Code"; "W/TAX Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("W/TAX Amount"; "W/TAX Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("W/TAX Amount(LCY)"; "W/TAX Amount(LCY)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Net Amount"; "Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount(LCY)"; "Net Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Applies-to Doc. Type"; "Applies-to Doc. Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Applies-to ID"; "Applies-to ID")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

