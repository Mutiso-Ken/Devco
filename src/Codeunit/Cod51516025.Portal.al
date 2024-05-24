codeunit 51516160 "Portal Integration"
{

    trigger OnRun()
    begin

    end;

    var
        Title: Label 'title';
        Message: Label 'message';
        Status: Label 'status';
        Data: Label 'data';
        LoansRegister: Record "Loans Register";
        GenJournalLine: Record "Gen. Journal Line";
        LoanCharges: Record "Loan Product Charges";

    // ################################################################################################
    // MAIN FUNCTIONS
    // ################################################################################################
    procedure ProcessRequest(Request: Text) Response: Text;
    var
        RequestJson: JsonObject;
        OutputJson: JsonObject;
        RequestDataJson: JsonObject;
        RequestAction: Text;
        SessionId: Text;
        SessionValid: Boolean;
    begin
        if not RequestJson.ReadFrom(Request) then
            Error('Invalid Json Input');

        SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;
        RequestAction := SelectJsonToken(RequestJson, '$.action').AsValue.AsText;

        RequestDataJson := SelectJsonToken(RequestJson, '$.payload').AsObject();

        ValidateRequestHash(RequestJson);

        SessionValid := true;

        if not (RequestAction in ['login']) then begin
            SessionValid := ValidateUserSession(RequestJson);
        end;

        if SessionValid then begin
            case RequestAction of
                'get-member-details':
                    begin
                        OutputJson := GetMemberDetails(RequestDataJson);
                    end;
                'GET_ACCOUNTS':
                    begin
                        OutputJson := GetAccountsPortal(RequestDataJson);//Done
                    end;

                'GET_LOAN_CALCULATOR_PARAMETERS':
                    begin
                        OutputJson := GetLoanCalculatorParameters(RequestDataJson);//iKO SAWA
                    end;
                'GET_LOAN_REPAYMENT_SCHEDULE_REPORT':
                    begin
                        OutputJson := GetLoanRepaymentScheduleReportPortal(RequestDataJson);//Done
                    end;
                'GET_LOAN_STATEMENT':
                    begin
                        OutputJson := GetLoanStatementPortal(RequestDataJson); //Done to test
                    end;
                'GET_LOAN_GUARANTORS':
                    begin
                        OutputJson := GetLoanGuarantorsPortal(RequestDataJson);//iko sawa
                    end;
                'GET_LOANS_GUARANTEED':
                    begin
                        OutputJson := GetLoansGuaranteedPortal(RequestDataJson);//iko sawa
                    end;
                'GET_LOAN_TYPES':
                    begin
                        OutputJson := GetLoanTypesPortal(RequestDataJson);//iko swa
                    end;
                'GET_LOAN_STATEMENT_REPORT':
                    begin
                        OutputJson := GetLoanStatementReportPortal(RequestDataJson); //checked ending Testing
                    end;
                // 'GET_ACCOUNT_DETAILS':
                //     begin
                //         OutputJson := GetAccountDetailsPortal(RequestDataJson);
                //     end;
                'GET_LOANS':
                    begin
                        OutputJson := GetLoansPortal(RequestDataJson);//iko sawa
                    end;
                // 'charge-mapp-service':
                //     begin
                //         OutputJson := ChargeMappService(RequestDataJson);
                //     end;
                // 'get-atm-cards':
                //     begin
                //         OutputJson := GetATMCards(RequestDataJson);
                //     end;
                // 'action_atm_card':
                //     begin
                //         OutputJson := ActionATMCards(RequestDataJson);
                //     end;

                'GET_NEXT_OF_KIN':
                    begin
                        OutputJson := GetNextOfKin(RequestDataJson);//iko sawa
                    end;
                // 'balance-enquiry':
                //     begin
                //         OutputJson := BalanceEnquiry(RequestDataJson);
                //     end;
                // 'statement-enquiry':
                //     begin
                //         OutputJson := StatementEnquiry(RequestDataJson);
                //     end;
                // 'GET_ACCOUNT_STATEMENT':
                //     begin
                //         OutputJson := GetAccountStatementPortal(RequestDataJson);
                //     end;
                // 'GET_RECENT_ACCOUNT_TRANSACTIONS':
                //     begin
                //         OutputJson := GetRecentAccountTransactionsPortal(RequestDataJson);
                //     end;
                'GET_LOAN_DETAILS':
                    begin
                        OutputJson := GetLoanDetailsPortal(RequestDataJson); // re check
                    end;
                'GET_ACCOUNT_STATEMENT_REPORT':
                    begin
                        OutputJson := GetAccountStatementReportPortal(RequestDataJson); // re check
                    end;

                'GET_DIVIDEND_PAYSLIP_REPORT':
                    begin
                        OutputJson := GetDividendPayslipReportPortal(RequestDataJson);
                    end;
            // 'internal-funds-transfer-loan':
            //     begin
            //         OutputJson := InternalFundsTransferLoans(RequestDataJson);
            //     end;
            // 'pesa-out-request':
            //     begin
            //         OutputJson := PESAOUTRequest(RequestDataJson);
            //     end;
            // 'pesa-out-confirmation':
            //     begin
            //         OutputJson := PESAOUTConfirmation(RequestDataJson);
            //     end;
            // 'internal-funds-transfer':
            //     begin
            //         OutputJson := InternalFundsTransfer(RequestDataJson);
            //     end;
            // 'pesa-in-confirmation':
            //     begin
            //         OutputJson := PESAINConfirmation(RequestDataJson);
            //     end;
            // 'get-loan-types-ussd':
            //     begin
            //         OutputJson := GetLoanTypesUSSD(RequestDataJson);
            //     end;

            // 'get-specific-loan-type-details':
            //     begin
            //         OutputJson := GetSpecificLoanTypesDetails(RequestDataJson);
            //     end;
            // 'get-loan-typess':
            //     begin
            //         OutputJson := GetLoanTypes(RequestDataJson);
            //     end;
            // 'check-loan-limit':
            //     begin
            //         OutputJson := CheckLoanLimit(RequestDataJson);
            //     end;
            // 'loan-application':
            //     begin
            //         OutputJson := LoanApplication(RequestDataJson);
            //     end;
            // 'discard-loan':
            //     begin
            //         OutputJson := DiscardLoanApplication(RequestDataJson);
            //     end;
            // 'get-outstanding-loans':
            //     begin
            //         OutputJson := GetOutstandingLoans(RequestDataJson);
            //     end;
            // 'get-transaction-charges':
            //     begin
            //         OutputJson := GetTransactionCharges(RequestDataJson);
            //     end;
            // 'virtual-member-registration':
            //     begin
            //         OutputJson := VirtualMemberRegistration(RequestDataJson);
            //     end;
            // 'add-guarantor':
            //     begin
            //         OutputJson := AddGuarantors(RequestDataJson);
            //     end;
            // 'remove-guarantor':
            //     begin
            //         OutputJson := RemoveGuarantors(RequestDataJson);
            //     end;
            // 'get-pending-guarantorship-requests':
            //     begin
            //         OutputJson := GetPendingGuarantorshipRequest(RequestDataJson);
            //     end;
            // 'accept-reject-guarantorship-request':
            //     begin
            //         OutputJson := AcceptRejectGuarantorship(RequestDataJson);
            //     end;
            // 'get-loans-guaranteed':
            //     begin
            //         OutputJson := GetLoansGuaranteedByMember(RequestDataJson);
            //     end;
            // 'get-loans-with-guarantors':
            //     begin
            //         OutputJson := GetLoanswithGuarantors(RequestDataJson);
            //     end;
            // 'ATM_BALANCE_ENQUIRY':
            //     begin
            //         OutputJson := BalanceEnquiryATM(RequestDataJson);
            //     end;
            // 'check-loan-status':
            //     begin
            //         OutputJson := CheckLoanStatus(RequestDataJson);
            //     end;

            end;
        end
        else begin
            SetResponseStatus(OutputJson, 'error', '401 Unauthorized', 'Your request could not be processed');
        end;

        Response := WrapResponse(RequestJson, OutputJson);
    end;


    // ################################################################################################
    // REQUEST PROCESSING PROCEDURES (MATUMBO)
    // ################################################################################################
    local procedure GetMemberDetails(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        Customer: Record Customer;
        Found: Boolean;
    begin

        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        Found := false;
        if IdentifierType = 'MSISDN' THEN begin
            Customer.Reset();
            Customer.SetRange(Customer."Mobile Phone No", UpperCase(Identifier));
            if Customer.FindFirst() then begin

                SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                DataJson.Add('customer_type', UpperCase(Format(Customer."Account Category")));
                DataJson.Add('identifier_type', 'CUSTOMER_NO');
                DataJson.Add('identifier', Customer."No.");
                DataJson.Add('primary_identity_type', UpperCase(Format(Customer."ID No.")));
                DataJson.Add('primary_identity_no', Customer."ID No.");
                DataJson.Add('title', Format(Customer.Title));
                DataJson.Add('full_name', Customer.Name);
                DataJson.Add('gender', UpperCase(Format(Customer.Gender)));
                DataJson.Add('date_of_birth', Customer."Date Of Birth");
                DataJson.Add('primary_email_address', Customer."E-Mail (Personal)");
                DataJson.Add('primary_mobile_number', Customer."Mobile Phone No");
                DataJson.Add('status', UpperCase(Format(Customer.Status)));
                DataJson.Add('registration_date', Customer."Registration Date");
                DataJson.Add('tax_authority', 'KRA');
                DataJson.Add('tax_authority_pin_number', Customer.Pin);
                DataJson.Add('branch_code', '100');
                DataJson.Add('branch', 'NAIROBI');
                DataJson.Add('main_savings_account_no', Customer."No.");
                Found := true;
            end;
        end;


        if IdentifierType = 'NATIONAL_ID_NUMBER' THEN begin
            Customer.Reset();
            Customer.SetRange(Customer."ID No.", UpperCase(Identifier));
            if Customer.FindFirst() then begin

                SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                DataJson.Add('customer_type', UpperCase(Format(Customer."Account Category")));
                DataJson.Add('identifier_type', 'CUSTOMER_NO');
                DataJson.Add('identifier', Customer."No.");
                DataJson.Add('primary_identity_type', UpperCase(Format(Customer."ID No.")));
                DataJson.Add('primary_identity_no', Customer."ID No.");
                DataJson.Add('title', Format(Customer.Title));
                DataJson.Add('full_name', Customer.Name);
                DataJson.Add('gender', UpperCase(Format(Customer.Gender)));
                DataJson.Add('date_of_birth', Customer."Date Of Birth");
                DataJson.Add('primary_email_address', Customer."E-Mail (Personal)");
                DataJson.Add('primary_mobile_number', Customer."Mobile Phone No");
                DataJson.Add('status', UpperCase(Format(Customer.Status)));
                DataJson.Add('registration_date', Customer."Registration Date");
                DataJson.Add('tax_authority', 'KRA');
                DataJson.Add('tax_authority_pin_number', Customer.Pin);
                DataJson.Add('branch_code', '100');
                DataJson.Add('branch', 'NAIROBI');
                DataJson.Add('main_savings_account_no', Customer."No.");
                Found := true;
            end;
        end;


        if IdentifierType = 'MEMBER_NUMBER' THEN begin
            Customer.Reset();
            Customer.SetRange(Customer."No.", UpperCase(Identifier));
            if Customer.FindFirst() then begin

                SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                DataJson.Add('customer_type', UpperCase(Format(Customer."Account Category")));
                DataJson.Add('identifier_type', 'CUSTOMER_NO');
                DataJson.Add('identifier', Customer."No.");
                DataJson.Add('primary_identity_type', UpperCase(Format(Customer."ID No.")));
                DataJson.Add('primary_identity_no', Customer."ID No.");
                DataJson.Add('title', Format(Customer.Title));
                DataJson.Add('full_name', Customer.Name);
                DataJson.Add('gender', UpperCase(Format(Customer.Gender)));
                DataJson.Add('date_of_birth', Customer."Date Of Birth");
                DataJson.Add('primary_email_address', Customer."E-Mail (Personal)");
                DataJson.Add('primary_mobile_number', Customer."Mobile Phone No");
                DataJson.Add('status', UpperCase(Format(Customer.Status)));
                DataJson.Add('registration_date', Customer."Registration Date");
                DataJson.Add('tax_authority', 'KRA');
                DataJson.Add('tax_authority_pin_number', Customer.Pin);
                DataJson.Add('branch_code', '100');
                DataJson.Add('branch', 'NAIROBI');
                DataJson.Add('main_savings_account_no', Customer."No.");
                Found := true;
            end;
        end;

        if IdentifierType = 'CUSTOMER_NO' THEN begin
            Customer.Reset();
            Customer.SetRange(Customer."No.", UpperCase(Identifier));
            if Customer.FindFirst() then begin

                SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                DataJson.Add('customer_type', UpperCase(Format(Customer."Account Category")));
                DataJson.Add('identifier_type', 'CUSTOMER_NO');
                DataJson.Add('identifier', Customer."No.");
                DataJson.Add('primary_identity_type', UpperCase(Format(Customer."ID No.")));
                DataJson.Add('primary_identity_no', Customer."ID No.");
                DataJson.Add('title', Format(Customer.Title));
                DataJson.Add('full_name', Customer.Name);
                DataJson.Add('gender', UpperCase(Format(Customer.Gender)));
                DataJson.Add('date_of_birth', Customer."Date Of Birth");
                DataJson.Add('primary_email_address', Customer."E-Mail (Personal)");
                DataJson.Add('primary_mobile_number', Customer."Mobile Phone No");
                DataJson.Add('status', UpperCase(Format(Customer.Status)));
                DataJson.Add('registration_date', Customer."Registration Date");
                DataJson.Add('tax_authority', 'KRA');
                DataJson.Add('tax_authority_pin_number', Customer.Pin);
                DataJson.Add('branch_code', '100');
                DataJson.Add('branch', 'NAIROBI');
                DataJson.Add('main_savings_account_no', Customer."No.");
                Found := true;
            end;
        end;

        if IdentifierType = 'ACCOUNT_NUMBER' THEN begin
            Customer.Reset();
            Customer.SetRange(Customer."No.", UpperCase(Identifier));
            if Customer.FindFirst() then begin

                SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                DataJson.Add('customer_type', UpperCase(Format(Customer."Account Category")));
                DataJson.Add('identifier_type', 'CUSTOMER_NO');
                DataJson.Add('identifier', Customer."No.");
                DataJson.Add('primary_identity_type', UpperCase(Format(Customer."ID No.")));
                DataJson.Add('primary_identity_no', Customer."ID No.");
                DataJson.Add('title', Format(Customer.Title));
                DataJson.Add('full_name', Customer.Name);
                DataJson.Add('gender', UpperCase(Format(Customer.Gender)));
                DataJson.Add('date_of_birth', Customer."Date Of Birth");
                DataJson.Add('primary_email_address', Customer."E-Mail (Personal)");
                DataJson.Add('primary_mobile_number', Customer."Mobile Phone No");
                DataJson.Add('status', UpperCase(Format(Customer.Status)));
                DataJson.Add('registration_date', Customer."Registration Date");
                DataJson.Add('tax_authority', 'KRA');
                DataJson.Add('tax_authority_pin_number', Customer.Pin);
                DataJson.Add('branch_code', '100');
                DataJson.Add('branch', 'NAIROBI');
                DataJson.Add('main_savings_account_no', Customer."No.");
                Found := true;
            end;
        end;

        if Found = false then begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
        end;


        ResponseJson.Add(Data, DataJson);
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure GetAccountsPortal(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        AccountType: Text;
        IdentifierType: Text;
        Identifier: Text;
        AccountsArray: JsonArray;
        AccountObject: JsonObject;
        AccountNumber: Code[200];
        Iterator: Integer;
        AccountTypes: Record "Account Types-Saving Products";
        Found: boolean;
        FireLable: Label '+';
        Memb: record Customer;
        // MBuffer: Record "Mpesa Withdawal Buffer";
        AvailableBalance: Decimal;
        PendingAmount: Decimal;
    begin
        Iterator := 0;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        Found := false;
        AccountNumber := '';

        if IdentifierType = 'NATIONAL_ID_NUMBER' THEN BEGIN
            Memb.Reset();
            Memb.SetRange(Memb."ID No.", UpperCase(Format(Identifier)));
            if Memb.FindFirst() then begin

                SetResponseStatus(ResponseJson, 'success', 'Success', 'Member’s accounts list has been fetched successfully');
                repeat

                    Memb.CalcFields(Memb."Current Shares");
                    AccountObject.Add('Account_Number', Memb."No.");
                    AccountObject.Add('Account_Name', Memb."Global Dimension 1 Code" + ' ' + 'Savings Account');
                    AccountObject.Add('Account_Type', Memb."Global Dimension 1 Code" + ' ' + 'Account');
                    AccountObject.Add('Account_Status', Memb.Status);
                    AccountObject.Add('Currency', 'KES');
                    AccountObject.Add('Deposits', Memb."Current Shares");
                    AccountObject.Add('actions', 'Deposits');
                    AccountsArray.Add(AccountObject);
                    Clear(AccountObject);
                    Iterator := Iterator + 1;

                    Found := true;

                until Memb.Next() = 0;
                //DataJson.Add('accounts', AccountsArray);
            end;


        end;



        if Found = false then begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
        end;

        ResponseJson.Add(Data, AccountsArray);
    end;

    // local procedure GetAccountDetailsPortal(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     AccountType: Text;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     AccountsArray: JsonArray;
    //     AccountsJson: JsonObject;
    //     SavLedger: record "Detailed Vendor Ledg. Entry";
    //     AccountObject: JsonObject;
    //     AccountNumber: Code[200];
    //     Iterator: Integer;
    //     Vend: Record Vendor;
    //     Vendor: Record Vendor;
    //     Vendors: Record Vendor;
    //     AccountTypes: Record "Account Types-Saving Products";
    //     Found: boolean;
    //     FireLable: Label '+';
    //     Memb: record Customer;
    //     MBuffer: Record "Mpesa Withdawal Buffer";
    //     AvailableBalance: Decimal;
    //     PendingAmount: Decimal;
    //     AccountNo: Text[200];
    //     Debits: Decimal;
    //     Credits: Decimal;
    // begin
    //     Iterator := 0;
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     AccountNo := SelectJsonToken(RequestJson, '$.account_number').AsValue.AsText;
    //     Found := false;
    //     AccountNumber := '';

    //     if IdentifierType = 'MSISDN' THEN BEGIN
    //         Memb.Reset();
    //         Memb.SetRange(Memb."Mobile Phone No", UpperCase(Format(Identifier)));
    //         if Memb.FindFirst() then begin
    //             Vendor.Reset();
    //             Vendor.SetRange(Vendor."BOSA Account No", Memb."No.");
    //             Vendor.SetRange(Vendor."No.", UpperCase(AccountNo));
    //             if Vendor.FindFirst() then begin
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Member’s accounts list has been fetched successfully');
    //                 repeat
    //                     AccountNumber := Vendor."BOSA Account No";
    //                     SavLedger.Reset();
    //                     SavLedger.SetRange(SavLedger."Vendor No.", Vendor."No.");
    //                     SavLedger.SetFilter(SavLedger."Debit Amount", '<>%1', 0);
    //                     if SavLedger.FindSet() then begin
    //                         SavLedger.CalcSums(SavLedger."Debit Amount");
    //                         Debits := SavLedger."Debit Amount";
    //                     end;

    //                     SavLedger.Reset();
    //                     SavLedger.SetRange(SavLedger."Vendor No.", Vendor."No.");
    //                     SavLedger.SetFilter(SavLedger."Credit Amount", '<>%1', 0);
    //                     if SavLedger.FindSet() then begin
    //                         SavLedger.CalcSums(SavLedger."Credit Amount");
    //                         Credits := SavLedger."Credit Amount";
    //                     end;
    //                     Vendor.CalcFields(Balance);

    //                     PendingAmount := 0;

    //                     if Vendor."Account Type" = '103' then begin
    //                         MBuffer.Reset();
    //                         MBuffer.SetRange(MBuffer."Vendor No", Vendor."No.");
    //                         MBuffer.SetRange(MBuffer.Posted, false);
    //                         MBuffer.SetRange(MBuffer.Reversed, false);
    //                         if MBuffer.FindSet() then begin
    //                             MBuffer.CalcSums(MBuffer."Amount Requested");
    //                             PendingAmount := MBuffer."Amount Requested";
    //                         end;
    //                         AvailableBalance := 0;
    //                         AvailableBalance := Vendor.Balance - ((Vendor."Uncleared Cheques" - Vendor."Cheque Discounted Amount") + PendingAmount + Vendor."ATM Transactions" + Vendor."EFT Transactions" + 1000 + Vendor."Mobile Transactions" + Vendor."Amount to freeze");
    //                     end;
    //                     if Vendor."Account Type" <> '103' then begin
    //                         AvailableBalance := Vendor.Balance;
    //                     end;

    //                     AccountTypes.Get(Vendor."Account Type");

    //                     AccountObject.Add('account_number', Vendor."No.");
    //                     AccountObject.Add('account_name', AccountTypes.Description);
    //                     AccountObject.Add('account_type', Format(AccountTypes."Account Location"));
    //                     AccountObject.Add('account_status', UpperCase(Format(Vendor.Status)));
    //                     AccountObject.Add('currency', 'KES');
    //                     AccountObject.Add('book_balance', Vendor.Balance);
    //                     AccountObject.Add('available_balance', AvailableBalance);
    //                     AccountObject.Add('credits', Credits);
    //                     AccountObject.Add('debits', Debits);
    //                     //AccountsArray.Add(AccountObject);
    //                     //Clear(AccountObject);
    //                     Iterator := Iterator + 1;

    //                     Found := true;

    //                 until Vendor.Next() = 0;
    //                 //DataJson.Add('accounts', AccountsArray);
    //             end;
    //         end;

    //     end;



    //     if Found = false then begin
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
    //     end;

    //     ResponseJson.Add(Data, AccountObject);
    // end;

    // local procedure ChargeMappService(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     ServiceType: Text;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     AccountsArray: JsonArray;
    //     AccountObject: JsonObject;
    //     AccountNumber: Code[200];
    //     Iterator: Integer;
    //     Vend: Record Vendor;
    //     Vendor: Record Vendor;
    //     AccountTypes: Record "Account Types-Saving Products";
    //     Found: boolean;
    //     FireLable: Label '+';
    //     Memb: record Customer;
    //     MBuffer: Record "Mpesa Withdawal Buffer";
    //     AvailableBalance: Decimal;
    //     PendingAmount: Decimal;
    //     MpesaComm: Decimal;
    //     SaccoCommission: Decimal;
    //     VendorComm: Decimal;
    //     ExciseDuty: Decimal;
    //     TotalAmount: Decimal;
    //     Category: Text;
    //     VendorCommAccount: Code[20];
    //     ExciseDutyAccount: Code[20];
    //     TotalAmountAccount: Code[20];
    //     SaccoCommissionAccount: Code[20];
    //     MpesaCommAccount: Code[20];
    //     SaccoGen: Record "Sacco General Set-Up";
    //     smsManagement: Codeunit "Sms Management";
    //     Members: Record Customer;

    // begin
    //     Iterator := 0;

    //     ServiceType := SelectJsonToken(RequestJson, '$.service_type').AsValue.AsText;
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

    //     Found := false;
    //     AccountNumber := '';



    //     if ServiceType = 'MAPP_LOGIN' THEN BEGIN
    //         if IdentifierType = 'MSISDN' then BEGIN
    //             Memb.Reset();
    //             Memb.SetRange(Memb."Mobile Phone No", UpperCase(Format(Identifier)));
    //             if Memb.FindFirst() then begin
    //                 Found := true;
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request was successful');
    //                 Vendor.Reset();
    //                 Vendor.SetRange(Vendor."No.", Memb."FOSA Account No.");
    //                 if Vendor.FindFirst() then begin
    //                     Vendor.CalcFields(Vendor.Balance);
    //                     MBuffer.Reset();
    //                     MBuffer.SetRange(MBuffer."Vendor No", Memb."FOSA Account No.");
    //                     MBuffer.SetRange(MBuffer.Posted, false);
    //                     MBuffer.SetRange(MBuffer.Reversed, false);
    //                     if MBuffer.FindSet() then begin
    //                         MBuffer.CalcSums(MBuffer."Amount Requested");
    //                         PendingAmount := MBuffer."Amount Requested";
    //                     end;
    //                     AvailableBalance := 0;
    //                     AvailableBalance := Vendor.Balance - ((Vendor."Uncleared Cheques" - Vendor."Cheque Discounted Amount") + PendingAmount + Vendor."ATM Transactions" + Vendor."EFT Transactions" + 1000 + Vendor."Mobile Transactions" + Vendor."Amount to freeze");
    //                 end;


    //                 IF AvailableBalance >= 30 then BEGIN
    //                     BATCH_TEMPLATE := 'GENERAL';
    //                     BATCH_NAME := 'MOBILE';
    //                     DOCUMENT_NO := Identifier;
    //                     GenJournalLine.Reset();
    //                     GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
    //                     GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
    //                     if GenJournalLine.FindSet() then begin
    //                         GenJournalLine.DeleteAll();
    //                     end;

    //                     DataJson.Add('transaction_status', 'SUCCESS');
    //                     DataJson.Add('transaction_description', 'Transaction processed successfully.');
    //                     TotalAmount := 0;
    //                     SaccoCommission := 0;
    //                     VendorComm := 0;
    //                     ExciseDuty := 0;
    //                     TotalAmount := 30;
    //                     VendorComm := 20 / 100 * 30;
    //                     SaccoGen.Get();
    //                     SaccoCommission := 30 - VendorComm;
    //                     ExciseDuty := SaccoGen."Excise Duty(%)" / 100 * SaccoCommission;
    //                     SaccoCommission := SaccoCommission - ExciseDuty;

    //                     //Error('Total%1Vendor%2SaccoCom%3Excise%4',TotalAmount,VendorComm,SaccoCommission,ExciseDuty);
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, Vendor."No.", Today, TotalAmount, 'FOSA', DOCUMENT_NO,
    //                      'Mobile charges' + ' ' + Vend."No.", '');//

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, 'VEND00244', Today, VendorComm * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Charges' + ' ' + Vend."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"G/L Account", '300-000-417', Today, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Sacco Comm' + ' ' + Vend."No.", '');

    //                     SaccoGen.Get();
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", Today, ExciseDuty * -1, 'FOSA', DOCUMENT_NO,
    //                      'Excise Duty Mobile Charges' + ' ' + Vend."No.", '');


    //                     GenJournalLine.Reset;
    //                     GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //                     GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //                     if GenJournalLine.Find('-') then begin
    //                         Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //                     end;
    //                 END;

    //                 IF AvailableBalance < 30 then BEGIN
    //                     DataJson.Add('transaction_status', 'INSUFFICIENT_FUNDS');
    //                     DataJson.Add('transaction_description', 'Transaction processed successfully.');
    //                 END;

    //             end;
    //         END;
    //     end;


    //     if Found = false then begin
    //         SetResponseStatus(ResponseJson, 'success', 'Success', 'Request was successful');
    //         DataJson.Add('transaction_status', 'ERROR');
    //         DataJson.Add('transaction_description', 'Transaction processed successfully.');
    //     end;

    //     ResponseJson.Add(Data, DataJson);
    // end;


    // local procedure GetATMCards(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     AccountType: Text;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     AccountsArray: JsonArray;
    //     AccountObject: JsonObject;
    //     AccountNumber: Code[200];
    //     Iterator: Integer;
    //     Vend: Record Vendor;
    //     Vendor: Record Vendor;
    //     AccountTypes: Record "Account Types-Saving Products";
    //     Found: boolean;
    //     FireLable: Label '+';
    //     Memb: record Customer;
    // begin
    //     Iterator := 0;

    //     //AccountType := SelectJsonToken(RequestJson, '$.account_type').AsValue.AsText;
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

    //     Found := false;
    //     AccountNumber := '';

    //     if IdentifierType = 'MEMBER_NUMBER' then begin
    //         Memb.Reset();
    //         Memb.SetRange(Memb."No.", UpperCase(Format(Identifier)));
    //         if Memb.FindFirst() then begin
    //             Vendor.Reset();
    //             Vendor.SetRange(Vendor."BOSA Account No", Memb."No.");
    //             Vendor.SetRange(Vendor."Account Type", '103');
    //             if Vendor.FindFirst() then begin
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                 AccountNumber := Vendor."BOSA Account No";

    //                 Vendor.CalcFields(Balance);
    //                 AccountTypes.Get(Vendor."Account Type");

    //                 AccountObject.Add('atm_card_number', Vendor."ATM No.");
    //                 AccountObject.Add('account_number', Vendor."No.");
    //                 AccountObject.Add('status', Format(Vendor."Card Status"));
    //                 AccountsArray.Add(AccountObject);
    //                 Clear(AccountObject);
    //                 Iterator := Iterator + 1;

    //                 Found := true;


    //                 DataJson.Add('atm_card', AccountsArray);
    //             end;
    //         end;
    //     end;

    //     if IdentifierType = 'IDENTIFICATION_NUMBER' then begin
    //         Memb.Reset();
    //         Memb.SetRange(Memb."ID No.", UpperCase(Format(Identifier)));
    //         if Memb.FindFirst() then begin
    //             Vendor.Reset();
    //             Vendor.SetRange(Vendor."BOSA Account No", Memb."No.");
    //             Vendor.SetRange(Vendor."Account Type", '103');
    //             if Vendor.FindFirst() then begin
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                 AccountNumber := Vendor."BOSA Account No";

    //                 Vendor.CalcFields(Balance);
    //                 AccountTypes.Get(Vendor."Account Type");

    //                 AccountObject.Add('atm_card_number', Vendor."ATM No.");
    //                 AccountObject.Add('account_number', Vendor."No.");
    //                 AccountObject.Add('status', Format(Vendor."Card Status"));
    //                 AccountsArray.Add(AccountObject);
    //                 Clear(AccountObject);
    //                 Iterator := Iterator + 1;

    //                 Found := true;
    //                 DataJson.Add('atm_card', AccountsArray);
    //             end;
    //         end;
    //     END;


    //     if IdentifierType = 'MSISDN' then begin

    //         Memb.Reset();
    //         Memb.SetRange(Memb."Mobile Phone No", UpperCase(Format(Identifier)));
    //         if Memb.FindFirst() then begin
    //             Vendor.Reset();
    //             Vendor.SetRange(Vendor."BOSA Account No", Memb."No.");
    //             Vendor.SetRange(Vendor."Account Type", '103');
    //             if Vendor.FindFirst() then begin
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //                 AccountNumber := Vendor."BOSA Account No";

    //                 Vendor.CalcFields(Balance);
    //                 AccountTypes.Get(Vendor."Account Type");

    //                 AccountObject.Add('atm_card_number', Vendor."ATM No.");
    //                 AccountObject.Add('account_number', Vendor."No.");
    //                 AccountObject.Add('status', Format(Vendor."Card Status"));
    //                 AccountsArray.Add(AccountObject);
    //                 Clear(AccountObject);
    //                 Iterator := Iterator + 1;

    //                 Found := true;
    //                 DataJson.Add('atm_card', AccountsArray);
    //             end;
    //         end;
    //     END;
    //     if Found = false then begin
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
    //     end;

    //     ResponseJson.Add(Data, DataJson);
    // end;


    // local procedure ActionATMCards(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     AccountType: Text;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     AccountsArray: JsonArray;
    //     AccountObject: JsonObject;
    //     AccountNumber: Code[200];
    //     Iterator: Integer;
    //     Vend: Record Vendor;
    //     Vendor: Record Vendor;
    //     AccountTypes: Record "Account Types-Saving Products";
    //     Found: boolean;
    //     FireLable: Label '+';
    //     Memb: record Customer;
    //     ATMCardAction: text;
    // begin
    //     Iterator := 0;

    //     ATMCardAction := SelectJsonToken(RequestJson, '$.atm_card_action').AsValue.AsText;
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

    //     Found := false;
    //     AccountNumber := '';
    //     if ATMCardAction = 'enable' then begin
    //         if IdentifierType = 'MEMBER_NUMBER' then begin
    //             Memb.Reset();
    //             Memb.SetRange(Memb."No.", UpperCase(Format(Identifier)));
    //             if Memb.FindFirst() then begin
    //                 Vendor.Reset();
    //                 Vendor.SetRange(Vendor."BOSA Account No", Memb."No.");
    //                 Vendor.SetRange(Vendor."Account Type", '103');
    //                 if Vendor.FindFirst() then begin
    //                     SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                     Vendor."Card Status" := Vendor."Card Status"::Active;
    //                     Vendor.Modify();
    //                 end;
    //             end;
    //         end;

    //         if IdentifierType = 'IDENTIFICATION_NUMBER' then begin

    //             Memb.Reset();
    //             Memb.SetRange(Memb."No.", UpperCase(Format(Identifier)));
    //             if Memb.FindFirst() then begin
    //                 Vendor.Reset();
    //                 Vendor.SetRange(Vendor."BOSA Account No", Memb."No.");
    //                 Vendor.SetRange(Vendor."Account Type", '103');
    //                 if Vendor.FindFirst() then begin
    //                     SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                     Vendor."Card Status" := Vendor."Card Status"::Active;
    //                     Vendor.Modify();
    //                 end;

    //             END;


    //             if IdentifierType = 'MSISDN' then begin


    //                 Memb.Reset();
    //                 Memb.SetRange(Memb."No.", UpperCase(Format(Identifier)));
    //                 if Memb.FindFirst() then begin
    //                     Vendor.Reset();
    //                     Vendor.SetRange(Vendor."BOSA Account No", Memb."No.");
    //                     Vendor.SetRange(Vendor."Account Type", '103');
    //                     if Vendor.FindFirst() then begin
    //                         SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                         Vendor."Card Status" := Vendor."Card Status"::Active;
    //                         Vendor.Modify();
    //                     end;
    //                 end;
    //             end;
    //         end;

    //     end;

    //     if ATMCardAction = 'disable' then begin
    //         if IdentifierType = 'MEMBER_NUMBER' then begin
    //             Memb.Reset();
    //             Memb.SetRange(Memb."No.", UpperCase(Format(Identifier)));
    //             if Memb.FindFirst() then begin
    //                 Vendor.Reset();
    //                 Vendor.SetRange(Vendor."BOSA Account No", Memb."No.");
    //                 Vendor.SetRange(Vendor."Account Type", '103');
    //                 if Vendor.FindFirst() then begin
    //                     SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                     Vendor."Card Status" := Vendor."Card Status"::Frozen;
    //                     Vendor.Modify();
    //                 end;
    //             end;
    //         end;

    //         if IdentifierType = 'IDENTIFICATION_NUMBER' then begin
    //             Memb.Reset();
    //             Memb.SetRange(Memb."No.", UpperCase(Format(Identifier)));
    //             if Memb.FindFirst() then begin
    //                 Vendor.Reset();
    //                 Vendor.SetRange(Vendor."BOSA Account No", Memb."No.");
    //                 Vendor.SetRange(Vendor."Account Type", '103');
    //                 if Vendor.FindFirst() then begin
    //                     SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                     Vendor."Card Status" := Vendor."Card Status"::Frozen;
    //                     Vendor.Modify();
    //                 end;
    //             end;


    //             if IdentifierType = 'MSISDN' then begin


    //                 Memb.Reset();
    //                 Memb.SetRange(Memb."No.", UpperCase(Format(Identifier)));
    //                 if Memb.FindFirst() then begin
    //                     Vendor.Reset();
    //                     Vendor.SetRange(Vendor."BOSA Account No", Memb."No.");
    //                     Vendor.SetRange(Vendor."Account Type", '103');
    //                     if Vendor.FindFirst() then begin
    //                         SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                         Vendor."Card Status" := Vendor."Card Status"::Frozen;
    //                         Vendor.Modify();
    //                     end;
    //                 end;
    //             end;
    //         end;
    //     end;








    //     ResponseJson.Add(Data, DataJson);
    // end;

    // // ------------------------------------------------------------------------------------------------
    // local procedure BalanceEnquiry(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     IdentifierType: Text;
    //     AccountObject: JsonObject;
    //     Vendor: Record Vendor;
    //     Identifier: Text;
    //     AccountsArray: JsonArray;
    //     AccountType: Text;
    //     AccountNumber: Text;
    //     Customer: Record Customer;
    //     Vend: Record Vendor;
    //     LoanResgister: Record "Loans Register";
    //     Found: Boolean;
    //     MobilePhoneNumber: Text;
    //     AccountTypes: Record "Account Types-Saving Products";
    //     AvailableBalance: Decimal;
    //     MBuffer: Record "Mpesa Withdawal Buffer";
    //     PendingAmount: Decimal;
    //     Memb: Record Customer;
    //     SaccoGen: Record "Sacco General Set-Up";
    //     Loans: Record "Loans Register";
    //     LoanObject: JsonObject;
    //     LoansArray: JsonArray;
    //     ProdFactory: Record "Loan Products Setup";
    // begin
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     AccountType := SelectJsonToken(RequestJson, '$.account_type').AsValue.AsText;
    //     AccountNumber := SelectJsonToken(RequestJson, '$.account_number').AsValue.AsText;
    //     IF AccountType = 'ACCOUNT' THEN begin
    //         BATCH_TEMPLATE := 'GENERAL';
    //         BATCH_NAME := 'MOBILE';
    //         GenJournalLine.Reset();
    //         GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
    //         GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
    //         if GenJournalLine.FindSet() then begin
    //             GenJournalLine.DeleteAll();
    //         end;
    //         Vend.Reset();
    //         Vend.SetRange(Vend."Mobile Phone No", UpperCase('+' + Identifier));
    //         if Vend.FindFirst() then begin
    //             if Vend.Get(AccountNumber) then begin
    //                 DOCUMENT_NO := Vend."No.";
    //                 AccountTypes.Get(Vend."Account Type");
    //                 Vend.CalcFields(Balance);
    //                 if Vend."Account Type" = '103' then begin
    //                     MBuffer.Reset();
    //                     MBuffer.SetRange(MBuffer."Vendor No", Vend."No.");
    //                     MBuffer.SetRange(MBuffer.Posted, false);
    //                     MBuffer.SetRange(MBuffer.Reversed, false);
    //                     if MBuffer.FindSet() then begin
    //                         MBuffer.CalcSums(MBuffer."Amount Requested");
    //                         PendingAmount := 0;
    //                         PendingAmount := MBuffer."Amount Requested";
    //                     end;
    //                     AvailableBalance := 0;
    //                     AvailableBalance := Vend.Balance - ((Vend."Uncleared Cheques" - Vend."Cheque Discounted Amount") + PendingAmount + Vend."ATM Transactions" + Vend."EFT Transactions" + 1000 + Vend."Mobile Transactions" + Vend."Amount to freeze");
    //                 end;
    //                 if Vend."Account Type" <> '103' then begin

    //                     AvailableBalance := Vend.Balance;


    //                 end;
    //         SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //         DataJson.Add('account_name', Vend."Account Type");
    //         DataJson.Add('account_label', AccountTypes.Description);
    //         DataJson.Add('account_number', Vend."No.");
    //         DataJson.Add('account_status', Format(Vend.Status));
    //         DataJson.Add('account_type', Vend."Account Type");
    //         DataJson.Add('account_balance', AvailableBalance);
    //         Found := true;//300-000-410

    //         SaccoGen.Get();
    //         Customer.Get(Vend."BOSA Account No");
    //         LineNo := LineNo + 10000;
    //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //         GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", Today, SaccoGen."Balance Enquiry Charge" + SaccoGen."Vendor Enquiry Charge", 'FOSA', DOCUMENT_NO,
    //          'balance Enquiry charge' + ' ' + Vend."No.", '');

    //         LineNo := LineNo + 10000;
    //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //         GenJournalLine."Account Type"::"G/L Account", '300-000-410', Today, SaccoGen."Balance Enquiry Charge" * -1, 'FOSA', DOCUMENT_NO,
    //          'balance Enquiry charge' + ' ' + Vend."No.", '');


    //         LineNo := LineNo + 10000;
    //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //         GenJournalLine."Account Type"::Vendor, SaccoGen."Vendor G/L", Today, SaccoGen."Vendor Enquiry Charge" * -1, 'FOSA', DOCUMENT_NO,
    //          'Vendor Charges' + ' ' + Vend."No.", '');

    //         GenJournalLine.Reset;
    //         GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //         GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //         if GenJournalLine.Find('-') then begin
    //             Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //         end;

    //     end;
    // end;
    //         Vend.Reset();
    //         Vend.SetRange(Vend."BOSA Account No", UpperCase(Identifier));
    //         if Vend.FindFirst() then begin
    //             if Vend.Get(AccountNumber) then begin
    //                 AccountTypes.Get(Vend."Account Type");
    //                 DOCUMENT_NO := Vend."No.";
    //                 Vend.CalcFields(Balance);
    //                 if Vend."Account Type" = '103' then begin
    //                     MBuffer.Reset();
    //                     MBuffer.SetRange(MBuffer."Vendor No", Vend."No.");
    //                     MBuffer.SetRange(MBuffer.Posted, false);
    //                     MBuffer.SetRange(MBuffer.Reversed, false);
    //                     if MBuffer.FindSet() then begin
    //                         MBuffer.CalcSums(MBuffer."Amount Requested");
    //                         PendingAmount := 0;
    //                         PendingAmount := MBuffer."Amount Requested";
    //                     end;
    //                     AvailableBalance := 0;
    //                     AvailableBalance := Vend.Balance - ((Vend."Uncleared Cheques" - Vend."Cheque Discounted Amount") + PendingAmount + Vend."ATM Transactions" + Vend."EFT Transactions" + 1000 + Vend."Mobile Transactions" + Vend."Amount to freeze");
    //                 end;
    //                 if Vend."Account Type" <> '103' then begin
    //                     AvailableBalance := Vend.Balance;
    //                 end;
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //                 DataJson.Add('account_name', Vend."Account Type");
    //                 DataJson.Add('account_label', AccountTypes.Description);
    //                 DataJson.Add('account_number', Vend."No.");
    //                 DataJson.Add('account_status', Format(Vend.Status));
    //                 DataJson.Add('account_type', Vend."Account Type");
    //                 DataJson.Add('account_balance', AvailableBalance);
    //                 Found := true;

    //                 SaccoGen.Get();
    //                 Customer.Get(Vend."BOSA Account No");
    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", Today, SaccoGen."Balance Enquiry Charge" + SaccoGen."Vendor Enquiry Charge", 'FOSA', DOCUMENT_NO,
    //                  'balance Enquiry charge' + ' ' + Vend."No.", '');

    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::"G/L Account", '300-000-410', Today, SaccoGen."Balance Enquiry Charge" * -1, 'FOSA', DOCUMENT_NO,
    //                  'balance Enquiry charge' + ' ' + Vend."No.", '');


    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, SaccoGen."Vendor G/L", Today, SaccoGen."Vendor Enquiry Charge" * -1, 'FOSA', DOCUMENT_NO,
    //                  'Vendor Charges' + ' ' + Vend."No.", '');


    //                 GenJournalLine.Reset;
    //                 GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //                 GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //                 if GenJournalLine.Find('-') then begin
    //                     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //                 end;
    //             end;
    //         end;
    //         Vend.Reset();
    //         Vend.SetRange(Vend."ID No.", UpperCase(Identifier));
    //         if Vend.FindFirst() then begin
    //             // if true then begin
    //             if Vend.Get(AccountNumber) then begin
    //                 AccountTypes.Get(Vend."Account Type");
    //                 DOCUMENT_NO := Vend."No.";
    //                 Vend.CalcFields(Balance);
    //                 if Vend."Account Type" = '103' then begin
    //                     MBuffer.Reset();
    //                     MBuffer.SetRange(MBuffer."Vendor No", Vend."No.");
    //                     MBuffer.SetRange(MBuffer.Posted, false);
    //                     MBuffer.SetRange(MBuffer.Reversed, false);
    //                     if MBuffer.FindSet() then begin
    //                         MBuffer.CalcSums(MBuffer."Amount Requested");
    //                         PendingAmount := 0;
    //                         PendingAmount := MBuffer."Amount Requested";
    //                     end;
    //                     AvailableBalance := 0;
    //                     AvailableBalance := Vend.Balance - ((Vend."Uncleared Cheques" - Vend."Cheque Discounted Amount") + PendingAmount + Vend."ATM Transactions" + Vend."EFT Transactions" + 1000 + Vend."Mobile Transactions" + Vend."Amount to freeze");
    //                 end;
    //                 if Vend."Account Type" <> '103' then begin
    //                     AvailableBalance := Vend.Balance;
    //                 end;
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //                 DataJson.Add('account_name', Vend."Account Type");
    //                 DataJson.Add('account_label', AccountTypes.Description);
    //                 DataJson.Add('account_number', Vend."No.");
    //                 DataJson.Add('account_status', Format(Vend.Status));
    //                 DataJson.Add('account_type', Vend."Account Type");
    //                 DataJson.Add('account_balance', AvailableBalance);
    //                 Found := true;
    //                 SaccoGen.Get();
    //                 Customer.Get(Vend."BOSA Account No");
    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", Today, SaccoGen."Balance Enquiry Charge" + SaccoGen."Vendor Enquiry Charge", 'FOSA', DOCUMENT_NO,
    //                  'balance Enquiry charge' + ' ' + Vend."No.", '');

    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::"G/L Account", '300-000-410', Today, SaccoGen."Balance Enquiry Charge" * -1, 'FOSA', DOCUMENT_NO,
    //                  'balance Enquiry charge' + ' ' + Vend."No.", '');


    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, SaccoGen."Vendor G/L", Today, SaccoGen."Vendor Enquiry Charge" * -1, 'FOSA', DOCUMENT_NO,
    //                  'Vendor Charges' + ' ' + Vend."No.", '');

    //                 GenJournalLine.Reset;
    //                 GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //                 GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //                 if GenJournalLine.Find('-') then begin
    //                     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //                 end;
    //             end
    //         end;
    //     END;
    //     IF AccountType = 'ALL' then begin
    //         BATCH_TEMPLATE := 'GENERAL';
    //         BATCH_NAME := 'MOBILE';

    //         GenJournalLine.Reset();
    //         GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
    //         GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
    //         if GenJournalLine.FindSet() then begin
    //             GenJournalLine.DeleteAll();
    //         end;

    //         Memb.Reset();
    //         Memb.SetRange(Memb."No.", UpperCase(Format(Identifier)));
    //         if Memb.FindFirst() then begin
    //             Vendor.Reset();
    //             Vendor.SetRange(Vendor."BOSA Account No", Memb."No.");
    //             if Vendor.FindFirst() then begin
    //                 DOCUMENT_NO := Vendor."No.";
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                 repeat
    //                     AccountNumber := Vendor."BOSA Account No";

    //                     Vendor.CalcFields(Balance);
    //                     PendingAmount := 0;
    //                     MBuffer.Reset();
    //                     MBuffer.SetRange(MBuffer."Vendor No", Vendor."No.");
    //                     MBuffer.SetRange(MBuffer.Posted, false);
    //                     MBuffer.SetRange(MBuffer.Reversed, false);
    //                     if MBuffer.FindSet() then begin
    //                         MBuffer.CalcSums(MBuffer."Amount Requested");
    //                         PendingAmount := MBuffer."Amount Requested";
    //                     end;
    //                     AvailableBalance := 0;
    //                     AvailableBalance := Vendor.Balance - ((Vendor."Uncleared Cheques" - Vendor."Cheque Discounted Amount") + PendingAmount + Vendor."ATM Transactions" + Vendor."EFT Transactions" + 1000 + Vendor."Mobile Transactions" + Vendor."Amount to freeze");
    //                     AccountTypes.Get(Vendor."Account Type");
    //                     if Vendor."Account Type" <> '103' then begin
    //                         AvailableBalance := Vendor.Balance;
    //                     end;
    //                     //Error('mMessage%1',AvailableBalance);
    //                     AccountObject.Add('account_name', Vendor."Account Type");
    //                     AccountObject.Add('account_label', AccountTypes.Description);
    //                     AccountObject.Add('account_number', Vendor."No.");
    //                     AccountObject.Add('account_type', Format(AccountTypes."Account Location"));
    //                     AccountObject.Add('account_balance', AvailableBalance);
    //                     AccountObject.Add('account_status', UpperCase(Format(Vendor.Status)));
    //                     AccountObject.Add('can_withdraw', UpperCase(Format(AccountTypes.Withrawable)));
    //                     AccountObject.Add('max_withdrawable_amount', AccountTypes."Maximum Withdrawal Amount");
    //                     AccountObject.Add('can_deposit', 'YES');
    //                     AccountObject.Add('max_deposit_amount', AccountTypes."Maximum Allowable Deposit");
    //                     AccountsArray.Add(AccountObject);
    //                     Clear(AccountObject);
    //                     // Iterator := Iterator + 1;

    //                     Found := true;

    //                 until Vendor.Next() = 0;
    //                 DataJson.Add('accounts', AccountsArray);
    //             end;
    //             SaccoGen.Get();

    //             LineNo := LineNo + 10000;
    //             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //             GenJournalLine."Account Type"::Vendor, Memb."FOSA Account No.", Today, SaccoGen."Balance Enquiry Charge" + SaccoGen."Vendor Enquiry Charge", 'FOSA', DOCUMENT_NO,
    //              'balance Enquiry charge' + ' ' + Vend."No.", '');

    //             LineNo := LineNo + 10000;
    //             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //             GenJournalLine."Account Type"::"G/L Account", '300-000-410', Today, SaccoGen."Balance Enquiry Charge" * -1, 'FOSA', DOCUMENT_NO,
    //              'balance Enquiry charge' + ' ' + Vend."No.", '');


    //             LineNo := LineNo + 10000;
    //             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //             GenJournalLine."Account Type"::Vendor, SaccoGen."Vendor G/L", Today, SaccoGen."Vendor Enquiry Charge" * -1, 'FOSA', DOCUMENT_NO,
    //              'Vendor Charges' + ' ' + Vend."No.", '');

    //             GenJournalLine.Reset;
    //             GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //             GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //             if GenJournalLine.Find('-') then begin
    //                 Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //             end;
    //         end;

    //     END;

    //     IF AccountType = 'LOAN' THEN begin

    //         BATCH_TEMPLATE := 'GENERAL';
    //         BATCH_NAME := 'MOBILE';
    //         GenJournalLine.Reset();
    //         GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
    //         GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
    //         if GenJournalLine.FindSet() then begin
    //             GenJournalLine.DeleteAll();
    //         end;
    //         Customer.Reset();
    //         Customer.SetRange(Customer."No.", UpperCase(Identifier));
    //         if Customer.FindFirst() then begin

    //             LoanResgister.Reset();
    //             LoanResgister.SetRange("Client Code", Customer."No.");
    //             LoanResgister.SetRange(LoanResgister."Loan  No.", AccountNumber);//ACCOUNT//LOAN
    //             if LoanResgister.FindFirst() then begin
    //                 DOCUMENT_NO := LoanResgister."Loan  No.";
    //                 LoanResgister.CalcFields("Outstanding Balance");

    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //                 DataJson.Add('account_name', LoanResgister."Loan Product Type");
    //                 DataJson.Add('account_label', LoanResgister."Loan Product Type Name");
    //                 DataJson.Add('account_number', LoanResgister."Loan  No.");
    //                 DataJson.Add('account_status', Format(LoanResgister."Loans Category"));
    //                 DataJson.Add('account_type', 'LOAN');
    //                 DataJson.Add('account_balance', LoanResgister."Outstanding Balance");
    //                 Found := true;

    //                 // Customer.Get(Vend."BOSA Account No");
    //                 SaccoGen.Get();

    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", Today, SaccoGen."Balance Enquiry Charge" + SaccoGen."Vendor Enquiry Charge", 'FOSA', DOCUMENT_NO,
    //                  'balance Enquiry charge' + ' ' + Vend."No.", '');

    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::"G/L Account", '300-000-410', Today, SaccoGen."Balance Enquiry Charge" * -1, 'FOSA', DOCUMENT_NO,
    //                  'balance Enquiry charge' + ' ' + Vend."No.", '');


    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, SaccoGen."Vendor G/L", Today, SaccoGen."Vendor Enquiry Charge" * -1, 'FOSA', DOCUMENT_NO,
    //                  'Vendor Charges' + ' ' + Vend."No.", '');


    //                 GenJournalLine.Reset;
    //                 GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //                 GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //                 if GenJournalLine.Find('-') then begin
    //                     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //                 end;
    //             end;
    //             if AccountNumber = 'ALL' then begin
    //                 Loans.Reset();
    //                 Loans.SetRange(Loans."Client Code", Customer."No.");
    //                 Loans.SetAutoCalcFields(Loans."Outstanding Balance");
    //                 Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
    //                 if Loans.FindFirst() then begin
    //                     SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                     DOCUMENT_NO := Loans."Loan  No.";
    //                     repeat
    //                         Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
    //                         LoanObject.Add('loan_serial_number', Loans."Loan  No.");
    //                         LoanObject.Add('loan_type_id', Loans."Loan Product Type");
    //                         if Loans."Loan Product Type Name" = '' then begin
    //                             ProdFactory.Reset();
    //                             ProdFactory.SetRange(ProdFactory.Code, Loans."Loan Product Type");
    //                             if ProdFactory.FindFirst() then begin
    //                                 LoanObject.Add('loan_type_name', ProdFactory."Product Description");
    //                             end
    //                         end else begin
    //                             LoanObject.Add('loan_type_name', Loans."Loan Product Type Name");
    //                         end;
    //                         LoanObject.Add('loan_amount', Loans."Approved Amount");
    //                         LoanObject.Add('loan_balance', Loans."Outstanding Balance" + Loans."Outstanding Interest");
    //                         LoanObject.Add('installment_amount', Loans.Repayment);
    //                         LoanObject.Add('loan_defaulted_amount', Loans."Amount in Arrears");
    //                         LoanObject.Add('loan_issued_date', Loans."Loan Disbursement Date");
    //                         LoanObject.Add('loan_end_date', Loans."Expected Date of Completion");
    //                         LoanObject.Add('loan_performance', Format(Loans."Loans Category-SASRA"));
    //                         LoanObject.Add('loan_performance_description', StrSubstNo('Loan is %1', UpperCase(Format(Loans."Loans Category-SASRA"))));

    //                         LoansArray.Add(LoanObject);
    //                         Clear(LoanObject);
    //                         Found := TRUE;
    //                     until Loans.Next() = 0;
    //                 end;
    //                 DataJson.Add('loans', LoansArray);
    //                 SaccoGen.Get();

    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", Today, SaccoGen."Balance Enquiry Charge" + SaccoGen."Vendor Enquiry Charge", 'FOSA', DOCUMENT_NO,
    //                  'balance Enquiry charge' + ' ' + Vend."No.", '');

    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::"G/L Account", '300-000-410', Today, SaccoGen."Balance Enquiry Charge" * -1, 'FOSA', DOCUMENT_NO,
    //                  'balance Enquiry charge' + ' ' + Vend."No.", '');


    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, SaccoGen."Vendor G/L", Today, SaccoGen."Vendor Enquiry Charge" * -1, 'FOSA', DOCUMENT_NO,
    //                  'Vendor Charges' + ' ' + Vend."No.", '');

    //                 GenJournalLine.Reset;
    //                 GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //                 GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //                 if GenJournalLine.Find('-') then begin
    //                     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //                 end;
    //             end;
    //         end;


    //         Customer.Reset();
    //         Customer.SetRange("No.", UpperCase(Identifier));
    //         if Customer.FindFirst() then begin
    //             LoanResgister.Reset();
    //             LoanResgister.SetRange("Client Code", Customer."No.");
    //             LoanResgister.SetRange(LoanResgister."Loan  No.", AccountNumber);//ACCOUNT//LOAN
    //             if LoanResgister.FindFirst() then begin
    //                 LoanResgister.CalcFields("Outstanding Balance");

    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //                 DataJson.Add('account_name', LoanResgister."Loan Product Type");
    //                 DataJson.Add('account_label', LoanResgister."Loan Product Type Name");
    //                 DataJson.Add('account_number', LoanResgister."Loan  No.");
    //                 DataJson.Add('account_status', Format(LoanResgister."Loans Category"));
    //                 DataJson.Add('account_type', 'LOAN');
    //                 DataJson.Add('account_balance', LoanResgister."Outstanding Balance");
    //                 Found := true;
    //                 SaccoGen.Get();
    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", Today, SaccoGen."Balance Enquiry Charge" + SaccoGen."Vendor Enquiry Charge", 'FOSA', DOCUMENT_NO,
    //                  'balance Enquiry charge' + ' ' + Customer."FOSA Account No.", '');

    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::"G/L Account", '300-000-410', Today, SaccoGen."Balance Enquiry Charge" * -1, 'FOSA', DOCUMENT_NO,
    //                  'balance Enquiry charge' + ' ' + Customer."FOSA Account No.", '');


    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, SaccoGen."Vendor G/L", Today, SaccoGen."Vendor Enquiry Charge" * -1, 'FOSA', DOCUMENT_NO,
    //                  'Vendor Charges' + ' ' + Customer."FOSA Account No.", '');

    //                 GenJournalLine.Reset;
    //                 GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //                 GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //                 if GenJournalLine.Find('-') then begin
    //                     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //                 end;
    //             end;

    //         end;

    //         Customer.Reset();
    //         Customer.SetRange("ID No.", UpperCase(Identifier));
    //         if Customer.FindFirst() then begin
    //             LoanResgister.Reset();
    //             LoanResgister.SetRange("Client Code", Customer."No.");
    //             LoanResgister.SetRange(LoanResgister."Loan  No.", AccountNumber);//ACCOUNT//LOAN
    //             if LoanResgister.FindFirst() then begin
    //                 LoanResgister.CalcFields("Outstanding Balance");

    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //                 DataJson.Add('account_name', LoanResgister."Loan Product Type");
    //                 DataJson.Add('account_label', LoanResgister."Loan Product Type Name");
    //                 DataJson.Add('account_number', LoanResgister."Loan  No.");
    //                 DataJson.Add('account_status', Format(LoanResgister."Loans Category"));
    //                 DataJson.Add('account_type', 'LOAN');
    //                 DataJson.Add('account_balance', LoanResgister."Outstanding Balance");
    //                 Found := true;

    //                 SaccoGen.Get();
    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", Today, SaccoGen."Balance Enquiry Charge" + SaccoGen."Vendor Enquiry Charge", 'FOSA', DOCUMENT_NO,
    //                  'balance Enquiry charge' + ' ' + Customer."FOSA Account No.", '');

    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::"G/L Account", '300-000-410', Today, SaccoGen."Balance Enquiry Charge" * -1, 'FOSA', DOCUMENT_NO,
    //                  'balance Enquiry charge' + ' ' + Customer."FOSA Account No.", '');


    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, SaccoGen."Vendor G/L", Today, SaccoGen."Vendor Enquiry Charge" * -1, 'FOSA', DOCUMENT_NO,
    //                  'Vendor Charges' + ' ' + Customer."FOSA Account No.", '');

    //                 GenJournalLine.Reset;
    //                 GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //                 GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //                 if GenJournalLine.Find('-') then begin
    //                     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //                 end;
    //             end;

    //         end;
    //     END;

    //     if Found = false then begin
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
    //     end;
    //     ResponseJson.Add(Data, DataJson);
    // end;

    // // ------------------------------------------------------------------------------------------------
    // local procedure StatementEnquiry(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     AccountType: Text;
    //     AccountNumber: Text;
    //     NumberOfTransactions: Integer;
    //     StartDate: Date;
    //     EndDate: Date;
    //     SavAccount: Record Vendor;
    //     StatementType: Text;
    //     Members: Record Customer;
    //     TransactionsArray: JsonArray;
    //     TransactionObject: JsonObject;
    //     Iterator: Integer;
    //     SavLedger: record "Detailed Vendor Ledg. Entry";
    //     DetLedger: record "Detailed Vendor Ledg. Entry";
    //     OpenBal: Decimal;
    //     Found: Boolean;
    //     Loans: Record "Loans Register";
    //     CredLedger: Record "Detailed Cust. Ledg. Entry";
    //     DocumentNumber: Code[40];
    //     AccountTypeX: Record "Account Types-Saving Products";
    //     varTempBlob: Codeunit "Temp Blob";
    //     OStream: OutStream;
    //     IStream: InStream;
    //     varBase64Conversion: Codeunit "Base64 Convert";
    //     vConvertedContent: Text;
    //     RecRef: RecordRef;
    //     MemberStatement: Report 50004;
    //     StatementOutstream: OutStream;
    //     TempBlob: Codeunit "Temp Blob";
    //     StatementInstream: InStream;
    //     RunBal: Decimal;
    //     SaccoGen: Record "Sacco General Set-Up";
    //     LoansRegister: Record "Loans Register";

    // // AmountL: 
    // begin
    //     Iterator := 0;
    //     Found := false;
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     AccountType := SelectJsonToken(RequestJson, '$.account_type').AsValue.AsText;
    //     AccountNumber := SelectJsonToken(RequestJson, '$.account_number').AsValue.AsText;
    //     NumberOfTransactions := SelectJsonToken(RequestJson, '$.number_of_transactions').AsValue.AsInteger();
    //     StartDate := SelectJsonToken(RequestJson, '$.start_date').AsValue.AsDate;
    //     EndDate := SelectJsonToken(RequestJson, '$.end_date').AsValue.AsDate;
    //     StatementType := SelectJsonToken(RequestJson, '$.statement_type').AsValue.AsText;
    //     DocumentNumber := SelectJsonToken(RequestJson, '$.reference_id').AsValue().AsText;


    //     if (StatementType = 'MINI_STATEMENT') or (StatementType = 'FULL_STATEMENT') or (StatementType = 'PDF_STATEMENT') then begin
    //         if (AccountType = 'ACCOUNT') or (AccountType = 'LOAN') then begin
    //             if AccountType = 'ACCOUNT' then begin

    //                 SavAccount.Reset();
    //                 SavAccount.SetRange("No.", AccountNumber);
    //                 //  SavAccount.SetRange("View on Mobile", true);
    //                 if SavAccount.FindFirst() then begin

    //                     SavAccount.CalcFields("Balance (LCY)");
    //                     AccountTypeX.Get(SavAccount."Account Type");
    //                     DataJson.Add('account_name', AccountTypeX.Description);
    //                     DataJson.Add('account_number', AccountNumber);
    //                     DataJson.Add('available_balance', SavAccount."Balance (LCY)");
    //                     SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //                     if StatementType = 'MINI_STATEMENT' then begin
    //                         BATCH_TEMPLATE := 'GENERAL';
    //                         BATCH_NAME := 'MOBILE';
    //                         DOCUMENT_NO := DocumentNumber;
    //                         GenJournalLine.Reset();
    //                         GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
    //                         GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
    //                         if GenJournalLine.FindSet() then begin
    //                             GenJournalLine.DeleteAll();
    //                         end;
    //                         Iterator := 0;
    //                         DetLedger.Reset();
    //                         DetLedger.SetRange(DetLedger."Vendor No.", AccountNumber);
    //                         DetLedger.SetFilter(DetLedger."Posting Date", '..%1', Today);
    //                         //DetLedger.SetAutoCalcFields(DetLedger.Amount);
    //                         if DetLedger.FindSet() then begin
    //                             DetLedger.CalcSums(DetLedger.Amount);
    //                             OpenBal := DetLedger.Amount;
    //                         end;
    //                         RunBal := OpenBal;

    //                         SavLedger.Reset();
    //                         SavLedger.SetAscending(SavLedger."Entry No.", false);
    //                         SavLedger.SetRange(SavLedger."Vendor No.", AccountNumber);
    //                         if SavLedger.Findfirst() then
    //                             repeat
    //                                 Iterator := Iterator + 1;
    //                                 RunBal := RunBal + SavLedger.Amount;
    //                                 SavLedger.CalcFields(SavLedger.Description);
    //                                 TransactionObject.Add('transaction_reference', Format(SavLedger."Entry No."));
    //                                 TransactionObject.Add('transaction_date', SavLedger."Posting Date");
    //                                 TransactionObject.Add('transaction_amount', SavLedger.Amount);
    //                                 TransactionObject.Add('available_balance', SavAccount."Balance (LCY)");
    //                                 TransactionObject.Add('transaction_description', SavLedger.Description);
    //                                 TransactionObject.Add('running_balance', -RunBal);
    //                                 TransactionObject.Add('other_details', SavLedger."Document No.");

    //                                 if Iterator < NumberOfTransactions then
    //                                     TransactionsArray.Add(TransactionObject);
    //                                 Clear(TransactionObject);



    //                             until SavLedger.Next() = 0;
    //                         SaccoGen.Get();
    //                         Members.Reset();
    //                         Members.SetRange(Members."FOSA Account No.", SavAccount."No.");
    //                         if Members.FindFirst() then begin
    //                             LineNo := LineNo + 10000;
    //                             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                             GenJournalLine."Account Type"::Vendor, Members."FOSA Account No.", Today, SaccoGen."Ministatement Charge" + SaccoGen."Vendor MiniStatement Charge", 'FOSA', DOCUMENT_NO,
    //                              'mini statement charge' + ' ' + SavAccount."No.", '');

    //                             LineNo := LineNo + 10000;
    //                             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                             GenJournalLine."Account Type"::"G/L Account", '300-000-410', Today, SaccoGen."Ministatement Charge" * -1, 'FOSA', DOCUMENT_NO,
    //                              'mini statement charge' + ' ' + SavAccount."No.", '');


    //                             LineNo := LineNo + 10000;
    //                             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                             GenJournalLine."Account Type"::Vendor, SaccoGen."Vendor G/L", Today, SaccoGen."Vendor MiniStatement Charge" * -1, 'FOSA', DOCUMENT_NO,
    //                              'Vendor Charges' + ' ' + SavAccount."No.", '');

    //                             GenJournalLine.Reset;
    //                             GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //                             GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //                             if GenJournalLine.Find('-') then begin
    //                                 Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //                             end;
    //                         end;
    //                         DataJson.Add('transactions', TransactionsArray);
    //                     end;
    //                     if StatementType = 'FULL_STATEMENT' then begin
    //                         if AccountType = 'ACCOUNT' THEN begin
    //                             SavLedger.Reset();
    //                             SavLedger.SetRange(SavLedger."Vendor No.", AccountNumber);
    //                             // SavLedger.SetRange("Posting Date", StartDate, EndDate);
    //                             if SavLedger.FindFirst() then
    //                                 repeat
    //                                     SavLedger.CalcFields(SavLedger.Description);
    //                                     TransactionObject.Add('transaction_reference', Format(SavLedger."Entry No."));
    //                                     TransactionObject.Add('transaction_date', SavLedger."Posting Date");
    //                                     TransactionObject.Add('transaction_time', Time);
    //                                     TransactionObject.Add('transaction_amount', SavLedger.Amount);
    //                                     TransactionObject.Add('available_balance', SavAccount."Balance (LCY)");
    //                                     TransactionObject.Add('transaction_description', SavLedger.Description);
    //                                     TransactionObject.Add('other_details', SavLedger."Document No.");
    //                                     TransactionsArray.Add(TransactionObject);
    //                                     Clear(TransactionObject);
    //                                 until SavLedger.Next() = 0;

    //                             DataJson.Add('transactions', TransactionsArray);
    //                         end;
    //                         if AccountType = 'LOAN' THEN begin
    //                             LoansRegister.Reset();
    //                             LoansRegister.SetRange(LoansRegister."Loan  No.", AccountNumber);
    //                             // SavLedger.SetRange("Posting Date", StartDate, EndDate);
    //                             if LoansRegister.FindFirst() then
    //                                 repeat
    //                                     //SavLedger.CalcFields(SavLedger.Description);
    //                                     TransactionObject.Add('transaction_reference', Format(LoansRegister."Loan  No."));
    //                                     TransactionObject.Add('transaction_date', LoansRegister."Loan Disbursement Date");
    //                                     TransactionObject.Add('transaction_time', Time);
    //                                     TransactionObject.Add('transaction_amount', LoansRegister."Approved Amount");
    //                                     TransactionObject.Add('available_balance', LoansRegister."Outstanding Balance");
    //                                     TransactionObject.Add('transaction_description', LoansRegister."Loan Product Type Name");
    //                                     TransactionObject.Add('other_details', LoansRegister."Loan Product Type");
    //                                     TransactionsArray.Add(TransactionObject);
    //                                     Clear(TransactionObject);
    //                                 until LoansRegister.Next() = 0;

    //                             DataJson.Add('transactions', TransactionsArray);
    //                         end;
    //                     END;
    //                     If StatementType = 'PDF_STATEMENT' then begin
    //                         if AccountType = 'ACCOUNT' then begin
    //                             SavAccount.Reset();
    //                             SavAccount.SetRange("No.", AccountNumber);
    //                             if SavAccount.Find('-') then begin

    //                                 varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);

    //                                 RecRef.GetTable(SavAccount);
    //                                 Report.SaveAs(Report::"FOSAStatementNewR", '', REPORTFORMAT::Pdf, OStream, RecRef);
    //                                 varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
    //                                 vConvertedContent := varBase64Conversion.ToBase64(IStream);
    //                                 DataJson.Add('pdf', vConvertedContent);
    //                                 // MemberStatement.SetTableView(SavAccount);
    //                                 // TempBlob.CreateOutStream(StatementOutstream);
    //                                 // if MemberStatement.SaveAs('', ReportFormat::Pdf, StatementOutstream) then //begin
    //                                 //     TempBlob.CreateInStream(StatementInstream);
    //                                 // vConvertedContent := varBase64Conversion.ToBase64(StatementInstream, true);
    //                                 // DataJson.Add('pdf', vConvertedContent);
    //                             end;
    //                             //loan

    //                             //end loan
    //                         end;
    //                         if AccountType = 'LOAN' then begin
    //                             LoansRegister.Reset();
    //                             LoansRegister.SetRange(LoansRegister."Loan  No.", AccountNumber);
    //                             if LoansRegister.Find('-') then begin

    //                                 varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);

    //                                 RecRef.GetTable(LoansRegister);
    //                                 Report.SaveAs(Report::"Loan Statement BOSA", '', REPORTFORMAT::Pdf, OStream, RecRef);
    //                                 varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
    //                                 vConvertedContent := varBase64Conversion.ToBase64(IStream);
    //                                 DataJson.Add('pdf', vConvertedContent);
    //                                 // MemberStatement.SetTableView(SavAccount);
    //                                 // TempBlob.CreateOutStream(StatementOutstream);
    //                                 // if MemberStatement.SaveAs('', ReportFormat::Pdf, StatementOutstream) then //begin
    //                                 //     TempBlob.CreateInStream(StatementInstream);
    //                                 // vConvertedContent := varBase64Conversion.ToBase64(StatementInstream, true);
    //                                 // DataJson.Add('pdf', vConvertedContent);
    //                             end;
    //                             //loan
    //                         END;
    //                         //end loan
    //                     end;
    //                 end else
    //                     SetResponseStatus(ResponseJson, 'error', 'Error', 'Account does not exist');
    //             end;
    //             if AccountType = 'LOAN' then begin

    //                 LoansRegister.Reset();
    //                 LoansRegister.SetRange(LoansRegister."Loan  No.", AccountNumber);
    //                 if LoansRegister.FindFirst() then begin
    //                     LoansRegister.CalcFields(LoansRegister."Outstanding Balance");
    //                     DataJson.Add('account_name', LoansRegister."Loan Product Type Name");
    //                     DataJson.Add('account_number', AccountNumber);
    //                     DataJson.Add('available_balance', LoansRegister."Outstanding Balance");
    //                     SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                     RunBal := LoansRegister."Outstanding Balance";
    //                     if StatementType = 'MINI_STATEMENT' then begin
    //                         Iterator := 0;
    //                         CredLedger.Reset();
    //                         CredLedger.SetCurrentKey("Posting Date");
    //                         CredLedger.SetAscending("Posting Date", false);
    //                         CredLedger.SetRange("Loan No", AccountNumber);
    //                         if CredLedger.FindSet() then
    //                             repeat
    //                                 Iterator := Iterator + 1;
    //                                 RunBal := RunBal + CredLedger.Amount;
    //                                 TransactionObject.Add('transaction_reference', CredLedger."Document No.");
    //                                 TransactionObject.Add('transaction_date', CredLedger."Posting Date");
    //                                 TransactionObject.Add('transaction_amount', CredLedger.Amount);
    //                                 TransactionObject.Add('running_balance', -RunBal);
    //                                 TransactionObject.Add('transaction_description', CredLedger.Description);

    //                                 TransactionObject.Add('other_details', CredLedger.Description);
    //                                 if Iterator < NumberOfTransactions then
    //                                     TransactionsArray.Add(TransactionObject);

    //                                 Clear(TransactionObject);



    //                             until CredLedger.Next() = 0;
    //                         BATCH_TEMPLATE := 'GENERAL';
    //                         BATCH_NAME := 'MOBILE';
    //                         DOCUMENT_NO := DocumentNumber;
    //                         GenJournalLine.Reset();
    //                         GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
    //                         GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
    //                         if GenJournalLine.FindSet() then begin
    //                             GenJournalLine.DeleteAll();
    //                         end;

    //                         SaccoGen.Get();
    //                         Members.Reset();
    //                         Members.SetRange(Members."No.", LoansRegister."Client Code");
    //                         if Members.FindFirst() then begin
    //                             LineNo := LineNo + 10000;
    //                             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                             GenJournalLine."Account Type"::Vendor, Members."FOSA Account No.", Today, SaccoGen."Ministatement Charge" + SaccoGen."Vendor MiniStatement Charge", 'FOSA', DOCUMENT_NO,
    //                              'mini statement charge' + ' ' + SavAccount."No.", '');

    //                             LineNo := LineNo + 10000;
    //                             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                             GenJournalLine."Account Type"::"G/L Account", '300-000-410', Today, SaccoGen."Ministatement Charge" * -1, 'FOSA', DOCUMENT_NO,
    //                              'mini statement charge' + ' ' + SavAccount."No.", '');


    //                             LineNo := LineNo + 10000;
    //                             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                             GenJournalLine."Account Type"::Vendor, SaccoGen."Vendor G/L", Today, SaccoGen."Vendor MiniStatement Charge" * -1, 'FOSA', DOCUMENT_NO,
    //                              'Vendor Charges' + ' ' + SavAccount."No.", '');

    //                             GenJournalLine.Reset;
    //                             GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //                             GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //                             if GenJournalLine.Find('-') then begin
    //                                 Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //                             end;
    //                         end;
    //                         DataJson.Add('transactions', TransactionsArray);
    //                     end;

    //                     if StatementType = 'FULL_STATEMENT' then begin

    //                         CredLedger.Reset();
    //                         CredLedger.SetRange("Loan No", AccountNumber);
    //                         CredLedger.SetRange("Posting Date", StartDate, EndDate);
    //                         if CredLedger.FindFirst() then
    //                             repeat

    //                                 TransactionObject.Add('transaction_reference', CredLedger."Document No.");
    //                                 TransactionObject.Add('transaction_date', CredLedger."Posting Date");
    //                                 TransactionObject.Add('transaction_time', '');
    //                                 TransactionObject.Add('transaction_amount', CredLedger.Amount);
    //                                 TransactionObject.Add('available_balance', LoansRegister."Outstanding Balance");
    //                                 TransactionObject.Add('transaction_description', CredLedger.Description);
    //                                 TransactionObject.Add('other_details', CredLedger.Description);

    //                                 TransactionsArray.Add(TransactionObject);
    //                                 Clear(TransactionObject);
    //                             until CredLedger.Next() = 0;

    //                         DataJson.Add('transactions', TransactionsArray);
    //                     end;

    //                 end else
    //                     SetResponseStatus(ResponseJson, 'error', 'Error', 'Loan does not exist');
    //             end;

    //             ResponseJson.Add(Data, DataJson);
    //             //RandText := Mob.GetBalanceEnquiry(Identifier, DocumentNumber);
    //         end else
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'Account Type Invalid');
    //     end else
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'Invalid statement type');


    // end;


    // local procedure GetAccountStatementPortalPend(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     AccountType: Text;
    //     AccountNumber: Text;
    //     NumberOfTransactions: Integer;
    //     StartDate: Date;
    //     EndDate: Date;
    //     SavAccount: Record Vendor;
    //     StatementType: Text;
    //     Members: Record Customer;
    //     TransactionsArray: JsonArray;
    //     TransactionObject: JsonObject;
    //     Iterator: Integer;
    //     SavLedger: record "Detailed Vendor Ledg. Entry";
    //     SavLedgerK: record "Detailed Vendor Ledg. Entry";
    //     SavLedgers: record "Detailed Vendor Ledg. Entry";
    //     DetLedger: record "Detailed Vendor Ledg. Entry";
    //     OpenBal: Decimal;
    //     Found: Boolean;
    //     Loans: Record "Loans Register";
    //     CredLedger: Record "Detailed Cust. Ledg. Entry";
    //     DocumentNumber: Code[40];
    //     AccountTypeX: Record "Account Types-Saving Products";
    //     varTempBlob: Codeunit "Temp Blob";
    //     OStream: OutStream;
    //     IStream: InStream;
    //     varBase64Conversion: Codeunit "Base64 Convert";
    //     vConvertedContent: Text;
    //     RecRef: RecordRef;
    //     MemberStatement: Report 50004;
    //     StatementOutstream: OutStream;
    //     TempBlob: Codeunit "Temp Blob";
    //     StatementInstream: InStream;
    //     RunBal: Decimal;
    //     SaccoGen: Record "Sacco General Set-Up";
    //     LoansRegister: Record "Loans Register";
    //     EntryType: Text[50];
    //     page_size: integer;
    //     page_number: Integer;
    //     TotalFoundRecords: Integer;
    //     FirstRow: Integer;
    //     LastRow: Integer;
    //     Count: Integer;
    //     PageJson: JsonObject;
    //     RunningBalances: decimal;
    //     TotalDebits: Decimal;
    //     TotalCredits: Decimal;
    //     NetCharges: Decimal;
    //     MBuffer: Record "Mpesa Withdawal Buffer";
    //     AvailableBalance: decimal;//
    //     FOSAAccounts: Record vendor;
    //     PendingAmount: decimal;
    // begin
    //     Iterator := 0;
    //     Found := false;
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     AccountNumber := SelectJsonToken(RequestJson, '$.account_number').AsValue.AsText;
    //     StartDate := SelectJsonToken(RequestJson, '$.start_date').AsValue.AsDate;
    //     EndDate := SelectJsonToken(RequestJson, '$.end_date').AsValue.AsDate;
    //     page_number := SelectJsonToken(RequestJson, '$.page').AsValue.AsInteger();
    //     page_size := SelectJsonToken(RequestJson, '$.page_count').AsValue.AsInteger();


    //     if IdentifierType = 'MSISDN' then begin

    //         SavAccount.Reset();
    //         SavAccount.SetRange("No.", AccountNumber);
    //         if SavAccount.FindFirst() then begin
    //             SetResponseStatus(ResponseJson, 'success', 'Success', 'Member’s Account Statement has been fetched successfully');
    //             SavAccount.CalcFields("Balance (LCY)");
    //             AccountTypeX.Get(SavAccount."Account Type");
    //             SavLedgers.Reset();
    //             SavLedgers.SetRange(SavLedgers."Vendor No.", AccountNumber);
    //             SavLedgers.SetFilter(SavLedgers."Posting Date", '%1..%2', StartDate, EndDate);
    //             if SavLedgers.Findset() then begin
    //                 SavLedgers.CalcSums("Debit Amount", "Credit Amount");
    //                 TotalDebits := SavLedgers."Debit Amount";
    //                 TotalCredits := SavLedgers."Credit Amount";


    //             end;
    //             RunBal := 0;

    //             OpenBal := 0;
    //             DetLedger.Reset();
    //             DetLedger.SetRange(DetLedger."Vendor No.", AccountNumber);
    //             DetLedger.SetFilter(DetLedger."Posting Date", '..%1', EndDate);
    //             DetLedger.SetRange(DetLedger.Reversed, false);
    //             if DetLedger.FindSet() then begin
    //                 DetLedger.CalcSums(DetLedger.Amount);
    //                 OpenBal := DetLedger.Amount;
    //             end;

    //             if SavAccount."Account Type" = '103' then begin
    //                 MBuffer.Reset();
    //                 MBuffer.SetRange(MBuffer."Vendor No", SavAccount."No.");
    //                 MBuffer.SetRange(MBuffer.Posted, false);
    //                 MBuffer.SetRange(MBuffer.Reversed, false);
    //                 if MBuffer.FindSet() then begin
    //                     MBuffer.CalcSums(MBuffer."Amount Requested");
    //                     PendingAmount := MBuffer."Amount Requested";
    //                 end;
    //                 AvailableBalance := 0;
    //                 AvailableBalance := ((SavAccount."Uncleared Cheques" - SavAccount."Cheque Discounted Amount") + PendingAmount + SavAccount."ATM Transactions" + SavAccount."EFT Transactions" + 1000 + SavAccount."Mobile Transactions" + SavAccount."Amount to freeze");

    //                 RunBal := OpenBal + AvailableBalance;
    //             end;


    //             if SavAccount."Account Type" <> '103' then begin
    //                 RunBal := OpenBal;

    //             end;



    //             //RunBal := AvailableBalance;

    //             //Error('Available%1OpenBal%2RunBal%3', AvailableBalance, OpenBal, RunBal);

    //             SavLedger.Reset();
    //             SavLedger.SetCurrentKey(SavLedger."Entry No.");
    //             SavLedger.SetAscending(SavLedger."Entry No.",false);
    //             SavLedger.SetRange(SavLedger."Vendor No.", AccountNumber);
    //             SavLedger.SetRange(SavLedger.Reversed, false);
    //             SavLedger.SetFilter(SavLedger."Posting Date", '%1..%2', StartDate, EndDate);
    //             if SavLedger.Findset() then begin
    //                 Count := 0;
    //                 FirstRow := ((page_number - 1) * page_size) + 1;
    //                 LastRow := page_number * page_size;
    //                 TotalFoundRecords := SavLedger.Count;
    //                 repeat begin

    //                     Count := Count + 1;
    //                     if (Count >= FirstRow) and (Count <= LastRow) then begin
    //                         EntryType := '';
    //                         if SavLedger."Debit Amount" <> 0 then
    //                             EntryType := 'Debit'
    //                         else
    //                             EntryType := 'Credit';

    //                         SavLedger.CalcFields(SavLedger.Description);
    //                         TransactionObject.Add('entry_number', SavLedger."Entry No.");
    //                         TransactionObject.Add('transaction_reference', SavLedger."Document No.");
    //                         TransactionObject.Add('posting_date', SavLedger."Posting Date");
    //                         TransactionObject.Add('description', SavLedger.Description);
    //                         TransactionObject.Add('amount', SavLedger.Amount);
    //                         TransactionObject.Add('running_balance', RunBal);
    //                         TransactionObject.Add('entry_type', EntryType);
    //                         TransactionsArray.Add(TransactionObject);
    //                         Clear(TransactionObject);
    //                     end;
    //                     RunBal := RunBal + (SavLedger.Amount);
    //                 end until SavLedger.Next() = 0;
    //                 PageJson.Add('records', TransactionsArray);
    //                 PageJson.Add('page', page_number);
    //                 PageJson.Add('page_count', page_size);
    //                 PageJson.Add('total_records', TotalFoundRecords);
    //                 PageJson.Add('credits', TotalCredits);
    //                 PageJson.Add('debits', TotalDebits);
    //             end;
    //         end else
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'Account does not exist');
    //     end;

    //     ResponseJson.Add(Data, PageJson);
    //     //RandText := Mob.GetBalanceEnquiry(Identifier, DocumentNumber);

    // end;

    // local procedure GetAccountStatementPortal(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     AccountType: Text;
    //     AccountNumber: Text;
    //     NumberOfTransactions: Integer;
    //     StartDate: Date;
    //     EndDate: Date;
    //     SavAccount: Record Vendor;
    //     StatementType: Text;
    //     Members: Record Customer;
    //     TransactionsArray: JsonArray;
    //     TransactionObject: JsonObject;
    //     Iterator: Integer;
    //     SavLedger: record "Detailed Vendor Ledg. Entry";
    //     SavLedgers: record "Detailed Vendor Ledg. Entry";
    //     DetLedger: record "Detailed Vendor Ledg. Entry";
    //     OpenBal: Decimal;
    //     Found: Boolean;
    //     Loans: Record "Loans Register";
    //     CredLedger: Record "Detailed Cust. Ledg. Entry";
    //     DocumentNumber: Code[40];
    //     AccountTypeX: Record "Account Types-Saving Products";
    //     varTempBlob: Codeunit "Temp Blob";
    //     OStream: OutStream;
    //     IStream: InStream;
    //     varBase64Conversion: Codeunit "Base64 Convert";
    //     vConvertedContent: Text;
    //     RecRef: RecordRef;
    //     MemberStatement: Report 50004;
    //     StatementOutstream: OutStream;
    //     TempBlob: Codeunit "Temp Blob";
    //     StatementInstream: InStream;
    //     RunBal: Decimal;
    //     SaccoGen: Record "Sacco General Set-Up";
    //     LoansRegister: Record "Loans Register";
    //     EntryType: Text[50];
    //     page_size: integer;
    //     page_number: Integer;
    //     TotalFoundRecords: Integer;
    //     FirstRow: Integer;
    //     LastRow: Integer;
    //     Count: Integer;
    //     PageJson: JsonObject;

    //     TotalDebits: Decimal;
    //     TotalCredits: Decimal;
    //     NetCharges: Decimal;
    //     MBuffer: Record "Mpesa Withdawal Buffer";
    //     AvailableBalance: decimal;//
    //     FOSAAccounts: Record vendor;
    //     PendingAmount: decimal;
    //     OpenBals: Decimal;
    // begin
    //     Iterator := 0;
    //     Found := false;
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     AccountNumber := SelectJsonToken(RequestJson, '$.account_number').AsValue.AsText;
    //     StartDate := SelectJsonToken(RequestJson, '$.start_date').AsValue.AsDate;
    //     EndDate := SelectJsonToken(RequestJson, '$.end_date').AsValue.AsDate;
    //     page_number := SelectJsonToken(RequestJson, '$.page').AsValue.AsInteger();
    //     page_size := SelectJsonToken(RequestJson, '$.page_count').AsValue.AsInteger();


    //     if IdentifierType = 'MSISDN' then begin

    //         SavAccount.Reset();
    //         SavAccount.SetRange("No.", AccountNumber);
    //         if SavAccount.FindFirst() then begin
    //             SetResponseStatus(ResponseJson, 'success', 'Success', 'Member’s Account Statement has been fetched successfully');
    //             SavAccount.CalcFields("Balance (LCY)");
    //             AccountTypeX.Get(SavAccount."Account Type");
    //             SavLedgers.Reset();
    //             SavLedgers.SetRange(SavLedgers."Vendor No.", AccountNumber);
    //             SavLedgers.SetFilter(SavLedgers."Posting Date", '%1..%2', StartDate, EndDate);
    //             if SavLedgers.Findset() then begin
    //                 SavLedgers.CalcSums("Debit Amount", "Credit Amount");
    //                 TotalDebits := SavLedgers."Debit Amount";
    //                 TotalCredits := SavLedgers."Credit Amount";


    //             end;

    //             RunBal := 0;

    //             OpenBal := 0;
    //             OpenBals := 0;


    //             if SavAccount."Account Type" = '103' then begin

    //                 MBuffer.Reset();
    //                 MBuffer.SetRange(MBuffer."Vendor No", SavAccount."No.");
    //                 MBuffer.SetRange(MBuffer.Posted, false);
    //                 MBuffer.SetRange(MBuffer.Reversed, false);
    //                 if MBuffer.FindSet() then begin
    //                     MBuffer.CalcSums(MBuffer."Amount Requested");
    //                     PendingAmount := MBuffer."Amount Requested";
    //                 end;
    //                 AvailableBalance := 0;
    //                 AvailableBalance := ((SavAccount."Uncleared Cheques" - SavAccount."Cheque Discounted Amount") + PendingAmount + SavAccount."ATM Transactions" + SavAccount."EFT Transactions" + 1000 + SavAccount."Mobile Transactions" + SavAccount."Amount to freeze");
    //                 //Error('Availa%1',AvailableBalance);
    //                 DetLedger.Reset();
    //                 DetLedger.SetRange(DetLedger."Vendor No.", AccountNumber);
    //                 DetLedger.SetFilter(DetLedger."Posting Date", '..%1', CalcDate('-1D', StartDate));
    //                 DetLedger.SetRange(DetLedger.Reversed, false);
    //                 if DetLedger.FindSet() then begin
    //                     DetLedger.CalcSums(DetLedger.Amount);

    //                     OpenBal := DetLedger.Amount + AvailableBalance;
    //                     OpenBals := -OpenBal;
    //                 end;

    //                 RunBal := OpenBal;
    //             end;


    //             if SavAccount."Account Type" <> '103' then begin
    //                 DetLedger.Reset();
    //                 DetLedger.SetRange(DetLedger."Vendor No.", AccountNumber);
    //                 DetLedger.SetFilter(DetLedger."Posting Date", '..%1', CalcDate('-1D', StartDate));
    //                 DetLedger.SetRange(DetLedger.Reversed, false);
    //                 if DetLedger.FindSet() then begin
    //                     DetLedger.CalcSums(DetLedger.Amount);
    //                     OpenBal := DetLedger.Amount;
    //                     OpenBals := -OpenBal;
    //                 end;
    //                 RunBal := OpenBal;
    //             end;

    //             //RunBal := AvailableBalance;

    //             //Error('Available%1OpenBal%2RunBal%3', AvailableBalance, OpenBal, RunBal);

    //             SavLedger.Reset();
    //             SavLedger.SetRange(SavLedger."Vendor No.", AccountNumber);
    //             SavLedger.SetRange(SavLedger.Reversed, false);
    //             SavLedger.SetFilter(SavLedger."Posting Date", '%1..%2', StartDate, EndDate);
    //             if SavLedger.Findset() then begin
    //                 Count := 0;
    //                 FirstRow := ((page_number - 1) * page_size) + 1;
    //                 LastRow := page_number * page_size;
    //                 TotalFoundRecords := SavLedger.Count;
    //                 repeat begin

    //                     Count := Count + 1;
    //                     if (Count >= FirstRow) and (Count <= LastRow) then begin
    //                         EntryType := '';
    //                         if SavLedger."Debit Amount" <> 0 then
    //                             EntryType := 'Debit'
    //                         else
    //                             EntryType := 'Credit';
    //                         RunBal := RunBal + SavLedger.Amount;
    //                         SavLedger.CalcFields(SavLedger.Description);
    //                         TransactionObject.Add('entry_number', SavLedger."Entry No.");
    //                         TransactionObject.Add('transaction_reference', SavLedger."Document No.");
    //                         TransactionObject.Add('posting_date', SavLedger."Posting Date");
    //                         TransactionObject.Add('description', SavLedger.Description);
    //                         TransactionObject.Add('amount', SavLedger.Amount);
    //                         TransactionObject.Add('running_balance', -RunBal);
    //                         TransactionObject.Add('entry_type', EntryType);
    //                         TransactionsArray.Add(TransactionObject);
    //                         Clear(TransactionObject);
    //                     end;
    //                 end until SavLedger.Next() = 0;
    //                 PageJson.Add('records', TransactionsArray);
    //                 PageJson.Add('page', page_number);
    //                 PageJson.Add('page_count', page_size);
    //                 PageJson.Add('total_records', TotalFoundRecords);
    //                 PageJson.Add('credits', TotalCredits);
    //                 PageJson.Add('debits', TotalDebits);
    //                 PageJson.Add('open_balance', OpenBals);
    //             end;
    //         end else
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'Account does not exist');
    //     end;

    //     ResponseJson.Add(Data, PageJson);
    //     //RandText := Mob.GetBalanceEnquiry(Identifier, DocumentNumber);




    // end;

    // local procedure GetRecentAccountTransactionsPortal(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     AccountType: Text;
    //     AccountNumber: Text;
    //     NumberOfTransactions: Integer;
    //     StartDate: Date;
    //     EndDate: Date;
    //     SavAccount: Record Vendor;
    //     StatementType: Text;
    //     Members: Record Customer;
    //     TransactionsArray: JsonArray;
    //     TransactionObject: JsonObject;
    //     Iterator: Integer;
    //     SavLedger: record "Detailed Vendor Ledg. Entry";
    //     SavLedgers: record "Detailed Vendor Ledg. Entry";
    //     DetLedger: record "Detailed Vendor Ledg. Entry";
    //     OpenBal: Decimal;
    //     Found: Boolean;
    //     Loans: Record "Loans Register";
    //     CredLedger: Record "Detailed Cust. Ledg. Entry";
    //     DocumentNumber: Code[40];
    //     AccountTypeX: Record "Account Types-Saving Products";
    //     varTempBlob: Codeunit "Temp Blob";
    //     OStream: OutStream;
    //     IStream: InStream;
    //     varBase64Conversion: Codeunit "Base64 Convert";
    //     vConvertedContent: Text;
    //     RecRef: RecordRef;
    //     MemberStatement: Report 50004;
    //     StatementOutstream: OutStream;
    //     TempBlob: Codeunit "Temp Blob";
    //     StatementInstream: InStream;
    //     RunBal: Decimal;
    //     SaccoGen: Record "Sacco General Set-Up";
    //     LoansRegister: Record "Loans Register";
    //     EntryType: Text[50];
    //     page_size: integer;
    //     page_number: Integer;
    //     TotalFoundRecords: Integer;
    //     FirstRow: Integer;
    //     LastRow: Integer;
    //     Count: Integer;
    //     PageJson: JsonObject;

    //     TotalDebits: Decimal;
    //     TotalCredits: Decimal;
    //     NetCharges: Decimal;
    //     MBuffer: Record "Mpesa Withdawal Buffer";
    //     AvailableBalance: decimal;//
    //     FOSAAccounts: Record vendor;
    //     PendingAmount: decimal;
    //     OpenBals: Decimal;
    //     Counts: Integer;
    //     LastDate: date;
    //     EntryDate: Integer;
    // begin
    //     Iterator := 0;
    //     Found := false;
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     AccountNumber := SelectJsonToken(RequestJson, '$.account_number').AsValue.AsText;
    //     page_size := SelectJsonToken(RequestJson, '$.page_count').AsValue.AsInteger();


    //     if IdentifierType = 'MSISDN' then begin

    //         SavAccount.Reset();
    //         SavAccount.SetRange("No.", AccountNumber);
    //         if SavAccount.FindFirst() then begin
    //             SetResponseStatus(ResponseJson, 'success', 'Success', 'Member’s Account Statement has been fetched successfully');
    //             SavAccount.CalcFields("Balance (LCY)");
    //             AccountTypeX.Get(SavAccount."Account Type");


    //             SavLedgers.Reset();
    //             SavLedgers.SetCurrentKey(SavLedgers."Entry No.");
    //             SavLedgers.SetAscending(SavLedgers."Entry No.", false);
    //             SavLedgers.SetRange(SavLedgers."Vendor No.", AccountNumber);
    //             SavLedgers.SetRange(SavLedgers.Reversed, false);
    //             if SavLedgers.Findset() then begin
    //                 Counts := 0;
    //                 repeat
    //                     Counts := Counts + 1;
    //                     if Counts = page_size then begin
    //                         LastDate := SavLedgers."Posting Date";
    //                         EntryDate := SavLedgers."Entry No.";

    //                         //    Error('Lastdate%1Amount%2Count%3EntryNo%4', LastDate, SavLedgers.Amount, Counts, SavLedgers."Entry No.");

    //                     end;

    //                 until SavLedgers.Next() = 0;

    //             end;
    //             LastDate := CalcDate('-1D', LastDate);

    //             RunBal := 0;

    //             OpenBal := 0;
    //             OpenBals := 0;


    //             if SavAccount."Account Type" = '103' then begin

    //                 MBuffer.Reset();
    //                 MBuffer.SetRange(MBuffer."Vendor No", SavAccount."No.");
    //                 MBuffer.SetRange(MBuffer.Posted, false);
    //                 MBuffer.SetRange(MBuffer.Reversed, false);
    //                 if MBuffer.FindSet() then begin
    //                     MBuffer.CalcSums(MBuffer."Amount Requested");
    //                     PendingAmount := MBuffer."Amount Requested";
    //                 end;
    //                 AvailableBalance := 0;
    //                 AvailableBalance := ((SavAccount."Uncleared Cheques" - SavAccount."Cheque Discounted Amount") + PendingAmount + SavAccount."ATM Transactions" + SavAccount."EFT Transactions" + 1000 + SavAccount."Mobile Transactions" + SavAccount."Amount to freeze");
    //                 //Error('Availa%1',AvailableBalance);
    //                 DetLedger.Reset();
    //                 DetLedger.SetRange(DetLedger."Vendor No.", AccountNumber);
    //                 //DetLedger.SetFilter(DetLedger."Posting Date", '..%1', LastDate);
    //                 DetLedger.SetFilter(DetLedger."Entry No.",'<%1',EntryDate);
    //                 DetLedger.SetRange(DetLedger.Reversed, false);
    //                 if DetLedger.FindSet() then begin
    //                     DetLedger.CalcSums(DetLedger.Amount);

    //                     OpenBal := DetLedger.Amount + AvailableBalance;
    //                     OpenBals := -OpenBal;
    //                 end;

    //                 RunBal := OpenBal;
    //             end;


    //             if SavAccount."Account Type" <> '103' then begin
    //                 DetLedger.Reset();
    //                 DetLedger.SetRange(DetLedger."Vendor No.", AccountNumber);
    //                 //DetLedger.SetFilter(DetLedger."Posting Date", '..%1', LastDate);
    //                 DetLedger.SetFilter(DetLedger."Entry No.",'<%1',EntryDate);
    //                 DetLedger.SetRange(DetLedger.Reversed, false);
    //                 if DetLedger.FindSet() then begin
    //                     DetLedger.CalcSums(DetLedger.Amount);
    //                     OpenBal := DetLedger.Amount;
    //                     OpenBals := -OpenBal;
    //                 end;
    //                 RunBal := OpenBal;
    //             end;

    //             //Error('Run%1LastEntry%2EntryDate%3Available%4', RunBal,EntryDate,LastDate,AvailableBalance);

    //             SavLedger.Reset();
    //             //SavLedger.SetCurrentKey(SavLedger."Entry No.");
    //             //SavLedger.SetAscending(SavLedger."Entry No.", false);
    //             SavLedger.SetRange(SavLedger."Vendor No.", AccountNumber);
    //             SavLedger.SetRange(SavLedger.Reversed, false);
    //             SavLedger.SetFilter(SavLedger."Posting Date", '>%1', LastDate);
    //             SavLedger.setfilter(SavLedger."Entry No.", '>=%1', EntryDate);
    //             if SavLedger.Findset() then begin
    //                 Count := 0;
    //                 repeat
    //                     //  if Count < page_size then begin
    //                     //    Count := Count + 1;

    //                     EntryType := '';
    //                     if SavLedger."Debit Amount" <> 0 then
    //                         EntryType := 'Debit'
    //                     else
    //                         EntryType := 'Credit';

    //                     RunBal := RunBal + SavLedger.Amount;
    //                     SavLedger.CalcFields(SavLedger.Description);
    //                     TransactionObject.Add('entry_number', SavLedger."Entry No.");
    //                     TransactionObject.Add('transaction_reference', SavLedger."Document No.");
    //                     TransactionObject.Add('posting_date', SavLedger."Posting Date");
    //                     TransactionObject.Add('description', SavLedger.Description);
    //                     TransactionObject.Add('amount', SavLedger.Amount);
    //                     TransactionObject.Add('running_balance', -RunBal);
    //                     TransactionObject.Add('entry_type', EntryType);
    //                     TransactionsArray.Add(TransactionObject);
    //                     Clear(TransactionObject);


    //                 // end;
    //                 until (SavLedger.next = 0);
    //                 PageJson.Add('records', TransactionsArray);
    //                 PageJson.Add('page_count', page_size);

    //             end;
    //         end else
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'Account does not exist');
    //     end;

    //     ResponseJson.Add(Data, PageJson);





    // end;

    local procedure GetLoanStatementPortal(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        AccountType: Text;
        AccountNumber: Text;
        NumberOfTransactions: Integer;
        StartDate: Date;
        EndDate: Date;
        SavAccount: Record Vendor;
        StatementType: Text;
        Members: Record Customer;
        TransactionsArray: JsonArray;
        TransactionObject: JsonObject;
        Iterator: Integer;
        DetLedger: record "Detailed Cust. Ledg. Entry";
        OpenBal: Decimal;
        Found: Boolean;
        Loans: Record "Loans Register";
        CredLedger: Record "Cust. Ledger Entry";
        CredLedgers: Record "Cust. Ledger Entry";
        DocumentNumber: Code[40];
        AccountTypeX: Record "Account Types-Saving Products";
        varTempBlob: Codeunit "Temp Blob";
        OStream: OutStream;
        IStream: InStream;
        varBase64Conversion: Codeunit "Base64 Convert";
        vConvertedContent: Text;
        RecRef: RecordRef;
        // MemberStatement: Report 50004;
        StatementOutstream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        StatementInstream: InStream;
        RunBal: Decimal;
        SaccoGen: Record "Sacco General Set-Up";
        LoansRegister: Record "Loans Register";
        EntryType: Text[50];
        loanNumber: Text;
        page_size: integer;
        page_number: Integer;
        TotalFoundRecords: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        Count: Integer;
        PageJson: JsonObject;
        TotalDebits: Decimal;
        TotalCredits: Decimal;
    begin
        Iterator := 0;
        Found := false;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        loanNumber := SelectJsonToken(RequestJson, '$.loan_number').AsValue.AsText;
        StartDate := SelectJsonToken(RequestJson, '$.start_date').AsValue.AsDate;
        EndDate := SelectJsonToken(RequestJson, '$.end_date').AsValue.AsDate;
        page_number := SelectJsonToken(RequestJson, '$.page').AsValue.AsInteger();
        page_size := SelectJsonToken(RequestJson, '$.page_count').AsValue.AsInteger();



        if IdentifierType = 'NATIONAL_ID_NUMBER' then begin
            Members.Reset();
            Members.SetRange(Members."ID No.", Identifier);
            if Members.FindFirst() then
                LoansRegister.Reset();
            LoansRegister.SetRange(LoansRegister."Loan  No.", loanNumber);
            if LoansRegister.FindFirst() then begin
                LoansRegister.CalcFields(LoansRegister."Outstanding Balance");
                SetResponseStatus(ResponseJson, 'success', 'Success', 'Member’s Loan Statement has been fetched successfully');
                RunBal := LoansRegister."Outstanding Balance";
                CredLedgers.Reset();
                CredLedgers.SetCurrentKey("Posting Date");
                CredLedgers.SetAscending("Posting Date", false);
                CredLedgers.SetRange(CredLedgers."Loan No", LoansRegister."Loan  No.");
                CredLedgers.SetFilter(CredLedgers."Transaction Type", '%1|%2', CredLedgers."Transaction Type"::Loan, CredLedgers."Transaction Type"::Repayment, CredLedgers."Transaction Type"::"Interest Due", CredLedgers."Transaction Type"::"Interest Paid");
                CredLedgers.SetFilter(CredLedgers."Posting Date", '%1..%2', StartDate, EndDate);

                if CredLedgers.FindSet() then begin
                    // CredLedgers.CalcSums("Debit Amount", "Credit Amount");
                    TotalDebits := CredLedgers."Debit Amount";
                    TotalCredits := CredLedgers."Credit Amount";

                end;


                DetLedger.Reset();
                DetLedger.SetFilter(DetLedger."Posting Date", '..%1', CalcDate('-1D', StartDate));
                DetLedger.SetFilter(DetLedger."Transaction Type", '%1|%2', DetLedger."Transaction Type"::Loan, DetLedger."Transaction Type"::Repayment, DetLedger."Transaction Type"::"Interest Due", DetLedger."Transaction Type"::"Interest Paid");
                //DetLedger.SetRange(DetLedger.Reversed, false);
                DetLedger.SetRange(DetLedger."Loan No", loanNumber);
                DetLedger.SetFilter(DetLedger."Entry Type", '<>%1', DetLedger."Entry Type"::Application);
                if DetLedger.FindSet() then begin
                    DetLedger.CalcSums(DetLedger.Amount);
                    OpenBal := DetLedger.Amount;
                end;
                RunBal := OpenBal;

                CredLedger.Reset();
                CredLedger.SetCurrentKey("Posting Date");
                CredLedger.SetAscending("Posting Date", false);
                CredLedger.SetRange(CredLedger.Reversed, false);
                CredLedger.SetRange(CredLedger."Loan No", LoansRegister."Loan  No.");
                CredLedger.SetFilter(CredLedger."Transaction Type", '%1|%2|%3|%4', CredLedger."Transaction Type"::Loan, CredLedger."Transaction Type"::Repayment, CredLedger."Transaction Type"::"Interest Due", CredLedger."Transaction Type"::"Interest Paid");
                CredLedger.SetFilter(CredLedger."Posting Date", '%1..%2', StartDate, EndDate);
                // CredLedger.SetFilter(CredLedger."Entry Type", '<>%1', CredLedger."Entry Type"::Application);
                if CredLedger.FindSet() then begin
                    Count := 0;
                    FirstRow := ((page_number - 1) * page_size) + 1;
                    LastRow := page_number * page_size;
                    TotalFoundRecords := CredLedger.Count;

                    repeat begin
                        Count := Count + 1;
                        if (Count >= FirstRow) and (Count <= LastRow) then begin
                            EntryType := '';
                            if CredLedger.Amount > 0 then
                                EntryType := 'Debit'
                            else
                                EntryType := 'Credit';
                            RunBal := RunBal + CredLedger.Amount;
                            TransactionObject.Add('entry_number', CredLedger."Entry No.");
                            TransactionObject.Add('transaction_reference', CredLedger."Document No.");
                            TransactionObject.Add('posting_date', CredLedger."Posting Date");
                            TransactionObject.Add('description', CredLedger.Description);
                            TransactionObject.Add('amount', CredLedger.Amount);
                            TransactionObject.Add('running_balance', RunBal);
                            TransactionObject.Add('entry_type', EntryType);
                            TransactionObject.Add('transaction_type', Format(CredLedger."Transaction Type"));
                            TransactionsArray.Add(TransactionObject);
                            Clear(TransactionObject);
                        end;
                    end until (Count = LastRow) or (CredLedger.Next() = 0);

                end;
                PageJson.Add('records', TransactionsArray);
                PageJson.Add('page', page_number);
                PageJson.Add('page_count', page_size);
                PageJson.Add('total_records', TotalFoundRecords);
                PageJson.Add('credits', TotalCredits);
                PageJson.Add('debits', TotalDebits);
                PageJson.Add('Balance_Brought_Forward', OpenBal);



            end else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Account does not exist');
        end;
        ResponseJson.Add(Data, PageJson);
    end;

    local procedure GetLoanStatementReportPortal(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        AccountType: Text;
        AccountNumber: Text;
        NumberOfTransactions: Integer;
        StartDate: Date;
        EndDate: Date;
        SavAccount: Record Vendor;
        StatementType: Text;
        Members: Record Customer;
        TransactionsArray: JsonArray;
        TransactionObject: JsonObject;
        Iterator: Integer;
        SavLedger: record "Detailed Vendor Ledg. Entry";
        DetLedger: record "Detailed Vendor Ledg. Entry";
        OpenBal: Decimal;
        Found: Boolean;
        Loans: Record "Loans Register";
        CredLedger: Record "Detailed Cust. Ledg. Entry";
        DocumentNumber: Code[40];
        AccountTypeX: Record "Account Types-Saving Products";
        varTempBlob: Codeunit "Temp Blob";
        OStream: OutStream;
        IStream: InStream;
        varBase64Conversion: Codeunit "Base64 Convert";
        vConvertedContent: Text;
        RecRef: RecordRef;
        // MemberStatement: Report 50004;
        StatementOutstream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        StatementInstream: InStream;
        RunBal: Decimal;
        SaccoGen: Record "Sacco General Set-Up";
        LoansRegister: Record "Loans Register";
        EntryType: Text[50];
        loanNumber: Text;
    begin
        Iterator := 0;
        Found := false;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        loanNumber := SelectJsonToken(RequestJson, '$.loan_number').AsValue.AsText;
        StartDate := SelectJsonToken(RequestJson, '$.start_date').AsValue.AsDate;
        EndDate := SelectJsonToken(RequestJson, '$.end_date').AsValue.AsDate;



        if IdentifierType = 'NATIONAL_ID_NUMBER' then begin
            LoansRegister.Reset();
            LoansRegister.SetRange(LoansRegister."Loan  No.", loanNumber);
            LoansRegister.SetFilter(LoansRegister."Date filter", '%1..%2', StartDate, EndDate);
            if LoansRegister.FindFirst() then begin
                SetResponseStatus(ResponseJson, 'success', 'Success', 'Member’s Loan Statement has been fetched successfully');
                varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);

                RecRef.GetTable(LoansRegister);
                Report.SaveAs(Report::"Member Loans Statement", '', REPORTFORMAT::Pdf, OStream, RecRef);
                varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
                vConvertedContent := varBase64Conversion.ToBase64(IStream);
                DataJson.Add('pdf', vConvertedContent);
            end else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Account does not exist');
        end;
        ResponseJson.Add(Data, DataJson);
    end;


    local procedure GetLoanRepaymentScheduleReportPortal(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        AccountType: Text;
        AccountNumber: Text;
        NumberOfTransactions: Integer;
        StartDate: Date;
        EndDate: Date;
        SavAccount: Record Vendor;
        StatementType: Text;
        Members: Record Customer;
        TransactionsArray: JsonArray;
        TransactionObject: JsonObject;
        Iterator: Integer;
        SavLedger: record "Detailed Vendor Ledg. Entry";
        DetLedger: record "Detailed Vendor Ledg. Entry";
        OpenBal: Decimal;
        Found: Boolean;
        Loans: Record "Loans Register";
        CredLedger: Record "Detailed Cust. Ledg. Entry";
        DocumentNumber: Code[40];
        AccountTypeX: Record "Account Types-Saving Products";
        varTempBlob: Codeunit "Temp Blob";
        OStream: OutStream;
        IStream: InStream;
        varBase64Conversion: Codeunit "Base64 Convert";
        vConvertedContent: Text;
        RecRef: RecordRef;
        MemberStatement: Report "Member Account Statement";
        StatementOutstream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        StatementInstream: InStream;
        RunBal: Decimal;
        SaccoGen: Record "Sacco General Set-Up";
        LoansRegister: Record "Loans Register";
        EntryType: Text[50];
        loanNumber: Text;
        Schedule: Record "Loan Repayment Schedule";
    begin
        Iterator := 0;
        Found := false;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        loanNumber := SelectJsonToken(RequestJson, '$.loan_number').AsValue.AsText;

        if IdentifierType = 'NATIONAL_ID_NUMBER' then begin
            Members.Reset();
            Members.SetRange(Members."ID No.", Identifier);
            if Members.FindFirst() then begin
                LoansRegister.Reset();
                LoansRegister.SetRange(LoansRegister."Client Code", Members."No.");
                LoansRegister.SetRange(LoansRegister."Loan  No.", loanNumber);
                if LoansRegister.FindFirst() then begin

                    SetResponseStatus(ResponseJson, 'success', 'Success', 'Member’s Loan Repayment Schedule report has been exported successfully');
                    varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);

                    RecRef.GetTable(LoansRegister);
                    Report.SaveAs(Report::"Loans Repayment Schedule New", '', REPORTFORMAT::Pdf, OStream, RecRef);
                    varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
                    vConvertedContent := varBase64Conversion.ToBase64(IStream);
                    DataJson.Add('pdf', vConvertedContent);
                end else
                    SetResponseStatus(ResponseJson, 'error', 'Error', 'Account does not exist');
            end;
        end;
        ResponseJson.Add(Data, DataJson);
    end;

    local procedure GetAccountStatementReportPortal(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        AccountType: Text;
        AccountNumber: Text;
        NumberOfTransactions: Integer;
        StartDate: Date;
        EndDate: Date;
        SavAccount: Record Customer;
        StatementType: Text;
        Members: Record Customer;
        TransactionsArray: JsonArray;
        TransactionObject: JsonObject;
        Iterator: Integer;
        SavLedger: record "Detailed Vendor Ledg. Entry";
        DetLedger: record "Detailed Vendor Ledg. Entry";
        OpenBal: Decimal;
        Found: Boolean;
        Loans: Record "Loans Register";
        CredLedger: Record "Detailed Cust. Ledg. Entry";
        DocumentNumber: Code[40];
        AccountTypeX: Record "Account Types-Saving Products";
        varTempBlob: Codeunit "Temp Blob";
        OStream: OutStream;
        IStream: InStream;
        varBase64Conversion: Codeunit "Base64 Convert";
        vConvertedContent: Text;
        RecRef: RecordRef;
        MemberStatement: Report "Member Detailed Statement";
        StatementOutstream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        StatementInstream: InStream;
        RunBal: Decimal;
        SaccoGen: Record "Sacco General Set-Up";
        LoansRegister: Record "Loans Register";
        EntryType: Text[50];
        page_size: integer;
        page_number: Integer;
        TotalFoundRecords: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        Count: Integer;
        PageJson: JsonObject;
        TotalDebits: Decimal;
        TotalCredits: Decimal;
        FosaState: report "Member Detailed Statement";
    begin
        Iterator := 0;
        Found := false;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        AccountNumber := SelectJsonToken(RequestJson, '$.account_number').AsValue.AsText;
        StartDate := SelectJsonToken(RequestJson, '$.start_date').AsValue.AsDate;
        EndDate := SelectJsonToken(RequestJson, '$.end_date').AsValue.AsDate;


        if IdentifierType = 'NATIONAL_ID_NUMBER' then begin
            // DetLedger.Reset();
            // DetLedger.SetRange(DetLedger."Vendor No.", AccountNumber);
            // DetLedger.SetFilter(DetLedger."Posting Date", '..%1', CalcDate('-1D', StartDate));
            // //DetLedger.SetAutoCalcFields(DetLedger.Amount);
            // if DetLedger.FindSet() then begin
            //     DetLedger.CalcSums(DetLedger.Amount);
            //     OpenBal := DetLedger.Amount;
            // end;

            //FosaState.SetParameters(OpenBal);
            //FosaState.RunModal();
            SavAccount.Reset();
            SavAccount.SetRange(SavAccount."ID No.", AccountNumber);
            SavAccount.SetFilter(SavAccount."Date Filter", '%1..%2', StartDate, EndDate);
            if SavAccount.FindFirst() then begin
                // SavAccount."Statement Balance" := OpenBal;
                // SavAccount."Start Date" := StartDate;
                // SavAccount."End Date" := EndDate;
                // SavAccount.Modify();
                SetResponseStatus(ResponseJson, 'success', 'Success', 'Member’s Account Statement has been fetched successfully');
                varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);
                RecRef.GetTable(SavAccount);



                Report.SaveAs(Report::"Member Detailed Statement", '', REPORTFORMAT::Pdf, OStream, RecRef);
                varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
                vConvertedContent := varBase64Conversion.ToBase64(IStream);
                DataJson.Add('pdf', vConvertedContent);


            end else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Account does not exist');
        end;

        ResponseJson.Add(Data, DataJson);
        //RandText := Mob.GetBalanceEnquiry(Identifier, DocumentNumber);




    end;


    local procedure GetDividendPayslipReportPortal(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        AccountType: Text;
        AccountNumber: Text;
        NumberOfTransactions: Integer;
        StartDate: Date;
        EndDate: Date;
        SavAccount: Record Customer;
        StatementType: Text;
        Members: Record Customer;
        TransactionsArray: JsonArray;
        TransactionObject: JsonObject;
        Iterator: Integer;
        DividendProgression: record "Dividends Progression";
        OpenBal: Decimal;
        Found: Boolean;
        Loans: Record "Loans Register";
        CredLedger: Record "Detailed Cust. Ledg. Entry";
        DocumentNumber: Code[40];
        AccountTypeX: Record "Account Types-Saving Products";
        varTempBlob: Codeunit "Temp Blob";
        OStream: OutStream;
        IStream: InStream;
        varBase64Conversion: Codeunit "Base64 Convert";
        vConvertedContent: Text;
        RecRef: RecordRef;
        // MemberStatement: Report 50004;
        StatementOutstream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        StatementInstream: InStream;
        RunBal: Decimal;
        SaccoGen: Record "Sacco General Set-Up";
        LoansRegister: Record "Loans Register";
        EntryType: Text[50];
        page_size: integer;
        page_number: Integer;
        TotalFoundRecords: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        Count: Integer;
        PageJson: JsonObject;
        TotalDebits: Decimal;
        TotalCredits: Decimal;
        // FosaState: report FOSAStatementOne;
        Period: Code[40];
    begin
        Iterator := 0;
        Found := false;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        Period := SelectJsonToken(RequestJson, '$.period').AsValue.AsText;



        if IdentifierType = 'NATIONAL_ID_NUMBER' then begin

            SavAccount.Reset();
            SavAccount.SetRange(SavAccount."ID No.", Identifier);
            if SavAccount.FindFirst() then begin
                // DividendProgression.SetRange(DividendProgression."Member No",SavAccount."No.");

                // SavAccount."Dividend Year" := Period;
                // SavAccount.Modify();
                SetResponseStatus(ResponseJson, 'success', 'Success', 'Member’s Dividend Payment report has been exported successfully');
                varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);
                RecRef.GetTable(SavAccount);



                Report.SaveAs(Report::"Dividends Progressionslip", '', REPORTFORMAT::Pdf, OStream, RecRef);
                varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
                vConvertedContent := varBase64Conversion.ToBase64(IStream);
                DataJson.Add('pdf', vConvertedContent);


            end else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Account does not exist');
        end;

        ResponseJson.Add(Data, DataJson);
        //RandText := Mob.GetBalanceEnquiry(Identifier, DocumentNumber);




    end;
    // // ------------------------------------------------------------------------------------------------
    // local procedure PESAOUTRequest(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     GenJournalLine: Record "Gen. Journal Line";
    //     OriginatorID: Text;
    //     ProductID: Text;
    //     PesaType: Text;
    //     LineNo: Integer;
    //     TransactionAction: Text;
    //     Command: Text;
    //     FosaStatement: Report FOSAStatementOne;
    //     TransactionInitiatorIdentifierType: Text;
    //     TransactionInitiatorIdentifier: Text;
    //     TransactionInitiatorAccount: Text;
    //     TransactionInitiatorName: Text;
    //     TransactionInitiatorReference: Text;
    //     TransactionSourceIdentifierType: Text;
    //     TransactionSourceIdentifier: Text;
    //     TransactionSourceAccount: Text;
    //     TransactionSourceName: Text;
    //     TransactionSenderIdentifierType: Text;
    //     TransactionSenderIdentifier: Text;
    //     TransactionSenderAccount: Text;
    //     TransactionSenderName: Text;
    //     TransactionReceiverIdentifierType: Text;
    //     TransactionReceiverIdentifier: Text;
    //     TransactionReceiverAccount: Text;
    //     TransactionReceiverName: Text;
    //     TransactionBeneficiaryIdentifierType: Text;
    //     TransactionBeneficiaryIdentifier: Text;
    //     TransactionBeneficiaryAccount: Text;
    //     TransactionBeneficiaryName: Text;
    //     Amount: Decimal;
    //     Category: Text;
    //     TransactionDescription: Text;
    //     SourceReference: Text;
    //     RequestApplication: Text;
    //     SourceApplication: Text;
    //     TransactionDateTime: Text;
    //     GLPosting: Codeunit 12;
    //     WithdrawalBuffer: Record "Mpesa Withdawal Buffer";
    //     Vend: Record Vendor;
    //     Vendor: Record Vendor;
    //     AvailableBalance: Decimal;
    //     // Mob: Codeunit MobileBanking_New;
    //     MBuffer: Record "Mpesa Withdawal Buffer";
    //     Response: Text;
    //     PendingAmount: Decimal;
    // begin
    //     OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
    //     ProductID := SelectJsonToken(RequestJson, '$.product_id').AsValue.AsText;
    //     PesaType := SelectJsonToken(RequestJson, '$.pesa_type').AsValue.AsText;
    //     TransactionAction := SelectJsonToken(RequestJson, '$.action').AsValue.AsText;
    //     Command := SelectJsonToken(RequestJson, '$.command').AsValue.AsText;

    //     TransactionInitiatorIdentifierType := SelectJsonToken(RequestJson, '$.transaction_initiator_details.identifier_type').AsValue.AsText;
    //     TransactionInitiatorIdentifier := SelectJsonToken(RequestJson, '$.transaction_initiator_details.identifier').AsValue.AsText;
    //     TransactionInitiatorAccount := SelectJsonToken(RequestJson, '$.transaction_initiator_details.account').AsValue.AsText;
    //     TransactionInitiatorName := SelectJsonToken(RequestJson, '$.transaction_initiator_details.name').AsValue.AsText;
    //     TransactionInitiatorReference := SelectJsonToken(RequestJson, '$.transaction_initiator_details.reference').AsValue.AsText;

    //     TransactionSourceIdentifierType := SelectJsonToken(RequestJson, '$.transaction_source_details.identifier_type').AsValue.AsText;
    //     TransactionSourceIdentifier := SelectJsonToken(RequestJson, '$.transaction_source_details.identifier').AsValue.AsText;
    //     TransactionSourceAccount := SelectJsonToken(RequestJson, '$.transaction_source_details.account').AsValue.AsText;
    //     TransactionSourceName := SelectJsonToken(RequestJson, '$.transaction_source_details.name').AsValue.AsText;

    //     TransactionSenderIdentifierType := SelectJsonToken(RequestJson, '$.transaction_sender_details.identifier_type').AsValue.AsText;
    //     TransactionSenderIdentifier := SelectJsonToken(RequestJson, '$.transaction_sender_details.identifier').AsValue.AsText;
    //     TransactionSenderAccount := SelectJsonToken(RequestJson, '$.transaction_sender_details.account').AsValue.AsText;
    //     TransactionSenderName := SelectJsonToken(RequestJson, '$.transaction_sender_details.name').AsValue.AsText;

    //     TransactionReceiverIdentifierType := SelectJsonToken(RequestJson, '$.transaction_receiver_details.identifier_type').AsValue.AsText;
    //     TransactionReceiverIdentifier := SelectJsonToken(RequestJson, '$.transaction_receiver_details.identifier').AsValue.AsText;
    //     TransactionReceiverAccount := SelectJsonToken(RequestJson, '$.transaction_receiver_details.account').AsValue.AsText;
    //     TransactionReceiverName := SelectJsonToken(RequestJson, '$.transaction_receiver_details.name').AsValue.AsText;

    //     TransactionBeneficiaryIdentifierType := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier_type').AsValue.AsText;
    //     TransactionBeneficiaryIdentifier := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier').AsValue.AsText;
    //     TransactionBeneficiaryAccount := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.account').AsValue.AsText;
    //     TransactionBeneficiaryName := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.name').AsValue.AsText;

    //     Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
    //     Category := SelectJsonToken(RequestJson, '$.category').AsValue.AsText;
    //     TransactionDescription := SelectJsonToken(RequestJson, '$.transaction_description').AsValue.AsText;
    //     SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
    //     RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
    //     SourceApplication := SelectJsonToken(RequestJson, '$.source_application').AsValue.AsText;
    //     TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;

    //     if PesaType = 'PESA_OUT' then begin
    //         WithdrawalBuffer.Reset();
    //         WithdrawalBuffer.SetRange("Originator ID", OriginatorID);
    //         if WithdrawalBuffer.Find('-') = false then begin

    //             Response := '';
    //             Vend.Reset();
    //             // Vend.SetRange(Vend."Mobile Phone No", TransactionInitiatorIdentifier);
    //             Vend.SetRange("No.", TransactionSourceAccount);
    //             Vend.SetAutoCalcFields(Balance);
    //             if Vend.FindFirst() then begin


    //                 PendingAmount := 0;
    //                 MBuffer.Reset();
    //                 MBuffer.SetRange(MBuffer."Vendor No", Vend."No.");
    //                 MBuffer.SetRange(MBuffer.Posted, false);
    //                 MBuffer.SetRange(MBuffer.Reversed, false);
    //                 if MBuffer.FindSet() then begin
    //                     MBuffer.CalcSums(MBuffer."Amount Requested");
    //                     PendingAmount := MBuffer."Amount Requested";
    //                 end;
    //                 AvailableBalance := 0;
    //                 AvailableBalance := Vend.Balance - ((Vend."Uncleared Cheques" - Vend."Cheque Discounted Amount") + PendingAmount + Vend."ATM Transactions" + Vend."EFT Transactions" + 1000 + Vend."Mobile Transactions" + Vend."Amount to freeze");
    //                 if FnOkayMember(Vend."BOSA Account No") <> true then
    //                     Response := 'The member account is not active.';
    //                 if Vend."Account Type" <> '103' then
    //                     Response := 'You cannot transact from this account';
    //                 if Amount > AvailableBalance then begin
    //                     Response := 'You have insufficient balance in your account available balance' + Format(Vendor.Balance);
    //                 end else begin
    //                     Response := 'Success';

    //                     WithdrawalBuffer.Init();
    //                     WithdrawalBuffer."Vendor No" := Vend."No.";
    //                     WithdrawalBuffer."Vendor Name" := Vend.Name;
    //                     WithdrawalBuffer."Amount Requested" := Amount;
    //                     WithdrawalBuffer.Posted := false;
    //                     WithdrawalBuffer."Originator ID" := OriginatorID;
    //                     WithdrawalBuffer."Transaction Date" := Today;
    //                     WithdrawalBuffer."Telephone No" := TransactionInitiatorIdentifier;
    //                     WithdrawalBuffer."Member No" := Vend."BOSA Account No";
    //                     WithdrawalBuffer.Insert(true);
    //                 end;
    //             end;/*  else begin
    //                  SetResponseStatus(ResponseJson, 'FAIL', 'FAIL', 'Account not found.');
    //             end; */
    //         end;
    //     end;

    //     if Response <> 'Success' then
    //         SetResponseStatus(ResponseJson, 'FAIL', 'Fail', Response);
    //     if Response = 'Success' then begin
    //         SetResponseStatus(ResponseJson, 'success', 'SUCCESS', 'Request processed successfully');
    //     end;
    //     DataJson.Add('transaction_reference', OriginatorID);
    //     DataJson.Add('transaction_status_description', Response);
    //     DataJson.Add('transaction_date_time', CurrentDateTime);

    //     ResponseJson.Add(Data, DataJson);
    // end;
    // // ------------------------------------------------------------------------------------------------
    // local procedure PESAOUTConfirmation(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     OriginatorID: Text;
    //     TransactionStatus: Text;
    //     TransactionStatusDescription: Text;
    //     BeneficiaryIdentifierType: Text;
    //     BeneficiaryIdentifier: Text;
    //     BeneficiaryName: Text;
    //     BeneficiaryReference: Text;
    //     TransactionDateTime: Text;
    //     BufferTable: Record "Mpesa Withdawal Buffer";
    //     MPESATRANS: Record "MOBILE MPESA Trans";
    //     GenJournalLine: Record "Gen. Journal Line";
    //     Vend: Record Vendor;
    //     Member: Record Customer;
    //     ChargeAmount: Decimal;
    //     GraduatedCharge: Record "MPESA  Withdrawal";
    //     GraduatedCharges: Record "Airtime Purchase Charges";
    //     GraduatedChargeB: Record "External Transfer Charges";
    //     MpesaComm: Decimal;
    //     SaccoCommission: Decimal;
    //     VendorComm: Decimal;
    //     ExciseDuty: Decimal;
    //     TotalAmount: Decimal;
    //     Category: Text;
    //     VendorCommAccount: Code[20];
    //     ExciseDutyAccount: Code[20];
    //     TotalAmountAccount: Code[20];
    //     SaccoCommissionAccount: Code[20];
    //     MpesaCommAccount: Code[20];
    //     SaccoGen: Record "Sacco General Set-Up";
    //     smsManagement: Codeunit "Sms Management";
    //     Members: Record Customer;
    //     MpesaMobile: Record "MOBILE MPESA Trans";
    //     CreationMessage: Text[2500];
    //     Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
    // begin
    //     OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
    //     TransactionStatus := SelectJsonToken(RequestJson, '$.transaction_status').AsValue.AsText;
    //     TransactionStatusDescription := SelectJsonToken(RequestJson, '$.transaction_status_description').AsValue.AsText;

    //     BeneficiaryIdentifierType := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier_type').AsValue.AsText;
    //     BeneficiaryIdentifier := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier').AsValue.AsText;
    //     BeneficiaryName := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.name').AsValue.AsText;
    //     Category := SelectJsonToken(RequestJson, '$.category').AsValue.AsText;
    //     BeneficiaryReference := SelectJsonToken(RequestJson, '$.beneficiary_reference').AsValue.AsText;//Kit Comment
    //     TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;
    //     //success transaction

    //     if TransactionStatus = 'CONFIRMED' then begin

    //         BufferTable.Reset();
    //         BufferTable.SetRange(BufferTable."Originator ID", UpperCase(OriginatorID));
    //         BufferTable.SetRange(Posted, false);
    //         if BufferTable.FindSet() then begin
    //             MpesaMobile.Reset();
    //             MpesaMobile.SetRange(MpesaMobile."Document No", OriginatorID);
    //             if not MpesaMobile.FindFirst() then begin
    //                 MPESATRANS.Init;
    //                 MPESATRANS."Document No" := OriginatorID;
    //                 MPESATRANS.Trace := BeneficiaryReference;
    //                 MPESATRANS.Description := TransactionStatusDescription;
    //                 MPESATRANS."Telephone" := BeneficiaryIdentifier;
    //                 MPESATRANS."Account No" := BufferTable."Vendor No";
    //                 MPESATRANS.Amount := BufferTable."Amount Requested";
    //                 MPESATRANS."Transaction Type" := 'Withdrawal';
    //                 MPESATRANS."Document Date" := Today;
    //                 MPESATRANS."Transaction Date Time" := Format(CurrentDateTime);
    //                 MPESATRANS.Posted := true;
    //                 MPESATRANS.Reference := OriginatorID;
    //                 MPESATRANS."Transaction Category" := BufferTable."Transaction Description";
    //                 MPESATRANS.Insert;

    //                 //if BufferTable."Transaction Description" = 'MPESA_WITHDRAWAL' then
    //                 BATCH_TEMPLATE := 'GENERAL';
    //                 BATCH_NAME := 'MOBILE';
    //                 DOCUMENT_NO := BeneficiaryReference;
    //                 GenJournalLine.Reset();
    //                 GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
    //                 GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
    //                 if GenJournalLine.FindSet() then begin
    //                     GenJournalLine.DeleteAll();
    //                 end;
    //                 //***Graduated Charge

    //                 if Category = 'MPESA_WITHDRAWAL' then begin
    //                     ChargeAmount := 0;

    //                     GraduatedCharge.Reset;
    //                     if GraduatedCharge.Find('-') then begin
    //                         repeat
    //                             if (BufferTable."Amount Requested" >= GraduatedCharge."Min Band") and (BufferTable."Amount Requested" <= GraduatedCharge."Upper Band") then begin
    //                                 VendorComm := 0;
    //                                 ChargeAmount := 0;
    //                                 ExciseDuty := 0;
    //                                 MpesaComm := 0;
    //                                 TotalAmount := 0;
    //                                 ChargeAmount := GraduatedCharge.Total;
    //                                 VendorComm := GraduatedCharge."Vendor Comm";
    //                                 SaccoCommission := GraduatedCharge."Sacco Comm";
    //                                 MpesaComm := GraduatedCharge.Mpesa;
    //                                 ExciseDuty := GraduatedCharge."Excise Duty";
    //                                 TotalAmount := GraduatedCharge.Total;
    //                                 MpesaCommAccount := GraduatedCharge."Mpesa Account";
    //                                 VendorCommAccount := GraduatedCharge."Vendor Comm G/L";
    //                                 SaccoCommissionAccount := GraduatedCharge."Sacco Comm G/L";
    //                             end;
    //                         until GraduatedCharge.Next = 0;
    //                     end;
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, BufferTable."Vendor No", Today, BufferTable."Amount Requested", 'FOSA', DOCUMENT_NO,
    //                      'Mobile withdrawal to ' + BeneficiaryName + ' ' + Vend."No.", '');//
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, BufferTable."Vendor No", Today, TotalAmount, 'FOSA', DOCUMENT_NO,
    //                      'Mobile charges' + ' ' + Vend."No.", '');//

    //                     //Balancing Account
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"Bank Account", 'BNK00013', Today, BufferTable."Amount Requested" * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile withdrawal' + ' ' + Vend."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"Bank Account", 'BNK00013', Today, MpesaComm * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Trans Mpesa' + ' ' + Vend."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, VendorCommAccount, Today, VendorComm * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Trans Mpesa Comm' + ' ' + Vend."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, Today, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Trans Mpesa Comm' + ' ' + Vend."No.", '');

    //                     SaccoGen.Get();
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", Today, ExciseDuty * -1, 'FOSA', DOCUMENT_NO,
    //                      'Excise Duty Mpesa Comm' + ' ' + Vend."No.", '');
    //                 end;

    //                 if Category = 'BANK_TRANSFER' then begin
    //                     ChargeAmount := 0;

    //                     GraduatedChargeb.Reset;
    //                     if GraduatedChargeb.Find('-') then begin
    //                         repeat
    //                             if (BufferTable."Amount Requested" >= GraduatedChargeb."Min Band") and (BufferTable."Amount Requested" <= GraduatedChargeb."Upper Band") then begin
    //                                 VendorComm := 0;
    //                                 ChargeAmount := 0;
    //                                 ExciseDuty := 0;
    //                                 MpesaComm := 0;
    //                                 TotalAmount := 0;
    //                                 ChargeAmount := GraduatedChargeb.Total;
    //                                 VendorComm := GraduatedChargeb."Vendor Comm";
    //                                 SaccoCommission := GraduatedChargeb."Sacco Comm";
    //                                 MpesaComm := GraduatedChargeb.Mpesa;
    //                                 ExciseDuty := GraduatedChargeb."Excise Duty";
    //                                 TotalAmount := GraduatedChargeb.Total;
    //                                 MpesaCommAccount := GraduatedChargeb."Mpesa Account";
    //                                 VendorCommAccount := GraduatedChargeb."Vendor Comm G/L";
    //                                 SaccoCommissionAccount := GraduatedChargeb."Sacco Comm G/L";
    //                             end;
    //                         until GraduatedChargeb.Next = 0;
    //                     end;
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, BufferTable."Vendor No", Today, BufferTable."Amount Requested", 'FOSA', DOCUMENT_NO,
    //                      'Bank Transfer' + ' ' + Vend."No.", '');//
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, BufferTable."Vendor No", Today, TotalAmount, 'FOSA', DOCUMENT_NO,
    //                      'Bank Transfer charges' + ' ' + Vend."No.", '');//

    //                     //Balancing Account
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"Bank Account", 'BNK00013', Today, BufferTable."Amount Requested" * -1, 'FOSA', DOCUMENT_NO,
    //                      'Bank Transfer' + ' ' + Vend."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"Bank Account", 'BNK00013', Today, MpesaComm * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Trans Mpesa Comm' + ' ' + Vend."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, VendorCommAccount, Today, VendorComm * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Trans Mpesa Comm' + ' ' + Vend."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, Today, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Trans Mpesa Comm' + ' ' + Vend."No.", '');

    //                     SaccoGen.Get();
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", Today, ExciseDuty * -1, 'FOSA', DOCUMENT_NO,
    //                      'Excise Duty Mpesa Comm' + ' ' + Vend."No.", '');
    //                 end;
    //                 if Category = 'AIRTIME_PURCHASE' then begin
    //                     ChargeAmount := 0;

    //                     GraduatedCharges.Reset;
    //                     if GraduatedCharges.Find('-') then begin
    //                         repeat
    //                             if (BufferTable."Amount Requested" >= GraduatedCharges."Min Band") and (BufferTable."Amount Requested" <= GraduatedCharges."Upper Band") then begin
    //                                 VendorComm := 0;
    //                                 ChargeAmount := 0;
    //                                 ExciseDuty := 0;
    //                                 MpesaComm := 0;
    //                                 TotalAmount := 0;
    //                                 ChargeAmount := GraduatedCharges.Total;
    //                                 VendorComm := GraduatedCharges."Vendor Comm";
    //                                 SaccoCommission := GraduatedCharges."Sacco Comm";
    //                                 MpesaComm := GraduatedCharges.Mpesa;
    //                                 ExciseDuty := GraduatedCharges."Excise Duty";
    //                                 TotalAmount := GraduatedCharges.Total;
    //                                 MpesaCommAccount := GraduatedCharges."Mpesa Account";
    //                                 VendorCommAccount := GraduatedCharges."Vendor Comm G/L";
    //                                 SaccoCommissionAccount := GraduatedCharges."Sacco Comm G/L";
    //                             end;
    //                         until GraduatedCharges.Next = 0;
    //                     end;
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, BufferTable."Vendor No", Today, BufferTable."Amount Requested", 'FOSA', DOCUMENT_NO,
    //                      'Airtime Purchase' + ' ' + Vend."No.", '');//
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, BufferTable."Vendor No", Today, TotalAmount, 'FOSA', DOCUMENT_NO,
    //                      'Airtime Purchase charges' + ' ' + Vend."No.", '');//

    //                     //Balancing Account
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"Bank Account", 'BNK00013', Today, BufferTable."Amount Requested" * -1, 'FOSA', DOCUMENT_NO,
    //                      'Airtime Purchase' + ' ' + Vend."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"Bank Account", 'BNK00013', Today, MpesaComm * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Trans Mpesa Comm' + ' ' + Vend."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, VendorCommAccount, Today, VendorComm * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Trans Mpesa Comm' + ' ' + Vend."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, Today, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Trans Mpesa Comm' + ' ' + Vend."No.", '');

    //                     SaccoGen.Get();
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", Today, ExciseDuty * -1, 'FOSA', DOCUMENT_NO,
    //                      'Excise Duty Mpesa Comm' + ' ' + Vend."No.", '');
    //                 end;
    //                 if Category = 'BILL_PAYMENT' then begin
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, BufferTable."Vendor No", Today, BufferTable."Amount Requested", 'FOSA', DOCUMENT_NO,
    //                      'Bank Transfer' + ' ' + Vend."No.", '');//
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, BufferTable."Vendor No", Today, TotalAmount, 'FOSA', DOCUMENT_NO,
    //                      'Bank Transfer charges' + ' ' + Vend."No.", '');//

    //                     //Balancing Account
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"Bank Account", 'BNK00013', Today, BufferTable."Amount Requested" * -1, 'FOSA', DOCUMENT_NO,
    //                      'Bank Transfer' + ' ' + Vend."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"Bank Account", 'BNK00013', Today, MpesaComm * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Trans Mpesa Comm' + ' ' + Vend."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, VendorCommAccount, Today, VendorComm * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Trans Mpesa Comm' + ' ' + Vend."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, Today, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Trans Mpesa Comm' + ' ' + Vend."No.", '');

    //                     SaccoGen.Get();
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", Today, ExciseDuty * -1, 'FOSA', DOCUMENT_NO,
    //                      'Excise Duty Mpesa Comm' + ' ' + Vend."No.", '');
    //                 end;

    //                 //Post
    //                 GenJournalLine.Reset;
    //                 GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //                 GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //                 if GenJournalLine.Find('-') then begin
    //                     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //                 end;
    //             end else begin
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Duplicate Transaction');
    //             end;
    //             BufferTable.Posted := true;
    //             BufferTable.Modify();
    //             Members.Reset();
    //             Members.SetRange(Members."FOSA Account No.", BufferTable."Vendor No");
    //             if Members.FindFirst() then begin
    //                 CreationMessage := 'Dear ' + BName.NameStyle(Members."No.") + ', your ' + LowerCase(Category) + ' of Ksh ' + Format(BufferTable."Amount Requested") + ' has been posted successfully to ' + BeneficiaryName + ' on ' + Format(Today) + ' at ' + Format(time) + 'REF:' + OriginatorID;
    //                 smsManagement.SendSmsWithID(Source::CASH_WITHDRAWAL_CONFIRM, Members."Mobile Phone No", CreationMessage, Members."No.", Members."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
    //             end;
    //             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //             DataJson.Add('transaction_status', 'SUCCESS');
    //             DataJson.Add('transaction_status_description', 'Result processed successfully');
    //             DataJson.Add('transaction_date_time', CurrentDateTime);
    //             BufferTable.Posted := true;
    //             BufferTable.Modify();

    //         end else
    //             SetResponseStatus(ResponseJson, 'success', 'Success', 'Invalid originator ID');
    //         ResponseJson.Add(Data, DataJson);
    //     end;

    //     if TransactionStatus = 'REVERSE_CONFIRMED' then begin
    //         BufferTable.Reset();
    //         BufferTable.SetRange(BufferTable."Originator ID", UpperCase(OriginatorID));
    //         BufferTable.SetRange(BufferTable.Reversed, false);
    //         if BufferTable.FindSet() then begin

    //             BufferTable.Reversed := true;
    //             BufferTable."Reversed Posted" := true;
    //             BufferTable."Transaction Description" := (BufferTable."Transaction Description" + '_Reversed');
    //             BufferTable.Modify();
    //             SetResponseStatus(ResponseJson, 'success', 'Success', 'Transaction reversed successfully');
    //             DataJson.Add('transaction_status', 'SUCCESS');
    //             DataJson.Add('transaction_status_description', 'Transaction reversed successfully');
    //             DataJson.Add('transaction_date_time', CurrentDateTime);


    //             //until BufferTable.Next() = 0;
    //         end else begin
    //             SetResponseStatus(ResponseJson, 'success', 'Success', 'originator ID already reversed');
    //         end;
    //         ResponseJson.Add(Data, DataJson);
    //     end;
    // end;


    // local procedure InternalFundsTransferLoans(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     OriginatorID: Text;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     SourceAccount: Text;
    //     DestinationAccount: Text;
    //     Amount: Decimal;
    //     SourceReference: Text;
    //     RequestApplication: Text;
    //     SourceApplication: Text;
    //     TransactionDescription: Text;
    //     TransactionDateTime: Text;
    //     SavAccount: Record Vendor;
    //     GenJournalLine: Record "Gen. Journal Line";
    //     Vend: Record Vendor;
    //     Vendor: Record Vendor;
    //     RunBal: Decimal;
    //     IntAmount: decimal;
    //     PrincipleAMount: Decimal;
    //     BufferTable: Record "Mpesa Withdawal Buffer";
    //     MPESATRANS: Record "MOBILE MPESA Trans";
    //     Member: Record Customer;
    //     ChargeAmount: Decimal;
    //     GraduatedCharge: Record "Funds Transfer Charges";
    //     MpesaComm: Decimal;
    //     SaccoCommission: Decimal;
    //     VendorComm: Decimal;
    //     ExciseDuty: Decimal;
    //     TotalAmount: Decimal;
    //     VendorCommAccount: Code[20];
    //     ExciseDutyAccount: Code[20];
    //     TotalAmountAccount: Code[20];
    //     SaccoCommissionAccount: Code[20];
    //     MpesaCommAccount: Code[20];
    //     SaccoGen: Record "Sacco General Set-Up";
    //     smsManagement: Codeunit "Sms Management";
    //     Members: Record Customer;
    //     CreationMessage: Text[2500];
    //     PercentageGra: Decimal;
    //     NetCharges: Decimal;
    //     MBuffer: Record "Mpesa Withdawal Buffer";
    //     AvailableBalance: decimal;
    //     FOSAAccounts: Record vendor;
    //     AccountTypes: Record "Account Types-Saving Products";
    //     PendingAmount: decimal;

    //     LProducts: Record "Loan Products Setup";
    //     SMSFee: Decimal;
    //     Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
    // //AvailableBalance: Decimal;
    // begin
    //     OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     SourceAccount := SelectJsonToken(RequestJson, '$.source_account').AsValue.AsText;
    //     DestinationAccount := SelectJsonToken(RequestJson, '$.destination_account').AsValue.AsText;
    //     Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
    //     SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
    //     RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
    //     SourceApplication := SelectJsonToken(RequestJson, '$.source_application').AsValue.AsText;
    //     TransactionDescription := SelectJsonToken(RequestJson, '$.transaction_description').AsValue.AsText;
    //     TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;


    //     //verify account
    //     SavAccount.Reset();
    //     SavAccount.SetRange(SavAccount."No.", SourceAccount);
    //     if SavAccount.FindFirst() then begin


    //         SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //         BATCH_TEMPLATE := 'GENERAL';
    //         BATCH_NAME := 'MOBILE';
    //         DOCUMENT_NO := SourceReference;
    //         GenJournalLine.Reset();
    //         GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
    //         GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
    //         if GenJournalLine.FindSet() then begin
    //             GenJournalLine.DeleteAll();
    //         end;

    //         FOSAAccounts.Reset();
    //         FOSAAccounts.SetRange(FOSAAccounts."No.", SourceAccount);
    //         if FOSAAccounts.FindFirst() then begin
    //             AccountTypes.Get(FOSAAccounts."Account Type");
    //             ChargeAmount := 0;
    //             SaccoGen.Get();
    //             Members.Get(FOSAAccounts."BOSA Account No");
    //             LineNo := LineNo + 10000;
    //             if Members."FOSA Account No." = SourceAccount then begin
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, SourceAccount, Today, Amount, 'FOSA', DOCUMENT_NO,
    //                  'Funds Transfer' + ' ' + SavAccount."No.", '');
    //             end;
    //             if Members."FOSA Account No." <> SourceAccount then begin
    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, SourceAccount, Today, Amount, 'FOSA', DOCUMENT_NO,
    //                  'Funds Transfer' + ' ' + SavAccount."No.", '');

    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, Members."FOSA Account No.", Today, -Amount, 'FOSA', DOCUMENT_NO,
    //                  'Funds Transfer FOSA' + ' ' + SavAccount."No.", '');
    //             end;

    //             RunBal := 0;
    //             RunBal := Amount;
    //             LoansRegister.Reset();
    //             LoansRegister.SetRange(LoansRegister."Loan  No.", DestinationAccount);
    //             LoansRegister.SetAutoCalcFields(LoansRegister."Outstanding Balance");
    //             // LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>%1', 0);
    //             if LoansRegister.FindFirst then begin
    //                 LProducts.Get(LoansRegister."Loan Product Type");
    //                 LoansRegister.CalcFields("Outstanding Balance", "Outstanding Interest");
    //                 if LoansRegister."Outstanding Interest" > 0 then begin
    //                     IntAmount := 0;
    //                     if LoansRegister."Outstanding Interest" > RunBal then
    //                         IntAmount := RunBal
    //                     else
    //                         IntAmount := LoansRegister."Outstanding Interest";
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
    //                     GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", Today, IntAmount * -1, 'FOSA', DOCUMENT_NO,
    //                      'Funds Transfer' + ' ' + SavAccount."No.", LoansRegister."Loan  No.");
    //                     RunBal := RunBal - IntAmount;
    //                 end;

    //                 if LoansRegister."Outstanding Balance" > 0 then begin
    //                     PrincipleAMount := 0;
    //                     PrincipleAMount := RunBal;
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
    //                    GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", Today, PrincipleAMount * -1, 'FOSA', DOCUMENT_NO,
    //                     'Funds Transfer' + ' ' + SavAccount."No.", LoansRegister."Loan  No.");

    //                 end;



    //                 CreationMessage := 'Dear ' + BName.NameStyle(Members."No.") + ' , your ' + LProducts."Product Description" + ' Loan Repayment of Ksh:' + Format(Amount) + ' from ' + AccountTypes.Description + ' has been processed successfully on ' + Format(Today) + ' at ' + Format(time) + 'REF:' + SourceReference;
    //                 smsManagement.SendSmsWithID(Source::INTERACCOUNT_TRANSFER, Members."Mobile Phone No", CreationMessage, Members."No.", Members."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
    //             end;

    //             //Post
    //             GenJournalLine.Reset;
    //             GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //             GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //             if GenJournalLine.Find('-') then begin
    //                 Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //             end;


    //             DataJson.Add('transaction_reference', SourceReference);
    //             DataJson.Add('transaction_status', 'SUCCESS');
    //             DataJson.Add('transaction_status_description', 'Transfer posted successfully');

    //             ResponseJson.Add(Data, DataJson);
    //             ;
    //         end else
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'Insufficient balance');



    //     end;
    // end;

    // // ------------------------------------------------------------------------------------------------
    // local procedure InternalFundsTransfer(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     OriginatorID: Text;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     SourceAccount: Text;
    //     DestinationAccount: Text;
    //     Amount: Decimal;
    //     SourceReference: Text;
    //     RequestApplication: Text;
    //     SourceApplication: Text;
    //     TransactionDescription: Text;
    //     TransactionDateTime: Text;
    //     SavAccount: Record Vendor;
    //     GenJournalLine: Record "Gen. Journal Line";
    //     Vend: Record Vendor;
    //     Vendor: Record Vendor;
    //     RunBal: Decimal;
    //     IntAmount: decimal;
    //     PrincipleAMount: Decimal;
    //     BufferTable: Record "Mpesa Withdawal Buffer";
    //     MPESATRANS: Record "MOBILE MPESA Trans";
    //     Member: Record Customer;
    //     ChargeAmount: Decimal;
    //     GraduatedCharge: Record "Funds Transfer Charges";
    //     MpesaComm: Decimal;
    //     SaccoCommission: Decimal;
    //     VendorComm: Decimal;
    //     ExciseDuty: Decimal;
    //     TotalAmount: Decimal;
    //     VendorCommAccount: Code[20];
    //     ExciseDutyAccount: Code[20];
    //     TotalAmountAccount: Code[20];
    //     SaccoCommissionAccount: Code[20];
    //     MpesaCommAccount: Code[20];
    //     SaccoGen: Record "Sacco General Set-Up";
    //     smsManagement: Codeunit "Sms Management";
    //     Members: Record Customer;
    //     CreationMessage: Text[2500];
    //     PercentageGra: Decimal;
    //     NetCharges: Decimal;
    //     MBuffer: Record "Mpesa Withdawal Buffer";
    //     AvailableBalance: decimal;
    //     FOSAAccounts: Record vendor;
    //     PendingAmount: decimal;
    //     AccountTypes: Record "Account Types-Saving Products";
    //     AccountType: Record "Account Types-Saving Products";
    //     SMSFee: Decimal;
    //     Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
    // //AvailableBalance: Decimal;
    // begin
    //     OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     SourceAccount := SelectJsonToken(RequestJson, '$.source_account').AsValue.AsText;
    //     DestinationAccount := SelectJsonToken(RequestJson, '$.destination_account').AsValue.AsText;
    //     Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
    //     SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
    //     RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
    //     SourceApplication := SelectJsonToken(RequestJson, '$.source_application').AsValue.AsText;
    //     TransactionDescription := SelectJsonToken(RequestJson, '$.transaction_description').AsValue.AsText;
    //     TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;


    //     //verify account
    //     SavAccount.Reset();
    //     SavAccount.SetRange(SavAccount."No.", SourceAccount);
    //     if SavAccount.FindFirst() then begin
    //         //get account balance
    //         //Error('Available%1Oksy%2',SavAccount.GetAvailableBalance,FnOkayMember(SavAccount."No."));
    //         if (SavAccount.GetAvailableBalance() > Amount) and (FnOkayMember(SavAccount."No.") = true) then begin


    //             MPESATRANS.Init;
    //             MPESATRANS."Document No" := SourceReference;
    //             MPESATRANS.Description := 'Mobile Funds Transfer -' + SourceReference;
    //             MPESATRANS."Account No" := DestinationAccount;
    //             MPESATRANS.Amount := Amount;
    //             MPESATRANS."Transaction Type" := 'Funds Transfer';
    //             MPESATRANS."Document Date" := Today;
    //             MPESATRANS."Transaction Date Time" := Format(CurrentDateTime);
    //             MPESATRANS."Key Word" := '';
    //             MPESATRANS.Posted := false;
    //             MPESATRANS."Telephone" := Identifier;
    //             MPESATRANS."Account No" := SourceAccount;
    //             MPESATRANS.Insert;


    //             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //             BATCH_TEMPLATE := 'GENERAL';
    //             BATCH_NAME := 'MOBILE';
    //             DOCUMENT_NO := SourceReference;
    //             GenJournalLine.Reset();
    //             GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
    //             GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
    //             if GenJournalLine.FindSet() then begin
    //                 GenJournalLine.DeleteAll();
    //             end;

    //             //Source Account
    //             Vendor.Reset();
    //             Vendor.SetRange(Vendor."No.", SourceAccount);
    //             Vendor.SetFilter(Vendor."Account Type", '%1|%2', '102', '101');
    //             if Vendor.FindFirst() then
    //                 Error('You are not allowed to transact using this account.');


    //             FOSAAccounts.Reset();
    //             FOSAAccounts.SetRange(FOSAAccounts."No.", SourceAccount);
    //             if FOSAAccounts.FindFirst() then begin
    //                 ChargeAmount := 0;
    //                 AccountTypes.Get(FOSAAccounts."Account Type");
    //                 SaccoGen.Get();
    //                 GraduatedCharge.Reset;
    //                 if GraduatedCharge.Find('-') then begin
    //                     repeat
    //                         if (Amount >= GraduatedCharge."Min Band") and (Amount <= GraduatedCharge."Upper Band") then begin

    //                             if GraduatedCharge."Use Percentage" = true then begin
    //                                 PercentageGra := 0;
    //                                 Evaluate(PercentageGra, GraduatedCharge.Percentage);
    //                                 VendorComm := 0;
    //                                 ChargeAmount := 0;
    //                                 ExciseDuty := 0;
    //                                 MpesaComm := 0;
    //                                 TotalAmount := 0;
    //                                 ChargeAmount := GraduatedCharge.Total;
    //                                 VendorComm := Amount * PercentageGra / 100;
    //                                 SaccoCommission := GraduatedCharge."Sacco Comm";
    //                                 MpesaComm := GraduatedCharge.Mpesa;
    //                                 ExciseDuty := GraduatedCharge."Excise Duty";
    //                                 TotalAmount := GraduatedCharge."Sacco Comm" + VendorComm;
    //                                 MpesaCommAccount := GraduatedCharge."Mpesa Account";
    //                                 VendorCommAccount := GraduatedCharge."Vendor Comm G/L";
    //                                 SaccoCommissionAccount := GraduatedCharge."Sacco Comm G/L";
    //                             end else begin
    //                                 VendorComm := 0;
    //                                 ChargeAmount := 0;
    //                                 ExciseDuty := 0;
    //                                 MpesaComm := 0;
    //                                 TotalAmount := 0;
    //                                 ChargeAmount := GraduatedCharge.Total;
    //                                 VendorComm := GraduatedCharge."Vendor Comm";
    //                                 SaccoCommission := GraduatedCharge."Sacco Comm";
    //                                 MpesaComm := GraduatedCharge.Mpesa;
    //                                 ExciseDuty := GraduatedCharge."Excise Duty";
    //                                 TotalAmount := GraduatedCharge.Total;
    //                                 MpesaCommAccount := GraduatedCharge."Mpesa Account";
    //                                 VendorCommAccount := GraduatedCharge."Vendor Comm G/L";
    //                                 SaccoCommissionAccount := GraduatedCharge."Sacco Comm G/L";
    //                             end;
    //                         end;
    //                     until GraduatedCharge.Next = 0;
    //                     NetCharges := 0;
    //                     SMSFee := 0;
    //                     SMSFee := SaccoGen."SMS Fee Amount";
    //                     TotalAmount := TotalAmount + SMSFee;
    //                     NetCharges := Amount - (TotalAmount);
    //                 end;

    //                 Members.get(FOSAAccounts."BOSA Account No");
    //                 Vendor.Reset();
    //                 Vendor.SetRange(Vendor."No.", Members."FOSA Account No.");
    //                 if Vendor.FindFirst() then begin
    //                     Vendor.CalcFields(Vendor.Balance);
    //                     MBuffer.Reset();
    //                     MBuffer.SetRange(MBuffer."Vendor No", Members."FOSA Account No.");
    //                     MBuffer.SetRange(MBuffer.Posted, false);
    //                     MBuffer.SetRange(MBuffer.Reversed, false);
    //                     if MBuffer.FindSet() then begin
    //                         MBuffer.CalcSums(MBuffer."Amount Requested");
    //                         PendingAmount := MBuffer."Amount Requested";
    //                     end;
    //                     AvailableBalance := 0;
    //                     AvailableBalance := Vendor.Balance - ((Vendor."Uncleared Cheques" - Vendor."Cheque Discounted Amount") + PendingAmount + Vendor."ATM Transactions" + Vendor."EFT Transactions" + 1000 + Vendor."Mobile Transactions" + Vendor."Amount to freeze");
    //                 end;

    //                 if Members."FOSA Account No." <> SourceAccount then begin
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, SourceAccount, Today, Amount, 'FOSA', DOCUMENT_NO,
    //                      'Funds Transfer' + ' ' + SavAccount."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, Members."FOSA Account No.", Today, -Amount, 'FOSA', DOCUMENT_NO,
    //                      'Funds Transfer FOSA' + ' ' + SavAccount."No.", '');
    //                 end;


    //                 //Error('Total%1', TotalAmount);
    //                 //Destination Account
    //                 Vend.Reset();
    //                 Vend.SetRange(Vend."No.", DestinationAccount);
    //                 if Vend.Find('-') then begin
    //                     AccountType.Get(Vend."Account Type");
    //                     if AvailableBalance >= TotalAmount then begin
    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                         GenJournalLine."Account Type"::Vendor, Members."FOSA Account No.", Today, Amount, 'FOSA', DOCUMENT_NO,
    //                          'Funds Transfer' + ' ' + SavAccount."No.", '');

    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                         GenJournalLine."Account Type"::Vendor, DestinationAccount, Today, Amount * -1, 'FOSA', DOCUMENT_NO,
    //                          'Funds Transfer' + ' ' + SavAccount."No.", '');
    //                     end;

    //                     if AvailableBalance < TotalAmount then begin
    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                         GenJournalLine."Account Type"::Vendor, Members."FOSA Account No.", Today, NetCharges, 'FOSA', DOCUMENT_NO,
    //                          'Funds Transfer' + ' ' + SavAccount."No.", '');

    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                         GenJournalLine."Account Type"::Vendor, DestinationAccount, Today, NetCharges * -1, 'FOSA', DOCUMENT_NO,
    //                          'Funds Transfer' + ' ' + SavAccount."No.", '');
    //                     end;

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, Members."FOSA Account No.", Today, TotalAmount, 'FOSA', DOCUMENT_NO,
    //                      'Funds transfer Charges' + ' ' + Member."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, VendorCommAccount, Today, VendorComm * -1, 'FOSA', DOCUMENT_NO,
    //                      'Vendor Commission' + ' ' + Members."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, Today, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
    //                      'Sacco Commission' + ' ' + Members."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::"G/L Account", SaccoGen."SMS Fee Account", Today, SMSFee * -1, 'FOSA', DOCUMENT_NO,
    //                      'Sacco Commission' + ' ' + Members."No.", '');

    //                     CreationMessage := 'Dear member, your transfer of Ksh ' + Format(Amount) + ' from ' + AccountTypes.Description + ' to ' + AccountType.Description + ' has been processed successfully on ' + Format(Today) + ' at ' + Format(time) + 'REF:' + SourceReference;
    //                     smsManagement.SendSmsWithID(Source::INTERACCOUNT_TRANSFER, Members."Mobile Phone No", CreationMessage, Members."No.", Members."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
    //                 end;

    //             end else begin
    //                 RunBal := 0;
    //                 RunBal := Amount;
    //                 LoansRegister.Reset();
    //                 LoansRegister.SetRange(LoansRegister."Loan  No.", DestinationAccount);
    //                 LoansRegister.SetAutoCalcFields(LoansRegister."Outstanding Balance");
    //                 LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>%1', 0);
    //                 if LoansRegister.FindFirst then begin
    //                     LoansRegister.CalcFields("Outstanding Balance", "Outstanding Interest");
    //                     if LoansRegister."Outstanding Interest" > 0 then begin
    //                         IntAmount := 0;
    //                         if LoansRegister."Outstanding Interest" > RunBal then
    //                             IntAmount := RunBal
    //                         else
    //                             IntAmount := LoansRegister."Outstanding Interest";
    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
    //                         GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", Today, IntAmount * -1, 'FOSA', DOCUMENT_NO,
    //                          'Funds Transfer' + ' ' + SavAccount."No.", LoansRegister."Loan  No.");
    //                         RunBal := RunBal - IntAmount;
    //                     end;

    //                     if LoansRegister."Outstanding Balance" > 0 then begin
    //                         PrincipleAMount := 0;
    //                         if RunBal > LoansRegister."Outstanding Balance" then
    //                             PrincipleAMount := LoansRegister."Outstanding Balance"
    //                         else
    //                             PrincipleAMount := RunBal;
    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
    //                         GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", Today, PrincipleAMount * -1, 'FOSA', DOCUMENT_NO,
    //                          'Funds Transfer' + ' ' + SavAccount."No.", LoansRegister."Loan  No.");
    //                         RunBal := RunBal - PrincipleAMount;
    //                     end;


    //                     if RunBal > 0 then begin
    //                         SavAccount.Reset();
    //                         SavAccount.SetRange(SavAccount."BOSA Account No", LoansRegister."Client Code");
    //                         SavAccount.SetRange(SavAccount."Account Type", 'CURRENT');
    //                         IF SavAccount.FindFirst() then BEGIN
    //                             LineNo := LineNo + 10000;
    //                             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
    //                             GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", Today, RunBal * -1, 'FOSA', DOCUMENT_NO,
    //                              'Funds Transfer Excess' + ' ' + SavAccount."No.", '');
    //                         END;
    //                     end;
    //                 end;
    //             end;
    //             //Post
    //             GenJournalLine.Reset;
    //             GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //             GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //             if GenJournalLine.Find('-') then begin
    //                 Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //             end;


    //             DataJson.Add('transaction_reference', SourceReference);
    //             DataJson.Add('transaction_status', 'SUCCESS');
    //             DataJson.Add('transaction_status_description', 'Transfer posted successfully');

    //             ResponseJson.Add(Data, DataJson);
    //             //end else
    //             //SetResponseStatus(ResponseJson, 'error', 'Error', 'Destination Account does not exist');
    //         end else
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'Insufficient balance');

    //     end else
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'Source account does not match identifier');


    // end;

    // // ------------------------------------------------------------------------------------------------
    // local procedure PESAINConfirmation(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     OriginatorID: Text;
    //     PesaType: Text;
    //     TransactionAction: Text;
    //     Command: Text;
    //     Sensitivity: Text;
    //     Charge: Decimal;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     BOSA: Record Customer;
    //     TransactionInitiatorIdentifierType: Text;
    //     TransactionInitiatorIdentifier: Text;
    //     TransactionInitiatorAccount: Text;
    //     TransactionInitiatorName: Text;
    //     TransactionInitiatorReference: Text;
    //     TransactionSourceIdentifierType: Text;
    //     TransactionSourceIdentifier: Text;
    //     TransactionSourceAccount: Text;
    //     TransactionSourceName: Text;
    //     TransactionSourceReference: Text;
    //     TransactionSenderIdentifierType: Text;
    //     TransactionSenderIdentifier: Text;
    //     TransactionSenderAccount: Text;
    //     TransactionSenderName: Text;
    //     TransactionSenderReference: Text;
    //     TransactionReceiverIdentifierType: Text;
    //     TransactionReceiverIdentifier: Text;
    //     TransactionReceiverAccount: Text;
    //     TransactionReceiverName: Text;
    //     TransactionBeneficiaryIdentifierType: Text;
    //     TransactionBeneficiaryIdentifier: Text;
    //     TransactionBeneficiaryAccount: Text;
    //     TransactionBeneficiaryName: Text;
    //     Amount: Decimal;
    //     TransactionDescription: Text;
    //     SourceReference: Text;
    //     RequestApplication: Text;
    //     SourceApplication: Text;
    //     TransactionDateTime: Text;
    //     Vendor: Record Vendor;
    //     Customer: Record Customer;
    //     LoanRegister: Record "Loans Register";
    //     GenJournalLine: Record "Gen. Journal Line";
    //     Found: boolean;
    //     Members: Record Customer;
    //     smsManagement: Codeunit "Sms Management";
    //     CreationMessage: Text[2500];
    //     ChargeAmount: Decimal;
    //     GraduatedCharge: Record "MPESA  Deposits";
    //     MpesaComm: Decimal;
    //     SaccoCommission: Decimal;
    //     VendorComm: Decimal;
    //     ExciseDuty: Decimal;
    //     TotalAmount: Decimal;
    //     VendorCommAccount: Code[20];
    //     ExciseDutyAccount: Code[20];
    //     TotalAmountAccount: Code[20];
    //     SaccoCommissionAccount: Code[20];
    //     MpesaCommAccount: Code[20];
    //     SaccoGen: Record "Sacco General Set-Up";
    //     NetCharges: Decimal;
    //     MBuffer: Record "Mpesa Withdawal Buffer";
    //     PendingAmount: Decimal;
    //     AccountTypes: Record "Account Types-Saving Products";
    //     AvailableBalance: Decimal;
    //     PaybillTransactions: Record "Paybill Transactions";
    //     AuPaybillAutomations: Codeunit "AU Paybill Automations";
    //     PercentageGra: Decimal;
    //     Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
    // begin
    //     OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
    //     PesaType := SelectJsonToken(RequestJson, '$.pesa_type').AsValue.AsText;
    //     TransactionAction := SelectJsonToken(RequestJson, '$.action').AsValue.AsText;
    //     Command := SelectJsonToken(RequestJson, '$.command').AsValue.AsText;
    //     Sensitivity := SelectJsonToken(RequestJson, '$.sensitivity').AsValue.AsText;
    //     Charge := SelectJsonToken(RequestJson, '$.charge').AsValue.AsDecimal;
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

    //     TransactionInitiatorIdentifierType := SelectJsonToken(RequestJson, '$.transaction_initiator_details.identifier_type').AsValue.AsText;
    //     TransactionInitiatorIdentifier := SelectJsonToken(RequestJson, '$.transaction_initiator_details.identifier').AsValue.AsText;
    //     TransactionInitiatorAccount := SelectJsonToken(RequestJson, '$.transaction_initiator_details.account').AsValue.AsText;
    //     TransactionInitiatorName := SelectJsonToken(RequestJson, '$.transaction_initiator_details.name').AsValue.AsText;
    //     TransactionInitiatorReference := SelectJsonToken(RequestJson, '$.transaction_initiator_details.reference').AsValue.AsText;

    //     TransactionSourceIdentifierType := SelectJsonToken(RequestJson, '$.transaction_source_details.identifier_type').AsValue.AsText;
    //     TransactionSourceIdentifier := SelectJsonToken(RequestJson, '$.transaction_source_details.identifier').AsValue.AsText;
    //     TransactionSourceAccount := SelectJsonToken(RequestJson, '$.transaction_source_details.account').AsValue.AsText;
    //     TransactionSourceName := SelectJsonToken(RequestJson, '$.transaction_source_details.name').AsValue.AsText;
    //     TransactionSourceReference := SelectJsonToken(RequestJson, '$.transaction_source_details.reference').AsValue.AsText;

    //     TransactionSenderIdentifierType := SelectJsonToken(RequestJson, '$.transaction_sender_details.identifier_type').AsValue.AsText;
    //     TransactionSenderIdentifier := SelectJsonToken(RequestJson, '$.transaction_sender_details.identifier').AsValue.AsText;
    //     TransactionSenderAccount := SelectJsonToken(RequestJson, '$.transaction_sender_details.account').AsValue.AsText;
    //     TransactionSenderName := SelectJsonToken(RequestJson, '$.transaction_sender_details.name').AsValue.AsText;
    //     TransactionSenderReference := SelectJsonToken(RequestJson, '$.transaction_sender_details.reference').AsValue.AsText;

    //     TransactionReceiverIdentifierType := SelectJsonToken(RequestJson, '$.transaction_receiver_details.identifier_type').AsValue.AsText;
    //     TransactionReceiverIdentifier := SelectJsonToken(RequestJson, '$.transaction_receiver_details.identifier').AsValue.AsText;
    //     TransactionReceiverAccount := SelectJsonToken(RequestJson, '$.transaction_receiver_details.account').AsValue.AsText;
    //     TransactionReceiverName := SelectJsonToken(RequestJson, '$.transaction_receiver_details.name').AsValue.AsText;

    //     TransactionBeneficiaryIdentifierType := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier_type').AsValue.AsText;
    //     TransactionBeneficiaryIdentifier := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier').AsValue.AsText;
    //     TransactionBeneficiaryAccount := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.account').AsValue.AsText;
    //     TransactionBeneficiaryName := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.name').AsValue.AsText;

    //     Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
    //     TransactionDescription := SelectJsonToken(RequestJson, '$.transaction_description').AsValue.AsText;
    //     SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
    //     RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
    //     SourceApplication := SelectJsonToken(RequestJson, '$.source_application').AsValue.AsText;
    //     TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;



    //     BATCH_TEMPLATE := 'GENERAL';
    //     BATCH_NAME := 'MOBILE';
    //     Found := false;
    //     GenJournalLine.Reset();
    //     GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
    //     GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
    //     if GenJournalLine.FindSet() then begin
    //         GenJournalLine.DeleteAll();
    //     end;

    //     MPESATRANS.Reset();
    //     MPESATRANS.SetRange(MPESATRANS."Account No", TransactionBeneficiaryIdentifier);
    //     MPESATRANS.SetRange("Document No", OriginatorID);
    //     if MPESATRANS.Find('-') = false then begin
    //         Customer.Reset();
    //         Customer.SetRange("Mobile Phone No", Identifier);
    //         if Customer.FindFirst() then begin

    //             LoanRegister.Reset();
    //             LoansRegister.SetRange("Client Code", Customer."No.");
    //             LoanRegister.SetRange("Loan  No.", TransactionReceiverAccount);//TransactionReceiverAccount,
    //             if LoanRegister.Find('-') then begin
    //                 MPESATRANS.Init;
    //                 MPESATRANS."Document No" := OriginatorID;
    //                 MPESATRANS.Trace := TransactionBeneficiaryName;
    //                 MPESATRANS.Description := TransactionBeneficiaryIdentifier;
    //                 MPESATRANS.Telephone := Identifier;
    //                 MPESATRANS.Amount := Amount;
    //                 MPESATRANS."Transaction Type" := 'Loan Repayment';
    //                 MPESATRANS."Document Date" := Today;
    //                 MPESATRANS."Transaction Date Time" := Format(CurrentDateTime);
    //                 MPESATRANS.Posted := false;
    //                 MPESATRANS."Transaction Category" := TransactionBeneficiaryIdentifier;
    //                 MPESATRANS.LoanNo := TransactionReceiverAccount;
    //                 MPESATRANS.Insert;



    //                 BATCH_TEMPLATE := 'GENERAL';
    //                 BATCH_NAME := 'MOBILE';
    //                 DOCUMENT_NO := OriginatorID;

    //                 ChargeAmount := 0;

    //                 GraduatedCharge.Reset;
    //                 if GraduatedCharge.Find('-') then begin
    //                     repeat
    //                         if (Amount >= GraduatedCharge."Min Band") and (Amount <= GraduatedCharge."Upper Band") then begin

    //                             if GraduatedCharge."Use Percentage" = true then begin
    //                                 PercentageGra := 0;
    //                                 Evaluate(PercentageGra, GraduatedCharge.Percentage);
    //                                 VendorComm := 0;
    //                                 ChargeAmount := 0;
    //                                 ExciseDuty := 0;
    //                                 MpesaComm := 0;
    //                                 TotalAmount := 0;
    //                                 ChargeAmount := GraduatedCharge.Total;
    //                                 VendorComm := Amount * PercentageGra / 100;
    //                                 SaccoCommission := GraduatedCharge."Sacco Comm";
    //                                 MpesaComm := GraduatedCharge.Mpesa;
    //                                 ExciseDuty := GraduatedCharge."Excise Duty";
    //                                 TotalAmount := GraduatedCharge."Sacco Comm" + VendorComm;
    //                                 MpesaCommAccount := GraduatedCharge."Mpesa Account";
    //                                 VendorCommAccount := GraduatedCharge."Vendor Comm G/L";
    //                                 SaccoCommissionAccount := GraduatedCharge."Sacco Comm G/L";
    //                             end else begin
    //                                 VendorComm := 0;
    //                                 ChargeAmount := 0;
    //                                 ExciseDuty := 0;
    //                                 MpesaComm := 0;
    //                                 TotalAmount := 0;
    //                                 ChargeAmount := GraduatedCharge.Total;
    //                                 VendorComm := GraduatedCharge."Vendor Comm";
    //                                 SaccoCommission := GraduatedCharge."Sacco Comm";
    //                                 MpesaComm := GraduatedCharge.Mpesa;
    //                                 ExciseDuty := GraduatedCharge."Excise Duty";
    //                                 TotalAmount := GraduatedCharge.Total;
    //                                 MpesaCommAccount := GraduatedCharge."Mpesa Account";
    //                                 VendorCommAccount := GraduatedCharge."Vendor Comm G/L";
    //                                 SaccoCommissionAccount := GraduatedCharge."Sacco Comm G/L";
    //                             end;
    //                         end;
    //                     until GraduatedCharge.Next = 0;
    //                     NetCharges := 0;
    //                     NetCharges := Amount - TotalAmount;
    //                 end;

    //                 //Balancing Account
    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::"Bank Account", 'BNK00010', Today, Amount, 'FOSA', DOCUMENT_NO,
    //                  'Mobile Trans Pesa In' + ' ' + Customer."No.", '');

    //                 //Balancing Account
    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", Today, -Amount, 'FOSA', DOCUMENT_NO,
    //                  'Mobile Trans Pesa In' + ' ' + Customer."No.", '');

    //                 Vendor.Reset();
    //                 Vendor.SetRange(Vendor."No.", Customer."FOSA Account No.");
    //                 if Vendor.FindFirst() then begin
    //                     Vendor.CalcFields(Vendor.Balance);
    //                     MBuffer.Reset();
    //                     MBuffer.SetRange(MBuffer."Vendor No", Customer."FOSA Account No.");
    //                     MBuffer.SetRange(MBuffer.Posted, false);
    //                     MBuffer.SetRange(MBuffer.Reversed, false);
    //                     if MBuffer.FindSet() then begin
    //                         MBuffer.CalcSums(MBuffer."Amount Requested");
    //                         PendingAmount := MBuffer."Amount Requested";
    //                     end;
    //                     AvailableBalance := 0;
    //                     AvailableBalance := Vendor.Balance - ((Vendor."Uncleared Cheques" - Vendor."Cheque Discounted Amount") + PendingAmount + Vendor."ATM Transactions" + Vendor."EFT Transactions" + 1000 + Vendor."Mobile Transactions" + Vendor."Amount to freeze");
    //                 end;

    //                 if AvailableBalance < TotalAmount then begin
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", Today, NetCharges, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Loan Repayment' + ' ' + Customer."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
    //                     GenJournalLine."Account Type"::Customer, Customer."No.", Today, NetCharges * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Loan Repayment' + ' ' + Customer."No.", transactionReceiverAccount);
    //                 end;
    //                 if AvailableBalance >= TotalAmount then begin
    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                     GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", Today, Amount, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Loan Repayment' + ' ' + Customer."No.", '');

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
    //                     GenJournalLine."Account Type"::Customer, Customer."No.", Today, Amount * -1, 'FOSA', DOCUMENT_NO,
    //                      'Mobile Loan Repayment' + ' ' + Customer."No.", transactionReceiverAccount);
    //                 end;

    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", Today, TotalAmount, 'FOSA', DOCUMENT_NO,
    //                  'Mobile Deposit Charges' + ' ' + Customer."No.", '');

    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, VendorCommAccount, Today, VendorComm * -1, 'FOSA', DOCUMENT_NO,
    //                  'Vendor Commission' + ' ' + Customer."No.", '');

    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, Today, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
    //                  'Sacco Commission' + ' ' + Customer."No.", '');

    //                 //Post
    //                 GenJournalLine.Reset;
    //                 GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //                 GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //                 if GenJournalLine.Find('-') then begin
    //                     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //                 end;

    //                 //response
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                 DataJson.Add('transaction_reference', '53f4bf31-79fa-40cb-b935-06792911d5b3');
    //                 DataJson.Add('transaction_status', 'SUCCESS');
    //                 DataJson.Add('transaction_status_description', 'Loan Repayment processed successfully');
    //                 DataJson.Add('transaction_date_time', CurrentDateTime);
    //                 Found := true;
    //             end;

    //             Vendor.Reset();
    //             Vendor.SetRange("BOSA Account No", Customer."No.");
    //             Vendor.SetRange("No.", TransactionReceiverAccount);
    //             if Vendor.FindFirst() then begin
    //                 AccountTypes.Get(Vendor."Account Type");
    //                 MPESATRANS.Init;
    //                 MPESATRANS."Document No" := OriginatorID;
    //                 MPESATRANS.Trace := TransactionBeneficiaryName;
    //                 MPESATRANS.Description := TransactionBeneficiaryIdentifier;
    //                 MPESATRANS.Telephone := Identifier;
    //                 MPESATRANS.Amount := BufferTable."Amount Requested";
    //                 MPESATRANS."Account No" := TransactionInitiatorAccount;
    //                 MPESATRANS."Account Name" := Customer.Name;
    //                 MPESATRANS."Transaction Type" := 'Savings Deposit';
    //                 MPESATRANS."Document Date" := Today;
    //                 MPESATRANS."Transaction Date Time" := Format(CurrentDateTime);
    //                 MPESATRANS.Posted := false;
    //                 MPESATRANS."Transaction Category" := TransactionBeneficiaryIdentifier;
    //                 MPESATRANS.LoanNo := TransactionReceiverAccount;
    //                 MPESATRANS.Insert;
    //                 BATCH_TEMPLATE := 'GENERAL';
    //                 BATCH_NAME := 'MOBILE';
    //                 DOCUMENT_NO := TransactionSenderReference;


    //                 ChargeAmount := 0;

    //                 GraduatedCharge.Reset;
    //                 if GraduatedCharge.Find('-') then begin
    //                     repeat
    //                         if (Amount >= GraduatedCharge."Min Band") and (Amount <= GraduatedCharge."Upper Band") then begin
    //                             if GraduatedCharge."Use Percentage" = true then begin
    //                                 PercentageGra := 0;
    //                                 Evaluate(PercentageGra, GraduatedCharge.Percentage);
    //                                 VendorComm := 0;
    //                                 ChargeAmount := 0;
    //                                 ExciseDuty := 0;
    //                                 MpesaComm := 0;
    //                                 TotalAmount := 0;
    //                                 ChargeAmount := GraduatedCharge.Total;
    //                                 VendorComm := Amount * PercentageGra / 100;
    //                                 SaccoCommission := GraduatedCharge."Sacco Comm";
    //                                 MpesaComm := GraduatedCharge.Mpesa;
    //                                 ExciseDuty := GraduatedCharge."Excise Duty";
    //                                 TotalAmount := GraduatedCharge."Sacco Comm" + VendorComm;
    //                                 MpesaCommAccount := GraduatedCharge."Mpesa Account";
    //                                 VendorCommAccount := GraduatedCharge."Vendor Comm G/L";
    //                                 SaccoCommissionAccount := GraduatedCharge."Sacco Comm G/L";
    //                             end else begin
    //                                 VendorComm := 0;
    //                                 ChargeAmount := 0;
    //                                 ExciseDuty := 0;
    //                                 MpesaComm := 0;
    //                                 TotalAmount := 0;
    //                                 ChargeAmount := GraduatedCharge.Total;
    //                                 VendorComm := GraduatedCharge."Vendor Comm";
    //                                 SaccoCommission := GraduatedCharge."Sacco Comm";
    //                                 MpesaComm := GraduatedCharge.Mpesa;
    //                                 ExciseDuty := GraduatedCharge."Excise Duty";
    //                                 TotalAmount := GraduatedCharge.Total;
    //                                 MpesaCommAccount := GraduatedCharge."Mpesa Account";
    //                                 VendorCommAccount := GraduatedCharge."Vendor Comm G/L";
    //                                 SaccoCommissionAccount := GraduatedCharge."Sacco Comm G/L";
    //                             end;
    //                         end;
    //                     until GraduatedCharge.Next = 0;
    //                     NetCharges := 0;
    //                     NetCharges := Amount - TotalAmount;
    //                 end;

    //                 /*                     BOSA.Reset();
    //                                     BOSA.SetRange(BOSA."No.", Vendor."BOSA Account No");
    //                                     if BOSA.FindFirst() then */

    //                 MBuffer.Reset();
    //                 MBuffer.SetRange(MBuffer."Vendor No", Customer."FOSA Account No.");
    //                 MBuffer.SetRange(MBuffer.Posted, false);
    //                 MBuffer.SetRange(MBuffer.Reversed, false);
    //                 if MBuffer.FindSet() then begin
    //                     MBuffer.CalcSums(MBuffer."Amount Requested");
    //                     PendingAmount := MBuffer."Amount Requested";
    //                 end;
    //                 Vendor.CalcFields(Vendor.Balance);
    //                 AvailableBalance := 0;
    //                 AvailableBalance := Vendor.Balance - ((Vendor."Uncleared Cheques" - Vendor."Cheque Discounted Amount") + PendingAmount + Vendor."ATM Transactions" + Vendor."EFT Transactions" + 1000 + Vendor."Mobile Transactions" + Vendor."Amount to freeze");
    //                 //Balancing Account
    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::"Bank Account", 'BNK00010', Today, Amount, 'FOSA', DOCUMENT_NO,
    //                  'Mobile Trans Pesa In' + ' ' + Vendor."No.", '');

    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", Today, Amount * -1, 'FOSA', DOCUMENT_NO,
    //                  'Mobile Trans Pesa In' + ' ' + Vendor."No.", '');

    //                 if AvailableBalance < TotalAmount then begin

    //                     if Customer."FOSA Account No." <> TransactionReceiverAccount then begin
    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                         GenJournalLine."Account Type"::Vendor, TransactionReceiverAccount, Today, NetCharges * -1, 'FOSA', DOCUMENT_NO,
    //                          'Mobile Trans Pesa In' + ' ' + Vendor."No.", '');

    //                         //Balancing Account
    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                         GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", Today, NetCharges, 'FOSA', DOCUMENT_NO,
    //                          'Mobile Trans Pesa In' + ' ' + Vendor."No.", '');
    //                     end;
    //                 end;
    //                 if AvailableBalance >= TotalAmount then begin
    //                     if Customer."FOSA Account No." <> TransactionReceiverAccount then begin
    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                         GenJournalLine."Account Type"::Vendor, TransactionReceiverAccount, Today, Amount * -1, 'FOSA', DOCUMENT_NO,
    //                          'Mobile Trans Pesa In' + ' ' + Vendor."No.", '');

    //                         //Balancing Account
    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                         GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", Today, Amount, 'FOSA', DOCUMENT_NO,
    //                          'Mobile Trans Pesa In' + ' ' + Vendor."No.", '');
    //                     end;

    //                 end;
    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", Today, TotalAmount, 'FOSA', DOCUMENT_NO,
    //                  'Mobile Deposit Charges' + ' ' + Customer."No.", '');

    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, VendorCommAccount, Today, VendorComm * -1, 'FOSA', DOCUMENT_NO,
    //                  'Vendor Commission' + ' ' + Customer."No.", '');


    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, Today, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
    //                  'Sacco Commission' + ' ' + Customer."No.", '');

    //                 Members.Get(Vendor."BOSA Account No");
    //                 CreationMessage := 'Dear ' + BName.NameStyle(Members."No.") + ' , your Cash Deposit of Ksh ' + Format(Amount) + ' to ' + AccountTypes.Description + ' was posted successfully on ' + Format(Today) + ' at ' + Format(time);
    //                 smsManagement.SendSmsWithID(Source::DEPOSIT_CONFIRMATION, Customer."Mobile Phone No", CreationMessage, Customer."No.", Customer."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
    //                 //Post
    //                 GenJournalLine.Reset;
    //                 GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //                 GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //                 if GenJournalLine.Find('-') then begin
    //                     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

    //                 end;

    //                 //response
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //                 DataJson.Add('transaction_reference', '53f4bf31-79fa-40cb-b935-06792911d5b3');
    //                 DataJson.Add('transaction_status', 'SUCCESS');
    //                 DataJson.Add('transaction_status_description', 'Savings Deposits processed successfully');
    //                 DataJson.Add('transaction_date_time', CurrentDateTime);
    //                 Found := true;
    //             end;

    //         end;
    //         if Found = true then begin
    //             ResponseJson.Add(Data, DataJson);
    //         end;
    //         if Found = false then begin
    //             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //             PaybillTransactions.Reset();
    //             PaybillTransactions.SetRange(PaybillTransactions.TransID, OriginatorID);
    //             if not PaybillTransactions.FindFirst() then begin
    //                 DataJson.Add('transaction_reference', OriginatorID);
    //                 DataJson.Add('transaction_status', 'SUCCESS');
    //                 DataJson.Add('transaction_status_description', 'Transaction Successful');
    //                 DataJson.Add('transaction_date_time', CurrentDateTime);
    //                 AuPaybillAutomations.FnInsertPaybillTransactions(OriginatorID, '', Amount, TransactionReceiverIdentifier, TransactionReceiverAccount, '', 0,
    //                  '', TransactionInitiatorIdentifier, TransactionInitiatorName, '', '', '');
    //             end ELSE begin
    //                 DataJson.Add('transaction_reference', OriginatorID);
    //                 DataJson.Add('transaction_status', 'DUPLICATE');
    //                 DataJson.Add('transaction_status_description', 'Duplicate Transaction');
    //                 DataJson.Add('transaction_date_time', CurrentDateTime);
    //             end;
    //             ResponseJson.Add(Data, DataJson);
    //         end;
    //     end
    //     else begin
    //         MPESATRANS.Reset();
    //         MPESATRANS.SetRange(Description, TransactionBeneficiaryIdentifier);
    //         MPESATRANS.SetRange("Document No", OriginatorID);
    //         if MPESATRANS.Find('-') then begin
    //             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //             DataJson.Add('transaction_reference', '53f4bf31-79fa-40cb-b935-06792911d5b3');
    //             DataJson.Add('transaction_status', 'DUPLICATE');
    //             DataJson.Add('transaction_status_description', 'Duplicate Transaction');
    //             DataJson.Add('transaction_date_time', CurrentDateTime);
    //         end;
    //         ResponseJson.Add(Data, DataJson);
    //     end;
    //     //response
    //     // SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //     // DataJson.Add('transaction_reference', '53f4bf31-79fa-40cb-b935-06792911d5b3');
    //     // DataJson.Add('transaction_status', 'SUCCESS');
    //     // DataJson.Add('transaction_status_description', 'Withdrawal processed successfully');
    //     // DataJson.Add('transaction_date_time', CurrentDateTime);

    // end;

    // // ------------------------------------------------------------------------------------------------
    // local procedure GetLoanTypes(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     LoanTypesArray: JsonArray;
    //     LoanTypesArray2: JsonArray;
    //     LoanTypeObject: JsonObject;
    //     LoanTypeObject2: JsonObject;
    //     Iterator: Integer;
    //     ProdFactory: Record "Loan Products Setup";
    //     ProdFactory2: Record "Loan Products Setup";
    //     Found: Boolean;
    //     SalDetails: record "Salary Details";
    //     Loans: Record "Loans Register";
    //     Members: Record Vendor;
    //     NetSalary: Decimal;
    //     Maxloan: Decimal;
    //     PayrollMonthlyTransactions: Record "prPeriod Transactions.";
    //     LoanDescription: Text[100];
    //     Cust: Record Customer;
    //     loanR: Record "Loans Register";
    //     PesaTele: Decimal;
    //     Msg: Text[250];
    // begin
    //     Found := false;
    //     Iterator := 0;

    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

    //     if IdentifierType = 'MSISDN' THEN BEGIN
    //         Members.Reset();
    //         Members.SetRange(Members."Mobile Phone No", Identifier);
    //         Members.SetFilter(Members."Account Type", '103');
    //         if Members.FindFirst() then begin
    //             Members.CalcFields(Members.Balance);

    //             ProdFactory.SetRange(ProdFactory."Is Mobile Loan?", true);
    //             ProdFactory.SetRange(ProdFactory."Mobile Application Source", true);
    //             if ProdFactory.FindFirst() then begin
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                 repeat
    //                     LoanDescription := '';
    //                     Maxloan := 0;
    //                     //Maxloan := GetGrossSalary(Members."No.", ProdFactory.Code);
    //                     Maxloan := FnGetMobileAdvanceEligibility(Members."No.", ProdFactory.Code, ProdFactory."Product Description", ProdFactory."Max. Loan Amount");
    //                     LoanTypeObject.Add('loan_type_id', ProdFactory.Code);
    //                     LoanTypeObject.Add('loan_type_name', Format(ProdFactory."Product Description"));
    //                     LoanTypeObject.Add('loan_type_min_amount', ProdFactory."Min. Loan Amount");
    //                     LoanTypeObject.Add('loan_type_description', LoanDescription);
    //                     LoanTypeObject.Add('loan_type_status', FnCheckMemberStatus(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_age', FnCheckMemberAge(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_shares', FnCheckMemberShares(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_default_status', FnCheckLoanDefault(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_max_amount', Maxloan);
    //                     LoanTypeObject.Add('loan_type_interest_rate', ProdFactory."Interest rate");
    //                     LoanTypeObject.Add('loan_type_min_instalments', 1);
    //                     LoanTypeObject.Add('loan_type_max_instalments', ProdFactory."Default Installements");
    //                     LoanTypeObject.Add('Installation_type', 'INPUT/NONE');
    //                     if ProdFactory."Min No. Of Guarantors" > 0 then begin
    //                         LoanTypeObject2.Add('required_guarantors', true);
    //                         LoanTypeObject2.Add('minimum_guarantors', ProdFactory."Min No. Of Guarantors");
    //                         LoanTypeObject2.Add('maximum_guarantors', ProdFactory."Max No. Of Guarantor");
    //                         LoanTypeObject.Add('guarantors', LoanTypeObject2);

    //                     end else begin
    //                         LoanTypeObject2.Add('required_guarantors', false);
    //                         LoanTypeObject.Add('guarantors', LoanTypeObject2);
    //                         LoanTypeObject2.Add('minimum_guarantors', ProdFactory."Min No. Of Guarantors");
    //                         LoanTypeObject2.Add('maximum_guarantors', ProdFactory."Max No. Of Guarantor");
    //                     end;
    //                     LoanTypesArray.Add(LoanTypeObject);
    //                     Clear(LoanTypeObject2);
    //                     Clear(LoanTypeObject);
    //                 // end;
    //                 until ProdFactory.Next() = 0;
    //                 DataJson.Add('loan_types', LoanTypesArray);
    //                 Found := true;
    //             end;
    //         end else
    //             DataJson.Add('loan_types', LoanTypesArray);
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'Member number does not exists.');


    //     end;
    //     if IdentifierType = 'MEMBER_NUMBER' THEN BEGIN
    //         Members.Reset();
    //         Members.SetRange(Members."BOSA Account No", Identifier);
    //         Members.SetFilter(Members."Account Type", '103');
    //         if Members.Findlast() then begin
    //             Members.CalcFields(Members.Balance);

    //             ProdFactory.SetRange(ProdFactory."Is Mobile Loan?", true);
    //             ProdFactory.SetRange(ProdFactory."Mobile Application Source", true);

    //             if ProdFactory.FindFirst() then begin
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                 repeat
    //                     Maxloan := 0;
    //                     //Maxloan := GetGrossSalary(Members."No.", ProdFactory.Code);
    //                     if (ProdFactory.Code = 'A03') or (ProdFactory.Code = 'A16') then begin
    //                         Maxloan := FnGetMobileAdvanceEligibility(Members."No.", ProdFactory.Code, Msg, ProdFactory."Max. Loan Amount");
    //                     end;
    //                     if ProdFactory.Code = 'A01' then begin
    //                         Maxloan := GetSalaryLoanQualifiedAmount(Members."No.", ProdFactory.Code, ProdFactory."Max. Loan Amount", Msg)
    //                     end;
    //                     if ProdFactory.Code = 'M_OD' then begin
    //                         Maxloan := GetOverdraftLoanQualifiedAmount(Members."No.", ProdFactory.Code, ProdFactory."Max. Loan Amount", Msg)
    //                     end;
    //                     if ProdFactory.Code = 'A10' then begin
    //                         Maxloan := GetReloadedLoanQualifiedAmount(Members."No.", ProdFactory.Code, ProdFactory."Max. Loan Amount", Msg)
    //                     end;


    //                     // Loans.Reset();
    //                     // Loans.SetRange(Loans."Client Code", Members."BOSA Account No");
    //                     // //Loans.SetAutoCalcFields(Loans."Outstanding Balance");
    //                     // Loans.SetRange(Loans."Loan Product Type", ProdFactory.Code);
    //                     // //Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
    //                     // if not Loans.FindFirst() then begin
    //                     LoanTypeObject.Add('loan_type_id', ProdFactory.Code);
    //                     LoanTypeObject.Add('loan_type_name', Format(ProdFactory."Product Description"));
    //                     LoanTypeObject.Add('loan_type_min_amount', ProdFactory."Min. Loan Amount");
    //                     LoanTypeObject.Add('loan_type_status', FnCheckMemberStatus(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_age', FnCheckMemberAge(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_shares', FnCheckMemberShares(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_default_status', FnCheckLoanDefault(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_max_amount', Maxloan);
    //                     LoanTypeObject.Add('loan_type_description', FnCheckLoanIfExisting(Members."BOSA Account No", ProdFactory.Code));
    //                     LoanTypeObject.Add('loan_type_interest_rate', ProdFactory."Interest rate");
    //                     LoanTypeObject.Add('loan_type_min_instalments', 1);
    //                     LoanTypeObject.Add('loan_type_max_instalments', ProdFactory."Default Installements");
    //                     LoanTypeObject.Add('Installation_type', 'INPUT/NONE');
    //                     if ProdFactory."Min No. Of Guarantors" > 0 then begin
    //                         LoanTypeObject2.Add('required_guarantors', true);
    //                         LoanTypeObject2.Add('minimum_guarantors', ProdFactory."Min No. Of Guarantors");
    //                         LoanTypeObject2.Add('maximum_guarantors', ProdFactory."Max No. Of Guarantor");
    //                         LoanTypeObject.Add('guarantors', LoanTypeObject2);

    //                     end else begin
    //                         LoanTypeObject2.Add('required_guarantors', false);
    //                         LoanTypeObject.Add('guarantors', LoanTypeObject2);
    //                         LoanTypeObject2.Add('minimum_guarantors', ProdFactory."Min No. Of Guarantors");
    //                         LoanTypeObject2.Add('maximum_guarantors', ProdFactory."Max No. Of Guarantor");
    //                     end;
    //                     LoanTypesArray.Add(LoanTypeObject);
    //                     Clear(LoanTypeObject2);
    //                     Clear(LoanTypeObject);
    //                 //end;
    //                 until ProdFactory.Next() = 0;
    //                 DataJson.Add('loan_types', LoanTypesArray);
    //                 Found := true;
    //             end;
    //         end else
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'Member number does not exists.');
    //     END;

    //     if Found = false then begin
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'No product exists');
    //     end;

    //     ResponseJson.Add(Data, DataJson);
    // end;


    local procedure GetLoanTypesPortal(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        LoanTypesArray: JsonArray;
        LoanTypesArray2: JsonArray;
        LoanTypeObject: JsonObject;
        LoanTypeObject2: JsonObject;
        Iterator: Integer;
        ProdFactory: Record "Loan Products Setup";
        ProdFactory2: Record "Loan Products Setup";
        Found: Boolean;
        SalDetails: record "Loan Appraisal Salary Details";
        Loans: Record "Loans Register";
        Members: Record Customer;
        NetSalary: Decimal;
        Maxloan: Decimal;
        PayrollMonthlyTransactions: Record "prPeriod Transactions.";
        LoanDescription: Text[100];
        Cust: Record Customer;
        loanR: Record "Loans Register";
        PesaTele: Decimal;
        Msg: Text[250];
        Insider: Record "Sacco Insiders";
        NormalMember: Boolean;
        Director: Boolean;
        Staff: Boolean;
    begin
        Found := false;
        Iterator := 0;

        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        Staff := false;
        Director := false;
        NormalMember := false;
        if IdentifierType = 'MSISDN' THEN BEGIN
            Members.Reset();
            Members.SetRange(Members."Mobile Phone No", Identifier);
            if Members.FindFirst() then begin
                Members.CalcFields(Members.Balance);
                Insider.Reset();
                Insider.SetRange(Insider.MemberNo, Members."No.");
                if Insider.FindFirst() then begin
                    if Insider."Position in society" = Insider."Position in society"::Staff then begin
                        Staff := true;
                    end;
                    if Insider."Position in society" = Insider."Position in society"::Board then begin
                        Director := true;
                    end;
                end else begin
                    NormalMember := true;
                end;

                if NormalMember = true then begin
                    ProdFactory.Reset();
                    // ProdFactory.SetFilter(ProdFactory."Member Category", '%1', ProdFactory."Member Category"::"All Members");
                    // ProdFactory.SetRange(ProdFactory.InActive,false);
                    if ProdFactory.FindFirst() then begin
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'SACCO loan types list has been fetched successfully');
                        repeat
                            LoanDescription := '';
                            Maxloan := 0;

                            LoanTypeObject.Add('loan_code', ProdFactory.Code);
                            LoanTypeObject.Add('product_name', Format(ProdFactory."Product Description"));
                            LoanTypeObject.Add('minimum_guarantors', ProdFactory."Min No. Of Guarantors");
                            LoanTypeObject.Add('source', Format(ProdFactory.Source));
                            LoanTypeObject.Add('maximum_amount', ProdFactory."Max. Loan Amount");
                            LoanTypeObject.Add('minimum_amount', ProdFactory."Min. Loan Amount");
                            LoanTypesArray.Add(LoanTypeObject);
                            Clear(LoanTypeObject);
                        until ProdFactory.Next() = 0;
                        Found := true;
                    end;
                end;

                if Director = true then begin
                    ProdFactory.Reset();
                    // ProdFactory.SetFilter(ProdFactory."Member Category", '%1|%2', ProdFactory."Member Category"::"All Members", ProdFactory."Member Category"::Board);
                    //  ProdFactory.SetRange(ProdFactory.InActive,false);
                    if ProdFactory.FindFirst() then begin
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'SACCO loan types list has been fetched successfully');
                        repeat
                            LoanDescription := '';
                            Maxloan := 0;

                            LoanTypeObject.Add('loan_code', ProdFactory.Code);
                            LoanTypeObject.Add('product_name', Format(ProdFactory."Product Description"));
                            LoanTypeObject.Add('minimum_guarantors', ProdFactory."Min No. Of Guarantors");
                            LoanTypeObject.Add('source', Format(ProdFactory.Source));
                            LoanTypeObject.Add('maximum_amount', ProdFactory."Max. Loan Amount");
                            LoanTypeObject.Add('minimum_amount', ProdFactory."Min. Loan Amount");
                            LoanTypesArray.Add(LoanTypeObject);
                            Clear(LoanTypeObject);
                        until ProdFactory.Next() = 0;
                        Found := true;
                    end;
                end;

                if Staff = true then begin
                    ProdFactory.Reset();
                    // ProdFactory.SetFilter(ProdFactory."Member Category", '%1|%2', ProdFactory."Member Category"::"All Members", ProdFactory."Member Category"::Staff);
                    //  ProdFactory.SetRange(ProdFactory.InActive,false);
                    if ProdFactory.FindFirst() then begin
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'SACCO loan types list has been fetched successfully');
                        repeat
                            LoanDescription := '';
                            Maxloan := 0;

                            LoanTypeObject.Add('loan_code', ProdFactory.Code);
                            LoanTypeObject.Add('product_name', Format(ProdFactory."Product Description"));
                            LoanTypeObject.Add('minimum_guarantors', ProdFactory."Min No. Of Guarantors");
                            LoanTypeObject.Add('source', Format(ProdFactory.Source));
                            LoanTypeObject.Add('maximum_amount', ProdFactory."Max. Loan Amount");
                            LoanTypeObject.Add('minimum_amount', ProdFactory."Min. Loan Amount");
                            LoanTypesArray.Add(LoanTypeObject);
                            Clear(LoanTypeObject);
                        until ProdFactory.Next() = 0;
                        Found := true;
                    end;
                end;


            end;


        end;


        ResponseJson.Add(Data, LoanTypesArray);
    end;

    // local procedure GetSpecificLoanTypesDetails(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     LoanTypesArray: JsonArray;
    //     LoanTypesArray2: JsonArray;
    //     LoanTypeObject: JsonObject;
    //     LoanTypeObject2: JsonObject;
    //     Iterator: Integer;
    //     ProdFactory: Record "Loan Products Setup";
    //     ProdFactory2: Record "Loan Products Setup";
    //     Found: Boolean;
    //     SalDetails: record "Salary Details";
    //     Loans: Record "Loans Register";
    //     Members: Record Vendor;
    //     NetSalary: Decimal;
    //     Maxloan: Decimal;
    //     PayrollMonthlyTransactions: Record "prPeriod Transactions.";
    //     LoanDescription: Text[100];
    //     Cust: Record Customer;
    //     loanR: Record "Loans Register";
    //     PesaTele: Decimal;
    //     Msg: Text[250];
    //     LoanType: Text;
    // begin
    //     Found := false;
    //     Iterator := 0;

    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     LoanType := SelectJsonToken(RequestJson, '$.loan_type').AsValue.AsText;


    //     if IdentifierType = 'MEMBER_NUMBER' THEN BEGIN
    //         Members.Reset();
    //         Members.SetRange(Members."BOSA Account No", Identifier);
    //         Members.SetFilter(Members."Account Type", '103');
    //         if Members.Findlast() then begin
    //             Members.CalcFields(Members.Balance);

    //             ProdFactory.SetRange(ProdFactory."Is Mobile Loan?", true);
    //             ProdFactory.SetRange(ProdFactory."Mobile Application Source", true);
    //             ProdFactory.SetRange(ProdFactory.Code, LoanType);

    //             if ProdFactory.FindFirst() then begin
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                 repeat
    //                     Maxloan := 0;
    //                     //Maxloan := GetGrossSalary(Members."No.", ProdFactory.Code);
    //                     if (ProdFactory.Code = 'A03') or (ProdFactory.Code = 'A16') then begin
    //                         Maxloan := FnGetMobileAdvanceEligibility(Members."No.", ProdFactory.Code, Msg, ProdFactory."Max. Loan Amount");
    //                     end;
    //                     if ProdFactory.Code = 'A01' then begin
    //                         Maxloan := GetSalaryLoanQualifiedAmount(Members."No.", ProdFactory.Code, ProdFactory."Max. Loan Amount", Msg)
    //                     end;
    //                     if ProdFactory.Code = 'M_OD' then begin
    //                         Maxloan := GetOverdraftLoanQualifiedAmount(Members."No.", ProdFactory.Code, ProdFactory."Max. Loan Amount", Msg)
    //                     end;
    //                     if ProdFactory.Code = 'A10' then begin
    //                         Maxloan := GetReloadedLoanQualifiedAmount(Members."No.", ProdFactory.Code, ProdFactory."Max. Loan Amount", Msg)
    //                     end;


    //                     // Loans.Reset();
    //                     // Loans.SetRange(Loans."Client Code", Members."BOSA Account No");
    //                     // //Loans.SetAutoCalcFields(Loans."Outstanding Balance");
    //                     // Loans.SetRange(Loans."Loan Product Type", ProdFactory.Code);
    //                     // //Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
    //                     // if not Loans.FindFirst() then begin
    //                     LoanTypeObject.Add('loan_type_id', ProdFactory.Code);
    //                     LoanTypeObject.Add('loan_type_name', Format(ProdFactory."Product Description"));
    //                     LoanTypeObject.Add('loan_type_min_amount', ProdFactory."Min. Loan Amount");
    //                     LoanTypeObject.Add('loan_type_status', FnCheckMemberStatus(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_age', FnCheckMemberAge(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_shares', FnCheckMemberShares(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_default_status', FnCheckLoanDefault(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_max_amount', Maxloan);
    //                     LoanTypeObject.Add('loan_type_description', FnCheckLoanIfExisting(Members."BOSA Account No", ProdFactory.Code));
    //                     LoanTypeObject.Add('loan_type_interest_rate', ProdFactory."Interest rate");
    //                     LoanTypeObject.Add('loan_type_min_instalments', 1);
    //                     LoanTypeObject.Add('loan_type_max_instalments', ProdFactory."Default Installements");
    //                     LoanTypeObject.Add('Installation_type', 'INPUT/NONE');
    //                     if ProdFactory."Min No. Of Guarantors" > 0 then begin
    //                         LoanTypeObject2.Add('required_guarantors', true);
    //                         LoanTypeObject2.Add('minimum_guarantors', ProdFactory."Min No. Of Guarantors");
    //                         LoanTypeObject2.Add('maximum_guarantors', ProdFactory."Max No. Of Guarantor");
    //                         LoanTypeObject.Add('guarantors', LoanTypeObject2);

    //                     end else begin
    //                         LoanTypeObject2.Add('required_guarantors', false);
    //                         LoanTypeObject.Add('guarantors', LoanTypeObject2);
    //                         LoanTypeObject2.Add('minimum_guarantors', ProdFactory."Min No. Of Guarantors");
    //                         LoanTypeObject2.Add('maximum_guarantors', ProdFactory."Max No. Of Guarantor");
    //                     end;
    //                     LoanTypesArray.Add(LoanTypeObject);
    //                     Clear(LoanTypeObject2);
    //                     Clear(LoanTypeObject);
    //                 //end;
    //                 until ProdFactory.Next() = 0;
    //                 DataJson.Add('loan_types', LoanTypesArray);
    //                 Found := true;
    //             end;
    //         end else
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'Member number does not exists.');
    //     END;

    //     if Found = false then begin
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'No product exists');
    //     end;

    //     ResponseJson.Add(Data, DataJson);
    // end;


    // local procedure GetLoanLimit(MemberNo: Code[40]; LoanType: Code[60]) Salary: Decimal
    // var
    //     DataJson: JsonObject;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     LoanTypesArray: JsonArray;
    //     LoanTypesArray2: JsonArray;
    //     LoanTypeObject: JsonObject;
    //     LoanTypeObject2: JsonObject;
    //     Iterator: Integer;
    //     ProdFactory: Record "Loan Products Setup";
    //     ProdFactory2: Record "Loan Products Setup";
    //     Found: Boolean;
    //     SalDetails: record "Salary Details";
    //     Loans: Record "Loans Register";
    //     Members: Record Vendor;
    //     NetSalary: Decimal;
    //     Maxloan: Decimal;
    //     PayrollMonthlyTransactions: Record "prPeriod Transactions.";
    //     LoanDescription: Text[100];
    //     Cust: Record Customer;
    //     loanR: Record "Loans Register";
    //     PesaTele: Decimal;
    //     Msg: Text[250];

    // begin


    //     Members.Reset();
    //     Members.SetRange(Members."BOSA Account No", MemberNo);
    //     Members.SetFilter(Members."Account Type", '103');
    //     if Members.Findlast() then begin
    //         Members.CalcFields(Members.Balance);
    //         ProdFactory.Reset();
    //         ProdFactory.SetRange(ProdFactory.Code, LoanType);
    //         if ProdFactory.FindFirst() then begin

    //             Maxloan := 0;
    //             //Maxloan := GetGrossSalary(Members."No.", ProdFactory.Code);
    //             if (ProdFactory.Code = 'A03') or (ProdFactory.Code = 'A16') then begin
    //                 Maxloan := FnGetMobileAdvanceEligibility(Members."No.", ProdFactory.Code, Msg, ProdFactory."Max. Loan Amount");
    //             end;
    //             if ProdFactory.Code = 'A01' then begin
    //                 Maxloan := GetSalaryLoanQualifiedAmount(Members."No.", ProdFactory.Code, ProdFactory."Max. Loan Amount", Msg)
    //             end;
    //             if ProdFactory.Code = 'M_OD' then begin
    //                 Maxloan := GetOverdraftLoanQualifiedAmount(Members."No.", ProdFactory.Code, ProdFactory."Max. Loan Amount", Msg)
    //             end;
    //             if ProdFactory.Code = 'A10' then begin
    //                 Maxloan := GetReloadedLoanQualifiedAmount(Members."No.", ProdFactory.Code, ProdFactory."Max. Loan Amount", Msg)
    //             end;
    //             Salary := Maxloan;

    //         end;
    //     end;
    // END;

    // local procedure GetLoanTypesUSSD(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     LoanTypesArray: JsonArray;
    //     LoanTypesArray2: JsonArray;
    //     LoanTypeObject: JsonObject;
    //     LoanTypeObject2: JsonObject;
    //     Iterator: Integer;
    //     ProdFactory: Record "Loan Products Setup";
    //     ProdFactory2: Record "Loan Products Setup";
    //     Found: Boolean;
    //     SalDetails: record "Salary Details";
    //     Loans: Record "Loans Register";
    //     Members: Record Vendor;
    //     NetSalary: Decimal;
    //     Maxloan: Decimal;
    //     PayrollMonthlyTransactions: Record "prPeriod Transactions.";
    //     LoanDescription: Text[100];
    //     Cust: Record Customer;
    //     loanR: Record "Loans Register";
    //     PesaTele: Decimal;
    //     Msg: Text[250];
    // begin
    //     Found := false;
    //     Iterator := 0;

    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

    //     if IdentifierType = 'MSISDN' THEN BEGIN
    //         Members.Reset();
    //         Members.SetRange(Members."Mobile Phone No", Identifier);
    //         Members.SetFilter(Members."Account Type", '103');
    //         if Members.FindFirst() then begin
    //             Members.CalcFields(Members.Balance);

    //             ProdFactory.SetRange(ProdFactory."Is Mobile Loan?", true);
    //             ProdFactory.SetRange(ProdFactory."Mobile Application Source", true);
    //             if ProdFactory.FindFirst() then begin
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                 repeat
    //                     LoanDescription := '';
    //                     Maxloan := 0;
    //                     //Maxloan := GetGrossSalary(Members."No.", ProdFactory.Code);
    //                     Maxloan := FnGetMobileAdvanceEligibility(Members."No.", ProdFactory.Code, ProdFactory."Product Description", ProdFactory."Max. Loan Amount");
    //                     LoanTypeObject.Add('loan_type_id', ProdFactory.Code);
    //                     LoanTypeObject.Add('loan_type_name', Format(ProdFactory."Product Description"));
    //                     // LoanTypeObject.Add('loan_type_min_amount', ProdFactory."Min. Loan Amount");
    //                     LoanTypeObject.Add('loan_type_description', LoanDescription);
    //                     LoanTypeObject.Add('loan_type_status', FnCheckMemberStatus(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_age', FnCheckMemberAge(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_shares', FnCheckMemberShares(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_default_status', FnCheckLoanDefault(Members."BOSA Account No"));
    //                     // LoanTypeObject.Add('loan_type_max_amount', Maxloan);
    //                     LoanTypeObject.Add('loan_type_interest_rate', ProdFactory."Interest rate");
    //                     LoanTypeObject.Add('loan_type_min_instalments', 1);
    //                     LoanTypeObject.Add('loan_type_max_instalments', ProdFactory."Default Installements");
    //                     LoanTypeObject.Add('Installation_type', 'INPUT/NONE');
    //                     if ProdFactory."Min No. Of Guarantors" > 0 then begin
    //                         LoanTypeObject2.Add('required_guarantors', true);
    //                         LoanTypeObject2.Add('minimum_guarantors', ProdFactory."Min No. Of Guarantors");
    //                         LoanTypeObject2.Add('maximum_guarantors', ProdFactory."Max No. Of Guarantor");
    //                         LoanTypeObject.Add('guarantors', LoanTypeObject2);

    //                     end else begin
    //                         LoanTypeObject2.Add('required_guarantors', false);
    //                         LoanTypeObject.Add('guarantors', LoanTypeObject2);
    //                         LoanTypeObject2.Add('minimum_guarantors', ProdFactory."Min No. Of Guarantors");
    //                         LoanTypeObject2.Add('maximum_guarantors', ProdFactory."Max No. Of Guarantor");
    //                     end;
    //                     LoanTypesArray.Add(LoanTypeObject);
    //                     Clear(LoanTypeObject2);
    //                     Clear(LoanTypeObject);
    //                 // end;
    //                 until ProdFactory.Next() = 0;
    //                 DataJson.Add('loan_types', LoanTypesArray);
    //                 Found := true;
    //             end;
    //         end else
    //             DataJson.Add('loan_types', LoanTypesArray);
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'Member number does not exists.');


    //     end;
    //     if IdentifierType = 'MEMBER_NUMBER' THEN BEGIN
    //         Members.Reset();
    //         Members.SetRange(Members."BOSA Account No", Identifier);
    //         Members.SetFilter(Members."Account Type", '103');
    //         if Members.Findlast() then begin
    //             Members.CalcFields(Members.Balance);

    //             ProdFactory.SetRange(ProdFactory."Is Mobile Loan?", true);
    //             ProdFactory.SetRange(ProdFactory."Mobile Application Source", true);

    //             if ProdFactory.FindFirst() then begin
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                 repeat
    //                     Maxloan := 0;
    //                     //Maxloan := GetGrossSalary(Members."No.", ProdFactory.Code);
    //                     if (ProdFactory.Code = 'A03') or (ProdFactory.Code = 'A16') then begin
    //                         //Maxloan := FnGetMobileAdvanceEligibility(Members."No.", ProdFactory.Code, Msg, ProdFactory."Max. Loan Amount");
    //                     end;
    //                     if ProdFactory.Code = 'A01' then begin
    //                         // Maxloan := GetSalaryLoanQualifiedAmount(Members."No.", ProdFactory.Code, ProdFactory."Max. Loan Amount", Msg)
    //                     end;
    //                     if ProdFactory.Code = 'M_OD' then begin
    //                         // Maxloan := GetOverdraftLoanQualifiedAmount(Members."No.", ProdFactory.Code, ProdFactory."Max. Loan Amount", Msg)
    //                     end;
    //                     if ProdFactory.Code = 'A10' then begin
    //                         // Maxloan := GetReloadedLoanQualifiedAmount(Members."No.", ProdFactory.Code, ProdFactory."Max. Loan Amount", Msg)
    //                     end;


    //                     // Loans.Reset();
    //                     // Loans.SetRange(Loans."Client Code", Members."BOSA Account No");
    //                     // //Loans.SetAutoCalcFields(Loans."Outstanding Balance");
    //                     // Loans.SetRange(Loans."Loan Product Type", ProdFactory.Code);
    //                     // //Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
    //                     // if not Loans.FindFirst() then begin
    //                     LoanTypeObject.Add('loan_type_id', ProdFactory.Code);
    //                     LoanTypeObject.Add('loan_type_name', Format(ProdFactory."Product Description"));
    //                     //LoanTypeObject.Add('loan_type_min_amount', ProdFactory."Min. Loan Amount");
    //                     LoanTypeObject.Add('loan_type_status', FnCheckMemberStatus(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_age', FnCheckMemberAge(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_shares', FnCheckMemberShares(Members."BOSA Account No"));
    //                     LoanTypeObject.Add('loan_type_default_status', FnCheckLoanDefault(Members."BOSA Account No"));
    //                     //LoanTypeObject.Add('loan_type_max_amount', Maxloan);
    //                     LoanTypeObject.Add('loan_type_description', FnCheckLoanIfExisting(Members."BOSA Account No", ProdFactory.Code));
    //                     LoanTypeObject.Add('loan_type_interest_rate', ProdFactory."Interest rate");
    //                     LoanTypeObject.Add('loan_type_min_instalments', 1);
    //                     LoanTypeObject.Add('loan_type_max_instalments', ProdFactory."Default Installements");
    //                     LoanTypeObject.Add('Installation_type', 'INPUT/NONE');
    //                     if ProdFactory."Min No. Of Guarantors" > 0 then begin
    //                         LoanTypeObject2.Add('required_guarantors', true);
    //                         LoanTypeObject2.Add('minimum_guarantors', ProdFactory."Min No. Of Guarantors");
    //                         LoanTypeObject2.Add('maximum_guarantors', ProdFactory."Max No. Of Guarantor");
    //                         LoanTypeObject.Add('guarantors', LoanTypeObject2);

    //                     end else begin
    //                         LoanTypeObject2.Add('required_guarantors', false);
    //                         LoanTypeObject.Add('guarantors', LoanTypeObject2);
    //                         LoanTypeObject2.Add('minimum_guarantors', ProdFactory."Min No. Of Guarantors");
    //                         LoanTypeObject2.Add('maximum_guarantors', ProdFactory."Max No. Of Guarantor");
    //                     end;
    //                     LoanTypesArray.Add(LoanTypeObject);
    //                     Clear(LoanTypeObject2);
    //                     Clear(LoanTypeObject);
    //                 //end;
    //                 until ProdFactory.Next() = 0;
    //                 DataJson.Add('loan_types', LoanTypesArray);
    //                 Found := true;
    //             end;
    //         end else
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'Member number does not exists.');
    //     END;

    //     if Found = false then begin
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'No product exists');
    //     end;

    //     ResponseJson.Add(Data, DataJson);
    // end;


    local procedure GetLoanCalculatorParameters(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        LoanTypesArray: JsonArray;
        LoanTypesArray2: JsonArray;
        LoanTypeObject: JsonObject;
        LoanTypeObject2: JsonObject;
        Iterator: Integer;
        ProdFactory: Record "Loan Products Setup";
        ProdFactory2: Record "Loan Products Setup";
        Found: Boolean;
        SalDetails: record "Loan Appraisal Salary Details";
        Loans: Record "Loans Register";
        Members: Record Customer;
        NetSalary: Decimal;
        Maxloan: Decimal;
        PayrollMonthlyTransactions: Record "prPeriod Transactions.";
        LoanDescription: Text[100];
        Cust: Record Customer;
        loanR: Record "Loans Register";
        PesaTele: Decimal;
        Msg: Text[250];
        loan_Code: text;
        Insider: Record "Sacco Insiders";
        NormalMember: Boolean;
        Director: Boolean;
        Staff: Boolean;

    Begin
        Found := false;
        Iterator := 0;

        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        loan_Code := SelectJsonToken(RequestJson, '$.loan_code').AsValue.AsText;
        Staff := false;
        Director := false;
        NormalMember := false;
        if IdentifierType = 'NATIONAL_ID_NUMBER' THEN BEGIN
            Members.Reset();
            Members.SetRange(Members."ID No.", Identifier);
            if Members.FindFirst() then begin
                Insider.Reset();
                Insider.SetRange(Insider.MemberNo, Members."No.");
                if Insider.FindFirst() then begin
                    if Insider."Position in society" = Insider."Position in society"::Staff then begin
                        Staff := true;
                    end;
                    if Insider."Position in society" = Insider."Position in society"::Board then begin
                        Director := true;
                    end;
                end else begin
                    NormalMember := true;
                end;

                if NormalMember = true then begin

                    ProdFactory.Reset();
                    ProdFactory.SetRange(ProdFactory.Code, loan_Code);
                    //ProdFactory.SetFilter(ProdFactory."Member Category", '%1', ProdFactory."Member Category"::"All Members");
                    if ProdFactory.FindFirst() then begin
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Loan calculator parameters have been fetched successfully');

                        LoanDescription := '';
                        Maxloan := 0;
                        LoanTypeObject.Add('loan_code', ProdFactory.Code);
                        LoanTypeObject.Add('product_name', Format(ProdFactory."Product Description"));
                        LoanTypeObject.Add('repayment_frequency', Format(ProdFactory."Repayment Frequency"));
                        LoanTypeObject.Add('maximum_loan_amount', ProdFactory."Max. Loan Amount");
                        LoanTypeObject.Add('manimum_loan_amount', ProdFactory."Min. Loan Amount");
                        LoanTypeObject.Add('interest_rate', ProdFactory."Interest rate");
                        LoanTypeObject.Add('maximum_installments', ProdFactory."Default Installements");
                        LoanTypeObject.Add('minimum_number_of_guarantors', ProdFactory."Min No. Of Guarantors");
                        LoanTypeObject.Add('maximum_number_of_guarantors', ProdFactory."Max No. Of Guarantors");
                        LoanTypeObject.Add('recovery_mode', Format(ProdFactory."Recovery Mode"));
                        LoanTypeObject.Add('source', Format(ProdFactory.Source));
                        LoanTypeObject.Add('interest_calculation_method', ProdFactory."Repayment Method");
                        Found := true;
                    end;
                end;

                if Director = true then begin

                    ProdFactory.Reset();
                    ProdFactory.SetRange(ProdFactory.Code, loan_Code);
                    //ProdFactory.SetFilter(ProdFactory."Member Category", '%1|%2', ProdFactory."Member Category"::"All Members", ProdFactory."Member Category"::Board);
                    if ProdFactory.FindFirst() then begin
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Loan calculator parameters have been fetched successfully');

                        LoanDescription := '';
                        Maxloan := 0;
                        LoanTypeObject.Add('loan_code', ProdFactory.Code);
                        LoanTypeObject.Add('product_name', Format(ProdFactory."Product Description"));
                        LoanTypeObject.Add('repayment_frequency', Format(ProdFactory."Repayment Frequency"));
                        LoanTypeObject.Add('maximum_loan_amount', ProdFactory."Max. Loan Amount");
                        LoanTypeObject.Add('interest_rate', ProdFactory."Interest rate");
                        LoanTypeObject.Add('maximum_installments', ProdFactory."Default Installements");
                        LoanTypeObject.Add('minimum_number_of_guarantors', ProdFactory."Min No. Of Guarantors");
                        LoanTypeObject.Add('maximum_number_of_guarantors', ProdFactory."Max No. Of Guarantors");
                        LoanTypeObject.Add('recovery_mode', Format(ProdFactory."Recovery Mode"));
                        LoanTypeObject.Add('source', Format(ProdFactory.Source));
                        LoanTypeObject.Add('interest_calculation_method', ProdFactory."Repayment Method");
                        Found := true;
                    end;
                end;



                if Staff = true then begin

                    ProdFactory.Reset();
                    ProdFactory.SetRange(ProdFactory.Code, loan_Code);
                    // ProdFactory.SetFilter(ProdFactory."Member Category", '%1|%2', ProdFactory."Member Category"::"All Members", ProdFactory."Member Category"::Staff);
                    if ProdFactory.FindFirst() then begin
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Loan calculator parameters have been fetched successfully');

                        LoanDescription := '';
                        Maxloan := 0;
                        LoanTypeObject.Add('loan_code', ProdFactory.Code);
                        LoanTypeObject.Add('product_name', Format(ProdFactory."Product Description"));
                        LoanTypeObject.Add('repayment_frequency', Format(ProdFactory."Repayment Frequency"));
                        LoanTypeObject.Add('maximum_loan_amount', ProdFactory."Max. Loan Amount");
                        LoanTypeObject.Add('interest_rate', ProdFactory."Interest rate");
                        LoanTypeObject.Add('maximum_installments', ProdFactory."Default Installements");
                        LoanTypeObject.Add('minimum_number_of_guarantors', ProdFactory."Min No. Of Guarantors");
                        LoanTypeObject.Add('maximum_number_of_guarantors', ProdFactory."Max No. Of Guarantors");
                        LoanTypeObject.Add('recovery_mode', Format(ProdFactory."Recovery Mode"));
                        LoanTypeObject.Add('source', Format(ProdFactory.Source));
                        LoanTypeObject.Add('interest_calculation_method', ProdFactory."Repayment Method");
                        Found := true;
                    end;
                end;

            end else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Member number does not exists.');


        end;

        if Found = false then begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'No product exists');
        end;

        ResponseJson.Add(Data, LoanTypeObject);
    end;

    // local procedure CheckLoanStatus(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     DataArray: JsonArray;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     LoanTypesArray: JsonArray;
    //     LoanTypesArray2: JsonArray;
    //     LoanTypeObject: JsonObject;
    //     LoanTypeObject2: JsonObject;
    //     Iterator: Integer;
    //     ProdFactory: Record "Loan Products Setup";
    //     ProdFactory2: Record "Loan Products Setup";
    //     Found: Boolean;
    //     SalDetails: record "Salary Details";
    //     Loans: Record "Loans Register";
    //     Members: Record Vendor;
    //     NetSalary: Decimal;
    //     Maxloan: Decimal;
    //     PayrollMonthlyTransactions: Record "prPeriod Transactions.";

    // begin
    //     Found := false;
    //     Iterator := 0;

    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

    //     if IdentifierType = 'MSISDN' THEN BEGIN
    //         Members.Reset();
    //         Members.SetRange(Members."Mobile Phone No", Identifier);
    //         // Members.SetFilter(Members."Account Type", '103');
    //         if Members.FindFirst() then begin
    //             Members.CalcFields(Members.Balance);
    //             Loans.Reset();
    //             Loans.SetRange(Loans."Client Code", Members."BOSA Account No");
    //             Loans.SetRange(Loans."Approval Status", Loans."Approval Status"::Pending);
    //             if Loans.FindFirst() then begin
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                 repeat

    //                     ProdFactory.Get(Loans."Loan Product Type");
    //                     LoanTypeObject.Add('loan_type_id', Loans."Loan Product Type");
    //                     LoanTypeObject.Add('loan_type_name', Format(ProdFactory."Product Description"));
    //                     LoanTypeObject.Add('loan_status', Format(Loans."Loan Status"));
    //                     LoanTypeObject.Add('loan_amount', Loans."Requested Amount");
    //                     LoanTypesArray.Add(LoanTypeObject);
    //                     Clear(LoanTypeObject);

    //                     Found := true;
    //                 until Loans.Next() = 0;

    //             end;
    //             DataJson.Add('loan_types', LoanTypesArray);
    //         end else
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'Member number does not exists.');
    //         // ResponseJson.Add('loan_types', DataJson);

    //     end;
    //     if IdentifierType = 'MEMBER_NUMBER' THEN BEGIN
    //         Members.Reset();
    //         Members.SetRange(Members."BOSA Account No", Identifier);
    //         //Members.SetFilter(Members."Account Type", '103');
    //         if Members.FindFirst() then begin
    //             Members.CalcFields(Members.Balance);
    //             Loans.Reset();
    //             Loans.SetRange(Loans."Client Code", Members."BOSA Account No");
    //             Loans.SetRange(Loans."Approval Status", Loans."Approval Status"::Pending);
    //             if Loans.FindFirst() then begin
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                 repeat

    //                     ProdFactory.Get(Loans."Loan Product Type");
    //                     LoanTypeObject.Add('loan_type_id', Loans."Loan Product Type");
    //                     LoanTypeObject.Add('loan_type_name', Format(ProdFactory."Product Description"));
    //                     LoanTypeObject.Add('loan_status', Format(Loans."Loan Status"));
    //                     LoanTypeObject.Add('loan_amount', Loans."Requested Amount");
    //                     LoanTypesArray.Add(LoanTypeObject);
    //                     Clear(LoanTypeObject);

    //                     Found := true;
    //                 until Loans.Next() = 0;
    //                 DataJson.Add('loan_types', LoanTypesArray);
    //             end;
    //         end;// else
    //             // SetResponseStatus(ResponseJson, 'error', 'Error', 'Member number does not exists.');

    //     END;

    //     if Found = false then begin
    //         //SetResponseStatus(ResponseJson, 'error', 'Error', 'No product exists');
    //         ResponseJson.Add('loan_types', LoanTypesArray);

    //     end;
    //     if Found = true then begin
    //         ResponseJson.Add(Data, DataJson);
    //     end;
    // end;


    // // ------------------------------------------------------------------------------------------------
    // local procedure CheckLoanLimit(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     OriginatorID: Text;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     LoanTypeID: Text;
    //     LoansRegister: Record "Loans Register";
    //     LoanType: Record "Loan Products Setup";
    //     Customer: Record Customer;
    // begin
    //     OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     LoanTypeID := SelectJsonToken(RequestJson, '$.loan_type_id').AsValue.AsText;

    //     if IdentifierType = 'MEMBER_NUMBER' then begin
    //         SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //         Customer.Reset();
    //         Customer.SetRange("No.", Identifier);
    //         if Customer.Find('-') then begin
    //             Customer.CalcFields("Current Shares");
    //             if LoanType.Get(LoanTypeID) then begin

    //                 DataJson.Add('loan_type_id', LoanType.Code);
    //                 DataJson.Add('loan_name', LoanType."Product Description");
    //                 DataJson.Add('eligible_amount', GetLoanLimit(Customer."No.", LoanTypeID));//GetGrossSalary(Customer."FOSA Account No.", LoanTypeID));
    //                 DataJson.Add('loan_type_status', FnCheckMemberStatus(Customer."No."));
    //                 DataJson.Add('loan_type_age', FnCheckMemberAge(Customer."No."));
    //                 DataJson.Add('loan_type_shares', FnCheckMemberShares(Customer."No."));
    //                 DataJson.Add('loan_type_default_status', FnCheckLoanDefault(Customer."No."));
    //             end;

    //         end;
    //     end;
    //     if IdentifierType = 'MSISDN' then begin
    //         Customer.Reset();
    //         Customer.SetRange(Customer."Mobile Phone No", Identifier);
    //         if Customer.Find('-') then begin
    //             Customer.CalcFields("Current Shares");
    //             if LoanType.Get(LoanTypeID) then begin
    //                 DataJson.Add('loan_type_id', LoanType.Code);
    //                 DataJson.Add('loan_name', LoanType."Product Description");
    //                 DataJson.Add('eligible_amount', GetLoanLimit(Customer."No.", LoanTypeID));
    //                 DataJson.Add('loan_type_status', FnCheckMemberStatus(Customer."No."));
    //                 DataJson.Add('loan_type_age', FnCheckMemberAge(Customer."No."));
    //                 DataJson.Add('loan_type_shares', FnCheckMemberShares(Customer."No."));
    //                 DataJson.Add('loan_type_default_status', FnCheckLoanDefault(Customer."No."));
    //             end;


    //         end;

    //     end;
    //     ResponseJson.Add(Data, DataJson);
    // end;

    // // ------------------------------------------------------------------------------------------------
    // local procedure LoanApplication(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     OriginatorID: Text;
    //     IdentifierType: Text;
    //     Installments: Integer;
    //     Identifier: Text;
    //     LoanTypeID: Text;
    //     Amount: Decimal;
    //     SourceReference: Text;
    //     RequestApplication: Text;
    //     TransactionDateTime: Text;
    //     LoansRegister: Record "Loans Register";
    //     LoanProductSetup: Record "Loan Products Setup";
    //     LoanRec: Record "Loans Register";
    //     Members: Record Customer;
    //     NoSeries: Codeunit NoSeriesManagement;
    //     Found: Boolean;
    //     ProductFound: Boolean;
    //     GenJournalLine: Record "Gen. Journal Line";
    //     Guarantors: record "Loans Guarantee Details";
    //     LoanType: Record "Loan Products Setup";
    //     InterestAmount: Decimal;
    //     CreationMessage: Text[2500];
    //     LProducts: Record "Loan Products Setup";
    //     smsManagement: Codeunit "Sms Management";
    //     FosaAcc: Record Vendor;
    //     CreditRating: Record "Credit Rating";
    //     msg: Text;
    //     Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
    // begin
    //     OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     LoanTypeID := SelectJsonToken(RequestJson, '$.loan_type_id').AsValue.AsText;
    //     Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
    //     Installments := SelectJsonToken(RequestJson, '$.installment_period').AsValue.AsInteger;
    //     SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
    //     RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
    //     TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;

    //     // SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //     Found := false;
    //     ProductFound := false;
    //     LoanRec.Reset();
    //     LoanRec.SetRange(LoanRec."Loan  No.", SourceReference);
    //     if not LoanRec.FindFirst() then begin

    //         if IdentifierType = 'MSISDN' THEN BEGIN
    //             Members.Reset();
    //             Members.SetRange("Mobile Phone No", Identifier);
    //             if Members.Find('-') then begin
    //                 FnCheckLoanIfExisting(Members."No.", LoanTypeID);
    //                 LoansRegister.Reset;
    //                 LoansRegister.SetRange(LoansRegister."Client Code", Members."No.");
    //                 LoansRegister.SetRange("Loan Product Type", LoanTypeID);
    //                 LoansRegister.SetFilter(LoansRegister."Approval Status", '%1', LoansRegister."Approval Status"::Approved);
    //                 LoansRegister.SetAutoCalcFields(LoansRegister."Outstanding Balance");
    //                 LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>0');
    //                 LoansRegister.SetRange(LoansRegister.Posted, true);
    //                 if LoansRegister.FindFirst() then begin
    //                     SetResponseStatus(ResponseJson, 'error', 'Error', 'Member has an existing loan product.');
    //                 end else
    //                     LoanProductSetup.Reset();
    //                 LoanProductSetup.SetRange(LoanProductSetup.Code, LoanTypeID);
    //                 LoanProductSetup.SetRange("Appraise Guarantors", true);
    //                 if LoanProductSetup.FindFirst() then begin
    //                     SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //                     LoanRec.INIT;
    //                     LoanRec."Account No" := Members."FOSA Account No.";
    //                     LoanRec."Application Date" := Today;
    //                     LoanRec."Client Code" := Members."No.";
    //                     LoanRec."Client Name" := Members.name;
    //                     LoanRec."Main Sector" := '8000';
    //                     LoanRec."Sub-Sector" := '8200';
    //                     LoanRec."Specific Sector" := '8210';
    //                     //  LoanRec."Requested Amount" := amount;
    //                     LoanRec."Requested Amount" := amount;
    //                     LoanRec."Approved Amount" := amount;
    //                     LoanRec."Mode Of Application" := LoanRec."Mode Of Application"::Mobile;
    //                     LoanRec.Installments := Installments;
    //                     LoanRec.Posted := FALSE;
    //                     LoanRec."Approval Status" := LoanRec."Approval Status"::Pending;
    //                     LoanRec."Loan Status" := LoanRec."Loan Status"::Appraisal;
    //                     LoanRec."Loan  No." := NoSeries.GetNextNo('BLOANS', Today, true);
    //                     LoanRec."Loan Product Type" := LoanTypeID;
    //                     LoanRec.INSERT(true);
    //                     // Mob.ProcessAdvanceLoansFinal(SourceReference);
    //                     FosaAcc.GET(LoanRec."Account No");
    //                     CreditRating.INIT;
    //                     CreditRating."Loan No." := LoanRec."Loan  No.";
    //                     CreditRating."Document Date" := TODAY;
    //                     CreditRating."Loan Amount" := LoanRec."Approved Amount";
    //                     CreditRating."Date Entered" := TODAY;
    //                     CreditRating."Time Entered" := TIME;
    //                     CreditRating."Entered By" := USERID;
    //                     CreditRating."Account No" := LoanRec."Account No";
    //                     CreditRating."Member No" := LoanRec."Client Code";
    //                     CreditRating."Telephone No" := FosaAcc."Mobile Phone No";
    //                     CreditRating."Customer Name" := LoanRec."Client Name";
    //                     CreditRating."Loan Product Type" := LoanRec."Loan Product Type";
    //                     CreditRating."Loan Limit" := amount;
    //                     CreditRating."Staff No." := FosaAcc."Personal No.";
    //                     CreditRating.INSERT;

    //                     //Get Loan No
    //                     LoansRegister.Reset();
    //                     LoansRegister.SetRange(Remarks, SourceReference);
    //                     if LoansRegister.FindFirst() then
    //                         DataJson.Add('transaction_reference', SourceReference);
    //                     DataJson.Add('loan_serial_number', LoanRec."Loan  No.");
    //                     DataJson.Add('loan_type_id', LoanTypeID);
    //                     DataJson.Add('loan_name', LoanProductSetup."Product Description");
    //                     DataJson.Add('amount', Amount);
    //                     Found := true;
    //                     ProductFound := true;
    //                 end
    //                 else begin
    //                     LoanProductSetup.Reset();
    //                     LoanProductSetup.SetRange(LoanProductSetup.Code, LoanTypeID);
    //                     LoanProductSetup.SetRange("Appraise Guarantors", false);
    //                     if LoanProductSetup.FindFirst() then begin

    //                         LoanRec.INIT;
    //                         LoanRec."Account No" := Members."FOSA Account No.";
    //                         LoanRec."Application Date" := Today;
    //                         LoanRec."Client Code" := Members."No.";
    //                         LoanRec."Client Name" := Members.name;
    //                         LoanRec."Requested Amount" := amount;
    //                         LoanRec."Approved Amount" := amount;
    //                         LoanRec."Main Sector" := '8000';
    //                         LoanRec."Sub-Sector" := '8200';
    //                         LoanRec."Specific Sector" := '8210';
    //                         LoanRec."Mode Of Application" := LoanRec."Mode Of Application"::Mobile;
    //                         LoanRec.Installments := Installments;
    //                         LoanRec."Loan Disbursement Date" := Today;
    //                         LoanRec.Validate("Loan Disbursement Date");
    //                         LoanRec."Loan Status" := LoanRec."Loan Status"::Issued;
    //                         LoanRec.Posted := true;
    //                         LoanRec."Approval Status" := LoanRec."Approval Status"::Approved;
    //                         LoanRec."Loan  No." := NoSeries.GetNextNo('BLOANS', Today, true);
    //                         LoanRec."Loan Product Type" := LoanTypeID;
    //                         LoanRec.INSERT(true);
    //                         // Mob.ProcessAdvanceLoansFinal(SourceReference);
    //                         FosaAcc.GET(LoanRec."Account No");
    //                         CreditRating.INIT;
    //                         CreditRating."Loan No." := LoanRec."Loan  No.";
    //                         CreditRating."Document Date" := TODAY;
    //                         CreditRating."Loan Amount" := LoanRec."Approved Amount";
    //                         CreditRating."Date Entered" := TODAY;
    //                         CreditRating."Time Entered" := TIME;
    //                         CreditRating."Entered By" := USERID;
    //                         CreditRating."Account No" := LoanRec."Account No";
    //                         CreditRating."Member No" := LoanRec."Client Code";
    //                         CreditRating."Telephone No" := FosaAcc."Mobile Phone No";
    //                         CreditRating."Customer Name" := LoanRec."Client Name";
    //                         CreditRating."Loan Product Type" := LoanRec."Loan Product Type";
    //                         CreditRating."Loan Limit" := amount;
    //                         CreditRating."Staff No." := FosaAcc."Personal No.";
    //                         CreditRating.INSERT;
    //                         // SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                         //Get Loan No
    //                         LoansRegister.Reset();
    //                         LoansRegister.SetRange(Remarks, SourceReference);
    //                         if LoansRegister.FindFirst() then
    //                             DataJson.Add('transaction_reference', SourceReference);
    //                         DataJson.Add('loan_serial_number', LoanRec."Loan  No.");
    //                         DataJson.Add('loan_type_id', LoanTypeID);
    //                         DataJson.Add('loan_name', LoanProductSetup."Product Description");
    //                         DataJson.Add('amount', Amount);
    //                         Found := true;
    //                         ProductFound := true;

    //                         BATCH_TEMPLATE := 'GENERAL';
    //                         BATCH_NAME := 'MOBILE';
    //                         DOCUMENT_NO := LoanRec."Loan  No.";
    //                         GenJournalLine.Reset();
    //                         GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
    //                         GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
    //                         if GenJournalLine.FindSet() then begin
    //                             GenJournalLine.DeleteAll();
    //                         end;
    //                         //Balancing Account
    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                         GenJournalLine."Account Type"::Vendor, Members."FOSA Account No.", Today, Amount * -1, '', DOCUMENT_NO,
    //                          'Mobile loan ' + LoanRec."Loan Product Type" + ' ' + Members."No.", '');

    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Loan,
    //                         GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", Today, Amount, '', DOCUMENT_NO,
    //                          'Mobile Loan' + ' ' + Members."No.", LoanRec."Loan  No.");
    //                         LoanType.Get(LoansRegister."Loan Product Type");
    //                         if LoanType."Charge Interest Upfront" = true then begin
    //                             LineNo := LineNo + 10000;
    //                             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                             GenJournalLine."Account Type"::"G/L Account", LoanType."Receivable Interest Account", Today, (LoanType."Interest rate" * Amount / 100) * -1, '', DOCUMENT_NO,
    //                              'Mobile Trans interest Upfront' + ' ' + Members."No.", '');

    //                             LineNo := LineNo + 10000;
    //                             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Due",
    //                             GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", Today, (LoanType."Interest rate" * Amount / 100), '', DOCUMENT_NO,
    //                              'Mobile Loan ' + ' ' + Members."No.", LoanRec."Loan  No.");


    //                             LineNo := LineNo + 10000;
    //                             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                             GenJournalLine."Account Type"::Vendor, Members."FOSA Account No.", Today, (LoanType."Interest rate" * Amount / 100), '', DOCUMENT_NO,
    //                              'Mobile Trans interest Repayment' + ' ' + Members."No.", '');


    //                             LineNo := LineNo + 10000;
    //                             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
    //                             GenJournalLine."Account Type"::Customer, Members."No.", Today, (LoanType."Interest rate" * Amount / 100) * -1, '', DOCUMENT_NO,
    //                              'Mobile Trans interest Repayment' + ' ' + Members."No.", LoanRec."Loan  No.");

    //                         end;

    //                         GenJournalLine.Reset;
    //                         GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //                         GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //                         if GenJournalLine.Find('-') then begin
    //                             Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //                         end;
    //                         LProducts.Get(LoanRec."Loan Product Type");

    //                         CreationMessage := 'Dear, ' + BName.NameStyle(Members."No.") + ' your ' + LProducts."Product Description" + ' loan has been received on ' + Format(Today) + ' ' + Format(Time) + ' and is being worked on.';
    //                         smsManagement.SendSmsWithID(Source::LOAN_POSTED, Members."Mobile Phone No", CreationMessage, Members."No.", Members."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
    //                     end;
    //                 END;
    //             end;
    //             if ProductFound = false then begin
    //                 SetResponseStatus(ResponseJson, 'error', 'Error', 'Product is not valid');
    //             end;
    //         end;
    //         if IdentifierType = 'MEMBER_NUMBER' THEN BEGIN
    //             Members.Reset();
    //             Members.SetRange(Members."No.", Identifier);
    //             if Members.Find('-') then begin
    //                 FnCheckLoanIfExisting(Members."No.", LoanTypeID);
    //                 LoansRegister.Reset;
    //                 LoansRegister.SetRange(LoansRegister."Client Code", Members."No.");
    //                 LoansRegister.SetRange("Loan Product Type", LoanTypeID);
    //                 LoansRegister.SetFilter(LoansRegister."Approval Status", '%1', LoansRegister."Approval Status"::Approved);
    //                 LoansRegister.SetAutoCalcFields(LoansRegister."Outstanding Balance");
    //                 LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>0');
    //                 LoansRegister.SetRange(LoansRegister.Posted, true);
    //                 if not LoansRegister.FindFirst() then begin

    //                     LoanProductSetup.Reset();
    //                     LoanProductSetup.SetRange(LoanProductSetup.Code, LoanTypeID);
    //                     LoanProductSetup.SetRange("Appraise Guarantors", true);
    //                     if LoanProductSetup.FindFirst() then begin
    //                         SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                         LoanRec.INIT;
    //                         LoanRec."Account No" := Members."FOSA Account No.";
    //                         LoanRec."Application Date" := Today;
    //                         LoanRec."Client Code" := Members."No.";
    //                         LoanRec."Client Name" := Members.name;
    //                         LoanRec."Requested Amount" := amount;
    //                         LoanRec."Staff No" := Members."Payroll No";
    //                         LoanRec.Interest := LoanProductSetup."Interest rate";
    //                         LoanRec."Approved Amount" := amount;
    //                         LoanRec."Main Sector" := '8000';
    //                         LoanRec."Sub-Sector" := '8200';
    //                         LoanRec."Specific Sector" := '8210';
    //                         LoanRec."Mode Of Application" := LoanRec."Mode Of Application"::Mobile;
    //                         LoanRec.Installments := Installments;
    //                         LoanRec.Posted := FALSE;
    //                         LoanRec."Approval Status" := LoanRec."Approval Status"::Pending;
    //                         LoanRec."Loan Status" := LoanRec."Loan Status"::Application;
    //                         LoanRec."Loan  No." := NoSeries.GetNextNo('BLOANS', Today, true);
    //                         LoanRec."Loan Product Type" := LoanTypeID;
    //                         LoanRec.INSERT(true);
    //                         // Mob.ProcessAdvanceLoansFinal(SourceReference);
    //                         FosaAcc.GET(LoanRec."Account No");
    //                         CreditRating.INIT;
    //                         CreditRating."Loan No." := LoanRec."Loan  No.";
    //                         CreditRating."Document Date" := TODAY;
    //                         CreditRating."Loan Amount" := LoanRec."Approved Amount";
    //                         CreditRating."Date Entered" := TODAY;
    //                         CreditRating."Time Entered" := TIME;
    //                         CreditRating."Entered By" := USERID;
    //                         CreditRating."Account No" := LoanRec."Account No";
    //                         CreditRating."Member No" := LoanRec."Client Code";
    //                         CreditRating."Telephone No" := FosaAcc."Mobile Phone No";
    //                         CreditRating."Customer Name" := LoanRec."Client Name";
    //                         CreditRating."Loan Product Type" := LoanRec."Loan Product Type";
    //                         CreditRating."Loan Limit" := amount;
    //                         CreditRating."Staff No." := FosaAcc."Personal No.";
    //                         CreditRating.INSERT;

    //                         //Get Loan No
    //                         LoansRegister.Reset();
    //                         LoansRegister.SetRange(Remarks, SourceReference);
    //                         if LoansRegister.FindFirst() then
    //                             DataJson.Add('transaction_reference', SourceReference);
    //                         DataJson.Add('loan_serial_number', LoanRec."Loan  No.");
    //                         DataJson.Add('loan_type_id', LoanTypeID);
    //                         DataJson.Add('loan_name', LoanProductSetup."Product Description");
    //                         DataJson.Add('amount', Amount);
    //                         Found := true;
    //                         ProductFound := true;
    //                     end else begin
    //                         LoanProductSetup.Reset();
    //                         LoanProductSetup.SetRange(LoanProductSetup.Code, LoanTypeID);
    //                         LoanProductSetup.SetRange("Appraise Guarantors", false);
    //                         if LoanProductSetup.FindFirst() then begin

    //                             LoanRec.INIT;
    //                             LoanRec."Account No" := Members."FOSA Account No.";
    //                             LoanRec."Application Date" := Today;
    //                             LoanRec."Client Code" := Members."No.";
    //                             LoanRec."Client Name" := Members.name;
    //                             LoanRec."Requested Amount" := amount;
    //                             LoanRec."Approved Amount" := amount;
    //                             LoanRec."Staff No" := Members."Payroll No";
    //                             LoanRec."Main Sector" := '8000';
    //                             LoanRec."Sub-Sector" := '8200';
    //                             LoanRec."Specific Sector" := '8210';
    //                             LoanRec.Interest := LoanProductSetup."Interest rate";
    //                             LoanRec."Repayment Method" := LoanProductSetup."Repayment Method";
    //                             LoanRec."Loan Status" := LoanRec."Loan Status"::Issued;
    //                             LoanRec."Mode Of Application" := LoanRec."Mode Of Application"::Mobile;
    //                             LoanRec.Installments := Installments;
    //                             LoanRec."Loan Disbursement Date" := Today;
    //                             LoanRec.Validate("Loan Disbursement Date");
    //                             LoanRec.Posted := true;
    //                             LoanRec."Approval Status" := LoanRec."Approval Status"::Approved;
    //                             LoanRec."Loan  No." := NoSeries.GetNextNo('BLOANS', Today, true);
    //                             LoanRec."Loan Product Type" := LoanTypeID;
    //                             LoanRec.INSERT(true);
    //                             // Mob.ProcessAdvanceLoansFinal(SourceReference);
    //                             FosaAcc.GET(LoanRec."Account No");
    //                             CreditRating.INIT;
    //                             CreditRating."Loan No." := LoanRec."Loan  No.";
    //                             CreditRating."Document Date" := TODAY;
    //                             CreditRating."Loan Amount" := LoanRec."Approved Amount";
    //                             CreditRating."Date Entered" := TODAY;
    //                             CreditRating."Time Entered" := TIME;
    //                             CreditRating."Entered By" := USERID;
    //                             CreditRating."Account No" := LoanRec."Account No";
    //                             CreditRating."Member No" := LoanRec."Client Code";
    //                             CreditRating."Telephone No" := FosaAcc."Mobile Phone No";
    //                             CreditRating."Customer Name" := LoanRec."Client Name";
    //                             CreditRating."Loan Product Type" := LoanRec."Loan Product Type";
    //                             CreditRating."Loan Limit" := amount;
    //                             CreditRating."Staff No." := FosaAcc."Personal No.";
    //                             CreditRating.INSERT;
    //                             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                             //Get Loan No
    //                             LoansRegister.Reset();
    //                             LoansRegister.SetRange(Remarks, SourceReference);
    //                             if LoansRegister.FindFirst() then
    //                                 DataJson.Add('transaction_reference', SourceReference);
    //                             DataJson.Add('loan_serial_number', LoanRec."Loan  No.");
    //                             DataJson.Add('loan_type_id', LoanTypeID);
    //                             DataJson.Add('loan_name', LoanProductSetup."Product Description");
    //                             DataJson.Add('amount', Amount);
    //                             Found := true;
    //                             ProductFound := true;

    //                             BATCH_TEMPLATE := 'GENERAL';
    //                             BATCH_NAME := 'MOBILE';
    //                             DOCUMENT_NO := LoanRec."Loan  No.";
    //                             GenJournalLine.Reset();
    //                             GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
    //                             GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
    //                             if GenJournalLine.FindSet() then begin
    //                                 GenJournalLine.DeleteAll();
    //                             end;
    //                             //Balancing Account
    //                             LineNo := LineNo + 10000;
    //                             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                             GenJournalLine."Account Type"::Vendor, Members."FOSA Account No.", Today, Amount * -1, '', DOCUMENT_NO,
    //                              'Mobile Loan ' + LoanRec."Loan Product Type" + ' ' + Members."No.", '');

    //                             LineNo := LineNo + 10000;
    //                             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Loan,
    //                             GenJournalLine."Account Type"::Customer, Members."No.", Today, Amount, '', DOCUMENT_NO,
    //                              'Mobile Loan ' + ' ' + Members."No.", LoanRec."Loan  No.");
    //                             LoanType.Get(LoanRec."Loan Product Type");

    //                             if (LoanType."Charge Interest Upfront" <> true) and (LoanType."Recovery Mode" = LoanType."Recovery Mode"::Mobile) then begin
    //                                 InterestAmount := 0;
    //                                 if LoanRec."Repayment Method" = LoanRec."repayment method"::Amortised then begin
    //                                     InterestAmount := ROUND(LoanRec."Approved Amount" / 100 / 12 * LoanType."Interest rate", 1, '>');

    //                                 end;
    //                                 if LoanRec."Repayment Method" = LoanRec."repayment method"::"Reducing Balance" then begin
    //                                     InterestAmount := ROUND(LoanRec."Approved Amount" * LoanType."Interest rate" / 1200, 1, '>');

    //                                 end;

    //                                 if LoanRec."Repayment Method" = LoanRec."repayment method"::"Straight Line" then begin
    //                                     InterestAmount := Round((LoanType."Interest rate" / 12 / 100) * LoanRec."Approved Amount", 1, '>');
    //                                 end;

    //                                 LineNo := LineNo + 10000;
    //                                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                                 GenJournalLine."Account Type"::"G/L Account", LoanType."Receivable Interest Account", Today, -InterestAmount, '', DOCUMENT_NO,
    //                                  'Mobile Trans interest Upfront' + ' ' + Members."No.", '');

    //                                 LineNo := LineNo + 10000;
    //                                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Due",
    //                                 GenJournalLine."Account Type"::Customer, LoanRec."Client Code", Today, InterestAmount, '', DOCUMENT_NO,
    //                                  'Mobile Loan ' + ' ' + Members."No.", LoanRec."Loan  No.");

    //                             end;
    //                             if LoanType."Charge Interest Upfront" = true then begin
    //                                 LineNo := LineNo + 10000;
    //                                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                                 GenJournalLine."Account Type"::"G/L Account", LoanType."Receivable Interest Account", Today, (LoanType."Interest rate" * Amount / 100) * -1, '', DOCUMENT_NO,
    //                                  'Mobile Trans interest Upfront' + ' ' + Members."No.", '');

    //                                 LineNo := LineNo + 10000;
    //                                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Due",
    //                                 GenJournalLine."Account Type"::Customer, LoanRec."Client Code", Today, (LoanType."Interest rate" * Amount / 100), '', DOCUMENT_NO,
    //                                  'Mobile Loan ' + ' ' + Members."No.", LoanRec."Loan  No.");


    //                                 LineNo := LineNo + 10000;
    //                                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                                 GenJournalLine."Account Type"::Vendor, Members."FOSA Account No.", Today, (LoanType."Interest rate" * Amount / 100), '', DOCUMENT_NO,
    //                                  'Mobile Trans interest Repayment' + ' ' + Members."No.", '');


    //                                 LineNo := LineNo + 10000;
    //                                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
    //                                 GenJournalLine."Account Type"::Customer, Members."No.", Today, (LoanType."Interest rate" * Amount / 100) * -1, '', DOCUMENT_NO,
    //                                  'Mobile Trans interest Repayment' + ' ' + Members."No.", LoanRec."Loan  No.");

    //                             end;

    //                             GenJournalLine.Reset;
    //                             GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //                             GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //                             if GenJournalLine.Find('-') then begin
    //                                 Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //                             end;
    //                             LProducts.Get(LoanRec."Loan Product Type");
    //                             CreationMessage := 'Dear, ' + BName.NameStyle(Members."No.") + ' your ' + LProducts."Product Description" + ' loan has been received on ' + Format(Today) + ' ' + Format(Time) + ' and is being worked on.';
    //                             smsManagement.SendSmsWithID(Source::LOAN_POSTED, Members."Mobile Phone No", CreationMessage, Members."No.", Members."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
    //                         end;
    //                     END;
    //                 end else
    //                     SetResponseStatus(ResponseJson, 'error', 'Error', 'You have an existing loan product.');

    //             end else
    //                 SetResponseStatus(ResponseJson, 'error', 'Error', 'Member cannot be found.');
    //             //  if ProductFound = false then begin
    //             //    SetResponseStatus(ResponseJson, 'error', 'Error', 'Product is not valid');
    //             //end;
    //         end;
    //         //   if Found = false then begin
    //         //  SetResponseStatus(ResponseJson, 'error', 'Error', 'Member cannot be found.');
    //         // end;
    //     end;// else
    //         // SetResponseStatus(ResponseJson, 'error', 'Error', 'Source reference already exists');
    //         //  if Found = true then begin
    //     ResponseJson.Add(Data, DataJson);

    //     // end;
    // end;

    // local procedure DiscardLoanApplication(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     OriginatorID: Text;
    //     IdentifierType: Text;
    //     Installments: Integer;
    //     Identifier: Text;
    //     LoanID: Code[40];
    //     Amount: Decimal;
    //     SourceReference: Text;
    //     RequestApplication: Text;
    //     TransactionDateTime: Text;
    //     LoansRegister: Record "Loans Register";
    //     LoanProductSetup: Record "Loan Products Setup";
    //     LoanRec: Record "Loans Register";
    //     Members: Record Customer;
    //     NoSeries: Codeunit NoSeriesManagement;
    //     Found: Boolean;
    //     ProductFound: Boolean;
    //     GenJournalLine: Record "Gen. Journal Line";
    //     Guarantors: record "Loans Guarantee Details";
    // begin
    //     // OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     LoanID := SelectJsonToken(RequestJson, '$.loan_id').AsValue.AsText;




    //     Found := false;
    //     if IdentifierType = 'MEMBER_NUMBER' then begin
    //         Members.Reset();
    //         Members.SetRange(Members."No.", Identifier);
    //         if Members.FindFirst() then begin

    //             LoanRec.Reset();
    //             LoanRec.SetRange(LoanRec."Client Code", Members."No.");
    //             LoanRec.SetRange(LoanRec."Loan  No.", UpperCase(LoanID));
    //             if LoanRec.FindFirst() then begin
    //                 // Error('here%1',LoanID);
    //                 SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //                 LoanRec."Archive Loan" := true;
    //                 LoanRec.Modify();
    //                 Found := true;
    //             end;
    //         end;
    //     end;
    //     if Found = false then begin
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'Loan not  found.');
    //     end;

    //     //if Found = true then begin
    //     //  ResponseJson.Add(Data, DataJson);
    //     //   end;

    // end;


    // // ------------------------------------------------------------------------------------------------    
    // local procedure GetOutstandingLoans(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     LoansArray: JsonArray;
    //     LoanObject: JsonObject;
    //     Iterator: Integer;
    //     Loans: Record "Loans Register";
    //     Members: Record Customer;
    //     ProdFactory: Record "Loan Products Setup";


    // begin
    //     Iterator := 0;

    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     if Members.get(Identifier) then begin
    //         SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //         Loans.Reset();
    //         Loans.SetRange(Loans."Client Code", Members."No.");
    //         Loans.SetAutoCalcFields(Loans."Outstanding Balance");
    //         Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
    //         if Loans.FindSet() then begin

    //             repeat
    //                 Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
    //                 LoanObject.Add('loan_serial_number', Loans."Loan  No.");
    //                 LoanObject.Add('loan_type_id', Loans."Loan Product Type");
    //                 if Loans."Loan Product Type Name" = '' then begin
    //                     ProdFactory.Reset();
    //                     ProdFactory.SetRange(ProdFactory.Code, Loans."Loan Product Type");
    //                     if ProdFactory.FindFirst() then begin
    //                         LoanObject.Add('loan_type_name', ProdFactory."Product Description");
    //                     end
    //                 end else begin
    //                     LoanObject.Add('loan_type_name', Loans."Loan Product Type Name");
    //                 end;
    //                 LoanObject.Add('loan_amount', Loans."Approved Amount");
    //                 LoanObject.Add('loan_balance', Loans."Outstanding Balance" + Loans."Outstanding Interest");
    //                 LoanObject.Add('installment_amount', Loans.Repayment);
    //                 LoanObject.Add('loan_defaulted_amount', Loans."Amount in Arrears");
    //                 LoanObject.Add('loan_issued_date', Loans."Loan Disbursement Date");
    //                 LoanObject.Add('loan_end_date', Loans."Expected Date of Completion");
    //                 LoanObject.Add('loan_performance', Format(Loans."Loans Category-SASRA"));
    //                 LoanObject.Add('loan_performance_description', StrSubstNo('Loan is %1', UpperCase(Format(Loans."Loans Category-SASRA"))));

    //                 LoansArray.Add(LoanObject);
    //                 Clear(LoanObject);
    //                 Iterator := Iterator + 1;
    //             until Loans.Next() = 0;
    //         end;

    //         DataJson.Add('loans', LoansArray);

    //     end else
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'Member does not exist');

    //     ResponseJson.Add(Data, DataJson);
    // end;

    local procedure GetLoansPortal(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        LoansArray: JsonArray;
        LoanObject: JsonObject;
        Iterator: Integer;
        Loans: Record "Loans Register";
        Members: Record Customer;
        ProdFactory: Record "Loan Products Setup";
        LoanNumber: Text;
        Schedule: Record "Loan Repayment Schedule";
        NextDate: Date;

    begin

        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        Members.Reset();
        Members.SetRange(Members."Mobile Phone No", Identifier);
        if Members.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'success', 'Success', 'Member’s loans list has been fetched successfully');
            Loans.Reset();
            Loans.SetRange(Loans."Client Code", Members."No.");
            Loans.SetAutoCalcFields(Loans."Outstanding Balance");
            Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
            if Loans.FindSet() then begin
                repeat
                    Schedule.Reset();
                    Schedule.SetRange(Schedule."Loan No.", Loans."Loan  No.");
                    Schedule.SetFilter(Schedule."Repayment Date", '>%1', Today);
                    if Schedule.FindFirst() then begin
                        NextDate := Schedule."Repayment Date";
                    end;

                    ProdFactory.Get(Loans."Loan Product Type");
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                    LoanObject.Add('loan_number', Loans."Loan  No.");
                    LoanObject.Add('loan_type', ProdFactory."Product Description");
                    LoanObject.Add('loan_source', ProdFactory.Source);
                    LoanObject.Add('application_date', Loans."Application Date");
                    LoanObject.Add('posting_date', Loans."Posting Date");
                    LoanObject.Add('outstanding_balance', Loans."Outstanding Balance" + Loans."Oustanding Interest");
                    LoanObject.Add('loan_principal', Loans."Approved Amount");
                    LoanObject.Add('outstanding_interest', Loans."Oustanding Interest");
                    LoanObject.Add('installments', Loans.Installments);
                    LoanObject.Add('loan_status', Format(Loans."Loan Status"));
                    LoanObject.Add('repayment_amount', Loans.Repayment);
                    LoanObject.Add('loan_category', Format(Loans."Loans Category-SASRA"));
                    LoanObject.Add('currency', 'KES');
                    LoanObject.Add('next_repayment_date', NextDate);
                    LoanObject.Add('loan_disbursement_date', Loans."Loan Disbursement Date");
                    LoanObject.Add('expected_date_of_completion', Loans."Expected Date of Completion");
                    LoansArray.Add(LoanObject);
                    Clear(LoanObject);
                until Loans.Next() = 0;
            end;

            //DataJson.Add('loans', LoansArray);

        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Member does not exist');

        ResponseJson.Add(Data, LoansArray);
    end;

    local procedure GetLoanDetailsPortal(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        LoansArray: JsonArray;
        LoanObject: JsonObject;
        Iterator: Integer;
        Loans: Record "Loans Register";
        Members: Record Customer;
        ProdFactory: Record "Loan Products Setup";
        LoanNumber: Text;
        Schedule: Record "Loan Repayment Schedule";
        NextDate: Date;

    begin

        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        LoanNumber := SelectJsonToken(RequestJson, '$.loan_number').AsValue.AsText;
        Members.Reset();
        Members.SetRange(Members."Mobile Phone No", Identifier);
        if Members.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'success', 'Success', 'Member’s loan details have been fetched successfully');
            Loans.Reset();
            Loans.SetRange(Loans."Client Code", Members."No.");
            Loans.SetRange(Loans."Loan  No.", LoanNumber);
            Loans.SetAutoCalcFields(Loans."Outstanding Balance");
            Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
            if Loans.FindSet() then begin
                Schedule.Reset();
                Schedule.SetRange(Schedule."Loan No.", Loans."Loan  No.");
                Schedule.SetFilter(Schedule."Repayment Date", '>%1', Today);
                if Schedule.FindFirst() then begin
                    NextDate := Schedule."Repayment Date";
                end;

                ProdFactory.Get(Loans."Loan Product Type");
                Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                LoanObject.Add('loan_number', Loans."Loan  No.");
                LoanObject.Add('loan_type', ProdFactory."Product Description");
                LoanObject.Add('loan_source', ProdFactory.Source);
                LoanObject.Add('application_date', Loans."Application Date");
                LoanObject.Add('posting_date', Loans."Posting Date");
                LoanObject.Add('outstanding_balance', Loans."Outstanding Balance" + Loans."Oustanding Interest");
                LoanObject.Add('loan_principal', Loans."Approved Amount");
                LoanObject.Add('outstanding_interest', Loans."Oustanding Interest");
                LoanObject.Add('installments', Loans.Installments);
                LoanObject.Add('loan_status', Format(Loans."Loan Status"));
                LoanObject.Add('repayment_amount', Loans.Repayment);
                LoanObject.Add('loan_category', Format(Loans."Loans Category-SASRA"));
                LoanObject.Add('currency', 'KES');
                LoanObject.Add('next_repayment_date', NextDate);
                LoanObject.Add('expected_date_of_completion', Loans."Expected Date of Completion");
                //LoansArray.Add(LoanObject);
                // Clear(LoanObject);
            end;

            // DataJson.Add('loans', LoansArray);

        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Member does not exist');

        ResponseJson.Add(Data, LoanObject);
    end;

    local procedure GetNextOfKin(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        NextKinJson: JsonObject;
        LoansArray: JsonArray;
        LoanObject: JsonObject;
        Iterator: Integer;
        Loans: Record "Loans Register";
        Members: Record Customer;
        ProdFactory: Record "Loan Products Setup";
        NetKin: Record "Members Next Kin Details";
        NextKin: JsonArray;


    begin
        Iterator := 0;

        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        Members.Reset();
        Members.SetRange(Members."ID No.", Identifier);
        if Members.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'success', 'Success', 'Member’s Next of Kin list has been fetched successfully');
            NetKin.Reset();
            NetKin.SetRange(NetKin."Account No", Members."No.");
            if NetKin.FindSet() then begin

                repeat
                    NextKinJson.Add('name', NetKin.Name);
                    NextKinJson.Add('relationship', NetKin.Relationship);
                    NextKinJson.Add('allocation', NetKin."%Allocation");
                    NextKinJson.Add('status', 'status');
                    NextKinJson.Add('address', NetKin.Address);
                    NextKinJson.Add('phone_number', NetKin.Telephone);
                    NextKinJson.Add('id_number', NetKin."ID No.");
                    NextKinJson.Add('email_address', NetKin.Email);
                    NextKin.Add(NextKinJson);
                    Clear(NextKinJson);
                    Iterator := Iterator + 1;
                until NetKin.Next() = 0;

            end;

        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Member does not exist');

        ResponseJson.Add(Data, NextKin);
    end;
    // // ------------------------------------------------------------------------------------------------
    // local procedure GetTransactionCharges(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     TransactionType: Text;
    //     TransactionAmount: Decimal;
    //     TransType: Record "Transaction Types";
    //     TransCharge: Record "Transaction Charges";
    //     ChargeAmount: Decimal;
    //     TariffDetails: Record "CWithdrawal Graduated Charges";
    //     ProductID: code[30];
    //     ExciseDutyAmt: Decimal;
    //     GenSet: Record "Sacco General Set-Up";
    //     ExcisableAmt: Decimal;
    // begin
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     TransactionType := SelectJsonToken(RequestJson, '$.transaction_type').AsValue.AsText;
    //     TransactionAmount := SelectJsonToken(RequestJson, '$.transaction_amount').AsValue.AsDecimal;

    //     /*   GenSet.Get;
    //       TransType.Reset();
    //       TransType.SetRange(TransType.Code, TransactionType);
    //       if TransType.FindFirst() then begin


    //           ChargeAmount := 0;
    //           ExcisableAmt := 0;



    //           TariffDetails.Reset;
    //           TariffDetails.SetRange(TariffDetails."Account Type", TransType."Account Type");
    //           if TariffDetails.Find('-') then begin
    //               repeat
    //                   if (TransactionAmount >= TariffDetails."Minimum Amount") and (TransactionAmount <= TariffDetails."Maximum Amount") then begin
    //                       if TariffDetails."Use Percentage" = true then begin
    //                           ChargeAmount := TransactionAmount * TariffDetails."Percentage of Amount" * 0.01;
    //                       end else begin
    //                           ChargeAmount := TariffDetails.Amount;
    //                           // ExcisableAmt := TariffDetails."Vendor Charge Amount";
    //                       end;
    //                   end;
    //               until TariffDetails.Next = 0;
    //           end; */
    //     ChargeAmount := 50;

    //     ExciseDutyAmt := Round((ChargeAmount - ExcisableAmt) * GenSet."Excise Duty(%)" * 0.01, 0.0001, '=');
    //     ChargeAmount := ChargeAmount + ExciseDutyAmt;

    //     SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //     DataJson.Add('total_charge_amount', ChargeAmount);

    //     /*         end else
    //                 SetResponseStatus(ResponseJson, 'error', 'Error', 'Transaction Type not set up'); */



    //     ResponseJson.Add(Data, DataJson);
    // end;


    // // ------------------------------------------------------------------------------------------------
    // local procedure VirtualMemberRegistration(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     OriginatorID: Text;
    //     MobileNumber: Text;
    //     Name: Text;
    //     NationalIDNumber: Text;
    //     EmailAddress: Text;
    //     ReferrerMobileNumber: Text;
    // begin
    //     OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
    //     MobileNumber := SelectJsonToken(RequestJson, '$.mobile_number').AsValue.AsText;
    //     Name := SelectJsonToken(RequestJson, '$.name').AsValue.AsText;
    //     NationalIDNumber := SelectJsonToken(RequestJson, '$.national_id_number').AsValue.AsText;
    //     EmailAddress := SelectJsonToken(RequestJson, '$.email_address').AsValue.AsText;
    //     ReferrerMobileNumber := SelectJsonToken(RequestJson, '$.referrer_mobile_number').AsValue.AsText;


    //     if true then begin
    //         SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //     end
    //     else begin
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
    //     end;
    //     ResponseJson.Add(Data, DataJson);
    // end;

    // // ################################################################################################
    // // RESPONSE GENERATION PROCEDURE
    // // ################################################################################################
    local procedure WrapResponse(RequestJson: JsonObject; ResponseJson: JsonObject) Wrapped: Text;
    var
        ResponseInnerJson: JsonObject;
        WrappedJson: JsonObject;
        PayloadJson: JsonObject;

        RequestAction: Text;
        RequestId: Text;
        ResponseStatus: Text;
        ResponsePayload: Text;
        ResponseHash: Text;
        RequestSessionId: Text;
        RequesteUser: Text;
    begin
        RequestId := SelectJsonToken(RequestJson, '$.id').AsValue.AsText;
        RequestAction := SelectJsonToken(RequestJson, '$.action').AsValue.AsText;

        RequestSessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;
        RequesteUser := SelectJsonToken(RequestJson, '$.user').AsValue.AsText;

        ResponseStatus := SelectJsonToken(ResponseJson, '$.' + Status).AsValue.AsText;

        ResponseJson.Remove(Status);

        PayloadJson.WriteTo(ResponsePayload);
        ResponseHash := Sha256Hash(ResponsePayload);

        ResponseInnerJson.Add('id', RequestId);
        ResponseInnerJson.Add('action', RequestAction);
        ResponseInnerJson.Add('status', ResponseStatus);
        ResponseInnerJson.Add('hash', ResponseHash);
        ResponseInnerJson.Add('session_id', RequestSessionId);
        ResponseInnerJson.Add('user', RequesteUser);
        ResponseInnerJson.Add('timestamp', CurrentDateTime);
        ResponseInnerJson.Add('payload', ResponseJson);

        WrappedJson.Add('response', ResponseInnerJson);
        WrappedJson.WriteTo(Wrapped);
    end;

    // // SUPPORTING PROCEDURES
    // // ------------------------------------------------------------------------------------------------

    local procedure SetResponseStatus(var ResponseJson: JsonObject; TheStatus: Text; TheTitle: Text; TheMessage: Text)
    begin
        ResponseJson.Add(Status, TheStatus);
        // ResponseJson.Add('Title', TheTitle);
        ResponseJson.Add(Message, TheMessage);
    end;

    local procedure ValidateUserSession(RequestJson: JsonObject) Response: Boolean
    var
        UserName: Text;
        SessionId: Text;
        Employee: Record Employee;
    begin
        UserName := SelectJsonToken(RequestJson, '$.user').AsValue.AsText;
        SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;
        Response := true;
    end;

    local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('Could not find a token with key %1', TokenKey);
    end;

    local procedure SelectJsonToken(JsonObject: JsonObject; Path: text) JsonToken: JsonToken;
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error('Could not find a token with path %1', Path);
    end;

    local procedure ValidateRequestHash(RequestJson: JsonObject)
    var
        PayLoadJson: JsonObject;
        PayLoad: Text;
        HashFromPayload: Text;
        HashedPayload: Text;
    begin
        exit;
        HashFromPayload := SelectJsonToken(RequestJson, '$.request.hash').AsValue.AsText;
        PayLoadJson := SelectJsonToken(RequestJson, '$.request.payload').AsObject;
        PayLoadJson.WriteTo(PayLoad);
        HashedPayload := Sha256Hash(PayLoad);

        if HashedPayload <> HashFromPayload then
            Error('Payload hash mismatch');
    end;

    local procedure Sha256Hash(ClearText: Text): Text
    var
        CryptographyManagement: codeunit "Cryptography Management";
        HashAlgorithmType: option MD5,SHA1,SHA256,SHA384,SHA512;
    begin
        exit(Text.LowerCase(CryptographyManagement.GenerateHash(ClearText, HashAlgorithmType::SHA256)));
    end;

    // local procedure CheckFirstCharactor(Mobile: Code[60]) MobilePhone: Code[50]
    // var
    //     MobileRest: Text;
    //     MobilePhoneNo: Text;
    //     Firstpart: Text;
    //     MobilePhoneNo3: Text;
    //     CustomerRecord: Record Vendor;
    //     MobileExt: Label '254';
    //     CheckZero: text;
    //     MobileRest2: Text;
    // begin
    //     CustomerRecord.Reset();
    //     CustomerRecord.Setrange("No.", Mobile);
    //     if CustomerRecord.find('-') then begin
    //         MobileRest := ' ';
    //         MobileRest := ' ';
    //         MobilePhoneNo := ' ';
    //         MobileRest2 := ' ';
    //         MobilePhoneNo3 := Format(CustomerRecord."Mobile Phone No");
    //         Firstpart := CopyStr(MobilePhoneNo3, 1, 4);
    //         CheckZero := CopyStr(MobilePhoneNo3, 1, 1);
    //         MobileRest := CopyStr(MobilePhoneNo3, 5, 200);
    //         MobileRest2 := CopyStr(MobilePhoneNo3, 2, 200);
    //         if Firstpart = '+254' then begin
    //             MobilePhone := MobileExt + MobileRest
    //         end

    //         else begin
    //             MobilePhone := CustomerRecord."Mobile Phone No";
    //         end;
    //         if Firstpart = '0' then begin
    //             MobilePhone := '254' + MobileRest2
    //         end

    //         else begin
    //             MobilePhone := CustomerRecord."Mobile Phone No";
    //         end;



    //     end;
    //     exit(MobilePhone);
    // end;

    // local procedure AddGuarantors(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     Guarantors: JsonObject;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     Customer: Record Customer;
    //     Loans: Record "Loans Register";
    //     Found: Boolean;
    //     LoanId: Integer;
    //     LoanProduct: Record "Loan Products Setup";
    //     LoanG: Record "Loans Guarantee Details";
    //     TransactionInitiatorIdentifierType: Text;
    //     TransactionInitiatorIdentifier: Text;
    //     TransactionInitiatorAccount: Text;
    //     TransactionInitiatorName: Text;
    //     TransactionInitiatorAmount: Decimal;
    //     TransactionSourceIdentifierType: Text;
    //     TransactionSourceIdentifier: Text;
    //     TransactionSourceAccount: Text;
    //     TransactionSourceName: Text;
    //     TransactionSourceAmount: Decimal;
    //     loansG: record "Loans Guarantee Details";
    //     Members: Record Customer;
    //     smsManagement: Codeunit "Sms Management";
    //     CreationMessage: Text[2500];
    //     Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
    // begin

    //     TransactionInitiatorIdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     TransactionInitiatorIdentifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     TransactionInitiatorAccount := SelectJsonToken(RequestJson, '$.loan_id').AsValue.AsText;
    //     TransactionInitiatorName := SelectJsonToken(RequestJson, '$.loan_name').AsValue.AsText;
    //     TransactionInitiatorAmount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;

    //     TransactionSourceIdentifierType := SelectJsonToken(RequestJson, '$.guarantor.identifier_type').AsValue.AsText;
    //     TransactionSourceIdentifier := SelectJsonToken(RequestJson, '$.guarantor.identifier').AsValue.AsText;
    //     TransactionSourceAmount := SelectJsonToken(RequestJson, '$.guarantor.amount').AsValue.AsDecimal;

    //     Found := false;
    //     LoanId := 1;

    //     if TransactionInitiatorIdentifierType = 'MEMBER_NUMBER' then begin
    //         Loans.Reset();
    //         Loans.SetRange(Loans."Loan  No.", TransactionInitiatorAccount);
    //         if Loans.FindFirst() then begin
    //             Members.Reset();
    //             Members.SetRange(Members."Mobile Phone No", UpperCase(TransactionSourceIdentifier));
    //             if Members.FindFirst() then begin

    //                 loansG.Reset();
    //                 LoanG.SetRange(LoanG."Loan No", Loans."Loan  No.");
    //                 LoanG.SetRange(LoanG."Member No", Members."No.");
    //                 if not LoanG.FindFirst() then begin
    //                     LoanG.Init();
    //                     loansG."Loan No" := TransactionInitiatorAccount;
    //                     loansG."Loanees  No" := Loans."Client Code";
    //                     loansG."Loanees  Name" := Loans."Client Name";
    //                     loansG."Amont Guaranteed" := TransactionSourceAmount;
    //                     loansG."Member No" := Members."No.";
    //                     LoanG."Mobile No" := Members."Mobile Phone No";
    //                     LoanG."ID No." := Members."ID No.";
    //                     LoanG.Name := Members.Name;
    //                     loansG.Insert();
    //                     Found := true;

    //                     //FnCheckIfGuarantorsMet(TransactionInitiatorAccount);
    //                     LoanProduct.Get(Loans."Loan Product Type");
    //                     CreationMessage := 'Dear ,' + BName.NameStyle(Members."No.") + ', ' + Loans."Client Name" + ' has requested to guarantee ' + LoanProduct."Product Description" + ' of amount Ksh ' + Format(Loans."Requested Amount") + ' .Dial *882# to Accept or Reject.';
    //                     smsManagement.SendSmsWithID(Source::LOAN_GUARANTORS, Members."Mobile Phone No", CreationMessage, Members."No.", Members."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
    //                     SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                 end else begin
    //                     SetResponseStatus(ResponseJson, 'error', 'Error', 'Guarantor Already Exists');
    //                 end;

    //             end else begin
    //                 SetResponseStatus(ResponseJson, 'error', 'Error', 'Member not found');
    //             end;
    //         end else begin
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'Loan not found');
    //         end;
    //     end;//else begin
    //         //SetResponseStatus(ResponseJson, 'error', 'Error', 'Wrong Identifier Type');
    //         // end;
    //     if TransactionInitiatorIdentifierType = 'MSISDN' then begin
    //         Loans.Reset();
    //         Loans.SetRange(Loans."Loan  No.", TransactionInitiatorAccount);
    //         if Loans.FindFirst() then begin
    //             Members.Reset();
    //             Members.SetRange(Members."Mobile Phone No", UpperCase(TransactionSourceIdentifier));
    //             if Members.FindFirst() then begin

    //                 loansG.Reset();
    //                 LoanG.SetRange(LoanG."Loan No", Loans."Loan  No.");
    //                 LoanG.SetRange(LoanG."Member No", Members."No.");
    //                 if not LoanG.FindFirst() then begin
    //                     LoanG.Init();
    //                     loansG."Loan No" := TransactionInitiatorAccount;
    //                     loansG."Loanees  No" := Loans."Client Code";
    //                     loansG."Loanees  Name" := Loans."Client Name";
    //                     loansG."Amont Guaranteed" := TransactionSourceAmount;
    //                     loansG."Member No" := Members."No.";
    //                     LoanG."Mobile No" := Members."Mobile Phone No";
    //                     LoanG."ID No." := Members."ID No.";
    //                     LoanG.Name := Members.Name;
    //                     loansG.Insert();
    //                     Found := true;

    //                     FnCheckIfGuarantorsMet(TransactionInitiatorAccount);
    //                     CreationMessage := 'Dear ,' + BName.NameStyle(Members."No.") + ', ' + Loans."Client Name" + ' has requested to guarantee him ' + Loans."Loan Product Type" + ' of amount Ksh ' + Format(Loans."Requested Amount");
    //                     smsManagement.SendSmsWithID(Source::LOAN_GUARANTORS, Members."Mobile Phone No", CreationMessage, Members."No.", Members."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
    //                     SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                 end else begin
    //                     SetResponseStatus(ResponseJson, 'error', 'Error', 'Guarantor Already Exists');
    //                 end;

    //             end else begin
    //                 SetResponseStatus(ResponseJson, 'error', 'Error', 'Member not found');
    //             end;
    //         end else begin
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'Loan not found');
    //         end;
    //     end;//else begin
    //         //SetResponseStatus(ResponseJson, 'error', 'Error', 'Wrong Identifier Type');
    //         // end;

    //     ResponseJson.Add(Data, DataJson);
    // end;

    // local procedure RemoveGuarantors(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     Guarantors: JsonObject;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     Customer: Record Customer;
    //     Loans: Record "Loans Register";
    //     Found: Boolean;
    //     LoanId: Integer;
    //     LoanG: Record "Loans Guarantee Details";
    //     TransactionInitiatorIdentifierType: Text;
    //     TransactionInitiatorIdentifier: Text;
    //     TransactionInitiatorAccount: Text;
    //     TransactionInitiatorName: Text;
    //     TransactionInitiatorAmount: Decimal;
    //     TransactionSourceIdentifierType: Text;
    //     TransactionSourceIdentifier: Text;
    //     TransactionSourceAccount: Text;
    //     TransactionSourceName: Text;
    //     TransactionSourceAmount: Decimal;
    //     loansG: record "Loans Guarantee Details";
    //     Members: Record Customer;
    // begin

    //     TransactionInitiatorIdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     TransactionInitiatorIdentifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     TransactionInitiatorAccount := SelectJsonToken(RequestJson, '$.loan_id').AsValue.AsText;
    //     TransactionInitiatorName := SelectJsonToken(RequestJson, '$.loan_name').AsValue.AsText;
    //     TransactionInitiatorAmount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;

    //     TransactionSourceIdentifierType := SelectJsonToken(RequestJson, '$.guarantor.identifier_type').AsValue.AsText;
    //     TransactionSourceIdentifier := SelectJsonToken(RequestJson, '$.guarantor.identifier').AsValue.AsText;
    //     TransactionSourceAmount := SelectJsonToken(RequestJson, '$.guarantor.amount').AsValue.AsDecimal;

    //     Found := false;
    //     LoanId := 1;

    //     if TransactionInitiatorIdentifierType = 'MEMBER_NUMBER' then begin
    //         Loans.Reset();
    //         Loans.SetRange(Loans."Loan  No.", TransactionInitiatorAccount);
    //         if Loans.FindFirst() then begin
    //             Members.Reset();
    //             Members.SetRange(Members."No.", UpperCase(TransactionSourceIdentifier));
    //             if Members.FindFirst() then begin
    //                 loansG.Reset();
    //                 LoanG.SetRange(LoanG."Loan No", Loans."Loan  No.");
    //                 LoanG.SetRange(LoanG."Member No", Members."No.");
    //                 if LoanG.FindFirst() then begin
    //                     LoanG.Delete();
    //                     SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                 end else begin
    //                     SetResponseStatus(ResponseJson, 'error', 'Error', 'Guarantor not found');
    //                 end;

    //             end else begin
    //                 SetResponseStatus(ResponseJson, 'error', 'Error', 'Member not found');
    //             end;
    //         end else begin
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'Loan not found');
    //         end;
    //     end else begin
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'Wrong Identifier Type');
    //     end;

    //     ResponseJson.Add(Data, DataJson);
    // end;


    // local procedure GetPendingGuarantorshipRequest(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     Guarantors: JsonObject;
    //     GuarantorsArray: JsonArray;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     Customer: Record Customer;
    //     Loans: Record "Loans Register";
    //     Found: Boolean;
    //     LoanId: Integer;
    //     LoanG: Record "Loans Guarantee Details";
    //     TransactionInitiatorIdentifierType: Text;
    //     TransactionInitiatorIdentifier: Text;
    //     TransactionInitiatorAccount: Text;
    //     TransactionInitiatorName: Text;
    //     TransactionInitiatorAmount: Decimal;
    //     TransactionSourceIdentifierType: Text;
    //     TransactionSourceIdentifier: Text;
    //     TransactionSourceAccount: Text;
    //     TransactionSourceName: Text;
    //     TransactionSourceAmount: Decimal;
    //     loansG: record "Loans Guarantee Details";
    //     Members: Record Customer;
    //     LoanType: Record "Loan Products Setup";

    // begin
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

    //     Found := false;
    //     LoanId := 1;

    //     if IdentifierType = 'MEMBER_NUMBER' then begin
    //         loansG.Reset();
    //         LoanG.SetRange(LoanG."Member No", UpperCase(Identifier));
    //         LoanG.SetFilter(LoanG."Acceptance Status", '%1', loansG."Acceptance Status"::Pending);
    //         if LoanG.FindFirst() then begin
    //             repeat
    //                 Loans.Reset();
    //                 Loans.SetRange(Loans."Loan  No.", LoanG."Loan No");
    //                 if Loans.FindFirst() then begin
    //                     Loans.CalcFields(Loans."Outstanding Balance");
    //                     LoanType.Get(Loans."Loan Product Type");
    //                     if LoanType."Is Mobile Loan?" then begin
    //                         LoanG.CalcFields(LoanG."Outstanding Balance");
    //                         Guarantors.Add('loan_id', LoanG."Loan No");
    //                         Guarantors.Add('loan_name', LoanType."Product Description");
    //                         Guarantors.Add('amount', Format(Loans."Approved Amount"));
    //                         Guarantors.Add('pending_amount', Format(GetGuarantorshipPendingAmount(Loans."Loan  No.", Loans."Approved Amount")));
    //                         Guarantors.Add('status', UpperCase((Format(LoanG."Acceptance Status"))));
    //                         Guarantors.Add('identifier_type', 'MEMBER_NUMBER');
    //                         Guarantors.Add('identifier', Loans."Client Code");
    //                         Guarantors.Add('name', Loans."Client Name");
    //                         GuarantorsArray.Add(Guarantors);
    //                         Clear(Guarantors);
    //                     end;
    //                 end;
    //             until LoanG.Next() = 0;
    //             DataJson.Add('loan_guarantors', GuarantorsArray);
    //             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //         end else begin
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'No Pending Guarantors found');
    //         end;
    //     end else begin
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'Wrong Identifier Type');
    //     end;

    //     ResponseJson.Add(Data, DataJson);
    // end;

    // local procedure AcceptRejectGuarantorship(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     Guarantors: JsonObject;
    //     GuarantorsArray: JsonArray;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     Customer: Record Customer;
    //     Loans: Record "Loans Register";
    //     Found: Boolean;
    //     LoanId: Integer;
    //     TransactionInitiatorIdentifierType: Text;
    //     TransactionInitiatorIdentifier: Text;
    //     TransactionInitiatorAccount: Text;
    //     TransactionInitiatorName: Text;
    //     TransactionInitiatorAmount: Decimal;
    //     TransactionInitiatorOption: text;
    //     TransactionSourceIdentifierType: Text;
    //     TransactionSourceIdentifier: Text;
    //     TransactionSourceAccount: Text;
    //     TransactionSourceName: Text;
    //     TransactionSourceAmount: Decimal;
    //     loansG: record "Loans Guarantee Details";
    //     Members: Record Customer;
    //     Cust: Record Customer;
    //     msg: Text;
    //     CreationMessage: Text[2500];
    //     LProducts: Record "Loan Products Setup";
    //     smsManagement: Codeunit "Sms Management";
    //     Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
    // begin
    //     TransactionInitiatorIdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     TransactionInitiatorIdentifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
    //     TransactionInitiatorAccount := SelectJsonToken(RequestJson, '$.loan_id').AsValue.AsText;
    //     TransactionInitiatorName := SelectJsonToken(RequestJson, '$.loan_name').AsValue.AsText;
    //     TransactionInitiatorAmount := SelectJsonToken(RequestJson, '$.loan_amount_guaranteed').AsValue.AsDecimal;
    //     TransactionInitiatorOption := SelectJsonToken(RequestJson, '$.loan_action').AsValue.AsText;


    //     Found := false;
    //     LoanId := 1;
    //     TransactionInitiatorOption := UpperCase(TransactionInitiatorOption);
    //     // Error('Here');
    //     if (UpperCase(TransactionInitiatorOption) = 'ACCEPT') or (UpperCase(TransactionInitiatorOption) = 'REJECT') then begin

    //         loansG.Reset();
    //         LoansG.SetRange(LoansG."Member No", UpperCase(TransactionInitiatorIdentifier));
    //         LoansG.SetRange(LoansG."Loan No", TransactionInitiatorAccount);
    //         LoansG.SetFilter(LoansG."Acceptance Status", '%1', loansG."Acceptance Status"::Pending);
    //         if LoansG.FindFirst() then begin
    //             Members.get(loansG."Member No");
    //             Members.CalcFields("Current Shares");
    //             if Members."Current Shares" >= TransactionInitiatorAmount then begin
    //                 //   SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //                 Loans.Reset();
    //                 Loans.SetRange(Loans."Loan  No.", LoansG."Loan No");
    //                 if Loans.FindFirst() then begin

    //                     if UpperCase(TransactionInitiatorOption) = 'ACCEPT' then begin
    //                         loansG."Acceptance Status" := loansG."Acceptance Status"::Accepted;
    //                         loansG."Amont Guaranteed" := TransactionInitiatorAmount;
    //                         loansG."ID No." := Members."ID No.";
    //                         loansG.Name := Members.Name;
    //                         loansG."Mobile No" := Members."Mobile Phone No";
    //                         loansG.Modify();
    //                         Cust.Get(Loans."Client Code");
    //                         CreationMessage := 'Dear, ' + BName.NameStyle(Loans."Client Code") + ',  ' + Members.Name + ' has approved your guarantorship request of ksh' + Format(TransactionInitiatorAmount) + '.';
    //                         smsManagement.SendSmsWithID(Source::LOAN_POSTED, Cust."Mobile Phone No", CreationMessage, Cust."No.", Cust."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
    //                         FnCheckIfGuarantorsMet(TransactionInitiatorAccount);
    //                         SetResponseStatus(ResponseJson, 'success', 'Success', 'Guarantorship accepted successfully');
    //                     end;
    //                     if UpperCase(TransactionInitiatorOption) = 'REJECT' then begin
    //                         loansG."Acceptance Status" := loansG."Acceptance Status"::Declined;
    //                         loansG.Modify();
    //                         SetResponseStatus(ResponseJson, 'success', 'Success', 'Guarantorship declined successfully');
    //                     end;
    //                 end;
    //             end else begin
    //                 SetResponseStatus(ResponseJson, 'error', 'Error', 'You dont have enough shares to guarantee this loan.');
    //             end;
    //         end else begin
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'No Pending Guarantors found');

    //         end;
    //     end else begin
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'Option not Found');
    //     end;
    //     //ResponseJson.Add(Data, DataJson);
    // end;

    // local procedure GetLoansGuaranteedByMember(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     Guarantors: JsonObject;
    //     GuarantorsArray: JsonArray;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     Customer: Record Customer;
    //     Loans: Record "Loans Register";
    //     Found: Boolean;
    //     LoanId: Integer;
    //     LoanG: Record "Loans Guarantee Details";
    //     TransactionInitiatorIdentifierType: Text;
    //     TransactionInitiatorIdentifier: Text;
    //     TransactionInitiatorAccount: Text;
    //     TransactionInitiatorName: Text;
    //     TransactionInitiatorAmount: Decimal;
    //     TransactionSourceIdentifierType: Text;
    //     TransactionSourceIdentifier: Text;
    //     TransactionSourceAccount: Text;
    //     TransactionSourceName: Text;
    //     TransactionSourceAmount: Decimal;
    //     loansG: record "Loans Guarantee Details";
    //     Members: Record Customer;
    //     Lproduct: Record "Loan Products Setup";

    // begin
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

    //     Found := false;
    //     LoanId := 1;

    //     if IdentifierType = 'MEMBER_NUMBER' then begin
    //         loansG.Reset();
    //         LoanG.SetRange(LoanG."Member No", UpperCase(Identifier));
    //         LoanG.SetFilter(LoanG."Acceptance Status", '%1', loansG."Acceptance Status"::Accepted);
    //         if LoanG.FindFirst() then begin
    //             repeat
    //                 Loans.Reset();
    //                 Loans.SetRange(Loans."Loan  No.", LoanG."Loan No");
    //                 Loans.SetAutoCalcFields(loans."Outstanding Balance");
    //                 //Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
    //                 if Loans.FindFirst() then begin
    //                     Lproduct.Get(Loans."Loan Product Type");
    //                     Guarantors.Add('loan_id', LoanG."Loan No");
    //                     Guarantors.Add('loan_name', Lproduct."Product Description");
    //                     Guarantors.Add('amount', LoanG."Amont Guaranteed");
    //                     Guarantors.Add('status', UpperCase(Format(Loans."Loans Category-SASRA")));
    //                     Guarantors.Add('identifier_type', 'MEMBER_NUMBER');
    //                     Guarantors.Add('identifier', Loans."Client Code");
    //                     Guarantors.Add('name', Loans."Client Name");
    //                     GuarantorsArray.Add(Guarantors);
    //                     Clear(Guarantors);
    //                 end;
    //             until LoanG.Next() = 0;
    //             DataJson.Add('loan_guarantors', GuarantorsArray);
    //             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //         end else begin
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'You have not guaranteed any loans');
    //         end;
    //     end else begin
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'Wrong Identifier Type');
    //     end;

    //     ResponseJson.Add(Data, DataJson);
    // end;

    local procedure GetLoansGuaranteedPortal(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        Guarantors: JsonObject;
        GuarantorsArray: JsonArray;
        IdentifierType: Text;
        Identifier: Text;
        Customer: Record Customer;
        Loans: Record "Loans Register";
        Found: Boolean;
        LoanId: Integer;
        LoanG: Record "Loans Guarantee Details";
        TransactionInitiatorIdentifierType: Text;
        TransactionInitiatorIdentifier: Text;
        TransactionInitiatorAccount: Text;
        TransactionInitiatorName: Text;
        TransactionInitiatorAmount: Decimal;
        TransactionSourceIdentifierType: Text;
        TransactionSourceIdentifier: Text;
        TransactionSourceAccount: Text;
        TransactionSourceName: Text;
        TransactionSourceAmount: Decimal;
        loansG: record "Loans Guarantee Details";
        Members: Record Customer;
        Lproduct: Record "Loan Products Setup";
        SaccoGen: Record "Sacco General Set-Up";
        GuaranteedAmount: Decimal;
        Vendor: Record Vendor;
        Deposits: Decimal;
        FreeShares: Decimal;
    begin
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        GuaranteedAmount := 0;
        Found := false;
        LoanId := 1;
        SaccoGen.Get();
        if IdentifierType = 'MSISDN' then begin
            Customer.Reset();
            Customer.SetRange(Customer."Mobile Phone No", Identifier);
            IF Customer.FindFirst() then BEGIN
                loansG.Reset();
                LoanG.SetRange(LoanG."Member No", Customer."No.");
                //LoanG.SetFilter(LoanG."Acceptance Status", '%1', loansG."Acceptance Status"::Accepted);
                LoanG.SetAutoCalcFields(LoanG."Loans Outstanding");
                LoanG.SetFilter(LoanG."Loans Outstanding", '>%1', 0);
                if LoanG.FindSet() then begin
                    LoanG.CalcSums(LoanG."Amont Guaranteed");
                    GuaranteedAmount := LoanG."Amont Guaranteed";
                end;

                Deposits := 0;
                FreeShares := 0;
                Vendor.Reset();
                Vendor.SetRange(Vendor."BOSA Account No", Customer."No.");
                Vendor.SetRange(Vendor."Account Type", '102');
                Vendor.SetAutoCalcFields(Vendor.Balance);
                IF Vendor.findfirst then begin
                    Deposits := Vendor.Balance * SaccoGen."Guarantors Multiplier";
                end;

                FreeShares := Deposits - GuaranteedAmount;
                // Error('GuaranteedAmount%1Deposits%2Setup%3Balance%4', GuaranteedAmount, Deposits,SaccoGen."Guarantors Multiplier",Vendor.Balance);
                loansG.Reset();
                LoanG.SetRange(LoanG."Member No", Customer."No.");
                //LoanG.SetFilter(LoanG."Acceptance Status", '%1', loansG."Acceptance Status"::Accepted);
                LoanG.SetAutoCalcFields(LoanG."Loans Outstanding");
                LoanG.SetFilter(LoanG."Loans Outstanding", '>%1', 0);
                if LoanG.FindFirst() then begin
                    repeat
                        Loans.Reset();
                        Loans.SetRange(Loans."Loan  No.", LoanG."Loan No");
                        Loans.SetAutoCalcFields(loans."Outstanding Balance");
                        Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);

                        if Loans.FindFirst() then begin
                            Members.Get(Loans."Client Code");
                            Guarantors.Add('member_number', Loans."Client Code");
                            Guarantors.Add('name', Loans."Client Name");
                            Guarantors.Add('phone_number', Members."Mobile Phone No");
                            Guarantors.Add('loan_number', LoanG."Loan No");
                            Lproduct.Get(Loans."Loan Product Type");
                            Guarantors.Add('loan_type', Lproduct."Product Description");
                            Guarantors.Add('amount_guaranteed', LoanG."Amont Guaranteed");
                            Guarantors.Add('loan_category', UpperCase(Format(Loans."Loans Category-SASRA")));
                            Guarantors.Add('loan_balance', Loans."Outstanding Balance");
                            Guarantors.Add('free_shares', FreeShares);
                            Guarantors.Add('application_date', Loans."Application Date");
                            Guarantors.Add('expected_completion_date', Loans."Expected Date of Completion");
                            GuarantorsArray.Add(Guarantors);
                            Clear(Guarantors);
                        end;
                    until LoanG.Next() = 0;
                    //  DataJson.Add('loan_guarantors', GuarantorsArray);
                    SetResponseStatus(ResponseJson, 'success', 'Success', 'Member’s loans guaranteed list has been fetched successfully');
                end else begin
                    SetResponseStatus(ResponseJson, 'error', 'Error', 'You have not guaranteed any loans');
                end;
            END ELSE
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Member not found');
        end else begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Wrong Identifier Type');
        end;

        ResponseJson.Add(Data, GuarantorsArray);
    end;

    // local procedure GetLoanswithGuarantors(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     LoanJson: JsonObject;
    //     LoanObject: JsonObject;
    //     Guarantors: JsonObject;
    //     GuarantorsArray: JsonArray;
    //     GuarantorObject: JsonObject;
    //     LoanArray: JsonArray;
    //     Soft: JsonArray;
    //     IdentifierType: Text;
    //     Identifier: Text;
    //     Customer: Record Customer;
    //     Loans: Record "Loans Register";
    //     LoanX: Record "Loans Register";
    //     LoansRec: Record "Loans Register";
    //     Found: Boolean;
    //     LoanId: Integer;
    //     LoanG: Record "Loans Guarantee Details";
    //     LoansWithGuarantors: Record "Loans Guarantee Details";
    //     TransactionInitiatorIdentifierType: Text;
    //     TransactionInitiatorIdentifier: Text;
    //     TransactionInitiatorAccount: Text;
    //     TransactionInitiatorName: Text;
    //     TransactionInitiatorAmount: Decimal;
    //     TransactionSourceIdentifierType: Text;
    //     TransactionSourceIdentifier: Text;
    //     TransactionSourceAccount: Text;
    //     TransactionSourceName: Text;
    //     TransactionSourceAmount: Decimal;
    //     loansG: record "Loans Guarantee Details";
    //     Members: Record Customer;
    //     LoanTypes: Record "Loan Products Setup";
    //     DataArray: JsonArray;
    //     GuarantorArray: JsonArray;

    // begin
    //     IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
    //     Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

    //     Found := false;
    //     LoanId := 1;

    //     if IdentifierType = 'MEMBER_NUMBER' then begin
    //         loanX.Reset();
    //         LoanX.SetRange(LoanX."Client Code", UpperCase(Identifier));
    //         LoanX.SetRange(LoanX.Posted, false);
    //         LoanX.SetAutoCalcFields(LoanX."Mobile Loan", LoanX."Requires Guarantors Mobile");
    //         LoanX.SetRange(LoanX."Mobile Loan", true);
    //         LoanX.SetRange(LoanX."Approval Status", LoanX."Approval Status"::Pending);
    //         LoanX.SetRange(LoanX."Requires Guarantors Mobile", true);
    //         LoanX.SetRange(LoanX."Archive Loan", false);
    //         if LoanX.FindFirst() then begin
    //             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
    //             repeat
    //                 LoanTypes.Get(LoanX."Loan Product Type");
    //                 LoanX.CalcFields(LoanX."No Of Guarantors", LoanX."No Of Guarantors Needed", LoanX."Has Pending Guarantors");
    //                 DataJson.Add('loan_id', LoanX."Loan  No.");
    //                 DataJson.Add('loan_name', LoanTypes."Product Description");
    //                 DataJson.Add('amount', LoanX."Approved Amount");
    //                 DataJson.Add('status', UpperCase(Format(Loans."Approval Status")));
    //                 DataJson.Add('number_of_guarantors_added', LoanX."No Of Guarantors");
    //                 DataJson.Add('number_of_guarantors_needed', LoanX."No Of Guarantors Needed");
    //                 DataJson.Add('has_pending_guarantors', UpperCase(Format(LoanX."Has Pending Guarantors")));
    //                 loanG.Reset();
    //                 LoanG.SetRange(LoanG."Loan No", LoanX."Loan  No.");
    //                 if LoanG.FindFirst() then begin
    //                     repeat
    //                         Members.Reset();
    //                         Members.SetRange(Members."No.", LoanG."Member No");
    //                         if Members.FindFirst() then begin
    //                             Guarantors.Add('guarantor_identifier_type', 'MSISDN/ID/Passport');
    //                             Guarantors.Add('guarantor_identifier', Members."Mobile Phone No");
    //                             Guarantors.Add('guarantor_member_number', Members."No.");
    //                             Guarantors.Add('guarantor_name', Members.Name);
    //                             Guarantors.Add('amount_guaranteed', LoanG."Amont Guaranteed");
    //                             Guarantors.Add('status', UpperCase(Format(LoanG."Acceptance Status")));
    //                             LoanArray.Add(Guarantors);
    //                             Clear(Guarantors);
    //                         end;
    //                     until LoanG.Next() = 0;

    //                 end;
    //                 DataJson.Add('guarantors', LoanArray);
    //                 Clear(LoanArray);
    //                 DataArray.Add(DataJson);

    //                 Clear(DataJson);
    //             until LoanX.Next() = 0;


    //         end else
    //             SetResponseStatus(ResponseJson, 'error', 'Error', 'No Loan found');


    //     end;

    //     ResponseJson.Add(Data, DataArray);
    // end;


    local procedure GetLoanGuarantorsPortal(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        LoanJson: JsonObject;
        LoanObject: JsonObject;
        Guarantors: JsonObject;
        GuarantorsArray: JsonArray;
        GuarantorObject: JsonObject;
        LoanArray: JsonArray;
        Soft: JsonArray;
        IdentifierType: Text;
        Identifier: Text;
        Customer: Record Customer;
        Loans: Record "Loans Register";
        LoanX: Record "Loans Register";
        LoansRec: Record "Loans Register";
        Found: Boolean;
        LoanId: Integer;
        LoanG: Record "Loans Guarantee Details";
        LoansWithGuarantors: Record "Loans Guarantee Details";
        TransactionInitiatorIdentifierType: Text;
        TransactionInitiatorIdentifier: Text;
        TransactionInitiatorAccount: Text;
        TransactionInitiatorName: Text;
        TransactionInitiatorAmount: Decimal;
        TransactionSourceIdentifierType: Text;
        TransactionSourceIdentifier: Text;
        TransactionSourceAccount: Text;
        TransactionSourceName: Text;
        TransactionSourceAmount: Decimal;
        loansG: record "Loans Guarantee Details";
        Members: Record Customer;
        LoanTypes: Record "Loan Products Setup";
        DataArray: JsonArray;
        GuarantorArray: JsonArray;
        LoanNumber: Text[200];


    begin
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        LoanNumber := SelectJsonToken(RequestJson, '$.loan_number').AsValue.AsText;
        Found := false;
        LoanId := 1;

        if IdentifierType = 'MSISDN' then begin
            Customer.Reset();
            Customer.SetRange(Customer."Mobile Phone No", Identifier);
            loanX.Reset();
            LoanX.SetRange(LoanX."Loan  No.", LoanNumber);
            if LoanX.FindFirst() then begin
                SetResponseStatus(ResponseJson, 'success', 'Success', 'Member’s loans guarantors list has been fetched successfully');
                LoanX.CalcFields(LoanX."Outstanding Balance");
                repeat
                    loanG.Reset();
                    LoanG.SetRange(LoanG."Loan No", LoanX."Loan  No.");
                    if LoanG.FindFirst() then begin
                        repeat
                            Members.Reset();
                            Members.SetRange(Members."No.", LoanG."Member No");
                            if Members.FindFirst() then begin
                                Guarantors.Add('member_number', Members."No.");
                                Guarantors.Add('guarantor_name', Members.Name);
                                Guarantors.Add('phone_number', Members."Mobile Phone No");
                                Guarantors.Add('amount_guaranteed', LoanG."Amont Guaranteed");
                                Guarantors.Add('status', UpperCase(Format(LoanG."Acceptance Status")));
                                Guarantors.Add('loan_balance', LoanX."Outstanding Balance");
                                LoanArray.Add(Guarantors);
                                Clear(Guarantors);
                            end;
                        until LoanG.Next() = 0;

                    end;
                //DataJson.Add('guarantors', LoanArray);
                //Clear(LoanArray);
                //DataArray.Add(DataJson);
                //Clear(DataJson);
                until LoanX.Next() = 0;

            end else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'No Loan found');


        end;

        ResponseJson.Add(Data, LoanArray);
    end;

    // local procedure BalanceEnquiryATM(RequestJson: JsonObject) ResponseJson: JsonObject
    // var
    //     DataJson: JsonObject;
    //     InstitutionJson: JsonObject;
    //     institutionArray: JsonArray;
    //     AccountJson: JsonObject;
    //     AccountArray: JsonArray;
    //     AdditionJson: JsonObject;
    //     AdditionArray: JsonArray;
    //     Keys: Text;
    //     Values: Text;
    //     CreditAccount: Text;
    //     DebitAccount: Text;
    //     InstitutionCode: text;
    //     InstitutionName: Text;
    //     AccountType: Text;
    //     AccountNumber: Text;
    //     Customer: Record Customer;
    //     Vend: Record Vendor;
    //     LoanResgister: Record "Loans Register";
    //     Found: Boolean;
    //     MobilePhoneNumber: Text;
    //     AccountTypes: Record "Account Types-Saving Products";
    // begin
    //     InstitutionCode := SelectJsonToken(RequestJson, '$.institution_code').AsValue.AsText;
    //     InstitutionName := SelectJsonToken(RequestJson, '$.institution_name').AsValue.AsText;
    //     CreditAccount := SelectJsonToken(RequestJson, '$.credit_account').AsValue.AsText;
    //     DebitAccount := SelectJsonToken(RequestJson, '$.debit_account').AsValue.AsText;
    //     Keys := SelectJsonToken(RequestJson, '$.key').AsValue.AsText;
    //     Values := SelectJsonToken(RequestJson, '$.value').AsValue.AsText;



    //     Vend.Reset();
    //     Vend.SetRange(Vend."BOSA Account No", DebitAccount);
    //     Vend.SetRange(Vend."Account Type", '103');
    //     if Vend.FindFirst() then begin



    //         Vend.CalcFields(Balance);
    //         SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

    //         InstitutionJson.Add('institution_code', InstitutionCode);
    //         InstitutionJson.Add('institution_name', InstitutionName);
    //         institutionArray.Add(InstitutionJson);
    //         Clear(InstitutionJson);
    //         DataJson.Add('institution', institutionArray);

    //         AccountJson.Add('debit_account', DebitAccount);
    //         AccountJson.Add('book_balance', Vend.Balance);
    //         AccountJson.Add('cleared_balance', Vend.Balance);
    //         AccountJson.Add('currency', 'KES');
    //         AccountArray.Add(AccountJson);
    //         Clear(AccountJson);
    //         DataJson.Add('account', AccountArray);

    //         AdditionJson.Add('key', Keys);
    //         AdditionJson.Add('value', Values);
    //         AdditionArray.Add(AdditionJson);
    //         Clear(AdditionJson);
    //         DataJson.Add('additional_info', AdditionArray);



    //         Found := true;

    //     end;



    //     if Found = false then begin
    //         SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
    //     end;
    //     ResponseJson.Add(Data, DataJson);
    // end;

    // local procedure GetGrossSalary(AccountNo: Code[20]; ProductType: Code[10]) GrossSalary: Decimal
    // var
    //     saccoAccount: Record Vendor;
    //     SalaryProcessingLines: Record "Salary Details";
    //     PayrollMonthlyTransactions: Record "prPeriod Transactions.";
    //     SalBuffer: Record "Salary Processing Lines";
    //     SalEnd: array[5] of Date;
    //     SalStart: array[5] of Date;
    //     i: Integer;
    //     SalaryAmount: array[5] of Decimal;
    //     EmployerCode: Code[30];
    //     Members: Record Customer;
    // begin

    //     saccoAccount.RESET;
    //     saccoAccount.SETRANGE("No.", AccountNo);
    //     IF saccoAccount.FINDFIRST THEN BEGIN
    //         Members.GET(saccoAccount."BOSA Account No");
    //         EmployerCode := Members."Employer Code";
    //         GrossSalary := 0;
    //         FOR i := 5 DOWNTO 1 DO BEGIN
    //             SalStart[i] := 0D;
    //             SalStart[i] := CALCDATE('-' + FORMAT(i) + 'M-CM', TODAY);
    //             SalEnd[i] := 0D;
    //             SalEnd[i] := CALCDATE('CM', SalStart[i]);
    //             SalaryAmount[i] := 0;
    //             SalaryProcessingLines.RESET;
    //             SalaryProcessingLines.SETRANGE(SalaryProcessingLines."Posting Date", SalStart[i], SalEnd[i]);
    //             SalaryProcessingLines.SETRANGE(SalaryProcessingLines."FOSA Account No", AccountNo);
    //             SalaryProcessingLines.SETFILTER(SalaryProcessingLines."Salary Type", '%1|%2', SalaryProcessingLines."Salary Type"::Salary, SalaryProcessingLines."Salary Type"::Pension);
    //             //     IF ProductType = 'M_OD' THEN
    //             //       SalaryProcessingLines.SETFILTER(SalaryProcessingLines."Document No.",'<> STAFF WELFARE MAY-23' );//overdraft
    //             IF SalaryProcessingLines.FINDFIRST THEN BEGIN
    //                 SalaryAmount[i] := SalaryProcessingLines."Gross Amount";
    //             END ELSE BEGIN
    //                 PayrollMonthlyTransactions.RESET;
    //                 PayrollMonthlyTransactions.SETRANGE(PayrollMonthlyTransactions."Employee Code", saccoAccount."Personal No.");
    //                 PayrollMonthlyTransactions.SETRANGE(PayrollMonthlyTransactions."Payroll Period", SalStart[i], SalEnd[i]);
    //                 PayrollMonthlyTransactions.SETRANGE(PayrollMonthlyTransactions."Transaction Code", 'NPAY');
    //                 IF PayrollMonthlyTransactions.FINDFIRST THEN
    //                     SalaryAmount[i] := PayrollMonthlyTransactions.Amount;
    //             END;
    //         END;



    //         IF (SalaryAmount[1] = 0) OR (SalaryAmount[2] = 0) OR (SalaryAmount[3] = 0) THEN BEGIN
    //             GrossSalary := 0;
    //         END;

    //         GrossSalary := SalaryAmount[1];
    //         FOR i := 2 TO 3 DO BEGIN
    //             IF SalaryAmount[i] < GrossSalary THEN
    //                 GrossSalary := SalaryAmount[i];
    //         END;

    //         IF Members."Employer Code" = 'POSTAL CORP' THEN BEGIN
    //             GrossSalary := SalaryAmount[1]; //initialising with one sal
    //             FOR i := 2 TO 5 DO BEGIN //starting loop with the second salary
    //                 IF SalaryAmount[i] > 0 THEN BEGIN //if the second or any of sal is present thats when we compare
    //                     IF GrossSalary = 0 THEN GrossSalary := SalaryAmount[i]; //if the first sal was 0, we reinitialize before comparing
    //                     IF SalaryAmount[i] < GrossSalary THEN
    //                         GrossSalary := SalaryAmount[1];
    //                 END;
    //             END;
    //         END;

    //         //Remove in march 2024
    //         IF Members."Employer Code" = 'CDL' THEN BEGIN
    //             IF (SalaryAmount[2] = 0) OR (SalaryAmount[3] = 0) OR (SalaryAmount[4] = 0) THEN BEGIN
    //                 GrossSalary := 0;
    //             END;

    //             GrossSalary := SalaryAmount[2];
    //             FOR i := 3 TO 4 DO BEGIN
    //                 IF SalaryAmount[i] < GrossSalary THEN
    //                     GrossSalary := SalaryAmount[i];
    //             END;
    //         END;

    //     END;

    //     EXIT(GrossSalary);
    // end;

    // local procedure GetGrossSalaryT(AccountNo: Code[20]; ProductType: Code[10]) GrossSalary: Decimal
    // var
    //     saccoAccount: Record Vendor;
    //     SalaryProcessingLines: Record "Salary Details";
    //     SalBuffer: Record "Salary Details";
    //     SalEnd: Date;
    //     SalStart: Date;
    //     i: Integer;
    //     Count: Integer;
    //     SalaryAmount1: Decimal;
    //     SalaryAmount2: Decimal;
    //     STO: Record "Standing Orders";
    //     SalaryAmount3: Decimal;
    //     STODeductions: Decimal;
    //     EmployerCode: Code[50];
    //     GrossAmount: Decimal;
    //     TotalLoans: Decimal;
    //     Members: record Customer;
    //     PayrollMonthlyTransactions: Record "prPeriod Transactions.";
    //     QualAmount: Decimal;
    //     LProducts: record "Loan Products Setup";
    //     LProduct: record "Loan Products Setup";
    //     Loans: record "Loans Register";
    //     SeventyFiveGross: Decimal;
    //     LoanCount: Integer;
    // begin

    //     saccoAccount.RESET;
    //     saccoAccount.SETRANGE("No.", AccountNo);
    //     saccoAccount.SetRange(saccoAccount."Salary Processing", true);
    //     IF saccoAccount.FINDFIRST THEN BEGIN
    //         SalaryProcessingLines.RESET;
    //         SalaryProcessingLines.SETRANGE(SalaryProcessingLines."FOSA Account No", AccountNo);
    //         SalaryProcessingLines.SETFILTER(SalaryProcessingLines."Salary Type", '%1|%2', SalaryProcessingLines."Salary Type"::Salary, SalaryProcessingLines."Salary Type"::Pension);
    //         while SalaryProcessingLines.FINDLAST do begin
    //             Count += 1;
    //             IF Count = 1 then BEGIN
    //                 SalaryAmount1 := SalaryProcessingLines."Net Salary";
    //             END;
    //             IF Count = 2 then BEGIN
    //                 SalaryAmount2 := SalaryProcessingLines."Net Salary";
    //             END;
    //             IF Count = 3 then BEGIN
    //                 SalaryAmount3 := SalaryProcessingLines."Net Salary";
    //             END;

    //             if Count > 3 then
    //                 BREAK;
    //         END;



    //         PayrollMonthlyTransactions.RESET;
    //         PayrollMonthlyTransactions.SETRANGE(PayrollMonthlyTransactions."Employee Code", saccoAccount."Personal No.");
    //         PayrollMonthlyTransactions.SetFilter(PayrollMonthlyTransactions."Transaction Code", 'NPAY');
    //         while PayrollMonthlyTransactions.FINDLAST do begin
    //             //IF PayrollMonthlyTransactions.FindLast() then begin
    //             //  repeat
    //             Count += 1;
    //             IF Count = 1 then BEGIN
    //                 SalaryAmount1 := PayrollMonthlyTransactions.Amount;
    //             END;
    //             IF Count = 2 then BEGIN
    //                 SalaryAmount2 := PayrollMonthlyTransactions.Amount;
    //             END;
    //             IF Count = 3 then BEGIN
    //                 SalaryAmount3 := PayrollMonthlyTransactions.Amount;
    //             END;
    //             // UNTIL PayrollMonthlyTransactions.Next()=0;
    //             if Count > 3 then
    //                 BREAK;
    //         END;





    //         GrossAmount := 0;
    //         IF SalaryAmount1 < SalaryAmount2 then
    //             QualAmount := SalaryAmount1
    //         else
    //             QualAmount := SalaryAmount2;

    //         if QualAmount < SalaryAmount3 then
    //             GrossAmount := QualAmount
    //         else
    //             GrossAmount := SalaryAmount3;




    //         SeventyFiveGross := 0;
    //         LProduct.Get(ProductType);
    //         //LProduct.TestField(LProduct."Loan Appraisal %");
    //         if LProduct.Code <> 'A03' then begin
    //             SeventyFiveGross := LProduct."Loan Appraisal %" / 100 * GrossAmount;


    //             TotalLoans := 0;

    //             Loans.Reset();
    //             Loans.SetRange(Loans."Loan Product Type", LProducts.Code);
    //             Loans.SetRange(Loans."Client Code", saccoAccount."BOSA Account No");
    //             Loans.SetAutoCalcFields(Loans."Outstanding Balance");
    //             Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
    //             if Loans.FindFirst() then begin
    //                 TotalLoans := TotalLoans + Loans.Repayment;
    //             end;
    //             STO.RESET;
    //             STO.SETRANGE(STO."Source Account No.", saccoAccount."No.");
    //             STO.SETRANGE(STO.Status, STO.Status::Approved);
    //             IF STO.FINDSET THEN BEGIN
    //                 REPEAT
    //                     STO.CALCFIELDS(STO."Allocated Amount");
    //                     STODeductions += STO."Allocated Amount";
    //                 UNTIL STO.NEXT = 0;
    //             END;


    //             GrossSalary := SeventyFiveGross - (STODeductions);

    //             GrossSalary := ROUND(GrossSalary / ((LProduct."Interest rate" / 12 / 100) / (1 - POWER((1 + (LProduct."Interest rate" / 12 / 100)), -LProduct."Default Installements"))), 100, '<');

    //             if GrossSalary > LProduct."Max. Loan Amount" then
    //                 GrossSalary := LProduct."Max. Loan Amount";

    //         end;

    //         IF (SalaryAmount1 = 0) OR (SalaryAmount2 = 0) OR (SalaryAmount3 = 0) THEN BEGIN
    //             GrossSalary := 0;
    //         END;
    //         LProduct.Get(ProductType);
    //         if LProduct.Code = 'A03' then begin
    //             Loans.Reset();
    //             Loans.SetRange(Loans."Loan Product Type", 'A03');
    //             Loans.SetRange(Loans."Client Code", saccoAccount."BOSA Account No");
    //             Loans.SetFilter(Loans."Outstanding Balance", '<=%1', 0);
    //             IF Loans.FindFirst() then begin
    //                 LoanCount := Loans.Count;
    //             end;
    //             if LoanCount = 0 then
    //                 LoanCount := 1;
    //             GrossSalary := 0;
    //             GrossSalary := LoanCount * 5000;
    //             if GrossSalary > LProduct."Maximimum Amount Salaried"
    //             then
    //                 GrossSalary := LProduct."Maximimum Amount Salaried"
    //             else
    //                 GrossSalary := GrossSalary;

    //         end;

    //         if GrossSalary < 0 then
    //             GrossSalary := 0;

    //         /// Error('Gross%1Max%2', GrossAmount, LProduct."Max. Loan Amount");
    //     END else begin
    //         saccoAccount.RESET;
    //         saccoAccount.SETRANGE("No.", AccountNo);
    //         IF saccoAccount.FINDFIRST THEN BEGIN
    //             LProduct.Get(ProductType);
    //             if LProduct.Code = 'A03' then begin
    //                 GrossSalary := LProduct."Maximimum Amount Non-Salaried";
    //             end;


    //         end;
    //     end;
    //     //Error('Gross--%1Max--%2', GrossAmount, LProduct."Max. Loan Amount");
    //     EXIT(GrossSalary);
    // END;

    // local procedure GetProductCharges(ProductCode: Code[20]; AppliedAmount: Decimal) Charge: Decimal;
    // begin
    //     LoanCharges.Reset();
    //     LoanCharges.SetRange(Code, ProductCode);
    //     if LoanCharges.Find('-') then begin
    //         repeat
    //             if LoanCharges."Use Perc" then begin
    //                 Charge += AppliedAmount * LoanCharges.Percentage / 100;
    //             end else begin
    //                 Charge += LoanCharges.Amount;
    //             end;
    //         until LoanCharges.Next() = 0;
    //     end;
    //     exit(Charge);
    // end;

    // local procedure GetSalaryLoanQualifiedAmount(AccountNo: Code[20]; LoanProductType: Code[20]; var LoanLimit: Decimal; var Remark: Text[250]): Decimal
    // var
    //     LoanBalance: Decimal;
    //     MaxLoanAmount: Decimal;
    //     saccoAccount: Record Vendor;
    //     LoanType: Record "Loan Products Setup";
    //     LoanRep: Decimal;
    //     nDays: Decimal;
    //     DepAmt: Decimal;
    //     Loans: Record "Loans Register";
    //     SaccoSetup: Record "Sacco General Set-Up";
    //     RatingLoanLimit: Decimal;
    //     PenaltyCounter: Record "Penalty Counter";
    //     LoansRegister: Record "Loans Register";
    //     MemberLedgerEntry: Record "Member Ledger Entry";
    //     NumberOfMonths: Integer;
    //     DayLoanPaid: Date;
    //     Continue: Boolean;
    //     SalaryProcessingLines: Record "Salary Processing Lines";
    //     PayrollMonthlyTransactions: Record "Payroll Monthly Transactions.";
    //     MaxLoanAmtPossible: Decimal;
    //     SalBuffer: Record "Salary Processing Lines";
    //     StandingOrders: Record "Standing Orders";
    //     DepAcc: Record Customer;
    //     Salary1: Decimal;
    //     Salary2: Decimal;
    //     Salary3: Decimal;
    //     SalEnd: array[5] of Date;
    //     SalStart: array[5] of Date;
    //     NetSal: Decimal;
    //     IntAmt: Decimal;
    //     ProdFac: Record "Loan Products Setup";
    //     GrossSalaryAmount: Decimal;
    //     NetSalaryAmount: Decimal;
    //     SalaryLoans: Record "Loans Register";
    //     STO: Record "Standing Orders";
    //     LoanRepayments: Decimal;
    //     STODeductions: Decimal;
    //     SameLoanRepayments: Decimal;
    //     SameLoanOutstandingBal: Decimal;
    //     CoopSetup: Record "Sky Mobile Setup";
    //     TotalCharge: Decimal;
    //     SaccoFee: Decimal;
    //     VendorCommission: Decimal;
    //     SMSCharge: Decimal;
    //     Members: Record Customer;
    //     SaccoAcc: Record Vendor;
    //     i: Integer;
    //     SalaryAmount: array[5] of Decimal;
    //     EmployerCode: Code[30];
    //     LoanRepaymentRecFromSal: Decimal;
    //     SalaryPostingCharge: Decimal;
    // begin
    //     MaxLoanAmount := 0;
    //     Remark := '';
    //     GrossSalaryAmount := 0;
    //     saccoAccount.RESET;
    //     saccoAccount.SETRANGE("No.", AccountNo);
    //     IF saccoAccount.FINDFIRST THEN BEGIN

    //         Members.GET(saccoAccount."BOSA Account No");
    //         IF Members.Status <> Members.Status::Active THEN BEGIN
    //             LoanLimit := 0;
    //             Remark := 'Your Member Account is not active';
    //             EXIT;
    //         END;

    //         IF Members."Loan Defaulter" = TRUE THEN BEGIN
    //             LoanLimit := 0;
    //             Remark := 'You are not eligible for this product because you are listed as a defaulter';
    //             EXIT;
    //         END;


    //         SaccoAcc.RESET;
    //         SaccoAcc.SETRANGE("No.", AccountNo);
    //         IF SaccoAcc.FINDFIRST THEN BEGIN
    //             IF SaccoAcc.Status <> SaccoAcc.Status::Active THEN BEGIN
    //                 LoanLimit := 0;
    //                 Remark := 'Your depopsit contribution is inactive';
    //                 EXIT;
    //             END;
    //         END;


    //         IF LoanType.GET(LoanProductType) THEN BEGIN
    //             LoanBalance := 0;

    //             Loans.RESET;
    //             Loans.SETRANGE("Client Code", saccoAccount."BOSA Account No");
    //             Loans.SETRANGE("Loan Product Type", LoanProductType);
    //             Loans.SETFILTER(Loans."Loan Product Type", 'A01');
    //             Loans.SETFILTER("Outstanding Balance", '>0');
    //             IF Loans.FINDSET THEN BEGIN
    //                 REPEAT
    //                     Loans.CALCFIELDS("Outstanding Balance");
    //                     LoanBalance += Loans."Outstanding Balance";
    //                 UNTIL Loans.NEXT = 0;
    //                 IF LoanBalance > 0 THEN BEGIN
    //                     MaxLoanAmount := 0;
    //                     Remark := 'You already have an existing loan';
    //                     EXIT;
    //                 END;
    //             END;

    //             MaxLoanAmount := 0;

    //             EmployerCode := Members."Employer Code";

    //             MaxLoanAmount := GetGrossSalary(AccountNo, LoanProductType);

    //             LoanLimit := 0;
    //             LoanRepaymentRecFromSal := 0;
    //             SalaryLoans.RESET;
    //             SalaryLoans.SETRANGE(SalaryLoans."Client Code", saccoAccount."BOSA Account No");
    //             SalaryLoans.SETRANGE(SalaryLoans."Recovery Mode", SalaryLoans."Recovery Mode"::Salary);
    //             SalaryLoans.SETFILTER(SalaryLoans."Outstanding Balance", '>0');
    //             IF SalaryLoans.FINDSET THEN BEGIN
    //                 REPEAT
    //                     SalaryLoans.CALCFIELDS(SalaryLoans."Outstanding Balance");
    //                     LoanRepaymentRecFromSal += SalaryLoans.Repayment;
    //                     IF SalaryLoans."Loan Product Type" = LoanType.Code THEN BEGIN
    //                         SameLoanRepayments += SalaryLoans.Repayment;
    //                         SameLoanOutstandingBal += SalaryLoans."Outstanding Balance";
    //                     END;
    //                 UNTIL SalaryLoans.NEXT = 0;
    //             END;

    //             STO.RESET;
    //             STO.SETRANGE(STO."Source Account No.", saccoAccount."No.");
    //             STO.SETRANGE(STO.Status, STO.Status::Approved);
    //             IF STO.FINDSET THEN BEGIN
    //                 REPEAT
    //                     STO.CALCFIELDS(STO."Allocated Amount");
    //                     STODeductions += STO."Allocated Amount";
    //                 UNTIL STO.NEXT = 0;
    //             END;
    //             IF Members."Employer Code" <> 'STAFF' THEN SalaryPostingCharge := 144;
    //             NetSalaryAmount := ((MaxLoanAmount * 0.72) - ((LoanRepaymentRecFromSal) + (STODeductions) + (SalaryPostingCharge)));

    //             CoopSetup.RESET;
    //             CoopSetup.SETRANGE("Transaction Type", CoopSetup."Transaction Type"::"Loan Disbursement");
    //             IF CoopSetup.FINDFIRST THEN BEGIN
    //                 //GetCharges(CoopSetup."Transaction Type", VendorCommission, SaccoFee, Safcom, 0);
    //                 TotalCharge := SaccoFee + VendorCommission;
    //             END;

    //             LoanLimit := ROUND(NetSalaryAmount / ((LoanType."Interest rate" / 12 / 100) / (1 - POWER((1 + (LoanType."Interest rate" / 12 / 100)), -LoanType."Default Installements"))), 100, '<');

    //             IF (LoanLimit - TotalCharge) < LoanType."Min. Loan Amount" THEN BEGIN
    //                 LoanLimit := 0;
    //                 Remark := 'You qualify for ' + FORMAT(LoanLimit) + ' which is less than the minimum amount';
    //                 EXIT;
    //             END;

    //             IF LoanLimit > LoanType."Max. Loan Amount" THEN
    //                 LoanLimit := LoanType."Max. Loan Amount";

    //             MaxLoanAmount := LoanLimit;
    //         END;
    //     END;

    //     EXIT(ROUND(MaxLoanAmount, 1, '<'));
    // end;

    // local procedure FnGetMobileAdvanceEligibility(AccountNo: Code[20]; LoanProductType: Code[20]; var Msg: Text[250]; var LoanLimit: Decimal): Decimal
    // var
    //     LoanBalance: Decimal;
    //     MaxLoanAmount: Decimal;
    //     saccoAccount: Record Vendor;
    //     LoanType: Record "Loan Products Setup";
    //     LoanRep: Decimal;
    //     nDays: Decimal;
    //     DepAmt: Decimal;
    //     Loans: Record "Loans Register";
    //     SaccoSetup: Record "Sacco Setup";
    //     RatingLoanLimit: Decimal;
    //     PenaltyCounter: Record "Penalty Counter";
    //     LoansRegister: Record "Loans Register";
    //     MemberLedgerEntry: Record "Member Ledger Entry";
    //     NumberOfMonths: Integer;
    //     DayLoanPaid: Date;
    //     Continue: Boolean;
    //     SalaryProcessingLines: Record "Salary Details";
    //     PayrollMonthlyTransactions: Record "Payroll Monthly Transactions.";
    //     MaxLoanAmtPossible: Decimal;
    //     SalBuffer: Record "Salary Details";
    //     StandingOrders: Record "Standing Orders";
    //     DepAcc: Record Customer;
    //     Salary1: Decimal;
    //     Salary2: Decimal;
    //     Salary3: Decimal;
    //     SalEnd: array[5] of Date;
    //     SalStart: array[5] of Date;
    //     Date3: Date;
    //     Date1: Date;
    //     Date2: Date;
    //     NetSal: Decimal;
    //     IntAmt: Decimal;
    //     ProdFac: Record "Loan Products Setup";
    //     GrossSalaryAmount: Decimal;
    //     NetSalaryAmount: Decimal;
    //     SalaryLoans: Record "Loans Register";
    //     STO: Record "Standing Orders";
    //     LoanRepayments: Decimal;
    //     STODeductions: Decimal;
    //     SameLoanRepayments: Decimal;
    //     SameLoanOutstandingBal: Decimal;
    //     CoopSetup: Record "Sky Mobile Setup";
    //     TotalCharge: Decimal;
    //     SaccoFee: Decimal;
    //     VendorCommission: Decimal;
    //     SMSCharge: Decimal;
    //     MemberNo: Code[30];
    //     MobileLoan: Record "Sky Mobile Loans";
    //     LoanProductsSetup: Record "Loan Products Setup";
    //     LoanProduct: Record "Loan Products Setup";
    //     SavAcc: Record Vendor;
    //     Repaymentdiff: Decimal;
    //     Fromdate: Date;
    //     Todate: Date;
    //     Customers: Record Customer;
    //     CreditRating: Record "Credit Rating";
    //     i: Integer;
    //     SalaryAmount: array[5] of Decimal;
    //     EmployerCode: Code[30];
    //     SalaryPostingCharge: Decimal;
    //     Members: Record Customer;
    // begin
    //     MaxLoanAmount := 0;
    //     saccoAccount.RESET;
    //     saccoAccount.SETRANGE("No.", AccountNo);
    //     saccoAccount.SetFilter(Status, '<>%1', saccoAccount.Status::Deceased);
    //     IF saccoAccount.FINDFIRST THEN BEGIN
    //         IF LoanType.GET(LoanProductType) THEN BEGIN
    //             LoanBalance := 0;
    //             LoanRep := 0;

    //             Loans.RESET;
    //             Loans.SETRANGE("Client Code", saccoAccount."BOSA Account No");
    //             Loans.SETRANGE("Loan Product Type", LoanProductType);
    //             Loans.SETFILTER("Outstanding Balance", '>0');
    //             IF Loans.FINDSET THEN BEGIN
    //                 REPEAT
    //                     Loans.CALCFIELDS("Outstanding Balance");
    //                     LoanBalance += Loans."Outstanding Balance";
    //                 UNTIL Loans.NEXT = 0;
    //             END;

    //             LoanRep += LoanBalance;

    //             MaxLoanAmount := LoanType."Max. Loan Amount";

    //             Loans.RESET;
    //             Loans.SETRANGE("Client Code", MemberNo);
    //             Loans.SETFILTER(Loans."Loan Product Type", MobileLoan."Loan Product Type");
    //             Loans.SETFILTER("Outstanding Balance", '>0');
    //             IF Loans.FINDFIRST THEN BEGIN
    //                 LoanProductsSetup.GET(Loans."Loan Product Type");

    //                 Msg := 'Your ' + LoanProduct."Product Description" + ' request on ' + FORMAT(CURRENTDATETIME) + ' has failed, You have an active ' + LoanProduct."USSD Product Name";
    //                 MobileLoan.Remarks := 'Member has active Loan No. ' + Loans."Loan  No." + ' - ' + LoanProduct."Product Description";
    //                 MobileLoan.Status := MobileLoan.Status::Failed;
    //                 MobileLoan.Posted := TRUE;
    //                 MobileLoan."Date Posted" := CURRENTDATETIME;
    //                 MobileLoan.Message := Msg;

    //                 MobileLoan.MODIFY;
    //                 Continue := FALSE;
    //             END;
    //             Fromdate := CALCDATE('-1M-CM', TODAY);

    //             IF Customers.GET(saccoAccount."BOSA Account No") THEN BEGIN
    //                 IF Customers."Employer Code" = 'POSTAL CORP' THEN
    //                     Fromdate := CALCDATE('-3M-CM', TODAY);
    //             END;


    //             SalaryProcessingLines.RESET;
    //             SalaryProcessingLines.SETRANGE(SalaryProcessingLines."Posting Date", Fromdate, TODAY);
    //             SalaryProcessingLines.SETRANGE(SalaryProcessingLines."FOSA Account No", AccountNo);
    //             IF SalaryProcessingLines.FINDFIRST THEN BEGIN
    //                 MaxLoanAmount := LoanType."Maximimum Amount Salaried";
    //             END;

    //             PayrollMonthlyTransactions.RESET;
    //             PayrollMonthlyTransactions.SETRANGE(PayrollMonthlyTransactions."No.", saccoAccount."Personal No.");
    //             PayrollMonthlyTransactions.SETRANGE(PayrollMonthlyTransactions."Payroll Period", CALCDATE('-1M-CM', TODAY), TODAY);
    //             PayrollMonthlyTransactions.SETRANGE(PayrollMonthlyTransactions."Transaction Code", 'NPAY');
    //             IF PayrollMonthlyTransactions.FINDFIRST THEN begin
    //                 MaxLoanAmount := LoanType."Maximimum Amount Salaried";
    //                 /// Error('qualifying332yyh-%1-minimum33 -%2 -%3-%4', RatingLoanLimit, SaccoSetup."Initial Loan Limit", LoanLimit, MaxLoanAmount);
    //             end;


    //             MaxLoanAmtPossible := MaxLoanAmount;
    //             SaccoSetup.GET;
    //             RatingLoanLimit := 0;


    //             SaccoSetup.TESTFIELD("Initial Loan Limit");
    //             SaccoSetup.TESTFIELD("Maximum Mobile Loan Limit");
    //             //1st Loan
    //             CreditRating.RESET;
    //             CreditRating.SETCURRENTKEY("Date Entered");
    //             CreditRating.SETRANGE("Member No", saccoAccount."BOSA Account No");
    //             CreditRating.SETRANGE("Loan Product Type", LoanProductType);
    //             IF NOT CreditRating.FINDFIRST THEN BEGIN
    //                 RatingLoanLimit := SaccoSetup."Initial Loan Limit";

    //             END ELSE BEGIN

    //                 //Subsequent Loan
    //                 CreditRating.RESET;
    //                 CreditRating.SETCURRENTKEY("Date Entered");
    //                 CreditRating.SETRANGE("Member No", saccoAccount."BOSA Account No");
    //                 CreditRating.SETRANGE("Loan Product Type", LoanProductType);
    //                 IF CreditRating.FINDLAST THEN BEGIN
    //                     IF CreditRating."Loan Limit" <= 0 THEN
    //                         CreditRating."Loan Limit" := SaccoSetup."Initial Loan Limit";

    //                     RatingLoanLimit := CreditRating."Loan Limit";
    //                     /// IF CALCDATE('1M', CreditRating."Date Entered") <= TODAY THEN
    //                     RatingLoanLimit := CreditRating."Loan Limit" + SaccoSetup."Loan Increment";

    //                 END;
    //             END;

    //             PenaltyCounter.RESET;
    //             PenaltyCounter.SETCURRENTKEY(PenaltyCounter."Date Entered");
    //             PenaltyCounter.SETRANGE(PenaltyCounter."Member Number", saccoAccount."BOSA Account No");
    //             PenaltyCounter.SETRANGE(PenaltyCounter."Product Type", LoanProductType);
    //             IF PenaltyCounter.FINDLAST THEN BEGIN
    //                 LoansRegister.GET(PenaltyCounter."Loan Number");
    //                 LoansRegister.CALCFIELDS(LoansRegister."Outstanding Balance", LoansRegister."Outstanding Interest");
    //                 IF (LoansRegister."Outstanding Balance" + LoansRegister."Outstanding Interest") > 0 THEN BEGIN
    //                     RatingLoanLimit := 0;
    //                 END ELSE BEGIN
    //                     IF PenaltyCounter."Date Penalty Paid" = 0D THEN BEGIN
    //                         RatingLoanLimit := 0;
    //                     END ELSE BEGIN
    //                         DayLoanPaid := PenaltyCounter."Date Penalty Paid";

    //                         NumberOfMonths := 0;
    //                         RatingLoanLimit := SaccoSetup."Defaulter Initial Limit";
    //                         IF TODAY > CALCDATE('3M', DayLoanPaid) THEN BEGIN
    //                             NumberOfMonths := ROUND(((TODAY - CALCDATE('3M', DayLoanPaid)) / 30), 1, '<');
    //                             RatingLoanLimit := SaccoSetup."Defaulter Initial Limit" + (SaccoSetup."Defaulter Loan Increment" * NumberOfMonths)
    //                         END;
    //                     END;
    //                 END;
    //             END;

    //             LoanLimit := RatingLoanLimit;

    //             IF MaxLoanAmount > RatingLoanLimit THEN begin
    //                 MaxLoanAmount := RatingLoanLimit;
    //             end;



    //             IF LoanLimit > MaxLoanAmount THEN begin
    //                 LoanLimit := MaxLoanAmount;
    //             end;


    //             IF Loans."Loan Product Type" <> 'A16' THEN BEGIN
    //                 IF LoanBalance > 0 THEN BEGIN
    //                     MaxLoanAmount := 0;
    //                     Msg := 'You have an existing loan of this type, kindly offset the loan and try again.';
    //                 END;
    //             END;

    //             IF MaxLoanAmount > MaxLoanAmtPossible THEN begin
    //                 MaxLoanAmount := MaxLoanAmtPossible;
    //             end;


    //             IF LoanBalance > 0 THEN begin
    //                 MaxLoanAmount := 0;
    //             end;


    //             IF MaxLoanAmount < 0 THEN begin
    //                 MaxLoanAmount := 0;
    //             end;

    //             ///Error('qualifying332 Complte-%1-minimum33 -%2 -%3-%4', RatingLoanLimit, SaccoSetup."Initial Loan Limit", LoanLimit, MaxLoanAmount);
    //             IF LoanProductType = 'A16' THEN BEGIN
    //                 saccoAccount.RESET;
    //                 saccoAccount.SETRANGE(saccoAccount."No.", AccountNo);
    //                 IF saccoAccount.FINDFIRST THEN BEGIN
    //                     GrossSalaryAmount := 0;
    //                     GrossSalaryAmount := saccoAccount."Net Salary";
    //                 END;

    //                 GrossSalaryAmount := GetGrossSalary(AccountNo, LoanProductType);


    //                 //MaxLoanAmount := 0;
    //                 LoanLimit := 0;
    //                 SalaryLoans.RESET;
    //                 SalaryLoans.SETRANGE(SalaryLoans."Client Code", saccoAccount."BOSA Account No");
    //                 SalaryLoans.SETRANGE(SalaryLoans."Recovery Mode", SalaryLoans."Recovery Mode"::Salary);
    //                 SalaryLoans.SETFILTER(SalaryLoans."Outstanding Balance", '>0');
    //                 SalaryLoans.SETFILTER(SalaryLoans."Loan Product Type", '<> A16');
    //                 IF SalaryLoans.FINDSET THEN BEGIN
    //                     REPEAT
    //                         SalaryLoans.CALCFIELDS(SalaryLoans."Outstanding Balance");
    //                         LoanRepayments += SalaryLoans.Repayment;
    //                         IF SalaryLoans."Loan Product Type" = LoanType.Code THEN BEGIN
    //                             SameLoanRepayments += SalaryLoans.Repayment;
    //                         END;
    //                     UNTIL SalaryLoans.NEXT = 0;
    //                 END;
    //                 SameLoanOutstandingBal := 0;

    //                 Loans.RESET;
    //                 Loans.SETRANGE(Loans."Client Code", saccoAccount."BOSA Account No");
    //                 Loans.SETRANGE(Loans."Recovery Mode", Loans."Recovery Mode"::Salary);
    //                 Loans.SETFILTER(Loans."Loan Product Type", 'A16');
    //                 IF Loans.FINDSET THEN BEGIN
    //                     REPEAT
    //                         Loans.CALCFIELDS(Loans."Outstanding Balance");
    //                         SameLoanOutstandingBal += Loans."Outstanding Balance";
    //                     UNTIL Loans.NEXT = 0;
    //                 END;
    //                 //Error('amountwwwww required Finals testing  %1 --limiting nett %2-%3-%4-%5-%6-%7', GrossSalaryAmount, NetSalaryAmount, LoanRepayments, Repaymentdiff, SameLoanOutstandingBal, STODeductions, SalaryPostingCharge);
    //                 STO.RESET;
    //                 STO.SETRANGE(STO."Source Account No.", saccoAccount."No.");
    //                 STO.SETRANGE(STO.Status, STO.Status::Approved);
    //                 IF STO.FINDSET THEN BEGIN
    //                     REPEAT
    //                         STO.CALCFIELDS(STO."Allocated Amount");
    //                         STODeductions += STO."Allocated Amount";
    //                     UNTIL STO.NEXT = 0;
    //                 END;
    //                 IF Members."Employer Code" <> 'STAFF' THEN SalaryPostingCharge := 144;
    //                 NetSalaryAmount := (GrossSalaryAmount * 0.72) - (((LoanRepayments - Repaymentdiff) + SameLoanOutstandingBal) + STODeductions + SalaryPostingCharge);
    //                 IF NetSalaryAmount < 0 THEN begin
    //                     NetSalaryAmount := 0;
    //                 end;





    //                 LoanLimit := ROUND(NetSalaryAmount / ((LoanType."Interest rate" / 12 / 100) / (1 - POWER((1 + (LoanType."Interest rate" / 12 / 100)), -LoanType."Default Installements"))), 1000, '<');

    //                 IF (LoanLimit - TotalCharge) < LoanType."Min. Loan Amount" THEN begin
    //                     LoanLimit := 0;
    //                 end;


    //                 IF (LoanLimit - (SameLoanOutstandingBal - TotalCharge)) < LoanType."Min. Loan Amount" THEN begin
    //                     LoanLimit := 0;
    //                 end;


    //                 IF LoanLimit > LoanType."Max. Loan Amount" THEN begin
    //                     LoanLimit := LoanType."Max. Loan Amount";
    //                 end;


    //             END;
    //         END;

    //         EXIT(LoanLimit);
    //     END;


    // end;

    // local procedure FnCheckIfGuarantorsMet(LoanNo: Code[40])
    // var

    //     LoanTypeID: Text;
    //     LoansRegister: Record "Loans Register";
    //     LoanProductSetup: Record "Loan Products Setup";
    //     LoanRec: Record "Loans Register";
    //     GAmount: Decimal;
    //     Members: Record Customer;
    //     GenJournalLine: Record "Gen. Journal Line";
    //     Guarantorss: record "Loans Guarantee Details";
    //     PCharges: Record "Loan Product Charges";
    //     PChargeAmount: Decimal;
    //     GenSetUp: Record "Sacco General Set-Up";
    //     SFactorys: Codeunit "Au Factory";
    //     CreationMessage: Text[2500];
    //     LProducts: Record "Loan Products Setup";
    //     smsManagement: Codeunit "Sms Management";
    //     Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
    // begin
    //     LoansRegister.Reset();
    //     LoansRegister.SetRange(LoansRegister."Loan  No.", LoanNo);
    //     if LoansRegister.FindFirst() then begin
    //         if Members.get(LoansRegister."Client Code") then begin
    //             GAmount := 0;
    //             Guarantorss.Reset();
    //             Guarantorss.SetRange(Guarantorss."Loan No", LoansRegister."Loan  No.");
    //             Guarantorss.SetRange(Guarantorss.Substituted, false);
    //             Guarantorss.SetRange(Guarantorss."Acceptance Status", Guarantorss."Acceptance Status"::Accepted);
    //             if Guarantorss.Findfirst() then begin
    //                 repeat
    //                     GAmount := GAmount + Guarantorss."Amont Guaranteed";
    //                 until Guarantorss.Next() = 0;
    //             end;
    //             if LoansRegister."Requested Amount" <= GAmount then begin
    //                 BATCH_TEMPLATE := 'GENERAL';
    //                 BATCH_NAME := 'MOBILE';
    //                 DOCUMENT_NO := LoansRegister."Loan  No.";
    //                 GenJournalLine.Reset();
    //                 GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
    //                 GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
    //                 if GenJournalLine.FindSet() then begin
    //                     GenJournalLine.DeleteAll();
    //                 end;
    //                 //Balancing Account
    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                 GenJournalLine."Account Type"::Vendor, Members."FOSA Account No.", Today, LoansRegister."Requested Amount" * -1, '', DOCUMENT_NO,
    //                 'Mobile Loan' + ' ' + LoansRegister."Client Code", '');

    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Loan,
    //                 GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", Today, LoansRegister."Requested Amount", '', DOCUMENT_NO,
    //                  'Mobile Loan' + ' ' + LoansRegister."Client Code", LoansRegister."Loan  No.");
    //                 PCharges.RESET;
    //                 PCharges.SETRANGE(PCharges."Product Code", LoansRegister."Loan Product Type");
    //                 //PCharges.SETFILTER(PCharges."Loan Charge Type", '<>%1', PCharges."Loan Charge Type"::"Loan Insurance");
    //                 IF PCharges.FIND('-') THEN BEGIN
    //                     REPEAT
    //                         GenSetUp.Get();
    //                         PCharges.TESTFIELD(PCharges."G/L Account");
    //                         GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
    //                         PChargeAmount := PCharges.Amount;
    //                         IF PCharges."Use Perc" = TRUE THEN
    //                             PChargeAmount := (LoansRegister."Requested Amount" * PCharges.Percentage / 100);//LoanDisbAmount
    //                                                                                                             //-------------------EARN CHARGE-------------------------------------------
    //                         LineNo := LineNo + 10000;
    //                         SFactorys.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                         GenJournalLine."Account Type"::"G/L Account", PCharges."G/L Account", Today, PChargeAmount * -1, 'BOSA', LoansRegister."Loan  No.",
    //                         PCharges.Description + ' - ' + LoansRegister."Client Code" + ' - ' + LoansRegister."Loan  No.", LoansRegister."Loan  No.", GenJournalLine."Application Source"::" ");
    //                         //-------------------RECOVER-----------------------------------------------
    //                         LineNo := LineNo + 10000;
    //                         SFactorys.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                         GenJournalLine."Account Type"::Vendor, LoansRegister."Account No", Today, PChargeAmount, 'BOSA', LoansRegister."Loan  No.",
    //                         PCharges.Description + '-' + LoansRegister."Loan Product Type Name", LoansRegister."Loan  No.", GenJournalLine."Application Source"::" ");



    //                         //------------------10% EXCISE DUTY----------------------------------------
    //                         IF SFactory.FnChargeExcise(PCharges.Code) THEN BEGIN
    //                             //-------------------Earn--------------------------------- 
    //                             LineNo := LineNo + 10000;
    //                             SFactorys.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                             GenJournalLine."Account Type"::"G/L Account", GenSetUp."Excise Duty Account", Today, (PChargeAmount * -1) * 0.1, 'BOSA', LoansRegister."Loan  No.",
    //                             PCharges.Description + '-' + LoansRegister."Client Code" + '-' + LoansRegister."Loan Product Type Name" + '-' + LoansRegister."Loan  No." + '- Excise(10%)', LoansRegister."Loan  No.", GenJournalLine."Application Source"::" ");
    //                             //-----------------Recover---------------------------------
    //                             LineNo := LineNo + 10000;
    //                             SFactorys.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
    //                             GenJournalLine."Account Type"::Vendor, LoansRegister."Account No", Today, PChargeAmount * 0.1, 'BOSA', LoansRegister."Loan  No.",
    //                             PCharges.Description + '-' + LoansRegister."Loan Product Type Name" + ' - Excise(10%)', LoansRegister."Loan  No.", GenJournalLine."Application Source"::" ");
    //                         END
    //                     //----------------END 10% EXCISE--------------------------------------------



    //                     UNTIL PCharges.NEXT = 0;
    //                 END;


    //                 GenJournalLine.Reset;
    //                 GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //                 GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //                 if GenJournalLine.Find('-') then begin
    //                     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    //                 end;
    //                 LoansRegister.Posted := true;
    //                 LoansRegister."Loan Status" := LoansRegister."Loan Status"::Issued;
    //                 LoansRegister."Approval Status" := LoansRegister."Approval Status"::Approved;
    //                 LoansRegister."Loan Disbursement Date" := Today;
    //                 LoansRegister.modify;
    //                 LProducts.Get(LoansRegister."Loan Product Type");

    //                 CreationMessage := 'Dear, ' + BName.NameStyle(LoansRegister."Client Code") + ' your ' + LProducts."Product Description" + ' loan has been disbursed to your FOSA Account ';
    //                 smsManagement.SendSmsWithID(Source::LOAN_POSTED, Members."Mobile Phone No", CreationMessage, Members."No.", Members."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
    //             end;

    //         end;
    //     end;




    // end;



    // local procedure FnOkayMember(MemberNo: Code[60]) Okayed: Boolean
    // var
    //     Members: Record Vendor;
    //     GenJournalLine: Record "Gen. Journal Line";
    //     Guarantorss: record "Loans Guarantee Details";
    // begin
    //     Members.Reset();
    //     Members.SetRange(Members."No.", MemberNo);
    //     Members.SetFilter(Members."Account Type", '103');
    //     Members.Setrange(Members.Status, Members.Status::Active);
    //     if Members.FindFirst() then begin
    //         Okayed := true;
    //     end;

    // end;


    // local PROCEDURE FnLoginUser(staff_no: Text; password: Text) Res: Text;
    // BEGIN
    //     /* 
    //             ObjMobileUsers.RESET;
    //             ObjMobileUsers.SETRANGE(ObjMobileUsers.Username, staff_no);
    //             ObjMobileUsers.SETRANGE(ObjMobileUsers.Password, password);
    //             ObjMobileUsers.SETRANGE(ObjMobileUsers.IsMember, FALSE);
    //             IF ObjMobileUsers.FIND('-') THEN BEGIN
    //                 ObjMobileUsersLogs.RESET;
    //                 ObjMobileUsersLogs.INIT;
    //                 ObjMobileUsersLogs."Mobile app No" := ObjMobileUsers."No.";
    //                 ObjMobileUsersLogs.Username := staff_no;
    //                 ObjMobileUsersLogs."OTP Code" := ObjMobileUsers."OTP Code";
    //                 ObjMobileUsersLogs."Transaction Date" := TODAY;
    //                 ObjMobileUsersLogs."Transaction time" := TIME;
    //                 ObjMobileUsersLogs.Activity := ObjMobileUsersLogs.Activity::Login;
    //                 ObjMobileUsersLogs."Created By" := USERID;
    //                 ObjMobileUsersLogs.Name := ObjMobileUsers."Account Name";
    //                 ObjMobileUsersLogs.INSERT;
    //                 Res := '{"success":true,';
    //                 Res += '"description":"Login successful"}';
    //             END ELSE BEGIN
    //                 Res := '{"success":false,';
    //                 Res += '"description":"Wrong username or password"}';
    //             END; */
    // END;


    // local procedure FnCheckMemberStatus(ClientCode: Code[40]) Response: Text[400]
    // var
    //     Members: Record Customer;
    // begin
    //     Response := '';
    //     Members.Reset();
    //     Members.SetRange(Members."No.", ClientCode);
    //     Members.SetFilter(Members.Status, '<>%1', Members.Status::Active);
    //     if Members.FindFirst() then begin
    //         Response := 'Member is not Active';
    //     end;
    //     exit(Response);
    // end;

    // local procedure FnCheckMemberAge(ClientCode: Code[40]) Response: Text[400]
    // var
    //     Members: Record Customer;
    // begin
    //     Response := '';
    //     Members.Reset();
    //     Members.SetRange(Members."No.", ClientCode);
    //     if Members.FindFirst() then begin
    //         if Members."Registration Date" = 0D then begin
    //             Response := 'Member is less than 6 months old in the SACCO';
    //         end;
    //         if Members."Registration Date" <> 0D then begin
    //             if CALCDATE('6M', Members."Registration Date") > TODAY then
    //                 Response := 'Member is less than 6 months old in the SACCO';
    //         end;
    //     end;
    //     exit(Response);
    // end;


    // local procedure FnCheckMemberShares(ClientCode: Code[40]) Response: Text[400]
    // var
    //     Members: Record Customer;
    //     SaccoGen: Record "Sacco General Set-Up";
    // begin
    //     Response := '';
    //     Members.Reset();
    //     Members.SetRange(Members."No.", ClientCode);
    //     if Members.FindFirst() then begin
    //         IF (Members."Shares Retained" < SaccoGen."Retained Shares") THEN BEGIN
    //             Response := 'Member has not met minimum shares amount.';
    //         end;
    //     end;
    // end;

    // local procedure FnCheckLoanDefault(ClientCode: Code[40]) Response: Text[400]
    // var
    //     Members: Record Customer;
    //     Loans: Record "Loans Register";
    //     LoanProduct: Record "Loan Products Setup";
    // begin
    //     Response := '';
    //     Loans.RESET;
    //     Loans.SETRANGE(Loans."Client Code", ClientCode);
    //     Loans.SETFILTER(Loans."Loans Category", '%1|%2|%3', Loans."Loans Category"::Substandard,
    //     Loans."Loans Category"::Doubtful, Loans."Loans Category"::Loss);
    //     Loans.SetAutoCalcFields(Loans."Outstanding Balance");
    //     Loans.SETFILTER(Loans."Outstanding Balance", '>%1', 0);
    //     IF Loans.FINDFIRST THEN BEGIN
    //         LoanProduct.Get(Loans."Loan Product Type");
    //         Response := 'Member has defaulted ' + LoanProduct."Product Description" + 'loan';
    //     end;
    // end;

    // local procedure FnCheckLoanIfExisting(ClientCode: Code[40]; ProductCode: Code[40]) Response: Text[400]
    // var
    //     Members: Record Customer;
    //     Loans: Record "Loans Register";
    //     LoanProduct: Record "Loan Products Setup";
    // begin
    //     Response := '';
    //     Loans.RESET;
    //     Loans.SETRANGE(Loans."Client Code", ClientCode);
    //     Loans.SETFILTER(Loans."Loan Product Type", ProductCode);
    //     Loans.SetAutoCalcFields(Loans."Outstanding Balance");
    //     Loans.SETFILTER(Loans."Outstanding Balance", '>%1', 0);
    //     IF Loans.FINDFIRST THEN BEGIN
    //         LoanProduct.Get(Loans."Loan Product Type");
    //         Response := 'Member has an existing ' + LoanProduct."Product Description";
    //     end;
    //     exit(Response);
    // end;

    // local procedure GetReloadedLoanQualifiedAmount(AccountNo: Code[20]; LoanProductType: Code[20]; var LoanLimit: Decimal; var Remark: Text[250]): Decimal
    // var
    //     LoanBalance: Decimal;
    //     MaxLoanAmount: Decimal;
    //     saccoAccount: Record Vendor;
    //     LoanType: Record "Loan Products Setup";
    //     LoanRep: Decimal;
    //     nDays: Decimal;
    //     DepAmt: Decimal;
    //     Loans: Record "Loans Register";
    //     SaccoSetup: Record "Sacco General Set-Up";
    //     RatingLoanLimit: Decimal;
    //     PenaltyCounter: Record "Penalty Counter";
    //     LoansRegister: Record "Loans Register";
    //     MemberLedgerEntry: Record "Member Ledger Entry";
    //     NumberOfMonths: Integer;
    //     DayLoanPaid: Date;
    //     Continue: Boolean;
    //     SalaryProcessingLines: Record "Salary Processing Lines";
    //     PayrollMonthlyTransactions: Record "Payroll Monthly Transactions.";
    //     MaxLoanAmtPossible: Decimal;
    //     SalBuffer: Record "Salary Processing Lines";
    //     StandingOrders: Record "Standing Orders";
    //     DepAcc: Record Customer;
    //     Salary1: Decimal;
    //     Salary2: Decimal;
    //     Salary3: Decimal;
    //     SalEnd: array[5] of Date;
    //     SalStart: array[5] of Date;
    //     NetSal: Decimal;
    //     IntAmt: Decimal;
    //     ProdFac: Record "Loan Products Setup";
    //     GrossSalaryAmount: Decimal;
    //     NetSalaryAmount: Decimal;
    //     SalaryLoans: Record "Loans Register";
    //     STO: Record "Standing Orders";
    //     LoanRepayments: Decimal;
    //     STODeductions: Decimal;
    //     SameLoanRepayments: Decimal;
    //     SameLoanOutstandingBal: Decimal;
    //     CoopSetup: Record "Sky Mobile Setup";
    //     TotalCharge: Decimal;
    //     SaccoFee: Decimal;
    //     VendorCommission: Decimal;
    //     SMSCharge: Decimal;
    //     Members: Record Customer;
    //     SaccoAcc: Record Vendor;
    //     i: Integer;
    //     SalaryAmount: array[5] of Decimal;
    //     LoanTypes: Record "Loan Products Setup";
    //     LoanProduct: Code[30];
    //     EmployerCode: Code[30];
    //     LoanRepaymentRecFromSal: Decimal;
    //     SalaryPostingCharge: Decimal;
    // begin
    //     MaxLoanAmount := 0;
    //     Remark := '';
    //     GrossSalaryAmount := 0;
    //     saccoAccount.RESET;
    //     saccoAccount.SETRANGE("No.", AccountNo);
    //     IF saccoAccount.FINDFIRST THEN BEGIN
    //         Members.GET(saccoAccount."BOSA Account No");
    //         IF Members.Status <> Members.Status::Active THEN BEGIN
    //             LoanLimit := 0;
    //             Remark := 'Your Bosa Account is not active';
    //             EXIT;
    //         END;

    //         IF Members."Loan Defaulter" = TRUE THEN BEGIN
    //             LoanLimit := 0;
    //             Remark := 'You are not eligible for this product because you are listed as a defaulter';
    //             EXIT;
    //         END;

    //         SaccoAcc.RESET;
    //         SaccoAcc.SETRANGE("No.", AccountNo);
    //         IF SaccoAcc.FINDFIRST THEN BEGIN
    //             IF SaccoAcc.Status <> SaccoAcc.Status::Active THEN BEGIN
    //                 LoanLimit := 0;
    //                 Remark := 'Your membership status is not Active';
    //                 EXIT;
    //             END;
    //         END;

    //         IF LoanType.GET(LoanProductType) THEN BEGIN
    //             LoanRepayments := 0;
    //             LoanTypes.RESET;
    //             LoanTypes.SETRANGE("Appraise Salary", TRUE);
    //             LoanTypes.SETFILTER(Code, '<>%1', LoanProduct);
    //             IF LoanTypes.FINDSET THEN BEGIN
    //                 REPEAT
    //                     Loans.RESET;
    //                     Loans.SETRANGE(Loans."Loan Status", Loans."Loan Status"::Approved);
    //                     Loans.SETRANGE(Loans."Client Code", Members."No.");
    //                     Loans.SETFILTER(Loans."Loan Product Type", LoanTypes.Code);
    //                     Loans.SETFILTER("Outstanding Balance", '>0');
    //                     IF Loans.FINDSET THEN BEGIN
    //                         REPEAT
    //                             Loans.CALCFIELDS(Loans."Outstanding Balance", Loans."Outstanding Interest");
    //                             IF (Loans."Outstanding Balance" + Loans."Outstanding Interest") > 0 THEN BEGIN
    //                                 IF (Loans."Outstanding Balance" + Loans."Outstanding Interest") > Loans.Repayment THEN BEGIN
    //                                     LoanRepayments += Loans.Repayment;
    //                                 END ELSE BEGIN
    //                                     LoanRepayments += (Loans."Outstanding Balance" + Loans."Outstanding Interest");
    //                                 END;
    //                             END;
    //                         UNTIL Loans.NEXT = 0
    //                     END;
    //                 UNTIL LoanTypes.NEXT = 0;
    //             END;

    //             LoanBalance := 0;

    //             LoanRepayments := 0;
    //             LoanRepaymentRecFromSal := 0;
    //             Loans.RESET;
    //             Loans.SETRANGE("Client Code", saccoAccount."BOSA Account No");
    //             Loans.SETRANGE("Loan Product Type", LoanProductType);
    //             Loans.SETFILTER(Loans."Loan Product Type", 'A01');
    //             Loans.SETFILTER("Outstanding Balance", '>0');
    //             IF Loans.FINDSET THEN BEGIN
    //                 REPEAT
    //                     Loans.CALCFIELDS("Outstanding Balance");
    //                     LoanBalance += Loans."Outstanding Balance";
    //                 UNTIL Loans.NEXT = 0;
    //                 IF LoanBalance > 0 THEN BEGIN

    //                 END;
    //             END;

    //             MaxLoanAmount := GetGrossSalary(AccountNo, LoanProductType);

    //             LoanLimit := 0;
    //             SalaryLoans.RESET;
    //             SalaryLoans.SETRANGE(SalaryLoans."Client Code", saccoAccount."BOSA Account No");
    //             SalaryLoans.SETRANGE(SalaryLoans."Recovery Mode", SalaryLoans."Recovery Mode"::Salary);
    //             SalaryLoans.SETFILTER(SalaryLoans."Outstanding Balance", '>0');
    //             IF SalaryLoans.FINDSET THEN BEGIN
    //                 REPEAT
    //                     SalaryLoans.CALCFIELDS(SalaryLoans."Outstanding Balance");
    //                     LoanRepaymentRecFromSal += SalaryLoans.Repayment;
    //                     IF SalaryLoans."Loan Product Type" = LoanType.Code THEN BEGIN
    //                         SameLoanRepayments += SalaryLoans.Repayment;
    //                         SameLoanOutstandingBal += SalaryLoans."Outstanding Balance";
    //                     END;
    //                 UNTIL SalaryLoans.NEXT = 0;
    //             END;

    //             STO.RESET;
    //             STO.SETRANGE(STO."Source Account No.", saccoAccount."No.");
    //             STO.SETRANGE(STO.Status, STO.Status::Approved);
    //             IF STO.FINDSET THEN BEGIN
    //                 REPEAT
    //                     STO.CALCFIELDS(STO."Allocated Amount");
    //                     STODeductions += STO."Allocated Amount";
    //                 UNTIL STO.NEXT = 0;
    //             END;
    //             // Error('Interest %1-LoanRepayments -%2-STO - %3-Max Loan%4', (MaxLoanAmount * LoanType."Loan Appraisal %" / 1200), LoanRepaymentRecFromSal, STODeductions, MaxLoanAmount);
    //             IF Members."Employer Code" <> 'STAFF' THEN SalaryPostingCharge := 144;
    //             NetSalaryAmount := ((MaxLoanAmount * LoanType."Loan Appraisal %") - ((LoanRepaymentRecFromSal) + (STODeductions) + (SalaryPostingCharge)));

    //             CoopSetup.RESET;
    //             CoopSetup.SETRANGE("Transaction Type", CoopSetup."Transaction Type"::"Loan Disbursement");
    //             IF CoopSetup.FINDFIRST THEN BEGIN
    //                 // GetCharges(CoopSetup."Transaction Type", VendorCommission, SaccoFee, Safcom, 0);
    //                 TotalCharge := SaccoFee + VendorCommission;
    //             END;

    //             LoanLimit := ROUND(NetSalaryAmount / ((LoanType."Interest rate" / 12 / 100) / (1 - POWER((1 + (LoanType."Interest rate" / 12 / 100)), -LoanType."Default Installements"))), 1000, '<');

    //             IF (LoanLimit - TotalCharge) < LoanType."Min. Loan Amount" THEN
    //                 LoanLimit := 0;

    //             IF LoanLimit > LoanType."Max. Loan Amount" THEN
    //                 LoanLimit := LoanType."Max. Loan Amount";

    //             MaxLoanAmount := LoanLimit;

    //         END;
    //     END;

    //     EXIT(ROUND(MaxLoanAmount, 1, '<'));
    // end;

    // local procedure GetOverdraftLoanQualifiedAmount(AccountNo: Code[20]; LoanProductType: Code[20]; var LoanLimit: Decimal; var Remark: Text[250]): Decimal
    // var
    //     LoanBalance: Decimal;
    //     MaxLoanAmount: Decimal;
    //     saccoAccount: Record vendor;
    //     LoanType: Record "Loan Products Setup";
    //     LoanRep: Decimal;
    //     nDays: Decimal;
    //     DepAmt: Decimal;
    //     Loans: Record "Loans Register";
    //     SaccoSetup: Record "Sacco General Set-Up";
    //     RatingLoanLimit: Decimal;
    //     PenaltyCounter: Record "Penalty Counter";
    //     LoansRegister: Record "Loans Register";
    //     MemberLedgerEntry: Record "Detailed Cust. Ledg. Entry";
    //     NumberOfMonths: Integer;
    //     DayLoanPaid: Date;
    //     Continue: Boolean;
    //     SalaryProcessingLines: Record "Salary Details";
    //     PayrollMonthlyTransactions: Record "Payroll Monthly Transactions.";
    //     MaxLoanAmtPossible: Decimal;
    //     SalBuffer: Record "Salary Details";
    //     StandingOrders: Record "Standing Orders";
    //     DepAcc: Record Customer;
    //     Salary1: Decimal;
    //     Salary2: Decimal;
    //     Salary3: Decimal;
    //     Salary4: Decimal;
    //     Salary5: Decimal;
    //     SalEnd: array[5] of Date;
    //     SalStart: array[5] of Date;
    //     NetSal: Decimal;
    //     IntAmt: Decimal;
    //     ProdFac: Record "Loan Products Setup";
    //     GrossSalaryAmount: Decimal;
    //     NetSalaryAmount: Decimal;
    //     SalaryLoans: Record "Loans Register";
    //     STO: Record "Standing Orders";
    //     LoanRepayments: Decimal;
    //     STODeductions: Decimal;
    //     SameLoanRepayments: Decimal;
    //     SameLoanOutstandingBal: Decimal;
    //     CoopSetup: Record "Sky Mobile Setup";
    //     TotalCharge: Decimal;
    //     SaccoFee: Decimal;
    //     VendorCommission: Decimal;
    //     SMSCharge: Decimal;
    //     Members: Record Customer;
    //     SaccoAcc: Record Vendor;
    //     i: Integer;
    //     SalaryAmount: array[5] of Decimal;
    //     SaccoEmployers: Record "Sacco Employers";
    //     EmployerCode: Code[30];
    //     MemberNo: Code[30];
    // begin
    //     MaxLoanAmount := 0;
    //     Remark := '';
    //     EmployerCode := '';
    //     GrossSalaryAmount := 0;
    //     saccoAccount.RESET;
    //     saccoAccount.SETRANGE("No.", AccountNo);
    //     IF saccoAccount.FINDFIRST THEN BEGIN
    //         MemberNo := saccoAccount."BOSA Account No";
    //         Members.GET(MemberNo);

    //         IF Members.Status <> Members.Status::Active THEN BEGIN
    //             LoanLimit := 0;
    //             Remark := 'Your Member Account is not active';
    //             EXIT;
    //         END;

    //         IF Members.Defaulter = TRUE THEN BEGIN
    //             LoanLimit := 0;
    //             Remark := 'You are not eligible for this product because you are listed as a defaulter';
    //             EXIT;
    //         END;

    //         SaccoAcc.RESET;
    //         SaccoAcc.SETRANGE("No.", AccountNo);
    //         IF SaccoAcc.FINDFIRST THEN BEGIN
    //             IF SaccoAcc.Status <> SaccoAcc.Status::Active THEN BEGIN
    //                 LoanLimit := 0;
    //                 Remark := 'Your depopsit contribution is inactive';
    //                 EXIT;
    //             END;
    //         END;

    //         IF LoanType.GET(LoanProductType) THEN BEGIN
    //             LoanBalance := 0;

    //             Loans.RESET;
    //             Loans.SETRANGE("Client Code", saccoAccount."BOSA Account No");
    //             Loans.SETRANGE("Loan Product Type", LoanProductType);
    //             Loans.SETFILTER(Loans."Loan Product Type", 'M_OD');
    //             Loans.SETFILTER("Outstanding Balance", '>0');
    //             IF Loans.FINDSET THEN BEGIN
    //                 REPEAT
    //                     Loans.CALCFIELDS("Outstanding Balance");
    //                     LoanBalance += Loans."Outstanding Balance";
    //                 UNTIL Loans.NEXT = 0;
    //                 IF LoanBalance > 0 THEN BEGIN
    //                     MaxLoanAmount := 0;
    //                     Remark := 'You already have an existing loan';
    //                     EXIT;
    //                 END;
    //             END;

    //             MaxLoanAmount := GetGrossSalarys(AccountNo, LoanProductType);

    //             LoanLimit := 0;
    //             SalaryLoans.RESET;
    //             SalaryLoans.SETRANGE(SalaryLoans."Client Code", saccoAccount."BOSA Account No");
    //             SalaryLoans.SETRANGE(SalaryLoans."Recovery Mode", SalaryLoans."Recovery Mode"::Salary);
    //             SalaryLoans.SETFILTER(SalaryLoans."Outstanding Balance", '>0');
    //             IF SalaryLoans.FINDSET THEN BEGIN
    //                 REPEAT
    //                     SalaryLoans.CALCFIELDS(SalaryLoans."Outstanding Balance");
    //                     LoanRepayments += SalaryLoans.Repayment;
    //                     IF SalaryLoans."Loan Product Type" = LoanType.Code THEN BEGIN
    //                         SameLoanRepayments += SalaryLoans.Repayment;
    //                         SameLoanOutstandingBal += SalaryLoans."Outstanding Balance";
    //                     END;
    //                 UNTIL SalaryLoans.NEXT = 0;
    //             END;

    //             STO.RESET;
    //             STO.SETRANGE(STO."Source Account No.", saccoAccount."No.");
    //             STO.SETRANGE(STO.Status, STO.Status::Approved);
    //             IF STO.FINDSET THEN BEGIN
    //                 REPEAT
    //                     STO.CALCFIELDS(STO."Allocated Amount");
    //                     STODeductions += STO."Allocated Amount";
    //                 UNTIL STO.NEXT = 0;
    //             END;

    //             NetSalaryAmount := ROUND((0.83 * MaxLoanAmount), 100, '<');

    //             IF NetSalaryAmount < 0 THEN
    //                 NetSalaryAmount := 0;

    //             /*                 CoopSetup.RESET;
    //                             CoopSetup.SETRANGE("Transaction Type", CoopSetup."Transaction Type"::"Loan Disbursement");
    //                             IF CoopSetup.FINDFIRST THEN BEGIN
    //                                 GetCharges(CoopSetup."Transaction Type", VendorCommission, SaccoFee, Safcom, 0);
    //                                 TotalCharge := SaccoFee + VendorCommission;
    //                             END; */

    //             LoanLimit := ROUND(((NetSalaryAmount) - ((LoanRepayments) + (STODeductions))), 100, '<');

    //             IF (LoanLimit - TotalCharge) < LoanType."Min. Loan Amount" THEN BEGIN
    //                 LoanLimit := 0;
    //                 Remark := 'You qualify for ' + FORMAT(LoanLimit) + ' which is less than the minimum amount';
    //                 EXIT;
    //             END;

    //             IF LoanLimit > LoanType."Max. Loan Amount" THEN
    //                 LoanLimit := LoanType."Max. Loan Amount";
    //             MaxLoanAmount := LoanLimit;
    //         END;
    //     END;

    //     EXIT(ROUND(MaxLoanAmount, 1, '<'));
    // end;

    // local procedure GetGrossSalarys(AccountNo: Code[20]; ProductType: Code[10]) GrossSalary: Decimal
    // var
    //     saccoAccount: Record Vendor;
    //     SalaryProcessingLines: Record "Salary Details";
    //     PayrollMonthlyTransactions: Record "prPeriod Transactions.";
    //     SalBuffer: Record "Salary Details";
    //     SalEnd: array[5] of Date;
    //     SalStart: array[5] of Date;
    //     i: Integer;
    //     SalaryAmount: array[5] of Decimal;
    //     EmployerCode: Code[30];
    //     Members: Record Customer;
    //     SalaryDate: Record Date;
    // begin



    //     saccoAccount.RESET;
    //     saccoAccount.SETRANGE("No.", AccountNo);
    //     IF saccoAccount.FINDFIRST THEN BEGIN
    //         Members.GET(saccoAccount."BOSA Account No");
    //         EmployerCode := Members."Employer Code";
    //         GrossSalary := 0;
    //         FOR i := 5 DOWNTO 1 DO BEGIN
    //             SalStart[i] := 0D;
    //             SalStart[i] := CALCDATE('-' + FORMAT(i) + 'M-CM', TODAY);

    //             SalEnd[i] := 0D;
    //             SalEnd[i] := CALCDATE('CM', SalStart[i]);
    //             SalaryAmount[i] := 0;
    //             SalaryProcessingLines.RESET;
    //             SalaryProcessingLines.SETRANGE(SalaryProcessingLines."Posting Date", SalStart[i], SalEnd[i]);
    //             SalaryProcessingLines.SETRANGE(SalaryProcessingLines."FOSA Account No", AccountNo);
    //             SalaryProcessingLines.SETFILTER(SalaryProcessingLines."Salary Type", '%1|%2', SalaryProcessingLines."Salary Type"::Salary, SalaryProcessingLines."Salary Type"::Pension);
    //             //     IF ProductType = 'M_OD' THEN
    //             //       SalaryProcessingLines.SETFILTER(SalaryProcessingLines."Document No.",'<> STAFF WELFARE MAY-23' );//overdraft
    //             IF SalaryProcessingLines.FINDFIRST THEN BEGIN
    //                 SalaryAmount[i] := SalaryProcessingLines."Gross Amount";

    //             END ELSE BEGIN
    //                 PayrollMonthlyTransactions.RESET;
    //                 PayrollMonthlyTransactions.SETRANGE(PayrollMonthlyTransactions."Employee Code", saccoAccount."Personal No.");
    //                 PayrollMonthlyTransactions.SETRANGE(PayrollMonthlyTransactions."Payroll Period", SalStart[i], SalEnd[i]);
    //                 PayrollMonthlyTransactions.SETRANGE(PayrollMonthlyTransactions."Transaction Code", 'NPAY');
    //                 IF PayrollMonthlyTransactions.FINDFIRST THEN
    //                     SalaryAmount[i] := PayrollMonthlyTransactions.Amount;
    //             END;
    //         END;
    //         //Error('Check Date%1Checkdate%2CheckDate%3',SalaryAmount[1],SalaryAmount[2],SalaryAmount[3]);
    //         //Error('%1-%2-%3', SalaryAmount[1], SalaryAmount[2], SalaryAmount[3]);

    //         IF (SalaryAmount[1] = 0) OR (SalaryAmount[2] = 0) OR (SalaryAmount[3] = 0) THEN BEGIN
    //             GrossSalary := 0;
    //         END;

    //         GrossSalary := SalaryAmount[1];
    //         FOR i := 2 TO 3 DO BEGIN
    //             IF SalaryAmount[i] < GrossSalary THEN
    //                 GrossSalary := SalaryAmount[i];
    //         END;

    //         IF Members."Employer Code" = 'POSTAL CORP' THEN BEGIN
    //             GrossSalary := SalaryAmount[1]; //initialising with one sal
    //             FOR i := 2 TO 5 DO BEGIN //starting loop with the second salary
    //                 IF SalaryAmount[i] > 0 THEN BEGIN //if the second or any of sal is present thats when we compare
    //                     IF GrossSalary = 0 THEN GrossSalary := SalaryAmount[i]; //if the first sal was 0, we reinitialize before comparing
    //                     IF SalaryAmount[i] < GrossSalary THEN
    //                         GrossSalary := SalaryAmount[1];
    //                 END;
    //             END;
    //         END;

    //         //Remove in march 2024
    //         IF Members."Employer Code" = 'CDL' THEN BEGIN
    //             IF (SalaryAmount[2] = 0) OR (SalaryAmount[3] = 0) OR (SalaryAmount[4] = 0) THEN BEGIN
    //                 GrossSalary := 0;
    //             END;

    //             GrossSalary := SalaryAmount[2];
    //             FOR i := 3 TO 4 DO BEGIN
    //                 IF SalaryAmount[i] < GrossSalary THEN
    //                     GrossSalary := SalaryAmount[i];
    //             END;
    //         END;

    //     END;

    //     EXIT(GrossSalary);
    // end;


    // local procedure GetLoanQualifiedAmount(AccountNo: Code[20]; LoanProductType: Code[20]; var Msg: Text[250]; var LoanLimit: Decimal): Decimal
    // var
    //     LoanBalance: Decimal;
    //     MaxLoanAmount: Decimal;
    //     saccoAccount: Record Vendor;
    //     LoanType: Record "Loan Products Setup";
    //     LoanRep: Decimal;
    //     nDays: Decimal;
    //     DepAmt: Decimal;
    //     Loans: Record "Loans Register";
    //     SaccoSetup: Record "Sacco Setup";
    //     RatingLoanLimit: Decimal;
    //     PenaltyCounter: Record "Penalty Counter";
    //     LoansRegister: Record "Loans Register";
    //     MemberLedgerEntry: Record "Detailed Cust. Ledg. Entry";
    //     NumberOfMonths: Integer;
    //     DayLoanPaid: Date;
    //     Continue: Boolean;
    //     SalaryProcessingLines: Record "Salary Details";
    //     PayrollMonthlyTransactions: Record "prPeriod Transactions.";
    //     MaxLoanAmtPossible: Decimal;
    //     SalBuffer: Record "Salary Details";
    //     StandingOrders: Record "Standing Orders";
    //     DepAcc: Record Customer;
    //     Salary1: Decimal;
    //     Salary2: Decimal;
    //     Salary3: Decimal;
    //     SalEnd: array[5] of Date;
    //     SalStart: array[5] of Date;
    //     Date3: Date;
    //     Date1: Date;
    //     Date2: Date;
    //     NetSal: Decimal;
    //     IntAmt: Decimal;
    //     ProdFac: Record "Loan Products Setup";
    //     GrossSalaryAmount: Decimal;
    //     NetSalaryAmount: Decimal;
    //     SalaryLoans: Record "Loans Register";
    //     STO: Record "Standing Orders";
    //     LoanRepayments: Decimal;
    //     STODeductions: Decimal;
    //     SameLoanRepayments: Decimal;
    //     SameLoanOutstandingBal: Decimal;
    //     CoopSetup: Record "Sky Mobile Setup";
    //     TotalCharge: Decimal;
    //     SaccoFee: Decimal;
    //     VendorCommission: Decimal;
    //     SMSCharge: Decimal;
    //     MemberNo: Code[30];
    //     MobileLoan: Record "Sky Mobile Loans";
    //     LoanProductsSetup: Record "Loan Products Setup";
    //     LoanProduct: Record "Loan Products Setup";
    //     SavAcc: Record Vendor;
    //     Repaymentdiff: Decimal;
    //     Fromdate: Date;
    //     Todate: Date;
    //     CreditRating: Record "Credit Rating";
    //     Customers: Record Customer;
    //     i: Integer;
    //     SalaryAmount: array[5] of Decimal;
    //     EmployerCode: Code[30];
    //     SalaryPostingCharge: Decimal;
    // begin
    //     MaxLoanAmount := 0;
    //     saccoAccount.RESET;
    //     saccoAccount.SETRANGE("No.", AccountNo);
    //     IF saccoAccount.FINDFIRST THEN BEGIN
    //         IF LoanType.GET(LoanProductType) THEN BEGIN
    //             LoanBalance := 0;
    //             LoanRep := 0;

    //             Loans.RESET;
    //             Loans.SETRANGE("Client Code", saccoAccount."BOSA Account No");
    //             Loans.SETRANGE("Loan Product Type", LoanProductType);
    //             Loans.SETFILTER("Outstanding Balance", '>0');
    //             IF Loans.FINDSET THEN BEGIN
    //                 REPEAT
    //                     Loans.CALCFIELDS("Outstanding Balance");
    //                     LoanBalance += Loans."Outstanding Balance";
    //                 UNTIL Loans.NEXT = 0;
    //             END;

    //             LoanRep += LoanBalance;

    //             MaxLoanAmount := LoanType."Max. Loan Amount";

    //             Loans.RESET;
    //             Loans.SETRANGE("Client Code", MemberNo);
    //             Loans.SETFILTER(Loans."Loan Product Type", MobileLoan."Loan Product Type");
    //             Loans.SETFILTER("Outstanding Balance", '>0');
    //             IF Loans.FINDFIRST THEN BEGIN
    //                 LoanProductsSetup.GET(Loans."Loan Product Type");

    //                 // Msg := 'Your ' + LoanProduct."Product Description" + ' request on ' + DateTimeToText(CURRENTDATETIME) + ' has failed, You have an active ' + LoanProduct."USSD Product Name";
    //                 MobileLoan.Remarks := 'Member has active Loan No. ' + Loans."Loan  No." + ' - ' + LoanProduct."Product Description";
    //                 MobileLoan.Status := MobileLoan.Status::Failed;
    //                 MobileLoan.Posted := TRUE;
    //                 MobileLoan."Date Posted" := CURRENTDATETIME;
    //                 MobileLoan.Message := Msg;
    //                 //SendSms(Source::MBANKING, SavAcc."Mobile Phone No", Msg, FORMAT(MobileLoan."Entry No"), SavAcc."No.", TRUE, Priority, TRUE);
    //                 MobileLoan.MODIFY;
    //                 Continue := FALSE;
    //             END;
    //             Fromdate := CALCDATE('-1M-CM', TODAY);

    //             IF Customers.GET(saccoAccount."BOSA Account No") THEN BEGIN
    //                 IF Customers."Employer Code" = 'POSTAL CORP' THEN
    //                     Fromdate := CALCDATE('-3M-CM', TODAY);
    //             END;


    //             SalaryProcessingLines.RESET;
    //             SalaryProcessingLines.SETRANGE(SalaryProcessingLines."Posting Date", Fromdate, TODAY);
    //             SalaryProcessingLines.SETRANGE(SalaryProcessingLines."FOSA Account No", AccountNo);
    //             IF SalaryProcessingLines.FINDFIRST THEN BEGIN
    //                 MaxLoanAmount := LoanType."Salaried Max Loan Amount";
    //             END;

    //             PayrollMonthlyTransactions.RESET;
    //             PayrollMonthlyTransactions.SETRANGE(PayrollMonthlyTransactions."Employee Code", saccoAccount."Personal No.");
    //             PayrollMonthlyTransactions.SETRANGE(PayrollMonthlyTransactions."Payroll Period", CALCDATE('-1M-CM', TODAY), TODAY);
    //             PayrollMonthlyTransactions.SETRANGE(PayrollMonthlyTransactions."Transaction Code", 'NPAY');
    //             IF PayrollMonthlyTransactions.FINDFIRST THEN
    //                 MaxLoanAmount := PayrollMonthlyTransactions.Amount;

    //             MaxLoanAmtPossible := MaxLoanAmount;
    //             /// Error('Max%1',MaxLoanAmount);
    //             //SaccoSetup.GET;
    //             RatingLoanLimit := 0;

    //             //  SaccoSetup.TESTFIELD("Initial Loan Limit");
    //             // SaccoSetup.TESTFIELD("Maximum Mobile Loan Limit");Kit
    //             //1st Loan
    //             /*                 CreditRating.RESET;
    //                             CreditRating.SETCURRENTKEY("Date Entered");
    //                             CreditRating.SETRANGE("Member No", saccoAccount."BOSA Account No");
    //                             CreditRating.SETRANGE("Loan Product Type", LoanProductType);
    //                             IF NOT CreditRating.FINDFIRST THEN BEGIN
    //                                 RatingLoanLimit := SaccoSetup."Initial Loan Limit";Kit
    //                             END ELSE BEGIN
    //                                 //Subsequent Loan
    //                                 CreditRating.RESET;
    //                                 CreditRating.SETCURRENTKEY("Date Entered");
    //                                 CreditRating.SETRANGE("Member No", saccoAccount."BOSA Account No");
    //                                 CreditRating.SETRANGE("Loan Product Type", LoanProductType);
    //                                 IF CreditRating.FINDLAST THEN BEGIN
    //                                     IF CreditRating."Loan Limit" <= 0 THEN
    //                                         CreditRating."Loan Limit" := SaccoSetup."Initial Loan Limit";

    //                                     RatingLoanLimit := CreditRating."Loan Limit";
    //                                     IF CALCDATE('1M', CreditRating."Date Entered") <= TODAY THEN
    //                                         RatingLoanLimit := CreditRating."Loan Limit" + SaccoSetup."Loan Increment";

    //                                 END;
    //                             END; */

    //             PenaltyCounter.RESET;
    //             PenaltyCounter.SETCURRENTKEY(PenaltyCounter."Date Entered");
    //             PenaltyCounter.SETRANGE(PenaltyCounter."Member Number", saccoAccount."BOSA Account No");
    //             PenaltyCounter.SETRANGE(PenaltyCounter."Product Type", LoanProductType);
    //             IF PenaltyCounter.FINDLAST THEN BEGIN
    //                 LoansRegister.GET(PenaltyCounter."Loan Number");
    //                 LoansRegister.CALCFIELDS(LoansRegister."Outstanding Balance", LoansRegister."Outstanding Interest", LoansRegister."Outstanding Penalty");
    //                 IF (LoansRegister."Outstanding Balance" + LoansRegister."Outstanding Interest" + LoansRegister."Outstanding Penalty") > 0 THEN BEGIN
    //                     RatingLoanLimit := 0;
    //                 END ELSE BEGIN
    //                     IF PenaltyCounter."Date Penalty Paid" = 0D THEN BEGIN
    //                         RatingLoanLimit := 0;
    //                     END ELSE BEGIN
    //                         DayLoanPaid := PenaltyCounter."Date Penalty Paid";

    //                         NumberOfMonths := 0;
    //                         RatingLoanLimit := SaccoSetup."Defaulter Initial Limit";
    //                         IF TODAY > CALCDATE('3M', DayLoanPaid) THEN BEGIN
    //                             //count the number of moths from month 7
    //                             NumberOfMonths := ROUND(((TODAY - CALCDATE('3M', DayLoanPaid)) / 30), 1, '<');
    //                             //each month is equivalent a 1000 untill its about to surpass the max loan
    //                             RatingLoanLimit := SaccoSetup."Defaulter Initial Limit" + (SaccoSetup."Defaulter Loan Increment" * NumberOfMonths)
    //                         END;
    //                     END;
    //                 END;
    //             END;

    //             LoanLimit := RatingLoanLimit;

    //             // IF MaxLoanAmount > RatingLoanLimit THEN
    //             //    MaxLoanAmount := RatingLoanLimit;Kit

    //             // IF MaxLoanAmount > GetMaximumMobileLoanLimit THEN
    //             //     MaxLoanAmount := GetMaximumMobileLoanLimit;
    //             IF LoanLimit > MaxLoanAmount THEN
    //                 LoanLimit := MaxLoanAmount;

    //             IF Loans."Loan Product Type" <> 'A16' THEN BEGIN
    //                 IF LoanBalance > 0 THEN BEGIN
    //                     MaxLoanAmount := 0;
    //                     // Msg := 'You have an existing loan of this type, kindly offset the loan and try again.';
    //                 END;
    //             END;

    //             IF MaxLoanAmount > MaxLoanAmtPossible THEN
    //                 MaxLoanAmount := MaxLoanAmtPossible;

    //             IF LoanBalance > 0 THEN
    //                 MaxLoanAmount := 0;

    //             IF MaxLoanAmount < 0 THEN
    //                 MaxLoanAmount := 0;

    //             IF LoanProductType = 'A16' THEN BEGIN
    //                 saccoAccount.RESET;
    //                 saccoAccount.SETRANGE(saccoAccount."No.", AccountNo);
    //                 IF saccoAccount.FINDFIRST THEN BEGIN
    //                     GrossSalaryAmount := 0;
    //                     GrossSalaryAmount := saccoAccount."Net Salary";
    //                 END;

    //                 GrossSalaryAmount := MaxLoanAmount;//GetGrossSalary(AccountNo, LoanProductType);
    //                                                    //Error('Max%1 MaxLoanAmoutnP%2', MaxLoanAmount,AccountNo);
    //                                                    // MaxLoanAmount := 0;
    //                 LoanLimit := 0;
    //                 SalaryLoans.RESET;
    //                 SalaryLoans.SETRANGE(SalaryLoans."Client Code", saccoAccount."BOSA Account No");
    //                 SalaryLoans.SETRANGE(SalaryLoans."Recovery Mode", SalaryLoans."Recovery Mode"::Salary);
    //                 SalaryLoans.SETFILTER(SalaryLoans."Outstanding Balance", '>0');
    //                 SalaryLoans.SETFILTER(SalaryLoans."Loan Product Type", '<> A16');
    //                 IF SalaryLoans.FINDSET THEN BEGIN
    //                     REPEAT
    //                         SalaryLoans.CALCFIELDS(SalaryLoans."Outstanding Balance");
    //                         LoanRepayments += SalaryLoans.Repayment;
    //                         IF SalaryLoans."Loan Product Type" = LoanType.Code THEN BEGIN
    //                             SameLoanRepayments += SalaryLoans.Repayment;
    //                         END;
    //                     UNTIL SalaryLoans.NEXT = 0;
    //                 END;
    //                 SameLoanOutstandingBal := 0;

    //                 Loans.RESET;
    //                 Loans.SETRANGE(Loans."Client Code", saccoAccount."BOSA Account No");
    //                 Loans.SETRANGE(Loans."Recovery Mode", Loans."Recovery Mode"::Salary);
    //                 Loans.SETFILTER(Loans."Loan Product Type", 'A16');
    //                 IF Loans.FINDSET THEN BEGIN
    //                     REPEAT
    //                         Loans.CALCFIELDS(Loans."Outstanding Balance");
    //                         SameLoanOutstandingBal += Loans."Outstanding Balance";
    //                     UNTIL Loans.NEXT = 0;
    //                 END;

    //                 STO.RESET;
    //                 STO.SETRANGE(STO."Source Account No.", saccoAccount."No.");
    //                 STO.SETRANGE(STO.Status, STO.Status::Approved);
    //                 IF STO.FINDSET THEN BEGIN
    //                     REPEAT
    //                         STO.CALCFIELDS(STO."Allocated Amount");
    //                         STODeductions += STO."Allocated Amount";
    //                     UNTIL STO.NEXT = 0;
    //                 END;
    //                 // IF Members."Employer Code" <> 'STAFF' THEN SalaryPostingCharge := 144;
    //                 NetSalaryAmount := (GrossSalaryAmount * 0.72) - (((LoanRepayments - Repaymentdiff) + SameLoanOutstandingBal) + STODeductions + SalaryPostingCharge);
    //                 IF NetSalaryAmount < 0 THEN
    //                     NetSalaryAmount := 0;

    //                 /* CoopSetup.RESET;
    //                 CoopSetup.SETRANGE("Transaction Type", CoopSetup."Transaction Type"::"Loan Disbursement");
    //                 IF CoopSetup.FINDFIRST THEN BEGIN
    //                     GetCharges(CoopSetup."Transaction Type", VendorCommission, SaccoFee, Safcom, 0);
    //                     TotalCharge := SaccoFee + VendorCommission;
    //                 END; */

    //                 LoanLimit := ROUND(NetSalaryAmount / ((LoanType."Interest rate" / 12 / 100) / (1 - POWER((1 + (LoanType."Interest rate" / 12 / 100)), -LoanType."Default Installements"))), 1000, '<');

    //                 IF (LoanLimit - TotalCharge) < LoanType."Min. Loan Amount" THEN
    //                     LoanLimit := 0;

    //                 IF (LoanLimit - (SameLoanOutstandingBal - TotalCharge)) < LoanType."Min. Loan Amount" THEN
    //                     LoanLimit := 0;

    //                 IF LoanLimit > LoanType."Max. Loan Amount" THEN
    //                     LoanLimit := LoanType."Max. Loan Amount";

    //             END;
    //         END;
    //     END;

    //     EXIT(LoanLimit);
    // end;

    // local procedure GetSalaryLoanQualifiedAmount2(AccountNo: Code[20]; LoanProductType: Code[20]; var LoanLimit: Decimal; var Remark: Text[250]): Decimal
    // var
    //     LoanBalance: Decimal;
    //     MaxLoanAmount: Decimal;
    //     saccoAccount: Record Vendor;
    //     LoanType: Record "Loan Products Setup";
    //     LoanRep: Decimal;
    //     nDays: Decimal;
    //     DepAmt: Decimal;
    //     Loans: Record "Loans Register";
    //     SaccoSetup: Record "Sacco General Set-Up";
    //     RatingLoanLimit: Decimal;
    //     PenaltyCounter: Record "Penalty Counter";
    //     LoansRegister: Record "Loans Register";
    //     MemberLedgerEntry: Record "Detailed Cust. Ledg. Entry";
    //     NumberOfMonths: Integer;
    //     DayLoanPaid: Date;
    //     Continue: Boolean;
    //     SalaryProcessingLines: Record "Salary Details";
    //     PayrollMonthlyTransactions: Record "prPeriod Transactions.";
    //     MaxLoanAmtPossible: Decimal;
    //     SalBuffer: Record "Salary Details";
    //     StandingOrders: Record "Standing Orders";
    //     DepAcc: Record Customer;
    //     Salary1: Decimal;
    //     Salary2: Decimal;
    //     Salary3: Decimal;
    //     SalEnd: array[5] of Date;
    //     SalStart: array[5] of Date;
    //     NetSal: Decimal;
    //     IntAmt: Decimal;
    //     ProdFac: Record "Loan Products Setup";
    //     GrossSalaryAmount: Decimal;
    //     NetSalaryAmount: Decimal;
    //     SalaryLoans: Record "Loans Register";
    //     STO: Record "Standing Orders";
    //     LoanRepayments: Decimal;
    //     STODeductions: Decimal;
    //     SameLoanRepayments: Decimal;
    //     SameLoanOutstandingBal: Decimal;
    //     CoopSetup: Record "Sky Mobile Setup";
    //     TotalCharge: Decimal;
    //     SaccoFee: Decimal;
    //     VendorCommission: Decimal;
    //     SMSCharge: Decimal;
    //     Members: Record Customer;
    //     SaccoAcc: Record Vendor;
    //     i: Integer;
    //     SalaryAmount: array[5] of Decimal;
    //     EmployerCode: Code[30];
    //     LoanRepaymentRecFromSal: Decimal;
    //     SalaryPostingCharge: Decimal;
    // begin
    //     MaxLoanAmount := 0;
    //     Remark := '';
    //     GrossSalaryAmount := 0;
    //     saccoAccount.RESET;
    //     saccoAccount.SETRANGE("No.", AccountNo);
    //     IF saccoAccount.FINDFIRST THEN BEGIN

    //         Members.GET(saccoAccount."BOSA Account No");
    //         IF Members.Status <> Members.Status::Active THEN BEGIN
    //             LoanLimit := 0;
    //             Remark := 'Your Member Account is not active';
    //             EXIT;
    //         END;

    //         IF Members.Defaulter = TRUE THEN BEGIN
    //             LoanLimit := 0;
    //             Remark := 'You are not eligible for this product because you are listed as a defaulter';
    //             EXIT;
    //         END;


    //         SaccoAcc.RESET;
    //         SaccoAcc.SETRANGE("No.", AccountNo);
    //         IF SaccoAcc.FINDFIRST THEN BEGIN
    //             IF SaccoAcc.Status <> SaccoAcc.Status::Active THEN BEGIN
    //                 LoanLimit := 0;
    //                 Remark := 'Your depopsit contribution is inactive';
    //                 EXIT;
    //             END;
    //         END;


    //         IF LoanType.GET(LoanProductType) THEN BEGIN
    //             LoanBalance := 0;

    //             Loans.RESET;
    //             Loans.SETRANGE("Client Code", saccoAccount."BOSA Account No");
    //             Loans.SETRANGE("Loan Product Type", LoanProductType);
    //             Loans.SETFILTER(Loans."Loan Product Type", 'A01');
    //             Loans.SETFILTER("Outstanding Balance", '>0');
    //             IF Loans.FINDSET THEN BEGIN
    //                 REPEAT
    //                     Loans.CALCFIELDS("Outstanding Balance");
    //                     LoanBalance += Loans."Outstanding Balance";
    //                 UNTIL Loans.NEXT = 0;
    //                 IF LoanBalance > 0 THEN BEGIN
    //                     MaxLoanAmount := 0;
    //                     Remark := '';///* 'You already have an existing loan';
    //                     EXIT;
    //                 END;
    //             END;

    //             MaxLoanAmount := 0;

    //             EmployerCode := Members."Employer Code";
    //             //Error('Accout%1', AccountNo);
    //             MaxLoanAmount := GetGrossSalary(AccountNo, LoanProductType);

    //             LoanLimit := 0;
    //             LoanRepaymentRecFromSal := 0;
    //             SalaryLoans.RESET;
    //             SalaryLoans.SETRANGE(SalaryLoans."Client Code", saccoAccount."BOSA Account No");
    //             SalaryLoans.SETRANGE(SalaryLoans."Recovery Mode", SalaryLoans."Recovery Mode"::Salary);
    //             SalaryLoans.SETFILTER(SalaryLoans."Outstanding Balance", '>0');
    //             IF SalaryLoans.FINDSET THEN BEGIN
    //                 REPEAT
    //                     SalaryLoans.CALCFIELDS(SalaryLoans."Outstanding Balance");
    //                     LoanRepaymentRecFromSal += SalaryLoans.Repayment;
    //                     IF SalaryLoans."Loan Product Type" = LoanType.Code THEN BEGIN
    //                         SameLoanRepayments += SalaryLoans.Repayment;
    //                         SameLoanOutstandingBal += SalaryLoans."Outstanding Balance";
    //                     END;
    //                 UNTIL SalaryLoans.NEXT = 0;
    //             END;

    //             STO.RESET;
    //             STO.SETRANGE(STO."Source Account No.", saccoAccount."No.");
    //             STO.SETRANGE(STO.Status, STO.Status::Approved);
    //             IF STO.FINDSET THEN BEGIN
    //                 REPEAT
    //                     STO.CALCFIELDS(STO."Allocated Amount");
    //                     STODeductions += STO."Allocated Amount";
    //                 UNTIL STO.NEXT = 0;
    //             END;
    //             IF Members."Employer Code" <> 'STAFF' THEN SalaryPostingCharge := 144;
    //             NetSalaryAmount := ((MaxLoanAmount * 0.72) - ((LoanRepaymentRecFromSal) + (STODeductions) + (SalaryPostingCharge)));

    //             /*                 CoopSetup.RESET;
    //                             CoopSetup.SETRANGE("Transaction Type", CoopSetup."Transaction Type"::"Loan Disbursement");
    //                             IF CoopSetup.FINDFIRST THEN BEGIN
    //                                 GetCharges(CoopSetup."Transaction Type", VendorCommission, SaccoFee, Safcom, 0);
    //                                 TotalCharge := SaccoFee + VendorCommission;
    //                             END; */

    //             LoanLimit := ROUND(NetSalaryAmount / ((LoanType."Interest rate" / 12 / 100) / (1 - POWER((1 + (LoanType."Interest rate" / 12 / 100)), -LoanType."Default Installements"))), 100, '<');

    //             IF (LoanLimit - TotalCharge) < LoanType."Min. Loan Amount" THEN BEGIN
    //                 LoanLimit := 0;
    //                 Remark := '';//'You qualify for ' + FORMAT(LoanLimit) + ' which is less than the minimum amount';
    //                 EXIT;
    //             END;

    //             IF LoanLimit > LoanType."Max. Loan Amount" THEN
    //                 LoanLimit := LoanType."Max. Loan Amount";

    //             MaxLoanAmount := LoanLimit;
    //         END;
    //     END;

    //     EXIT(ROUND(MaxLoanAmount, 1, '<'));
    // end;


    // procedure GetGuarantorshipPendingAmount(LoanNo: Code[60]; ApprovedAmount: Decimal) Amount: Decimal
    // var
    //     Guarantor: record "Loans Guarantee Details";
    //     AmountGuaranteed: Decimal;
    // begin
    //     AmountGuaranteed := 0;
    //     Guarantor.Reset();
    //     Guarantor.SetRange(Guarantor."Loan No", LoanNo);
    //     Guarantor.SetRange(Guarantor."Acceptance Status", Guarantor."Acceptance Status"::Accepted);
    //     Guarantor.SetRange(Guarantor.Substituted, false);
    //     if Guarantor.FindSet() then begin
    //         Guarantor.CalcSums(Guarantor."Amont Guaranteed");
    //         AmountGuaranteed := Guarantor."Amont Guaranteed";
    //     end;

    //     Amount := ApprovedAmount - AmountGuaranteed;
    //     if Amount < 0 then
    //         Amount := 0;

    // end;

    var
        // SFactory: Codeunit "SURESTEP FactoryMobile";
        LineNo: Integer;
        BATCH_TEMPLATE: Code[60];
        BATCH_NAME: Code[80];
        // BName: Codeunit "Send Birthday SMS";
        DOCUMENT_NO: Code[40];
    // ObjMobileUsersLogs: Record "MOBILE Pin Reset Logs";

}
