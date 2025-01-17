#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516010 "Posted Cash Payment Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Payment Header";
    SourceTableView = where("Payment Type"=const("Cash Purchase"),
                            Posted=const(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date";"Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code";"Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account";"Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account Name";"Bank Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account Balance";"Bank Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field(Payee;Payee)
                {
                    ApplicationArea = Basic;
                }
                field("On Behalf Of";"On Behalf Of")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Description";"Payment Description")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount(LCY)";"Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Amount";"VAT Amount")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Amount(LCY)";"VAT Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("WithHolding Tax Amount";"WithHolding Tax Amount")
                {
                    ApplicationArea = Basic;
                }
                field("WithHolding Tax Amount(LCY)";"WithHolding Tax Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount";"Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount(LCY)";"Net Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code";"Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Posted By";"Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted";"Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted";"Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field(Cashier;Cashier)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control35;"Posted Cash Payment Line")
            {
                SubPageLink = "Document No"=field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Print)
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                      PHeader.Reset;
                      PHeader.SetRange(PHeader."No.","No.");
                      if PHeader.FindFirst then begin
                        Report.RunModal(Report::"Cash Voucher",true,false,PHeader);
                      end;
                end;
            }
        }
    }

    var
        PHeader: Record "Payment Header";
}

