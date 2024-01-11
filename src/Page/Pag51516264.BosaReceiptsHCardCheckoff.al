#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516264 "Bosa Receipts H Card-Checkoff"
{
    // IF Posted=TRUE THEN
    // ERROR('This Check Off has already been posted');
    // 
    // 
    // IF "Account No" = '' THEN
    // ERROR('You must specify the Account No.');
    // 
    // IF "Document No" = '' THEN
    // ERROR('You must specify the Document No.');
    // 
    // 
    // IF "Posting date" = 0D THEN
    // ERROR('You must specify the Posting date.');
    // 
    // IF Amount = 0 THEN
    // ERROR('You must specify the Amount.');
    // 
    // IF "Employer Code"='' THEN
    // ERROR('You must specify Employer Code');
    // 
    // 
    // PDate:="Posting date";
    // DocNo:="Document No";
    // 
    // 
    // "Scheduled Amount":= ROUND("Scheduled Amount");
    // 
    // 
    // IF "Scheduled Amount"<>Amount THEN
    // ERROR('The Amount must be equal to the Scheduled Amount');
    // 
    // 
    // //delete journal line
    // Gnljnline.RESET;
    // Gnljnline.SETRANGE("Journal Template Name",'GENERAL');
    // Gnljnline.SETRANGE("Journal Batch Name",No);
    // Gnljnline.DELETEALL;
    // //end of deletion
    // //delete journal line
    // Gnljnline.RESET;
    // Gnljnline.SETRANGE("Journal Template Name",'GENERAL');
    // Gnljnline.SETRANGE("Journal Batch Name",No);
    // Gnljnline.INSERT;
    // //end of deletion
    // 
    // RunBal:=0;
    // 
    // IF DocNo='' THEN
    // ERROR('Kindly specify the document no.');
    // 
    // ReceiptsProcessingLines.RESET;
    // ReceiptsProcessingLines.SETRANGE(ReceiptsProcessingLines."Receipt Header No",No);
    // ReceiptsProcessingLines.SETRANGE(ReceiptsProcessingLines.Posted,FALSE);
    // IF ReceiptsProcessingLines.FIND('-') THEN BEGIN
    // REPEAT
    // 
    // 
    // ReceiptsProcessingLines.TESTFIELD(ReceiptsProcessingLines."Member No");
    // ReceiptsProcessingLines.TESTFIELD(ReceiptsProcessingLines."Trans Type");
    // {
    // IF (ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sLoan) OR
    // (ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sInterest) OR
    // (ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sInsurance) THEN
    // 
    // ReceiptsProcessingLines.TESTFIELD(ReceiptsProcessingLines."Loan No");
    // }
    // 
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sInterest THEN BEGIN
    // 
    //     LineNo:=LineNo+500;
    //     Gnljnline.INIT;
    //     Gnljnline."Journal Template Name":='GENERAL';
    //     Gnljnline."Journal Batch Name":=No;
    //     Gnljnline."Line No.":=LineNo;
    //     Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    //     Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    //     Gnljnline.VALIDATE(Gnljnline."Account No.");
    //     Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Posting Date":=PDate;
    //     Gnljnline.Description:='Interest Paid';
    //     Gnljnline.Amount:=ROUND(-1*ReceiptsProcessingLines.Amount);
    //     Gnljnline.VALIDATE(Gnljnline.Amount);
    //     Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Interest Paid";
    //     Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    //     //Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    //     Gnljnline."Loan No":=ReceiptsProcessingLines."Loan No";
    //     IF Gnljnline.Amount<>0 THEN
    //     Gnljnline.INSERT;
    // 
    //     LineNo:=LineNo+1000;
    //     Gnljnline.INIT;
    //     Gnljnline."Journal Template Name":='GENERAL';
    //     Gnljnline."Journal Batch Name":=No;
    //     Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    //     Gnljnline."Line No.":=LineNo;
    //     Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    //     //Gnljnline.VALIDATE(Gnljnline."Account No.");
    //     Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Posting Date":=PDate;
    //     Gnljnline.Description:='Interest Paid'+' '+ReceiptsProcessingLines."Loan No"+' '+ReceiptsProcessingLines."Staff/Payroll No";
    //     Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount);
    //     Gnljnline.VALIDATE(Gnljnline.Amount);
    //     //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Interest Paid";
    //     Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    //    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    //     Gnljnline."Loan No":=ReceiptsProcessingLines."Loan No";
    //     IF Gnljnline.Amount<>0 THEN
    //     Gnljnline.INSERT;
    // 
    //     END;
    // 
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sLoan THEN BEGIN
    // 
    //     LineNo:=LineNo+500;
    //     Gnljnline.INIT;
    //     Gnljnline."Journal Template Name":='GENERAL';
    //     Gnljnline."Journal Batch Name":=No;
    //     Gnljnline."Line No.":=LineNo;
    //     Gnljnline."Account Type":=Gnljnline."Account Type"::Member;
    //     Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    //     Gnljnline.VALIDATE(Gnljnline."Account No.");
    //     //Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Posting Date":=PDate;
    //     Gnljnline.Description:='Loan Repayment';
    //     Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*-1);
    //     Gnljnline.VALIDATE(Gnljnline.Amount);
    //     Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::Repayment;
    //     Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    //     //Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    //     Gnljnline."Loan No":=ReceiptsProcessingLines."Loan No";
    //     IF Gnljnline.Amount<>0 THEN
    //     Gnljnline.INSERT;
    // 
    // 
    // 
    //     LineNo:=LineNo+1000;
    //     Gnljnline.INIT;
    //     Gnljnline."Journal Template Name":='GENERAL';
    //     Gnljnline."Journal Batch Name":=No;
    //     Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    //     Gnljnline."Line No.":=LineNo;
    //     Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    //     //Gnljnline.VALIDATE(Gnljnline."Account No.");
    //     //Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Posting Date":=PDate;
    //     Gnljnline.Description:='Loan Repayment'+' '+ReceiptsProcessingLines."Loan No";
    //     Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*1);
    //    // Gnljnline.VALIDATE(Gnljnline.Amount);
    //     Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    //     //Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    //     Gnljnline."Loan No":=ReceiptsProcessingLines."Loan No";
    // 
    //     IF Gnljnline.Amount<>0 THEN
    //     Gnljnline.INSERT;
    // 
    //      END;
    // 
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sDeposits THEN BEGIN
    // 
    // LineNo:=LineNo+500;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Account Type"::Member;
    // Gnljnline.VALIDATE(Gnljnline."Account Type");
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // //Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Document No.":=DocNo;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Deposit Contribution';
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*-1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Deposit Contribution";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // //Gnljnline."Bal. Account Type":=Gnljnline."Bal. Account Type"::Customer;
    // //Gnljnline.VALIDATE(Gnljnline."Bal. Account Type");
    // //Gnljnline."Bal. Account No.":="ReceiptsProcessingLines"."Employer Code";
    // //Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    // Gnljnline.VALIDATE(Gnljnline."Account Type");
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    // //Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Document No.":=DocNo;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Deposit Contribution'+ '-'+ReceiptsProcessingLines."Member No";
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Deposit Contribution";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // //Gnljnline."Bal. Account Type":=Gnljnline."Bal. Account Type"::Customer;
    // //Gnljnline.VALIDATE(Gnljnline."Bal. Account Type");
    // //Gnljnline."Bal. Account No.":="ReceiptsProcessingLines"."Employer Code";
    // //Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // 
    // 
    // 
    // //Benevolent Fund
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sBenevolent THEN BEGIN
    // 
    // LineNo:=LineNo+500;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Document No.":=DocNo;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Benevolent Fund';
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*-1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Benevolent Fund";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    // //Gnljnline."Account Type":=Gnljnline."Account Type"::"G/L Account";
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    // //Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Document No.":=DocNo;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Benevolent Fund'+ReceiptsProcessingLines."Member No";
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*1);
    // //Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Benevolent Fund";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // 
    // //Loan Insurance
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sInsurance THEN BEGIN
    // 
    // LineNo:=LineNo+500;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Loan Insurance 0.02%'+' '+ReceiptsProcessingLines."Loan No";
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*-1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Insurance Contribution";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Loan Insurance 0.02%'+' '+ReceiptsProcessingLines."Loan No";
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Insurance Contribution";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // 
    // 
    // //Share Capital
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sShare THEN BEGIN
    // 
    // LineNo:=LineNo+500;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // //Gnljnline."Posting Date":=ReceiptsProcessingLines."Transaction Date";
    // Gnljnline.Description:='Shares Contribution';
    // Gnljnline.Amount:=ReceiptsProcessingLines.Amount*-1;
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Shares Capital";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // Gnljnline."Posting Date":=ReceiptsProcessingLines."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Shares Contribution'+' '+ReceiptsProcessingLines."Staff/Payroll No";
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Insurance Contribution";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    //  {
    // //UAP
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::"9" THEN BEGIN
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline.Description:='UAP Premium';
    // Gnljnline.Amount:=ReceiptsProcessingLines.Amount*-1;
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"UAP Premiums";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // 
    // 
    // 
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sInsurance THEN BEGIN
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Document No.":=DocNo;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Administration fee paid';
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*-1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Administration Fee Paid";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // Gnljnline."Loan No":=ReceiptsProcessingLines."Loan No";
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // }
    // UNTIL ReceiptsProcessingLines.NEXT=0;
    // END;
    //  {
    // //Bank Entry
    // 
    // //BOSA Bank Entry
    // //IF ("Mode Of Disbursement"="Mode Of Disbursement"::Cheque) THEN BEGIN
    // IF(LBatches."Mode Of Disbursement"=LBatches."Mode Of Disbursement"::Cheque) THEN BEGIN
    //      //("Mode Of Disbursement"="Mode Of Disbursement"::"Transfer to FOSA") THEN BEGIN
    // LineNo:=LineNo+10000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":=Jtemplate;
    // Gnljnline."Journal Batch Name":=JBatch;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Document No.":=DocNo;;
    // Gnljnline."Posting Date":="Posting date";
    // Gnljnline."External Document No.":=LBatches."Document No.";
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::"Bank Account";
    // Gnljnline."Account No.":=LBatches."BOSA Bank Account";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // Gnljnline.Description:=ReceiptsProcessingLines.Name;
    // Gnljnline.Amount:=ReceiptsProcessingLines.Amount*-1;
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline."Shortcut Dimension 1 Code":=DActivityBOSA;
    // Gnljnline."Shortcut Dimension 2 Code":=DBranchBOSA;
    // Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 1 Code");
    // Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 2 Code");
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // }
    // {
    // LineN:=LineN+100;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."External Document No.":=DocNo;
    // Gnljnline."Line No.":=LineN;
    // Gnljnline."Account Type":="Account Type";
    // Gnljnline."Account No.":="Account No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Check Off transfer';
    // Gnljnline.Amount:=Amount;
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // }
    // 
    // //Post New
    // Gnljnline.RESET;
    // Gnljnline.SETRANGE("Journal Template Name",'GENERAL');
    // Gnljnline.SETRANGE("Journal Batch Name",No);
    // IF Gnljnline.FIND('-') THEN BEGIN
    // CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B",Gnljnline);
    // END;
    // 
    // //Post New
    // Posted:=TRUE;
    // "Posted By":= UPPERCASE(No);
    // MODIFY;
    // 
    // {
    // "ReceiptsProcessingLines".RESET;
    // "ReceiptsProcessingLines".SETRANGE("ReceiptsProcessingLines"."Receipt Header No",No);
    //  IF "ReceiptsProcessingLines".FIND('-') THEN BEGIN
    //  REPEAT
    // "ReceiptsProcessingLines".Posted:=TRUE;
    // "ReceiptsProcessingLines".MODIFY;
    // UNTIL "ReceiptsProcessingLines".NEXT=0;
    // END;
    // MODIFY;
    // }

    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "ReceiptsProcessing_H-Checkoff";
    SourceTableView = where(Posted=const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By";"Entered By")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Date Entered";"Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date";"Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan CutOff Date";"Loan CutOff Date")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks;Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count";"Total Count")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By";"Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code";"Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Document No";"Document No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount";"Scheduled Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            part("Bosa receipt lines";"Bosa Receipt line-Checkoff")
            {
                SubPageLink = "Receipt Header No"=field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<XMLport Import receipts>")
            {
                ApplicationArea = Basic;
                Caption = 'Import Checkoff';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = XMLport "Import Checkoff Block";
            }
            group(ActionGroup1102755021)
            {
            }
            action("Validate Receipts")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Receipts';
                Image = ValidateEmailLoggingSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin


                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No",No);
                     if RcptBufLines.Find('-')then begin
                    repeat

                    Memb.Reset;
                    Memb.SetRange(Memb."Payroll/Staff No",RcptBufLines."Staff/Payroll No");
                    Memb.SetRange(Memb."Employer Code",RcptBufLines."Employer Code");
                    if Memb.Find('-') then begin
                    //memb.CALCFIELDS(memb."Benevolent Fund");

                    RcptBufLines."Member No":=Memb."No.";
                    RcptBufLines.Name:=Memb.Name;
                    RcptBufLines."ID No.":=Memb."ID No.";
                    RcptBufLines."FOSA Account":=Memb."FOSA Account";
                    // For Christmas Posting Comment From Here

                    Vendor.Reset;
                    Vendor.SetRange(Vendor."Staff No",Memb."Payroll/Staff No");
                    Vendor.SetRange(Vendor."Account Type",'CHRISTMAS');
                    if Vendor.Find('-')then begin

                      RcptBufLines."Xmas Account":=Vendor."No.";

                      RcptBufLines."Xmas Contribution":=Vendor."Monthly Contribution";
                    RcptBufLines.Modify;

                    end;

                    // End of Christmas Commenting



                    RcptBufLines."Member Found":=true;
                    RcptBufLines.Modify;
                    end;
                    until RcptBufLines.Next=0;
                    end;
                    Message('Successfull validated');
                end;
            }
            group(ActionGroup1102755019)
            {
            }
            action("Post check off")
            {
                ApplicationArea = Basic;
                Caption = 'Post check off';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    genstup.Get();
                    if Posted=true then
                    Error('This Check Off has already been posted');
                    if "Account No" = '' then
                    Error('You must specify the Account No.');
                    if "Document No" = '' then
                    Error('You must specify the Document No.');
                    if "Posting date" = 0D then
                    Error('You must specify the Posting date.');
                    if "Posting date" = 0D then
                    Error('You must specify the Posting date.');
                    if "Loan CutOff Date" = 0D then
                    Error('You must specify the Loan CutOff Date.');
                    Datefilter:='..'+Format("Loan CutOff Date");
                    IssueDate:="Loan CutOff Date";
                    startDate:=20000101D;

                    //Delete journal
                    Gnljnline.Reset;
                    Gnljnline.SetRange("Journal Template Name",'GENERAL');
                    Gnljnline.SetRange("Journal Batch Name",'CHECKOFF');
                    if Gnljnline.Find('-') then
                    Gnljnline.DeleteAll;

                    RunBal:=0;
                    TotalWelfareAmount:=0;
                    CalcFields("Scheduled Amount");
                    if "Scheduled Amount" <>   Amount then begin
                    Error('Scheduled Amount Is Not Equal To Cheque Amount');
                    end;

                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No",No);
                    RcptBufLines.SetRange(RcptBufLines.Posted,false);
                    if RcptBufLines.Find('-') then begin

                      repeat
                        RunBal:=0;
                        RunBal:=RcptBufLines.Amount;
                        RunBal:=FnRecoverWelfare(RcptBufLines,RunBal); //3
                        RunBal:=FnRunDepositContribution(RcptBufLines,RunBal); //1
                       //For December Christmas Saving Comment Below Line
                        RunBal:=FnRunXmasContribution(RcptBufLines,RunBal);  //2
                        RunBal:=FnRunEntranceFee(RcptBufLines,RunBal); //4
                        RunBal:=FnRunInterest(RcptBufLines,RunBal); //5
                        RunBal:=FnRunShareCapital(RcptBufLines,RunBal); //6
                        RunBal:=FnRunPrinciple(RcptBufLines,RunBal);  //7
                        RunBal:=FnRecoverPrincipleFromExcess(RcptBufLines,RunBal); //8
                                FnTransferExcessToUnallocatedFunds(RcptBufLines,RunBal); //9
                      until RcptBufLines.Next=0;
                    end;

                    //CREDIT WELFARE VENDOR ACCOUNT
                    LineN:=LineN+10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name":='GENERAL';
                    Gnljnline."Journal Batch Name":='CHECKOFF';
                    Gnljnline."Line No.":=LineN;
                    Gnljnline."Account Type":=Gnljnline."account type"::Vendor;
                    Gnljnline."Account No.":='L25001000001';  //Insert Welfare Control account here
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No.":="Document No";
                    Gnljnline."Posting Date":="Posting date";
                    Gnljnline.Description:='Welfare Contributions';
                    Gnljnline.Amount:=TotalWelfareAmount*-1;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                    Gnljnline."Shortcut Dimension 2 Code":='001';
                    Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                    Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                    if Gnljnline.Amount<>0 then
                    Gnljnline.Insert;

                    //DEBIT TOTAL CHECK OFF
                    CalcFields("Scheduled Amount");
                     LineN:=LineN+10000;
                     Gnljnline.Init;
                     Gnljnline."Journal Template Name":='GENERAL';
                     Gnljnline."Journal Batch Name":='CHECKOFF';
                     Gnljnline."Line No.":=LineN;
                     Gnljnline."Account Type":="Account Type";
                     Gnljnline."Account No.":="Account No";
                     Gnljnline.Validate(Gnljnline."Account No.");
                     Gnljnline."Document No.":="Document No";
                     Gnljnline."Posting Date":="Posting date";
                     Gnljnline.Description:='CHECKOFF '+Remarks;
                     Gnljnline.Amount:="Scheduled Amount";
                     Gnljnline.Validate(Gnljnline.Amount);
                     Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                     Gnljnline."Shortcut Dimension 2 Code":='001';
                     Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                     Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                     if Gnljnline.Amount<>0 then
                     Gnljnline.Insert;

                    //Post New  //To be Uncommented after thorough tests
                    Gnljnline.Reset;
                    Gnljnline.SetRange("Journal Template Name",'GENERAL');
                    Gnljnline.SetRange("Journal Batch Name",'CHECKOFF');
                    if Gnljnline.Find('-') then begin
                    //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",Gnljnline);
                    end;
                    Posted:=true;
                    Modify;
                    Message('CheckOff Successfully Generated');
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
           "Posting date":=Today;
           "Date Entered":=Today;
    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "ReceiptsProcessing_L-Checkoff";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "ReceiptsProcessing_H-Checkoff";
        Cust: Record Customer;
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "ReceiptsProcessing_L-Checkoff";
        LoanType: Record "Loan Products Setup";
        LoanApp: Record "Loans Register";
        Interest: Decimal;
        LineN: Integer;
        TotalRepay: Decimal;
        MultipleLoan: Integer;
        LType: Text;
        MonthlyAmount: Decimal;
        ShRec: Decimal;
        SHARESCAP: Decimal;
        DIFF: Decimal;
        DIFFPAID: Decimal;
        genstup: Record "Sacco General Set-Up";
        Memb: Record Customer;
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "ReceiptsProcessing_L-Checkoff";
        XMAS: Decimal;
        MemberRec: Record Customer;
        Vendor: Record Vendor;
        IssueDate: Date;
        startDate: Date;
        TotalWelfareAmount: Decimal;

    local procedure FnRunInterest(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff";RunningBalance: Decimal) NewRunningBalance: Decimal
    var
        AmountToDeduct: Decimal;
        InterestToRecover: Decimal;
    begin

        if RunningBalance > 0 then begin
        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source,"Issued Date","Loan Product Type","Client Code","Staff No","Employer Code");
        LoanApp.SetRange(LoanApp."Client Code",ObjRcptBuffer."Member No");
        LoanApp.SetRange(LoanApp."Recovery Mode",LoanApp."recovery mode"::Checkoff);
        //LoanApp.SETFILTER(LoanApp."Date filter",Datefilter); Deduct all interest outstanding regardless of date
        if LoanApp.Find('-') then
          begin
            repeat
            LoanApp.CalcFields(LoanApp."Oustanding Interest");
            if LoanApp."Oustanding Interest">0 then
              begin
                    if  RunningBalance > 0 then //300
                      begin
                        AmountToDeduct:=0;
                        InterestToRecover:=ROUND(LoanApp."Oustanding Interest",0.05,'>');//100
                        if RunningBalance >= InterestToRecover then
                        AmountToDeduct:=InterestToRecover
                        else
                        AmountToDeduct:=RunningBalance;

                        LineN:=LineN+10000;
                        Gnljnline.Init;
                        Gnljnline."Journal Template Name":='GENERAL';
                        Gnljnline."Journal Batch Name":='CHECKOFF';
                        Gnljnline."Line No.":=LineN;
                        Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                        Gnljnline."Account No.":=LoanApp."Client Code";
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline."Document No.":="Document No";
                        Gnljnline."Posting Date":="Posting date";
                        Gnljnline.Description:=LoanApp."Loan Product Type"+'-Loan Interest Paid ';
                        Gnljnline.Amount:=-1*AmountToDeduct;
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Interest Paid";
                        Gnljnline."Loan No":=LoanApp."Loan  No.";

                        Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                        Gnljnline."Shortcut Dimension 2 Code":=FnGetMemberBranch(LoanApp."Client Code");
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                        if Gnljnline.Amount<>0 then
                        Gnljnline.Insert;
                        RunningBalance:=RunningBalance-Abs(Gnljnline.Amount);
                    end;
                  end;
          until LoanApp.Next = 0;
          end;
          exit(RunningBalance);
        end;
    end;

    local procedure FnRunPrinciple(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff";RunningBalance: Decimal) NewRunningBalance: Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        AmountToDeduct: Decimal;
        NewOutstandingBal: Decimal;
    begin

        if  RunningBalance > 0 then begin
        varTotalRepay:=0;
        varMultipleLoan:=0;

        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source,"Issued Date","Loan Product Type","Client Code","Staff No","Employer Code");
        LoanApp.SetRange(LoanApp."Client Code",ObjRcptBuffer."Member No");
        LoanApp.SetRange(LoanApp."Recovery Mode",LoanApp."recovery mode"::Checkoff);
        LoanApp.SetRange(LoanApp."Issued Date",startDate,IssueDate);
        if LoanApp.Find('-') then begin
          repeat
            if  RunningBalance > 0 then
              begin
                LoanApp.CalcFields(LoanApp."Outstanding Balance");
                if LoanApp."Outstanding Balance" > 0 then
                  begin
                    AmountToDeduct:=RunningBalance;
                    NewOutstandingBal:=LoanApp."Outstanding Balance"-RunningBalance;

                    if AmountToDeduct >= LoanApp."Loan Principle Repayment" then
                      begin
                        AmountToDeduct:=LoanApp."Loan Principle Repayment";
                        NewOutstandingBal:=LoanApp."Outstanding Balance"-AmountToDeduct;
                      end;
                    if AmountToDeduct >=LoanApp."Outstanding Balance" then
                      begin
                        AmountToDeduct:=LoanApp."Outstanding Balance";
                        NewOutstandingBal:=LoanApp."Outstanding Balance"-AmountToDeduct;
                      end;

                      if NewOutstandingBal >0 then
                        FnSaveTempLoanAmount(LoanApp,NewOutstandingBal);

                        LineN:=LineN+10000;
                        Gnljnline.Init;
                        Gnljnline."Journal Template Name":='GENERAL';
                        Gnljnline."Journal Batch Name":='CHECKOFF';
                        Gnljnline."Line No.":=LineN;
                        Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                        Gnljnline."Account No.":=LoanApp."Client Code";
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline."Document No.":="Document No";
                        Gnljnline."Posting Date":="Posting date";
                        Gnljnline.Description:=LoanApp."Loan Product Type"+'-Loan Repayment ';
                        Gnljnline.Amount:=AmountToDeduct*-1;
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline."Transaction Type":=Gnljnline."transaction type"::Repayment;
                        Gnljnline."Loan No":=LoanApp."Loan  No.";
                        Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                        Gnljnline."Shortcut Dimension 2 Code":=FnGetMemberBranch(LoanApp."Client Code");
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                        if Gnljnline.Amount<>0 then
                        Gnljnline.Insert;
                        RunningBalance:=RunningBalance-Abs(Gnljnline.Amount);
                      end;
                 end;
            until LoanApp.Next = 0;
        end;
        exit(RunningBalance);
        end;
    end;

    local procedure FnRunEntranceFee(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff";RunningBalance: Decimal) NewRunningBalance: Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjMember: Record Customer;
        AmountToDeduct: Decimal;
    begin

        if RunningBalance > 0 then
          begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.",ObjRcptBuffer."Member No");
            ObjMember.SetRange(ObjMember."Payroll/Staff No",ObjRcptBuffer."Staff/Payroll No");
            ObjMember.SetRange(ObjMember."Employer Code",ObjRcptBuffer."Employer Code");
            ObjMember.SetFilter(ObjMember."Registration Date",'>%1',20170115D); //To Ensure deduction is for New Members Only
            if ObjMember.Find('-') then
              begin
                  repeat
                      ObjMember.CalcFields(ObjMember."Registration Fee Paid");
                      if Abs(ObjMember."Registration Fee Paid")<500 then
                        begin
                           if ObjMember."Registration Date" <>0D then
                              begin

                                  AmountToDeduct:=0;
                                  AmountToDeduct:=genstup."Registration Fee"-Abs(ObjMember."Registration Fee Paid");
                                  if RunningBalance <= AmountToDeduct then
                                  AmountToDeduct:=RunningBalance;

                                  LineN:=LineN+10000;
                                  Gnljnline.Init;
                                  Gnljnline."Journal Template Name":='GENERAL';
                                  Gnljnline."Journal Batch Name":='CHECKOFF';
                                  Gnljnline."Line No.":=LineN;
                                  Gnljnline."Account Type":=Gnljnline."account type"::Customer;
                                  Gnljnline."Account No.":=RcptBufLines."Member No";
                                  Gnljnline.Validate(Gnljnline."Account No.");
                                  Gnljnline."Document No.":="Document No";
                                  Gnljnline."Posting Date":="Posting date";
                                  Gnljnline.Description:='Registration Fee '+Remarks;
                                  Gnljnline.Amount:=AmountToDeduct*-1;
                                  Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Registration Fee";
                                  Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                                  Gnljnline."Shortcut Dimension 2 Code":=ObjMember."Global Dimension 2 Code";
                                  Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                                  Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                                  Gnljnline.Validate(Gnljnline.Amount);
                                  if Gnljnline.Amount<>0 then
                                  Gnljnline.Insert;
                                  RunningBalance:=RunningBalance-Abs(Gnljnline.Amount);
                              end;
                        end;
                  until Cust.Next=0;
               end;
        exit(RunningBalance);
        end;
    end;

    local procedure FnRunShareCapital(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff";RunningBalance: Decimal) NewRunningBalance: Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjMember: Record Customer;
        AmountToDeduct: Decimal;
    begin

        if RunningBalance > 0 then
          begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.",ObjRcptBuffer."Member No");
            ObjMember.SetRange(ObjMember."Employer Code",ObjRcptBuffer."Employer Code");
            ObjMember.SetRange(ObjMember."Customer Type",ObjMember."customer type"::Member);
            if ObjMember.Find('-') then
               begin
                  //REPEAT Deducted once unless otherwise advised
                    ObjMember.CalcFields (ObjMember."Shares Retained");
                    if  ObjMember."Shares Retained" < genstup."Retained Shares" then
                    begin
                      SHARESCAP:=genstup."Retained Shares";
                      DIFF:=SHARESCAP-ObjMember."Shares Retained";

                      if  DIFF > 1 then
                          begin
                          if RunningBalance > 0 then
                            begin
                             AmountToDeduct:=0;
                                  AmountToDeduct:=DIFF;
                                  if DIFF > 500 then
                                    AmountToDeduct:=500;
                             if RunningBalance <= AmountToDeduct then
                             AmountToDeduct:=RunningBalance;

                              LineN:=LineN+10000;
                              Gnljnline.Init;
                              Gnljnline."Journal Template Name":='GENERAL';
                              Gnljnline."Journal Batch Name":='CHECKOFF';
                              Gnljnline."Line No.":=LineN;
                              Gnljnline."Account Type":=Gnljnline."account type"::Customer;
                              Gnljnline."Account No.":=ObjRcptBuffer."Member No";
                              Gnljnline.Validate(Gnljnline."Account No.");
                              Gnljnline."Document No.":="Document No";
                              Gnljnline."Posting Date":="Posting date";
                              Gnljnline.Description:='Share Capital';
                              Gnljnline.Amount:=AmountToDeduct*-1;
                              Gnljnline.Validate(Gnljnline.Amount);
                              Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Shares Capital";
                              Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                              Gnljnline."Shortcut Dimension 2 Code":=ObjMember."Global Dimension 2 Code";
                              Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                              Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                              if Gnljnline.Amount<>0 then
                              Gnljnline.Insert;
                              RunningBalance:=RunningBalance-Abs(Gnljnline.Amount);
                          end;
                        end;
                    end;
                //UNTIL RcptBufLines.NEXT=0;
            end;

        exit(RunningBalance);
        end;
    end;

    local procedure FnRunDepositContribution(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff";RunningBalance: Decimal) NewRunningBalance: Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjMember: Record Customer;
        AmountToDeduct: Decimal;
    begin

        if RunningBalance > 0 then
          begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.",ObjRcptBuffer."Member No");
            ObjMember.SetRange(ObjMember."Employer Code",ObjRcptBuffer."Employer Code");
            ObjMember.SetRange(ObjMember."Customer Type",ObjMember."customer type"::Member);
            if ObjMember.Find('-') then
               begin
                  AmountToDeduct:=0;
                  AmountToDeduct:=ROUND(ObjMember."Monthly Contribution",0.05,'>');
                  if RunningBalance <= AmountToDeduct then
                  AmountToDeduct:=RunningBalance;

                  LineN:=LineN+10000;
                  Gnljnline.Init;
                  Gnljnline."Journal Template Name":='GENERAL';
                  Gnljnline."Journal Batch Name":='CHECKOFF';
                  Gnljnline."Line No.":=LineN;
                  Gnljnline."Account Type":=Gnljnline."account type"::Customer;
                  Gnljnline."Account No.":=ObjRcptBuffer."Member No";
                  Gnljnline.Validate(Gnljnline."Account No.");
                  Gnljnline."Document No.":="Document No";
                  Gnljnline."Posting Date":="Posting date";
                  Gnljnline.Description:='Unwithdrawable Deposits';
                  Gnljnline.Amount:=AmountToDeduct*-1;
                  Gnljnline.Validate(Gnljnline.Amount);
                  Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Deposit Contribution";
                  Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                  Gnljnline."Shortcut Dimension 2 Code":=ObjMember."Global Dimension 2 Code";
                  Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                  Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                  if Gnljnline.Amount<>0 then
                  Gnljnline.Insert;
                  RunningBalance:=RunningBalance-Abs(Gnljnline.Amount*-1);
            end;

        exit(RunningBalance);
        end;
    end;

    local procedure FnRunXmasContribution(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff";RunningBalance: Decimal) NewRunningBalance: Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjMember: Record Customer;
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then
          begin
                AmountToDeduct:=0;
                AmountToDeduct:=ROUND(ObjRcptBuffer."Xmas Contribution",0.05,'>');;
                if RunningBalance <=AmountToDeduct then
                AmountToDeduct:=RunningBalance;

                LineN:=LineN+10000;

                Gnljnline.Init;
                Gnljnline."Journal Template Name":='GENERAL';
                Gnljnline."Journal Batch Name":='CHECKOFF';
                Gnljnline."Line No.":=LineN;
                Gnljnline."Account Type":=Gnljnline."account type"::Vendor;
                Gnljnline."Account No.":=RcptBufLines."Xmas Account";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No.":="Document No";
                Gnljnline."Posting Date":="Posting date";
                Gnljnline.Description:='Xmas Contribution';
                Gnljnline.Amount:=AmountToDeduct*-1;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                Gnljnline."Shortcut Dimension 2 Code":=FnGetMemberBranch(ObjRcptBuffer."Member No");
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                if Gnljnline.Amount<>0 then
                Gnljnline.Insert;
                RunningBalance:=RunningBalance-Abs(Gnljnline.Amount);
        exit(RunningBalance);
        end;
    end;

    local procedure FnRecoverPrincipleFromExcess(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff";RunningBalance: Decimal) NewRunningBalance: Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjTempLoans: Record "Temp Loans Balances";
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
        varTotalRepay:=0;
        varMultipleLoan:=0;

        ObjTempLoans.Reset;
        ObjTempLoans.SetRange(ObjTempLoans."Member No",ObjRcptBuffer."Member No");
        if ObjTempLoans.Find('-') then begin
          repeat
            if  RunningBalance > 0 then
              begin
                if ObjTempLoans."Outstanding Balance" > 0 then
                  begin
                        AmountToDeduct:=RunningBalance;
                        if AmountToDeduct >=ObjTempLoans."Outstanding Balance" then
                        AmountToDeduct:=ObjTempLoans."Outstanding Balance";
                        LineN:=LineN+10000;
                        Gnljnline.Init;
                        Gnljnline."Journal Template Name":='GENERAL';
                        Gnljnline."Journal Batch Name":='CHECKOFF';
                        Gnljnline."Line No.":=LineN;
                        Gnljnline."Account Type":=Gnljnline."bal. account type"::Customer;
                        Gnljnline."Account No.":=LoanApp."Client Code";
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline."Document No.":="Document No";
                        Gnljnline."Posting Date":="Posting date";
                        Gnljnline.Description:=LoanApp."Loan Product Type"+'-Repayment Excess from checkoff'; //TODO Change the Narrative after testing
                        Gnljnline.Amount:=AmountToDeduct*-1;
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline."Transaction Type":=Gnljnline."transaction type"::Repayment;
                        Gnljnline."Loan No":=LoanApp."Loan  No.";
                        Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                        Gnljnline."Shortcut Dimension 2 Code":=FnGetMemberBranch(ObjTempLoans."Member No");
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                        if Gnljnline.Amount<>0 then
                        Gnljnline.Insert;
                        RunningBalance:=RunningBalance-Abs(Gnljnline.Amount);
                      end;
                 end;
            until  ObjTempLoans.Next = 0;
        end;
        exit(RunningBalance);
        end;
    end;

    local procedure FnSaveTempLoanAmount(ObjLoansRegister: Record "Loans Register";TempBalance: Decimal)
    var
        ObjTempLoans: Record "Temp Loans Balances";
    begin
        ObjTempLoans.Reset;
        ObjTempLoans.SetRange(ObjTempLoans."Member No",ObjLoansRegister."Client Code");
        ObjTempLoans.SetRange(ObjTempLoans."Loan No",ObjLoansRegister."Loan  No.");
        if ObjTempLoans.Find('-') then
          ObjTempLoans.DeleteAll;

        ObjTempLoans.Init;
        ObjTempLoans."Member No":=ObjLoansRegister."Client Code";
        ObjTempLoans."Loan No":=ObjLoansRegister."Loan  No.";
        ObjTempLoans."Outstanding Balance":=TempBalance;
        ObjTempLoans.Insert;
    end;

    local procedure FnGetMemberBranch(MemberNo: Code[50]): Code[100]
    var
        MemberBranch: Code[100];
    begin
        Cust.Reset;
        Cust.SetRange(Cust."No.",MemberNo);
        if Cust.Find('-') then begin
          MemberBranch:=Cust."Global Dimension 2 Code";
          end;
        exit(MemberBranch);
    end;

    local procedure FnTransferExcessToUnallocatedFunds(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff";RunningBalance: Decimal)
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjMember: Record Customer;
        AmountToDeduct: Decimal;
        AmountToTransfer: Decimal;
    begin

        if RunningBalance > 0 then
          begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.",ObjRcptBuffer."Member No");
            ObjMember.SetRange(ObjMember."Employer Code",ObjRcptBuffer."Employer Code");
            ObjMember.SetRange(ObjMember."Customer Type",ObjMember."customer type"::Member);
            if ObjMember.Find('-') then
               begin
                  AmountToTransfer:=0;
                  AmountToTransfer:=RunningBalance;

                  LineN:=LineN+10000;
                  Gnljnline.Init;
                  Gnljnline."Journal Template Name":='GENERAL';
                  Gnljnline."Journal Batch Name":='CHECKOFF';
                  Gnljnline."Line No.":=LineN;
                  Gnljnline."Account Type":=Gnljnline."account type"::Customer;
                  Gnljnline."Account No.":=ObjRcptBuffer."Member No";
                  Gnljnline.Validate(Gnljnline."Account No.");
                  Gnljnline."Document No.":="Document No";
                  Gnljnline."Posting Date":="Posting date";
                  Gnljnline.Description:='Unallocated Funds';
                  Gnljnline.Amount:=AmountToTransfer*-1;
                  Gnljnline.Validate(Gnljnline.Amount);
                  Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Unallocated Funds";
                  Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                  Gnljnline."Shortcut Dimension 2 Code":=ObjMember."Global Dimension 2 Code";
                  Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                  Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                  if Gnljnline.Amount<>0 then
                  Gnljnline.Insert;
            end;
        end;
    end;

    local procedure FnRecoverWelfare(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff";RunningBalance: Decimal) NewRunningBalance: Decimal
    var
        AmountToDeduct: Decimal;
        ObjVendor: Record Vendor;
    begin
        /*ObjVendor.RESET;
        ObjVendor.SETRANGE(ObjVendor."BOSA Account No",ObjRcptBuffer."Member No");
        ObjVendor.SETRANGE(ObjVendor."Company Code",'MMHSACCO');
        ObjVendor.SETRANGE(ObjVendor."Account Type",'ORDINARY');
        IF ObjVendor.FIND('-') THEN BEGIN
        IF RunningBalance > 0 THEN
          BEGIN
            AmountToDeduct:=RunningBalance;
            IF RunningBalance >=200 THEN
            AmountToDeduct:=200;
            TotalWelfareAmount:=TotalWelfareAmount+AmountToDeduct;
            RunningBalance:=RunningBalance-ABS(Gnljnline.Amount);
        EXIT(RunningBalance);
        END;
        END;*/
        if RunningBalance > 0 then begin
         if "Employer Code"='MMHSACCO' then begin
            AmountToDeduct:=RunningBalance;
            if RunningBalance >=300 then
            AmountToDeduct:=300;
            TotalWelfareAmount:=TotalWelfareAmount+AmountToDeduct;
            //MESSAGE('EMPLLOYER CODE IS %1',RcptBufLines."Employer Code");
             // MESSAGE('staff name is %1' + ' RcptBufLines."Name" ' ,AmountToDeduct);
             // MESSAGE('Total welfare Contribution is %1' , TotalWelfareAmount);
            RunningBalance:=RunningBalance-Abs(AmountToDeduct);
            end;
        exit(RunningBalance);
        end;

    end;
}

