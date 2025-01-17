#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516299 "Data Sheet ADJ Loan"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Data Sheet ADJ Loan.rdlc';

    dataset
    {
        dataitem("Data Sheet Main"; "Data Sheet Main")
        {
            DataItemTableView = sorting("Sort Code") order(ascending) where(Source = filter(BOSA), "Transaction Type" = const("ADJUSTMENT LOAN"));
            RequestFilterFields = "PF/Staff No", "Transaction Type", Employer, "Payroll Month", Date;
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(PFStaffNo_DataSheetMain; "Data Sheet Main"."PF/Staff No")
            {
            }
            column(Name_DataSheetMain; "Data Sheet Main".Name)
            {
            }
            column(IDNO_DataSheetMain; "Data Sheet Main"."ID NO.")
            {
            }
            column(TypeofDeduction_DataSheetMain; "Data Sheet Main"."Type of Deduction")
            {
            }
            column(AmountON_DataSheetMain; "Data Sheet Main"."Amount ON")
            {
            }
            column(AmountOFF_DataSheetMain; "Data Sheet Main"."Amount OFF")
            {
            }
            column(NewBalance_DataSheetMain; "Data Sheet Main"."New Balance")
            {
            }
            column(REF_DataSheetMain; "Data Sheet Main"."REF.")
            {
            }
            column(RemarkLoanNO_DataSheetMain; "Data Sheet Main"."Remark/LoanNO")
            {
            }
            column(SortCode_DataSheetMain; "Data Sheet Main"."Sort Code")
            {
            }
            column(Employer_DataSheetMain; "Data Sheet Main".Employer)
            {
            }
            column(TransactionType_DataSheetMain; "Data Sheet Main"."Transaction Type")
            {
            }
            column(Date_DataSheetMain; "Data Sheet Main".Date)
            {
            }
            column(PayrollMonth_DataSheetMain; "Data Sheet Main"."Payroll Month")
            {
            }
            column(InterestAmount_DataSheetMain; "Data Sheet Main"."Interest Amount")
            {
            }
            column(ApprovedAmount_DataSheetMain; "Data Sheet Main"."Approved Amount")
            {
            }
            column(UploadedInterest_DataSheetMain; "Data Sheet Main"."Uploaded Interest")
            {
            }
            column(BatchNo_DataSheetMain; "Data Sheet Main"."Batch No.")
            {
            }
            column(PrincipalAmount_DataSheetMain; "Data Sheet Main"."Principal Amount")
            {
            }
            column(UploadInt_DataSheetMain; "Data Sheet Main".UploadInt)
            {
            }
            column(Source_DataSheetMain; "Data Sheet Main".Source)
            {
            }
            column(Code_DataSheetMain; "Data Sheet Main".Code)
            {
            }
            column(SharesOFF_DataSheetMain; "Data Sheet Main"."Shares OFF")
            {
            }
            column(AdjustmentType_DataSheetMain; "Data Sheet Main"."Adjustment Type")
            {
            }
            column(Period_DataSheetMain; "Data Sheet Main".Period)
            {
            }
            column(aMOUNTON1_DataSheetMain; "Data Sheet Main"."aMOUNT ON 1")
            {
            }
            column(VoteCode_DataSheetMain; "Data Sheet Main"."Vote Code")
            {
            }
            column(EDCode_DataSheetMain; "Data Sheet Main".EDCode)
            {
            }
            column(CurrentBalance_DataSheetMain; "Data Sheet Main"."Current Balance")
            {
            }
            column(TranType_DataSheetMain; "Data Sheet Main".TranType)
            {
            }
            column(TranName_DataSheetMain; "Data Sheet Main".TranName)
            {
            }
            column(Action_DataSheetMain; "Data Sheet Main".Action)
            {
            }
            column(InterestFee_DataSheetMain; "Data Sheet Main"."Interest Fee")
            {
            }
            column(Recoveries_DataSheetMain; "Data Sheet Main".Recoveries)
            {
            }
            column(DateFilter_DataSheetMain; "Data Sheet Main"."Date Filter")
            {
            }
            column(InterestOff_DataSheetMain; "Data Sheet Main"."Interest Off")
            {
            }
            column(RepaymentMethod_DataSheetMain; "Data Sheet Main"."Repayment Method")
            {
            }
            column(No; No)
            {
            }
            column(EmployerName; EmployerName)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Phone_No_; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }

            trigger OnAfterGetRecord()
            begin

                if EmployerS.Get(Employer) then begin
                    EmployerName := EmployerS.Description;
                end;


                LOANS.Reset;
                LOANS.SetRange(LOANS."Loan  No.", "Remark/LoanNO");
                if LOANS.Find('-') then begin
                    repeat
                        if LOANS."Repayment Start Date" <> 0D then begin
                            if "Payroll Month" = '' then begin
                                "Payroll Month" := Format(Date2dmy(LOANS."Repayment Start Date", 2));
                                Modify;
                            end;
                        end;
                    until LOANS.Next = 0;
                end;
                No := No + 1;

                if "Data Sheet Main"."Transaction Type" = "Data Sheet Main"."transaction type"::"FRESH FEED" then begin
                    "Data Sheet Main"."Amount ON" := ROUND("Data Sheet Main"."Amount ON", 5, '>');

                end;

                //"Data Sheet Main".RESET;
                if "Data Sheet Main"."Type of Deduction" = 'BELA' then
                    if "Data Sheet Main"."Payroll Month" = '7/2013' then
                        if "Data Sheet Main".Period <> 0 then
                            "Data Sheet Main"."Amount ON" := ROUND(("Data Sheet Main"."New Balance" + "Data Sheet Main".UploadInt) / "Data Sheet Main".Period, 5, '>');


                //END;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("PF/Staff No");
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Employer Code"; "Data Sheet Main".Employer)
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        EmployerS: Record "Sacco Employers";
        EmployerName: Text[50];
        LOANS: Record "Loans Register";
        No: Integer;
        CompanyInfo: Record "Company Information";
}

