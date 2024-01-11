pageextension 51516628 "ChartOfAccountsCardExt" extends "G/L Account Card"
{

    layout
    {
        addbefore(Name)
        {

        }

    }
    trigger OnOpenPage()
    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Accessed and read the G/L account page no-' + Format("No.") + ' Name-' + Format(Name));
    end;

    trigger OnClosePage()
    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Closed G/L account page no-' + Format("No.") + ' Name-' + Format(Name));
    end;

    var
        AuditLog: Codeunit "Audit Log Codeunit";
}