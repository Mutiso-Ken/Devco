#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516180 "Payroll Employee List"
{
    ApplicationArea = Basic;
    CardPageID = "Payroll Employee Card";
    InsertAllowed = true;
DeleteAllowed=true;
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Employee";
    SourceTableView = where(Status = const(Active));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Full Name"; "Full Name")
                {
                    ApplicationArea = Basic;
                }
                field("Joining Date"; "Joining Date")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Status"; Status)
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Status';
                }
            }
        }
        area(factboxes)
        {

            part(HrEmployeePictureFactbox; HrEmployeePictureFactbox)
            {

            }
        }
    }

    actions
    {
        area(creation)
        {
            // action("Update List")
            // {
            //     ApplicationArea = Basic;
            //     Image = Allocations;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     PromotedCategory = Process;
            //     PromotedOnly = true;
            //     Visible = false;

            //     trigger OnAction()
            //     var
            //         objEmp: Record "HR Employee";
            //         PayrollEmployees: record "Payroll Employee";
            //     begin
            //         //......................................Check For If there are new employees in HR Employee Table
            //         PayrollEmployees.Reset();
            //         PayrollEmployees.SetRange(PayrollEmployees."No.", objEmp."No.");
            //         if PayrollEmployees.Find('-') = false then begin
            //             repeat
            //                 PayrollEmployees.Init();
            //                 PayrollEmployees."No." := objEmp."No.";
            //                 PayrollEmployees.Surname := objEmp.Surname;
            //                 PayrollEmployees.Firstname := objEmp."First Name";
            //                 PayrollEmployees."Joining Date" := objEmp."Date Of Join";
            //                 PayrollEmployees."Global Dimension 1" := objEmp."Global Dimension 1 Code";
            //                 PayrollEmployees."Global Dimension 2" := objEmp."Global Dimension 2 Code";
            //                 PayrollEmployees."Payment Mode" := "Payment Mode"::"Bank Transfer";
            //                 PayrollEmployees.Status := Status::Active;
            //                 PayrollEmployees."NSSF No" := objEmp."NSSF No.";
            //                 PayrollEmployees."Pays NHIF" := true;
            //                 PayrollEmployees."Pays NSSF" := true;
            //                 PayrollEmployees."PIN No" := objEmp."PIN No.";
            //                 PayrollEmployees."Pays PAYE" := true;
            //                 if CopyStr(objEmp."No.", 1, 2) = 'C0' then begin
            //                     PayrollEmployees.Gratuity := true;
            //                     PayrollEmployees.Casual := true;
            //                 end;
            //                 PayrollEmployees."Full Name" := objEmp."Full Name";

            //                 if PayrollEmployees.Insert(true) = false then begin
            //                     PayrollEmployees.Modify();
            //                 end;
            //             until objEmp.Next = 0;
            //             Message('Updated');
            //         end;
            //         Message('No new Records');
            //     end;
            // }
        }
    }

    trigger OnInit()
    var
        ProcessPayroll: Codeunit "Sacco Payroll Management";
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Post Leave Days Allocations" then
                Error(PemissionDenied);
        end else begin
            Error(UserNotFound, UserId);
        end;
    end;

    var
        Employee: Record "Payroll Employee";
        UserSetup: Record "User Setup";
        UserNotFound: label 'User Setup %1 not found.';
        PemissionDenied: label 'User Account is not Setup for Payroll Use. Contact System Administrator.';
        PayrollEmp: Record "Payroll Employee";
        ProgressWindow: Dialog;
        PayrollManager: Codeunit "Sacco Payroll Management";
        "Payroll Period": Date;
        PayrollCalender: Record "Payroll Calender";
        PayrollMonthlyTrans: Record "Payroll Monthly Transactions";
        PayrollEmployeeDed: Record "Payroll Employee Deductions";
        PayrollEmployerDed: Record "Payroll Employer Deductions";

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
}

