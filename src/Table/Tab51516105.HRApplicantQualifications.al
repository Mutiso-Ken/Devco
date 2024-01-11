#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516105 "HR Applicant Qualifications"
{

    fields
    {
        field(10; "No."; Code[10])
        {
        }
        field(11; "Application No"; Code[11])
        {
            TableRelation = "No. Series".Code;
        }
        field(12; "Employee No."; Code[10])
        {
        }
        field(13; "Qualification Type"; Code[10])
        {
        }
        field(14; "Qualification Code"; Code[10])
        {
        }
        field(15; "Qualification Description"; Text[100])
        {
        }
        field(16; "From Date"; Date)
        {
        }
        field(17; "To Date"; Date)
        {
        }
        field(18; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Internal,External,Previous Position';
            OptionMembers = " ",Internal,External,"Previous Position";
        }
        field(19; "Institution/Company"; Text[100])
        {
        }


    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

