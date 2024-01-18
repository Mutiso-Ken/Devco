// Report 51516474 "Company Payroll Summary"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/CompanyPayrollSummary.rdlc';

//     dataset
//     {
//         dataitem("Payroll Calender"; "Payroll Calender")
//         {
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(COMPANYNAME; COMPANYNAME)
//             {
//             }
//             column(COMPANYNAME_Control1102755015; COMPANYNAME)
//             {
//             }
//             column(COMPANYNAME_Control1102756027; COMPANYNAME)
//             {
//             }
//             column(COMPANYNAME_Control1102756028; COMPANYNAME)
//             {
//             }
//             column(CompanyInfo_Picture; CompanyInfo.Picture)
//             {
//             }
//             column(CompanyInfo_Picture_Control1102756014; CompanyInfo.Picture)
//             {
//             }
//             column(Name; CompanyInfo.Name)
//             {
//             }
//             column(PayrollSummary; 'COMPANY PAYROLL SUMMARY')
//             {
//             }
//             column(PeriodNamez; 'PERIOD:  ' + PeriodName)
//             {
//             }
//             column(TransDesc; 'TRANSACTION DESC.')
//             {
//             }
//             column(payments; 'PAYMENTS')
//             {
//             }
//             column(deductions; 'DEDUCTIONS')
//             {
//             }
//             column(kirinyagatitle; COMPANYNAME)
//             {
//             }
//             column(abreviation; 'MUST')
//             {
//             }
//             column(DetDate; DetDate)
//             {
//             }
//             column(GPY; GPY)
//             {
//             }
//             column(NETS; NETS)
//             {
//             }
//             column(STAT; STAT)
//             {
//             }
//             column(DED; DED)
//             {
//             }
//             column(CountBpay; PeriodTrans."Bpay Count")
//             {
//             }
//             column(payTrans_1; PayTrans[1])
//             {
//             }
//             column(payTrans_2; PayTrans[2])
//             {
//             }
//             column(payTrans_3; PayTrans[3])
//             {
//             }
//             column(payTrans_4; PayTrans[4])
//             {
//             }
//             column(payTrans_5; PayTrans[5])
//             {
//             }
//             column(payTrans_6; PayTrans[6])
//             {
//             }
//             column(payTrans_7; PayTrans[7])
//             {
//             }
//             column(payTrans_8; PayTrans[8])
//             {
//             }
//             column(payTrans_9; PayTrans[9])
//             {
//             }
//             column(payTrans_10; PayTrans[10])
//             {
//             }
//             column(payTrans_11; PayTrans[11])
//             {
//             }
//             column(payTrans_12; PayTrans[12])
//             {
//             }
//             column(payTrans_13; PayTrans[13])
//             {
//             }
//             column(payTrans_14; PayTrans[14])
//             {
//             }
//             column(payTrans_15; PayTrans[15])
//             {
//             }
//             column(payTrans_16; PayTrans[16])
//             {
//             }
//             column(payTrans_17; PayTrans[17])
//             {
//             }
//             column(payTrans_18; PayTrans[18])
//             {
//             }
//             column(payTrans_19; PayTrans[19])
//             {
//             }
//             column(payTrans_20; PayTrans[20])
//             {
//             }
//             column(payTrans_21; PayTrans[21])
//             {
//             }
//             column(payTrans_22; PayTrans[22])
//             {
//             }
//             column(payTrans_23; PayTrans[23])
//             {
//             }
//             column(payTrans_24; PayTrans[24])
//             {
//             }
//             column(payTrans_25; PayTrans[25])
//             {
//             }
//             column(payTrans_26; PayTrans[26])
//             {
//             }
//             column(payTrans_27; PayTrans[27])
//             {
//             }
//             column(payTrans_28; PayTrans[28])
//             {
//             }
//             column(payTrans_29; PayTrans[29])
//             {
//             }
//             column(payTrans_30; PayTrans[30])
//             {
//             }
//             column(payTrans_31; PayTrans[31])
//             {
//             }
//             column(payTrans_32; PayTrans[32])
//             {
//             }
//             column(payTrans_33; PayTrans[33])
//             {
//             }
//             column(payTrans_34; PayTrans[34])
//             {
//             }
//             column(payTrans_35; PayTrans[35])
//             {
//             }
//             column(payTrans_36; PayTrans[36])
//             {
//             }
//             column(payTrans_37; PayTrans[37])
//             {
//             }
//             column(payTrans_38; PayTrans[38])
//             {
//             }
//             column(payTrans_39; PayTrans[39])
//             {
//             }
//             column(payTrans_40; PayTrans[40])
//             {
//             }
//             column(payTrans_41; PayTrans[41])
//             {
//             }
//             column(payTrans_42; PayTrans[42])
//             {
//             }
//             column(payTrans_43; PayTrans[43])
//             {
//             }
//             column(payTrans_44; PayTrans[44])
//             {
//             }
//             column(payTrans_45; PayTrans[45])
//             {
//             }
//             column(payTrans_46; PayTrans[46])
//             {
//             }
//             column(payTrans_47; PayTrans[47])
//             {
//             }
//             column(payTrans_48; PayTrans[48])
//             {
//             }
//             column(payTrans_49; PayTrans[49])
//             {
//             }
//             column(payTrans_50; PayTrans[50])
//             {
//             }
//             column(payTrans_51; PayTrans[51])
//             {
//             }
//             column(payTrans_52; PayTrans[52])
//             {
//             }
//             column(payTrans_53; PayTrans[53])
//             {
//             }
//             column(payTrans_54; PayTrans[54])
//             {
//             }
//             column(payTrans_55; PayTrans[55])
//             {
//             }
//             column(payTrans_56; PayTrans[56])
//             {
//             }
//             column(payTrans_57; PayTrans[57])
//             {
//             }
//             column(payTrans_58; PayTrans[58])
//             {
//             }
//             column(payTrans_59; PayTrans[59])
//             {
//             }
//             column(payTrans_60; PayTrans[60])
//             {
//             }
//             column(payTrans_61; PayTrans[61])
//             {
//             }
//             column(payTrans_62; PayTrans[62])
//             {
//             }
//             column(payTrans_63; PayTrans[63])
//             {
//             }
//             column(payTrans_64; PayTrans[64])
//             {
//             }
//             column(payTrans_65; PayTrans[65])
//             {
//             }
//             column(payTrans_66; PayTrans[66])
//             {
//             }
//             column(payTrans_67; PayTrans[67])
//             {
//             }
//             column(payTrans_68; PayTrans[68])
//             {
//             }
//             column(payTrans_69; PayTrans[69])
//             {
//             }
//             column(payTrans_70; PayTrans[70])
//             {
//             }
//             column(PayTransAmt_1; PayTransAmt[1])
//             {
//             }
//             column(PayTransAmt_2; PayTransAmt[2])
//             {
//             }
//             column(PayTransAmt_3; PayTransAmt[3])
//             {
//             }
//             column(PayTransAmt_4; PayTransAmt[4])
//             {
//             }
//             column(PayTransAmt_5; PayTransAmt[5])
//             {
//             }
//             column(PayTransAmt_6; PayTransAmt[6])
//             {
//             }
//             column(PayTransAmt_7; PayTransAmt[7])
//             {
//             }
//             column(PayTransAmt_8; PayTransAmt[8])
//             {
//             }
//             column(PayTransAmt_9; PayTransAmt[9])
//             {
//             }
//             column(PayTransAmt_10; PayTransAmt[10])
//             {
//             }
//             column(PayTransAmt_11; PayTransAmt[11])
//             {
//             }
//             column(PayTransAmt_12; PayTransAmt[12])
//             {
//             }
//             column(PayTransAmt_13; PayTransAmt[13])
//             {
//             }
//             column(PayTransAmt_14; PayTransAmt[14])
//             {
//             }
//             column(PayTransAmt_15; PayTransAmt[15])
//             {
//             }
//             column(PayTransAmt_16; PayTransAmt[16])
//             {
//             }
//             column(PayTransAmt_17; PayTransAmt[17])
//             {
//             }
//             column(PayTransAmt_18; PayTransAmt[18])
//             {
//             }
//             column(PayTransAmt_19; PayTransAmt[19])
//             {
//             }
//             column(PayTransAmt_20; PayTransAmt[20])
//             {
//             }
//             column(PayTransAmt_21; PayTransAmt[21])
//             {
//             }
//             column(PayTransAmt_22; PayTransAmt[22])
//             {
//             }
//             column(PayTransAmt_23; PayTransAmt[23])
//             {
//             }
//             column(PayTransAmt_24; PayTransAmt[24])
//             {
//             }
//             column(PayTransAmt_25; PayTransAmt[25])
//             {
//             }
//             column(PayTransAmt_26; PayTransAmt[26])
//             {
//             }
//             column(PayTransAmt_27; PayTransAmt[27])
//             {
//             }
//             column(PayTransAmt_28; PayTransAmt[28])
//             {
//             }
//             column(PayTransAmt_29; PayTransAmt[29])
//             {
//             }
//             column(PayTransAmt_30; PayTransAmt[30])
//             {
//             }
//             column(PayTransAmt_31; PayTransAmt[31])
//             {
//             }
//             column(PayTransAmt_32; PayTransAmt[32])
//             {
//             }
//             column(PayTransAmt_33; PayTransAmt[33])
//             {
//             }
//             column(PayTransAmt_34; PayTransAmt[34])
//             {
//             }
//             column(PayTransAmt_35; PayTransAmt[35])
//             {
//             }
//             column(PayTransAmt_36; PayTransAmt[36])
//             {
//             }
//             column(PayTransAmt_37; PayTransAmt[37])
//             {
//             }
//             column(PayTransAmt_38; PayTransAmt[38])
//             {
//             }
//             column(PayTransAmt_39; PayTransAmt[39])
//             {
//             }
//             column(PayTransAmt_40; PayTransAmt[40])
//             {
//             }
//             column(PayTransAmt_41; PayTransAmt[41])
//             {
//             }
//             column(PayTransAmt_42; PayTransAmt[42])
//             {
//             }
//             column(PayTransAmt_43; PayTransAmt[43])
//             {
//             }
//             column(PayTransAmt_44; PayTransAmt[44])
//             {
//             }
//             column(PayTransAmt_45; PayTransAmt[45])
//             {
//             }
//             column(PayTransAmt_46; PayTransAmt[46])
//             {
//             }
//             column(PayTransAmt_47; PayTransAmt[47])
//             {
//             }
//             column(PayTransAmt_48; PayTransAmt[48])
//             {
//             }
//             column(PayTransAmt_49; PayTransAmt[49])
//             {
//             }
//             column(PayTransAmt_50; PayTransAmt[50])
//             {
//             }
//             column(PayTransAmt_51; PayTransAmt[51])
//             {
//             }
//             column(PayTransAmt_52; PayTransAmt[52])
//             {
//             }
//             column(PayTransAmt_53; PayTransAmt[53])
//             {
//             }
//             column(PayTransAmt_54; PayTransAmt[54])
//             {
//             }
//             column(PayTransAmt_55; PayTransAmt[55])
//             {
//             }
//             column(PayTransAmt_56; PayTransAmt[56])
//             {
//             }
//             column(PayTransAmt_57; PayTransAmt[57])
//             {
//             }
//             column(PayTransAmt_58; PayTransAmt[58])
//             {
//             }
//             column(PayTransAmt_59; PayTransAmt[59])
//             {
//             }
//             column(PayTransAmt_60; PayTransAmt[60])
//             {
//             }
//             column(PayTransAmt_61; PayTransAmt[61])
//             {
//             }
//             column(PayTransAmt_62; PayTransAmt[62])
//             {
//             }
//             column(PayTransAmt_63; PayTransAmt[63])
//             {
//             }
//             column(PayTransAmt_64; PayTransAmt[64])
//             {
//             }
//             column(PayTransAmt_65; PayTransAmt[65])
//             {
//             }
//             column(PayTransAmt_66; PayTransAmt[66])
//             {
//             }
//             column(PayTransAmt_67; PayTransAmt[67])
//             {
//             }
//             column(PayTransAmt_68; PayTransAmt[68])
//             {
//             }
//             column(PayTransAmt_69; PayTransAmt[69])
//             {
//             }
//             column(PayTransAmt_70; PayTransAmt[70])
//             {
//             }
//             column(DedTrans_1; DedTrans[1])
//             {
//             }
//             column(DedTrans_2; DedTrans[2])
//             {
//             }
//             column(DedTrans_3; DedTrans[3])
//             {
//             }
//             column(DedTrans_4; DedTrans[4])
//             {
//             }
//             column(DedTrans_5; DedTrans[5])
//             {
//             }
//             column(DedTrans_6; DedTrans[6])
//             {
//             }
//             column(DedTrans_7; DedTrans[7])
//             {
//             }
//             column(DedTrans_8; DedTrans[8])
//             {
//             }
//             column(DedTrans_9; DedTrans[9])
//             {
//             }
//             column(DedTrans_10; DedTrans[10])
//             {
//             }
//             column(DedTrans_11; DedTrans[11])
//             {
//             }
//             column(DedTrans_12; DedTrans[12])
//             {
//             }
//             column(DedTrans_13; DedTrans[13])
//             {
//             }
//             column(DedTrans_14; DedTrans[14])
//             {
//             }
//             column(DedTrans_15; DedTrans[15])
//             {
//             }
//             column(DedTrans_16; DedTrans[16])
//             {
//             }
//             column(DedTrans_17; DedTrans[17])
//             {
//             }
//             column(DedTrans_18; DedTrans[18])
//             {
//             }
//             column(DedTrans_19; DedTrans[19])
//             {
//             }
//             column(DedTrans_20; DedTrans[20])
//             {
//             }
//             column(DedTrans_21; DedTrans[21])
//             {
//             }
//             column(DedTrans_22; DedTrans[22])
//             {
//             }
//             column(DedTrans_23; DedTrans[23])
//             {
//             }
//             column(DedTrans_24; DedTrans[24])
//             {
//             }
//             column(DedTrans_25; DedTrans[25])
//             {
//             }
//             column(DedTrans_26; DedTrans[26])
//             {
//             }
//             column(DedTrans_27; DedTrans[27])
//             {
//             }
//             column(DedTrans_28; DedTrans[28])
//             {
//             }
//             column(DedTrans_29; DedTrans[29])
//             {
//             }
//             column(DedTrans_30; DedTrans[30])
//             {
//             }
//             column(DedTrans_31; DedTrans[31])
//             {
//             }
//             column(DedTrans_32; DedTrans[32])
//             {
//             }
//             column(DedTrans_33; DedTrans[33])
//             {
//             }
//             column(DedTrans_34; DedTrans[34])
//             {
//             }
//             column(DedTrans_35; DedTrans[35])
//             {
//             }
//             column(DedTrans_36; DedTrans[36])
//             {
//             }
//             column(DedTrans_37; DedTrans[37])
//             {
//             }
//             column(DedTrans_38; DedTrans[38])
//             {
//             }
//             column(DedTrans_39; DedTrans[39])
//             {
//             }
//             column(DedTrans_40; DedTrans[40])
//             {
//             }
//             column(DedTrans_41; DedTrans[41])
//             {
//             }
//             column(DedTrans_42; DedTrans[42])
//             {
//             }
//             column(DedTrans_43; DedTrans[43])
//             {
//             }
//             column(DedTrans_44; DedTrans[44])
//             {
//             }
//             column(DedTrans_45; DedTrans[45])
//             {
//             }
//             column(DedTrans_46; DedTrans[46])
//             {
//             }
//             column(DedTrans_47; DedTrans[47])
//             {
//             }
//             column(DedTrans_48; DedTrans[48])
//             {
//             }
//             column(DedTrans_49; DedTrans[49])
//             {
//             }
//             column(DedTrans_50; DedTrans[50])
//             {
//             }
//             column(DedTrans_51; DedTrans[51])
//             {
//             }
//             column(DedTrans_52; DedTrans[52])
//             {
//             }
//             column(DedTrans_53; DedTrans[53])
//             {
//             }
//             column(DedTrans_54; DedTrans[54])
//             {
//             }
//             column(DedTrans_55; DedTrans[55])
//             {
//             }
//             column(DedTrans_56; DedTrans[56])
//             {
//             }
//             column(DedTrans_57; DedTrans[57])
//             {
//             }
//             column(DedTrans_58; DedTrans[58])
//             {
//             }
//             column(DedTrans_59; DedTrans[59])
//             {
//             }
//             column(DedTrans_60; DedTrans[60])
//             {
//             }
//             column(DedTrans_61; DedTrans[61])
//             {
//             }
//             column(DedTrans_62; DedTrans[62])
//             {
//             }
//             column(DedTrans_63; DedTrans[63])
//             {
//             }
//             column(DedTrans_64; DedTrans[64])
//             {
//             }
//             column(DedTrans_65; DedTrans[65])
//             {
//             }
//             column(DedTrans_66; DedTrans[66])
//             {
//             }
//             column(DedTrans_67; DedTrans[67])
//             {
//             }
//             column(DedTrans_68; DedTrans[68])
//             {
//             }
//             column(DedTrans_69; DedTrans[69])
//             {
//             }
//             column(DedTrans_70; DedTrans[70])
//             {
//             }
//             column(DedTransAmt_1; DedTransAmt[1])
//             {
//             }
//             column(DedTransAmt_2; DedTransAmt[2])
//             {
//             }
//             column(DedTransAmt_3; DedTransAmt[3])
//             {
//             }
//             column(DedTransAmt_4; DedTransAmt[4])
//             {
//             }
//             column(DedTransAmt_5; DedTransAmt[5])
//             {
//             }
//             column(DedTransAmt_6; DedTransAmt[6])
//             {
//             }
//             column(DedTransAmt_7; DedTransAmt[7])
//             {
//             }
//             column(DedTransAmt_8; DedTransAmt[8])
//             {
//             }
//             column(DedTransAmt_9; DedTransAmt[9])
//             {
//             }
//             column(DedTransAmt_10; DedTransAmt[10])
//             {
//             }
//             column(DedTransAmt_11; DedTransAmt[11])
//             {
//             }
//             column(DedTransAmt_12; DedTransAmt[12])
//             {
//             }
//             column(DedTransAmt_13; DedTransAmt[13])
//             {
//             }
//             column(DedTransAmt_14; DedTransAmt[14])
//             {
//             }
//             column(DedTransAmt_15; DedTransAmt[15])
//             {
//             }
//             column(DedTransAmt_16; DedTransAmt[16])
//             {
//             }
//             column(DedTransAmt_17; DedTransAmt[17])
//             {
//             }
//             column(DedTransAmt_18; DedTransAmt[18])
//             {
//             }
//             column(DedTransAmt_19; DedTransAmt[19])
//             {
//             }
//             column(DedTransAmt_20; DedTransAmt[20])
//             {
//             }
//             column(DedTransAmt_21; DedTransAmt[21])
//             {
//             }
//             column(DedTransAmt_22; DedTransAmt[22])
//             {
//             }
//             column(DedTransAmt_23; DedTransAmt[23])
//             {
//             }
//             column(DedTransAmt_24; DedTransAmt[24])
//             {
//             }
//             column(DedTransAmt_25; DedTransAmt[25])
//             {
//             }
//             column(DedTransAmt_26; DedTransAmt[26])
//             {
//             }
//             column(DedTransAmt_27; DedTransAmt[27])
//             {
//             }
//             column(DedTransAmt_28; DedTransAmt[28])
//             {
//             }
//             column(DedTransAmt_29; DedTransAmt[29])
//             {
//             }
//             column(DedTransAmt_30; DedTransAmt[30])
//             {
//             }
//             column(DedTransAmt_31; DedTransAmt[31])
//             {
//             }
//             column(DedTransAmt_32; DedTransAmt[32])
//             {
//             }
//             column(DedTransAmt_33; DedTransAmt[33])
//             {
//             }
//             column(DedTransAmt_34; DedTransAmt[34])
//             {
//             }
//             column(DedTransAmt_35; DedTransAmt[35])
//             {
//             }
//             column(DedTransAmt_36; DedTransAmt[36])
//             {
//             }
//             column(DedTransAmt_37; DedTransAmt[37])
//             {
//             }
//             column(DedTransAmt_38; DedTransAmt[38])
//             {
//             }
//             column(DedTransAmt_39; DedTransAmt[39])
//             {
//             }
//             column(DedTransAmt_40; DedTransAmt[40])
//             {
//             }
//             column(DedTransAmt_41; DedTransAmt[41])
//             {
//             }
//             column(DedTransAmt_42; DedTransAmt[42])
//             {
//             }
//             column(DedTransAmt_43; DedTransAmt[43])
//             {
//             }
//             column(DedTransAmt_44; DedTransAmt[44])
//             {
//             }
//             column(DedTransAmt_45; DedTransAmt[45])
//             {
//             }
//             column(DedTransAmt_46; DedTransAmt[46])
//             {
//             }
//             column(DedTransAmt_47; DedTransAmt[47])
//             {
//             }
//             column(DedTransAmt_48; DedTransAmt[48])
//             {
//             }
//             column(DedTransAmt_49; DedTransAmt[49])
//             {
//             }
//             column(DedTransAmt_50; DedTransAmt[50])
//             {
//             }
//             column(DedTransAmt_51; DedTransAmt[51])
//             {
//             }
//             column(DedTransAmt_52; DedTransAmt[52])
//             {
//             }
//             column(DedTransAmt_53; DedTransAmt[53])
//             {
//             }
//             column(DedTransAmt_54; DedTransAmt[54])
//             {
//             }
//             column(DedTransAmt_55; DedTransAmt[55])
//             {
//             }
//             column(DedTransAmt_56; DedTransAmt[56])
//             {
//             }
//             column(DedTransAmt_57; DedTransAmt[57])
//             {
//             }
//             column(DedTransAmt_58; DedTransAmt[58])
//             {
//             }
//             column(DedTransAmt_59; DedTransAmt[59])
//             {
//             }
//             column(DedTransAmt_60; DedTransAmt[60])
//             {
//             }
//             column(DedTransAmt_61; DedTransAmt[61])
//             {
//             }
//             column(DedTransAmt_62; DedTransAmt[62])
//             {
//             }
//             column(DedTransAmt_63; DedTransAmt[63])
//             {
//             }
//             column(DedTransAmt_64; DedTransAmt[64])
//             {
//             }
//             column(DedTransAmt_65; DedTransAmt[65])
//             {
//             }
//             column(DedTransAmt_66; DedTransAmt[66])
//             {
//             }
//             column(DedTransAmt_67; DedTransAmt[67])
//             {
//             }
//             column(DedTransAmt_68; DedTransAmt[68])
//             {
//             }
//             column(DedTransAmt_69; DedTransAmt[69])
//             {
//             }
//             column(DedTransAmt_70; DedTransAmt[70])
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin

