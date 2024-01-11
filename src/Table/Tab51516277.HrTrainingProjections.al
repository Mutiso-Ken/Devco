#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516277 "Hr Training Projections"
{

    fields
    {
        field(1; "Training Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Name of Program"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Target Group"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "No of Employees"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Duration; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Trainer; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Quater; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' , Q1, Q2, Q3, Q4';
            OptionMembers = " "," Q1"," Q2"," Q3"," Q4";
        }
        field(8; Cost; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Period; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accounting Period"."Starting Date";
        }
        field(10; "No series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Training Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Training Code" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Training Projection No");
            NoSeriesMgt.InitSeries(HRSetup."Training Projection No", xRec."No series", 0D, "Training Code", "No series");
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRSetup: Record "HR General Setup";
}

