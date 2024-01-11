#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516189 "HR Leave Periods"
{
    Caption = 'Leave Periods';

    fields
    {
        field(1; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                Name := Format("Starting Date", 0, Text000);
            end;
        }
        field(2; Name; Text[10])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(3; "New Fiscal Year"; Boolean)
        {
            Caption = 'New Fiscal Year';

            trigger OnValidate()
            begin
                TestField("Date Locked", false);
            end;
        }
        field(4; Closed; Boolean)
        {
            Caption = 'Closed';
            Editable = false;
        }
        field(5; "Date Locked"; Boolean)
        {
            Caption = 'Date Locked';
            Editable = false;
        }
        field(6; "Reimbursement Clossing Date"; Boolean)
        {
        }
        field(7; "Period Description"; Text[150])
        {
            trigger OnValidate()
            begin
                Name := Format("Period Description");
            end;
        }
        field(8; "Period Code"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Starting Date", "Period Code")
        {
            Clustered = true;
        }
        key(Key2; "New Fiscal Year", "Date Locked")
        {
        }
        key(Key3; Closed)
        {
        }
        key(Key4; "Period Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

    end;

    trigger OnInsert()
    begin


    end;

    trigger OnModify()
    begin

    end;

    trigger OnRename()
    begin


    end;

    var
        Text000: label '<Month Text>';
        AccountingPeriod2: Record "HR Leave Periods";
        InvtSetup: Record "Inventory Setup";

}

