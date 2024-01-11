#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516247 "Receipts & Payments"
{

    fields
    {
        field(1; "Transaction No."; Code[20])
        {
        }
        field(2; "Account No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                TestField(Source);

                if ("Account Type" = "account type"::"FOSA Loan") or
                   ("Account Type" = "account type"::Debtor) then begin
                    if Cust.Get("Account No.") then begin
                        Name := Cust.Name;
                    end;
                end;
                if ("Account Type" = "account type"::Customer) then begin
                    if Mem.Get("Account No.") then
                        Name := Mem.Name;
                end;
                if ("Account Type" = "account type"::Vendor) then begin
                    if Vend.Get("Account No.") then
                        Name := Vend.Name;
                end;
                if ("Account Type" = "account type"::"G/L Account") then begin
                    if GLAcct.Get("Account No.") then begin
                        Name := GLAcct.Name;
                    end;
                end;
            end;
        }
        field(3; Name; Text[50])
        {
        }
        field(4; Amount; Decimal)
        {
            NotBlank = true;
        }
        field(5; "Cheque No."; Code[50])
        {

            trigger OnValidate()
            begin
                /*
                BOSARcpt.RESET;
                BOSARcpt.SETRANGE(BOSARcpt."Cheque No.","Cheque No.");
                BOSARcpt.SETRANGE(BOSARcpt.Posted,TRUE);
                IF BOSARcpt.FIND('-') THEN
                ERROR('Cheque no already exist in a posted receipt.');
                */

            end;
        }
        field(6; "Cheque Date"; Date)
        {
        }
        field(7; Posted; Boolean)
        {
            Editable = true;
        }
        field(8; "Employer No."; Code[20])
        {
            Editable = true;
            TableRelation = if (Source = const(Bosa),
                                "Mode of Payment" = filter(Cheque | "Deposit Slip" | Mpesa | "Standing order")) "Bank Account"."No." where("Account Type" = filter(" "))
            else
            if (Source = const(Bosa),
                                         "Mode of Payment" = filter(Cheque | "Deposit Slip" | Mpesa | "Standing order")) "Bank Account"."No." where("Account Type" = filter(" "))
            else
            if (Source = const(Bosa),
                                                  "Mode of Payment" = filter(Cash)) "Bank Account"."No." where("Account Type" = filter(Cashier),
                                                                                                              CashierID = field("User ID"))
            else
            if (Source = const(Fosa),
                                                                                                                       "Mode of Payment" = filter(Cash)) "Bank Account"."No." where("Account Type" = filter(Cashier),
                                                                                                                                                                                   CashierID = field("User ID"));
        }
        field(9; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(10; "Allocated Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Allocation".Amount where("Document No" = field("Transaction No."),
                                                                 "Member No" = field("Account No.")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                CalcFields("Un allocated Amount");
                Validate("Un allocated Amount");
            end;
        }
        field(11; "Transaction Date"; Date)
        {
            Editable = true;
        }
        field(12; "Transaction Time"; Time)
        {
            Editable = false;
        }
        field(13; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14; "Account Type"; Option)
        {
            OptionCaption = 'Member,Debtor,G/L Account,FOSA Loan,Vendor';
            OptionMembers = Customer,Debtor,"G/L Account","FOSA Loan",Vendor;
        }
        field(15; "Transaction Slip Type"; Option)
        {
            OptionCaption = ' ,Standing Order,Direct Debit,Direct Deposit,Cash,Cheque,M-Pesa';
            OptionMembers = " ","Standing Order","Direct Debit","Direct Deposit",Cash,Cheque,"M-Pesa";
        }
        field(16; "Bank Name"; Code[50])
        {
        }
        field(50000; Insuarance; Decimal)
        {
            FieldClass = Normal;
        }
        field(50001; "Un allocated Amount"; Decimal)
        {
        }
        field(50002; Source; Option)
        {
            OptionCaption = ' ,Bosa,Fosa,Micro';
            OptionMembers = " ",Bosa,Fosa,Micro;
        }
        field(50003; "Mode of Payment"; Option)
        {
            OptionCaption = 'Cash,Cheque,Mpesa,Standing order,Deposit Slip';
            OptionMembers = Cash,Cheque,Mpesa,"Standing order","Deposit Slip";

            trigger OnValidate()
            begin
                Clear("Employer No.");
                if "Mode of Payment" = "mode of payment"::Cash then
                    "Employer No." := SFactory.FnGetTellerTillNo();
            end;
        }
        field(50004; Remarks; Text[100])
        {
        }
        field(50005; "Code"; Code[100])
        {
        }
        field(50006; Type; Option)
        {
            NotBlank = true;
            OptionMembers = " ",Receipt,Payment,Imprest,Advance;
        }
        field(50007; Description; Text[50])
        {
        }
        field(50008; "Default Grouping"; Code[20])
        {
            Editable = false;
        }
        field(50009; "Transation Remarks"; Text[50])
        {
        }
        field(50010; "Customer Payment On Account"; Boolean)
        {
        }
        field(50011; "G/L Account"; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"."No.";

            trigger OnValidate()
            begin
                GLAcc.Reset;

                if GLAcc.Get("G/L Account") then begin
                    //IF Type=Type::Payment THEN
                    //  GLAcc.TESTFIELD(GLAcc."Budget Controlled",TRUE);
                    if GLAcc."Direct Posting" = false then begin
                        Error('Direct Posting must be True');
                    end;
                end;

                /*PayLine.RESET;
                PayLine.SETRANGE(PayLine.Type,Code);
                IF PayLine.FIND('-') THEN
                   ERROR('This Transaction Code Is Already in Use You Cannot Delete');uncomment*/

            end;
        }
        field(50012; Blocked; Boolean)
        {
        }
        field(50013; "Old receipt No"; Code[30])
        {

            trigger OnValidate()
            begin
                //IF xRec."Old receipt No"="Old receipt No" THEN ERROR ('OLD RECEIPT NO ALREADY EXIST');
                BOSARcpt.Reset;
                BOSARcpt.SetRange(BOSARcpt."Old receipt No", "Old receipt No");
                if BOSARcpt.Find('-') then begin
                    repeat
                        OldNo := BOSARcpt."Old receipt No";
                    until BOSARcpt.Next = 0;
                    if OldNo = Rec."Old receipt No" then Error('This old receipt No. already exists!');
                end;
            end;
        }
        field(50014; "Bank No."; Code[30])
        {
        }
        field(50015; "FOSA Account No."; Code[30])
        {
            TableRelation = Vendor."No.";
        }
        field(50016; "Branch Code"; Code[10])
        {
        }
        field(50017; "Activity Code"; Code[10])
        {
        }
        field(50018; "Posted By"; Code[50])
        {
        }
        field(50019; "Responsibilty Center"; Code[50])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(50020; "Date Posted"; Date)
        {
        }
        field(50021; "Time Posted"; Time)
        {
        }
        field(50022; "FOSA Account Bal"; Decimal)
        {
        }
        field(50023; "Application Type"; Option)
        {
            OptionCaption = 'BOSA,MICRO,FOSA';
            OptionMembers = BOSA,MICRO,FOSA;
        }
        field(50024; "BOSA Account No."; Code[30])
        {
            TableRelation = Customer;
        }
        field(50025; "Payroll/Staff No."; Code[20])
        {
        }
        field(50026; "Loan No"; Code[40])
        {
        }
    }

    keys
    {
        key(Key1; "Transaction No.")
        {
            Clustered = true;
        }
        key(Key2; "Account Type", Posted)
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        if Posted then
            Error('Cannot delete a posted transaction');
    end;

    trigger OnInsert()
    begin
        if "Transaction No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."BOSA Receipts Nos");
            NoSeriesMgt.InitSeries(NoSetup."BOSA Receipts Nos", xRec."No. Series", 0D, "Transaction No.", "No. Series");
        end;

        "User ID" := UserId;
        "Transaction Date" := Today;
        "Transaction Time" := Time;
        if "Mode of Payment" = "mode of payment"::Cash then
            "Employer No." := SFactory.FnGetTellerTillNo();
    end;

    trigger OnModify()
    begin
        if Posted = true then
            Error('Cannot modify a posted transaction');
    end;

    trigger OnRename()
    begin
        if Posted then
            Error('Cannot rename a posted transaction');
    end;

    var
        Cust: Record Customer;
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BOSARcpt: Record "Receipts & Payments";
        GLAcct: Record "G/L Account";
        Mem: Record Customer;
        Vend: Record Vendor;
        GLAcc: Record "G/L Account";
        PayLine: Record "Payment Line";
        OldNo: Code[20];
        SFactory: Codeunit "SURESTEP Factory";
}

