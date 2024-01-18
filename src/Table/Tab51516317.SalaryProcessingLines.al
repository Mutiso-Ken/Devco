#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516317 "Salary Processing Lines"
{

    fields
    {
        field(1; "No."; Integer)
        {
            NotBlank = false;
        }
        field(2; "Account No."; Code[20])
        {
            TableRelation = Vendor."No." where("Creditor Type" = const(Account),
                                             "Account Type" = filter('ORDINARY' | 'Current'));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin

                Acc.Reset;
                Acc.SetRange(Acc."No.", "Account No.");
                if Acc.Find('-') then begin
                    if "Staff No." = '' then
                        "Staff No." := Acc."Staff No";
                    if Name = '' then
                        Name := Acc.Name;
                    "Account Name" := Acc.Name;
                    "Client Code" := Acc."BOSA Account No";
                    if "Grower No." = '' then
                        "Grower No." := Acc."Grower No";
                end;
            end;
        }
        field(3; "Staff No."; Code[20])
        {

            // trigger OnValidate()
            // begin

            //     IF "Account Type" = filter(<>'ordinary'| <>'jaza') THEN BEGIN 
            //     "Account Type":=Acc.AccountType;
            //     VALIDATE("Account Type");
            //     END
            //     ELSE
            //     ERROR('Record not found.')

            // end;
        }
        field(4; Name; Text[50])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Account Not Found"; Boolean)
        {
        }
        field(7; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(8; Processed; Boolean)
        {
        }
        field(9; "Document No."; Code[20])
        {
        }
        field(10; Date; Date)
        {
        }
        field(11; "No. Series"; Code[20])
        {
        }
        field(12; "Original Account No."; Code[30])
        {
        }
        field(13; "Multiple Salary"; Boolean)
        {
        }
        field(14; Reversed; Boolean)
        {
        }
        field(15; "Branch Reff."; Code[20])
        {
        }
        field(16; "Account Name"; Text[50])
        {
        }
        field(17; "ID No."; Code[30])
        {
        }
        field(18; "Blocked Accounts"; Boolean)
        {
        }

        field(19; "Account Type"; Text[20])
        {
            // trigger OnValidate()
            // begin
            //     CASE "Account Type" OF
            //         'ordinary', 'jaza':
            //             VALIDATE("Account Type");
            //         ELSE
            //             ERROR('Invalid account type.');
            //     END;
            // end;
        }
        field(62000; "BOSA Schedule"; Boolean)
        {
        }
        field(62001; USER; Code[50])
        {
        }
        field(62002; "Balance sl"; Decimal)
        {
            CalcFormula = sum("Gen. Journal Line".Amount where("Account No." = field("Account No.")));
            FieldClass = FlowField;
        }
        field(62003; "Client Code"; Code[20])
        {
        }
        field(62004; Type; Option)
        {
            OptionCaption = 'Salary,Tea Bonus,Milk,Tea';
            OptionMembers = Salary,"Tea Bonus",Milk,Tea;
        }
        field(62005; "Grower No."; Code[20])
        {
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Acc.Reset;
                Acc.SetRange(Acc."Grower No", "Grower No.");
                if Acc.Find('-') then begin
                    /* IF "Staff No." = '' THEN
                     "Staff No.":=Acc."Staff No";
                     IF Name = '' THEN*/
                    Name := Acc.Name;
                    "Account Name" := Acc.Name;
                    "Client Code" := Acc."BOSA Account No";
                    "Account No." := Acc."No.";
                end;

            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Account No.", Date, Processed)
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        SalBuffer.Reset;
        if SalBuffer.Find('+') then
            "No." := SalBuffer."No." + 1;

        USER := UserId;
    end;

    var
        Acc: Record Vendor;
        // NoSetup: Record "Payroll Employee Deductions";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalBuffer: Record "Salary Processing Lines";
}

