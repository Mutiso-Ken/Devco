#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516865 "Tea Batch"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TeaBatch.rdlc';

    dataset
    {
        dataitem("Salary Processing Buffer"; "Salary Processing Lines")
        {
            DataItemTableView = sorting("No.") where(Processed = const(false));
            RequestFilterFields = "Account No.", "Date Filter";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(NO; "Salary Processing Buffer"."No.")
            {
            }
            column(Account_No; "Salary Processing Buffer"."Account No.")
            {
            }
            column(Staff_No; "Salary Processing Buffer"."Staff No.")
            {
            }
            column(Account_Name; "Salary Processing Buffer"."Account Name")
            {
            }
            column(Amount; "Salary Processing Buffer".Amount)
            {
            }
            column(Account_Not_Found; "Salary Processing Buffer"."Account Not Found")
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            dataitem("Standing Orders"; "Standing Orders")
            {
                DataItemLink = "Source Account No." = field("Account No.");
                DataItemTableView = where(Status = const(Approved), "Income Type" = const(Salary));
                column(ReportForNavId_1102755010; 1102755010)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    if SittingAll = false then begin
                        AmountDed := 0;
                        "Standing Orders".Effected := false;
                        "Standing Orders".Unsuccessfull := false;
                        "Standing Orders".Balance := 0;

                        if AccountS.Get("Standing Orders"."Source Account No.") then begin
                            DActivity3 := AccountS."Global Dimension 1 Code";
                            DBranch3 := AccountS."Global Dimension 2 Code";

                            AccountS.CalcFields(AccountS.Balance, AccountS."Uncleared Cheques");
                            AvailableBal := RunBal;
                            if AccountTypeS.Get(AccountS."Account Type") then begin
                                Charges.Reset;
                                if "Destination Account Type" = "destination account type"::External then
                                    Charges.SetRange(Charges."Charge Type", Charges."charge type"::"External Standing Order Fee")
                                else
                                    Charges.SetRange(Charges."Charge Type", Charges."charge type"::"Standing Order Fee");
                                if Charges.Find('-') then begin
                                    AvailableBal := AvailableBal - Charges."Charge Amount";
                                end;

                                if "Standing Orders"."Next Run Date" = 0D then
                                    "Standing Orders"."Next Run Date" := "Standing Orders"."Effective/Start Date";

                                if AvailableBal >= "Standing Orders".Amount then begin
                                    AmountDed := "Standing Orders".Amount;
                                    DedStatus := Dedstatus::Successfull;
                                    if "Standing Orders".Amount >= "Standing Orders".Balance then begin
                                        "Standing Orders".Balance := 0;
                                        "Standing Orders".Unsuccessfull := false;
                                    end else begin
                                        "Standing Orders".Balance := "Standing Orders".Balance - "Standing Orders".Amount;
                                        "Standing Orders".Unsuccessfull := true;
                                    end;
                                end else begin
                                    if "Standing Orders"."Don't Allow Partial Deduction" = true then begin
                                        AmountDed := 0;
                                        DedStatus := Dedstatus::Failed;
                                        "Standing Orders".Balance := "Standing Orders".Amount;
                                        "Standing Orders".Unsuccessfull := true;

                                    end else begin
                                        AmountDed := AvailableBal;
                                        DedStatus := Dedstatus::"Partial Deduction";
                                        "Standing Orders".Balance := "Standing Orders".Amount - AmountDed;
                                        "Standing Orders".Unsuccessfull := true;

                                    end;
                                end;

                                if AmountDed < 0 then begin
                                    AmountDed := 0;
                                    DedStatus := Dedstatus::Failed;

                                    "Standing Orders".Balance := "Standing Orders".Amount;
                                    "Standing Orders".Unsuccessfull := true;


                                end;


                                if AmountDed > 0 then begin
                                    ActualSTO := 0;
                                    if "Standing Orders"."Destination Account Type" = "Standing Orders"."destination account type"::BOSA then begin
                                        PostBOSAEntries();
                                        AmountDed := ActualSTO;
                                    end;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'TEA';
                                    GenJournalLine."Document No." := DocNo;
                                    GenJournalLine."External Document No." := "Standing Orders"."Destination Account No.";
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := "Standing Orders"."Source Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Standing Order ' + "Standing Orders"."No.";//COPYSTR("Standing Orders".Remarks,1,14);
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := AmountDed;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity3;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch3;
                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    //Added SURESTEP
                                    RunBal := RunBal - AmountDed;

                                    if "Standing Orders"."Destination Account Type" <> "Standing Orders"."destination account type"::BOSA then begin

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'GENERAL';
                                        GenJournalLine."Journal Batch Name" := 'TEA';
                                        GenJournalLine."Document No." := DocNo;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."External Document No." := "Standing Orders"."Source Account No.";
                                        if "Standing Orders"."Destination Account Type" = "Standing Orders"."destination account type"::Internal then begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                            GenJournalLine."Account No." := "Standing Orders"."Destination Account No.";
                                        end else begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                            GenJournalLine."Account No." := AccountTypeS."Standing Orders Suspense";
                                        end;
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'Standing Order ' + "Standing Orders"."No.";
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        GenJournalLine.Amount := -AmountDed;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity3;
                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch3;
                                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                    end;

                                end;

                                //Standing Order Charges
                                if AmountDed > 0 then begin
                                    Charges.Reset;
                                    ChargeAmount := 0;
                                    Charges.Get('STO');
                                    Charges.Reset;
                                    if "Destination Account Type" = "destination account type"::External then
                                        Charges.SetRange(Charges."Charge Type", Charges."charge type"::"External Standing Order Fee")
                                    else
                                        Charges.SetRange(Charges."Charge Type", Charges."charge type"::"Standing Order Fee");
                                    if Charges.Find('-') then begin
                                        ChargeAmount := Charges."Charge Amount";
                                    end;
                                    if (Charges."Charge Type" = Charges."charge type"::"Standing Order Fee") or (Charges."Charge Type" = Charges."charge type"::"External Standing Order Fee")
                                    then begin
                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'GENERAL';
                                        GenJournalLine."Journal Batch Name" := 'TEA';
                                        GenJournalLine."Document No." := DocNo;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := "Standing Orders"."Source Account No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := Charges.Description;
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        GenJournalLine.Amount := ChargeAmount;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := Charges."GL Account";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity3;
                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch3;
                                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                    end;

                                end else begin
                                    if AccountTypeS.Code <> 'WSS' then begin
                                        Charges.Reset;
                                        Charges.SetRange(Charges."Charge Type", Charges."charge type"::"Failed Standing Order Fee");
                                        if Charges.Find('-') then begin
                                            LineNo := LineNo + 10000;

                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := 'GENERAL';
                                            GenJournalLine."Journal Batch Name" := 'TEA';
                                            GenJournalLine."Document No." := DocNo;
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                            GenJournalLine."Account No." := "Standing Orders"."Source Account No.";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine."Posting Date" := Today;
                                            GenJournalLine.Description := Charges.Description;
                                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                                            GenJournalLine.Amount := ChargeAmount;
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                            GenJournalLine."Bal. Account No." := Charges."GL Account";
                                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity3;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch3;
                                            // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                            // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                        end;
                                    end;
                                end;

                                //Standing Order Charges

                                //PostBOSAEntries();

                                "Standing Orders".Effected := true;
                                "Standing Orders"."Date Reset" := Today;
                                "Standing Orders".Modify;


                                STORegister.Init;
                                STORegister."Register No." := '';
                                STORegister.Validate(STORegister."Register No.");
                                STORegister."Standing Order No." := "Standing Orders"."No.";
                                STORegister."Source Account No." := "Standing Orders"."Source Account No.";
                                STORegister."Staff/Payroll No." := "Standing Orders"."Staff/Payroll No.";
                                STORegister.Date := Today;
                                STORegister."Account Name" := "Standing Orders"."Account Name";
                                STORegister."Destination Account Type" := "Standing Orders"."Destination Account Type";
                                STORegister."Destination Account No." := "Standing Orders"."Destination Account No.";
                                STORegister."Destination Account Name" := "Standing Orders"."Destination Account Name";
                                STORegister."BOSA Account No." := "Standing Orders"."BOSA Account No.";
                                STORegister."Effective/Start Date" := "Standing Orders"."Effective/Start Date";
                                STORegister."End Date" := "Standing Orders"."End Date";
                                STORegister.Duration := "Standing Orders".Duration;
                                STORegister.Frequency := "Standing Orders".Frequency;
                                STORegister."Don't Allow Partial Deduction" := "Standing Orders"."Don't Allow Partial Deduction";
                                STORegister."Deduction Status" := DedStatus;
                                STORegister.Remarks := "Standing Orders".Remarks;
                                STORegister.Amount := "Standing Orders".Amount;
                                STORegister."Amount Deducted" := AmountDed;
                                if "Standing Orders"."Destination Account Type" = "Standing Orders"."destination account type"::External then
                                    STORegister.EFT := true;
                                STORegister."Document No." := DocNo;
                                STORegister.Insert(true);


                            end;
                        end;

                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                TeaPay: Decimal;
                hehe: Decimal;
            begin

                ProcessingUser := '';
                ProcessingUser := UpperCase(UserId);

                if "Salary Processing Buffer".USER = ProcessingUser then begin
                    SalBuffer.Reset;
                    SalBuffer.SetRange(SalBuffer.Processed, false);
                    SalBuffer.SetRange(SalBuffer."Account No.", "Salary Processing Buffer"."Account No.");
                    if SalBuffer.Find('-') then begin
                        repeat
                            if SalBuffer."Blocked Accounts" = true then
                                Error(Text0001, SalBuffer."Account No.")
                        until SalBuffer.Next = 0;
                    end;

                    Gensetup.Get;

                    LineNo := LineNo + 10000;
                    TotSal := TotSal + "Salary Processing Buffer".Amount;


                    if Account.Get("Salary Processing Buffer"."Account No.") then begin

                        DActivity2 := Account."Global Dimension 1 Code";
                        DBranch2 := Account."Global Dimension 2 Code";

                        if "Salary Processing Buffer"."Account No." = '350010' then begin

                            LineNo := LineNo + 1000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'TEA';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."External Document No." := "Salary Processing Buffer"."Branch Reff.";
                            GenJournalLine."Posting Date" := PDate;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := "Salary Processing Buffer"."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := "Salary Processing Buffer".Name;
                            GenJournalLine.Amount := -"Salary Processing Buffer".Amount;
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;

                        //Check Account Bal
                        AvailableBal := 0;
                        Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."ATM Transactions");
                        AvailableBal := (Account.Balance - (Account."Uncleared Cheques" + Account."ATM Transactions"));
                        if AccountTypeS.Get(Account."Account Type") then
                            AvailableBal := AvailableBal - AccountTypeS."Minimum Balance";

                        if AvailableBal < 0 then
                            AvailableBal := 0;

                        LineNo := LineNo + 1000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'TEA';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."External Document No." := "Salary Processing Buffer"."Branch Reff.";
                        GenJournalLine."Posting Date" := PDate;
                        if "Salary Processing Buffer"."Account No." = '350010' then
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account"
                        else
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := "Salary Processing Buffer"."Account No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        if (Account."Account Category" = Account."account category"::Branch)
                        or ("Salary Processing Buffer"."Account No." = '350010') then
                            GenJournalLine.Description := "Salary Processing Buffer".Name
                        else
                            GenJournalLine.Description := 'Tea Payout';
                        if SittingAll = true then
                            GenJournalLine.Description := Remarks;
                        GenJournalLine.Amount := -"Salary Processing Buffer".Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //---------------------------------------Tea Graduated Charges----------------------------
                        RunBal := ("Salary Processing Buffer".Amount);
                        TeaComm.Reset;
                        if TeaComm.Find('-') then
                            repeat
                                if (RunBal >= TeaComm."Lower Bound") and (RunBal <= TeaComm."Upper Bound") then begin
                                    ProcFee := TeaComm.Charge;
                                    ExciseFee := ProcFee * (Gensetup."Excise Duty(%)" / 100);
                                end
                            until TeaComm.Next = 0;
                        //--------------------------------------Tea Graduated Charges---------------------------------
                        if (Account."Account Category" <> Account."account category"::Branch)
                        and ("Salary Processing Buffer"."Account No." <> '350010') then begin
                            LineNo := LineNo + 1000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'TEA';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."Posting Date" := PDate;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := "Salary Processing Buffer"."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            if SittingAll = true then
                                GenJournalLine.Description := 'Processing Fee'
                            else
                                GenJournalLine.Description := 'Tea Processing Fee';
                            GenJournalLine.Amount := ProcFee;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := ProcGLAccount;
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                            // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;


                            //Excise duty

                            Gensetup.Get;
                            LineNo := LineNo + 1000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'TEA';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."Posting Date" := PDate;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := "Salary Processing Buffer"."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := 'Excise Duty';
                            GenJournalLine.Amount := ExciseFee;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := Gensetup."Excise Duty Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                            // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;

                        //Loans Recovery
                        if SittingAll = false then begin

                            if Account."Account Category" <> Account."account category"::Branch then
                                RunBal := "Salary Processing Buffer".Amount - (ProcFee + ExciseFee);

                            /*
                            //Registration Fee
                            RegFee:=0;
                            Vend.RESET;
                            Vend.SETRANGE(Vend."No.","Salary Processing Buffer"."Account No.");
                            Vend.SETFILTER(Vend."Registration Date",'>%1',20172008D);
                            Vend.SETFILTER(Vend."Account Type",'<>%1|<>%2','HOLIDAY','JUNIOR');
                            IF  Vend.FIND('-') THEN
                              BEGIN
                                IF (RunBal>485) THEN
                                  RegFee:=485
                                ELSE
                                  RegFee:=RunBal;

                                //Charge Reg Fee
                                IF (SureAccountCharges.FnCheckIfPaid("Salary Processing Buffer"."Account No.")=FALSE) THEN
                                  BEGIN
                                    LineNo:=LineNo+10000;
                                    SureAccountCharges.FnAccountOpen('GENERAL','TEA',LineNo,"Salary Processing Buffer"."Account No.",RegFee,DActivity2,DBranch2,DocNo);
                                  END;
                                  RunBal:=RunBal-ABS(RegFee);
                              END;
                              */
                            //1.----------------------RECOVER OVERDRAFT--------------------------------------
                            RunBal := FnRecoverOverDraft("Salary Processing Buffer"."Account No.", RunBal);
                            // RunBal:=FnRecoverOverDraft("Tea Processing Buffer"."Account No.",RunBal);
                            //-------------------------------END----------------------------------------------

                            //End of Registation Fee
                            startDate := IssueDate;
                            SDATE := '..' + Format(startDate);

                            Loans.Reset;
                            Loans.SetCurrentkey(Loans.Source, Loans."Client Code", Loans."Loan Product Type", Loans."Issued Date");
                            Loans.SetRange(Loans."Client Code", "Salary Processing Buffer"."Client Code");
                            Loans.SetFilter(Loans."Period Date Filter", GetFilter("Date Filter"));
                            if Loans.Find('-') then begin
                                if Loans."Employer Code" <> 'MMH' then
                                    repeat
                                        if RunBal > 0 then begin
                                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                                            if Loans."Oustanding Interest" > 0 then begin
                                                Interest := 0;
                                                Interest := Loans."Oustanding Interest";
                                                if Interest > 0 then begin
                                                    LineNo := LineNo + 10000;

                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                                    GenJournalLine."Journal Batch Name" := 'TEA';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                                    GenJournalLine."Account No." := "Salary Processing Buffer"."Client Code";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                                    GenJournalLine."Document No." := DocNo;
                                                    GenJournalLine."Posting Date" := PDate;
                                                    GenJournalLine.Description := 'Interest Paid';
                                                    if RunBal > Interest then
                                                        GenJournalLine.Amount := Interest * -1
                                                    else
                                                        GenJournalLine.Amount := RunBal * -1;
                                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                    GenJournalLine."Loan No" := Loans."Loan  No.";
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;

                                                    LineNo := LineNo + 10000;

                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                                    GenJournalLine."Journal Batch Name" := 'TEA';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                                    GenJournalLine."Account No." := "Salary Processing Buffer"."Account No.";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                                    GenJournalLine."Document No." := DocNo;
                                                    GenJournalLine."Posting Date" := PDate;
                                                    GenJournalLine.Description := 'Interest Paid - ' + Loans."Loan Product Type Name";
                                                    if RunBal > Interest then
                                                        GenJournalLine.Amount := Interest
                                                    else
                                                        GenJournalLine.Amount := RunBal;
                                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;

                                                    RunBal := RunBal - Abs(GenJournalLine.Amount);
                                                end;
                                            end;
                                            //END;
                                        end;
                                    until Loans.Next = 0;
                            end;


                            startDate := 20000101D;
                            SDATE := '..' + Format(startDate);
                            //Priciple
                            Loans.Reset;
                            Loans.SetCurrentkey(Loans.Source, Loans."Client Code", Loans."Loan Product Type", Loans."Issued Date");
                            Loans.SetRange(Loans."Client Code", "Salary Processing Buffer"."Client Code");
                            Loans.SetRange(Loans."Issued Date", startDate, IssueDate);
                            if Loans.Find('-') then begin
                                if Loans."Employer Code" <> 'MMH' then
                                    repeat
                                        if RunBal > 0 then begin
                                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                                            if Loans."Outstanding Balance" > 0 then begin
                                                LRepayment := 0;
                                                LRepayment := Loans."Loan Principle Repayment";
                                                if LRepayment > 0 then begin
                                                    if LRepayment > Loans."Outstanding Balance" then
                                                        LRepayment := Loans."Outstanding Balance";
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                                    GenJournalLine."Journal Batch Name" := 'TEA';

                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                                    GenJournalLine."Account No." := "Salary Processing Buffer"."Client Code";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                                    GenJournalLine."Document No." := DocNo;
                                                    GenJournalLine."Posting Date" := PDate;
                                                    GenJournalLine.Description := 'Loan Repayment';

                                                    if RunBal > LRepayment then
                                                        GenJournalLine.Amount := LRepayment * -1
                                                    else
                                                        GenJournalLine.Amount := RunBal * -1;
                                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                                    GenJournalLine."Loan No" := Loans."Loan  No.";
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;

                                                    LineNo := LineNo + 10000;

                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                                    GenJournalLine."Journal Batch Name" := 'TEA';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                                    GenJournalLine."Account No." := "Salary Processing Buffer"."Account No.";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                                    GenJournalLine."Document No." := DocNo;
                                                    GenJournalLine."Posting Date" := PDate;
                                                    GenJournalLine.Description := 'Loan Repayment - ' + Loans."Loan Product Type Name";
                                                    if RunBal > LRepayment then
                                                        GenJournalLine.Amount := LRepayment
                                                    else
                                                        GenJournalLine.Amount := RunBal;
                                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                                    GenJournalLine."Loan No" := Loans."Loan  No.";
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;

                                                    RunBal := RunBal - Abs(GenJournalLine.Amount);
                                                end;
                                            end;
                                        end;
                                    until Loans.Next = 0;
                            end;

                        end;

                    end else begin
                        "Salary Processing Buffer"."Account Not Found" := true;
                    end;
                    if Account.Get("Salary Processing Buffer"."Account No.") then begin
                        Account."Salary Processing" := true;
                        Account."Net Salary" := "Salary Processing Buffer".Amount;
                        Account.Modify;
                    end;
                    "Salary Processing Buffer"."Document No." := DocNo;
                    "Salary Processing Buffer".Date := PDate;
                    "Salary Processing Buffer".Modify;
                end;

            end;

            trigger OnPreDataItem()
            begin

                if DocNo = '' then
                    Error('You must specify the Document No.');

                if PDate = 0D then
                    Error('You must specify the posting date.');

                if IssueDate = 0D then
                    Error('You must specify the last issue date.');

                if SittingAll = true then begin
                    if Remarks = '' then
                        Error('You must specify the remarks for other GENERAL.');
                end;

                STORegister.Reset;
                STORegister.SetRange(STORegister."Document No.", DocNo);
                STORegister.SetRange(STORegister.Date, PDate);
                STORegister.SetRange(STORegister."Transfered to EFT", false);
                if STORegister.Find('-') then
                    STORegister.DeleteAll;


                GenJournalLine.Reset;
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'TEA');
                if GenJournalLine.Find('-') then
                    GenJournalLine.DeleteAll;

                ExciseFee := 0;
                ProcFee := 0;

                //Get Tea charges GL A/C
                if Charges.Get('TEA') then begin
                    ProcGLAccount := Charges."GL Account";
                end;

                //Get Tea Payout GL A/C

                if Charges.Get('TEAPAY') then begin
                    TeaPayGLAccount := Charges."GL Account";
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DocNo; DocNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Document No';
                }
                field(PDate; PDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                }
                field(IssueDate; IssueDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Loans Issue Date';
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Caption = 'Remarks';
                }
                field(SittingAll; SittingAll)
                {
                    ApplicationArea = Basic;
                    Caption = 'Other Payments';
                }
                field(DontChargeProcFee; DontChargeProcFee)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dont Charge Processing Fee';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        BATCH_TEMPLATE := 'GENERAL';
        //BATCH_NAME:='SALARIES';
        BATCH_NAME := 'TEA';
        DOCUMENT_NO := DocNo;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        STORegister: Record "Standing Order Register";
        AmountDed: Decimal;
        DedStatus: Option Successfull,"Partial Deduction",Failed;
        Charges: Record Charges;
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        SalFee: Decimal;
        SalGLAccount: Code[20];
        Loans: Record "Loans Register";
        LRepayment: Decimal;
        RunBal: Decimal;
        Interest: Decimal;
        SittingAll: Boolean;
        UsersID: Record User;
        DActivity: Code[20];
        DBranch: Code[20];
        AccountS: Record Vendor;
        AccountTypeS: Record "Account Types-Saving Products";
        IssueDate: Date;
        DActivity2: Code[20];
        DBranch2: Code[20];
        DActivity3: Code[20];
        DBranch3: Code[20];
        BOSABank: Code[20];
        ReceiptAllocations: Record "Receipt Allocation";
        STORunBal: Decimal;
        ReceiptAmount: Decimal;
        StandingOrders: Record "Standing Orders";
        AccountCard: Record Vendor;
        AccountCard2: Record Vendor;
        FlexContribution: Decimal;
        FlexAccountNo: Code[20];
        ActualSTO: Decimal;
        InsCont: Decimal;
        LoanType: Record "Loan Products Setup";
        Remarks: Text[50];
        Trans: Record Transactions;
        TotSal: Decimal;
        Gensetup: Record "Sacco General Set-Up";
        ProcessingUser: Code[50];
        SalBuffer: Record "Salary Processing Lines";
        Text0001: label 'There is a blocked account %1 kindly unblock before proceeding';
        DontChargeProcFee: Boolean;
        startDate: Date;
        SDATE: Text;
        ChargeAmount: Decimal;
        TeaComm: Record "Tea Commissions";
        TeaCharges: Decimal;
        ProcFee: Decimal;
        ExciseFee: Decimal;
        ProcGLAccount: Code[10];
        TeaPayGLAccount: Code[10];
        RegFee: Decimal;
        Vend: Record Vendor;
        SureAccountCharges: Codeunit SureAccountCharges;
        SFactory: Codeunit "SURESTEP Factory";
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        BalanceCutOffDate: Date;


    procedure PostBOSAEntries()
    var
        ReceiptAllocation: Record "Receipt Allocation";
    begin
        //BOSA Cash Book Entry
        if "Standing Orders"."Destination Account No." = '502-00-000300-00' then
            BOSABank := '13865'
        else
            if "Standing Orders"."Destination Account No." = '502-00-000303-00' then
                BOSABank := '070006';

        if AmountDed > 0 then begin
            STORunBal := AmountDed;


            ReceiptAllocations.Reset;
            ReceiptAllocations.SetRange(ReceiptAllocations."Document No", "Standing Orders"."No.");
            ReceiptAllocations.SetRange(ReceiptAllocations."Member No", "Standing Orders"."BOSA Account No.");
            if ReceiptAllocations.Find('-') then begin
                repeat
                    ReceiptAllocations."Amount Balance" := 0;
                    ReceiptAllocations."Interest Balance" := 0;

                    ReceiptAmount := ReceiptAllocations.Amount;//-ReceiptAllocations."Amount Balance";

                    //Check Loan Balances
                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Repayment then begin
                        Loans.Reset;
                        Loans.SetRange(Loans."Loan  No.", ReceiptAllocations."Loan No.");
                        if Loans.Find('-') then begin
                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");

                            if ReceiptAmount > Loans."Outstanding Balance" then
                                ReceiptAmount := Loans."Outstanding Balance";

                            if Loans."Oustanding Interest" > 0 then
                                ReceiptAmount := ReceiptAmount - Loans."Oustanding Interest";

                        end else
                            Error('Loan No. %1 not Found. :- %2', ReceiptAllocations."Loan No.", ReceiptAllocations."Document No");
                    end;

                    if ReceiptAmount < 0 then
                        ReceiptAmount := 0;

                    if STORunBal < 0 then
                        STORunBal := 0;

                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'TEA';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := DocNo;
                    GenJournalLine."External Document No." := "Standing Orders"."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                    GenJournalLine."Account No." := ReceiptAllocations."Member No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type") + '-' + "Standing Orders"."No.";
                    if STORunBal > ReceiptAmount then
                        GenJournalLine.Amount := -ReceiptAmount
                    else
                        GenJournalLine.Amount := -STORunBal;

                    //PKK
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Deposit Contribution" then
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution"
                    else
                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Repayment then
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment
                        else
                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Benevolent Fund" then
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Benevolent Fund"
                            else
                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee"
                                else
                                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Shares Capital" then
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Shares Capital"
                                    else
                                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"FOSA Shares" then
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"FOSA Shares"
                                        else
                                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Pepea Shares" then
                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Pepea Shares"
                                            else
                                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Tambaa Shares" then
                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Tamba Shares"
                                                else
                                                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Lift Shares" then
                                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Lift Shares";

                    GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity3;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch3;
                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    ReceiptAllocations."Amount Balance" := ReceiptAllocations."Amount Balance" + (GenJournalLine.Amount * -1);

                    STORunBal := STORunBal + GenJournalLine.Amount;
                    ActualSTO := ActualSTO + (GenJournalLine.Amount * -1);

                    //PKK
                    if STORunBal < 0 then
                        STORunBal := 0;


                    if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Repayment) then begin
                        LineNo := LineNo + 10000;

                        //Check Outstanding Interest
                        Loans.Reset;
                        Loans.SetRange(Loans."Loan  No.", ReceiptAllocations."Loan No.");
                        if Loans.Find('-') then begin
                            Loans.CalcFields(Loans."Oustanding Interest");
                            ReceiptAmount := Loans."Oustanding Interest";
                        end else
                            Error('Loan No. %1 not Found. :- %2', ReceiptAllocations."Loan No.", ReceiptAllocations."Document No");


                        if ReceiptAmount < 0 then
                            ReceiptAmount := 0;

                        if ReceiptAmount > 0 then begin

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'TEA';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."External Document No." := "Standing Orders"."No.";
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                            GenJournalLine."Account No." := ReceiptAllocations."Member No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := 'Interest Paid ' + "Standing Orders"."No.";
                            if STORunBal > ReceiptAmount then
                                GenJournalLine.Amount := -ReceiptAmount
                            else
                                GenJournalLine.Amount := -STORunBal;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                            GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity3;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch3;
                            // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            ReceiptAllocations."Interest Balance" := ReceiptAllocations."Interest Balance" + (GenJournalLine.Amount * -1);

                            STORunBal := STORunBal + GenJournalLine.Amount;
                            ActualSTO := ActualSTO + (GenJournalLine.Amount * -1);


                        end;
                    end;

                    ReceiptAllocations.Modify;

                until ReceiptAllocations.Next = 0;
            end;
        end;
    end;

    local procedure FnRecoverOverDraft("Account No": Code[100]; RunningBalance: Decimal): Decimal
    var
        ObjVendor: Record Vendor;
        ObjOverDraft: Record "Over Draft Register";
        ObjOverDraftSetup: Record "Overdraft Setup";
        AmountToDeduct: Decimal;
        ODNumber: Code[100];
    begin
        if RunningBalance > 0 then begin
            ODNumber := FnGetApprovedOverDraftNo("Account No");
            ObjOverDraftSetup.Get();
            AmountToDeduct := 0;
            ObjVendor.Reset;
            ObjVendor.SetRange(ObjVendor."No.", "Account No");
            ObjVendor.SetFilter(ObjVendor."Date Filter", '..' + Format(PDate));
            if ObjVendor.Find('-') then begin
                ObjVendor.CalcFields(ObjVendor."Oustanding Overdraft interest", ObjVendor.Balance, ObjVendor."Outstanding Overdraft");
                if ObjVendor."Outstanding Overdraft" > 0 then begin
                    LineNo := LineNo + 10000;
                    AmountToDeduct := FnGetMonthlyRepayment("Account No");

                    if ObjVendor."Outstanding Overdraft" <= AmountToDeduct then
                        AmountToDeduct := ObjVendor."Outstanding Overdraft";

                    if RunningBalance <= AmountToDeduct then
                        AmountToDeduct := RunningBalance;

                    SFactory.FnCreateGnlJournalLineBalancedCashier(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"0", GenJournalLine."account type"::Vendor,
                    "Account No", PDate, AmountToDeduct, 'FOSA', 'OV' + "Account No", "Account No" + ' Overdraft paid', '',
                    GenJournalLine."account type"::"G/L Account", ObjOverDraftSetup."Control Account", ODNumber, GenJournalLine."overdraft codes"::"Overdraft Paid");
                    RunningBalance := RunningBalance - AmountToDeduct;
                end;
            end;
        end;
        exit(RunningBalance);
    end;

    local procedure FnGetApprovedOverDraftNo(AccNo: Code[100]): Code[100]
    var
        ObjOverdraftRegister: Record "Over Draft Register";
    begin
        ObjOverdraftRegister.Reset;
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Account No", AccNo);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister.Status, ObjOverdraftRegister.Status::Approved);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Overdraft Status", ObjOverdraftRegister."overdraft status"::Active);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Running Overdraft", true);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Recovery Mode", ObjOverdraftRegister."recovery mode"::Tea);
        if ObjOverdraftRegister.FindFirst then
            exit(ObjOverdraftRegister."Over Draft No");
    end;

    local procedure FnGetMonthlyRepayment(AccNo: Code[100]): Decimal
    var
        ObjOverdraftRegister: Record "Over Draft Register";
    begin
        ObjOverdraftRegister.Reset;
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Account No", AccNo);

        ObjOverdraftRegister.SetRange(ObjOverdraftRegister.Status, ObjOverdraftRegister.Status::Approved);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Overdraft Status", ObjOverdraftRegister."overdraft status"::Active);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Running Overdraft", true);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Recovery Mode", ObjOverdraftRegister."recovery mode"::Tea);
        if ObjOverdraftRegister.FindFirst then
            exit(ObjOverdraftRegister."Monthly Overdraft Repayment");
    end;
}

