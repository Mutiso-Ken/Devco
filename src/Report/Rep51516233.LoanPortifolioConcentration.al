#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516233 "Loan Portifolio Concentration"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Portifolio Concentration.rdlc';

    dataset
    {
        dataitem("Loan Products Setup"; "Loan Products Setup")
        {
            DataItemTableView = sorting(Code);
            RequestFilterFields = "Code";
            column(ReportForNavId_1344; 1344)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Loan_Product_Types__Loan_Product_Types___Product_Description_; "Loan Products Setup"."Product Description")
            {
            }
            column(LessTenthousand; LessTenthousand)
            {
            }
            column(LessTenthousandCount; LessTenthousandCount)
            {
            }
            column(Less20thousand; Less20thousand)
            {
            }
            column(Less20thousandCount; Less20thousandCount)
            {
            }
            column(Less50thousandCount; Less50thousandCount)
            {
            }
            column(Less50thousand; Less50thousand)
            {
            }
            column(Less100thousandCount; Less100thousandCount)
            {
            }
            column(Less100thousand; Less100thousand)
            {
            }
            column(Greaterthousand; Greaterthousand)
            {
            }
            column(GreaterthousandCount; GreaterthousandCount)
            {
            }
            column(V10perInt_; "10perInt")
            {
            }
            column(V20perInt_; "20perInt")
            {
            }
            column(V500perInt_; "500perInt")
            {
            }
            column(V100perInt_; "100perInt")
            {
            }
            column(GreaterperInt; GreaterperInt)
            {
            }
            column(V10perDec_; "10perDec")
            {
            }
            column(V20perDec_; "20perDec")
            {
            }
            column(V500perDec_; "500perDec")
            {
            }
            column(V100perDec_; "100perDec")
            {
            }
            column(GreaterperDec; GreaterperDec)
            {
            }
            column(TotalDec; TotalDec)
            {
            }
            column(TotalInt; TotalInt)
            {
            }
            column(PORTFOLIO_CONCENTRATION_ANALYSISCaption; PORTFOLIO_CONCENTRATION_ANALYSISCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loan_SizeCaption; Loan_SizeCaptionLbl)
            {
            }
            column(CountCaption; CountCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1000000053; EmptyStringCaption_Control1000000053Lbl)
            {
            }
            column(Outstanding_BalanceCaption; Outstanding_BalanceCaptionLbl)
            {
            }
            column(V0_____250_000Caption; V0_____250_000CaptionLbl)
            {
            }
            column(V250_001_____500_000Caption; V250_001_____500_000CaptionLbl)
            {
            }
            column(V500_001_____750_000Caption; V500_001_____750_000CaptionLbl)
            {
            }
            column(V750_001___1_000_000Caption; V750_001___1_000_000CaptionLbl)
            {
            }
            column(V1_000_000Caption; V1_000_000CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Loan_Product_Types_Code; Code)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LessTenthousand := 0;
                LessTenthousandCount := 0;
                Less20thousand := 0;
                Less20thousandCount := 0;
                Less50thousand := 0;
                Less50thousandCount := 0;
                Less100thousand := 0;
                Less100thousandCount := 0;
                Greaterthousand := 0;
                GreaterthousandCount := 0;
                "10perInt" := 0;
                "20perInt" := 0;
                "500perInt" := 0;
                "100perInt" := 0;
                GreaterperInt := 0;
                "10perDec" := 0;
                "20perDec" := 0;
                "500perDec" := 0;
                "100perDec" := 0;
                GreaterperDec := 0;
                TotalInt := 0;
                TotalDec := 0;
                PerTotalInt := 0;
                PertotalDec := 0;
                LoanBal := 0;


                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Loan Product Type", "Loan Products Setup".Code);
                LoanApp.SetRange(LoanApp."Issued Date", FromDate, ToDate);
                if LoanApp.Find('-') then begin
                    repeat
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        LoanBal := LoanApp."Outstanding Balance";
                        if LoanBal > 0 then begin
                            if LoanBal <= 250000 then begin
                                LessTenthousandCount := LessTenthousandCount + 1;
                                LessTenthousand := LessTenthousand + LoanBal;
                            end;

                            if (LoanBal > 250001) and (LoanBal <= 500000) then begin
                                Less20thousandCount := Less20thousandCount + 1;
                                Less20thousand := Less20thousand + LoanBal;
                            end;

                            if (LoanBal > 500001) and (LoanBal <= 750000) then begin
                                Less50thousandCount := Less50thousandCount + 1;
                                Less50thousand := Less50thousand + LoanBal;
                            end;

                            if (LoanBal > 750001) and (LoanBal <= 1000000) then begin
                                Less100thousandCount := Less100thousandCount + 1;
                                Less100thousand := Less100thousand + LoanBal;
                            end;

                            if LoanBal > 1000000 then begin
                                GreaterthousandCount := GreaterthousandCount + 1;
                                Greaterthousand := Greaterthousand + LoanBal;
                            end;

                        end;
                    until LoanApp.Next = 0;

                end;
                TotalDec := TotalDec + LessTenthousand + Less20thousand + Less50thousand + Less100thousand + Greaterthousand;
                TotalInt := GreaterperInt + LessTenthousandCount + Less20thousandCount + Less50thousandCount + Less100thousandCount +
                               GreaterthousandCount;

                if TotalDec <> 0 then begin
                    "10perDec" := ROUND((LessTenthousand / TotalDec) * 100, 1);
                    "20perDec" := ROUND((Less20thousand / TotalDec) * 100, 1);
                    "500perDec" := ROUND((Less50thousand / TotalDec) * 100, 1);
                    "100perDec" := ROUND((Less100thousand / TotalDec) * 100, 1);
                    GreaterperDec := ROUND((Greaterthousand / TotalDec) * 100, 1);
                end;
                if TotalInt <> 0 then begin
                    "10perInt" := ROUND((LessTenthousandCount / TotalInt) * 100, 1);
                    "20perInt" := ROUND((Less20thousandCount / TotalInt) * 100, 1);
                    "500perInt" := ROUND((Less50thousandCount / TotalInt) * 100, 1);
                    "100perInt" := ROUND((Less100thousandCount / TotalInt) * 100, 1);
                    GreaterperInt := ROUND((GreaterthousandCount / TotalInt) * 100, 1);
                end;
                PerTotalInt := "10perInt" + "20perInt" + "500perInt" + "100perInt" + GreaterperInt;
                PertotalDec := "10perDec" + "20perDec" + "500perDec" + "100perDec" + GreaterperDec;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo(Code);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if FromDate = 0D then
            Error('Must specify from date');
        if ToDate = 0D then
            Error('Must specify To date');
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        LessTenthousand: Decimal;
        LessTenthousandCount: Integer;
        Less20thousand: Decimal;
        Less20thousandCount: Integer;
        Less50thousand: Decimal;
        Less50thousandCount: Integer;
        Less100thousand: Decimal;
        Less100thousandCount: Integer;
        Greaterthousand: Decimal;
        GreaterthousandCount: Integer;
        LoanApp: Record "Loans Register";
        FromDate: Date;
        ToDate: Date;
        "10perInt": Integer;
        "20perInt": Integer;
        "500perInt": Integer;
        "100perInt": Integer;
        GreaterperInt: Integer;
        "10perDec": Decimal;
        "20perDec": Decimal;
        "500perDec": Decimal;
        "100perDec": Decimal;
        GreaterperDec: Decimal;
        TotalInt: Integer;
        TotalDec: Decimal;
        PerTotalInt: Integer;
        PertotalDec: Integer;
        LoanBal: Decimal;
        PORTFOLIO_CONCENTRATION_ANALYSISCaptionLbl: label 'PORTFOLIO CONCENTRATION ANALYSIS';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_SizeCaptionLbl: label 'Loan Size';
        CountCaptionLbl: label 'Count';
        EmptyStringCaptionLbl: label '%';
        EmptyStringCaption_Control1000000053Lbl: label '%';
        Outstanding_BalanceCaptionLbl: label 'Outstanding Balance';
        V0_____250_000CaptionLbl: label '0 -   250,000';
        V250_001_____500_000CaptionLbl: label '250,001 -   500,000';
        V500_001_____750_000CaptionLbl: label '500.001 -   750,000';
        V750_001___1_000_000CaptionLbl: label '750,001 - 1,000,000';
        V1_000_000CaptionLbl: label '>1,000,000';
        TotalCaptionLbl: label 'Total';
}

