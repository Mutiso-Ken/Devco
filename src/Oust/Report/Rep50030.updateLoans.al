report 50030 updateLoans
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            column(Loan__No_; "Loan  No.")
            {

            }
            trigger OnAfterGetRecord()
            var
                Loans: Record "Loans Register";
                Cust: Record Customer;
            begin
                // Loans.SetRange(Loans."Client Code", Cust."No.");
                // If cust.get("Client Code") then begin
                //     "Client Name" := Cust.Name;
                //     "Loans Register".Modify(true);
                // end;


                Loans.Reset();
                Loans.SetRange(Loans."Loan  No.", "Loan  No.");
                if Loans.FindSet() then begin
                    //Loans.Repayment := Loans."Loan Principle Repayment" + "Loan Interest Repayment";
                    if "Loan Disbursement Date" <> 0D then begin
                        if Date2dmy("Loan Disbursement Date", 1) <= 10 then begin
                            Loans."Repayment Start Date" := CalcDate('CM', "Loan Disbursement Date");
                        end else begin
                            Loans."Repayment Start Date" := CalcDate('CM', CalcDate('CM+1M', "Loan Disbursement Date"));
                        end;
                        Loans."Expected Date of Completion" := CalcDate('CM', CalcDate('CM+' + Format(Loans.Installments) + 'M', Loans."Loan Disbursement Date"));
                    end;
                    Loans.Modify();


                end;
            end;
        }
    }



}