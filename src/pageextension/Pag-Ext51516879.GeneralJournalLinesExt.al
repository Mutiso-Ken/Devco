pageextension 51516879 "GeneralJournalLinesExt" extends "General Journal"
{
    layout
    {
        addafter("Credit Amount")
        {
            field("Debit Amounts"; "Debit Amount")
            {
                ApplicationArea = Basic;
            }
            field("Credit Amounts"; "Credit Amount")
            {
                ApplicationArea = Basic;
            }
            field("Transaction Type"; "Transaction Type")
            {
                ApplicationArea = Basic;
            }
            field("Loan No"; "Loan No")
            {
                ApplicationArea = Basic;
            }
            field("Loan Product Type"; "Loan Product Type")
            {
                ApplicationArea = Basic;
            }
            field("Line No."; "Line No.")
            {
                ApplicationArea = Basic;
            }


        }
        modify("External Document No.")
        {
            Visible = false;
        }
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Bal. Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }
        modify(Comment)
        {
            Visible = false;
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Activity';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Branch';
        }
        modify(Correction)
        {
            Visible = false;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }


    }
    actions
    {
        addafter("&Line")
        {
            action(ImportJoural)
            {
                ApplicationArea = all;
                RunObject = xmlport "Import Sacco Jnl";
            }
        }

    }
}