//                 Clear(rows);
//                 Clear(rows2);
//                 prPeriod_Transactions.Reset;
//                 prPeriod_Transactions.SetRange(prPeriod_Transactions."Payroll Period", SelectedPeriod);
//                 prPeriod_Transactions.SetFilter(prPeriod_Transactions.Grouping, '=1|3|4|7|8|9|11');
//                 prPeriod_Transactions.SetCurrentkey(prPeriod_Transactions."Payroll Period", prPeriod_Transactions.Grouping, prPeriod_Transactions.SubGrouping);
//                 if prPeriod_Transactions.Find('-') then begin
//                     Clear(DetDate);
//                     DetDate := Format("Payroll Calender"."Period Name");
//                     repeat
//                     begin
//                         if prPeriod_Transactions.Amount > 0 then begin
//                             if ((prPeriod_Transactions.Grouping = 4) and (prPeriod_Transactions.SubGrouping = 0)) then
//                                 GPY := GPY + prPeriod_Transactions.Amount;

//                             if ((prPeriod_Transactions.Grouping = 7) and
//                             ((prPeriod_Transactions.SubGrouping = 3) or (prPeriod_Transactions.SubGrouping = 5) or (prPeriod_Transactions.SubGrouping = 1) or
//                              (prPeriod_Transactions.SubGrouping = 2))) then
//                                 STAT := STAT + prPeriod_Transactions.Amount;

