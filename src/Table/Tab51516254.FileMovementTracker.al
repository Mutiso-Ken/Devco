#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516254 "File Movement Tracker"
{

    fields
    {
        field(1;"Member No.";Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(2;"Approval Type";Option)
        {
            OptionCaption = 'Loans,Special Loans,Personal Loans,Refunds,Funeral Expenses,Withdrawals - Resignation,Withdrawals - Death,Branch Loans';
            OptionMembers = Loans,"Special Loans","Personal Loans",Refunds,"Funeral Expenses","Withdrawals - Resignation","Withdrawals - Death","Branch Loans";
        }
        field(3;Stage;Integer)
        {
        }
        field(4;Remarks;Text[50])
        {
        }
        field(5;Status;Option)
        {
            OptionCaption = 'Being Processed,Approved,Rejected';
            OptionMembers = "Being Processed",Approved,Rejected;
        }
        field(6;"Current Location";Boolean)
        {
        }
        field(7;"Date/Time In";DateTime)
        {
        }
        field(8;"Date/Time Out";DateTime)
        {
        }
        field(9;"USER ID";Code[20])
        {
        }
        field(10;"Entry No.";Integer)
        {
        }
        field(11;Description;Text[50])
        {
        }
        field(12;Station;Code[50])
        {
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
        }
        key(Key2;"Member No.","Approval Type","Entry No.",Stage)
        {
            Clustered = true;
        }
        key(Key3;"Member No.","Current Location")
        {
        }
    }

    fieldgroups
    {
    }
}

