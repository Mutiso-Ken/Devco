#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516115 "HR Job Applications List"
{
    CardPageID = "HR Job Applications Card";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Applicant,Functions,Print';
    SourceTable = "HR Job Applications";
    SourceTableView = where("Qualification Status"=filter(" "));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                field("Application No";"Application No")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    StyleExpr = true;
                }
                field("Date Applied";"Date Applied")
                {
                    ApplicationArea = Basic;
                    StyleExpr = true;
                }
                field("Job Applied For";"Job Applied For")
                {
                    ApplicationArea = Basic;
                }
                field("First Name";"First Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Middle Name";"Middle Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Last Name";"Last Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Qualified;Qualified)
                {
                    ApplicationArea = Basic;
                }
                field("Interview Invitation Sent";"Interview Invitation Sent")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Qualification Status";"Qualification Status")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1;Links)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicant)
            {
                Caption = 'Applicant';
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category4;
                }
                action("&Upload to Employee Card")
                {
                    ApplicationArea = Basic;
                    Caption = '&Upload to Employee Card';
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if not Confirm(Text001,false) then exit;
                          if "Employee No" = '' then begin
                          //IF NOT CONFIRM('Are you sure you want to Upload Applications Information to the Employee Card',FALSE) THEN EXIT;
                          HRJobApplications.SetFilter(HRJobApplications."Application No","Application No");
                          Report.Run(55600,true,false,HRJobApplications);
                          end else begin
                          Message('This applicants information already exists in the employee card');
                          end;
                    end;
                }
                action("Send Interview Invitation")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Interview Invitation';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if not Confirm(Text002,false) then exit;

                        HRJobApplications.Reset;
                        HRJobApplications.SetFilter(HRJobApplications."Application No","Application No");
                        HRJobApplications.SetRange(HRJobApplications.Qualified,true);
                        //REPORT.RUN(53940,TRUE,FALSE,HRJobApplications);
                        if HRJobApplications.Find('-') then
                        begin
                         repeat


                          Message('Invitation Email sent to '+Format(HRJobApplications."Application No"));
                         until HRJobApplications.Next=0;
                        end;
                    end;
                }
                action("Q&ualification Overview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Q&ualification Overview';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;
                }
                action(Referees)
                {
                    ApplicationArea = Basic;
                    Caption = 'Referees';
                    Image = ContactReference;
                    Promoted = true;
                    PromotedCategory = Category5;
                }
                action(Hobbies)
                {
                    ApplicationArea = Basic;
                    Caption = 'Hobbies';
                    Image = Holiday;
                    Promoted = true;
                    PromotedCategory = Category5;
                }
                action(Attachments)
                {
                    ApplicationArea = Basic;
                    Caption = 'Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No","Application No");
                        if HRJobApplications.Find('-') then
                        Report.Run(53925,true,true,HRJobApplications);
                    end;
                }
                action("Generate Offer Letter")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generate Offer Letter';
                    Promoted = true;
                }
                action("Upload Attachments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Upload Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Category6;
                }
            }
            group(Print)
            {
                Caption = 'Print';
                action("&Print")
                {
                    ApplicationArea = Basic;
                    Caption = '&Print';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    begin
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No","Application No");
                        if HRJobApplications.Find('-') then
                        Report.Run(53925,true,true,HRJobApplications);
                    end;
                }
            }
        }
        area(reporting)
        {
            action("HR Job Applications")
            {
                ApplicationArea = Basic;
                Caption = 'Job Applications';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    HRJobApplications.Reset;
                    HRJobApplications.SetRange(HRJobApplications."Application No","Application No");
                    if HRJobApplications.Find('-') then
                    Report.Run(51516175,true,true,HRJobApplications);
                end;
            }
            action("Shortlisted Candidates")
            {
                ApplicationArea = Basic;
                Caption = 'Shortlisted Candidates';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
            }
        }
    }

    var
        HRJobApplications: Record "HR Job Applications";
        Text001: label 'Are you sure you want to Upload Applicants Details to the Employee Card?';
        Text002: label 'Are you sure you want to Send an Interview Application?';
}

