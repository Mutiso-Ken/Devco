#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516854 "Over draft Application Card"
{
    //DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Over Draft Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Over Draft No"; Rec."Over Draft No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Application date"; Rec."Application date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Overdraft Repayment Start Date"; Rec."Overdraft Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Overdraft Repayment Completion"; Rec."Overdraft Repayment Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured by"; Rec."Captured by")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Current Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Draft Per OD"; Rec."Outstanding Draft Per OD")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Overdraft"; Rec."Outstanding Overdraft")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Outstanding Overdraft';
                    Editable = false;
                }
                field("Oustanding Overdraft Interest"; Rec."Oustanding Overdraft Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Net Overdraft"; Rec."Net Overdraft")
                {
                    ApplicationArea = Basic;
                    Caption = 'Requested Amount';
                }
                field("Amount applied"; Rec."Amount applied")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recommended Amount';
                    Editable = true;
                }
                field("Overdraft period(Months)"; Rec."Overdraft period(Months)")
                {
                    ApplicationArea = Basic;
                }
                field("Override Interest Rate"; Rec."Override Interest Rate")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        EditableField := false;
                        if Rec."Override Interest Rate" then
                            EditableField := true;
                    end;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                }
                field("Monthly Overdraft Repayment"; Rec."Monthly Overdraft Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Interest Repayment"; Rec."Monthly Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Interest Charged"; Rec."Total Interest Charged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Overdraft Status"; Rec."Overdraft Status")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Overdraft security"; Rec."Overdraft security")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Landvisible := false;
                        Motorvisible := false;
                        Salaryvisible := false;
                        if Rec."Overdraft security" = Rec."overdraft security"::"Motor Vehicle" then begin
                            Motorvisible := true;
                        end;
                        if Rec."Overdraft security" = Rec."overdraft security"::Land then begin
                            Landvisible := true;
                        end;
                        if Rec."Overdraft security" = Rec."overdraft security"::Salary then begin
                            Salaryvisible := true;
                        end;
                    end;
                }
                field("Do not Charge Commision"; Rec."Do not Charge Commision")
                {
                    ApplicationArea = Basic;
                }
                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Salary)
            {
                Caption = 'Salary';
                Visible = Salaryvisible;
                field("Basic salary"; Rec."Basic salary")
                {
                    ApplicationArea = Basic;
                }
                field(Employer; Rec.Employer)
                {
                    ApplicationArea = Basic;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field("Terms Of Employment"; Rec."Terms Of Employment")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Motor Vehicle")
            {
                Caption = 'Motor Vehicle';
                Visible = Motorvisible;
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Registration Number"; Rec."Registration Number")
                {
                    ApplicationArea = Basic;
                }
                field("Current Value"; Rec."Current Value")
                {
                    ApplicationArea = Basic;
                }
                field(Multpliers; Rec.Multpliers)
                {
                    ApplicationArea = Basic;
                }
                field("Amount to secure Overdraft"; Rec."Amount to secure Overdraft")
                {
                    ApplicationArea = Basic;
                }
                field(insured; Rec.insured)
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Company"; Rec."Insurance Company")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Land)
            {
                Caption = 'Land';
                Visible = Landvisible;
                field("Land deed No"; Rec."Land deed No")
                {
                    ApplicationArea = Basic;
                }
                field("Land acrage"; Rec."Land acrage")
                {
                    ApplicationArea = Basic;
                }
                field("Land location"; Rec."Land location")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Send Approval")
            {
                ApplicationArea = Basic;
                Image = SendApprovalRequest;
                Promoted = true;

                trigger OnAction()
                begin

                    if Rec.Posted = true then begin
                        Error(Rec."Over Draft No" + 'Already posted');
                    end else
                        Rec.TestField("Account No");
                    Rec.TestField("Current Account No");
                    Rec.TestField("Amount applied");
                    Rec.TestField("Recovery Mode");
                    //TESTFIELD("Interest Rate");
                    Rec.TestField("Overdraft period(Months)");
                    Rec.Status := Rec.Status::Approved;
                    Message('Approved succesfully');
                    Rec.Modify;
                    if Rec.Status = Rec.Status::Approved then
                        Rec."Approved Date" := Today;

                    /*
                    IF Status<>Status::Open THEN
                    ERROR(Text001);

                  {//End allocate batch number
                  Doc_Type:=Doc_Type::Interbank;
                  Table_id:=DATABASE::"Funds Transfer Header";
                  IF ApprovalMgt.SendApproval(Table_id,"No.",Doc_Type,Status)THEN;}

                  IF ApprovalMgt.CheckBOSATransWorkflowEnabled(Rec) THEN
                    ApprovalMgt.OnSendBOSATransForApproval(Rec);
                  */

                end;
            }
            action("Reject Request")
            {
                ApplicationArea = Basic;
                Image = Reject;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Open;
                    Message('Application rejected');
                    Rec.Modify;
                end;
            }
            action(Post)
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Approved;
                    rec.Modify(true);
                    Rec.TestField(Status, Rec.Status::Approved);
                    if Rec.Posted = true then begin
                        Error(Rec."Over Draft No" + 'Already posted');
                    end else
                        if Rec."Overdraft period(Months)" > 3 then begin
                            Error('Overdraft Months cannot be greater than 3 Months');
                        end else
                            /*
                          IF "Outstanding Overdraft">0 THEN BEGIN
                            ERROR('Overdraft Months cannot be greater than 3 Months');
                            END ELSE
                            */
                    Rec.TestField("Account No");
                    Rec.TestField("Approved Date");
                    Rec.TestField("Current Account No");
                    overdraftno := '';
                    Rec.TestField("Amount applied");
                    Rec.TestField("Overdraft Repayment Start Date");
                    //----------------------Get Ordinary account...................................................................................
                    if vend."Account Type" = 'ORDINARY' then
                        vend.Reset;
                    vend.SetRange(vend."No.", Rec."Account No");
                    if vend.Find('-') then begin
                        Rec."Approved Amount" := Rec."Amount applied";
                        vend."Overdraft amount" := Rec."Approved Amount";
                        //vend."Oustanding Overdraft interest":="Total Interest Charged";
                        vend.Modify;
                    end;
                    PostOverdraft();
                    Rec."Posted By" := UserId;
                    Rec.Posted := true;
                    Rec."Time Posted" := Time;
                    Rec."Overdraft Status" := Rec."overdraft status"::Active;
                    Rec."Running Overdraft" := true;
                    vend.Modify;
                    Rec.Modify;

                    OVED.Reset;
                    OVED.SetRange("Account No", Rec."Account No");
                    OVED.SetFilter("Over Draft No", '<>%1', Rec."Over Draft No");
                    if OVED.Find('-') then begin
                        repeat
                            OVED."Overdraft Status" := OVED."overdraft status"::Inactive;
                            OVED.Modify;
                        until OVED.Next = 0;
                    end

                end;
            }
            action(Print)
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    Cust.Reset;
                    Cust.SetRange(Cust."Account No", Rec."Account No");
                    Report.Run(51516281, true, false, Cust);
                end;
            }
        }
    }

    var
        Gnljnline: Record "Gen. Journal Line";
        LineN: Integer;
        vend: Record Vendor;
        overdraftno: Code[30];
        Cust: Record "Over Draft Register";
        LineNo: Integer;
        UserSetup: Record "User Setup";
        GenSetup: Record "Sacco General Set-Up";
        DValue: Record "Dimension Value";
        OverdraftBank: Code[10];
        GenJournalLine: Record "Gen. Journal Line";
        OverdraftAut: Record "Over Draft Authorisationx";
        LneNo: Integer;
        OVED: Record "Over Draft Register";
        Landvisible: Boolean;
        Salaryvisible: Boolean;
        Motorvisible: Boolean;
        SFactory: Codeunit "SURESTEP Factory";
        EditableField: Boolean;
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        CommisionOnOverdraft: Decimal;
        Period: Code[10];

    local procedure PostOverdraft()
    var
        OverdraftAcc: Record "Over Draft Register";
        OVERBAL: Decimal;
        RemainAmount: Decimal;
        Overdraftbank: Code[10];
        dbanch: Code[50];
        balanceov: Decimal;
        vendoroverdraft: Record Vendor;
        BALRUN: Decimal;
        OVERDRAFTREC: Record Vendor;
        "overdraftcomm a/c": Code[10];
        vendor2: Record Vendor;
        commoverdraft: Decimal;
        overdraftSetup: Record "Overdraft Setup";
        currentbal: Decimal;
    begin
        BATCH_TEMPLATE := 'PURCHASES';
        BATCH_NAME := 'FTRANS';
        DOCUMENT_NO := Rec."Over Draft No";
        currentbal := 0;
        overdraftSetup.Get();

        vendoroverdraft.Reset;
        vendoroverdraft.SetRange(vendoroverdraft."No.", Rec."Account No");
        if vendoroverdraft.Find('-') then begin
            vendoroverdraft.CalcFields(vendoroverdraft.Balance);
            currentbal := vendoroverdraft.Balance;
        end;





        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        CommisionOnOverdraft := overdraftSetup."Overdraft Commision Charged";

        LineNo := 0;


        //1.----------------------CREDIT FOSA A/C WITH OVERDRAFT AMOUNT---------------------------------------------------APPROVED AMOUNT-------------------------------------------------

        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineBalancedCashier(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"0", GenJournalLine."account type"::Vendor,
        Rec."Account No", Today, Rec."Approved Amount" * -1, 'FOSA', Rec."Over Draft No", Format(Rec."Overdraft period(Months)") + ' Month Overdraft Issued', '',
        GenJournalLine."account type"::"G/L Account", overdraftSetup."Control Account", Rec."Over Draft No", GenJournalLine."overdraft codes"::"Overdraft Granted");

        //2.----------------------CREDIT FOSA A/C WITH OVERDRAFT CHARGE-------------------------------------------APPROVED AMOUNT * INTEREST RATE-------------------------------------------------

        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineBalancedCashier(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"0", GenJournalLine."account type"::Vendor,
        Rec."Account No", Today, ((Rec."Approved Amount" * Rec."Interest Rate") * -1) / 100, 'FOSA', Rec."Over Draft No", 'Overdraft Interest', '',
        GenJournalLine."account type"::"G/L Account", overdraftSetup."Control Account", Rec."Over Draft No", GenJournalLine."overdraft codes"::"Overdraft Granted");

        //3.----------------------CREDIT FOSA A/C WITH FORM CHARGE---------------------------------------------------COMMISSION-------------------------------------------------
        if not Rec."Do not Charge Commision" then begin
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalancedCashier(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"0", GenJournalLine."account type"::Vendor,
            Rec."Account No", Today, CommisionOnOverdraft * -1, 'FOSA', Rec."Over Draft No", 'Overdraft Commision', '',
            GenJournalLine."account type"::"G/L Account", overdraftSetup."Control Account", Rec."Over Draft No", GenJournalLine."overdraft codes"::"Overdraft Granted");

            //4.----------------------DEBIT FOSA A/C(Recover Commission on Overdraft Form)--------------------------------------------------------------------------------------------


            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"0", GenJournalLine."account type"::Vendor,
            Rec."Account No", Today, CommisionOnOverdraft, 'FOSA', Rec."Account No", 'Commission on Overdraft', '',
            GenJournalLine."account type"::"G/L Account", overdraftSetup."Commission A/c");
            Rec."commission charged" := true;
        end;


        //5.----------------------CREDIT INCOME G/L(Interest on Overdraft)--------------------------------------------------------------------------------------------

        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"0", GenJournalLine."account type"::Vendor,
        Rec."Account No", Today, (Rec."Approved Amount" * Rec."Interest Rate") / 100, 'FOSA', Rec."Account No", 'Overdraft Int Charged', '',
        GenJournalLine."account type"::"G/L Account", overdraftSetup."Interest Income A/c");
        Rec."Interest Charged" := true;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;
        //END;
        Message('OverDraft Successfully Credited.');
    end;
}

