#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516233 "Loan Collateral Details"
{
    DrillDownPageID = "Loan Collateral Security";
    LookupPageID = "Loan Collateral Security";

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Loans Register"."Loan  No.";

            trigger OnValidate()
            begin
                if LoanApplications.Get("Loan No") then
                    "Loan Type" := LoanApplications."Loan Product Type";
            end;
        }
        field(2; Type; Option)
        {
            NotBlank = true;
            OptionCaption = ' ,Shares,Deposits,Collateral,Fixed Deposit';
            OptionMembers = " ",Shares,Deposits,Collateral,"Fixed Deposit";
        }
        field(3; "Security Details"; Text[150])
        {
        }
        field(4; Remarks; Text[250])
        {
        }
        field(5; "Loan Type"; Code[20])
        {
            //TableRelation = Table50005.Field3;
        }
        field(6; Value; Decimal)
        {

            trigger OnValidate()
            begin
                //"Guarantee Value":=Value*0.7;
                if Type = Type::"Fixed Deposit" then
                    Error('The cannot change the value for fixed deposit');
                //IF SecSetup.GET(Code) THEN BEGIN
                SecSetup.Reset;
                SecSetup.SetRange(SecSetup.Code, Code);
                if SecSetup.Find('-') then begin

                    Type := SecSetup.Type;
                    "Security Details" := SecSetup."Security Description";
                    "Collateral Multiplier" := SecSetup."Collateral Multiplier";
                    "Guarantee Value" := (Value * "Collateral Multiplier") / 100;
                    Category := SecSetup.Category;

                end;
                //END;
            end;
        }
        field(7; "Guarantee Value"; Decimal)
        {
            //Editable = false;
        }
        field(8; "Code"; Code[20])
        {
            TableRelation = "Loan Collateral Set-up".Code;

            trigger OnValidate()
            begin
                //IF SecSetup.GET(Code) THEN BEGIN
                SecSetup.Reset;
                SecSetup.SetRange(SecSetup.Code, Code);
                if SecSetup.Find('-') then begin

                    Type := SecSetup.Type;
                    "Security Details" := SecSetup."Security Description";
                    "Collateral Multiplier" := SecSetup."Collateral Multiplier";
                    "Guarantee Value" := Value * "Collateral Multiplier";
                    Category := SecSetup.Category;

                end;
                //END;
            end;
        }
        field(9; Category; Option)
        {
            OptionCaption = ' ,Cash,Government Securities,Corporate Bonds,Equity,Morgage Securities,Assets';
            OptionMembers = " ",Cash,"Government Securities","Corporate Bonds",Equity,"Morgage Securities",Assets;
        }
        field(10; "Collateral Multiplier"; Decimal)
        {

            trigger OnValidate()
            begin
                "Guarantee Value" := "Collateral Multiplier" * Value;
            end;
        }
        field(11; "View Document"; Code[20])
        {

            trigger OnValidate()
            begin
                Hyperlink('C:\SAMPLIR.DOC');
            end;
        }
        field(12; "Assesment Done"; Boolean)
        {
        }
        // field(13; "Account No"; Code[20])
        // {
        //     TableRelation = Vendor."No." where("Vendor Posting Group" = const('FIXED'));

        //     trigger OnValidate()
        //     begin
        //         if Vendor.Get("Account No") then begin
        //             Vendor.CalcFields(Vendor."Balance (LCY)");
        //             Value := Vendor."Balance (LCY)";
        //         end;
        //     end;
        // }
    }

    keys
    {
        key(Key1; "Loan No", Type, "Security Details", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LoanApplications: Record "Loans Register";
        SecSetup: Record "Loan Collateral Set-up";
        Vendor: Record Vendor;
}

