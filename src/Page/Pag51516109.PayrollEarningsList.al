#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516109 "Payroll Earnings List"
{
    ApplicationArea = Basic;
    CardPageID = "Payroll Earnings Card";
    PageType = List;
    SourceTable = "Payroll Transaction Code";
    SourceTableView = where("Transaction Type"=const(Income));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code";"Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Name";"Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Taxable;Taxable)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
          "Transaction Type":="transaction type"::Income;
    end;
}

