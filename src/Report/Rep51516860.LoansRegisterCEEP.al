// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 51516860 "Loans Register-CEEP"
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = all;
//     Caption = 'Update Loans';

//     dataset
//     {
//         dataitem(Loans; "Loans Register")
//         {


//             trigger OnAfterGetRecord()
//             begin
//                 Loans.Reset();
//                 Loans.SetRange(Loans."Loan  No.", "Loan  No.");
//                 if Loans.FindSet() then begin
//                     Loans.Repayment := Loans."Loan Principle Repayment" + "Loan Interest Repayment";
//                 end;

//             end;


//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         RPeriod: Decimal;
//         BatchL: Code[100];
//         Batches: Record "Loan Disburesment-Batching";
//         ApprovalSetup: Record "Approval Setup";
//         LocationFilter: Code[20];
//         TotalApproved: Decimal;
//         cust: Record Customer;
//         BOSABal: Decimal;
//         SuperBal: Decimal;
//         LAppl: Record "Loans register";
//         Deposits: Decimal;
//         CompanyCode: Code[20];
//         LoanType: Text[50];
//         LoanProdType: Record "Loan Products Setup";
//         LCount: Integer;
//         RFilters: Text[250];
//         DValue: Record "Dimension Value";
//         VALREPAY: Record "Cust. Ledger Entry";
//         Loans_RegisterCaptionLbl: label 'Loans Register';
//         CurrReport_PAGENOCaptionLbl: label 'Page';
//         Loan_TypeCaptionLbl: label 'Loan Type';
//         Client_No_CaptionLbl: label 'Client No.';
//         Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
//         PeriodCaptionLbl: label 'Period';
//         Approved_DateCaptionLbl: label 'Approved Date';
//         Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';
//         Verified_By__________________________________________________CaptionLbl: label 'Verified By..................................................';
//         Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................................................';
//         Sign________________________CaptionLbl: label 'Sign........................';
//         Sign________________________Caption_Control1102755003Lbl: label 'Sign........................';
//         Date________________________CaptionLbl: label 'Date........................';
//         Date________________________Caption_Control1102755005Lbl: label 'Date........................';
//         Datefilter: Date;
//         CustLedger: Record "Cust. Ledger Entry";
//         DateFilterr: Date;
//         LBalance: Decimal;
// }