//                             if ((prPeriod_Transactions.Grouping = 8) and
//                             ((prPeriod_Transactions.SubGrouping = 1) or (prPeriod_Transactions.SubGrouping = 0))) then
//                                 DED := DED + prPeriod_Transactions.Amount;

//                             if ((prPeriod_Transactions.Grouping = 9) and (prPeriod_Transactions.SubGrouping = 0)) then
//                                 NETS := NETS + prPeriod_Transactions.Amount;

//                             //TotalsAllowances:=TotalsAllowances+"prPeriod Transactions".Amount;
//                             if ((prPeriod_Transactions.Grouping = 1) or
//                             (prPeriod_Transactions.Grouping = 3) or
//                              ((prPeriod_Transactions.Grouping = 4) and (prPeriod_Transactions.SubGrouping <> 0))) then begin // A Payment
//                                 Clear(countz);
//                                 Clear(found);
//                                 repeat
//                                 begin
//                                     countz := countz + 1;
//                                     if (PayTrans[countz]) = prPeriod_Transactions."Transaction Name" then found := true;
//                                 end;
//                                 until ((countz = (ArrayLen(PayTransAmt))) or ((PayTrans[countz]) = prPeriod_Transactions."Transaction Name")
//                                 or ((PayTrans[countz]) = ''));
//                                 rows := countz;
//                                 PayTrans[rows] := prPeriod_Transactions."Transaction Name";
//                                 PayTransAmt[rows] := PayTransAmt[rows] + prPeriod_Transactions.Amount;
//                             end else
//                                 if (((prPeriod_Transactions.Grouping = 7) and ((prPeriod_Transactions.SubGrouping <> 6)
//                        and (prPeriod_Transactions.SubGrouping <> 50))) or
//                        ((prPeriod_Transactions.Grouping = 8) and (prPeriod_Transactions.SubGrouping <> 9))) then begin
//                                     Clear(countz);
//                                     // countz:=1;
//                                     Clear(found);
//                                     // prPeriod_Transactions.setcurrentkey("Transaction Name");
//                                     repeat
//                                     begin
//                                         countz := countz + 1;
//                                         if (DedTrans[countz]) = prPeriod_Transactions."Transaction Name" then found := true;
//                                     end;
//                                     until ((countz = (ArrayLen(DedTransAmt))) or ((DedTrans[countz]) = prPeriod_Transactions."Transaction Name")
//                                     or ((DedTrans[countz]) = ''));
//                                     rows := countz;
//                                     DedTrans[rows] := prPeriod_Transactions."Transaction Name";
//                                     DedTransAmt[rows] := DedTransAmt[rows] + prPeriod_Transactions.Amount;
//                                 end;
//                         end; // If Amount >0;
//                     end;
//                     until prPeriod_Transactions.Next = 0;
//                 end;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 "Payroll Calender".SetFilter("Payroll Calender"."Date Opened", '=%1', SelectedPeriod);
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 field(periodfilter; PeriodFilter)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Period Filter';
//                     TableRelation = "Payroll Calender"."Date Opened";
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnInitReport()
//     begin
//         objPeriod.Reset;
//         objPeriod.SetRange(objPeriod.Closed, false);
//         if objPeriod.Find('-') then;
//         PeriodFilter := objPeriod."Date Opened";
//     end;

