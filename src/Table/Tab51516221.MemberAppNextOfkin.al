#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516221 "Member App Next Of kin"
{

    fields
    {
        field(1; "Account No"; Code[20])
        {
            TableRelation = "Membership Applications"."No.";
        }
        field(2; Name; Text[50])
        {
            NotBlank = true;
        }
        field(3; Relationship; Text[30])
        {
            TableRelation = "Relationship Types";
        }
        field(4; Beneficiary; Boolean)
        {
        }
        field(5; "Date of Birth"; Date)
        {
        }
        field(6; Address; Text[30])
        {
        }
        field(7; Telephone; Code[20])
        {
        }
        field(8; Fax; Code[10])
        {
        }
        field(9; Email; Text[30])
        {
        }
        field(11; "ID No."; Code[20])
        {
        }
        field(12; "%Allocation"; Decimal)
        {
            trigger OnValidate()
            begin
                SetAutoCalcFields("Total Allocation");
                //CalcFields("Total Allocation");
                if "Total Allocation" > 100 then
                    Error(' Total allocation should not  be greater than 100 %');
            end;
        }
        field(13; "Total Allocation"; Decimal)
        {
            CalcFormula = sum("Member App Next Of kin"."%Allocation" where("Account No" = field("Account No")));
            FieldClass = FlowField;

        }
        field(14; "Maximun Allocation %"; Decimal)
        {
        }
        field(15; Type; Option)
        {
            OptionCaption = 'Nominee,Spouse,Children';
            OptionMembers = "Next of Kin",Spouse,"Benevolent Beneficiary";
        }
    }

    keys
    {
        key(Key1; "Account No", Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    begin

    end;

    trigger OnRename()
    begin

    end;

    trigger OnModify()
    begin

    end;
}

