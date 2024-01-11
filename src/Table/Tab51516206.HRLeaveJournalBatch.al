#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516206 "HR Leave Journal Batch"
{
    DataCaptionFields = Name,Description;

    fields
    {
        field(1;"Journal Template Name";Code[20])
        {
            Caption = 'Journal Template Name';
            NotBlank = true;
            //TableRelation = "HR Leave Journal Template";
        }
        field(2;Name;Code[20])
        {
            Caption = 'Name';
            NotBlank = true;
        }
        field(3;Description;Text[50])
        {
            Caption = 'Description';
        }
        field(4;"Reason Code";Code[20])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";

            trigger OnValidate()
            begin
            end;
        }
        field(5;"No. Series";Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                if ("No. Series" <> '') and ("No. Series" = "Posting No. Series") then
                  Validate("Posting No. Series",'');
            end;
        }
        field(6;"Posting No. Series";Code[20])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
            end;
        }
        field(18;Type;Option)
        {
            OptionCaption = 'Positive,Negative';
            OptionMembers = Positive,Negative;

            trigger OnValidate()
            begin
                
            end;
        }
        field(19;"Posting Description";Text[50])
        {
        }
    }

    keys
    {
        key(Key1;"Journal Template Name",Name)
        {
            Clustered = true;
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

    trigger OnRename()
    begin
       
    end;

    var
        Text000: label 'must not be %1';



    procedure SetupNewBatch()
    begin
      
    end;
}

