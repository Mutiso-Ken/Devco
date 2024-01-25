#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516222 "Member Account  balances"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/MemberAccountbalances.rdlc';

    dataset
    {
        dataitem(member; Customer)
        {
            RequestFilterFields = "No.", Name;
            column(ReportForNavId_1102755077; 1102755077)
            {
            }
            column(No_member; member."No.")
            {
            }
            column(Name_member; member.Name)
            {
            }
            column(City_member; member.City)
            {
            }
            column(Contact_member; member.Contact)
            {
            }
            column(PhoneNo_member; member."Phone No.")
            {
            }

            column(NoofPstdShipments_member; member."No. of Pstd. Shipments")
            {
            }
            column(NoofPstdInvoices_member; member."No. of Pstd. Invoices")
            {
            }
            column(NoofPstdReturnReceipts_member; member."No. of Pstd. Return Receipts")
            {
            }
            column(NoofPstdCreditMemos_member; member."No. of Pstd. Credit Memos")
            {
            }
            column(NoofShiptoAddresses_member; member."No. of Ship-to Addresses")
            {
            }
            column(BillToNoofQuotes_member; member."Bill-To No. of Quotes")
            {
            }
            column(BillToNoofBlanketOrders_member; member."Bill-To No. of Blanket Orders")
            {
            }
            column(BillToNoofOrders_member; member.CalcFields("Bill-To No. of Orders"))
            {
            }
            column(BillToNoofInvoices_member; member."Bill-To No. of Invoices")
            {
            }
            column(BillToNoofReturnOrders_member; member."Bill-To No. of Return Orders")
            {
            }
            column(BillToNoofCreditMemos_member; member."Bill-To No. of Credit Memos")
            {
            }
            column(BillToNoofPstdShipments_member; member."Bill-To No. of Pstd. Shipments")
            {
            }
            column(BillToNoofPstdInvoices_member; member."Bill-To No. of Pstd. Invoices")
            {
            }
            column(BillToNoofPstdReturnR_member; member."Bill-To No. of Pstd. Return R.")
            {
            }
            column(BillToNoofPstdCrMemos_member; member."Bill-To No. of Pstd. Cr. Memos")
            {
            }
            column(BaseCalendarCode_member; member."Base Calendar Code")
            {
            }
            column(CopySelltoAddrtoQteFrom_member; member."Copy Sell-to Addr. to Qte From")
            {
            }
            column(CustomerType_member; member."Customer Type")
            {
            }
            column(RegistrationDate_member; member."Registration Date")
            {
            }
            column(CurrentLoan_member; member."Current Loan")
            {
            }
            column(CurrentShares_member; member."Current Shares")
            {
            }
            column(TotalRepayments_member; member."Total Repayments")
            {
            }
            column(PrincipalBalance_member; member."Principal Balance")
            {
            }
            column(PrincipalRepayment_member; member."Principal Repayment")
            {
            }
            column(DebtorsType_member; member."Debtors Type")
            {
            }
            column(OutstandingBalance_member; member."Outstanding Balance")
            {
            }
            column(Status_member; member.Status)
            {
            }
            column(FOSAAccount_member; member."FOSA Account")
            {
            }
            column(OldAccountNo_member; member."Old Account No.")
            {
            }
            column(LoanProductFilter_member; member."Loan Product Filter")
            {
            }
            column(EmployerCode_member; member."Employer Code")
            {
            }
            column(DateofBirth_member; member."Date of Birth")
            {
            }
            column(EMailPersonal_member; member."E-Mail (Personal)")
            {
            }
            column(StationDepartment_member; member."Station/Department")
            {
            }
            column(HomeAddress_member; member."Home Address")
            {
            }
            column(Location_member; member.Location)
            {
            }
            column(SubLocation_member; member."Sub-Location")
            {
            }
            column(District_member; member.District)
            {
            }
            column(ResonsforStatusChange_member; member."Resons for Status Change")
            {
            }
            column(PayrollStaffNo_member; member."Payroll/Staff No")
            {
            }
            column(IDNo_member; member."ID No.")
            {
            }
            column(MobilePhoneNo_member; member."Mobile Phone No")
            {
            }
            column(MaritalStatus_member; member."Marital Status")
            {
            }
            column(Signature_member; member.Signature)
            {
            }
            column(PassportNo_member; member."Passport No.")
            {
            }
            column(Gender_member; member.Gender)
            {
            }
            column(WithdrawalDate_member; member."Withdrawal Date")
            {
            }
            column(WithdrawalFee_member; member."Withdrawal Fee")
            {
            }
            column(StatusWithdrawalApp_member; member."Status - Withdrawal App.")
            {
            }
            column(WithdrawalApplicationDate_member; member."Withdrawal Application Date")
            {
            }
            column(InvestmentMonthlyCont_member; member."Investment Monthly Cont")
            {
            }
            column(InvestmentMaxLimit_member; member."Investment Max Limit.")
            {
            }
            column(CurrentInvestmentTotal_member; member."Current Investment Total")
            {
            }
            column(DocumentNoFilter_member; member."Document No. Filter")
            {
            }
            column(SharesRetained_member; member."Shares Retained")
            {
            }
            column(RegistrationFeePaid_member; member."Registration Fee Paid")
            {
            }
            column(RegistrationFee_member; member."Registration Fee")
            {
            }
            column(SocietyCode_member; member."Society Code")
            {
            }
            column(InsuranceFund_member; member."Insurance Fund")
            {
            }
            column(MonthlyContribution_member; member."Monthly Contribution")
            {
            }
            column(InvestmentBF_member; member."Investment B/F")
            {
            }
            column(DividendAmount_member; member."Dividend Amount")
            {
            }
            column(NameofChief_member; member."Name of Chief")
            {
            }
            column(OfficeTelephoneNo_member; member."Office Telephone No.")
            {
            }
            column(ExtensionNo_member; member."Extension No.")
            {
            }
            column(InsuranceContribution_member; member."Insurance Contribution")
            {
            }
            column(Advice_member; member.Advice)
            {
            }
            column(Province_member; member.Province)
            {
            }
            column(PreviousShareContribution_member; member."Previous Share Contribution")
            {
            }
            column(UnallocatedFunds_member; member."Un-allocated Funds")
            {
            }
            column(RefundRequestAmount_member; member."Refund Request Amount")
            {
            }
            column(RefundIssued_member; member."Refund Issued")
            {
            }
            column(BatchNo_member; member."Batch No.")
            {
            }
            column(CurrentStatus_member; member."Current Status")
            {
            }
            column(ChequeNo_member; member."Cheque No.")
            {
            }
            column(ChequeDate_member; member."Cheque Date")
            {
            }
            column(AccruedInterest_member; member."Accrued Interest")
            {
            }
            column(DefaultedLoansRecovered_member; member."Defaulted Loans Recovered")
            {
            }
            column(WithdrawalPosted_member; member."Withdrawal Posted")
            {
            }
            column(LoanNoFilter_member; member."Loan No. Filter")
            {
            }
            column(CurrectFileLocation_member; member."Currect File Location")
            {
            }
            column(MoveTo1_member; member."Move To1")
            {
            }
            column(FileMovementRemarks_member; member."File Movement Remarks")
            {
            }
            column(StatusChangeDate_member; member."Status Change Date")
            {
            }
            column(LastPaymentDate_member; member."Last Payment Date")
            {
            }
            column(DiscountedAmount_member; member."Discounted Amount")
            {
            }
            column(CurrentSavings_member; member."Current Savings")
            {
            }
            column(PayrollUpdated_member; member."Payroll Updated")
            {
            }
            column(LastMarkingDate_member; member."Last Marking Date")
            {
            }
            column(DividendsCapitalised_member; member."Dividends Capitalised %")
            {
            }
            column(FOSAOutstandingBalance_member; member."FOSA Outstanding Balance")
            {
            }
            column(FOSAOustandingInterest_member; member."FOSA Oustanding Interest")
            {
            }
            column(FormationProvince_member; member."Formation/Province")
            {
            }
            column(DivisionDepartment_member; member."Division/Department")
            {
            }
            column(StationSection_member; member."Station/Section")
            {
            }
            column(ClosingDepositBalance_member; member."Closing Deposit Balance")
            {
            }
            column(ClosingLoanBalance_member; member."Closing Loan Balance")
            {
            }
            column(ClosingInsuranceBalance_member; member."Closing Insurance Balance")
            {
            }
            column(DividendProgression_member; member."Dividend Progression")
            {
            }
            column(ClosingDate_member; member."Closing Date")
            {
            }
            column(WelfareFund_member; member."Welfare Fund")
            {
            }
            column(DiscountedDividends_member; member."Discounted Dividends")
            {
            }
            column(ModeofDividendPayment_member; member."Mode of Dividend Payment")
            {
            }
            column(QualifyingShares_member; member."Qualifying Shares")
            {
            }
            column(DefaulterOverideReasons_member; member."Defaulter Overide Reasons")
            {
            }
            column(DefaulterOveride_member; member."Defaulter Overide")
            {
            }
            column(ClosureRemarks_member; member."Closure Remarks")
            {
            }
            column(BankAccountNo_member; member."Bank Account No.")
            {
            }
            column(BankCode_member; member."Bank Code")
            {
            }
            column(DividendProcessed_member; member."Dividend Processed")
            {
            }
            column(DividendError_member; member."Dividend Error")
            {
            }
            column(DividendCapitalized_member; member."Dividend Capitalized")
            {
            }
            column(DividendPaidFOSA_member; member."Dividend Paid FOSA")
            {
            }
            column(DividendPaidEFT_member; member."Dividend Paid EFT")
            {
            }
            column(DividendWithholdingTax_member; member."Dividend Withholding Tax")
            {
            }
            column(LoanLastPaymentDate_member; member."Loan Last Payment Date")
            {
            }
            column(OutstandingInterest_member; member."Outstanding Interest")
            {
            }
            column(LastTransactionDate_member; member."Last Transaction Date")
            {
            }
            column(AccountCategory_member; member."Account Category")
            {
            }
            column(TypeOfOrganisation_member; member."Type Of Organisation")
            {
            }
            column(SourceOfFunds_member; member."Source Of Funds")
            {
            }
            column(MPESAMobileNo_member; member."MPESA Mobile No")
            {
            }
            column(ForceNo_member; member."Force No.")
            {
            }
            column(LastAdviceDate_member; member."Last Advice Date")
            {
            }
            column(AdviceType_member; member."Advice Type")
            {
            }
            column(ShareBalanceBF_member; member."Share Balance BF")
            {
            }
            column(Moveto_member; member."Move to")
            {
            }
            column(FileMovementRemarks1_member; member."File Movement Remarks1")
            {
            }
            column(FileMVTUserID_member; member."File MVT User ID")
            {
            }
            column(FileMVTTime_member; member."File MVT Time")
            {
            }
            column(FilePreviousLocation_member; member."File Previous Location")
            {
            }
            column(FileMVTDate_member; member."File MVT Date")
            {
            }
            column(filereceiveddate_member; member."file received date")
            {
            }
            column(FilereceivedTime_member; member."File received Time")
            {
            }
            column(FileReceivedby_member; member."File Received by")
            {
            }
            column(fileReceived_member; member."file Received")
            {
            }
            column(User_member; member.User)
            {
            }
            column(ChangeLog_member; member."Change Log")
            {
            }
            column(Section_member; member.Section)
            {
            }
            column(rejoined_member; member.rejoined)
            {
            }
            column(Jobtitle_member; member."Job title")
            {
            }
            column(Pin_member; member.Pin)
            {
            }
            column(Remitancemode_member; member."Remitance mode")
            {
            }
            column(TermsofService_member; member."Terms of Service")
            {
            }
            column(Comment1_member; member.Comment1)
            {
            }
            column(Comment2_member; member.Comment2)
            {
            }
            column(Currentfilelocation_member; member."Current file location")
            {
            }
            column(WorkProvince_member; member."Work Province")
            {
            }
            column(WorkDistrict_member; member."Work District")
            {
            }
            column(SaccoBranch_member; member."Bank Name")
            {
            }
            column(BankBranchCode_member; member."Bank Branch")
            {
            }
            column(CustomerPaypoint_member; member."Customer Paypoint")
            {
            }
            column(DateFileOpened_member; member."Date File Opened")
            {
            }
            column(FileStatus_member; member."File Status")
            {
            }
            column(CustomerTitle_member; member."Customer Title")
            {
            }
            column(FolioNumber_member; member."Folio Number")
            {
            }
            column(Movetodescription_member; member."Move to description")
            {
            }
            column(Filelocc_member; member.Filelocc)
            {
            }
            column(SCardNo_member; member."S Card No.")
            {
            }
            column(Reasonforfileoverstay_member; member."Reason for file overstay")
            {
            }
            column(LocDescription_member; member."Loc Description")
            {
            }
            column(CurrentBalance_member; member."Current Balance")
            {
            }
            column(MemberTransferDate_member; member."Member Transfer Date")
            {
            }
            column(ContactPerson_member; member."Contact Person")
            {
            }
            column(MemberwithdrawableDeposits_member; member."Member withdrawable Deposits")
            {
            }
            column(CurrentLocation_member; member."Current Location")
            {
            }
            column(GroupCode_member; member."Group Code")
            {
            }
            column(XmasContribution_member; member."Holiday Savers")
            {
            }
            column(BenevolentFund_member; member."Benevolent Fund")
            {
            }
            column(OfficeBranch_member; member."Office Branch")
            {
            }
            column(Department_member; member.Department)
            {
            }
            column(Occupation_member; member.Occupation)
            {
            }
            column(Designation_member; member.Designation)
            {
            }
            column(VillageResidence_member; member."Village/Residence")
            {
            }
            column(IncompleteShares_member; member."Incomplete Shares")
            {
            }
            column(ContactPersonPhone_member; member."Contact Person Phone")
            {
            }
            column(DevelopmentShares_member; member."Development Shares")
            {
            }
            column(CooperativeShares_member; member."Fanikisha savings")
            {
            }
            column(OldFosaAccount_member; member."Old Fosa Account")
            {
            }
            column(RecruitedBy_member; member."Recruited By")
            {
            }
            column(ContactPersonRelation_member; member."ContactPerson Relation")
            {
            }
            column(ContactPersonOccupation_member; member."ContactPerson Occupation")
            {
            }
            column(MemberNo2_member; member."Member No. 2")
            {
            }
            column(JujaHousing_member; member.Juja)
            {
            }
            column(KonzaHousing_member; member."Junior Savings")
            {
            }
            column(LukenyaHousing_member; member."Gpange Savings")
            {
            }
            column(InsuranceonShares_member; member."Insurance on Shares")
            {
            }
            column(PhysicalStates_member; member."Physical States")
            {
            }
            column(DIOCESE_member; member.DIOCESE)
            {
            }
            column(MobileNo2_member; member."Mobile No. 2")
            {
            }
            column(EmployerName_member; member."Employer Name")
            {
            }
            column(Title_member; member.Title)
            {
            }
            column(Town_member; member.Town)
            {
            }
            column(HomeTown_member; member."Home Town")
            {
            }
            column(LoansDefaulterStatus_member; member."Loans Defaulter Status")
            {
            }
            column(HomePostalCode_member; member."Home Postal Code")
            {
            }
            column(TotalLoansOutstanding_member; member."Total Loans Outstanding")
            {
            }
            column(NoofLoansGuaranteed_member; member."No of Loans Guaranteed")
            {
            }
            column(MemberFound_member; member."Member Found")
            {
            }
            column(HousingTitle_member; member."Housing Title")
            {
            }
            column(HousingWater_member; member."Housing Water")
            {
            }
            column(HousingMain_member; member."Housing Main")
            {
            }
            column(MemberCanGuaranteeLoan_member; member."Member Can Guarantee  Loan")
            {
            }
            column(FOSAAccountBal_member; member."FOSA  Account Bal")
            {
            }
            column(RejoiningDate_member; member."Rejoining Date")
            {
            }
            column(ActiveLoansGuarantor_member; member."Active Loans Guarantor")
            {
            }
            column(LoansGuaranteed_member; member."Loans Guaranteed")
            {
            }
            column(MemberDeposit3_member; member."Member Deposit *3")
            {
            }
            column(NewloanEligibility_member; member."New loan Eligibility")
            {
            }
            column(ASAT; ASAT)
            {
            }

            trigger OnAfterGetRecord()
            begin
                DFilter := '01/01/05..' + Format(ASAT);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("As at"; ASAT)
                {
                    ApplicationArea = Basic;
                    Caption = 'As at';
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
        Loans_RegisterCaptionLbl: label 'Loans Register';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Client_No_CaptionLbl: label 'Client No.';
        Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
        PeriodCaptionLbl: label 'Period';
        Approved_DateCaptionLbl: label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';
        Verified_By__________________________________________________CaptionLbl: label 'Verified By..................................................';
        Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................................................';
        Sign________________________CaptionLbl: label 'Sign........................';
        Sign________________________Caption_Control1102755003Lbl: label 'Sign........................';
        Date________________________CaptionLbl: label 'Date........................';
        Date________________________Caption_Control1102755005Lbl: label 'Date........................';
        NameCreditOff: label 'Name..............................................';
        NameCreditDate: label 'Date...............................................';
        NameCreditSign: label 'Signature.........................................';
        NameCreditMNG: label 'Name..............................................';
        NameCreditMNGDate: label 'Date...............................................';
        NameCreditMNGSign: label 'Signature...........................................';
        NameCEO: label 'Name................................................';
        NameCEOSign: label 'Signature...........................................';
        NameCEODate: label 'Date.................................................';
        CreditCom1: label 'Name................................................';
        CreditCom1Sign: label 'Signature...........................................';
        CreditCom1Date: label 'Date.................................................';
        CreditCom2: label 'Name................................................';
        CreditCom2Sign: label 'Signature...........................................';
        CreditCom2Date: label 'Date.................................................';
        CreditCom3: label 'Name................................................';
        CreditComDate3: label 'Date..................................................';
        CreditComSign3: label 'Signature............................................';
        From: Date;
        "To": Integer;
        DFilter: Text;
        ASAT: Date;
}

