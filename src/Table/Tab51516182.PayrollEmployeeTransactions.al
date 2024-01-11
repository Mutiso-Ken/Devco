#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516182 "Payroll Employee Transactions"
{

    fields
    {
        field(10;"No.";Code[20])
        {
        }
        field(11;"Transaction Code";Code[20])
        {

            trigger OnValidate()
            begin
                 PayrollTrans.Reset;
                 PayrollTrans.SetRange(PayrollTrans."Transaction Code","Transaction Code");
                 if PayrollTrans.Find('-') then begin
                  "Transaction Name":=PayrollTrans."Transaction Name";
                  "Transaction Type":=PayrollTrans."Transaction Type";
                 end;
            end;
        }
        field(12;"Transaction Name";Text[100])
        {
            Editable = false;
        }
        field(13;"Transaction Type";Option)
        {
            Editable = true;
            OptionCaption = 'Income,Deduction';
            OptionMembers = Income,Deduction;
        }
        field(14;Amount;Decimal)
        {

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."No.","No.");
                if Employee.FindFirst then begin
                  if Employee."Currency Code" = '' then
                    "Amount(LCY)" := Amount
                  else
                    "Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(Today,Employee."Currency Code",Amount,Employee."Currency Factor"));
                end;
            end;
        }
        field(15;"Amount(LCY)";Decimal)
        {
            Editable = false;
        }
        field(16;Balance;Decimal)
        {
            Editable = true;
        }
        field(17;"Balance(LCY)";Decimal)
        {
            Editable = true;
        }
        field(18;"Period Month";Integer)
        {
            Editable = false;
        }
        field(19;"Period Year";Integer)
        {
            Editable = false;
        }
        field(20;"Payroll Period";Date)
        {
            Editable = false;
            TableRelation = "Payroll Calender"."Date Opened";
        }
        field(21;"No of Repayments";Decimal)
        {
        }
        field(22;Membership;Code[20])
        {
        }
        field(23;"Reference No";Text[30])
        {
        }
        field(24;"Employer Amount";Decimal)
        {

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."No.","No.");
                if Employee.FindFirst then begin
                  if Employee."Currency Code" = '' then
                    "Employer Amount(LCY)" := "Employer Amount"
                  else
                    "Employer Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(Today,Employee."Currency Code","Employer Amount",Employee."Currency Factor"));
                end;
            end;
        }
        field(25;"Employer Amount(LCY)";Decimal)
        {
            Editable = false;
        }
        field(26;"Employer Balance";Decimal)
        {
            Editable = false;
        }
        field(27;"Employer Balance(LCY)";Decimal)
        {
            Editable = false;
        }
        field(28;"Stop for Next Period";Boolean)
        {
        }
        field(29;"Amtzd Loan Repay Amt";Decimal)
        {

            trigger OnValidate()
            begin
                /*Employee.RESET;
                Employee.SETRANGE(Employee."Job No","No.");
                IF Employee.FINDFIRST THEN BEGIN
                  IF Employee."Currency Code" = '' THEN
                    "Amtzd Loan Repay Amt(LCY)" :="Amtzd Loan Repay Amt"
                  ELSE
                    "Amtzd Loan Repay Amt(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(TODAY,Employee."Currency Code","Amtzd Loan Repay Amt",Employee."Currency Factor"));
                END;*/

            end;
        }
        field(30;"Amtzd Loan Repay Amt(LCY)";Decimal)
        {
        }
        field(31;"Start Date";Date)
        {
        }
        field(32;"End Date";Date)
        {
        }
        field(33;"Loan Number";Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where ("Staff No"=field("No."),
                                                                Source=filter(BOSA));

            trigger OnValidate()
            begin

                Loan.Reset;
                Loan.SetRange(Loan."Loan  No.","Loan Number");
                if Loan.Find('-') then begin
                 Loan.CalcFields(Loan."Outstanding Balance");
                 Balance:=Loan."Outstanding Balance";

                end;
            end;
        }
        field(34;"Payroll Code";Code[20])
        {
        }
        field(35;"No of Units";Decimal)
        {
        }
        field(36;Suspended;Boolean)
        {
        }
        field(37;"Entry No";Integer)
        {
        }
        field(38;"IsCoop/LnRep";Boolean)
        {
        }
        field(39;Grants;Code[20])
        {
        }
        field(40;"Posting Group";Code[20])
        {
        }
        field(41;"Original Amount";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"No.","Transaction Code","Payroll Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
         PayrollCalender.Reset;
         PayrollCalender.SetRange(PayrollCalender.Closed,false);
         if PayrollCalender.FindFirst then begin
          "Period Month":=PayrollCalender."Period Month";
          "Period Year":=PayrollCalender."Period Year";
          "Payroll Period":=PayrollCalender."Date Opened";
         end;
    end;

    var
        Employee: Record "Payroll Employee";
        CurrExchRate: Record "Currency Exchange Rate";
        PayrollCalender: Record "Payroll Calender";
        PayrollTrans: Record "Payroll Transaction Code";
        Loan: Record "Loans Register";
}

