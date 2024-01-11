#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516246 "Receipt Allocation"
{
    DrillDownPageID = "Receipt Allocation-BOSA";
    LookupPageID = "Receipt Allocation-BOSA";

    fields
    {
        field(1;"Document No";Code[20])
        {
            NotBlank = true;
        }
        field(2;"Member No";Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(3;"Transaction Type";Option)
        {
            NotBlank = true;
            OptionCaption = ',Registration Fee,Loan,Repayment,Withdrawal,Interest Due,Interest Paid,Benevolent Fund,Deposit Contribution,Penalty Charged,Application Fee,Appraisal Fee,Investment,Unallocated Funds,Shares Capital,Loan Adjustment,Dividend,Withholding Tax,Administration Fee,Insurance Contribution,Prepayment,Withdrawable Deposits,Xmas Contribution,Penalty Paid,Dev Shares,Co-op Shares,Welfare Contribution 2,Loan Penalty,Loan Guard,Lukenya,Konza,Juja,Housing Water,Housing Title,Housing Main,M Pesa Charge ,Insurance Charge,Insurance Paid,FOSA Account,Partial Disbursement,Loan Due,FOSA Shares,Loan Form Fee,PassBook Fee,Normal shares,SchFee Shares,Pepea Shares,Tambaa Shares,Lift Shares,Changamka Shares';
            OptionMembers = ,"Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","Welfare Contribution 2","Loan Penalty","Loan Guard",Lukenya,Konza,Juja,"Housing Water","Housing Title","Housing Main","M Pesa Charge ","Insurance Charge","Insurance Paid","FOSA Account","Partial Disbursement","Loan Due","FOSA Shares","Loan Form Fee","PassBook Fee","Normal shares","SchFee Shares","Pepea Shares","Tambaa Shares","Lift Shares","Changamka Shares";

            trigger OnValidate()
            begin
                "Loan No.":='';
                Amount:=0;
                
                /*
                IF ("Transaction Type" = "Transaction Type"::Commision) OR ("Transaction Type" = "Transaction Type"::Investment) THEN BEGIN
                IF "Loan No." = '' THEN
                ERROR('You must specify loan no. for loan transactions.');
                END;
                 */
                 /*
                IF ("Transaction Type" <> "Transaction Type"::Repayment) THEN BEGIN
                IF Cust.GET("Member No") THEN BEGIN
                IF Cust."Customer Type" <> Cust."Customer Type"::Member THEN
                ERROR('This transaction type only applicable for BOSA Members.');
                END;
                END;
                 */

            end;
        }
        field(4;"Loan No.";Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where ("Client Code"=field("Member No"),
                                                                Source=filter(FOSA|BOSA));

            trigger OnValidate()
            begin

                if Loans.Get("Loan No.") then begin
                Loans.CalcFields(Loans."Outstanding Balance",Loans."Oustanding Interest");
                if Loans."Outstanding Balance" > 0 then begin
                Amount:=Loans.Repayment-Loans."Oustanding Interest";
                "Interest Amount":=Loans."Oustanding Interest";


                if LoanType.Get(Loans."Loan Product Type")  then
                  "Loan Product Type":=LoanType.Code;
                end;
                end;



                "Total Amount":=Amount+"Interest Amount";
            end;
        }
        field(5;Amount;Decimal)
        {

            trigger OnValidate()
            begin
                if ("Transaction Type" = "transaction type"::Repayment) or ("Transaction Type" = "transaction type"::"Interest Paid") then begin
                if "Loan No." = '' then
                Error('You must specify loan no. for loan transactions.');
                end;
                
                /*IF Loans.GET("Loan No.") THEN BEGIN
                Loans.CALCFIELDS(Loans."Outstanding Balance");
                IF Loans.Posted = TRUE THEN BEGIN
                IF Amount > Loans."Outstanding Balance" THEN
                ERROR('Principle Repayment cannot be more than the loan oustanding balance.');
                END;
                END;     */
                
                "Total Amount":=Amount+"Interest Amount";

            end;
        }
        field(6;"Interest Amount";Decimal)
        {

            trigger OnValidate()
            begin
                
                /*IF ("Transaction Type" = "Transaction Type"::"Registration Fee") THEN BEGIN
                IF "Loan No." = '' THEN
                ERROR('You must specify loan no. for loan transactions.');
                END;
                
                
                IF Loans.GET("Loan No.") THEN BEGIN
                Loans.CALCFIELDS(Loans."Oustanding Interest");
                IF "Interest Amount" > Loans."Oustanding Interest" THEN
                ERROR('Interest Repayment cannot be more than the loan oustanding balance.');
                END;
                
                
                "Total Amount":=Amount+"Interest Amount"+"Loan Insurance";
                */

            end;
        }
        field(7;"Total Amount";Decimal)
        {
            Editable = false;
        }
        field(8;"Amount Balance";Decimal)
        {
        }
        field(9;"Interest Balance";Decimal)
        {
        }
        field(10;"Loan ID";Code[10])
        {
        }
        field(11;"Prepayment Date";Date)
        {
        }
        field(50000;"Loan Insurance";Decimal)
        {
            BlankZero = true;

            trigger OnValidate()
            begin

                //Loans.GET();
                   CalcFields("Applied Amount");

                   if "Applied Amount">100000 then
                    //Loans.SETRANGE(Loans."Client Code","Member No");
                   "Loan Insurance":="Applied Amount"*0.25;
            end;
        }
        field(50001;"Applied Amount";Decimal)
        {
            CalcFormula = lookup("Loans Register"."Approved Amount" where ("Loan  No."=field("Loan No.")));
            FieldClass = FlowField;
        }
        field(50002;Insurance;Decimal)
        {
        }
        field(50003;"Un Allocated Amount";Decimal)
        {
        }
        field(51516150;"Global Dimension 1 Code";Code[20])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(51516151;"Global Dimension 2 Code";Code[20])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(51516152;"Loan Product Type";Code[70])
        {
        }
    }

    keys
    {
        key(Key1;"Document No","Member No","Transaction Type","Loan No.","Loan ID","Un Allocated Amount")
        {
            Clustered = true;
            SumIndexFields = "Total Amount";
        }
    }

    fieldgroups
    {
    }

    var
        Loans: Record "Loans Register";
        Cust: Record Customer;
        LoanType: Record "Loan Products Setup";
}

