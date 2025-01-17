#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516292 "Account App Next Of Kin Detail"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Accounts App Kin Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field(Relationship;Relationship)
                {
                    ApplicationArea = Basic;
                }
                field(Beneficiary;Beneficiary)
                {
                    ApplicationArea = Basic;
                }
                field("Date of Birth";"Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Address;Address)
                {
                    ApplicationArea = Basic;
                }
                field(Telephone;Telephone)
                {
                    ApplicationArea = Basic;
                }
                field(Fax;Fax)
                {
                    ApplicationArea = Basic;
                }
                field(Email;Email)
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("%Allocation";"%Allocation")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Reset;
                        SetRange("Account No","Account No");
                         CalcFields("Total Allocation");

                         if "%Allocation">"Maximun Allocation %" then
                           Error(' Total allocation should be equal to 100 %');
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        "Maximun Allocation %":=100;
    end;

    trigger OnOpenPage()
    begin
        "Maximun Allocation %":=100;
        //MODIFY;
    end;

    var
        App: Record "Accounts App Kin Details";
}

