#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516268 "Membership Withdrawal List"
{
    ApplicationArea = Basic;
    CardPageID = "Membership Withdrawal Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption';
    SourceTable = "Membership Withdrawals";
    SourceTableView = where(Posted = filter(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; "Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Closing Date"; "Closing Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Total Loan"; "Total Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Total Interest"; "Total Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Member Deposits"; "Member Deposits")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::"Member Closure";
                        ApprovalEntries.SetRecordFilters(Database::"Payroll Employer Deductions", DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                    //ApprovalMgt: Codeunit "Export F/O Consolidation";
                    begin
                        if Status <> Status::Open then
                            Error(text001);

                        //End allocate batch number
                        //IF ApprovalMgt.SendClosurelRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel A&pproval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                    //ApprovalMgt: Codeunit "Export F/O Consolidation";
                    begin
                        //End allocate batch number
                        //ApprovalMgt.CancelClosureApprovalRequest(Rec)
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Cust.Get("Member No.") then begin
                            /*
                            IF Cust."Status - Withdrawal App." <> Cust."Status - Withdrawal App."::Approved THEN
                            ERROR('Withdrawal application must be approved before posting.');
                            */
                            if Confirm('Are you sure you want to recover the loans from the members shares?') = false then
                                exit;

                            Generalsetup.Get(0);

                            //delete journal line
                            Gnljnline.Reset;
                            Gnljnline.SetRange("Journal Template Name", 'GENERAL');
                            Gnljnline.SetRange("Journal Batch Name", 'ACC CLOSED');
                            Gnljnline.DeleteAll;
                            //end of deletion

                            Totalrecovered := 0;

                            Cust.CalcFields(Cust."Outstanding Balance", Cust."Accrued Interest", Cust."Current Shares");

                            Totalavailable := (Cust."Current Shares" + Generalsetup."Withdrawal Fee");

                            AvailableShares := Cust."Current Shares" * -1;

                            if Cust."Defaulted Loans Recovered" <> true then begin
                                if Cust."Closing Deposit Balance" = 0 then
                                    Cust."Closing Deposit Balance" := Cust."Current Shares" * -1;
                                if Cust."Closing Loan Balance" = 0 then
                                    Cust."Closing Loan Balance" := Cust."Outstanding Balance" + Cust."FOSA Outstanding Balance";
                                if Cust."Closing Insurance Balance" = 0 then
                                    Cust."Closing Insurance Balance" := Cust."Insurance Fund" * -1;
                            end;

                            Cust."Withdrawal Posted" := true;
                            Advice := true;
                            Cust."Last Advice Date" := Today;
                            Modify;

                            TotalOustanding := (Cust."Outstanding Balance" + Cust."Accrued Interest");

                            Loans.Reset;
                            Loans.SetRange(Loans."Client Code", "Member No.");
                            Loans.SetRange(Loans.Source, Loans.Source::BOSA);
                            if Loans.Find('-') then begin
                                repeat
                                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                                    //Recover Interest
                                    if Loans."Oustanding Interest" > 0 then begin
                                        //**Interest:=0;
                                        Interest := Loans."Oustanding Interest";
                                        LRepayment := Loans."Outstanding Balance";
                                        if (AvailableShares > 0) and (Interest > 0) then begin
                                            LineN := LineN + 10000;
                                            Gnljnline.Init;
                                            Gnljnline."Journal Template Name" := 'GENERAL';
                                            Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                                            Gnljnline."Line No." := LineN;
                                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                                            Gnljnline."Account No." := Cust."No.";
                                            Gnljnline.Validate(Gnljnline."Account No.");
                                            Gnljnline."Document No." := 'LR-' + "No.";
                                            Gnljnline."Posting Date" := Today;
                                            Gnljnline.Description := 'Interest Recovery from deposits';
                                            if AvailableShares < Interest then
                                                Gnljnline.Amount := -1 * AvailableShares
                                            else
                                                Gnljnline.Amount := -1 * Interest;
                                            Gnljnline.Validate(Gnljnline.Amount);
                                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                                            Gnljnline."Loan No" := Loans."Loan  No.";
                                            if Gnljnline.Amount <> 0 then
                                                Gnljnline.Insert;

                                            AvailableShares := AvailableShares - (Gnljnline.Amount * -1);
                                            Totalrecovered := Totalrecovered + (Gnljnline.Amount * -1);

                                            //Recover Repayment
                                            //**LRepayment:=0;
                                            LRepayment := Loans."Outstanding Balance";
                                            if (AvailableShares > 0) and (LRepayment > 0) then begin
                                                LineN := LineN + 10000;
                                                Gnljnline.Init;
                                                Gnljnline."Journal Template Name" := 'GENERAL';
                                                Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                                                Gnljnline."Line No." := LineN;
                                                Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                                                Gnljnline."Account No." := Cust."No.";
                                                Gnljnline.Validate(Gnljnline."Account No.");
                                                Gnljnline."Document No." := 'LR-' + "No.";
                                                Gnljnline."Posting Date" := Today;
                                                Gnljnline.Description := 'Interest Recovery from deposits';
                                                if AvailableShares < LRepayment then
                                                    Gnljnline.Amount := -1 * AvailableShares
                                                else
                                                    Gnljnline.Amount := -1 * LRepayment;
                                                Gnljnline.Validate(Gnljnline.Amount);
                                                Gnljnline."Transaction Type" := Gnljnline."transaction type"::Repayment;
                                                Gnljnline."Loan No" := Loans."Loan  No.";
                                                if Gnljnline.Amount <> 0 then
                                                    Gnljnline.Insert;

                                                AvailableShares := AvailableShares - (Gnljnline.Amount * -1);
                                                Totalrecovered := Totalrecovered + (Gnljnline.Amount * -1);

                                            end;
                                        end;
                                        Loans."Recovered Balance" := Loans."Outstanding Balance";
                                        Loans.Modify;
                                    end;
                                until Loans.Next = 0;
                            end;

                            //Withdrawal Fee
                            if Generalsetup."Withdrawal Fee" > 0 then begin
                                LineN := LineN + 10000;
                                Gnljnline.Init;
                                Gnljnline."Journal Template Name" := 'GENERAL';
                                Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                                Gnljnline."Line No." := LineN;
                                Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                                Gnljnline."Account No." := Cust."No.";
                                Gnljnline.Validate(Gnljnline."Account No.");
                                Gnljnline."Document No." := 'LR-' + "No.";
                                Gnljnline."Posting Date" := Today;
                                Gnljnline.Description := 'Withdrawal Fee';
                                Gnljnline.Amount := -Generalsetup."Withdrawal Fee";
                                Gnljnline.Validate(Gnljnline.Amount);
                                Gnljnline."Transaction Type" := Gnljnline."transaction type"::Withdrawal;
                                Gnljnline.Validate(Gnljnline."Bal. Account No.");
                                if Gnljnline.Amount <> 0 then
                                    Gnljnline.Insert;
                            end;

                            //Reduce Shares
                            LineN := LineN + 10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No." := Cust."No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := 'LR-' + "No.";
                            Gnljnline."Posting Date" := Today;
                            Gnljnline.Description := 'Deposit Refundable';
                            if Cust.Status = Cust.Status::Deceased then
                                Gnljnline.Amount := Totalrecovered + Generalsetup."Withdrawal Fee"
                            else
                                Gnljnline.Amount := Totalrecovered + Generalsetup."Withdrawal Fee"; //+"Insurance Fund"
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Deposit Contribution";
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;



                            //Post New
                            Gnljnline.Reset;
                            Gnljnline.SetRange("Journal Template Name", 'GENERAL');
                            Gnljnline.SetRange("Journal Batch Name", 'ACC CLOSED');
                            if Gnljnline.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", Gnljnline);
                            end;

                            //Block account if status deceased
                            if Cust.Status = Cust.Status::Deceased then begin
                                Cust.Blocked := Cust.Blocked::All;
                            end;

                            Cust.Status := Cust.Status::Withdrawal;
                            Cust.Modify;

                            Message('Closure posted successfully.');
                        end;

                    end;
                }
            }
        }
    }

    var
        Closure: Integer;
        Cust: Record Customer;
        UBFRefund: Decimal;
        Generalsetup: Record "Sacco General Set-Up";
        Totalavailable: Decimal;
        UnpaidDividends: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        value2: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Totalrecovered: Decimal;
        Advice: Boolean;
        TotalDefaulterR: Decimal;
        AvailableShares: Decimal;
        Loans: Record "Loans Register";
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        Vendno: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff;
}

