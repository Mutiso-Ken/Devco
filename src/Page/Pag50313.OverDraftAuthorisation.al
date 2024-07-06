#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50313 "Over Draft Authorisation"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Over Draft Authorisation";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = AccNo;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Editable = ReqAmount;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Editable = AppAmount;
                }
                field("Overdraft Interest %"; Rec."Overdraft Interest %")
                {
                    ApplicationArea = Basic;
                    Editable = ODInt;
                }
                field("Effective/Start Date"; Rec."Effective/Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = EstartDate;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                    Editable = Durationn;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = Remmarks;
                }
                field("Overdraft Fee"; Rec."Overdraft Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transacting Branch"; Rec."Transacting Branch")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field(Expired; Rec.Expired)
                {
                    ApplicationArea = Basic;
                }
                field(Liquidated; Rec.Liquidated)
                {
                    ApplicationArea = Basic;
                }
                field("Date Liquidated"; Rec."Date Liquidated")
                {
                    ApplicationArea = Basic;
                }
                field("Liquidated By"; Rec."Liquidated By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755033; Outlook)
            {
            }
            systempart(Control1102755034; Notes)
            {
            }
            systempart(Control1102755035; MyNotes)
            {
            }
            systempart(Control1102755036; Links)
            {
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
                        DocumentType := Documenttype::Overdraft;
                        ApprovalEntries.SetRecordFilters(Database::"Over Draft Authorisation", DocumentType, Rec."No.");
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
                    // ApprovalMgt: Codeunit "Export F/O Consolidation";
                    begin
                        if Rec.Status <> Rec.Status::Open then
                            Error(text001);

                        Rec.TestField("Account No.");
                        Rec.TestField("Effective/Start Date");
                        Rec.TestField(Duration);
                        Rec.TestField("Expiry Date");
                        Rec.TestField("Requested Amount");
                        Rec.TestField("Approved Amount");
                        Rec.TestField("Overdraft Interest %");

                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify;
                        Message('Application Approved Sucessfuly');
                        //End allocate batch number
                        // IF ApprovalMgt.SendOverdraftApprovalRequest(Rec) THEN;
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
                    //  ApprovalMgt: Codeunit "Export F/O Consolidation";
                    begin
                        if Rec.Status <> Rec.Status::Open then
                            Error(text001);


                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Rec.Posted = true then
                            Error('This Overdraft has already been issued');

                        if Rec.Status <> Rec.Status::Approved then
                            Error('You cannot post an application being processed.');

                        Rec.TestField("Account No.");
                        Rec.TestField("Effective/Start Date");
                        Rec.TestField(Duration);
                        Rec.TestField("Expiry Date");
                        Rec.TestField("Requested Amount");
                        Rec.TestField("Approved Amount");
                        Rec.TestField("Overdraft Interest %");


                        if Confirm('Are you sure you want to authorise this overdraft? This will charge overdraft issue fee.', false) = false then
                            exit;

                        //Overdraft Issue Fee
                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                        if AccountTypes.Find('-') then begin

                            /*
                            CalcAvailableBal;

                            IF AvailableBalance < "Overdraft Fee" THEN
                            ERROR('Available balance not sufficient to cover the overdraft issue charge.');
                            */

                            UsersID.Reset;
                            UsersID.SetRange(UsersID."User ID", UpperCase(UserId));
                            if UsersID.Find('-') then begin
                                DBranch := UsersID.Branch;
                                DActivity := 'FOSA';
                                //MESSAGE('%1,%2',Branch,Activity);
                            end;


                            if Rec."Overdraft Fee" > 0 then begin
                                AccountTypes.TestField("Over Draft Issue Charge %");

                                GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Overdraft Issue Charges';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Rec."Overdraft Fee";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Account No." := AccountTypes."Over Draft Issue Charge A/C";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := Rec."Account Name";
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -Rec."Overdraft Fee";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Post New
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then begin
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                                end;

                                //Post New

                            end;
                        end;
                        //Overdraft Fee

                        Rec.Posted := true;
                        Rec.Modify;

                        Message('Overdraft authorised and charges posted successfully.');

                    end;
                }
                action(Account)
                {
                    // ApplicationArea = Basic;
                    // Image = Planning;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    // RunObject = Page "Account Card";
                    // RunPageLink = "No." = field("Account No.");
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    var
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft;
        AvailableBalance: Decimal;
        MinAccBal: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BankName: Text[200];
        Banks: Record Banks;
        UsersID: Record "User Setup";
        AccP: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        Account: Record Vendor;
        i: Integer;
        DActivity: Code[20];
        DBranch: Code[20];
        ODCharge: Decimal;
        AccNo: Boolean;
        ReqAmount: Boolean;
        AppAmount: Boolean;
        ODInt: Boolean;
        EstartDate: Boolean;
        Durationn: Boolean;
        ODFee: Boolean;
        Remmarks: Boolean;
        text001: label 'This application must be open';


    procedure CalcAvailableBal()
    begin
        AvailableBalance := 0;
        MinAccBal := 0;

        if Account.Get(Rec."Account No.") then begin
            Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."ATM Transactions",
                               Account."Authorised Over Draft");

            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
            if AccountTypes.Find('-') then begin
                MinAccBal := AccountTypes."Minimum Balance";

                AvailableBalance := (Account.Balance + Account."Authorised Over Draft") - MinAccBal - Account."Uncleared Cheques" -
                                  Account."EFT Transactions" - Account."ATM Transactions";


            end;
        end;
    end;


    procedure UpdateControl()
    begin


        if Rec.Status = Rec.Status::Open then begin
            AccNo := true;
            ReqAmount := true;
            AppAmount := true;
            ODInt := true;
            EstartDate := true;
            Durationn := true;
            ODFee := true;
            Remmarks := true;
        end;


        if Rec.Status = Rec.Status::Pending then begin
            AccNo := false;
            ReqAmount := false;
            AppAmount := true;
            ODInt := true;
            EstartDate := true;
            Durationn := true;
            ODFee := true;
            Remmarks := true;
        end;


        if Rec.Status = Rec.Status::Rejected then begin
            AccNo := false;
            ReqAmount := false;
            AppAmount := false;
            ODInt := false;
            EstartDate := false;
            Durationn := false;
            ODFee := false;
            Remmarks := false;

        end;

        if Rec.Status = Rec.Status::Approved then begin
            AccNo := false;
            ReqAmount := false;
            AppAmount := false;
            ODInt := false;
            EstartDate := false;
            Durationn := false;
            ODFee := false;
            Remmarks := false;

        end;
    end;
}

