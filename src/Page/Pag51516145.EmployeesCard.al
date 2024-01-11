page 51516145 "Employees Card"
{
    Caption = 'Employee Card';
    PageType = Card;
    SourceTable = "HR Employee";
    //Editable = false;
    DeleteAllowed = false;
    InsertAllowed = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(Surname; Surname)
                {
                    ApplicationArea = Basic;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = Basic;
                }
                field("Full Name"; "Full Name")
                {
                    ApplicationArea = Basic;
                }
                field(Title; Title)
                {
                    ApplicationArea = Basic;
                }
                field(Initials; Initials)
                {
                    ApplicationArea = Basic;
                }
                field("ID Number"; "ID Number")
                {
                    ApplicationArea = Basic;
                }
                field("Pin Number"; "Pin Number")
                {
                    ApplicationArea = Basic;
                    Caption = 'KRA Pin No';
                    ShowMandatory = true;
                }
                field("NHIF No."; "NHIF No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("NSSF No."; "NSSF No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Location; Location)
                {
                    ApplicationArea = Basic;
                }
                field(Photo; Photo)
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Contract Type"; "Contract Type")
                {
                    ApplicationArea = Basic;
                }
                field(Position; Position)
                {
                    ApplicationArea = Basic;
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Activity Code';
                }
                field("Global Dim 2"; "Global Dim 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Branch Code';
                }
                field("System User Name"; "User ID")
                {
                    ApplicationArea = Basic;
                    Caption = 'USER ID';
                }
            }
            group("Contact Information")
            {
                field("Mobile Number"; "Mobile Number")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Number2"; "Mobile Number2")
                {
                    ApplicationArea = Basic;
                }
                field("Phone Number"; "Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field("Postal Code"; "Postal Code")
                {
                    ApplicationArea = Basic;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                }
                field(Address2; Address2)
                {
                    ApplicationArea = Basic;
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                }
                field("Work Phone Number"; "Work Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address"; "Email Address")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Important Dates")
            {
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Age; Age)
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Join"; "Date Of Join")
                {
                    ApplicationArea = Basic;
                }
                field("Admission Date"; "Admission Date")
                {
                    ApplicationArea = Basic;
                }
                field("Length of Service"; "Length of Service")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Bank Details")
            {
            }
        }

        area(factboxes)
        {
            part(HrEmployeePictureFactbox; HrEmployeePictureFactbox)
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = FIELD("No.");

            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                Image = Employee;
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Employee),
                                  "No." = FIELD("No.");
                    ToolTip = 'View or add comments for the record.';
                }
                action(Dimensions)
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5200),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action("&Picture")
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Employee Picture";
                    RunPageLink = "No." = FIELD("No.");
                    ToolTip = 'View or add a picture of the employee or, for example, the company''s logo.';
                }
                action(AlternativeAddresses)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Alternate Addresses';
                    Image = Addresses;
                    RunObject = Page "Alternative Address List";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of addresses that are registered for the employee.';
                }
                action("&Relatives")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Relatives';
                    Image = Relatives;
                    RunObject = Page "Employee Relatives";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of relatives that are registered for the employee.';
                }
                action("Mi&sc. Article Information")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of miscellaneous articles that are registered for the employee.';
                }
                action("&Confidential Information")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Confidential Information';
                    Image = Lock;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of any confidential information that is registered for the employee.';
                }
                action("Q&ualifications")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Q&ualifications';
                    Image = Certificate;
                    RunObject = Page "Employee Qualifications";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of qualifications that are registered for the employee.';
                }
                action("A&bsences")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'A&bsences';
                    Image = Absence;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'View absence information for the employee.';
                }
                separator(Action23)
                {
                }
                action("Absences by Ca&tegories")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Absences by Ca&tegories';
                    Image = AbsenceCategory;
                    RunObject = Page "Empl. Absences by Categories";
                    RunPageLink = "No." = FIELD("No."),
                                  "Employee No. Filter" = FIELD("No.");
                    ToolTip = 'View categorized absence information for the employee.';
                }
                action("Misc. Articles &Overview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Misc. Articles &Overview';
                    Image = FiledOverview;
                    RunObject = Page "Misc. Articles Overview";
                    ToolTip = 'View miscellaneous articles that are registered for the employee.';
                }
                action("Co&nfidential Info. Overview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&nfidential Info. Overview';
                    Image = ConfidentialOverview;
                    RunObject = Page "Confidential Info. Overview";
                    ToolTip = 'View confidential information that is registered for the employee.';
                }
                separator(Action61)
                {
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    RunObject = Page "Employee Ledger Entries";
                    RunPageLink = "Employee No." = FIELD("No.");
                    RunPageView = SORTING("Employee No.")
                                  ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                action(Attachments)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }
                action(PayEmployee)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Pay Employee';
                    Image = SuggestVendorPayments;
                    RunObject = Page "Employee Ledger Entries";
                    RunPageLink = "Employee No." = FIELD("No."),
                                  "Remaining Amount" = FILTER(< 0),
                                  "Applies-to ID" = FILTER('');
                    ToolTip = 'View employee ledger entries for the record with remaining amount that have not been paid yet.';
                }
                action(Contact)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Contact';
                    Image = ContactPerson;
                    ToolTip = 'View or edit detailed information about the contact person at the employee.';

                    trigger OnAction()
                    var
                        ContBusRel: Record "Contact Business Relation";
                        Contact: Record Contact;
                    begin
                        if ContBusRel.FindByRelation(ContBusRel."Link to Table"::Employee, "No.") then begin
                            Contact.Get(ContBusRel."Contact No.");
                            Page.Run(Page::"Contact Card", Contact);
                        end;
                    end;
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Sent Emails")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sent Emails';
                    Image = ShowList;
                    ToolTip = 'View a list of emails that you have sent to this employee.';

                    trigger OnAction()
                    var
                        Email: Codeunit Email;
                    begin
                        Email.OpenSentEmails(Database::Employee, Rec.SystemId);
                    end;
                }
            }
        }
        area(Processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(ApplyTemplate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Apply Template';
                    Ellipsis = true;
                    Image = ApplyTemplate;
                    ToolTip = 'Apply a template to update the entity with your standard settings for a certain type of entity.';

                    trigger OnAction()
                    var
                    begin

                    end;
                }

            }
            action(Email)
            {
                ApplicationArea = All;
                Caption = 'Send Email';
                Image = Email;
                ToolTip = 'Send an email to this employee.';

                trigger OnAction()
                var
                    TempEmailItem: Record "Email Item" temporary;
                    EmailScenario: Enum "Email Scenario";
                begin
                    TempEmailItem.AddSourceDocument(Database::Employee, Rec.SystemId);
                    if Rec."Email Address" <> '' then begin
                        TempEmailitem."Send to" := Rec."Email Address";
                    end

                    else begin
                        Error('Employee E-Mail Must be Provided');
                    end;
                    TempEmailItem.Send(false, EmailScenario::Default);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref(PayEmployee_Promoted; PayEmployee)
                {
                }
                actionref(Email_Promoted; Email)
                {
                }
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
            group(Category_Category4)
            {
                Caption = 'Employee', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(Dimensions_Promoted; Dimensions)
                {
                }
                actionref("Ledger E&ntries_Promoted"; "Ledger E&ntries")
                {
                }
                actionref("Co&mments_Promoted"; "Co&mments")
                {
                }
                actionref(Attachments_Promoted; Attachments)
                {
                }
            }
            group(Category_Category5)
            {
                Caption = 'Navigate', Comment = 'Generated from the PromotedActionCategories property index 4.';

                actionref("&Confidential Information_Promoted"; "&Confidential Information")
                {
                }
                actionref("A&bsences_Promoted"; "A&bsences")
                {
                }
                actionref(Contact_Promoted; Contact)
                {
                }
                actionref("&Picture_Promoted"; "&Picture")
                {
                }
                actionref("Q&ualifications_Promoted"; "Q&ualifications")
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Accessed and read the employee List page no-' + Format("No.") + ' Name-' + Format("Full Name"));
    end;

    trigger OnClosePage()
    var
        PayrollEmployees: Record "Payroll Employee";

    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Closed employee List page no-' + Format("No.") + ' Name-' + Format("Full Name"));
        //.....................................Add details to employee payroll table
        if confirm('Update Member Payroll Details ?', false) = false then begin
            exit;
        end else begin
            PayrollEmployees.Init();
            PayrollEmployees."No." := "No.";
            PayrollEmployees.Surname := Surname;
            PayrollEmployees.Firstname := "First Name";
            PayrollEmployees."Joining Date" := "Date Of Join";
            PayrollEmployees."Global Dimension 1" := "Global Dimension 1 Code";
            PayrollEmployees."Global Dimension 2" := "Global Dimension 2 Code";
            PayrollEmployees."Payment Mode" := "Payment Mode"::"Bank Transfer";
            PayrollEmployees.Status := Status::Active;
            PayrollEmployees."NSSF No" := "NSSF No.";
            PayrollEmployees."NHIF No" := "NHIF No.";
            PayrollEmployees."Pays NHIF" := true;
            PayrollEmployees."Pays NSSF" := true;
            PayrollEmployees."PIN No" := "PIN No.";
            PayrollEmployees."Pays PAYE" := true;
            PayrollEmployees."Posting Group" := 'PAYROLL';
            if CopyStr("No.", 1, 2) = 'C0' then begin
                PayrollEmployees.Gratuity := true;
                PayrollEmployees.Casual := true;
            end;
            PayrollEmployees."Full Name" := "Full Name";
            if PayrollEmployees.Insert(true) = false then begin
                PayrollEmployees.Modify();
            end;
            Message('Updated');
        end;
    end;

    var
        AuditLog: Codeunit "Audit Log Codeunit";

    trigger OnNewRecord(BelowxRec: Boolean)
    var

    begin

    end;

    trigger OnAfterGetCurrRecord()
    var
        Employee: Record Employee;
        EmployeeTemplMgt: Codeunit "Employee Templ. Mgt.";
    begin

    end;

    var

}