//     trigger OnPreReport()
//     begin
//         if UserSetup.Get(UserId) then begin
//             if UserSetup."Payroll User" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
//         end else begin
//             Error('You have been setup in the user setup!');
//         end;

//         SelectedPeriod := PeriodFilter;
//         objPeriod.Reset;
//         objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
//         if objPeriod.Find('-') then begin
//             PeriodName := objPeriod."Period Name";
//         end;


//         if CompanyInfo.Get() then
//             CompanyInfo.CalcFields(CompanyInfo.Picture);
//         Clear(rows);
//         Clear(GPY);
//         Clear(STAT);
//         Clear(DED);
//         Clear(NETS);
//     end;

//     var
//         UserSetup: Record "User Setup";
//         DetDate: Text[100];
//         found: Boolean;
//         countz: Integer;
//         PeriodFilter: Date;
//         LastFieldNo: Integer;
//         FooterPrinted: Boolean;
//         PeriodTrans: Record "Payroll Monthly Transactions";
//         objPeriod: Record "Payroll Calender";
//         SelectedPeriod: Date;
//         PeriodName: Text[30];
//         CompanyInfo: Record "Company Information";
//         TotalsAllowances: Decimal;
//         Dept: Boolean;
//         PaymentDesc: Text[200];
//         DeductionDesc: Text[200];
//         GroupText1: Text[200];
//         GroupText2: Text[200];
//         PaymentAmount: Decimal;
//         DeductAmount: Decimal;
//         PayTrans: array[70] of Text[250];
//         PayTransAmt: array[70] of Decimal;
//         DedTrans: array[70] of Text[250];
//         DedTransAmt: array[70] of Decimal;
//         rows: Integer;
//         rows2: Integer;
//         GPY: Decimal;
//         NETS: Decimal;
//         STAT: Decimal;
//         DED: Decimal;
//         TotalFor: label 'Total for ';
//         GroupOrder: label '3';
//         TransBal: array[2, 60] of Text[250];
//         Addr: array[2, 10] of Text[250];
//         RecordNo: Integer;
//         NoOfColumns: Integer;
//         ColumnNo: Integer;
//         prPeriod_Transactions: Record "Payroll Monthly Transactions";
// }

