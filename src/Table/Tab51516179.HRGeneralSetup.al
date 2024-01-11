#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516179 "HR General Setup"
{

    fields
    {
        field(10; "Primary Key"; Code[10])
        {
        }
        field(11; "Employee Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(12; "Payroll Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(13; "Leave Application Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(14; "Min. Leave App. Months"; Integer)
        {

        }
        field(15; "Base Calendar"; Code[50])
        {

        }
        field(16; "Leave Template"; Code[50])
        {

        }
        field(17; "Leave Batch"; Code[50])
        {

        }
        field(18; "Default Leave Posting Template"; Code[50])
        {

        }
        field(19; "Positive Leave Posting Batch"; Code[50])
        {

        }
        field(20; "Leave Posting Period[FROM]"; Date)
        {

        }
        field(21; "Leave Posting Period[TO]"; Date)
        {

        }
        field(22; "Leave Reimbursment Nos."; Code[50])
        {
            TableRelation = "No. Series".Code;
        }
        field(23; "Job Nos"; Code[50])
        {
            TableRelation = "No. Series".Code;
        }
        field(24; "Training Application Nos."; Code[50])
        {
            TableRelation = "No. Series".Code;
        }
        field(25; "Employee Requisition Nos."; Code[50])
        {
            TableRelation = "No. Series".Code;
        }
        field(26; "Job Application Nos"; Code[50])
        {
            TableRelation = "No. Series".Code;
        }
        field(27; "Leave Planner Nos."; Code[50])
        {
            TableRelation = "No. Series".Code;
        }
        field(28; "Training Projection No"; Code[50])
        {
            TableRelation = "No. Series".Code;
        }
        field(29; "Company Documents"; Code[50])
        {
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

