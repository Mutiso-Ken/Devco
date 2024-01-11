#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516183 "Payroll Employee Deductions"
{
    DeleteAllowed = true;
    PageType = ListPart;
    SourceTable = "Payroll Employee Transactions";
    SourceTableView = where("Transaction Type" = const(Deduction));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = Basic;
                    TableRelation = "Payroll Transaction Code"."Transaction Code" where("Transaction Type" = const(Deduction));
                }
                field("Transaction Name"; "Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        PayPeriod.Reset;
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then begin
            PPeriod := PayPeriod."Date Opened";

        end;
        SetFilter("Payroll Period", Format(PayPeriod."Date Opened"));
    end;

    var
        PayPeriod: Record "Payroll Calender";
        PPeriod: Date;
}

