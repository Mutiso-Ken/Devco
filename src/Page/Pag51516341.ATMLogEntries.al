#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516341 "ATM Log Entries"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "ATM Log Entries";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No";"Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Time";"Date Time")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("ATM No";"ATM No")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Location";"ATM Location")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Return Code";"Return Code")
                {
                    ApplicationArea = Basic;
                }
                field("Trace ID";"Trace ID")
                {
                    ApplicationArea = Basic;
                }
                field("Account No.";"Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Card No.";"Card No.")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Amount";"ATM Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Location";"Withdrawal Location")
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

