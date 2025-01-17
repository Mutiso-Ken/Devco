#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516840 "MC Individual Application Card"
{
    Caption = 'C.E.E.P Individual Application Card';
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";
    SourceTableView = where("Customer Posting Group" = const('MICRO'));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field("BOSA Account No."; "BOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Membership No.';
                    ShowMandatory = true;
                    Visible = true;

                    trigger OnValidate()
                    begin

                        CustMember.Reset;
                        CustMember.SetRange(CustMember."No.", "BOSA Account No.");
                        if CustMember.Find('-') then begin
                            if CustMember."FOSA Account" = '' then
                                Error('The Member Does not have FOSA Account');
                        end;
                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Account Category';

                    trigger OnValidate()
                    begin

                        BosaAccNoVisible := true;
                        FosaAccNoVisible := true;
                        MemCatVisible := true;
                        PayrollVisible := true;
                        IDNoVisible := true;
                        PassVisible := true;
                        MaritalVisible := true;
                        GenderVisible := true;
                        DoBVisible := true;
                        BenvVisible := true;
                        WstationVisible := true;
                        DeptVisible := true;
                        SecVisible := true;
                        OccpVisible := true;
                    end;
                }
                field("Group Account"; "Group Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        TestField("Account Category", "account category"::Group);
                    end;
                }
                field("Customer Type"; "Customer Type")
                {
                    ApplicationArea = Basic;
                    OptionCaption = ' ,,,,,Micro';
                    Visible = false;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Visible = true;

                    trigger OnValidate()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."ID No.", "ID No.");
                        Cust.SetFilter(Cust."Account Category", '<>%1', Cust."account category"::Group);
                        Cust.SetFilter(Cust."Group Account", '%1', false);
                        Cust.SetRange(Cust."Customer Posting Group", 'MICRO');
                        if Cust.Find('-') then begin
                            Error(Text005, Cust."Group Account Name");
                        end;

                        CustMember.Reset;
                        CustMember.SetRange(CustMember."ID No.", "ID No.");
                        CustMember.SetRange(CustMember."Customer Type", CustMember."customer type"::Member);
                        if CustMember.Find('-') then
                            repeat
                                Validate("BOSA Account No.", CustMember."No.");
                            until CustMember.Next = 0;
                    end;
                }
                field("FOSA Account No."; "FOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Visible = true;
                }
                field("Payroll/Staff No"; "Payroll/Staff No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("Passport No."; "Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = PassEditable;
                    Visible = true;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                    Editable = AddressEditable;
                }
                field("Postal Code"; "Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = PostCodeEditable;
                    Importance = Promoted;
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                    Caption = 'City';
                    Editable = false;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Editable = CountryEditable;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("E-Mail (Personal)"; "E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Village/Residence"; "Village/Residence")
                {
                    ApplicationArea = Basic;
                    Editable = VillageResidence;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = RegistrationDateEdit;
                    Visible = false;
                }
                field("Home Town2"; "Home Town2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Physical Location';
                }
            }
            group("Group Information")
            {
                Caption = 'Group Information';
                field("Group Account No"; "Group Account No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    TableRelation = Customer where("Group Account" = const(true),
                                                              "Customer Posting Group" = const('MICRO'));
                
                }
                field("Group Account Name"; "Group Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    
                }
                field("Recruited By"; "Recruited By")
                {
                    ApplicationArea = Basic;
                }
                field("Salesperson Name"; "Salesperson Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'C.E.E.P Officer';
                    ShowMandatory = true;
                }
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                }
            }
            group("Other Information")
            {
                Caption = 'Other Information';
                field("Monthly Contribution"; "Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyContributionEdit;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = Basic;
                    Editable = BankAEditable;
                    Visible = false;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bank Account No"; "Bank Account No")
                {
                    ApplicationArea = Basic;
                    Editable = BankNEditable;
                    Visible = false;
                }
                field("Office Branch"; "Office Branch")
                {
                    ApplicationArea = Basic;
                    Caption = 'Work Station';
                    Editable = OfficeBranchEditable;
                    Visible = false;
                }
                field(Department; Department)
                {
                    ApplicationArea = Basic;
                    Editable = DeptEditable;
                    Visible = false;
                }
                field(Section; Section)
                {
                    ApplicationArea = Basic;
                    Editable = SectionEditable;
                    Visible = false;
                }
                field(Occupation; Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = OccupationEditable;
                    Visible = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = GlobalDim2Editable;
                }
                field("FOSA Account Type"; "FOSA Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
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
                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next of Kin';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                }
                group(Approvals)
                {
                    Caption = '-';
                }
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        /*DocumentType:=DocumentType::"Account Opening";
                        ApprovalEntries.Setfilters(DATABASE::"Member Application",DocumentType,"No.");
                        ApprovalEntries.RUN;
                        */

                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        Approvalmgt: Codeunit "Export F/O Consolidation";
                    begin
                        if Status = Status::Rejected then
                            Error(Text001);


                        //TESTFIELD("Business Loan Appl Type");

                        if "Customer Posting Group" <> 'MICRO' then begin
                            Error('Customer Posting Group Must be MICRO')
                        end;

                        if "Global Dimension 1 Code" <> 'MICRO' then begin
                            Error('Acivity Code Must be MICRO')
                        end;

                        if "ID No." <> '' then begin
                            Cust.Reset;
                            Cust.SetRange(Cust."ID No.", "ID No.");
                            Cust.SetRange(Cust."Customer Posting Group", 'Micro');
                            if Cust.Find('-') then begin
                                if Cust."No." <> "No." then
                                    Message('This Member has Already been Created');
                            end;
                        end;

                        if "Account Category" <> "account category"::Single then begin
                            AccountSignApp.Reset;
                            AccountSignApp.SetRange(AccountSignApp."Account No", "No.");
                            if AccountSignApp.Find('-') = false then
                                Error(text003);
                        end;

                        //TESTFIELD(Picture);
                        //TESTFIELD(Signature);
                        //TESTFIELD("E-Mail (Personal)");
                        TestField("Customer Posting Group");
                        TestField("Global Dimension 1 Code");
                        TestField("Global Dimension 2 Code");
                        TestField("Monthly Contribution");
                        TestField("Mobile Phone No");


                        if Status <> Status::Open then
                            Error(Text001);
                        if UserId = '' then begin
                            Status := Status::Approved;
                            Modify;
                        end else begin
                            SrestepApprovalsCodeUnit.SendMembershipApplicationsRequestForApproval(rec."No.", Rec);
                        end;
                        Message('Account has been automatically approved');
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Export F/O Consolidation";
                    begin
                        if Confirm('Cancel Approval?', false) = true then begin
                            SrestepApprovalsCodeUnit.CancelMembershipApplicationsRequestForApproval(rec."No.", Rec);

                        end;
                    end;
                }
                separator(Action7)
                {
                    Caption = '       -';
                }
                action("Create Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Account';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Status <> Status::Approved then
                            Error('This application has not been approved');

                        if Confirm('Are you sure you want to Create Account Application?', false) = true then begin

                            GenSetUp.Get;

                            if "ID No." <> '' then begin
                                Cust.Reset;
                                Cust.SetRange(Cust."ID No.", "ID No.");
                                Cust.SetRange(Cust."Customer Posting Group", 'MICRO');
                                if Cust.Find('-') then begin
                                    if Cust."No." <> "No." then
                                        //ERROR('This Member Account has Already been Created');
                                        Message('This Member Account has Already been Created');
                                end;
                            end;

                            //Create Micro Account
                            GenSetUp.TestField(GenSetUp."Business Loans A/c Format");
                            TestField("Global Dimension 2 Code");
                            TestField("BOSA Account No.");
                            //Cust."No.":="Global Dimension 2 Code"+''+"BOSA Account No."+''+GenSetUp."Business Loans A/c Format"+;
                            Cust."No." := GenSetUp."Business Loans A/c Format" + "Global Dimension 2 Code" + "BOSA Account No.";
                            Cust."BOSA Account No." := "BOSA Account No.";
                            Cust.Name := UpperCase(Name);
                            Cust.Address := Address;
                            Cust."Post Code" := "Postal Code";
                            Cust.City := City;
                            Cust.County := City;
                            Cust."Country/Region Code" := "Country/Region Code";
                            Cust."Phone No." := "Phone No.";
                            Cust."Global Dimension 1 Code" := "Global Dimension 1 Code";
                            Cust."Global Dimension 2 Code" := "Global Dimension 2 Code";
                            Cust."Customer Posting Group" := "Customer Posting Group";
                            Cust."Registration Date" := Today;//Registration date must be the day the application is converted to a member and not day of capture
                            Cust.Status := Cust.Status::"Non-Active";
                            Cust."Employer Code" := "Employer Code";
                            Cust."Date of Birth" := "Date of Birth";
                            Cust."Station/Department" := "Station/Department";
                            Cust."E-Mail" := "E-Mail (Personal)";
                            Cust.Location := Location;
                            Cust."Group Account Name" := "Group Account Name";


                            //**
                            Cust."Office Branch" := "Office Branch";
                            Cust.Department := Department;
                            Cust.Occupation := Occupation;
                            Cust.Designation := Designation;
                            Cust."Bank Code" := "Bank Code";
                            //Cust."Bank Branch Code":="Bank Name";
                            Cust."Bank Account No." := "Bank Account No";
                            //**
                            Cust."Sub-Location" := "Sub-Location";
                            Cust.District := District;
                            Cust."Payroll/Staff No" := "Payroll/Staff No";
                            Cust."ID No." := "ID No.";
                            Cust."Passport No." := "Passport No.";
                            //Cust."Business Loan Officer":="Salesperson Code";
                            Cust."Mobile Phone No" := "Mobile Phone No";
                            Cust."Marital Status" := "Marital Status";
                            Cust."Customer Type" := Cust."customer type"::MicroFinance;
                            Cust.Gender := Gender;

                            CalcFields(Signature, Picture);

                            Cust."Monthly Contribution" := "Monthly Contribution";
                            Cust."Account Category" := "Account Category";
                            Cust."Contact Person" := "Contact Person";
                            Cust."Contact Person Phone" := "Contact Person Phone";
                            Cust."ContactPerson Relation" := "ContactPerson Relation";
                            Cust."Recruited By" := "Recruited By";
                            Cust."Loan Officer Name" := "Salesperson Name";
                            Cust."ContactPerson Occupation" := "ContactPerson Occupation";
                            Cust."Village/Residence" := "Village/Residence";
                            Cust."Group Account" := "Group Account";
                            Cust."Group Account Name" := "Group Account Name";
                            Cust."FOSA Account" := "FOSA Account No.";
                            Cust."Home Town" := "Home Town2";
                            Cust.Insert(true);

                            //BOSAACC:=Cust."No.";
                            Cust.Reset;
                            if Cust.Get(BOSAACC) then begin
                                Cust.Validate(Cust.Name);
                                Cust.Validate(Cust."Global Dimension 1 Code");
                                Cust.Validate(Cust."Global Dimension 2 Code");
                                Cust.Modify;
                            end;


                            Message('Account created successfully.');
                            Message('Your Account No. is %1', Cust."No.");
                            Status := Status::Approved;
                            "Created By" := UserId;
                            rec.Modify(true);



                            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Send SMS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                            AccountSignatoriesApp.Reset;
                            AccountSignatoriesApp.SetRange(AccountSignatoriesApp."Account No", "No.");
                            if AccountSignatoriesApp.Find('-') then begin

                                AccountSignatoriesApp.Reset;
                                AccountSignatoriesApp.SetRange(AccountSignatoriesApp."Account No", "No.");
                                AccountSignatoriesApp.SetRange(AccountSignatoriesApp."Send SMS", false);
                                if AccountSignatoriesApp.Find('-') then begin
                                    repeat

                                        SMSMessage.Reset;
                                        if SMSMessage.Find('+') then begin
                                            iEntryNo := SMSMessage."Entry No";
                                            iEntryNo := iEntryNo + 1;
                                        end
                                        else begin
                                            iEntryNo := 1;
                                        end;


                                        SMSMessage.Init;
                                        SMSMessage."Entry No" := iEntryNo;
                                        SMSMessage."Account No" := "Payroll/Staff No";
                                        SMSMessage."Date Entered" := Today;
                                        SMSMessage."Time Entered" := Time;
                                        SMSMessage.Source := 'MEMBERACCOUNT';
                                        SMSMessage."Entered By" := UserId;
                                        SMSMessage."System Created Entry" := true;
                                        SMSMessage."Document No" := "No.";
                                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                                        SMSMessage."SMS Message" := Name + ' has been succesfuly created. MMH SACCCO';
                                        SMSMessage."Telephone No" := AccountSignatoriesApp."Mobile Phone No.";
                                        SMSMessage.Insert;

                                        AccountSignatoriesApp."Send SMS" := true;
                                        AccountSignatoriesApp.Modify;

                                    until AccountSignatoriesApp.Next = 0;
                                end;
                            end;

                            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                            // SEND SMS


                        end else
                            Error('Application Not approved');

                    end;




                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //"Responsibility Centre" := UserMgt.GetSalesFilter;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        "Customer Type" := "customer type"::MicroFinance;
        "Global Dimension 1 Code" := 'MICRO';
        "Customer Posting Group" := 'MICRO';
        //Source:=Source::Micro;
        "Account Type" := "account type"::Single;
        "Account Category" := "account category"::Single;
        "Group Account" := false;
    end;

    trigger OnOpenPage()
    VAR
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin

        if Status = Status::Approved then
            CurrPage.Editable := false;
    end;

    trigger OnInit()
    begin


    end;

    var
        StatusPermissions: Record "Status Change Permision";
        Cust: Record Customer;
        Accounts: Record Vendor;
        AcctNo: Code[20];
        NextOfKinApp: Record "Member App Next Of kin";
        NextofKinFOSA: Record "Accounts Next Of Kin Details";
        AccountSign: Record "Account Signatories Details";
        AccSignatories: Record "Account Signatories Details";
        AccountSignApp: Record "Account App Signatories";
        GetSeUp: Record "Sacco General Set-Up";
        Acc: Record Vendor;
        UsersID: Record User;
        Nok: Record "Member App Next Of kin";
        NOKBOSA: Record "Members Next Kin Details";
        BOSAACC: Code[20];
        NextOfKin: Record "Members Next Kin Details";
        PictureExists: Boolean;
        Saccosetup: Record "Sacco No. Series";
        text001: label 'Status must be open';
        UserMgt: Codeunit "User Setup Management";
        //Notification: Codeunit "SMTP Mail";
        NotificationE: Codeunit Mail;
        MailBody: Text[250];
        ccEmail: Text[1000];
        toEmail: Text[1000];
        GenSetUp: Record "Sacco General Set-Up";
        ClearingAcctNo: Code[20];
        AdvrAcctNo: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
        AccountTypes: Record "Account Types-Saving Products";
        DivAcctNo: Code[20];
        NameEditable: Boolean;
        AddressEditable: Boolean;
        GlobalDim1Editable: Boolean;
        GlobalDim2Editable: Boolean;
        CustPostingGroupEdit: Boolean;
        PhoneEditable: Boolean;
        MaritalstatusEditable: Boolean;
        IDNoEditable: Boolean;
        RegistrationDateEdit: Boolean;
        OfficeBranchEditable: Boolean;
        DeptEditable: Boolean;
        SectionEditable: Boolean;
        OccupationEditable: Boolean;
        DesignationEdiatble: Boolean;
        EmployerCodeEditable: Boolean;
        DOBEditable: Boolean;
        EmailEdiatble: Boolean;
        StaffNoEditable: Boolean;
        GenderEditable: Boolean;
        MonthlyContributionEdit: Boolean;
        PostCodeEditable: Boolean;
        CityEditable: Boolean;
        WitnessEditable: Boolean;
        StatusEditable: Boolean;
        BankCodeEditable: Boolean;
        BranchCodeEditable: Boolean;
        BankAccountNoEditable: Boolean;
        VillageResidence: Boolean;
        SignatureExists: Boolean;
        ForceNo: Boolean;
        ContPhone: Boolean;
        ContRelation: Boolean;
        ContOcuppation: Boolean;
        Recruitedby: Boolean;
        PassEditable: Boolean;
        EmployerEditable: Boolean;
        CountryEditable: Boolean;
        SalesEditable: Boolean;
        text002: label 'Kindly specify the next of kin';
        AccountCategory: Boolean;
        text003: label 'You must specify Signatories for this type of membership';
        GetAccountType: Record "Account Types-Saving Products";
        Text004: label 'You MUST specify the next of kin Benevolent';
        CustMember: Record Customer;
        "BenvNo.": Code[10];
        BankAEditable: Boolean;
        MemEditable: Boolean;
        BenvEditable: Boolean;
        BankNEditable: Boolean;
        InserFEditable: Boolean;
        FosAEditable: Boolean;
        Memb: Record "Membership Applications";
        BosaAccNoVisible: Boolean;
        FosaAccNoVisible: Boolean;
        MemCatVisible: Boolean;
        PayrollVisible: Boolean;
        IDNoVisible: Boolean;
        PassVisible: Boolean;
        MaritalVisible: Boolean;
        GenderVisible: Boolean;
        DoBVisible: Boolean;
        BenvVisible: Boolean;
        WstationVisible: Boolean;
        DeptVisible: Boolean;
        SecVisible: Boolean;
        OccpVisible: Boolean;
        MembCust: Record Customer;
        AccountSignatoriesApp: Record "Account App Signatories";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        AccoutTypes: Record "Account Types-Saving Products";
        Text005: label 'Member already belongs to group %1.';
        MembrCount: Integer;
        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;


    procedure UpdateControls()
    begin

        if Status = Status::Approved then begin
            NameEditable := false;
            AddressEditable := false;
            GlobalDim1Editable := false;
            GlobalDim2Editable := false;
            CustPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            OfficeBranchEditable := false;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            WitnessEditable := false;
            BankCodeEditable := false;
            BranchCodeEditable := false;
            BankAccountNoEditable := false;
            VillageResidence := false;
            ForceNo := false;
            ContPhone := false;
            ContRelation := false;
            ContOcuppation := false;
            Recruitedby := false;
            PassEditable := false;
            EmployerEditable := false;
            CountryEditable := false;
            SalesEditable := false;
            AccountCategory := false;
            BankAEditable := false;
            MemEditable := false;
            BenvEditable := false;
            BankNEditable := false;
        end;

        if Status = Status::Open then begin
            NameEditable := true;
            AddressEditable := true;
            GlobalDim1Editable := false;
            GlobalDim2Editable := true;
            CustPostingGroupEdit := false;
            PhoneEditable := true;
            MaritalstatusEditable := true;
            IDNoEditable := true;
            PhoneEditable := true;
            RegistrationDateEdit := true;
            OfficeBranchEditable := true;
            DeptEditable := true;
            SectionEditable := true;
            OccupationEditable := true;
            DesignationEdiatble := true;
            EmployerCodeEditable := true;
            DOBEditable := true;
            EmailEdiatble := true;
            StaffNoEditable := true;
            GenderEditable := true;
            MonthlyContributionEdit := true;
            PostCodeEditable := true;
            CityEditable := false;
            WitnessEditable := true;
            BankCodeEditable := true;
            BranchCodeEditable := true;
            BankAccountNoEditable := true;
            VillageResidence := true;
            ForceNo := true;
            ContPhone := true;
            ContRelation := true;
            ContOcuppation := true;
            Recruitedby := true;
            PassEditable := true;
            EmployerEditable := true;
            CountryEditable := true;
            SalesEditable := true;
            AccountCategory := true;
            BankAEditable := true;
            MemEditable := true;
            BenvEditable := true;
            BankNEditable := true;

        end
    end;
}

