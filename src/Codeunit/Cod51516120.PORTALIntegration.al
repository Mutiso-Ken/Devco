#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516120 "PORTALIntegration"
{

    trigger OnRun()
    begin
        //fnTotalDepositsGraph('055000005','2013');
        //fnCurrentShareGraph('10000','2013');
        //fnTotalRepaidGraph('055000005','2013');
        //MESSAGE( MiniStatement('1024'));
        //fnMemberStatement('SUG00011','006995Thox.pdf');
        //FnDepositsStatement('006995','dstatemnt.pdf');
        //FnLoanStatement('ACI015683','lsmnt.pdf');
        //MESSAGE(MiniStatement('006995'));
        //MESSAGE(FORMAT( FnLoanApplication('SUG00011','FRL',20000,2,6)));
        //fnFosaStatement('2483-05-1-1189','fosa1.pdf');
        //fnLoanRepaymentShedule('BLN0036','fstn11.pdf');
        //fndividentstatement('000547','divident.pdf')
        //fnLoanGuranteed('006995','loansguaranteed.pdf');
        //fnLoanRepaymentShedule('10000','victorLoanrepay.pdf');
        fnLoanGurantorsReport('022335','Guarantors.pdf');
        //fnAtmApplications('0101-001-00266')
        //fnChangePassword('10000','1122','1200');
        //FnUpdateMonthlyContrib('2439', 2000);
        //fnUpdatePassword('10001','8340224','1340');
        //fnAtmApplications('2483-05-1-1189');
        //FnStandingOrders('2439','2483-05-1-1189','1W','1Y','2483-05-06-1189',20170913D,240,1);
        //MESSAGE(FnLoanApplication('2439','TANK LOAN',12500,'DEVELOPMENT',6,3,25000,28000,38000,0,0,0,0,0));
        //fnFosaStatement('2747-006995-01', 'thox.pdf')
        //MESSAGE(FORMAT( Fnlogin('1024','')));
        //MESSAGE( MiniStatement('ACI015683'));
        //MESSAGE( fnAccountInfo('022335'));
        //MESSAGE(FORMAT(fnLoanDetails('d308')));
         //MESSAGE(FnmemberInfo('1024'));
        //MESSAGE(Fnloanssetup());
        //fnFeedback('1024', 'I have a big problem');
        //MESSAGE( FnloanCalc(100000, 10, 'D301'));
        //MESSAGE( FnNotifications());
        //MESSAGE(fnLoanDetails('ss'));
        //MESSAGE(fnLoansPurposes());
        //fnGuarantorsPortal('1024', '1023', 'BLN00148', 'Has requested you to quarantee laon');
        //FnApproveGurarantors(1, '1023','BLN00148', '',10000);
        //MESSAGE(FORMAT(Fnlogin('000007',' ')));
    end;

    var
        objMember: Record Customer;
        Vendor: Record Vendor;
        VendorLedgEntry: Record "Vendor Ledger Entry";
        FILESPATH: label 'E:\EMMANUEL PORTAL\CODFPUBLISHED\Downloads\';
        objLoanRegister: Record "Loans Register";
        objAtmapplication: Record "ATM Card Applications";
        objNextKin: Record "Membership Applications";
        GenSetup: Record "Sacco General Set-Up";
        FreeShares: Decimal;
        glamount: Decimal;
        freq: DateFormula;
        dur: DateFormula;
        phoneNumber: Code[20];
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        FAccNo: Text[250];
        sms: Text[250];
        ClientName: Code[20];
        Loansetup: Record "Loan Products Setup";
        LoansPurpose: Record "Loans Purpose";
        ObjLoansregister: Record "Loans Register";
        LPrincipal: Decimal;
        LInterest: Decimal;
        Amount: Decimal;
        LBalance: Decimal;
        LoansRec: Record "Loans Register";
        TotalMRepay: Decimal;
        InterestRate: Decimal;
        Date: Date;
        FormNo: Code[40];
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
        objStandingOrders: Record "Standing Orders";


    procedure fnUpdatePassword(MemberNo: Code[50];idNo: Code[10];NewPassword: Text[100];smsport: Text) emailAddress: Boolean
    begin
        sms:=smsport+NewPassword;

        objMember.Reset;
        objMember.SetRange(objMember."No.",MemberNo);
        objMember.SetRange(objMember."ID No.",idNo);
        if objMember.Find('-') then begin

           phoneNumber:= objMember."Phone No.";
           FAccNo := objMember."FOSA Account";
          objMember.PortalPassword:=NewPassword;

          objMember.Modify;
          FnSMSMessage(FAccNo,phoneNumber,sms);
          emailAddress:=true;
          end
          else begin
        objMember.Reset;
        objMember.SetRange(objMember."Old Account No.",MemberNo);
        objMember.SetRange(objMember."ID No.",idNo);
        if objMember.Find('-') then begin

            phoneNumber:= objMember."Phone No.";
           FAccNo := objMember."FOSA Account";
          objMember.PortalPassword:=NewPassword;
          objMember.Modify;
          FnSMSMessage(FAccNo,phoneNumber,sms);
          emailAddress:=true;
          end
        //   ELSE BEGIN
        //     objMember.RESET;
        // objMember.SETRANGE(objMember.staff,MemberNo);
        // objMember.SETRANGE(objMember."ID No.",idNo);
        // IF objMember.FIND('-') THEN BEGIN
        //
        //     phoneNumber:= objMember."Phone No.";
        //    FAccNo := objMember."FOSA Account No.";
        //  objMember.PortalPassword:=NewPassword;
        //   objMember.MODIFY;
        //   FnSMSMessage(FAccNo,phoneNumber,sms);
        //   emailAddress:=TRUE;
        //   END
        //   END
        end;
          exit(emailAddress);
    end;


    procedure MiniStatement(MemberNo: Text[100]) MiniStmt: Text
    var
        minimunCount: Integer;
        amount: Decimal;
    begin
          begin
          MiniStmt :='';
            objMember.Reset;
           objMember.SetRange("No."  ,MemberNo);

          if objMember .Find('-') then begin

             minimunCount:=1;
             //Vendor.CALCFIELDS(Vendor.Balance);
             VendorLedgEntry.SetCurrentkey(VendorLedgEntry."Entry No.");
             VendorLedgEntry.Ascending(false);
             VendorLedgEntry.SetRange(VendorLedgEntry."Bal. Account No.",MemberNo);
           //  VendorLedgEntry.SETRANGE(VendorLedgEntry.Reversed,FALSE);
            if VendorLedgEntry.FindSet then begin
                MiniStmt:='';
                repeat
                  amount:=VendorLedgEntry.Amount;
                  if amount<1 then   amount:= amount*-1;
                      MiniStmt :=MiniStmt + Format(VendorLedgEntry."Posting Date") +':::'+ CopyStr(Format(VendorLedgEntry."Transaction Type"),1,25) +':::' +
                      Format(amount)+'::::';
                      minimunCount:= minimunCount +1;
                      if minimunCount > 5 then begin
                      exit(MiniStmt);
                      end
                  until VendorLedgEntry.Next =0;
                  end;

          end;

          end;
          exit(MiniStmt);
    end;


    procedure fnMemberStatement(MemberNo: Code[50];path: Text[100])
    var
        Filename: Text[100];
    begin

        Filename := FILESPATH+path;
        Message(FILESPATH);
        if Exists(Filename) then

          Erase(Filename);
          objMember.Reset;
          objMember.SetRange(objMember."No.",MemberNo);

        if objMember.Find('-') then begin
          Report.SaveAsPdf(51516018,Filename,objMember);
        end;
    end;


    procedure fnFosaStatement("Account No": Code[50];path: Text[100])
    var
        Filename: Text[100];
    begin

        Filename := FILESPATH+path;
        if Exists(Filename) then

          Erase(Filename);
          Vendor.Reset;
          Vendor.SetRange(Vendor."No.","Account No");

        if Vendor.Find('-') then begin
          Report.SaveAsPdf(51516533,Filename,Vendor);
        end;
    end;


    procedure fndividentstatement(No: Code[50];Path: Text[100])
    var
        filename: Text;
        "Member No": Code[50];
    begin
        filename := FILESPATH+Path;
        if Exists(filename) then

          Erase(filename);
          objMember.Reset;
          objMember.SetRange(objMember."No.",No);

        if objMember.Find('-') then begin
          Report.SaveAsPdf(51516241,filename,objMember);

        end;
    end;


    procedure fnLoanGuranteed("Member No": Code[50];path: Text[100])
    var
        Filename: Text[100];
    begin
        Filename := FILESPATH+path;
        if Exists(Filename) then

          Erase(Filename);
          objMember.Reset;
          objMember.SetRange(objMember."No.","Member No");

        if objMember.Find('-') then begin
          Report.SaveAsPdf(51516503,Filename,objMember);
        Message(FILESPATH);

        end;
    end;


    procedure fnLoanRepaymentShedule("Loan No": Code[50];path: Text[100])
    var
        "Member No": Code[100];
        filename: Text[250];
    begin
        filename := FILESPATH+path;
        if Exists(filename) then

          Erase(filename);
          objLoanRegister.Reset;
          objLoanRegister.SetRange(objLoanRegister."Loan  No.","Loan No");

        if objLoanRegister.Find('-') then begin
          Report.SaveAsPdf(51516477,filename,objLoanRegister);
          Message(FILESPATH);
        end;
    end;


    procedure fnLoanGurantorsReport("Member No": Code[10];path: Text)
    var
        filename: Text[100];
    begin
        filename := FILESPATH+path;
        if Exists(filename) then

          Erase(filename);
          objMember.Reset;
          objMember.SetRange(objMember."No.","Member No");

        if objMember.Find('-') then begin
          Report.SaveAsPdf(51516504,filename,objMember);
          Message(FILESPATH);
          end;
    end;


    procedure fnAtmApplications(Account: Code[100])
    begin
        objAtmapplication.Init;
        objAtmapplication."Branch Code":=Account;
        //objAtmapplication."Card No":=TODAY;
        //objAtmapplication."Application Date":=objAtmapplication."Application Date"::"0";
        //objAtmapplication."Date Activated":=objAtmapplication."Date Activated"::"0";
        //objAtmapplication.VALIDATE(objAtmapplication."Branch Code");
        //objAtmapplication.INSERT;
    end;


    procedure fnAtmBlocking(Account: Code[100];ReasonForBlock: Text[250])
    begin
        objAtmapplication.Reset;
        objAtmapplication.SetRange(objAtmapplication."Branch Code",Account);
        if objAtmapplication.Find('-') then begin
        //objAtmapplication."Date Activated":=objAtmapplication."Date Activated"::"2";
        objAtmapplication."Reason for Account blocking":=ReasonForBlock;
        objAtmapplication.Modify;
        end;
    end;


    procedure fnChangePassword(memberNumber: Code[100];currentPass: Code[100];newPass: Code[100]) updated: Boolean
    begin
        sms:= 'You have successfully updated your password. Your new password is: '+newPass;
        updated:=false;
        objMember.Reset;
        objMember.SetRange(objMember."No.", memberNumber);
        objMember.SetRange(objMember.PortalPassword, currentPass);
        if objMember.Find('-') then
         objMember.PortalPassword :=newPass;
          phoneNumber:= objMember."Phone No.";
           FAccNo := objMember."FOSA Account";
        updated := objMember.Modify;
        Message('Successful pass change');
        FnSMSMessage(FAccNo,phoneNumber,sms);
        exit(updated);
    end;


    procedure fnTotalRepaidGraph(Mno: Code[10];year: Code[10]) total: Decimal
    begin
        objMember.Reset;
        objMember.SetRange("No.", Mno);
        if objMember.Find('-') then begin

        objMember.SetFilter("Date Filter",'0101'+year+'..1231'+year);
        //objMember.CALCFIELDS("Current Shares");
        total:=objMember."Total Repayments";
        Message ('current repaid is %1', total);
        end;
    end;


    procedure fnCurrentShareGraph(Mno: Code[10];year: Code[10]) total: Decimal
    begin
        objMember.Reset;
        objMember.SetRange("No.", Mno);
        if objMember.Find('-') then begin

        objMember.SetFilter("Date Filter",'0101'+year+'..1231'+year);
        objMember.CalcFields("Current Shares");
        total:=objMember."Current Shares";
        Message ('current shares is %1', total);
        end;
    end;


    procedure fnTotalDepositsGraph(Mno: Code[10];year: Code[10]) total: Decimal
    begin
        objMember.Reset;
        objMember.SetRange("No.", Mno);
        if objMember.Find('-') then begin

        objMember.SetFilter("Date Filter",'0101'+year+'..1231'+year);
        objMember.CalcFields("Shares Retained");
        total:=objMember."Shares Retained";
        Message ('current deposits is %1', total);
        end;
    end;


    procedure FnRegisterKin("Full Names": Text;Relationship: Text;"ID Number": Code[10];"Phone Contact": Code[10];Address: Text;Idnomemberapp: Code[10])
    begin
        begin
        //       objRegMember.RESET;
        //       objNextKin.RESET;
        //       objNextKin.INIT();
        //       objRegMember.SETRANGE("ID No.",Idnomemberapp);
        //       IF objRegMember.FIND('-') THEN BEGIN
        //         objNextKin."Account No":=objRegMember."No.";
        //       objNextKin.Name:="Full Names";
        //       objNextKin.Relationship:=Relationship;
        //       objNextKin."ID No.":="ID Number";
        //       objNextKin.Telephone:="Phone Contact";
        //       objNextKin.Address:=Address;
        //       objNextKin.INSERT(TRUE);
        //       END;
            end;
    end;


    procedure FnMemberApply("First Name": Code[30];"Mid Name": Code[30];"Last Name": Code[30];"PO Box": Text;Residence: Code[30];"Postal Code": Text;Town: Code[30];"Phone Number": Code[30];Email: Text;"ID Number": Code[30];"Branch Code": Code[30];"Branch Name": Code[30];"Account Number": Code[30];Gender: Option;"Marital Status": Option;"Account Category": Option;"Application Category": Option;"Customer Group": Code[30];"Employer Name": Code[30];"Date of Birth": Date) num: Text
    begin
        begin

        //       objRegMember.RESET;
        //       objRegMember.SETRANGE("ID No.","ID Number");
        //       IF objRegMember.FIND('-') THEN BEGIN
        //         MESSAGE('already registered');
        //       END
        //         ELSE  BEGIN
        //       objRegMember.INIT;
        //       objRegMember.Name:="First Name"+' '+"Mid Name"+' '+"Last Name";
        //       objRegMember.Address:="PO Box";
        //       objRegMember."Address 2":=Residence;
        //       objRegMember."Postal Code":="Postal Code";
        //       objRegMember.Town:=Town;
        //       objRegMember."Mobile Phone No":="Phone Number";
        //       objRegMember."E-Mail (Personal)":=Email;
        //       objRegMember."Date of Birth":= "Date of Birth";
        //       objRegMember."ID No.":="ID Number";
        //       objRegMember."Bank Code":="Branch Code";
        //       objRegMember."Bank Name":="Branch Name";
        //       objRegMember."Bank Account No":= "Account Number";
        //       objRegMember.Gender:=Gender;
        //       objRegMember."Created By":=USERID;
        //       objRegMember."Global Dimension 1 Code":='BOSA';
        //       objRegMember."Date of Registration":=TODAY;
        //       objRegMember.Status:=objRegMember.Status::Open;
        //       objRegMember."Application Category":="Application Category";
        //       objRegMember."Account Category":="Account Category";
        //       objRegMember."Marital Status":="Marital Status";
        //       objRegMember."Employer Name":="Employer Name";
        //       objRegMember."Customer Posting Group":="Customer Group";
        //       objRegMember.INSERT(TRUE);
        //       END;
        //
        //
        //       //FnRegisterKin('','','','','');
            end;
    end;

    local procedure FnFreeShares("Member No": Text) Shares: Text
    begin
        begin
              begin
              GenSetup.Get();
              FreeShares:=0;
              glamount:=0;

                objMember.Reset;
                objMember.SetRange(objMember."No.","Member No");
                if objMember.Find('-') then begin
                  objMember.CalcFields("Current Shares");
                  LoansGuaranteeDetails.Reset;
                  LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails."Member No",objMember."No.");
                  LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails.Substituted,false);
                    if LoansGuaranteeDetails.Find('-') then begin
                      repeat
                          glamount:=glamount+LoansGuaranteeDetails."Amont Guaranteed";
                          //MESSAGE('Member No %1 Account no %2',Members."No.",glamount);
                          until LoansGuaranteeDetails.Next =0;
                    end;
                   FreeShares:=(objMember."Current Shares"*GenSetup."Contactual Shares (%)")-glamount;
                    Shares:= Format(FreeShares,0,'<Precision,2:2><Integer><Decimals>');
                end;
                end;
            end;
    end;


    procedure FnStandingOrders(BosaAcNo: Code[30];SourceAcc: Code[50];frequency: Text;Duration: Text;DestAccNo: Code[30];StartDate: Date;Amount: Decimal;DestAccType: Option)
    begin
        objStandingOrders.Init();
        objStandingOrders."BOSA Account No.":=BosaAcNo;
        objStandingOrders."Source Account No.":=SourceAcc;
        objStandingOrders.Validate(objStandingOrders."Source Account No.");
        if Format(freq) ='' then
          Evaluate(freq, frequency);
        objStandingOrders.Frequency:= freq;
        if Format(dur) ='' then
          Evaluate(dur, Duration);
        objStandingOrders.Duration:=dur;
        objStandingOrders."Destination Account No." :=DestAccNo;
        objStandingOrders.Validate(objStandingOrders."Destination Account No.");
        objStandingOrders."Destination Account Type":= DestAccType;
        objStandingOrders.Amount:= Amount;
        objStandingOrders."Effective/Start Date" :=StartDate;
        objStandingOrders.Validate(objStandingOrders.Duration);
        objStandingOrders.Status:=objStandingOrders.Status::Open;
        objStandingOrders.Insert(true);
        objMember.Reset;
        objMember.SetRange(objMember."No.", BosaAcNo);
        if objMember.Find('-') then begin
          phoneNumber:=objMember."Phone No.";
          sms:='You have created a standing order of amount : ' +Format(Amount)+' from Account '+SourceAcc+' start date: '
                + Format(StartDate)+'. Thanks for using SURESTEP SACCO Portal.';
          FnSMSMessage(SourceAcc,phoneNumber,sms);
          //MESSAGE('All Cool');
          end
    end;


    procedure FnUpdateMonthlyContrib("Member No": Code[30];"Updated Fig": Decimal)
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", "Member No");

        if objMember.Find('-') then begin
         phoneNumber:= objMember."Phone No.";
          FAccNo := objMember."FOSA Account";
          objMember."Monthly Contribution":="Updated Fig";
          objMember.Modify;
          sms := 'You have adjusted your monthly contributions to: '+Format("Updated Fig")+' account number '+FAccNo+
                '. Thank you for using SURESTEP Sacco Portal';
          FnSMSMessage(FAccNo,phoneNumber,sms);

        //MESSAGE('Updated');
        end
    end;


    procedure FnSMSMessage(accfrom: Text[30];phone: Text[20];message: Text[250])
    begin

            SMSMessages.Reset;
            if SMSMessages.Find('+') then begin
            iEntryNo:=SMSMessages."Entry No";
            iEntryNo:=iEntryNo+1;
            end
            else begin
            iEntryNo:=1;
            end;
            SMSMessages.Init;
            SMSMessages."Entry No":=iEntryNo;
            //SMSMessages."Batch No":=documentNo;
            //SMSMessages."Document No":=documentNo;
            SMSMessages."Account No":=accfrom;
            SMSMessages."Date Entered":=Today;
            SMSMessages."Time Entered":=Time;
            SMSMessages.Source:='WEBPORTAL';
            SMSMessages."Entered By":=UserId;
            SMSMessages."Sent To Server":=SMSMessages."sent to server"::No;
            SMSMessages."SMS Message":=message;
            SMSMessages."Telephone No":=phone;
            if SMSMessages."Telephone No"<>'' then
            SMSMessages.Insert;
    end;


    procedure FnLoanApplication(Member: Code[30];LoanProductType: Code[10];AmountApplied: Decimal;"Loan type": Option;RepaymentFrequency: Integer) Result: Boolean
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", Member);
        if objMember.Find('-') then begin


          objLoanRegister.Init;
        //***********insert******************//
              objLoanRegister."Loan Product Type":=LoanProductType;
              objLoanRegister.Validate("Loan Product Type");
              objLoanRegister.Validate("Loan  No.");
             // objLoanRegister."Loan Type":="Loan type";
              objLoanRegister."Client Code":=Member;
              objLoanRegister.Validate("Client Code");
             // objLoanRegister.VALIDATE("Loan Type");
              objLoanRegister."Application Date":=Today;
              objLoanRegister.Validate("Application Date");
              objLoanRegister."Requested Amount":=AmountApplied;
            //  objLoanRegister.VALIDATE("Requested Amount");
             // objLoanRegister.VALIDATE("Batch No.");
               //objLoanRegister.Source:=objLoanRegister.Source::FOSA;
               objLoanRegister."Captured By":=UserId;
              // objLoanRegister."Phone Number":=FormNo;
              // objLoanRegister.VALIDATE("Phone Number");
               objLoanRegister.Insert(true);
               Message('here');
                Result:=true;
                phoneNumber:=objMember."Phone No.";
                ClientName := objMember."FOSA Account";
                sms:='We have received your '+LoanProductType+' loan application of  amount : ' +Format(AmountApplied)+
                '. We are processing your loan, you will hear from us soon. Thanks for using CODF  Portal.';
             //   FnSMSMessage(ClientName,phoneNumber,sms);
                //MESSAGE('All Cool');
              //MESSAGE('Am just cool');
        end;
    end;


    procedure FnDepositsStatement("Account No": Code[30];path: Text[100])
    var
        Filename: Text[100];
    begin
        Filename := FILESPATH+path;
        Message(FILESPATH);
        if Exists(Filename) then

          Erase(Filename);
          objMember.Reset;
          objMember.SetRange(objMember."No.","Account No");

        if objMember.Find('-') then begin
          Report.SaveAsPdf(51516354,Filename,objMember);
        end;
    end;


    procedure FnLoanStatement("Member No": Code[30];path: Text[100])
    var
        Filename: Text[100];
    begin
        Filename := FILESPATH+path;
        Message(FILESPATH);
        if Exists(Filename) then

          Erase(Filename);
          Vendor.Reset;
          Vendor.SetRange(Vendor."BOSA Account No","Member No");

        if Vendor.Find('-') then begin
          Report.SaveAsPdf(51516531,Filename,objMember);
        end;
    end;


    procedure Fnlogin(username: Code[20];password: Text) status: Boolean
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", username);
        objMember.SetRange(PortalPassword, password);

        if objMember.Find('-') then  begin
          status:=true;
          end
          else
          status:=false;
    end;


    procedure FnmemberInfo(MemberNo: Code[20]) info: Text
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
          info:=objMember."No."+'.'+':'+objMember.Name+'.'+':'+objMember."E-Mail"+'.'+':'+Format(objMember."ID No.")+'.'+':'+Format(objMember."Account Category")+'.'+':'
          +objMember."Phone No."+'.'+':';
          end;
    end;


    procedure fnAccountInfo(Memberno: Code[20]) info: Text
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", Memberno);

        if objMember.Find('-') then begin
         // objMember.CALCFIELDS("Share Capital B Class");
          objMember.CalcFields("Current Shares","Preferencial Building Shares", "School Fees Shares", "Shares Retained", "FOSA  Account Bal" , "Executive Deposits", "Housing Deposits");
         // objMember.CALCFIELDS("Current Shares");objMember.CALCFIELDS("Demand Savings");
        objMember.CalcFields("Shares Retained");
          info:=Format(objMember."Current Shares")+':'+Format(objMember."Shares Retained")+':'+Format(objMember."Un-allocated Funds")+':'+Format(objMember."Executive Deposits")+':'
          +Format(objMember."School Fees Shares")+':'+Format(objMember."FOSA  Account Bal")+':'+Format(objMember."Housing Deposits");
          end;
    end;


    procedure fnloaninfo(Memberno: Code[20]) info: Text
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", Memberno);
        if objMember.Find('-') then begin
          objMember.CalcFields("Outstanding Balance");
          objMember.CalcFields("Outstanding Interest");
           info:=Format(objMember.Balance)+':'+Format(objMember."Outstanding Interest");
          end;
    end;


    procedure fnLoans(MemberNo: Code[20]) loans: Text
    begin
        objLoanRegister.Reset;
        objLoanRegister.SetRange("Client Code", MemberNo);
        if objLoanRegister.Find('-') then begin
          objLoanRegister.SetCurrentkey("Loan  No.");
          objLoanRegister.Ascending(false);

          repeat
            objLoanRegister.CalcFields("Total Loans Outstanding");
            loans:=loans+objLoanRegister."Loan Product Type Name"+':'+ Format(objLoanRegister."Total Loans Outstanding")+':'+Format(objLoanRegister."Approval Status")+':'+Format(objLoanRegister."Instalment Period")+'::';
            until
            objLoanRegister.Next=0;

          end;
    end;


    procedure FnloanCalc(LoanAmount: Decimal;RepayPeriod: Integer;LoanCode: Code[30]) text: Text
    begin
         Loansetup.Reset;
         Loansetup.SetRange(Code, LoanCode);

         if Loansetup.Find('-') then begin

          if Loansetup."Repayment Method"= Loansetup."repayment method"::Amortised then begin
         // LoansRec.TESTFIELD(LoansRec.Interest);
         // LoansRec.TESTFIELD(LoansRec.Installments);
          TotalMRepay:=ROUND((Loansetup."Interest rate"/12/100) / (1 - Power((1 +(Loansetup."Interest rate"/12/100)),- (RepayPeriod))) * (LoanAmount),0.0001,'>');
          LInterest:=ROUND(LBalance / 100 / 12 * InterestRate,0.0001,'>');
          LPrincipal:=TotalMRepay-LInterest;
          end;

          if  Loansetup."Repayment Method"= Loansetup."repayment method"::"Straight Line" then begin
          LoansRec.TestField(LoansRec.Interest);
          LoansRec.TestField(LoansRec.Installments);
          LPrincipal:=LoanAmount/RepayPeriod;
          LInterest:=(Loansetup."Interest rate"/12/100)*LoanAmount/RepayPeriod;
          end;

          if  Loansetup."Repayment Method"= Loansetup."repayment method"::"Reducing Balance" then begin
          //LoansRec.TESTFIELD(LoansRec.Interest);
          //LoansRec.TESTFIELD(LoansRec.Installments);
          Message('type is %1',LoanCode);
           Date:=Today;

          TotalMRepay:=ROUND((Loansetup."Interest rate"/12/100) / (1 - Power((1 +(Loansetup."Interest rate"/12/100)),- (RepayPeriod))) * (LoanAmount),0.0001,'>');
           repeat
          LInterest:=ROUND(LoanAmount * Loansetup."Interest rate"/12/100,0.0001,'>');
          LPrincipal:=TotalMRepay-LInterest;
            LoanAmount:=LoanAmount-LPrincipal;
         RepayPeriod:= RepayPeriod-1;

          text:=text+Format(Date)+'!!'+Format(LPrincipal)+'!!'+Format(LInterest)+'!!'+Format(TotalMRepay)+'!!'+Format(LoanAmount)+'??';
          Date:=CalcDate('+1M', Date);

          until RepayPeriod=0;
          end;

          if  Loansetup."Repayment Method"= Loansetup."repayment method"::Constants then begin
         // LoansRec.TESTFIELD(LoansRec.Repayment);
        //  IF LBalance < LoansRec.Repayment THEN
        //  LPrincipal:=LBalance
        //  ELSE
        //  LPrincipal:=LoansRec.Repayment;
        //  LInterest:=LoansRec.Interest;
          end;



          //END;

        //EXIT(Amount);
        end
    end;


    procedure Fnloanssetup() loanType: Text
    begin
        Loansetup.Reset;
        begin
        loanType:='';
        repeat
        loanType:=Format(Loansetup.Code)+':'+Loansetup."Product Description"+':::'+loanType;
          until Loansetup.Next=0;
        end;
    end;


    procedure fnLoanDetails(Loancode: Code[20]) loandetail: Text
    begin
        Loansetup.Reset;
        //Loansetup.SETRANGE(Code, Loancode);
        if Loansetup.Find('-') then begin
          repeat
          loandetail:=loandetail+Loansetup."Product Description"+'!!'+ Format(Loansetup."Repayment Method")+'!!'+Format(Loansetup."Max. Loan Amount")+'!!'+Format(Loansetup."Instalment Period")+'!!'+Format(Loansetup."Interest rate")+'!!'
          +Format(Loansetup."Repayment Frequency")+'??';
          until Loansetup.Next=0;
        end;
    end;


    procedure fnFeedback(No: Code[20];Comment: Text[200])
    begin
        // objMember.RESET;
        // objMember.SETRANGE("No.", No);
        // IF objMember.FIND('-') THEN BEGIN
        //  IF feedback.FIND('+') THEN
        //  feedback.Entry:=feedback.Entry+1
        //  ELSE
        //  feedback.Entry:=1;
        //  feedback.No:=No;
        //  feedback.Portalfeedback:=Comment;
        //  feedback.DatePosted:=TODAY;
        //  feedback.INSERT(TRUE)
        //
        //
        // END
        // ELSE
        // EXIT;
    end;


    procedure fnLoansPurposes() LoanType: Text
    begin
        LoansPurpose.Reset;
        begin
        LoanType:='';
        repeat
        //LoanType:=FORMAT(LoansPurpose."Loan Type")+':'+LoansPurpose."Loan Type Description"+'.'+':::'+LoanType;
          until LoansPurpose.Next=0;
        end;
    end;


    procedure fnReplys(No: Code[20]) text: Text
    begin
        // feedback.RESET;
        // feedback.SETRANGE(No, No);
        // feedback.SETCURRENTKEY(Entry);
        // feedback.ASCENDING(FALSE);
        // IF feedback.FIND('-') THEN BEGIN
        //   REPEAT
        //      IF(feedback.Reply ='') THEN BEGIN
        //
        //  END ELSE
        //     text:=text+FORMAT(feedback.DatePosted)+'!!'+feedback.Portalfeedback+'!!'+ feedback.Reply+'??';
        // UNTIL feedback.NEXT=0;
        // END;
    end;


    procedure FnNotifications() text: Text
    begin
        // feedback.RESET;
        // feedback.SETCURRENTKEY(Entry);
        // feedback.ASCENDING(FALSE);
        // IF feedback.FIND('-') THEN BEGIN
        // REPEAT
        //  IF(feedback.PortalNotifications ='') THEN BEGIN
        //
        //  END ELSE
        //  text:=text+FORMAT(feedback.DatePosted)+'!!'+feedback.PortalNotifications+'??';
        //  UNTIL
        //  feedback.NEXT=0;
        //  END;
    end;


    procedure fnGuarantorsPortal(Member: Code[40];Number: Code[40];LoanNo: Code[40];Message: Text[100])
    begin
        // objMember.RESET;
        // objMember.SETRANGE("No.", Member);
        // IF objMember.FIND('-') THEN BEGIN
        //  IF feedback.FIND('+') THEN
        //  feedback.Entry:=feedback.Entry+1
        //  ELSE
        //  feedback.Entry:=1;
        //  feedback.No:=Member;
        // // feedback.Portalfeedback:=Message;
        //  feedback.DatePosted:=TODAY;
        // feedback.Guarantor:=Number;
        // objLoanRegister.RESET;
        // objLoanRegister.SETRANGE("Client Code", Member);
        // objLoanRegister.SETCURRENTKEY("Application Date");
        // // objLoanRegister.ASCENDING(FALSE);
        //
        // feedback.LoanNo:=objLoanRegister."Loan  No.";
        // feedback.Accepted:=0;
        // feedback.Rejected:=0;
        //  feedback.INSERT(TRUE)
        //
        //
        // END
        // ELSE
        // EXIT;
    end;


    procedure FnApproveGurarantors(Approval: Integer;Number: Code[40];LoanNo: Code[40];reply: Text;Amount: Decimal)
    begin
        // feedback.RESET;
        // feedback.SETRANGE(Guarantor, Number);
        // IF feedback.FIND ('-') THEN BEGIN
        //  IF (Approval=0) THEN
        //    EXIT
        //  ELSE IF Approval=1 THEN
        //  feedback.Accepted:=1;
        //  feedback.Rejected:=0;
        // objMember.SETRANGE("No.", Number);
        // IF objMember.FIND('-') THEN
        //
        //
        // reply:=objMember.Name+' '+'Has accepted to quarntee your loan';
        //
        // objLoanRegister.RESET;
        // objLoanRegister.SETRANGE("Loan  No.", LoanNo);
        // IF objLoanRegister.FIND('-') THEN
        // reply:=reply+ 'of amount '+ FORMAT(objLoanRegister."Requested Amount");
        // LoansGuaranteeDetails.INIT;
        // LoansGuaranteeDetails.CALCFIELDS("Loanees  No");
        //
        // LoansGuaranteeDetails."Member No":=Number;
        // LoansGuaranteeDetails.VALIDATE("Member No");
        // LoansGuaranteeDetails.VALIDATE("Substituted Guarantor");
        // LoansGuaranteeDetails."Loan No":=LoanNo;
        // LoansGuaranteeDetails.VALIDATE("Loan No");
        // LoansGuaranteeDetails."Amont Guaranteed":=Amount;
        // LoansGuaranteeDetails.VALIDATE("Amont Guaranteed");
        // //LoansGuaranteeDetails."Loanees  No":=feedback.No;
        //
        // //LoansGuaranteeDetails.VALIDATE("Loanees  No");
        // feedback.Reply:=reply;
        // feedback.MODIFY;
        // LoansGuaranteeDetails.INSERT;
        // END;
    end;
}

