#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516286 "Generate Salaries Batch"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/GenerateSalariesBatch.rdlc';

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
                                        //"Standing Orders"."Next Run Date":=CALCDATE("Standing Orders".Frequency,"Standing Orders"."Next Run Date");
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
                                    GenJournalLine."Journal Template Name" := JTemplate;
                                    GenJournalLine.Validate(GenJournalLine."Journal Template Name");
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine.Validate(GenJournalLine."Journal Batch Name");
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
                                        GenJournalLine."Journal Template Name" := JTemplate;
                                        GenJournalLine.Validate(GenJournalLine."Journal Template Name");
                                        GenJournalLine."Journal Batch Name" := JBatch;
                                        GenJournalLine.Validate(GenJournalLine."Journal Batch Name");
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
                                    //IF "Destination Account Type" = "Destination Account Type"::External THEN
                                    //Charges.SETRANGE(Charges."Charge Type",Charges."Charge Type"::"External Standing Order Fee")
                                    //ELSE
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
                                        GenJournalLine."Journal Template Name" := JTemplate;
                                        GenJournalLine.Validate(GenJournalLine."Journal Template Name");
                                        GenJournalLine."Journal Batch Name" := JBatch;
                                        GenJournalLine.Validate(GenJournalLine."Journal Batch Name");
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
                                            GenJournalLine."Journal Template Name" := JTemplate;
                                            GenJournalLine.Validate(GenJournalLine."Journal Template Name");
                                            GenJournalLine."Journal Batch Name" := JBatch;
                                            GenJournalLine.Validate(GenJournalLine."Journal Batch Name");
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

                trigger OnPostDataItem()
                begin
                    /*
                //Done by SURESTEP
                Trans.No:='';
                Trans."Account No":='502-023107-00';
                Trans.VALIDATE(Trans."Account No");
                Trans."Transaction Type":='CDEP';
                Trans.VALIDATE(Trans."Transaction Type");
                Trans.Amount:=TotSal;
                Trans.Posted:=TRUE;
                Trans."Cheque Type":='LOCAL';
                Trans."Cheque Processed":=TRUE;
                Trans."Cheque No":=DocNo;
                Trans."Cheque Date":=TODAY;
                Trans.Remarks:='Bulk Payment cheques';
                Trans.INSERT(TRUE);
                         */

                end;
            }

            trigger OnAfterGetRecord()
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
                            GenJournalLine."Journal Template Name" := JTemplate;
                            GenJournalLine.Validate(GenJournalLine."Journal Template Name");
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine.Validate(GenJournalLine."Journal Batch Name");
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
                        GenJournalLine."Journal Template Name" := JTemplate;
                        GenJournalLine.Validate(GenJournalLine."Journal Template Name");
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine.Validate(GenJournalLine."Journal Batch Name");
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
                            GenJournalLine.Description := 'Salary';
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


                        //Salary Processing Fee
                        if (Account."Account Category" <> Account."account category"::Branch)
                        and ("Salary Processing Buffer"."Account No." <> '350010') then begin
                            LineNo := LineNo + 1000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := JTemplate;
                            GenJournalLine.Validate(GenJournalLine."Journal Template Name");
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine.Validate(GenJournalLine."Journal Batch Name");
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."Posting Date" := PDate;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := "Salary Processing Buffer"."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            if SittingAll = true then
                                GenJournalLine.Description := 'Processing Fee'
                            else
                                GenJournalLine.Description := 'Salary Processing Fee';
                            GenJournalLine.Amount := SalFee;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := SalGLAccount;
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
                            GenJournalLine."Journal Template Name" := JTemplate;
                            GenJournalLine.Validate(GenJournalLine."Journal Template Name");
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine.Validate(GenJournalLine."Journal Batch Name");
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
                                RunBal := ("Salary Processing Buffer".Amount - (SalFee + ExciseFee));//+AvailableBal;

                            //Registration Fee
                            /*
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
                                    SureAccountCharges.FnAccountOpen('GENERAL','SALARIES',LineNo,"Salary Processing Buffer"."Account No.",RegFee,DActivity2,DBranch2,DocNo);
                                  END;
                                  RunBal:=RunBal-ABS(RegFee);
                              END;
                            */
                            //End of Registation Fee

                            //Interest
                            startDate := IssueDate;
                            SDATE := '..' + Format(startDate);

                            Loans.Reset;
                            Loans.SetCurrentkey(Loans.Source, Loans."Client Code", Loans."Loan Product Type", Loans."Issued Date");
                            Loans.SetRange(Loans."Client Code", "Salary Processing Buffer"."Client Code");
                            Loans.SetFilter(Loans."Period Date Filter", GetFilter("Date Filter"));
                            Loans.SetRange(Loans."Recovery Mode", Loans."recovery mode"::Salary);       //,Loans."Recovery Mode"::SAYE);
                            if Loans.Find('-') then begin
                                repeat
                                    if RunBal > 0 then begin
                                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                                        if Loans."Oustanding Interest" > 0 then begin
                                            Interest := 0;
                                            Interest := Loans."Oustanding Interest";

                                            if Interest > 0 then begin
                                                LineNo := LineNo + 10000;

                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := JTemplate;
                                                GenJournalLine.Validate(GenJournalLine."Journal Template Name");
                                                GenJournalLine."Journal Batch Name" := JBatch;
                                                GenJournalLine.Validate(GenJournalLine."Journal Batch Name");
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
                                                GenJournalLine."Journal Template Name" := JTemplate;
                                                GenJournalLine.Validate(GenJournalLine."Journal Template Name");
                                                GenJournalLine."Journal Batch Name" := JBatch;
                                                GenJournalLine.Validate(GenJournalLine."Journal Batch Name");
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

                            //1.--------------------------RECOVER PRINCIPAL------------------------------------------------
                            RunBal := FnRunPrinciple("Salary Processing Buffer"."Client Code", RunBal);
                            //2.----------------------RECOVER Overdraft From FOSA-------------------------------------------
                            RunBal := FnRecoverOverDraft("Salary Processing Buffer"."Account No.", RunBal);

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
                        Error('You must specify the remarks for other payments.');
                end;

                STORegister.Reset;
                STORegister.SetRange(STORegister."Document No.", DocNo);
                STORegister.SetRange(STORegister.Date, PDate);
                STORegister.SetRange(STORegister."Transfered to EFT", false);
                if STORegister.Find('-') then
                    STORegister.DeleteAll;

                if FundsUser.Get(UserId) then begin
                    FundsUser.TestField(FundsUser."Salaries Template");
                    FundsUser.TestField(FundsUser."Salaries Batch");
                    JTemplate := FundsUser."Salaries Template";
                    JBatch := FundsUser."Salaries Batch";
                    //FundsManager.PostPayment(Rec,JTemplate,JBatch);


                    GenJournalLine.Reset;
                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                    if GenJournalLine.Find('-') then begin
                        GenJournalLine.DeleteAll;
                    end;
                    /*GenJournalLine.RESET;
                    GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name",'GENERAL');
                    GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name",'SALARIES');
                    IF GenJournalLine.FIND('-') THEN
                    GenJournalLine.DELETEALL;*/

                    Gensetup.Get();
                    SalFee := 0;
                    ExciseFee := 0;
                    if DontChargeProcFee = false then begin
                        if Charges.Get('SAL') then begin
                            SalGLAccount := Charges."GL Account";
                            SalFee := Charges."Charge Amount";
                            ExciseFee := SalFee * (Gensetup."Excise Duty(%)" / 100);
                        end;
                    end;
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
                field(BalanceCutOffDate; BalanceCutOffDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Balance CutOf fDate';
                }
                field(Vendor; Vendor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary Control Account';
                    TableRelation = Vendor;
                    Visible = false;
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
        BATCH_NAME := 'SALARIES';
        //BATCH_NAME:='';
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
        DocNo: Code[30];
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
        Vendor: Code[20];
        ExciseFee: Decimal;
        RegFee: Decimal;
        Vend: Record Vendor;
        SureAccountCharges: Codeunit SureAccountCharges;
        SFactory: Codeunit "SURESTEP Factory";
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        BalanceCutOffDate: Date;
        FundsUser: Record "Funds User Setup";
        JTemplate: Code[50];
        JBatch: Code[50];


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

                            /*
                            IF (Loans."Recovery Mode"=Loans."Recovery Mode"::CheckOff) OR (Loans."Recovery Mode"=Loans."Recovery Mode"::"Standing Order")
                            OR (Loans."Recovery Mode"=Loans."Recovery Mode"::"Checkoff/Standing Order") THEN
                            */

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
                    GenJournalLine."Journal Template Name" := JTemplate;
                    GenJournalLine.Validate(GenJournalLine."Journal Template Name");
                    GenJournalLine."Journal Batch Name" := JBatch;
                    GenJournalLine.Validate(GenJournalLine."Journal Batch Name");
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
                    /*
                    IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::"Insurance Contribution" THEN BEGIN
                    IF ABS(GenJournalLine.Amount) = 100 THEN
                    InsCont:=100;
                    GenJournalLine.Amount:=-25;
                    END;
                    */
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
                                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Pepea Shares" then
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Pepea Shares"
                                    else
                                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"FOSA Shares" then
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"FOSA Shares"
                                        else
                                            // if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Tambaa Shares" then
                                            //     GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Tamba Shares"
                                            // else
                                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Changamka Shares" then
                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Changamka Shares"
                                                else
                                                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Shares Capital" then
                                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Shares Capital";

                    /*
                    ELSE IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::Withdrawal THEN
                    GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Registration Fee";
                    */
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
                    /*
                    IF (ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::"Insurance Contribution")
                       AND (InsCont = 100) THEN BEGIN
                    LineNo:=LineNo+10000;

                    GenJournalLine.INIT;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":='SALARIES';
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Document No.":=DocNo;
                    GenJournalLine."External Document No.":="Standing Orders"."No.";
                    GenJournalLine."Posting Date":=TODAY;
                    GenJournalLine."Account Type":=GenJournalLine."Bal. Account Type"::Member;
                    GenJournalLine."Account No.":=ReceiptAllocations."Member No";
                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                    GenJournalLine.Description:=FORMAT(ReceiptAllocations."Transaction Type");
                    GenJournalLine.Amount:=-75;
                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Welfare Contribution 2";
                    GenJournalLine."Loan No":=ReceiptAllocations."Loan No.";
                    GenJournalLine."Shortcut Dimension 1 Code":=DActivity3;
                    GenJournalLine."Shortcut Dimension 2 Code":=DBranch3;
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                    IF GenJournalLine.Amount<>0 THEN
                    GenJournalLine.INSERT;

                    ReceiptAllocations."Amount Balance":=ReceiptAllocations."Amount Balance" + (GenJournalLine.Amount * -1);

                    STORunBal:=STORunBal+GenJournalLine.Amount;
                    ActualSTO:=ActualSTO+(GenJournalLine.Amount*-1);

                    END;
                    */
                    //PKK

                    if STORunBal < 0 then
                        STORunBal := 0;


                    if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Repayment) then begin // AND
                                                                                                                             // (ReceiptAllocations."Interest Amount" > 0) THEN BEGIN
                        LineNo := LineNo + 10000;

                        //ReceiptAmount:=ReceiptAllocations."Interest Amount";

                        //Check Outstanding Interest
                        Loans.Reset;
                        Loans.SetRange(Loans."Loan  No.", ReceiptAllocations."Loan No.");
                        //Loans.SETRANGE(Loans."Recovery Mode",Loans."Recovery Mode"::"Standing Order");
                        if Loans.Find('-') then begin
                            Loans.CalcFields(Loans."Oustanding Interest");
                            /*
                          IF (Loans."Recovery Mode"=Loans."Recovery Mode"::CheckOff) OR (Loans."Recovery Mode"=Loans."Recovery Mode"::"Standing Order")
                          OR (Loans."Recovery Mode"=Loans."Recovery Mode"::"Checkoff/Standing Order") THEN
                                 */
                            //IF (ReceiptAmount > Loans."Oustanding Interest") AND (Loans."Oustanding Interest">0) THEN
                            ReceiptAmount := Loans."Oustanding Interest";
                        end else
                            Error('Loan No. %1 not Found. :- %2', ReceiptAllocations."Loan No.", ReceiptAllocations."Document No");


                        if ReceiptAmount < 0 then
                            ReceiptAmount := 0;

                        if ReceiptAmount > 0 then begin

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := JTemplate;
                            GenJournalLine.Validate(GenJournalLine."Journal Template Name");
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine.Validate(GenJournalLine."Journal Batch Name");
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

            /*//STIMA
            LineNo:=LineNo+10000;

            GenJournalLine.INIT;
            GenJournalLine."Journal Template Name":='GENERAL';
            GenJournalLine."Journal Batch Name":='SALARIES';
            GenJournalLine."Document No.":=DocNo;
            GenJournalLine."External Document No.":="Standing Orders"."No.";
            GenJournalLine."Line No.":=LineNo;
            GenJournalLine."Account Type":=GenJournalLine."Account Type"::"Bank Account";
            GenJournalLine."Account No.":=BOSABank;
            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
            GenJournalLine."Posting Date":=TODAY;
            GenJournalLine.Description:="Standing Orders"."Account Name";
            GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
            GenJournalLine.Amount:=AmountDed-STORunBal;
            GenJournalLine.VALIDATE(GenJournalLine.Amount);
            IF GenJournalLine.Amount<>0 THEN
            GenJournalLine.INSERT;

            */

        end;

    end;

    local procedure FnRunPrinciple(BNumber: Code[100]; RunningBalance: Decimal) NewRunningBalance: Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        AmountToDeduct: Decimal;
        WhatISaved: Decimal;
        PrincipleDue: Decimal;
        LoanApp: Record "Loans Register";
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", BNumber);
            LoanApp.SetRange(LoanApp."Recovery Mode", LoanApp."recovery mode"::Salary);
            LoanApp.SetFilter(LoanApp."Outstanding Balance", '>%1', 0);
            //LoanApp.SETFILTER(LoanApp."Repayment Start Date",'<=%1',CALCDATE('CM',IssueDate)); //Repayment Must have Started!!
            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        //PrincipleDue:=SFactory.FnGetPrincipalDueFiltered(LoanApp,'..'+FORMAT(BalanceCutOffDate));
                        PrincipleDue := LoanApp."Loan Principle Repayment";
                        if PrincipleDue > 0 then begin
                            AmountToDeduct := PrincipleDue;
                            if PrincipleDue > RunningBalance then
                                AmountToDeduct := RunningBalance;
                            //---------------------DEBIT FOSA--------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(JTemplate, JBatch, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"0",
                            GenJournalLine."account type"::Vendor, LoanApp."Account No", PDate, AmountToDeduct, 'FOSA', LoanApp."Loan  No.",
                            LoanApp."Loan Product Type" + '-Loan Repayment', '');
                            //----------------------CREDIT LOAN REPAYMENT--------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(JTemplate, JBatch, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                            GenJournalLine."account type"::Customer, LoanApp."Client Code", PDate, AmountToDeduct * -1, Format(LoanApp.Source), LoanApp."Loan  No.",
                            LoanApp."Loan Product Type" + '-Loan Repayment', LoanApp."Loan  No.");
                            RunningBalance := RunningBalance - AmountToDeduct;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
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

                    SFactory.FnCreateGnlJournalLineBalancedCashier(JTemplate, JBatch, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"0", GenJournalLine."account type"::Vendor,
                    "Account No", PDate, AmountToDeduct, 'FOSA', ODNumber, 'Overdraft' + ' ' + ODNumber + ' ' + 'Paid', '',
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
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Recovery Mode", ObjOverdraftRegister."recovery mode"::Salary);
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
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Recovery Mode", ObjOverdraftRegister."recovery mode"::Salary);
        if ObjOverdraftRegister.FindFirst then
            exit(ObjOverdraftRegister."Monthly Overdraft Repayment" + ROUND(ObjOverdraftRegister."Monthly Interest Repayment") + ROUND(100 / ObjOverdraftRegister."Overdraft period(Months)"));
        //(ObjOverdraftRegister."Monthly Interest Repayment")
    end;
}

