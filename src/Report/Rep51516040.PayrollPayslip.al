report 51516040 "Payroll Payslip"
{
    ApplicationArea = All;
    Caption = 'Payroll Payslip';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PayrollPayslip.rdlc';

    dataset
    {
        dataitem("Payroll Employee"; "Payroll Employee")
        {
            DataItemTableView = sorting("No.") order(ascending);
            RequestFilterFields = "Period Filter";
            column(ReportForNavId_8631; 8631)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(HR_Employee_No_; "Payroll Employee"."No.")
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            dataitem("Payroll Monthly Transactions"; "Payroll Monthly Transactions")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = order(ascending);
                RequestFilterFields = "No.", "Period Filter";
                column(ReportForNavId_6207; 6207)
                {
                }
                column(Trans_1__1_; Trans[1] [1])
                {
                }
                column(TransAmt_1__1_; TransAmt[1] [1])
                {
                }
                column(TransBal_1__1_; TransBal[1] [1])
                {
                }
                column(TransBal_1__2_; TransBal[1] [2])
                {
                }
                column(TransAmt_1__2_; TransAmt[1] [2])
                {
                }
                column(Trans_1__2_; Trans[1] [2])
                {
                }
                column(TransBal_1__3_; TransBal[1] [3])
                {
                }
                column(TransAmt_1__3_; TransAmt[1] [3])
                {
                }
                column(Trans_1__3_; Trans[1] [3])
                {
                }
                column(TransBal_1__4_; TransBal[1] [4])
                {
                }
                column(TransBal_1__5_; TransBal[1] [5])
                {
                }
                column(TransBal_1__6_; TransBal[1] [6])
                {
                }
                column(TransAmt_1__4_; TransAmt[1] [4])
                {
                }
                column(TransAmt_1__5_; TransAmt[1] [5])
                {
                }
                column(TransAmt_1__6_; TransAmt[1] [6])
                {
                }
                column(Trans_1__4_; Trans[1] [4])
                {
                }
                column(Trans_1__5_; Trans[1] [5])
                {
                }
                column(Trans_1__6_; Trans[1] [6])
                {
                }
                column(TransBal_1__7_; TransBal[1] [7])
                {
                }
                column(TransBal_1__8_; TransBal[1] [8])
                {
                }
                column(TransBal_1__9_; TransBal[1] [9])
                {
                }
                column(TransAmt_1__7_; TransAmt[1] [7])
                {
                }
                column(TransAmt_1__8_; TransAmt[1] [8])
                {
                }
                column(TransAmt_1__9_; TransAmt[1] [9])
                {
                }
                column(Trans_1__7_; Trans[1] [7])
                {
                }
                column(Trans_1__8_; Trans[1] [8])
                {
                }
                column(Trans_1__9_; Trans[1] [9])
                {
                }
                column(TransBal_1__10_; TransBal[1] [10])
                {
                }
                column(TransBal_1__12_; TransBal[1] [12])
                {
                }
                column(TransBal_1__13_; TransBal[1] [13])
                {
                }
                column(TransAmt_1__10_; TransAmt[1] [10])
                {
                }
                column(TransAmt_1__12_; TransAmt[1] [12])
                {
                }
                column(TransAmt_1__13_; TransAmt[1] [13])
                {
                }
                column(Trans_1__10_; Trans[1] [10])
                {
                }
                column(Trans_1__12_; Trans[1] [12])
                {
                }
                column(Trans_1__13_; Trans[1] [13])
                {
                }
                column(TransBal_1__14_; TransBal[1] [14])
                {
                }
                column(TransBal_1__15_; TransBal[1] [15])
                {
                }
                column(TransBal_1__16_; TransBal[1] [16])
                {
                }
                column(TransBal_1__17_; TransBal[1] [17])
                {
                }
                column(TransBal_1__18_; TransBal[1] [18])
                {
                }
                column(TransBal_1__19_; TransBal[1] [19])
                {
                }
                column(TransBal_1__11_; TransBal[1] [11])
                {
                }
                column(TransBal_1__20_; TransBal[1] [20])
                {
                }
                column(TransAmt_1__14_; TransAmt[1] [14])
                {
                }
                column(TransAmt_1__15_; TransAmt[1] [15])
                {
                }
                column(TransAmt_1__16_; TransAmt[1] [16])
                {
                }
                column(TransAmt_1__17_; TransAmt[1] [17])
                {
                }
                column(TransAmt_1__18_; TransAmt[1] [18])
                {
                }
                column(TransAmt_1__19_; TransAmt[1] [19])
                {
                }
                column(TransAmt_1__11_; TransAmt[1] [11])
                {
                }
                column(TransAmt_1__20_; TransAmt[1] [20])
                {
                }
                column(Trans_1__14_; Trans[1] [14])
                {
                }
                column(Trans_1__15_; Trans[1] [15])
                {
                }
                column(Trans_1__16_; Trans[1] [16])
                {
                }
                column(Trans_1__17_; Trans[1] [17])
                {
                }
                column(Trans_1__18_; Trans[1] [18])
                {
                }
                column(Trans_1__19_; Trans[1] [19])
                {
                }
                column(Trans_1__11_; Trans[1] [11])
                {
                }
                column(Trans_1__20_; Trans[1] [20])
                {
                }
                column(Addr_1__1_; Addr[1] [1])
                {
                }
                column(Addr_1__2_; Addr[1] [2])
                {
                }
                column(Addr_1__3_; Addr[1] [3])
                {
                }
                column(Addr_1__4_; Addr[1] [4])
                {
                }
                column(Addr_1__5_; Addr[1] [5])
                {
                }
                column(TransBal_1__21_; TransBal[1] [21])
                {
                }
                column(TransBal_1__22_; TransBal[1] [22])
                {
                }
                column(TransAmt_1__21_; TransAmt[1] [21])
                {
                }
                column(TransAmt_1__22_; TransAmt[1] [22])
                {
                }
                column(TransBal_1__23_; TransBal[1] [23])
                {
                }
                column(TransAmt_1__23_; TransAmt[1] [23])
                {
                }
                column(TransBal_1__24_; TransBal[1] [24])
                {
                }
                column(TransAmt_1__24_; TransAmt[1] [24])
                {
                }
                column(Trans_1__21_; Trans[1] [21])
                {
                }
                column(Trans_1__23_; Trans[1] [23])
                {
                }
                column(Trans_1__24_; Trans[1] [24])
                {
                }
                column(Trans_1__22_; Trans[1] [22])
                {
                }
                column(TransBal_1__25_; TransBal[1] [25])
                {
                }
                column(TransAmt_1__25_; TransAmt[1] [25])
                {
                }
                column(Trans_1__25_; Trans[1] [25])
                {
                }
                column(TransBal_1__26_; TransBal[1] [26])
                {
                }
                column(TransAmt_1__26_; TransAmt[1] [26])
                {
                }
                column(Trans_1__26_; Trans[1] [26])
                {
                }
                column(TransBal_1__27_; TransBal[1] [27])
                {
                }
                column(TransAmt_1__27_; TransAmt[1] [27])
                {
                }
                column(Trans_1__27_; Trans[1] [27])
                {
                }
                column(TransBal_1__28_; TransBal[1] [28])
                {
                }
                column(TransAmt_1__28_; TransAmt[1] [28])
                {
                }
                column(Trans_1__28_; Trans[1] [28])
                {
                }
                column(TransBal_1__29_; TransBal[1] [29])
                {
                }
                column(TransAmt_1__29_; TransAmt[1] [29])
                {
                }
                column(Trans_1__29_; Trans[1] [29])
                {
                }
                column(TransBal_1__30_; TransBal[1] [30])
                {
                }
                column(TransAmt_1__30_; TransAmt[1] [30])
                {
                }
                column(Trans_1__30_; Trans[1] [30])
                {
                }
                column(TransBal_1__31_; TransBal[1] [31])
                {
                }
                column(TransAmt_1__31_; TransAmt[1] [31])
                {
                }
                column(Trans_1__31_; Trans[1] [31])
                {
                }
                column(TransBal_1__32_; TransBal[1] [32])
                {
                }
                column(TransBal_1__33_; TransBal[1] [33])
                {
                }
                column(TransBal_1__34_; TransBal[1] [34])
                {
                }
                column(TransBal_1__35_; TransBal[1] [35])
                {
                }
                column(TransBal_1__36_; TransBal[1] [36])
                {
                }
                column(TransBal_1__37_; TransBal[1] [37])
                {
                }
                column(TransBal_1__38_; TransBal[1] [38])
                {
                }
                column(TransBal_1__39_; TransBal[1] [39])
                {
                }
                column(TransBal_1__40_; TransBal[1] [40])
                {
                }
                column(TransAmt_1__32_; TransAmt[1] [32])
                {
                }
                column(TransAmt_1__33_; TransAmt[1] [33])
                {
                }
                column(TransAmt_1__34_; TransAmt[1] [34])
                {
                }
                column(TransAmt_1__35_; TransAmt[1] [35])
                {
                }
                column(TransAmt_1__36_; TransAmt[1] [36])
                {
                }
                column(TransAmt_1__37_; TransAmt[1] [37])
                {
                }
                column(TransAmt_1__38_; TransAmt[1] [38])
                {
                }
                column(TransAmt_1__39_; TransAmt[1] [39])
                {
                }
                column(TransAmt_1__40_; TransAmt[1] [40])
                {
                }
                column(Trans_1__32_; Trans[1] [32])
                {
                }
                column(Trans_1__34_; Trans[1] [34])
                {
                }
                column(Trans_1__35_; Trans[1] [35])
                {
                }
                column(Trans_1__33_; Trans[1] [33])
                {
                }
                column(Trans_1__36_; Trans[1] [36])
                {
                }
                column(Trans_1__37_; Trans[1] [37])
                {
                }
                column(Trans_1__38_; Trans[1] [38])
                {
                }
                column(Trans_1__39_; Trans[1] [39])
                {
                }
                column(Trans_1__40_; Trans[1] [40])
                {
                }
                column(Trans_1__45_; Trans[1] [45])
                {
                }
                column(TransAmt_1__45_; TransAmt[1] [45])
                {
                }
                column(TransAmt_1__46_; TransAmt[1] [46])
                {
                }
                column(TransAmt_1__47_; TransAmt[1] [47])
                {
                }
                column(TransAmt_1__48_; TransAmt[1] [48])
                {
                }
                column(TransAmt_1__49_; TransAmt[1] [49])
                {
                }
                column(Trans_1__46_; Trans[1] [46])
                {
                }
                column(Trans_1__47_; Trans[1] [47])
                {
                }
                column(Trans_1__48_; Trans[1] [48])
                {
                }
                column(Trans_1__49_; Trans[1] [49])
                {
                }
                column(TransAmt_1__50_; TransAmt[1] [50])
                {
                }
                column(TransAmt_1__51_; TransAmt[1] [51])
                {
                }
                column(Trans_1__50_; Trans[1] [50])
                {
                }
                column(Trans_1__51_; Trans[1] [51])
                {
                }
                column(TransBal_1__42_; TransBal[1] [42])
                {
                }
                column(TransAmt_1__42_; TransAmt[1] [42])
                {
                }
                column(Trans_1__42_; Trans[1] [42])
                {
                }
                column(TransBal_1__43_; TransBal[1] [43])
                {
                }
                column(TransAmt_1__43_; TransAmt[1] [43])
                {
                }
                column(Trans_1__43_; Trans[1] [43])
                {
                }
                column(TransBal_1__44_; TransBal[1] [44])
                {
                }
                column(TransAmt_1__44_; TransAmt[1] [44])
                {
                }
                column(Trans_1__44_; Trans[1] [44])
                {
                }
                column(Trans_1__41_; Trans[1] [41])
                {
                }
                column(TransAmt_1__41_; TransAmt[1] [41])
                {
                }
                column(TransBal_1__41_; TransBal[1] [41])
                {
                }
                column(TransAmt_1__52_; TransAmt[1] [52])
                {
                }
                column(Trans_1__52_; Trans[1] [52])
                {
                }
                column(Employee_Caption; Employee_CaptionLbl)
                {
                }
                column(EmptyStringCaption_Control1102755067; EmptyStringCaption_Control1102755067Lbl)
                {
                }
                column(Department_Caption; Department_CaptionLbl)
                {
                }
                column(Period_Caption; Period_CaptionLbl)
                {
                }
                column(P_I_N_No_Caption; P_I_N_No_CaptionLbl)
                {
                }
                column(BALANCECaption; BALANCECaptionLbl)
                {
                }
                column(AMOUNTCaption; AMOUNTCaptionLbl)
                {
                }
                column(prSalary_Card_Employee_Code; "Payroll Employee"."No.")
                {
                }
                column(name; CompInfo.Name)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    strNssfNo := '. ';
                    strNhifNo := '. ';
                    strBank := '. ';
                    strBranch := '. ';
                    strAccountNo := '. ';
                    strPin := '. ';

                    RecordNo := RecordNo + 1;
                    ColumnNo := ColumnNo + 1;

                    //Get the staff details (header)
                    objEmp.SetRange(objEmp."No.", "Payroll Employee"."No.");
                    if objEmp.Find('-') then begin
                        strEmpName := "Payroll Employee"."No.";
                        EmpName := objEmp."Full Name";
                        strPin := objEmp."PIN No";
                        dtDOE := objEmp."Joining Date";
                        STATUS := Format(objEmp.Status);
                        // Get Dept Description
                        Dimm.Reset;
                        Dimm.SetRange(Dimm."Dimension Code", 'DEPARTMENT');
                        Dimm.SetRange(Dimm.Code, dept);
                        if Dimm.Find('-') then
                            dept := Dimm.Name;

                        strNssfNo := objEmp."NSSF No";
                        strNhifNo := objEmp."NHIF No";
                        strPin := objEmp."PIN No";


                    end;


                    /*If the Employee's Pay is suspended, OR  the guy is active DO NOT execute the following code
                    *****************************************************************************************************/
                    if (objEmp."Suspend Pay" = false) then begin
                        strEmpCode := "Payroll Employee"."No.";
                    end;
                    /******************************************************************************************************/

                    //Clear headers
                    Addr[ColumnNo] [1] := '';
                    Addr[ColumnNo] [2] := '';
                    Addr[ColumnNo] [3] := '';
                    Addr[ColumnNo] [4] := '';
                    Addr[ColumnNo] [5] := '';
                    //Clear previous Transaction entries 53
                    for intRow := 1 to 53 do begin
                        Trans[ColumnNo, intRow] := '';
                        TransAmt[ColumnNo, intRow] := '';
                        TransBal[ColumnNo, intRow] := '';
                    end;

                    //Loop through the transactions
                    PeriodTrans.Reset;
                    PeriodTrans.SetRange(PeriodTrans."No.", "Payroll Employee"."No.");
                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                    PeriodTrans.SetRange(PeriodTrans."Company Deduction", false);         // to filter our company deductions

                    PeriodTrans.SetCurrentkey(PeriodTrans."No.", PeriodTrans."Period Month", PeriodTrans."Period Year",
                    PeriodTrans.Grouping, PeriodTrans.SubGrouping);


                    Addr[ColumnNo] [1] := Format(strEmpName);
                    Addr[ColumnNo] [2] := dept; //Depart
                    Addr[ColumnNo] [3] := PeriodName; //Period
                    Addr[ColumnNo] [4] := strPin; //Pin
                    Addr[ColumnNo] [5] := EmpName;
                    Index := 1;
                    strGrpText := '';
                    if PeriodTrans.Find('-') then
                        repeat
                            //Check if the group has changed
                            if strGrpText <> PeriodTrans."Group Text" then begin
                                if PeriodTrans.Grouping <> 1 then begin
                                    Index := Index + 1;
                                    Trans[ColumnNo, Index] := '......................................';
                                    TransAmt[ColumnNo, Index] := '......................................';
                                    TransBal[ColumnNo, Index] := '......................................';
                                end;

                                Index := Index + 1;
                                strGrpText := PeriodTrans."Group Text";
                                Trans[ColumnNo, Index] := strGrpText;
                                TransAmt[ColumnNo, Index] := '';
                                TransBal[ColumnNo, Index] := '';

                                // IF PeriodTrans.Amount>0 THEN
                                // BEGIN
                                Index := Index + 1;
                                Trans[ColumnNo, Index] := PeriodTrans."Transaction Name";
                                Evaluate(TransAmt[ColumnNo, Index], Format(PeriodTrans.Amount));

                                if PeriodTrans.Balance = 0 then
                                    Evaluate(TransBal[ColumnNo, Index], Format('                           '))
                                else
                                    Evaluate(TransBal[ColumnNo, Index], Format(PeriodTrans.Balance));
                                // END;

                            end else begin
                                //  IF PeriodTrans.Amount>0 THEN
                                //  BEGIN
                                Index := Index + 1;
                                strGrpText := PeriodTrans."Group Text";
                                Trans[ColumnNo, Index] := PeriodTrans."Transaction Name";
                                Evaluate(TransAmt[ColumnNo, Index], Format(PeriodTrans.Amount));

                                if PeriodTrans.Balance = 0 then
                                    Evaluate(TransBal[ColumnNo, Index], Format('                           '))
                                else
                                    Evaluate(TransBal[ColumnNo, Index], Format(PeriodTrans.Balance));
                                //  END;
                            end;
                        until PeriodTrans.Next = 0;

                    /*Fill-in the other staff information
                    *******************************************************************************/
                    Index += 1;
                    Trans[ColumnNo, Index] := '......................................';
                    Evaluate(TransAmt[ColumnNo, Index], '......................................');

                    Index += 1;
                    Trans[ColumnNo, Index] := 'Staff Information:';
                    Evaluate(TransAmt[ColumnNo, Index], '.');

                    //N.S.S.F No:
                    Index += 1;
                    Trans[ColumnNo, Index] := 'N.S.S.F No:';
                    Evaluate(TransAmt[ColumnNo, Index], Format(strNssfNo));

                    //N.H.I.F No:
                    Index += 1;
                    Trans[ColumnNo, Index] := 'N.H.I.F No:';
                    Evaluate(TransAmt[ColumnNo, Index], Format(strNhifNo));

                    
                    Index += 1;
                    Trans[ColumnNo, Index] := 'PIN No';
                    Evaluate(TransAmt[ColumnNo, Index], Format(strPin));
                    Index += 1;
                    Trans[ColumnNo, Index] := '......................................';
                    Evaluate(TransAmt[ColumnNo, Index], '......................................');

                    

                    if (RecordNo = NoOfRecords) and (ColumnNo < 3) then begin
                        for i := ColumnNo + 1 to NoOfColumns do begin
                            Clear(Addr[i]);
                            Clear(Trans[i]);
                            Clear(TransAmt[i]);
                            Clear(TransBal[i]);
                        end;
                        ColumnNo := 0;

                    end else begin
                        if ColumnNo = NoOfColumns then
                            ColumnNo := 0;
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    NoOfRecords := Count;
                    NoOfColumns := 1;
                   

                    strNssfNo := '.';
                    strNhifNo := '.';
                    strBank := '.';
                    strBranch := '.';
                    strAccountNo := '.';

                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);

                //IF PeriodFilter=0D THEN ERROR('You must specify the period filter');
                //SelectedPeriod:=PeriodFilter;
                objPeriod.Reset;
                if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
                objEmp.Reset;
                if objEmp.Find('-') then begin
                    repeat
                        objEmp."Period Filter" := SelectedPeriod;
                        objEmp.Modify;
                    until objEmp.Next = 0;
                end
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(PeriodFilter; PeriodFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Period';
                    TableRelation = "Payroll Calender"."Date Opened";
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

    trigger OnPreReport()
    begin
        /*PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
        IF PeriodFilter='' THEN ERROR('You must specify the period filter');
        */

        SelectedPeriod := "Payroll Employee".GetRangeMin("Payroll Employee"."Period Filter");


        //SelectedPeriod:="prSalary Card".GETRANGEMIN("Period Filter");
        /*PrPeriods.RESET;
        PrPeriods.SETRANGE(PrPeriods.Closed,FALSE);
        IF PrPeriods.FIND('-') THEN
        SelectedPeriod:=PrPeriods."Date Opened";
        */


        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";

        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);

    end;

    var
        PeriodFilter: Date;
        PrPeriods: Record "Payroll Calender";
        CompInfo: Record "Company Information";
        Addr: array[2, 10] of Text[250];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        intInfo: Integer;
        i: Integer;
        PeriodTrans: Record "Payroll Monthly Transactions";
        intRow: Integer;
        Index: Integer;
        objEmp: Record "Payroll Employee";
        strEmpName: Text[250];
        strPin: Text[30];
        Trans: array[2, 60] of Text[250];
        TransAmt: array[2, 60] of Text[250];
        TransBal: array[2, 60] of Text[250];
        strGrpText: Text[100];
        strNssfNo: Text[30];
        strNhifNo: Text[30];
        strBank: Text[100];
        strBranch: Text[100];
        strAccountNo: Text[100];
        strMessage: Text[100];
        PeriodName: Text[30];
        SelectedPeriod: Date;
        objPeriod: Record "Payroll Calender";
        dtDOE: Date;
        strEmpCode: Text[30];
        STATUS: Text[30];
        dtOfLeaving: Date;
        "Served Notice Period": Boolean;
        dept: Text[100];
        strBankno: Text[30];
        strBranchno: Text[30];
        CompanyInfo: Record "Company Information";
        objOcx: Codeunit "Payroll Management";
        Dimm: Record "Dimension Value";
        EmptyStringCaptionLbl: label '......................................................................................................................................................................................................';
        Employee_CaptionLbl: label 'Employee:';
        EmptyStringCaption_Control1102755067Lbl: label '.....................................................................................................................................................................................................';
        Department_CaptionLbl: label 'Department:';
        Period_CaptionLbl: label 'Period:';
        P_I_N_No_CaptionLbl: label 'P.I.N No:';
        BALANCECaptionLbl: label 'BALANCE';
        AMOUNTCaptionLbl: label 'AMOUNT';
        EmpName: Text[100];
        info: Record "Company Information";
        EmployeeCode: Code[100];
}