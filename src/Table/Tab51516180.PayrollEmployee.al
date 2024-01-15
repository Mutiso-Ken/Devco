#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516180 "Payroll Employee"
{

    fields
    {
        field(10; "No."; Code[20])
        {
            NotBlank=true;
            
        }
        field(11; Firstname; Text[30])
        {

            trigger OnValidate()
            begin
                "Full Name" := Firstname + ' ' + ' '+ SecondName+ ' '+ Lastname;
            end;
        }
        field(12;SecondName; Text[30])
        {

            trigger OnValidate()
            begin
                "Full Name" := Firstname + ' ' + ' '+ SecondName+ ' '+ Lastname;
            end;
        }
        field(13; Lastname; Text[30])
        {

            trigger OnValidate()
            begin
              "Full Name" := Firstname + ' ' + ' '+ SecondName+ ' '+ Lastname;
            end;
        }
        field(14; "Joining Date"; Date)
        {
        }
        field(15; "Currency Code"; Code[20])
        {
            TableRelation = Currency.Code;
        }
        field(16; "Currency Factor"; Decimal)
        {
        }
        field(17; "Global Dimension 1"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(18; "Global Dimension 2"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(19; "Shortcut Dimension 3"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(20; "Shortcut Dimension 4"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(21; "Shortcut Dimension 5"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
        }
        field(22; "Shortcut Dimension 6"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));
        }
        field(23; "Shortcut Dimension 7"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));
        }
        field(24; "Shortcut Dimension 8"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));
        }
        field(25; "Basic Pay"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                    "Basic Pay(LCY)" := "Basic Pay"
                else
                    "Basic Pay(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(Today, "Currency Code", "Basic Pay", "Currency Factor"));
            end;
        }
        field(26; "Basic Pay(LCY)"; Decimal)
        {
        }
        field(27; "Cummulative Basic Pay"; Decimal)
        {
            Editable = false;
        }
        field(28; "Cummulative Gross Pay"; Decimal)
        {
            Editable = false;
        }
        field(29; "Cummulative Allowances"; Decimal)
        {
            Editable = false;
        }
        field(30; "Cummulative Deductions"; Decimal)
        {
            Editable = false;
        }
        field(31; "Cummulative Net Pay"; Decimal)
        {
            Editable = false;
        }
        field(32; "Cummulative PAYE"; Decimal)
        {
        }
        field(33; "Cummulative NSSF"; Decimal)
        {
        }
        field(34; "Cummulative Pension"; Decimal)
        {
        }
        field(35; "Cummulative HELB"; Decimal)
        {
        }
        field(36; "Cummulative NHIF"; Decimal)
        {
        }
        field(37; "Cummulative Employer Pension"; Decimal)
        {
        }
        field(38; "Cummulative TopUp"; Decimal)
        {
        }
        field(39; "Cummulative Basic Pay(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(40; "Cummulative Gross Pay(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(41; "Cummulative Allowances(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(42; "Cummulative Deductions(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(43; "Cummulative Net Pay(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(44; "Cummulative PAYE(LCY)"; Decimal)
        {
        }
        field(45; "Cummulative NSSF(LCY)"; Decimal)
        {
        }
        field(46; "Cummulative Pension(LCY)"; Decimal)
        {
        }
        field(47; "Cummulative HELB(LCY)"; Decimal)
        {
        }
        field(48; "Cummulative NHIF(LCY)"; Decimal)
        {
        }
        field(49; "Cumm Employer Pension(LCY)"; Decimal)
        {
        }
        field(50; "Cummulative TopUp(LCY)"; Decimal)
        {
        }
        field(51; "Non Taxable"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                    "Non Taxable(LCY)" := "Non Taxable"
                else
                    "Non Taxable(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(Today, "Currency Code", "Non Taxable", "Currency Factor"));
            end;
        }
        field(52; "Non Taxable(LCY)"; Decimal)
        {
        }
        field(53; "Posting Group"; Code[20])
        {
            TableRelation = "Payroll Posting Groups"."Posting Code";
        }
        field(54; "Payment Mode"; Option)
        {
            OptionCaption = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = "Bank Transfer",Cheque,Cash,SACCO;
        }
        field(55; "Pays PAYE"; Boolean)
        {
        }
        field(56; "Pays NSSF"; Boolean)
        {
        }
        field(57; "Pays NHIF"; Boolean)
        {
        }
        field(58; "Bank Code"; Code[20])
        {
            TableRelation = "Payroll Bank Codes"."Bank Code";

            trigger OnValidate()
            begin
                BankCodes.Reset;
                BankCodes.SetRange(BankCodes."Bank Code", "Bank Code");
                if BankCodes.FindFirst then begin
                    BankCodes.TestField(BankCodes."Bank Name");
                    "Bank Name" := BankCodes."Bank Name";
                end;
            end;
        }
        field(59; "Bank Name"; Text[100])
        {
            Editable = false;
        }
        field(60; "Branch Code"; Code[20])
        {
            TableRelation = "Payroll Bank Branches"."Branch Code" where("Bank Code" = field("Bank Code"));

            trigger OnValidate()
            begin
                BankBranches.Reset;
                BankBranches.SetRange(BankBranches."Bank Code", "Bank Code");
                BankBranches.SetRange(BankBranches."Branch Code", "Branch Code");
                if BankBranches.FindFirst then begin
                    BankBranches.TestField(BankBranches."Branch Name");
                    "Branch Name" := BankBranches."Branch Name";
                end;
            end;
        }
        field(61; "Branch Name"; Text[100])
        {
            Editable = false;
        }
        field(62; "Bank Account No"; Code[50])
        {
        }
        field(63; "Suspend Pay"; Boolean)
        {
        }
        field(64; "Suspend Date"; Date)
        {
        }
        field(65; "Suspend Reason"; Text[100])
        {
        }
        field(66; "Hourly Rate"; Decimal)
        {
        }
        field(67; Gratuity; Boolean)
        {
        }
        field(68; "Gratuity Percentage"; Decimal)
        {
        }
        field(69; "Gratuity Provision"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                    "Gratuity Provision(LCY)" := "Gratuity Provision"
                else
                    "Gratuity Provision(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(Today, "Currency Code", "Gratuity Provision", "Currency Factor"));
            end;
        }
        field(70; "Gratuity Provision(LCY)"; Decimal)
        {
        }
        field(71; "Cummulative Gratuity"; Decimal)
        {
        }
        field(72; "Cummulative Gratuity(LCY)"; Decimal)
        {
        }
        field(73; "Days Absent"; Decimal)
        {
        }
        field(74; "Payslip Message"; Text[100])
        {
        }
        field(75; "Paid per Hour"; Boolean)
        {
        }
        field(76; "Full Name"; Text[90])
        {
        }
        field(77; Status; Option)
        {
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(78; "Date of Leaving"; Date)
        {
        }
        field(79; GetsPayeRelief; Boolean)
        {
        }
        field(80; GetsPayeBenefit; Boolean)
        {
        }
        field(81; Secondary; Boolean)
        {
        }
        field(82; PayeBenefitPercent; Decimal)
        {
        }
        field(83; "NSSF No"; Code[20])
        {
        }
        field(84; "NHIF No"; Code[20])
        {
        }
        field(85; "PIN No"; Code[20])
        {
        }
     
        field(87; "Current Month Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(88; "National ID No"; Code[20])
        {
        }
        field(89; Photo; Blob)
        {
            SubType = Bitmap;
        }
        field(90; "Period Filter"; Date)
        {
            TableRelation = "Payroll Calender"."Date Opened";
        }
        field(91; "Date of Birth"; Date)
        {
        }
        field(92; Casual; Boolean)
        {
        }
              field(93; "Sacco No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Sacco No") then begin
                    "Full Name" := ObjCust.Name;
                    "Employee Email" := ObjCust."E-Mail";
                    "National ID No" := ObjCust."ID No.";
                    "PIN No" := ObjCust.Pin;
                    "Sacco No" := ObjCust."No.";

                end;
            end;
        }
        field(94; "Employee Email"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.","National ID No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CurrExchRate: Record "Currency Exchange Rate";
        BankCodes: Record "Payroll Bank Codes";
        BankBranches: Record "Payroll Bank Branches";
        ObjCust: Record Customer;
}

