Page 51516110 "HR Leave Application Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Comments';
    SourceTable = "HR Leave Application";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application Code"; "Application Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                    Editable = false;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Leave Type"; "Leave Type")
                {
                    ApplicationArea = Basic;
                    Editable = "Leave TypeEditable";
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if "Leave Type" = 'STUDY' THEN begin
                            ExamDates := true;
                        end;
                        LeaveBalanceCaption := "Leave Type" + ' - ' + 'Leave Balance';

                        GetLeaveStats("Leave Type");
                        HREmp.Get("Employee No");
                        if "Leave Type" = 'ANNUAL' then begin
                            if "Days Applied" > dLeft then
                                Error('Days applied cannot exceed leave balance for this leave');
                        end else begin
                            HRLeaveTypes.Reset;
                            HRLeaveTypes.SetRange(HRLeaveTypes.Code, "Leave Type");
                            if HRLeaveTypes.Find('-') then begin
                                if "Days Applied" > HRLeaveTypes.Days then
                                    Error('Days applied cannot exceed leave balance for this leave');
                            end;
                        end;

                    end;
                }
                field("Leave Balance Per Category"; "Leave Balance Per Category")
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Type Balance';
                    Style = Strong;
                }
                field("Days Applied"; "Days Applied")
                {
                    ApplicationArea = Basic;
                    Editable = "Days AppliedEditable";
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        HREmp.Get("Employee No");
                        if "Leave Type" = 'ANNUAL' then begin
                            if "Days Applied" > dLeft then
                                Error('Days applied cannot exceed leave balance for this leave');
                        end else begin
                            HRLeaveTypes.Reset;
                            HRLeaveTypes.SetRange(HRLeaveTypes.Code, "Leave Type");
                            if HRLeaveTypes.Find('-') then begin
                                if "Days Applied" > HRLeaveTypes.Days then
                                    Error('Days applied cannot exceed leave balance for this leave');
                            end;

                        end;
                    end;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = "Start DateEditable";
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("Return Date"; "Return Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Ambiguous;
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee No.';
                    Editable = false;
                    Enabled = false;
                    Style = Strong;
                    Importance = Promoted;
                }
                field(EmpName; EmpName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Applicant Name';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    Style = Strong;
                }
                field("Job Tittle"; "Job Tittle")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    Style = Strong;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                }
                field(EmpDept; EmpDept)
                {
                    ApplicationArea = Basic;
                    Caption = 'Department';
                    Editable = false;
                    Visible = false;
                }
                field(Supervisor; Supervisor)
                {
                    ApplicationArea = Basic;
                    Editable = SupervisorEditable;

                    trigger OnValidate()
                    var
                        usersetup: Record "User Setup";
                    begin
                        //GET THE APPROVER NAMES
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."User ID", Supervisor);
                        if HREmp.Find('-') then begin
                            SupervisorName := HREmp."Full Name";
                        end else begin
                            SupervisorName := '';
                        end;
                        usersetup.Reset;
                        usersetup.SetRange(usersetup."User ID", Supervisor);
                        if usersetup.Find('-') then begin
                            "Supervisor Email" := usersetup."E-Mail";
                        end else begin
                            "Supervisor Email" := '';
                        end;

                    end;
                }
                field(SupervisorName; SupervisorName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisor Name';
                    Editable = false;
                }
                field("Supervisor Email"; "Supervisor Email")
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisor Email';
                    Editable = false;
                }
                field("Approved days"; "Approved days")
                {
                    ApplicationArea = Basic;
                    Editable = "Days AppliedEditable";
                }
                field(dEarnd; dEarnd)
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Leave Days';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(dTaken; dTaken)
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Leave Taken';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(dLeft; dLeft)
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Balance';
                    Editable = false;
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = true;
                }
                field(Reliever; Reliever)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reliever Code';
                    Editable = RelieverEditable;
                    ShowMandatory = true;
                }
                field("Reliever Name"; "Reliever Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
            group("More Leave Details")
            {
                Caption = 'More Leave Details';
                field("Cell Phone Number"; "Cell Phone Number")
                {
                    ApplicationArea = Basic;
                    Editable = "Cell Phone NumberEditable";
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("E-mail Address"; "E-mail Address")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("Details of Examination"; "Details of Examination")
                {
                    ApplicationArea = Basic;
                    Editable = "Details of ExaminationEditable";
                    Importance = Promoted;
                    Visible = false;
                }
                field("Date of Exam"; "Date of Exam")
                {
                    ApplicationArea = Basic;
                    Editable = "Date of ExamEditable";
                    Importance = Promoted;
                    Visible = false;
                }
                field("Number of Previous Attempts"; "Number of Previous Attempts")
                {
                    ApplicationArea = Basic;
                    Editable = NumberofPreviousAttemptsEditab;
                    Importance = Promoted;
                    Visible = false;
                }
            }
            group("Exam Dates")
            {
                Caption = 'Exam Dates';
                Visible = ExamDates;
                field("Date Of Exam 1"; "Date Of Exam 1")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 2"; "Date Of Exam 2")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 3"; "Date Of Exam 3")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 4"; "Date Of Exam 4")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 5"; "Date Of Exam 5")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 6"; "Date Of Exam 6")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 7"; "Date Of Exam 7")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000003; "HR Leave Applicaitons Factbox")
            {
                SubPageLink = "No." = field("Employee No");
                Caption = 'Employee Leave Details';
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = SendApproval;

                    trigger OnAction()
                    var
                        LeavePeriod: Text;
                        VarEmailSubject: Text;
                        VarEmailBody: Text;
                        SFactory: Codeunit "SURESTEP Factory";
                        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
                    begin
                        TestField("Leave Type");
                        TestField("Days Applied");
                        TestField("Start Date");
                        HREmp.Get("Employee No");
                        if HREmp.Position <> 'CEO' then begin
                            TestField(Supervisor);
                        end;
                        TESTFIELD(Reliever);
                        TestField("Cell Phone Number");
                        //TestField("E-mail Address");
                        //.........................................
                        if Confirm('Are you sure you want to send the approval request', false) = false then begin
                            exit;
                        end else begin
                            SrestepApprovalsCodeUnit.SendLeaveApplicationsRequestForApproval(rec."Application Code", Rec);
                            //....................................................................
                            HREmp.Get("Employee No");
                            //HREmp.TestField(HREmp."Email Address");
                            HRLeaveTypes.Get("Leave Type");

                            Users.Reset;
                            Users.SetRange("User Name", Supervisor);
                            if Users.FindSet then begin
                                if HRLeaveApp."Days Applied" > 1 then
                                    LeaveDaysText := Format("Days Applied") + ' days '
                                else
                                    LeaveDaysText := Format("Days Applied") + ' day ';

                                if "Days Applied" > 1 then
                                    LeavePeriod := 'from ' + Format("Start Date", 0, '<Day,2> <Month Text,3> <Year4>') + ' to ' +
                                                  Format(HRLeaveApp."End Date", 0, '<Day,2> <Month Text,3> <Year4>')
                                else
                                    LeavePeriod := 'for ' + Format("Start Date", 0, '<Day,2> <Month Text,3> <Year4>');

                                if Reliever <> '' then begin
                                    HREmp2.Get(Reliever);
                                    ReleivedBy := ' relieved by ' + "Reliever Name";
                                    ReleiverEmail := HREmp2."Email Address";
                                    if ReleiverEmail = '' then begin
                                        ReleiverEmail := HREmp2."E-Mail";
                                    end;
                                    if ReleiverEmail <> '' then begin
                                        VarEmailSubject := "Leave Type" + ' LEAVE APPLICATION - ' + "Employee Name";
                                        VarEmailBody := "Employee Name" + ' has applied for ' + LeaveDaysText + "Leave Type" + ' Leave ' + LeavePeriod + ReleivedBy +
                                        ' to resume on ' + Format("Return Date", 0, '<Day,2> <Month Text,3> <Year4>') +
                                        ' and has attached you as reliever.If you dont agree to this,contact the Human Resource Department';
                                        //.............................
                                        MailToSend.Create(ReleiverEmail, VarEmailSubject, VarEmailBody);
                                        FnEmail.Send(MailToSend, Enum::"Email Scenario"::Default);
                                    end;

                                    //...................................
                                end;


                            end;
                        end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = CancelApproval;
                    trigger OnAction()
                    var
                        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;

                    begin
                        if Confirm('Are you sure you want to cancel the approval request', false) = true then begin

                            SrestepApprovalsCodeUnit.CancelLeaveApplicationsRequestForApproval(rec."Application Code", Rec);
                        end;
                    end;
                }
                action("&Post Leave Application")
                {
                    ApplicationArea = Basic;
                    Caption = '&Post Leave Application';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Enabled = IsApproved and CanPost;

                    trigger OnAction()
                    var
                        VarEmailBody: Text;
                        VarEmailSubject: Text;
                        SFactory: Codeunit "SURESTEP Factory";
                        ObjApprovals: Record "Approval Entry";
                        Approver: Text;
                        EmailCC: Text;
                        LeavePeriod: Text;
                        MemberReg: Record Customer;
                        LoansRegister: Record "Loans Register";
                        FileName: Text[200];
                        FileName2: Text[200];
                        FileType: Text[100];
                        SendEmailTo: Text[100];
                        EmailBody: Text[1000];
                        EmailSubject: Text[100];
                        membersreg: Record Customer;
                        Outstr: OutStream;
                        Instr: InStream;
                        Outstr2: OutStream;
                        Instr2: InStream;
                        TempBlob: Codeunit "Temp Blob";

                        MailToSend: Codeunit "Email Message";
                        GenerateDoc: InStream;//Generate PDF/Document to be sent 
                        EncodeStream: Codeunit "Base64 Convert";//To encode the stream of data form GenerateDoc
                        FnEmail: Codeunit Email;
                        DialogBox: Dialog;
                    begin
                        if Status <> Status::Approved then
                            Error('The Leave Status must be Approved')
                        else begin
                            if Confirm('Post Leave Application for staff ?', false) = false then begin
                                exit;
                            end else begin
                                HRLeaveApp.Reset;
                                HRLeaveApp.SetRange(HRLeaveApp."Application Code", "Application Code");
                                if HRLeaveApp.Find('-') then begin
                                    HRLeaveApp.CreateLeaveLedgerEntries;
                                    HREmp.Get("Employee No");
                                    //HREmp.TestField(HREmp."Email Address");
                                    ObjApprovals.Reset;
                                    ObjApprovals.SetRange(ObjApprovals."Document No.", HRLeaveApp."Application Code");
                                    if ObjApprovals.FindSet then begin
                                        Approver := ObjApprovals."Last Modified By User ID";
                                    end;
                                    HRLeaveTypes.Get(HRLeaveApp."Leave Type");
                                    if HRLeaveApp."Approved days" > 1 then
                                        LeaveDaysText := Format(HRLeaveApp."Approved days") + ' days '
                                    else
                                        LeaveDaysText := Format(HRLeaveApp."Approved days") + ' day ';

                                    if Reliever <> '' then begin
                                        HREmp2.Get(Reliever);
                                        ReleivedBy := ' relieved by ' + "Reliever Name";
                                        ReleiverEmail := HREmp2."Email Address";
                                        if ReleiverEmail = '' then begin
                                            ReleiverEmail := HREmp2."E-Mail";
                                        end;
                                    end;
                                    EmailCC := HREmp."Email Address";
                                    if ReleiverEmail <> '' then
                                        EmailCC := EmailCC + ';' + ReleiverEmail;
                                    if HRLeaveApp."Approved days" > 1 then
                                        LeavePeriod := 'from ' + Format(HRLeaveApp."Start Date", 0, '<Day,2> <Month Text,3> <Year4>') + ' to ' +
                                                      Format(HRLeaveApp."End Date", 0, '<Day,2> <Month Text,3> <Year4>')
                                    else
                                        LeavePeriod := 'for ' + Format(HRLeaveApp."Start Date", 0, '<Day,2> <Month Text,3> <Year4>');


                                    VarEmailSubject := HRLeaveApp."Leave Type" + ' LEAVE APPLICATION APPROVED - ' + HRLeaveApp."Employee No";
                                    VarEmailBody := 'Your ' + LeaveDaysText + HRLeaveApp."Leave Type" + ' Leave Application ' + LeavePeriod + ReleivedBy + ' has been Approved by ' + Approver +
                                    '. You are expected to resume on ' + Format(HRLeaveApp."Return Date", 0, '<Day,2> <Month Text,3> <Year4>') + '. ';
                                    //............................send email
                                    MailToSend.Create(HREmp."Email Address", VarEmailSubject, VarEmailBody);
                                    FnEmail.Send(MailToSend, Enum::"Email Scenario"::Default);
                                    Message('Leave applicant and reliever have been notified successfully');
                                end;

                            end;
                        end;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EmpDept := '';
        //PASS VALUES TO VARIABLES ON THE FORM
        FillVariables;
        //GET LEAVE STATS FOR THIS EMPLOYEE FROM THE EMPLOYEE TABLE
        GetLeaveStats("Leave Type");
        //TO PREVENT USER FROM SEEING OTHER PEOPLES LEAVE APPLICATIONS
        SetFilter("User ID", UserId);

        Updatecontrols;

        LeaveBalanceCaption := "Leave Type" + ' - ' + 'Leave Balance';
        if "Leave Type" = 'STUDY' THEN begin
            ExamDates := true;
        end;
    end;

    trigger OnInit()
    begin
        NumberofPreviousAttemptsEditab := true;
        "Date of ExamEditable" := true;
        "Details of ExaminationEditable" := true;
        "Cell Phone NumberEditable" := true;
        SupervisorEditable := true;
        RequestLeaveAllowanceEditable := true;
        RelieverEditable := true;
        "Leave Allowance AmountEditable" := true;
        "Start DateEditable" := true;
        "Responsibility CenterEditable" := true;
        "Days AppliedEditable" := true;
        "Leave TypeEditable" := true;
        "Application CodeEditable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    VAR
        LeaveAppTable: Record "HR Leave Application";
    begin
        "Responsibility Center" := 'FINANCE';
        if "Leave Type" = 'STUDY' THEN begin
            ExamDates := true;
        end;
        // LeaveAppTable.Reset();
        // LeaveAppTable.SetRange(LeaveAppTable."User ID", "User ID");
        // if LeaveAppTable.Find('-') then begin
        //     repeat
        //         if (LeaveAppTable.Status = LeaveAppTable.Status::New) or (LeaveAppTable.Status = LeaveAppTable.Status::Approved) or (LeaveAppTable.Status = LeaveAppTable.Status::"Pending Approval") then begin
        //             Error('You have a ' + Format(LeaveAppTable.Status) + ' card that is not posted. Utilise it FIRST!');
        //         end;
        //     until LeaveAppTable.Next = 0;
        // end;
    end;


    var
        HREmp: Record "HR Employee";
        HREmp2: Record "HR Employee";
        Users: Record User;
        EmpJobDesc: Text[50];
        HRJobs: Record "HR Jobss";
        SupervisorName: Text[60];
        URL: Text[500];
        dAlloc: Decimal;
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Decimal;
        CancelApproval: Boolean;
        HRSetup: Record "HR General Setup";
        EmpDept: Text[30];
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        HRLeaveApp: Record "HR Leave Application";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication;
        ApprovalEntries: Page "Approval Entries";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        EmpName: Text[70];
        ApprovalComments: Page "Approval Comments";
        [InDataSet]
        "Application CodeEditable": Boolean;
        [InDataSet]
        "Leave TypeEditable": Boolean;
        [InDataSet]
        "Days AppliedEditable": Boolean;
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        "Start DateEditable": Boolean;
        [InDataSet]
        "Leave Allowance AmountEditable": Boolean;
        [InDataSet]
        RelieverEditable: Boolean;
        [InDataSet]
        RequestLeaveAllowanceEditable: Boolean;
        [InDataSet]
        SupervisorEditable: Boolean;
        [InDataSet]
        "Cell Phone NumberEditable": Boolean;
        [InDataSet]
        "Details of ExaminationEditable": Boolean;
        [InDataSet]
        "Date of ExamEditable": Boolean;
        [InDataSet]
        NumberofPreviousAttemptsEditab: Boolean;
        Text19010232: label 'Leave Statistics';
        Text1: label 'Reliver Details';
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        LeaveGjline: Record "HR Journal Line";
        "LineNo.": Integer;
        sDate: Record Date;
        Customized: Record "HR Calendar List";
        HREmailParameters: Record "HR E-Mail Parameters";
        HRLeavePeriods: Record "HR Leave Periods";
        HRJournalBatch: Record "HR Leave Journal Batch";
        LeaveDaysText: Text;
        ReleivedBy: Text;
        ReleiverEmail: Text;
        HRLeavetyp: Record "HR Leave Types";
        LeaveBalanceCaption: Text;
        ExamDates: Boolean;
        VarEmailBody: Text;
        IsApproved: Boolean;
        CanPost: Boolean;
        VarEmailSubject: Text;
        SFactory: Codeunit "SURESTEP Factory";
        ObjApprovals: Record "Approval Entry";
        Approver: Text;
        EmailCC: Text;
        LeavePeriod: Text;
        MemberReg: Record Customer;
        LoansRegister: Record "Loans Register";
        FileName: Text[200];
        FileName2: Text[200];
        FileType: Text[100];
        SendEmailTo: Text[100];
        EmailBody: Text[1000];
        EmailSubject: Text[100];
        membersreg: Record Customer;
        Outstr: OutStream;
        Instr: InStream;

        Outstr2: OutStream;
        Instr2: InStream;
        TempBlob: Codeunit "Temp Blob";

        MailToSend: Codeunit "Email Message";
        GenerateDoc: InStream;
        EncodeStream: Codeunit "Base64 Convert";
        FnEmail: Codeunit Email;
        DialogBox: Dialog;
        SendApproval: Boolean;

    procedure FillVariables()
    begin
        //GET THE APPLICANT DETAILS

        HREmp.Reset;
        if HREmp.Get("Employee No") then begin
            EmpName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            EmpDept := HREmp."Global Dimension 2 Code";
            "Job Tittle" := HREmp.Position;
        end else begin
            EmpDept := '';
        end;

        //GET THE JOB DESCRIPTION FRON THE HR JOBS TABLE AND PASS IT TO THE VARIABLE
        HRJobs.Reset;
        if HRJobs.Get("Job Tittle") then begin
            EmpJobDesc := HRJobs."Job Description";

        end else begin
            EmpJobDesc := '';
        end;

        //GET THE APPROVER NAMES
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", Supervisor);
        if HREmp.Find('-') then begin
            SupervisorName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        end else begin
            SupervisorName := '';
        end;
    end;


    procedure GetLeaveStats(LeaveType: Text[50])
    begin
        dAlloc := 0;
        dEarnd := 0;
        dTaken := 0;
        dLeft := 0;
        cReimbsd := 0;
        cPerDay := 0;
        cbf := 0;
        if HREmp.Get("Employee No") then begin
            HREmp.SetFilter(HREmp."Leave Type Filter", LeaveType);
            HREmp.CalcFields(HREmp."Allocated Leave Days", HREmp."Reimbursed Leave Days", HREmp."Total Leave Taken");
            dAlloc := HREmp."Allocated Leave Days";
            dEarnd := HREmp."Allocated Leave Days" + HREmp."Reimbursed Leave Days";
            dTaken := (HREmp."Total Leave Taken" * -1);
            dLeft := dEarnd - dTaken;
            cReimbsd := HREmp."Cash - Leave Earned";
            cPerDay := HREmp."Cash per Leave Day";
            cbf := HREmp."Reimbursed Leave Days";
        end;
    end;


    procedure TESTFIELDS()
    begin
        TestField("Leave Type");
        TestField("Days Applied");
        TestField("Start Date");
        //TESTFIELD(Reliever);
        TestField(Supervisor);
    end;


    procedure Updatecontrols()
    begin

        if Status = Status::New then begin
            "Application CodeEditable" := true;
            SendApproval := true;
            IsApproved := false;
            CanPost := false;
            CancelApproval := false;
            "Leave TypeEditable" := true;
            "Days AppliedEditable" := true;
            "Responsibility CenterEditable" := true;
            "Start DateEditable" := true;
            "Leave Allowance AmountEditable" := true;
            RelieverEditable := true;
            RequestLeaveAllowanceEditable := true;
            SupervisorEditable := true;
            "Cell Phone NumberEditable" := true;
            "Details of ExaminationEditable" := true;
            "Date of ExamEditable" := true;
            NumberofPreviousAttemptsEditab := true;
        end else
            if Status = Status::"Pending Approval" then begin
                SendApproval := false;
                "Application CodeEditable" := false;
                "Leave TypeEditable" := false;
                IsApproved := false;
                CanPost := false;
                "Days AppliedEditable" := false;
                "Responsibility CenterEditable" := false;
                "Start DateEditable" := false;
                "Leave Allowance AmountEditable" := false;
                RelieverEditable := false;
                CancelApproval := true;
                RequestLeaveAllowanceEditable := false;
                SupervisorEditable := false;
                "Cell Phone NumberEditable" := false;
                "Details of ExaminationEditable" := false;
                "Date of ExamEditable" := false;
                NumberofPreviousAttemptsEditab := false;
            end else
                if Status = Status::Approved then begin
                    SendApproval := false;
                    "Application CodeEditable" := false;
                    "Leave TypeEditable" := false;
                    "Days AppliedEditable" := false;
                    IsApproved := true;
                    "Responsibility CenterEditable" := false;
                    "Start DateEditable" := false;
                    "Leave Allowance AmountEditable" := false;
                    RelieverEditable := false;
                    CancelApproval := false;
                    RequestLeaveAllowanceEditable := false;
                    SupervisorEditable := false;
                    "Cell Phone NumberEditable" := false;
                    "Details of ExaminationEditable" := false;
                    "Date of ExamEditable" := false;
                    NumberofPreviousAttemptsEditab := false;
                end else begin
                    SendApproval := false;
                    "Application CodeEditable" := false;
                    "Leave TypeEditable" := false;
                    "Days AppliedEditable" := false;
                    "Responsibility CenterEditable" := false;
                    "Start DateEditable" := false;
                    "Leave Allowance AmountEditable" := false;
                    RelieverEditable := false;
                    CancelApproval := false;
                    RequestLeaveAllowanceEditable := false;
                    SupervisorEditable := false;
                    "Cell Phone NumberEditable" := false;
                    "Details of ExaminationEditable" := false;
                    "Date of ExamEditable" := false;
                    NumberofPreviousAttemptsEditab := false;
                end;
        if (Status = Status::Approved) and (FnUserCanPost("User ID")) then begin
            IsApproved := true;
            CanPost := true;
        end else begin
            IsApproved := false;
            CanPost := false;
        end;
    end;


    procedure TestLeaveFamily()
    var
        LeaveFamily: Record "HR Leave Family Groups";
        LeaveFamilyEmployees: Record "HR Leave Family Employees";
        Employees: Record "HR Employee";
    begin
        LeaveFamilyEmployees.SetRange(LeaveFamilyEmployees."Employee No", "Employee No");
        if LeaveFamilyEmployees.FindSet then //find the leave family employee is associated with
            repeat
                LeaveFamily.SetRange(LeaveFamily.Code, LeaveFamilyEmployees.Family);
                LeaveFamily.SetFilter(LeaveFamily."Max Employees On Leave", '>0');
                if LeaveFamily.FindSet then //find the status other employees on the same leave family
                  begin
                    Employees.SetRange(Employees."No.", LeaveFamilyEmployees."Employee No");
                    Employees.SetRange(Employees."Leave Status", Employees."leave status"::" ");
                    if Employees.Count > LeaveFamily."Max Employees On Leave" then
                        Error('The Maximum number of employees on leave for this family has been exceeded, Contact th HR manager for more information');
                end
            until LeaveFamilyEmployees.Next = 0;
    end;


    procedure DetermineLeaveReturnDates(var fBeginDate: Date; var fDays: Decimal) fReturnDate: Date
    begin
        /*varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        REPEAT
          IF DetermineIfIncludesNonWorking("Leave Type") =FALSE THEN BEGIN
            fReturnDate := CALCDATE('1D', fReturnDate);
            IF DetermineIfIsNonWorking(fReturnDate) THEN
              varDaysApplied := varDaysApplied + 1
            ELSE
              varDaysApplied := varDaysApplied;
            varDaysApplied := varDaysApplied - 1
          END
          ELSE BEGIN
            fReturnDate := CALCDATE('1D', fReturnDate);
            varDaysApplied := varDaysApplied - 1;
          END;
        UNTIL varDaysApplied = 0;
        EXIT(fReturnDate);
               */

    end;


    procedure DetermineIfIncludesNonWorkings(var fLeaveCode: Code[10]): Boolean
    begin
        if HRLeaveTypes.Get(fLeaveCode) then begin
            if HRLeaveTypes."Inclusive of Non Working Days" = true then
                exit(true);
        end;
    end;


    procedure DetermineIfIsNonWorking(var bcDate: Date) Isnonworking: Boolean
    begin

        HRSetup.Find('-');
        HRSetup.TestField(HRSetup."Base Calendar");
        BaseCalendarChange.SetFilter(BaseCalendarChange."Base Calendar Code", HRSetup."Base Calendar");
        BaseCalendarChange.SetRange(BaseCalendarChange.Date, bcDate);

        if BaseCalendarChange.Find('-') then begin
            if BaseCalendarChange.Nonworking = false then
                Error('Start date can only be a Working Day Date');
            exit(true);
        end;

        /*
        Customized.RESET;
        Customized.SETRANGE(Customized.Date,bcDate);
        IF Customized.FIND('-') THEN BEGIN
            IF Customized."Non Working" = TRUE THEN
            EXIT(TRUE)
            ELSE
            EXIT(FALSE);
        END;
         */

    end;


    procedure DeterminethisLeaveEndDates(var fDate: Date) fEndDate: Date
    begin
        /*ReturnDateLoop := TRUE;
        fEndDate := fDate;
        IF fEndDate <> 0D THEN BEGIN
          fEndDate := CALCDATE('-1D', fEndDate);
          WHILE (ReturnDateLoop) DO BEGIN
          IF DetermineIfIsNonWorking(fEndDate) THEN
            fEndDate := CALCDATE('-1D', fEndDate)
           ELSE
            ReturnDateLoop := FALSE;
          END
          END;
        EXIT(fEndDate);
         */

    end;


    procedure CreateLeaveLedgerEntriess()
    begin
        TestField("Approved days");
        HRSetup.Reset;
        if HRSetup.Find('-') then begin

            LeaveGjline.Reset;
            LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            LeaveGjline.DeleteAll;
            //Dave
            //HRSetup.TESTFIELD(HRSetup."Leave Template");
            //HRSetup.TESTFIELD(HRSetup."Leave Batch");

            HREmp.Get("Employee No");
            //HREmp.TestField(HREmp."Email Address");

            //POPULATE JOURNAL LINES

            "LineNo." := 10000;
            LeaveGjline.Init;
            LeaveGjline."Journal Template Name" := HRSetup."Leave Template";
            LeaveGjline."Journal Batch Name" := HRSetup."Leave Batch";
            LeaveGjline."Line No." := "LineNo.";
            LeaveGjline."Leave Period" := format(Date2DMY(today, 3));
            LeaveGjline."Document No." := "Application Code";
            LeaveGjline."Staff No." := "Employee No";
            LeaveGjline.Validate(LeaveGjline."Staff No.");
            LeaveGjline."Posting Date" := Today;
            LeaveGjline."Leave Entry Type" := LeaveGjline."leave entry type"::Negative;
            LeaveGjline."Leave Approval Date" := Today;
            LeaveGjline.Description := 'Leave Taken';
            LeaveGjline."Leave Type" := "Leave Type";
            //------------------------------------------------------------
            //HRSetup.RESET;
            //HRSetup.FIND('-');
            HRSetup.TestField(HRSetup."Leave Posting Period[FROM]");
            HRSetup.TestField(HRSetup."Leave Posting Period[TO]");
            //------------------------------------------------------------
            LeaveGjline."Leave Period Start Date" := HRSetup."Leave Posting Period[FROM]";
            LeaveGjline."Leave Period End Date" := HRSetup."Leave Posting Period[TO]";
            LeaveGjline."No. of Days" := "Approved days";
            if LeaveGjline."No. of Days" <> 0 then
                LeaveGjline.Insert(true);

            //Post Journal
            LeaveGjline.Reset;
            LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            if LeaveGjline.Find('-') then begin
                Codeunit.Run(Codeunit::"HR Leave Jnl.-Post", LeaveGjline);
            end;
            Status := Status::Posted;
            Modify;

        end;

    end;


    procedure NotifyApplicants()
    var
        recipient: list of [text];
    begin
        HREmp.Get("Employee No");
        HREmp.TestField(HREmp."Email Address");

        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        HREmailParameters.Reset;
        HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."associate with"::"Interview Invitations");
        if HREmailParameters.Find('-') then begin
            //Error('email');
            // HREmp.TestField(HREmp."Email Address");
            // recipient.Add(HREmp."Email Address");
            // SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", recipient,
            // HREmailParameters.Subject, 'Dear' + ' ' + HREmp."First Name" + ' ' +
            // HREmailParameters.Body + ' ' + "Application Code" + ' ' + HREmailParameters."Body 2", true);
            // SMTP.Send();
            Message('Leave applicant has been notified successfully');
        end;
    end;

    local procedure FnUserCanPost(UserID: Code[50]): Boolean
    var
        usersetup: Record "User Setup";
    begin
        usersetup.Reset();
        usersetup.SetRange(usersetup."User ID", UserID);
        if usersetup.Find('-') then begin
            if usersetup."Post Leave Days Allocations" = true then begin
                exit(true);
            end;
        end;
        exit(false);
    end;
}

