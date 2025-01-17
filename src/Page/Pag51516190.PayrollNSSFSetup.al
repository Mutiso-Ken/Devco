#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516190 "Payroll NSSF Setup"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Payroll NSSF Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tier Code"; "Tier Code")
                {
                    ApplicationArea = Basic;
                }
                field(Earnings; Earnings)
                {
                    ApplicationArea = Basic;
                }
                field("Pensionable Earnings"; "Pensionable Earnings")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 1 earnings"; "Tier 1 earnings")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 1 Employee Deduction"; "Tier 1 Employee Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 1 Employer Contribution"; "Tier 1 Employer Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 2 earnings"; "Tier 2 earnings")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 2 Employee Deduction"; "Tier 2 Employee Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 2 Employer Contribution"; "Tier 2 Employer Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Lower Limit"; "Lower Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Upper Limit"; "Upper Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Total NSSF Contribution"; "Total NSSF Contribution")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

