Page 51516181 "Payroll Employee Card"
{
    DeleteAllowed =true;
    PageType = Card;
    SourceTable = "Payroll Employee";
    Editable = true;
    InsertAllowed=true;



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
                  field("Sacco No";"Sacco No")
                {
                    ApplicationArea = All;
                    Caption = 'Sacco Member No.';

                }
                field(Surname; Surname)
                {
                    ApplicationArea = Basic;
                }
                 field("Full Name";"Full Name")
                {
                    ApplicationArea = Basic;
                }
                field(Firstname; Firstname)
                {
                    ApplicationArea = Basic;
                }
                field(Lastname; Lastname)
                {
                    ApplicationArea = Basic;
                }
                field(Photo; Photo)
                {
                    ApplicationArea = Basic;
                }
                field("Joining Date"; "Joining Date")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1"; "Global Dimension 1")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2"; "Global Dimension 2")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Group"; "Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Mode"; "Payment Mode")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("NSSF No"; "NSSF No")
                {
                    ApplicationArea = Basic;
                }
                field("NHIF No"; "NHIF No")
                {
                    ApplicationArea = Basic;
                }
                field("PIN No"; "PIN No")
                {
                    ApplicationArea = Basic;
                }
                field("Period Filter"; "Period Filter")
                {
                    ApplicationArea = Basic;
                }
                group("Pay Details")
                {
                }
                field("Basic Pay"; "Basic Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Basic Pay(LCY)"; "Basic Pay(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Non Taxable"; "Non Taxable")
                {
                    ApplicationArea = Basic;
                }
                field("Non Taxable(LCY)"; "Non Taxable(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Suspend Pay"; "Suspend Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Suspend Date"; "Suspend Date")
                {
                    ApplicationArea = Basic;
                }
                field("Suspend Reason"; "Suspend Reason")
                {
                    ApplicationArea = Basic;
                }
                field("Pays PAYE"; "Pays PAYE")
                {
                    ApplicationArea = Basic;
                }
                field("Pays NSSF"; "Pays NSSF")
                {
                    ApplicationArea = Basic;
                }
                field("Pays NHIF"; "Pays NHIF")
                {
                    ApplicationArea = Basic;
                }
                field("Hourly Rate"; "Hourly Rate")
                {
                    ApplicationArea = Basic;
                }
                field(Gratuity; Gratuity)
                {
                    ApplicationArea = Basic;
                }
                field("Gratuity Percentage"; "Gratuity Percentage")
                {
                    ApplicationArea = Basic;
                }
                field("Gratuity Provision"; "Gratuity Provision")
                {
                    ApplicationArea = Basic;
                }
                field("Gratuity Provision(LCY)"; "Gratuity Provision(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Days Absent"; "Days Absent")
                {
                    ApplicationArea = Basic;
                }
                field("Paid per Hour"; "Paid per Hour")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Bank Details")
            {
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code"; "Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Name"; "Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No"; "Bank Account No")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Other Details")
            {
                field("Payslip Message"; "Payslip Message")
                {
                    ApplicationArea = Basic;
                }
                field(Casual; Casual)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Process All Employee")
            {
                ApplicationArea = Basic;
                Image = Salutation;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ChoiceTacken: Integer;
                begin
                    // ChoiceTacken := 0;
                    // ChoiceTacken := Dialog.StrMenu('Contract Employees,Casual Employees', 1, 'Process Salary for ?');
                    // if ChoiceTacken = 1 then begin
                    //     FnProcessSalaryForNonCasualEmployees();
                    // end else
                    //     if ChoiceTacken = 2 then begin

                    //     end else begin
                    //         exit;
                    //     end;
                    if Confirm('Process Employee Salary ?', false) = false then begin
                        exit;
                    end else begin
                        FnProcessSalaryCasualEmployees();
                    end;

                end;
            }

            action("Employee Earnings")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Payroll Employee Earnings";
                RunPageLink = "No." = field("No.");
            }
            action("Employee Deductions")
            {
                ApplicationArea = Basic;
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Payroll Employee Deductions";
                RunPageLink = "No." = field("No.");
            }
            action("Employee Assignments")
            {
                ApplicationArea = Basic;
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Payroll Employee Assignments";
                RunPageLink = "No." = field("No.");
                Visible = false;
            }
            action("Employee Cummulatives")
            {
                ApplicationArea = Basic;
                Image = History;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Payroll Employee Cummulatives";
                RunPageLink = "No." = field("No.");
                Visible = false;
            }
            action("View PaySlip ")
            {
                ApplicationArea = Basic;
                Caption = 'View PaySlip ';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    PayCalender.Reset;
                    PayCalender.SetRange(PayCalender.Closed, false);
                    if PayCalender.Find('-') then begin
                        Period := PayCalender."Date Opened";
                        PayrollEmp.Reset;
                        PayrollEmp.SetRange(PayrollEmp."No.", "No.");
                        PayrollEmp.SetRange(PayrollEmp."Period Filter", Period);
                        IF PayrollEmp.FIND('-') THEN BEGIN
                            Report.Run(Report::"Payroll Payslip", true, false, PayrollEmp);
                        END ELSE begin
                            Report.Run(Report::"Payroll Payslip", true, false, PayrollEmp);
                        end;
                    END;

                end;
            }
        }
    }

    trigger OnInit()
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Payroll User" then
                Error(PemissionDenied);
        end else begin
            Error(UserNotFound, UserId);
        end;
    end;

    var
        PayrollEmp: Record "Payroll Employee";
        ProgressWindow: Dialog;
        PayrollManager: Codeunit "Payroll Management";
        "Payroll Period": Date;
        PayrollCalender: Record "Payroll Calender";
        PayrollMonthlyTrans: Record "Payroll Monthly Transactions";
        PayrollEmployeeDed: Record "Payroll Employee Deductions";
        PayrollEmployerDed: Record "Payroll Employer Deductions";
        UserSetup: Record "User Setup";
        UserNotFound: label 'User Setup %1 not found.';
        PemissionDenied: label 'User Account is not Setup for Payroll Use. Contact System Administrator.';
        PayCalender: Record "Payroll Calender";
        Period: Date;
        objEmp: Record "HR Employee";
        SalCard: Record "Payroll Employee";
        objPeriod: Record "Payroll Calender";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;

        ProcessPayroll: Codeunit "Sacco Payroll Management";
        HrEmployee: Record "HR Employee";
        prPeriodTransactions: Record "Payroll Monthly Transactions";
        prEmployerDeductions: Record "Payroll Employer Deductions";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Control-Information";


    local procedure RemoveTrans(EmpNo: Code[20]; PayrollPeriod: Date)
    begin
        //Remove Monthly Transactions
        PayrollMonthlyTrans.Reset;
        PayrollMonthlyTrans.SetRange(PayrollMonthlyTrans."No.", EmpNo);
        PayrollMonthlyTrans.SetRange(PayrollMonthlyTrans."Period Month", Date2dmy(PayrollPeriod, 2));
        PayrollMonthlyTrans.SetRange(PayrollMonthlyTrans."Period Year", Date2dmy(PayrollPeriod, 3));
        if PayrollMonthlyTrans.FindSet then
            PayrollMonthlyTrans.DeleteAll;

        //Remove Employee Deductions
        //Remove Employer Deductions
    end;

    local procedure FnProcessSalaryCasualEmployees()
    begin
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        IF objPeriod.FIND('-') THEN;
        SelectedPeriod := objPeriod."Date Opened";
        SalCard.GET("No.");
        TESTFIELD("Basic Pay");
        //-------------------------------------
        PayrollCalender.RESET;
        PayrollCalender.SETRANGE(PayrollCalender.Closed, FALSE);
        IF PayrollCalender.FINDFIRST THEN BEGIN
            "Payroll Period" := PayrollCalender."Date Opened";
        END;
        IF "Payroll Period" = 0D THEN
            ERROR('No Open Payroll Period');
        PayrollEmp.RESET;
        PayrollEmp.SETRANGE(PayrollEmp.Status, PayrollEmp.Status::Active);
        PayrollEmp.SETRANGE(PayrollEmp."Suspend Pay", FALSE);
        IF PayrollEmp.FINDFIRST THEN BEGIN
            ProgressWindow.OPEN('Processing Salary for Employee No. #1#######');
            //First Remove Any transactions for this Month
            RemoveTrans(PayrollEmp."No.", "Payroll Period");
            //End Remove Transactions
            //-------------------------------
            //Delete all Records from the prPeriod Transactions for Reprocessing
            prPeriodTransactions.RESET;
            prPeriodTransactions.SETRANGE(prPeriodTransactions."Payroll Period", SelectedPeriod);
            IF prPeriodTransactions.FIND('-') THEN
                prPeriodTransactions.DELETEALL;
            //Delete all Records from prEmployer Deductions
            prEmployerDeductions.RESET;
            prEmployerDeductions.SETRANGE(prEmployerDeductions."Payroll Period", SelectedPeriod);
            IF prEmployerDeductions.FIND('-') THEN
                prEmployerDeductions.DELETEALL;
            //Use CODEUNIT
            HrEmployee.RESET;
            HrEmployee.SETRANGE(HrEmployee.Status, HrEmployee.Status::Active);
            IF HrEmployee.FIND('-') THEN BEGIN
                //Progress Window
                ProgressWindow.OPEN('Processing Salary for Employee No. #1#######');
                REPEAT
                    //Progress Window
                    SLEEP(100);
                    //Progress Window
                    IF NOT SalCard."Suspend Pay" THEN BEGIN
                        ProgressWindow.UPDATE(1, HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee.Surname);
                        IF SalCard.GET(HrEmployee."No.") THEN
                            ProcessPayroll.fnProcesspayroll(HrEmployee."No.", HrEmployee."Admission Date", SalCard."Basic Pay", SalCard."Pays PAYE"
                                , SalCard."Pays NSSF", SalCard."Pays NHIF", SelectedPeriod, SelectedPeriod, '', '',
                                HrEmployee."Date of Leaving", TRUE, HrEmployee."Department Code", PayrollCode);
                    END;
                UNTIL HrEmployee.NEXT = 0;
                ////Progress Window
                ProgressWindow.CLOSE;
            END;
        END;
    end;

}

