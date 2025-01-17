#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516260 "BOSA Receipt Card"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "Receipts & Payments";
    SourceTableView = where(Posted=filter(false));

    layout
    {
        area(content)
        {
            group(Transaction)
            {
                Caption = 'Transaction';
                field("Transaction No.";"Transaction No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(Source;Source)
                {
                    ApplicationArea = Basic;
                }
                field("Account No.";"Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Payment";"Mode of Payment")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks;Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Allocated Amount";"Allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Un allocated Amount";"Un allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Employer No.";"Employer No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Teller Till / Bank  No.';
                }
                field("Cheque No.";"Cheque No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque / Slip  No.';
                }
                field("Cheque Date";"Cheque Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque / Slip  Date';
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Time";"Transaction Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Suggest)
            {
                Caption = 'Suggest';
                action("Cash/Cheque Clearance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cash/Cheque Clearance';

                    trigger OnAction()
                    begin
                        Cheque := false;
                        //SuggestBOSAEntries();
                    end;
                }
                separator(Action1102760032)
                {
                }
                action("Suggest Payments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Monthy Repayments';
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        TestField(Posted,false);
                        TestField("Account No.");
                        TestField(Amount);
                        //Cust.CALCFIELDS(Cust."Registration Fee Paid");

                        ReceiptAllocations.Reset;
                        ReceiptAllocations.SetRange(ReceiptAllocations."Document No","Transaction No.");
                        ReceiptAllocations.DeleteAll;


                        if "Account Type"="account type"::Customer then  begin

                        BosaSetUp.Get();
                        RunBal:=Amount;

                        if RunBal>0 then begin

                        if Cust.Get("Account No.") then begin
                        Cust.CalcFields(Cust."Registration Fee Paid");
                        if Cust."Registration Fee Paid"=0 then begin
                        if Cust."Registration Date" >20140103D then begin
                        ReceiptAllocations.Init;
                        ReceiptAllocations."Document No":="Transaction No.";
                        ReceiptAllocations."Member No":="Account No.";
                        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::"Registration Fee";
                        ReceiptAllocations."Loan No.":='';
                        ReceiptAllocations.Amount:=BosaSetUp."Registration Fee";
                        //ReceiptAllocations."Interest Amount":=Loans."Interest Due";
                        ReceiptAllocations."Total Amount":=ReceiptAllocations.Amount;
                        ReceiptAllocations."Global Dimension 1 Code":='BOSA';
                        ReceiptAllocations."Global Dimension 2 Code":='NAIROBI';
                        ReceiptAllocations.Insert;
                        RunBal:=RunBal-ReceiptAllocations.Amount;
                        end;
                        end;
                        end;
                        //********** Mpesa Charges
                        if "Mode of Payment"= "mode of payment"::Mpesa then begin
                        ReceiptAllocations.Init;
                        ReceiptAllocations."Document No":="Transaction No.";
                        ReceiptAllocations."Member No":="Account No.";
                        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::"M Pesa Charge ";
                        ReceiptAllocations."Loan No.":='';

                         // M Pesa Tarriff

                        if Amount<= 2499 then
                        ReceiptAllocations."Total Amount":=55
                        else if Amount <= 4999 then
                        ReceiptAllocations."Total Amount":=75
                        else if Amount <= 9999 then
                        ReceiptAllocations."Total Amount":=105
                        else if Amount <= 19999 then
                        ReceiptAllocations."Total Amount":=130
                        else if Amount <= 34999 then
                        ReceiptAllocations."Total Amount":=185
                        else if Amount <= 49999 then
                        ReceiptAllocations."Total Amount":=220
                        else if Amount <= 70000 then
                        ReceiptAllocations."Total Amount":=240
                        else if Amount > 70000 then
                        Error ('Sorry the Maximum M - Pesa transaction Amount is Ksha. 70,000');


                        ReceiptAllocations.Amount:=ReceiptAllocations."Total Amount";
                        ReceiptAllocations."Global Dimension 1 Code":='BOSA';
                        ReceiptAllocations."Global Dimension 2 Code":='NAIROBI';
                        ReceiptAllocations.Insert;
                        end;
                        //********** END Mpesa Charges

                        if RunBal >0 then begin
                        //Loan Repayments
                        Loans.Reset;
                        Loans.SetCurrentkey(Loans.Source,Loans."Client Code");
                        Loans.SetRange(Loans."Client Code","Account No.");
                        Loans.SetRange(Loans.Source,Loans.Source::BOSA);
                        if Loans.Find('-') then begin
                        repeat

                        //Insurance Charge
                        Loans.CalcFields(Loans."Outstanding Balance",Loans."Interest Due",Loans."Loans Insurance",Loans."Oustanding Interest");
                        if (Loans."Outstanding Balance" > 0 ) and  (Loans."Approved Amount" > 100000) and
                        (Loans."Loans Insurance">0) then begin



                        ReceiptAllocations.Init;
                        ReceiptAllocations."Document No":="Transaction No.";
                        ReceiptAllocations."Member No":="Account No.";
                        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::"Insurance Paid";
                        ReceiptAllocations."Loan No.":=Loans."Loan  No.";
                        ReceiptAllocations."Loan ID":=Loans."Loan Product Type";
                        ReceiptAllocations.Amount:=Loans."Loans Insurance";
                        //MESSAGE('ReceiptAllocations.Amount is %1',ReceiptAllocations.Amount);
                        ReceiptAllocations."Amount Balance":=Loans."Outstanding Balance";
                        ReceiptAllocations."Total Amount":=ReceiptAllocations.Amount;
                        ReceiptAllocations."Global Dimension 1 Code":='BOSA';
                        ReceiptAllocations."Global Dimension 2 Code":='NAIROBI';
                        ReceiptAllocations.Insert;
                        end;


                        if (Loans."Outstanding Balance") > 0 then begin
                        LOustanding:=0;
                        ReceiptAllocations.Init;
                        ReceiptAllocations."Document No":="Transaction No.";
                        ReceiptAllocations."Member No":="Account No.";
                        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::Repayment;
                        ReceiptAllocations."Loan No.":=Loans."Loan  No.";
                        ReceiptAllocations."Loan ID":=Loans."Loan Product Type";
                        //ReceiptAllocations.Amount:=Loans.Repayment-Loans."Loans Insurance"-Loans."Oustanding Interest";
                        ReceiptAllocations.Amount:=Loans."Loan Principle Repayment";
                        ReceiptAllocations."Amount Balance":=Loans."Outstanding Balance";
                        ReceiptAllocations."Total Amount":=ReceiptAllocations.Amount+ReceiptAllocations."Interest Amount";
                        ReceiptAllocations."Global Dimension 1 Code":='BOSA';
                        ReceiptAllocations."Global Dimension 2 Code":='NAIROBI';
                        ReceiptAllocations.Insert;
                        end;

                        if (Loans."Oustanding Interest" > 0 )then begin
                        ReceiptAllocations.Init;
                        ReceiptAllocations."Document No":="Transaction No.";
                        ReceiptAllocations."Member No":="Account No.";
                        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::"Interest Paid";
                        ReceiptAllocations."Loan No.":=Loans."Loan  No.";
                        ReceiptAllocations.Amount:=Loans."Oustanding Interest";
                        //ReceiptAllocations.Amount:=Loans."Loan Interest Repayment";
                        //ReceiptAllocations.Amount:=Loans."Interest Due";
                        ReceiptAllocations."Total Amount":=ReceiptAllocations.Amount+ReceiptAllocations."Interest Amount";
                        ReceiptAllocations."Global Dimension 1 Code":='BOSA';
                        ReceiptAllocations."Global Dimension 2 Code":='NAIROBI';
                        ReceiptAllocations.Insert;
                        end;

                        RunBal:=RunBal-ReceiptAllocations.Amount;
                        Message('RunBal is %1',RunBal);

                        until Loans.Next = 0;
                        end;
                        end;
                        end;
                        BosaSetUp.Get();
                        ReceiptAllocations.Init;
                        ReceiptAllocations."Document No":="Transaction No.";
                        ReceiptAllocations."Member No":="Account No.";
                        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::"Benevolent Fund";
                        ReceiptAllocations."Loan No.":=' ';
                        ReceiptAllocations.Amount:=BosaSetUp."Welfare Contribution";
                        ReceiptAllocations."Total Amount":=ReceiptAllocations.Amount;
                        ReceiptAllocations."Global Dimension 1 Code":='BOSA';
                        ReceiptAllocations."Global Dimension 2 Code":='NAIROBI';
                        ReceiptAllocations.Insert;

                        //Deposits Contribution
                        if Cust.Get("Account No.") then begin
                        if Cust."Monthly Contribution">0 then begin
                        ReceiptAllocations.Init;
                        ReceiptAllocations."Document No":="Transaction No.";
                        ReceiptAllocations."Member No":="Account No.";
                        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::"Deposit Contribution";
                        ReceiptAllocations."Loan No.":='';
                        ReceiptAllocations.Amount:=ROUND(Cust."Monthly Contribution",0.01);;
                        ReceiptAllocations."Total Amount":=ReceiptAllocations.Amount;
                        ReceiptAllocations."Global Dimension 1 Code":='BOSA';
                        ReceiptAllocations."Global Dimension 2 Code":='NAIROBI';
                        ReceiptAllocations.Insert;
                        end;
                        end;

                        //Shares Contribution
                        if Cust.Get("Account No.") then begin
                        Cust.CalcFields(Cust."Shares Retained");

                        if Cust."Shares Retained"<5000  then begin
                        BosaSetUp.Get();
                        if BosaSetUp."Monthly Share Contributions">0 then begin
                        //IF CONFIRM('This member has reached a maximum share contribution of Kshs. 5,000/=. Do you want to post this transaction as shares contribution?',TRUE)=TRUE THEN
                        //IF CONFIRM(Text001,TRUE) THEN BEGIN
                        ReceiptAllocations.Init;
                        ReceiptAllocations."Document No":="Transaction No.";
                        ReceiptAllocations."Member No":="Account No.";
                        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::"Shares Capital";
                        ReceiptAllocations."Loan No.":='';
                        ReceiptAllocations.Amount:=ROUND(BosaSetUp."Monthly Share Contributions",0.01);
                        ReceiptAllocations."Total Amount":=ReceiptAllocations.Amount;
                        ReceiptAllocations."Global Dimension 1 Code":='BOSA';
                        ReceiptAllocations."Global Dimension 2 Code":='NAIROBI';
                        ReceiptAllocations.Insert;
                        end;
                        end;
                        end;
                        end;

                        if "Account Type"="account type"::Vendor then  begin
                        if "Mode of Payment"= "mode of payment"::Mpesa then begin
                        ReceiptAllocations.Init;
                        ReceiptAllocations."Document No":="Transaction No.";
                        ReceiptAllocations."Member No":="Account No.";

                        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::"M Pesa Charge ";
                        ReceiptAllocations."Total Amount":= Amount ;
                        ReceiptAllocations."Loan No.":='';


                         // M Pesa Tarriff
                        MpesaCharge:=0;
                        if Amount<= 2499 then
                        ReceiptAllocations."Total Amount":=55
                        else if Amount <= 4999 then
                        ReceiptAllocations."Total Amount":=75
                        else if Amount <= 9999 then
                        ReceiptAllocations."Total Amount":=105
                        else if Amount <= 19999 then
                        ReceiptAllocations."Total Amount":=130
                        else if Amount <= 34999 then
                        ReceiptAllocations."Total Amount":=185
                        else if Amount <= 49999 then
                        ReceiptAllocations."Total Amount":=220
                        else if Amount <= 70000 then
                        ReceiptAllocations."Total Amount":=240
                        else if Amount > 70000 then
                        Error ('Sorry the Maximum M - Pesa transaction Amount is Ksha. 70,000');
                        MpesaCharge:=ReceiptAllocations."Total Amount";
                        ReceiptAllocations.Amount:=ReceiptAllocations."Total Amount";

                        //ReceiptAllocations."Total Amount":=Amount;
                        ReceiptAllocations."Global Dimension 1 Code":='BOSA';
                        ReceiptAllocations."Global Dimension 2 Code":='NAIROBI';
                        ReceiptAllocations.Insert;
                        end;

                        //********** END Mpesa Charges


                        ReceiptAllocations.Init;
                        ReceiptAllocations."Document No":="Transaction No.";
                        ReceiptAllocations."Member No":="Account No.";
                        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::"FOSA Account";
                        //GenJournalLine.Description:= 'BT'+'-'+Remarks+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No.";
                        ReceiptAllocations."Loan No.":=' ';
                        ReceiptAllocations."Total Amount":=Amount;
                        ReceiptAllocations."Global Dimension 1 Code":='FOSA';
                        ReceiptAllocations."Global Dimension 2 Code":='NAIROBI';
                        ReceiptAllocations.Amount:= ReceiptAllocations."Total Amount";
                        ReceiptAllocations.Insert;



                        end;
                        //VALIDATE("Allocated Amount");
                        CalcFields("Allocated Amount");
                        "Un allocated Amount":=(Amount-"Allocated Amount");
                        Modify;
                    end;
                }
            }
        }
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Post (F11)';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    
                    if ("Mode of Payment"="mode of payment"::Cash) and ("Transaction Date"<> Today) then
                    Error('You cannot post cash transactions with a date not today');
                    
                    if Posted then
                    Error('This receipt is already posted');
                    
                    TestField("Account No.");
                    TestField(Amount);
                    //TESTFIELD("Employer No.");
                    //TESTFIELD("Cheque No.");
                    //TESTFIELD("Cheque Date");
                    
                    if ("Account Type" = "account type"::"G/L Account") or
                       ("Account Type" = "account type"::Debtor) then
                    TransType := 'Withdrawal'
                    else
                    TransType := 'Deposit';
                    
                    BOSABank:="Employer No.";
                    if ("Account Type" = "account type"::Customer) or ("Account Type" = "account type"::"FOSA Loan") then begin
                    
                    if Amount <> "Allocated Amount" then
                    Error('Receipt amount must be equal to the allocated amount.');
                    end;
                    
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
                    GenJournalLine.DeleteAll;
                    
                    
                    LineNo:=LineNo+10000;
                    
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":='FTRANS';
                    GenJournalLine."Document No.":="Transaction No.";
                    GenJournalLine."External Document No.":="Cheque No.";
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No.":="Employer No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    //GenJournalLine."Posting Date":="Cheque Date";
                    GenJournalLine."Posting Date":="Transaction Date";
                    GenJournalLine.Description:='BT-'+"Account No.";
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
                    if TransType = 'Withdrawal' then
                    GenJournalLine.Amount:=-Amount
                    else
                    GenJournalLine.Amount:=Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;
                    
                    if ("Account Type" <> "account type"::Customer) and ("Account Type" <> "account type"::"FOSA Loan") and ("Account Type" <> "account type"::Vendor) then begin
                    LineNo:=LineNo+10000;
                    
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":='FTRANS';
                    GenJournalLine."Document No.":="Transaction No.";
                    GenJournalLine."External Document No.":="Cheque No.";
                    GenJournalLine."Line No.":=LineNo;
                    if "Account Type" = "account type"::"G/L Account" then
                    GenJournalLine."Account Type":="Account Type"
                    else if "Account Type" = "account type"::Debtor then
                    GenJournalLine."Account Type":="Account Type"
                    else if "Account Type" = "account type"::Vendor then
                    GenJournalLine."Account Type":="Account Type"
                    else if "Account Type" = "account type"::Customer then
                    GenJournalLine."Account Type":="Account Type";
                    GenJournalLine."Account No.":="Account No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    //GenJournalLine."Posting Date":="Cheque Date";
                    GenJournalLine."Posting Date":="Transaction Date";
                    GenJournalLine.Description:='BT-'+'-'+"Account No.";
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    if TransType = 'Withdrawal' then
                    GenJournalLine.Amount:=Amount
                    else
                    GenJournalLine.Amount:=-Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;
                    
                    end;
                    
                    GenSetup.Get();
                    
                    if ("Account Type" = "account type"::Customer) or ("Account Type" = "account type"::"FOSA Loan") or ("Account Type" = "account type"::Vendor)  then begin
                    
                    ReceiptAllocations.Reset;
                    ReceiptAllocations.SetRange(ReceiptAllocations."Document No","Transaction No.");
                    if ReceiptAllocations.Find('-') then begin
                    repeat
                    
                    LineNo:=LineNo+10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":='FTRANS';
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Document No.":="Transaction No.";
                    GenJournalLine."External Document No.":="Cheque No.";
                    //GenJournalLine."Posting Date":="Cheque Date";
                    GenJournalLine."Posting Date":="Transaction Date";
                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"FOSA Account" then begin
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No.":="Account No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description:='BT-'+Name+'-'+"Account No."+'-'+Remarks;
                    GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                    GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    
                    end else begin
                    if  "Account Type"="account type"::Vendor then begin
                    GenJournalLine."Posting Date":="Transaction Date";
                    GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                    GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                    //GenJournalLine.Description:=FORMAT(ReceiptAllocations."Transaction Type")+'-'+Remarks;
                    //GenJournalLine.Description:='BT-'+Name+'-'+"Account No."+'-'+Remarks;
                    //GenJournalLine.Description:='BT'+'-'+Remarks+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No.";
                    
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No.":=ReceiptAllocations."Member No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    
                    if ("Mode of Payment"="mode of payment"::Mpesa) and (ReceiptAllocations."Transaction Type"=ReceiptAllocations."transaction type":: "M Pesa Charge ") then  begin
                    GenJournalLine.Amount:=-Amount;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No.":=GenSetup."FOSA MPESA COmm A/C";
                    GenJournalLine.Description:=Format(ReceiptAllocations."Transaction Type")+'-'+Remarks;
                    GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::Vendor;
                    GenJournalLine."Bal. Account No.":="Account No.";
                    
                    end;
                    end;
                    
                    if"Account Type"="account type"::Customer then begin
                    GenJournalLine."Posting Date":="Transaction Date";
                    GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Customer;
                    GenJournalLine."Account No." :=ReceiptAllocations."Member No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    if ("Mode of Payment"="mode of payment"::Mpesa) and (ReceiptAllocations."Transaction Type"=ReceiptAllocations."transaction type":: "M Pesa Charge ") then begin
                    GenJournalLine.Amount:=-Amount;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No.":=GenSetup."FOSA MPESA COmm A/C";
                    GenJournalLine.Description:=Format(ReceiptAllocations."Transaction Type")+'-'+Remarks;
                    end;
                    end;
                    end;
                    //GenJournalLine."Prepayment date":=ReceiptAllocations."Prepayment Date";
                    //IF ("Mode of Payment"="Mode of Payment"::Mpesa) AND (ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::"Administration Fee") THEN
                    //GenJournalLine.Amount:=-ReceiptAllocations.Amount
                    //ELSE
                    GenJournalLine.Amount:=-ReceiptAllocations.Amount;
                    GenJournalLine."Shortcut Dimension 1 Code":=ReceiptAllocations."Global Dimension 1 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine."Shortcut Dimension 2 Code":=ReceiptAllocations."Global Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //description
                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Interest Paid" then
                    GenJournalLine.Description:='Interest'+'-'+Format("Mode of Payment")+'-'+"Cheque No."
                    else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Insurance Paid" then
                    GenJournalLine.Description:='L-Insurance'+'-'+Format("Mode of Payment")+'-'+"Cheque No."
                    else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Benevolent Fund" then
                    GenJournalLine.Description:='Insurance'+'-'+Format("Mode of Payment")+'-'+"Cheque No."
                    else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
                    GenJournalLine.Description:='Registration'+'-'+Format("Mode of Payment")+'-'+"Cheque No."
                    else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Repayment then
                    GenJournalLine.Description:='Repayment'+'-'+Format("Mode of Payment")+'-'+"Cheque No."
                    else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Unallocated Funds" then
                    GenJournalLine.Description:='Unallocated'+'-'+Format("Mode of Payment")+'-'+"Cheque No."
                    else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Lukenya then
                    GenJournalLine.Description:='Lukenya'+'-'+Format("Mode of Payment")+'-'+"Cheque No."
                    else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Juja then
                    GenJournalLine.Description:='juja'+'-'+Format("Mode of Payment")+'-'+"Cheque No."
                    else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Konza then
                    GenJournalLine.Description:='Konza'+'-'+Remarks+'-'+Format("Mode of Payment")+'-'+"Cheque No."
                    else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Housing Title" then
                    GenJournalLine.Description:='Title'+'-'+Remarks+'-'+Format("Mode of Payment")+'-'+"Cheque No."
                    else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Housing Water" then
                    GenJournalLine.Description:='Water'+'-'+Remarks+'-'+Format("Mode of Payment")+'-'+"Cheque No."
                    else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Deposit Contribution" then
                    GenJournalLine.Description:='Deposit'+'-'+Format("Mode of Payment")+'-'+"Cheque No."
                    else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Shares Capital" then
                    GenJournalLine.Description:='Share'+'-'+Format("Mode of Payment")+'-'+"Cheque No."
                    else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Benevolent Fund" then
                    GenJournalLine.Description:='Benevolent'+'-'+Format("Mode of Payment")+'-'+"Cheque No."
                    else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Loan Due" then
                    GenJournalLine.Description:='School Fees Shares'+'-'+Format("Mode of Payment")+'-'+"Cheque No."
                    else  GenJournalLine.Description:='BT'+'-'+Format("Mode of Payment")+'-'+"Cheque No.";
                    Message('tuko hapa');
                    
                    //description
                    GenJournalLine."Transaction Type":=ReceiptAllocations."Transaction Type";
                    
                    //MESSAGE('%1',ReceiptAllocations."Transaction Type");
                    GenJournalLine."Loan No":=ReceiptAllocations."Loan No.";
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;
                      /*
                    IF (ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::Withdrawal) AND
                       (ReceiptAllocations."Interest Amount" > 0) THEN BEGIN
                    LineNo:=LineNo+10000;
                    
                    GenJournalLine.INIT;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":='FTRANS';
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Document No.":="Transaction No.";
                    GenJournalLine."External Document No.":="Cheque No.";
                    GenJournalLine."Posting Date":="Cheque Date";
                    GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                    GenJournalLine."Account No.":=ReceiptAllocations."Member No";
                    //GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                    GenJournalLine.Description:='Interest Paid'+'-'+Remarks;
                    GenJournalLine.Amount:=-ReceiptAllocations."Interest Amount";
                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Paid";
                    GenJournalLine."Loan No":=ReceiptAllocations."Loan No.";
                    IF GenJournalLine.Amount<>0 THEN
                    GenJournalLine.INSERT;
                    
                    END;
                     */
                    until ReceiptAllocations.Next = 0;
                    end;
                    
                    
                    end;
                    
                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
                    if GenJournalLine.Find('-') then begin
                    
                    
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco21",GenJournalLine);
                    end;
                    //Post New
                    
                    Posted:=true;
                    Modify;
                    BOSARcpt.Reset;
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.","Transaction No.");
                    if BOSARcpt.Find('-') then
                     if/* ("Mode of Payment"<>"Mode of Payment"::"Standing order") AND */
                        //("Mode of Payment"<>"Mode of Payment"::"Direct Debit") AND
                        ("Mode of Payment"<>"mode of payment"::Mpesa) then begin
                    
                    BOSARcpt.Reset;//
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.","Transaction No.");
                    if BOSARcpt.Find('-') then
                    //REPORT.RUN(51516247,FALSE,TRUE,BOSARcpt);
                    Report.Run(51516836,false,true,BOSARcpt);  //51516836
                    
                    end;
                    Commit;

                end;
            }
            action("Reprint Frecipt")
            {
                ApplicationArea = Basic;
                Caption = 'Reprint Receipt';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    TestField(Posted);

                    BOSARcpt.Reset;
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.","Transaction No.");
                    if BOSARcpt.Find('-') then
                    Report.Run(51516836,true,true,BOSARcpt)
                end;
            }
        }
    }

    var
        GenJournalLine: Record "Gen. Journal Line";
        InterestPaid: Decimal;
        PaymentAmount: Decimal;
        RunBal: Decimal;
        Recover: Boolean;
        Cheque: Boolean;
        ReceiptAllocations: Record "Receipt Allocation";
        Loans: Record "Loans Register";
        Commision: Decimal;
        LOustanding: Decimal;
        TotalCommision: Decimal;
        TotalOustanding: Decimal;
        Cust: Record Customer;
        BOSABank: Code[20];
        LineNo: Integer;
        BOSARcpt: Record "Receipts & Payments";
        TellerTill: Record "Bank Account";
        CurrentTellerAmount: Decimal;
        TransType: Text[30];
        RCPintdue: Decimal;
        Text001: label 'This member has reached a maximum share contribution of Kshs. 5,000/=. Do you want to post this transaction as shares contribution?';
        BosaSetUp: Record "Sacco General Set-Up";
        MpesaCharge: Decimal;
        CustPostingGrp: Record "Customer Posting Group";
        MpesaAc: Code[30];
        GenSetup: Record "Sacco General Set-Up";

    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update:=true;
    end;
}

