Codeunit 51516120 "PORTALIntegration"
{

    trigger OnRun()
    begin

    end;

    var
        objMember: Record Customer;
        objLoanRegister: Record "Loans Register";
        objRegMember: Record "Membership Applications";
        objNextKin: Record "Next of Kin/Account Sign";
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        Loansetup: Record "Loan Products Setup";
        LPrincipal: Decimal;
        LInterest: Decimal;
        LBalance: Decimal;
        TotalMRepay: Decimal;
        InterestRate: Decimal;
        Date: Date;
        Loanperiod: Integer;
        Filename: Text;
        FILESPATH: label 'C:\inetpub\wwwroot\SaccoData\PdfDocs';
        qualificationasperSeposit: Decimal;
        EligibleAmount: Decimal;
        QualificationAsPerSalary: Decimal;
        CompanyInformation: Record "Company Information";
        objLoanGuarantors: Record "Loans Guarantee Details";
        _loans: Record "Loans Register";
        _guarantors: Record "Loans Guarantee Details";
        _variant: Variant;
        ApprovalManagement: Codeunit "Approvals Mgmt.";
        _approvalEntry: Record "Approval Entry";

    procedure GetNextOfKin(MemberNumber: Code[100]) return: JsonObject
    var
        NextOfKin: Record "Next of Kin/Account Sign";
        NextOfKinJson: JsonObject;
        NextOfKinArray: JsonArray;
        NextOfKinEntry: JsonObject;
    begin
        NextOfKin.Reset;
        NextOfKin.SetRange("Account No", MemberNumber);
        if NextOfKin.Find('-') then begin
            repeat
                NextOfKinEntry.Add('Name', NextOfKin.Name);
                NextOfKinEntry.Add('Relationship', NextOfKin.Relationship);
                NextOfKinEntry.Add('Allocation', Format(NextOfKin."%Allocation"));
                NextOfKinEntry.Add('Address', NextOfKin.Address);
                NextOfKinEntry.Add('Phone_number', NextOfKin.Telephone);
                NextOfKinEntry.Add('Id_Number', NextOfKin."ID No.");
                NextOfKinEntry.Add('Email_Address', NextOfKin.Email);
                NextOfKinArray.Add(NextOfKinEntry);
            until NextOfKin.Next() = 0;
        end;
        NextOfKinJson.Add('NextOfKin', NextOfKinArray);
        exit(NextOfKinJson);
    end;
    //Get Accounts
    procedure Get_Accounts(MemberNumber: Code[100]) return: JsonObject
    var
        MemberAccountJson: JsonObject;
        MemberAccountArray: JsonArray;
        MemberAccountEntry: JsonObject;
        Members: Record Customer;
    begin

        Members.Reset;
        Members.SetRange(Members."No.", MemberNumber);
        if Members.Find('-') then begin
            repeat
                Members.CalcFields(Members."Current Shares");
                MemberAccountEntry.Add('Account_Number', Members."No.");
                MemberAccountEntry.Add('Account_Name', Members."Global Dimension 1 Code" + ' ' + 'Savings Account');
                MemberAccountEntry.Add('Account_Type', Members."Global Dimension 1 Code" + ' ' + 'Account');
                MemberAccountEntry.Add('Account_Status', Members.Status);
                MemberAccountEntry.Add('Currency', 'KES');
                MemberAccountEntry.Add('Deposits', Members."Current Shares");
                MemberAccountEntry.Add('Deposits', 'Deposits');
            until objMember.Next() = 0;
        end;
        MemberAccountJson.Add('MemberAccount', MemberAccountArray);
        exit(MemberAccountJson);
    end;

    //Get Loans

    procedure Get_Loans(MemberNo: Code[20]) return: JsonObject
    var
        LoanRegister: Record "Loans Register"; // Assuming "Loan Register" is a table.
        LoanListJson: JsonObject;
        LoanArray: JsonArray;
        LoanEntry: JsonObject;
    begin
        LoanRegister.Reset;
        LoanRegister.SetRange("Client Code", MemberNo);
        LoanRegister.SetRange(LoanRegister.Posted, true);
        if LoanRegister.Find('-') then begin
            repeat

                LoanRegister.CalcFields("Outstanding Balance");
                LoanEntry.Add('LoanNo', LoanRegister."Loan  No.");
                LoanEntry.Add('LoanProductType', LoanRegister."Loan Product Type");
                LoanEntry.Add('Loan_source', LoanRegister.Source);
                LoanEntry.Add('Outstanding_Balance', Format(LoanRegister."Outstanding Balance"));
                LoanEntry.Add('Installments', Format(LoanRegister.Installments));
                LoanEntry.Add('LoanStatus', Format(LoanRegister."Loan Status"));
                LoanEntry.Add('Repayment_amount', Format(LoanRegister."Loan Principle Repayment"));
                LoanEntry.Add('Currency', 'KES');
                LoanEntry.Add('ApprovedAmount', Format(LoanRegister."Approved Amount"));
                // LoanEntry.Add('RemainingInstallments', Format(LoanRegister.Installments - LoanRegister.LoanPeriod));//To check later
                LoanEntry.Add('Expected_date_0f_completion', Format(LoanRegister."Expected Date of Completion"));
                LoanArray.Add(LoanEntry);
            until LoanRegister.Next() = 0;
        end;
        LoanListJson.Add('Loans', LoanArray);
        exit(LoanListJson);
    end;

    //Get Loans Details
    procedure Get_Loans_Details(Loan_Number: Code[20]) return: JsonObject
    var
        LoanRegister: Record "Loans Register"; // Assuming "Loan Register" is a table.
        LoanListJson: JsonObject;
        LoanArray: JsonArray;
        LoanEntry: JsonObject;
    begin
        LoanRegister.Reset;
        LoanRegister.SetRange("Loan  No.", Loan_Number);
        LoanRegister.SetRange(LoanRegister.Posted, true);
        if LoanRegister.Find('-') then begin
            repeat

                LoanRegister.CalcFields("Outstanding Balance");
                LoanEntry.Add('LoanNo', LoanRegister."Loan  No.");
                LoanEntry.Add('LoanProductType', LoanRegister."Loan Product Type");
                LoanEntry.Add('Loan_source', LoanRegister.Source);
                LoanEntry.Add('Application_date', LoanRegister."Application Date");
                LoanEntry.Add('Outstanding_Balance', Format(LoanRegister."Outstanding Balance"));
                LoanEntry.Add('Loan_principal', Format(LoanRegister."Approved Amount"));
                LoanEntry.Add('Oustanding_Interest', Format(LoanRegister."Oustanding Interest"));
                LoanEntry.Add('Installments', Format(LoanRegister.Installments));
                LoanEntry.Add('LoanStatus', Format(LoanRegister."Loan Status"));
                LoanEntry.Add('Repayment_amount', Format(LoanRegister."Loan Principle Repayment"));
                LoanEntry.Add('Loan_Category', LoanRegister."Loans Category-SASRA");
                LoanEntry.Add('Currency', 'KES');

                // LoanEntry.Add('RemainingInstallments', Format(LoanRegister.Installments - LoanRegister.LoanPeriod));//To check later
                LoanEntry.Add('Expected_date_0f_completion', Format(LoanRegister."Expected Date of Completion"));
                LoanArray.Add(LoanEntry);
            until LoanRegister.Next() = 0;
        end;
        LoanListJson.Add('Loans', LoanArray);
        exit(LoanListJson);
    end;

    //Get Loan Statement
    procedure MiniStatement(MemberNo: Text[100]) return: JsonObject
    var
        MemberLedgerEntry: Record "Cust. Ledger Entry";
        Members: Record Customer;
        MiniStmtJson: JsonObject;
        MiniStmtArray: JsonArray;
        StmtEntry: JsonObject;
        ShareCap: Option;
        DepContribution: Option;
        LoanRepayment: Option;
        RunCount: Integer;
        MaxNumberOfRows: Integer;
    begin
        Members.Reset;
        Members.SetRange(Members."No.", MemberNo);
        if Members.Find('-') then begin
            ShareCap := MemberLedgerEntry."Transaction Type"::"Shares Capital";
            DepContribution := MemberLedgerEntry."Transaction Type"::"Deposit Contribution";
            LoanRepayment := MemberLedgerEntry."Transaction Type"::"Repayment";
            MaxNumberOfRows := 100;

            MemberLedgerEntry.Reset;
            MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
            MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '%1|%2', MemberLedgerEntry."Transaction Type"::Loan, MemberLedgerEntry."Transaction Type"::Repayment);
            MemberLedgerEntry.Ascending(false);
            if MemberLedgerEntry.Find('-') then begin
                repeat
                    MemberLedgerEntry.CalcFields("Amount Posted");
                    StmtEntry.Add('PostingDate', Format(MemberLedgerEntry."Posting Date"));
                    StmtEntry.Add('TransactionType', Format(MemberLedgerEntry."Transaction Type"));
                    StmtEntry.Add('Amount', Format(Abs(MemberLedgerEntry."Amount Posted")));
                    if MemberLedgerEntry."Amount Posted" < 0 then begin
                        StmtEntry.Add('Entry_Type', 'Credit');
                    end else begin
                        StmtEntry.Add('Entry_Type', 'Debit');
                    end;

                    MiniStmtArray.Add(StmtEntry);

                    RunCount := RunCount + 1;
                    if RunCount >= MaxNumberOfRows then begin
                        MiniStmtJson.Add('MiniStatement', MiniStmtArray);
                        exit(MiniStmtJson);
                    end;
                until MemberLedgerEntry.Next() = 0;
            end;
            exit(MiniStmtJson);
        end;
    end;


}