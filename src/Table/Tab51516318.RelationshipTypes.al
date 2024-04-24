#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516318 "Relationship Types"
{
    DrillDownPageID = "Relationship list";
    LookupPageID = "Relationship list";

    fields
    {
        field(1;"code";Code[30])
        {
        }
        field(2;Describution;Text[30])
        {
        }
    }

    keys
    {
        key(Key1;"code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

