Codeunit 51516120 "PORTALIntegration"
{

    trigger OnRun()
    begin

    end;

    var
        objMember: Record Customer;
        objLoanRegister: Record "Loans Register";
        objRegMember: Record "Membership Applications";
        objNextKin:
         Record "Next of Kin/Account Sign";
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

    [ServiceEnabled]
    procedure GetNextOfKin(MemberNumber: Code[100]) NextofkInVar: Text[3000]
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
        NextOfKinJson.WriteTo(NextofkInVar);
        exit(NextofkInVar);
    end;
    //Get Accounts
    [ServiceEnabled]
    procedure Get_Accounts(MemberNumber: Code[100]) MemberAccountVar: Text[3000]
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
        MemberAccountJson.WriteTo(MemberAccountVar);
        exit(MemberAccountVar);
    end;

    //Get Loans
    [ServiceEnabled]
    procedure Get_Loans(MemberNo: Code[20]) LoanList: Text[3000]
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
        LoanListJson.WriteTo(LoanList);
        exit(LoanList);
    end;

    //Get Loans Details
    [ServiceEnabled]
    procedure Get_Loans_Details(Loan_Number: Code[20]) LoanDetails: Text[3000];
    var
        LoanRegister: Record "Loans Register";
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
        LoanListJson.WriteTo(LoanDetails);
        exit(LoanDetails);
    end;

    //Get Loan Statement
    [ServiceEnabled]
    procedure MiniStatement(MemberNo: Text[100]) Ministat: Text[3000]
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
                    MiniStmtJson.WriteTo(Ministat);
                    RunCount := RunCount + 1;
                    if RunCount >= MaxNumberOfRows then begin
                        MiniStmtJson.Add('MiniStatement', MiniStmtArray);
                        exit(Ministat);
                    end;
                until MemberLedgerEntry.Next() = 0;
            end;
            MiniStmtJson.WriteTo(Ministat);
            exit(Ministat);
        end;
    end;

    procedure Get_Loan_Statement_Report(MemberNo: Code[50]; Parameters: Text; Loan_Number: Code[50]; StartDate: Date; EndDate: Date): Text
    var
        OutS: OutStream;
        Ins: InStream;
        TempBlob: Codeunit "Temp Blob";
        Cust: Record Customer;
        Base64: Codeunit "Base64 Convert";
    begin
        Cust.Reset;
        Cust.SetRange(Cust."No.", MemberNo);
        Cust.SetFilter(Cust."Loan No. Filter", Loan_Number);
        Cust.SetFilter("Date Filter", '%1...%2', StartDate, EndDate);
        if Cust.FindSet() then begin
            TempBlob.CreateOutStream(OutS);
            Report.SaveAs(51516227, Parameters, ReportFormat::Pdf, OutS);
            TempBlob.CreateInStream(Ins);
            exit(Base64.ToBase64(Ins));
        end;


    end;

    procedure Get_Loan_Guarantors(loanNo: Code[20]; guarantorNo: Code[20]) GaurantorList: Text[20000];
    var
        Guarantor_details: Record "Loans Guarantee Details";
        GuarLoanListJson: JsonObject;
        GuarArray: JsonArray;
        GuarEntry: JsonObject;
    begin
        Guarantor_details.Reset();
        Guarantor_details.SetRange(Guarantor_details."Loan No", loanNo);
        Guarantor_details.SetRange(Guarantor_details."Member No", guarantorNo);
        if Guarantor_details.FindSet() then begin
            repeat
                GuarEntry.Add('Member_Number', Guarantor_details."Member No");
                GuarEntry.Add('Name', Guarantor_details.Name);
                GuarEntry.Add('Amount_Guaranteed', Guarantor_details."Amont Guaranteed");
                GuarEntry.Add('Status', Guarantor_details."Acceptance Status");

                GuarArray.Add(GuarEntry);
                GuarLoanListJson.WriteTo(GaurantorList);
                exit(GaurantorList);
            until Guarantor_details.Next = 0;
        end;
    end;


    procedure Get_Loans_Guaranteed(MemberNo: Code[40]; LoanNo: Code[50]) GuaranteedLoans: Text[20000];
    var
        Guarantor_details: Record "Loans Guarantee Details";
        LoanRegister: Record "Loans Register";
        LoanGuaranteedLoanListJson: JsonObject;
        LoanGuarArray: JsonArray;
        LoanGuarEntry: JsonObject;
    begin
        Guarantor_details.Reset();
        Guarantor_details.SetRange(Guarantor_details."Member No", MemberNo);
        if Guarantor_details.FindSet() then begin
            repeat
                LoanGuarEntry.Add('Amount_Guaranteed', Guarantor_details."Amont Guaranteed");
                LoanRegister.Reset();
                LoanRegister.SetRange(LoanRegister."Loan  No.", Guarantor_details."Loan No");
                if LoanRegister.FindSet() then begin
                    LoanRegister.CalcFields(LoanRegister."Outstanding Balance");
                    LoanGuarEntry.Add('Member_Number', LoanRegister."Client Code");
                    LoanGuarEntry.Add('Name', LoanRegister."Client Name");
                    LoanGuarEntry.Add('Loan_Number', LoanRegister."Loan  No.");
                    LoanGuarEntry.Add('Loan_Type', LoanRegister."Loan Product Type");
                    LoanGuarEntry.Add('Loan_Category', LoanRegister."Loans Category-SASRA");
                    LoanGuarEntry.Add('Loan_Balance', LoanRegister."Outstanding Balance");
                    LoanGuarEntry.Add('Application_Date', LoanRegister."Application Date");

                    LoanGuarArray.Add(LoanGuarEntry);
                    LoanGuaranteedLoanListJson.WriteTo(GuaranteedLoans);
                    exit(GuaranteedLoans);

                end;
            until Guarantor_details.Next = 0;

        end;
    end;

    procedure Get_Loan_Types(MemberNo: Code[30]) loanType: Text
    Var
        LoanTypeListJson: JsonObject;
        LoanTypeArray: JsonArray;
        LoanTypeEntry: JsonObject;

    begin
        objMember.Reset();
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.FindSet() then begin
            Loansetup.Reset;
            if Loansetup.Find('-') then begin
                repeat
                    LoanTypeEntry.Add('Loan_Code', Loansetup.Code);
                    LoanTypeEntry.Add('Product_Name', Loansetup."Product Description");
                    LoanTypeEntry.Add('Minimum_Guarantors', Loansetup."Min No. Of Guarantors");
                    LoanTypeEntry.Add('Source', Loansetup.Source);
                    LoanTypeEntry.Add('Maximum_Amount', Loansetup."Max. Loan Amount");
                    LoanTypeEntry.Add('Minimum_Amount', Loansetup."Min. Loan Amount");
                    LoanTypeArray.Add(LoanTypeEntry);
                    LoanTypeListJson.WriteTo(loanType);
                    exit(loanType);
                until Loansetup.Next = 0;
            end;
        end;

    end;

    procedure Get_Loan_Calculator_Parameters(Loan_Code: Code[30]) LoanCalculationParameters: Text
    Var
        LoanCalculatorJson: JsonObject;
        LoancalculatorArray: JsonArray;
        LoanCalculatorEntry: JsonObject;
    begin
        Loansetup.Reset;
        if Loansetup.Find('-') then begin

            LoanCalculatorEntry.Add('Loan_Code', Loansetup.Code);
            LoanCalculatorEntry.Add('Product_Name', Loansetup."Product Description");
            LoanCalculatorEntry.Add('Repayment_Frequency', Loansetup."Repayment Frequency");
            LoanCalculatorEntry.Add('Maximum_Loan_Amount', Loansetup."Max. Loan Amount");
            LoanCalculatorEntry.Add('Interest_Rate', Loansetup."Interest rate");


            LoanCalculatorEntry.Add('Maximum_Installmets', Loansetup."No of Installment");
            LoanCalculatorEntry.Add('Minimum_Number_of_Guarantors', Loansetup."Min No. Of Guarantors");
            LoanCalculatorEntry.Add('Maximum_Number_of_Guarantors', Loansetup."Max No. Of Guarantors");
            LoanCalculatorEntry.Add('Recovery_Mode', Loansetup."Recovery Mode");
            LoanCalculatorEntry.Add('Source', Loansetup.Source);
            LoanCalculatorEntry.Add('Interest_Calculation_Method', Loansetup."Repayment Method");
            LoancalculatorArray.Add(LoanCalculatorEntry);
            LoanCalculatorJson.WriteTo(LoanCalculationParameters);
            exit(LoanCalculationParameters);

        end;
    end;

    procedure Get_Loan_Repayment_Schedule_report(MemberNo: Code[40]; LoanNumber: code[30]): Text
    var
        OutS: OutStream;
        Ins: InStream;
        TempBlob: Codeunit "Temp Blob";
        Cust: Record Customer;
        Base64: Codeunit "Base64 Convert";
        Paramaters: Text[30];

    begin
        objLoanRegister.Reset;
        objLoanRegister.SetRange(objLoanRegister."Client Code", MemberNo);
        objLoanRegister.SetRange(objLoanRegister."Loan  No.", LoanNumber);
        if objLoanRegister.FindSet() then begin
            TempBlob.CreateOutStream(OutS);
            Report.SaveAs(51516477, Paramaters, ReportFormat::Pdf, OutS);
            TempBlob.CreateInStream(Ins);
            exit(Base64.ToBase64(Ins));
        end;
    end;


    procedure Member_Registration(FullNames: Text[300]; Phone_Number: Text[300]; Email_Address: Text[300]; Gender: Option; Date_of_Birth: Date; Id_Number: code[100]; Passport_Number: code[100]; Home_Address: Text[300];
     Citizenship: Text[100]; Recruiter_Identifier: Text[100]; RecruiterMembNo: Text[100]; NextofKinFullnames: Text[100]; RelationShip: Text[100]; NextOfKinIdentifier: Text[50]; NextofKinPhone_number: Text[20]; NextofKinEmail_Address: text[15]; Percentage: Decimal; Benificiary: Boolean)

    begin

        objMember.Reset;
        objMember.SetRange(objMember."ID No.", Id_Number);
        if objMember.Find('-') then begin
            Message('already registered');
        end
        else begin
            objRegMember.Init;
            objRegMember.Name := FullNames;
            objRegMember."Phone No." := Phone_Number;
            objRegMember."E-Mail (Personal)" := Email_Address;
            objRegMember.Gender := Gender;
            objRegMember."Date of Birth" := Date_of_Birth;
            objRegMember."ID No." := Id_Number;
            objRegMember."Passport No." := Passport_Number;
            objRegMember."Home Address" := Home_Address;
            objRegMember."Country/Region Code" := Citizenship;
            objRegMember."Recruiter Name" := Recruiter_Identifier;
            objRegMember.Insert(true);


            objRegMember.Reset();
            objRegMember.SetRange(objRegMember."ID No.", Id_Number);
            if objRegMember.FindSet() then begin
                FnRegisterKin(Id_Number, NextofKinEmail_Address, RelationShip,
                NextOfKinIdentifier,
                NextofKinPhone_number,
                NextofKinEmail_Address,
                Percentage,
                Benificiary);
            end;

        end;
    end;

    procedure FnRegisterKin(MemberId_Number: Text[30]; "Full Names": Text; Relationship: Text; "ID Number": Code[10]; "Phone Contact": Code[10]; EmailAddress: Text; Percentage: Decimal; Benificiary: Boolean)
    begin
        begin
            objRegMember.Reset;
            objNextKin.Reset;
            objNextKin.Init();
            objRegMember.SetRange("ID No.", MemberId_Number);
            if objRegMember.Find('-') then begin
                repeat
                    objNextKin."Account No" := objRegMember."No.";
                    objNextKin.Name := "Full Names";
                    objNextKin.Relationship := Relationship;
                    objNextKin."ID No." := "ID Number";
                    objNextKin.Telephone := "Phone Contact";
                    objNextKin.Email := EmailAddress;
                    objNextKin.Insert(true);
                until objNextKin.Next = 0;

            end;
        end;
    end;


}




