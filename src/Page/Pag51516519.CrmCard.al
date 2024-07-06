#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516519 "Crm Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group("General Information")
            {
                Caption = 'General Information';
                Editable = true;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("FOSA Account"; Rec."FOSA Account")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin

                        FosaName := '';

                        if Rec."FOSA Account" <> '' then begin
                            if Vend.Get(Rec."FOSA Account") then begin
                                FosaName := Vend.Name;
                            end;
                        end;
                    end;
                }
                field(FosaName; FosaName)
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Account Name';
                    Editable = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID Number';
                    Editable = true;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Code';
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Address';
                }
                field("Home Postal Code"; Rec."Home Postal Code")
                {
                    ApplicationArea = Basic;
                }
                field("Home Town"; Rec."Home Town")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = true;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer';
                    Editable = true;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        StatusPermissions.Reset;
                        StatusPermissions.SetRange(StatusPermissions."User Id", UserId);
                        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Overide Defaulters");
                        if StatusPermissions.Find('-') = false then
                            Error('You do not have permissions to change the account status.');
                    end;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field("Recruited By"; Rec."Recruited By")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Savings Details")
            {
                Caption = 'Savings Details';
                field("Current Shares"; Rec."Current Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits';
                }
                field("Shares Retained"; Rec."Shares Retained")
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Capital';
                }
                field("Insurance Fund"; Rec."Insurance Fund")
                {
                    ApplicationArea = Basic;
                    Caption = 'Benevolent Fund';
                }
                field("FOSA  Account Bal"; Rec."FOSA  Account Bal")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000013; "Loans Sub-Page List")
            {
                Caption = 'Loans Details';
                SubPageLink = "Client Code" = field("No.");
            }
            group("Loan Eligibility")
            {
                Caption = 'Loan Eligibility';
                field("Current Shares1"; Rec."Current Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Deposit';
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Member Deposit *3"; Rec."Member Deposit *3")
                {
                    ApplicationArea = Basic;
                }
                field("New loan Eligibility"; Rec."New loan Eligibility")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Withdrawal Details")
            {
                Caption = 'Withdrawal Details';
                Editable = true;
                field("Withdrawal Application Date"; Rec."Withdrawal Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Date"; Rec."Withdrawal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Fee"; Rec."Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Status - Withdrawal App."; Rec."Status - Withdrawal App.")
                {
                    ApplicationArea = Basic;
                }
                field("Active Loans Guarantor"; Rec."Active Loans Guarantor")
                {
                    ApplicationArea = Basic;
                }
                field("Loans Guaranteed"; Rec."Loans Guaranteed")
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
            group("&Member")
            {
                Caption = '&Member';
                action("Member Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Ledger Entries';
                    Image = CustomerLedger;
                    RunObject = Page "Data Sheet Main";
                    RunPageLink = "ID NO." = field("No.");
                    RunPageView = sorting("ID NO.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "No." = field("No.");
                }
                action("Bank Account")
                {
                    ApplicationArea = Basic;
                    Image = Card;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = field("No.");
                }
                action(Contacts)
                {
                    ApplicationArea = Basic;
                    Image = ContactPerson;

                    trigger OnAction()
                    begin
                        Rec.ShowContact;
                    end;
                }
            }
            group(ActionGroup1000000056)
            {
                action("Members Kin Details List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Members Kin Details List';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Members Kin Details List";
                    //RunPageLink = "Account No"=field("No.");
                }
                action("Members Spouse & Children ")
                {
                    ApplicationArea = Basic;
                    Caption = 'SPouse & Children';
                    Image = relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Members Spouse & Children List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories Details';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Statistics FactBox";
                    RunPageLink = "No." = field("No.");
                }
                action("Member card")
                {
                    ApplicationArea = Basic;
                    Image = Account;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.FindFirst then begin
                            Report.Run(Report::"members card", true, false, Cust);
                        end;
                    end;
                }
                action("Members Statistics")
                {
                    ApplicationArea = Basic;
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("No.");
                }
                action("Member is  a Guarantor")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member is  a Guarantor';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(51516225, true, false, Cust);
                    end;
                }
                action("Member is  Guaranteed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member is  Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(51516226, true, false, Cust);
                        //51516482
                    end;
                }
                group(Reports)
                {
                    Caption = 'Reports';
                }
                action("Detailed Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(51516360, true, false, Cust);
                    end;
                }
                action("Detailed Interest Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Interest Statement';
                    Image = "Report";
                    Promoted = true;

                    trigger OnAction()
                    begin
                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("Account Closure Slip")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Closure Slip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(51516474, true, false, Cust);
                    end;
                }
                action("FOSA Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."FOSA Account");
                        if Vend.Find('-') then
                            Report.Run(51516248, true, false, Vend);


                        /*
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(51516476,TRUE,FALSE,Cust);
                        */

                    end;
                }
            }
        }
    }

    var
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        PictureExists: Boolean;
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        Vend: Record Vendor;
        Cust: Record Customer;
        LineNo: Integer;
        UsersID: Record User;
        GeneralSetup: Record "Sacco General Set-Up";
        Loans: Record "Loans Register";
        AvailableShares: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        TotalRecovered: Decimal;
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
        LoansR: Record "Loans Register";
        DActivity: Code[20];
        DBranch: Code[20];
        Accounts: Record Vendor;
        FosaName: Text[50];
        [InDataSet]
        lblIDVisible: Boolean;
        [InDataSet]
        lblDOBVisible: Boolean;
        [InDataSet]
        lblRegNoVisible: Boolean;
        [InDataSet]
        lblRegDateVisible: Boolean;
        [InDataSet]
        lblGenderVisible: Boolean;
        [InDataSet]
        txtGenderVisible: Boolean;
        [InDataSet]
        lblMaritalVisible: Boolean;
        [InDataSet]
        txtMaritalVisible: Boolean;
        AccNo: Code[20];
        Vendor: Record Vendor;
        TotalAvailable: Decimal;
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        TotalDefaulterR: Decimal;
        value2: Decimal;
        Value1: Decimal;
        RoundingDiff: Decimal;
        Statuschange: Record "Status Change Permision";
}

