// codeunit 51516160 "Portal Integration"
// {
//     trigger OnRun()
//     begin

//     end;

//     procedure FnCheckIfPortalUserExists(var member_no: Code[20]) Response: text;
//     var
//         Members: record Customer;
//     begin
//         Members.Reset();
//         Members.SetRange(Members."No.", member_no);
//         if Members.find('-') = true then begin
//             response := '{' +
//               ' "StatusCode":"00",' +
//               ' "StatusDescription": "Success",' +
//               ' "member_no":"' + Format(Members."No.") + '",' +
//               ' "first_name":"' + Format(Members."First Name") + '",' +
//               ' "last_name":"' + Format(Members."Last Name") + '",' +
//               ' "full_name":"' + Format(Members."Full Name") + '",' +
//               ' "email":"' + Format(Members."E-Mail") + '",' +
//                ' "Narration": "Member Record Found"' +
//               '}';
//             exit;
//         end else
//             if Members.find('-') = false then begin
//                 response := '{' +
//                   ' "StatusCode":"01",' +
//                   ' "StatusDescription": "Failed",' +
//                   ' "member_no":"' + '' + '",' +
//                   ' "first_name":"' + '' + '",' +
//                   ' "last_name":"' + '' + '",' +
//                   ' "full_name":"' + '' + '",' +
//                   ' "email":"' + '' + '",' +
//                    ' "Narration": "Member Record Does Not Exist"' +
//                   '}';
//                 exit;
//             end;
//     end;


//     procedure FnInsertSMS(var Source: Code[50]; var SMSMessage: Text[250]; Var AccountNo: Text[50];var PhoneNo: Text[20]) Response: text;
//     var
//         SystemFactory: Codeunit "SURESTEP Factory";
//         MessageStatus: Boolean;
//     begin
//         MessageStatus := SystemFactory.FnSendSMS(Source, SMSMessage,AccountNo,PhoneNo);
//         if MessageStatus = true then begin
//             response := '{' +
//                    ' "StatusCode":"00",' +
//                    ' "StatusDescription": "Success",' +
//                    '}';
//             exit;
//         end else begin
//             response := '{' +
//                           ' "StatusCode":"01",' +
//                           ' "StatusDescription": "Failed",' +
//                           '}';
//             exit;
//         end;
//     end;

//     procedure FnInsertOTP(var MemberNo: Code[50]; var otp: Code[50]) Response: text;
//     var
//         MessageStatus: Boolean;
//         MemberTable: Record customer;
//     begin
//         MessageStatus := false;
//         MemberTable.Reset();
//         MemberTable.SetRange(MemberTable."No.", MemberNo);
//         if MemberTable.Find('-') then begin
//             MemberTable."Portal OTP" := otp;
//             IF MemberTable.Modify(true) THEN begin
//                 MessageStatus := true;
//             end else
//                 MessageStatus := false;
//         end;
//         if MessageStatus = true then begin
//             response := '{' +
//                    ' "StatusCode":"00",' +
//                    ' "StatusDescription": "Success",' +
//                    '}';
//             exit;
//         end else begin
//             response := '{' +
//                           ' "StatusCode":"01",' +
//                           ' "StatusDescription": "Failed",' +
//                           '}';
//             exit;
//         end;
//     end;

//     procedure FnVerifyOTP(var MemberNo: Code[50]; var otp: Code[50]) Response: text;
//     var
//         MessageStatus: Boolean;
//         MemberTable: Record customer;
//     begin
//         MessageStatus := false;
//         MemberTable.Reset();
//         MemberTable.SetRange(MemberTable."No.", MemberNo);
//         if MemberTable.Find('-') then begin
//             IF MemberTable."Portal OTP" = otp THEN begin
//                 MessageStatus := true;
//             end else
//                 MessageStatus := false;
//         end;
//         if MessageStatus = true then begin
//             response := '{' +
//                             ' "StatusCode":"00",' +
//                             ' "StatusDescription": "Success",' +
//                             ' "member_no":"' + Format(MemberTable."No.") + '",' +
//                             ' "id_no":"' + Format(MemberTable."ID No.") + '"' +
//                         '}';
//             exit;
//         end else begin
//             response := '{' +
//                           ' "StatusCode":"01",' +
//                           ' "StatusDescription": "Failed",' +
//                           ' "member_no":"' + '' + '",' +
//                           ' "id_no":"' + '' + '"' +
//                        '}';
//             exit;
//         end;
//     end;

//     procedure FnActivateAccount(var member_no: Code[50]; var identity_no: Code[50]) Response: text;
//     var
//         Members: record customer;
//     begin
//         Members.Reset();
//         Members.SetRange(Members."No.", member_no);
//         Members.SetRange(Members."ID No.", identity_no);
//         if Members.find('-') = true then begin
//             response := '{' +
//               ' "StatusCode":"00",' +
//               ' "StatusDescription": "Success",' +
//               ' "member_no":"' + Format(Members."No.") + '",' +
//               ' "first_name":"' + Format(Members."First Name") + '",' +
//               ' "last_name":"' + Format(Members."Last Name") + '",' +
//               ' "full_name":"' + Format(Members."Full Name") + '",' +
//               ' "email":"' + Format(Members."E-Mail") + '",' +
//               ' "phone_no":"' + Format(Members."Mobile Phone No.") + '",' +
//                ' "Narration": "Member Record Found"' +
//               '}';
//             exit;
//         end else
//             if Members.find('-') = false then begin
//                 response := '{' +
//                   ' "StatusCode":"01",' +
//                   ' "StatusDescription": "Failed",' +
//                   ' "member_no":"' + '' + '",' +
//                   ' "first_name":"' + '' + '",' +
//                   ' "last_name":"' + '' + '",' +
//                   ' "full_name":"' + '' + '",' +
//                   ' "email":"' + '' + '",' +
//                    ' "Narration": "Member Record Does Not Exist"' +
//                   '}';
//                 exit;
//             end;
//     end;

//     procedure FnGetUserDetails(var member_no: Code[50]) Response: text;
//     var
//         Members: record customer;
//     begin
//         Members.Reset();
//         Members.SetRange(Members."No.", member_no);
//         if Members.find('-') = true then begin
//             response := '{' +
//               ' "StatusCode":"00",' +
//               ' "StatusDescription": "Success",' +
//               ' "member_no":"' + Format(Members."No.") + '",' +
//               ' "first_name":"' + Format(Members.fi) + '",' +
//               ' "last_name":"' + Format(Members."Last Name") + '",' +
//               ' "full_name":"' + Format(LowerCase(Members."Full Name")) + '",' +
//               ' "email":"' + Format(Members."E-Mail") + '",' +
//               ' "phone_no":"' + Format(Members."Mobile Phone No.") + '",' +
//               ' "image":"' + Format(GetMemberImage(Members."No.")) + '",' +
//               ' "accountStatus":"' + Format(Members."Account Status") + '",' +
//                ' "Narration": "Member Record Found"' +
//               '}';
//             exit;
//         end else
//             if Members.find('-') = false then begin
//                 response := '{' +
//                   ' "StatusCode":"01",' +
//                   ' "StatusDescription": "Failed",' +
//                    ' "Narration": "Member Record Does Not Exist"' +
//                   '}';
//                 exit;
//             end;
//     end;

//     local procedure GetMemberImage(MemberNo: code[20]): Text
//     var
//         MemberRecord: record Customer;
//         Base64Convert: Codeunit "Base64 Convert";
//         InstreamPic: InStream;
//         FileName: Text;
//         Base64Format: text;
//         TenantMedia: Record "Tenant Media";
//     begin
//         Base64Format := '';
//         MemberRecord.reset;
//         MemberRecord.SetRange(MemberRecord."No.", MemberNo);
//         if MemberRecord.Find('-') then begin
//             if TenantMedia.Get(MemberRecord.Image.MediaId) then begin
//                 TenantMedia.CalcFields(TenantMedia.Content);
//                 if TenantMedia.Content.HasValue then begin
//                     FileName := '';
//                     FileName := StrSubstNo(MemberRecord."No." + '.png', TenantMedia.TableCaption);
//                     TenantMedia.Content.CreateInStream(InstreamPic, TextEncoding::UTF8);
//                     Base64Format := Base64Convert.ToBase64(InstreamPic, false);
//                 end;
//             end;
//         end;
//         exit(Base64Format);
//     end;

//     procedure FnDownloadShareCapitalStatement(member_no: Code[50]; datefilter: Text) Response: Text
//     var
//         MemberTable: Record Customer;
//         Outstr: OutStream;
//         Instr: InStream;
//         RecRef: RecordRef;
//         TempBlob: Codeunit "Temp Blob";
//         Base64Format: text;
//         AddPasswordOptions: dotnet AddPasswordOptions;
//         AddPasswordOptionsII: DotNet AddPasswordOptions;
//         Merger: dotnet Merger;
//         MergerII: DotNet Merger;

//         Base64Convert: Codeunit "Base64 Convert";
//         DocumentPassword: Text;
//         msg: Text;
//         SystemFactory: Codeunit "SURESTEP Factory";
//     begin
//         DocumentPassword := '';
//         DocumentPassword := SystemFactory.FnGeneratePassword();
//         MemberTable.Reset();
//         MemberTable.SetRange(MemberTable."No.", member_no);
//         MemberTable.SetFilter(MemberTable."Date Filter", datefilter);
//         if MemberTable.Find('-') then begin
//             RecRef.GetTable(MemberTable);
//             Clear(TempBlob);
//             TempBlob.CreateOutStream(Outstr);
//             TempBlob.CreateInStream(Instr);
//             if Report.SaveAs(Report::"Member Share Capital Statement", '', ReportFormat::Pdf, Outstr, RecRef) then begin
//                 AddPasswordOptionsII := AddPasswordOptions.AddPasswordOptions(DocumentPassword);
//                 MergerII := Merger.Merger(Outstr);
//                 MergerII.AddPassword(AddPasswordOptionsII);
//                 MergerII.Save(Instr);
//                 Base64Format := Base64Convert.ToBase64(Instr);
//                 msg := '';
//                 msg := 'Your Share Capital statement is password encrypted. To open use ' + Format(DocumentPassword) + ' as the password.';
//                 SystemFactory.FnSendSMS('ENCRYPTION KEY', msg, MemberTable."Mobile Phone No.");
//                 response := '{' +
//                                 ' "StatusCode":"00",' +
//                                 ' "StatusDescription": "Success",' +
//                                 ' "report":"' + (Base64Format) + '"' +
//                             '}';
//                 exit;
//             end;
//             response := '{' +
//                                 ' "StatusCode":"01",' +
//                                 ' "StatusDescription": "Failed"' +
//                          '}';
//             exit;
//         end;
//     end;

//     procedure FnDownloadDetailedStatement(member_no: Code[50]; datefilter: Text) Response: Text
//     var
//         MemberTable: Record Customer;
//         Outstr: OutStream;
//         Instr: InStream;
//         RecRef: RecordRef;
//         TempBlob: Codeunit "Temp Blob";
//         Base64Format: text;
//         AddPasswordOptions: dotnet AddPasswordOptions;
//         AddPasswordOptionsII: DotNet AddPasswordOptions;
//         Merger: dotnet Merger;
//         MergerII: DotNet Merger;

//         Base64Convert: Codeunit "Base64 Convert";
//         DocumentPassword: Text;
//         msg: Text;
//         SystemFactory: Codeunit "SURESTEP Factory";
//     begin
//         DocumentPassword := '';
//         DocumentPassword := SystemFactory.FnGeneratePassword();
//         MemberTable.Reset();
//         MemberTable.SetRange(MemberTable."No.", member_no);
//         MemberTable.SetFilter(MemberTable."Date Filter", datefilter);
//         if MemberTable.Find('-') then begin
//             RecRef.GetTable(MemberTable);
//             Clear(TempBlob);
//             TempBlob.CreateOutStream(Outstr);
//             TempBlob.CreateInStream(Instr);
//             if Report.SaveAs(Report::"Member Detailed Statement", '', ReportFormat::Pdf, Outstr, RecRef) then begin
//                 AddPasswordOptionsII := AddPasswordOptions.AddPasswordOptions(DocumentPassword);
//                 MergerII := Merger.Merger(Outstr);
//                 MergerII.AddPassword(AddPasswordOptionsII);
//                 MergerII.Save(Instr);
//                 Base64Format := Base64Convert.ToBase64(Instr);
//                 msg := '';
//                 msg := 'Your detailed statement is password encrypted. To open use ' + Format(DocumentPassword) + ' as the password.';
//                 SystemFactory.FnSendSMS('ENCRYPTION KEY', msg, MemberTable."Mobile Phone No.");
//                 response := '{' +
//                                 ' "StatusCode":"00",' +
//                                 ' "StatusDescription": "Success",' +
//                                 ' "report":"' + (Base64Format) + '"' +
//                             '}';
//                 exit;
//             end;
//             response := '{' +
//                                 ' "StatusCode":"01",' +
//                                 ' "StatusDescription": "Failed"' +
//                          '}';
//             exit;
//         end;
//     end;

//     procedure FnDownloadDepositsStatement(member_no: Code[50]; datefilter: Text) Response: Text
//     var
//         MemberTable: Record Customer;
//         Outstr: OutStream;
//         Instr: InStream;
//         RecRef: RecordRef;
//         TempBlob: Codeunit "Temp Blob";
//         Base64Format: text;
//         AddPasswordOptions: dotnet AddPasswordOptions;
//         AddPasswordOptionsII: DotNet AddPasswordOptions;
//         Merger: dotnet Merger;
//         MergerII: DotNet Merger;

//         Base64Convert: Codeunit "Base64 Convert";
//         DocumentPassword: Text;
//         msg: Text;
//         SystemFactory: Codeunit "SURESTEP Factory";
//     begin
//         DocumentPassword := '';
//         DocumentPassword := SystemFactory.FnGeneratePassword();
//         MemberTable.Reset();
//         MemberTable.SetRange(MemberTable."No.", member_no);
//         MemberTable.SetFilter(MemberTable."Date Filter", datefilter);
//         if MemberTable.Find('-') then begin
//             RecRef.GetTable(MemberTable);
//             Clear(TempBlob);
//             TempBlob.CreateOutStream(Outstr);
//             TempBlob.CreateInStream(Instr);
//             if Report.SaveAs(Report::"Members Deposits Statement", '', ReportFormat::Pdf, Outstr, RecRef) then begin
//                 AddPasswordOptionsII := AddPasswordOptions.AddPasswordOptions(DocumentPassword);
//                 MergerII := Merger.Merger(Outstr);
//                 MergerII.AddPassword(AddPasswordOptionsII);
//                 MergerII.Save(Instr);
//                 Base64Format := Base64Convert.ToBase64(Instr);
//                 msg := '';
//                 msg := 'Your Deposits statement is password encrypted. To open use ' + Format(DocumentPassword) + ' as the password.';
//                 SystemFactory.FnSendSMS('ENCRYPTION KEY', msg, MemberTable."Mobile Phone No.");
//                 response := '{' +
//                                 ' "StatusCode":"00",' +
//                                 ' "StatusDescription": "Success",' +
//                                 ' "report":"' + (Base64Format) + '"' +
//                             '}';
//                 exit;
//             end;
//             response := '{' +
//                                 ' "StatusCode":"01",' +
//                                 ' "StatusDescription": "Failed"' +
//                          '}';
//             exit;
//         end;
//     end;

//     // procedure FnDownloadFOSAStatement(member_no: Code[50]; datefilter: Text) Response: Text
//     // var
//     //     VendorTable: Record vendor;
//     //     Outstr: OutStream;
//     //     Instr: InStream;
//     //     RecRef: RecordRef;
//     //     TempBlob: Codeunit "Temp Blob";
//     //     Base64Format: text;
//     //     AddPasswordOptions: dotnet AddPasswordOptions;
//     //     AddPasswordOptionsII: DotNet AddPasswordOptions;
//     //     Merger: dotnet Merger;
//     //     MergerII: DotNet Merger;

//     //     Base64Convert: Codeunit "Base64 Convert";
//     //     DocumentPassword: Text;
//     //     msg: Text;
//     //     SystemFactory: Codeunit "System Factory";
//     // begin
//     //     DocumentPassword := '';
//     //     DocumentPassword := SystemFactory.FnGeneratePassword();
//     //     VendorTable.Reset();
//     //     VendorTable.SetRange(VendorTable."Member No", member_no);
//     //     VendorTable.SetFilter(VendorTable."Date Filter", datefilter);
//     //     if VendorTable.Find('-') then begin
//     //         RecRef.GetTable(VendorTable);
//     //         Clear(TempBlob);
//     //         TempBlob.CreateOutStream(Outstr);
//     //         TempBlob.CreateInStream(Instr);
//     //         if Report.SaveAs(Report::"Member FOSA Statement", '', ReportFormat::Pdf, Outstr, RecRef) then begin
//     //             AddPasswordOptionsII := AddPasswordOptions.AddPasswordOptions(DocumentPassword);
//     //             MergerII := Merger.Merger(Outstr);
//     //             MergerII.AddPassword(AddPasswordOptionsII);
//     //             MergerII.Save(Instr);
//     //             Base64Format := Base64Convert.ToBase64(Instr);
//     //             msg := '';
//     //             msg := 'Your FOSA statement is password encrypted. To open use ' + Format(DocumentPassword) + ' as the password.';
//     //             SystemFactory.SendSMS('ENCRYPTION KEY', msg, VendorTable."Mobile Phone No.");
//     //             response := '{' +
//     //                             ' "StatusCode":"00",' +
//     //                             ' "StatusDescription": "Success",' +
//     //                             ' "report":"' + (Base64Format) + '"' +
//     //                         '}';
//     //             exit;
//     //         end;
//     //         response := '{' +
//     //                             ' "StatusCode":"01",' +
//     //                             ' "StatusDescription": "Failed"' +
//     //                      '}';
//     //         exit;
//     //     end;
//     // end;

//     procedure FnGetMemberReport(member_no: Code[50]; startdatefilter: Text; enddatefilter: Text; reporttype: Text) Response: Text
//     var
//         datefilter: Text;
//     begin
//         datefilter := '';
//         datefilter := Format(startdatefilter) + '..' + Format(enddatefilter);
//         if (reporttype = 'Detailed Report') then begin
//             Response := FnDownloadDetailedStatement(member_no, datefilter);
//             exit;
//         end else if (reporttype = 'Deposit Report') then begin
//             Response := FnDownloadDepositsStatement(member_no, datefilter);
//             exit;
//         end else if (reporttype = 'Loan Report') then begin
//             Response := FnDownloadDepositsStatement(member_no, datefilter);
//             exit;
//         end else if (reporttype = 'FOSA Report') then begin
//             Response := FnDownloadFOSAStatement(member_no, datefilter);
//             exit;
//         end;
//         response := '{' +
//                                 ' "StatusCode":"01",' +
//                                 ' "StatusDescription": "Your request Failed."' +
//                          '}';
//         exit;
//     end;

//     procedure FnGetMemberLoans(var member_no: Code[20]) Response: text;
//     var
//         LoansTable: record "Loans Register";
//     begin
//         LoansTable.Reset();
//         LoansTable.SetRange(LoansTable."Client Code", member_no);
//         LoansTable.SetAutoCalcFields(LoansTable."Outstanding Balance", LoansTable."Oustanding Interest");
//         LoansTable.SetFilter(LoansTable."Outstanding Balance", '>%1', 0);
//         if LoansTable.find('-') = true then begin
//             response := '{' +
//                    ' "StatusCode":"00",' +
//                    ' "StatusDescription": "Success",' +
//                    ' "LoanResponse": {' +
//                    '   "LoanDetails": [';
//             repeat
//                 response += '{' +
//             ' "loan_number": "' + FORMAT(LoansTable."Loan  No.") + '",' +
//             ' "loan_type": "' + FORMAT(LoansTable."Loan Product Type") + '",' +
//             ' "loan_source": "' + FORMAT(LoansTable.Source) + '",' +
//             ' "outstanding_balance": "' + FORMAT(LoansTable."Outstanding Balance") + '",' +
//             ' "installments": "' + FORMAT(LoansTable.Installments) + '",' +
//             ' "loan_status": "' + FORMAT(LoansTable."Loans Category-SASRA") + '",' +
//             ' "repayment_amount": "' + FORMAT(LoansTable."Monthly Repayment") + '",' +
//             ' "repayment_frequency": "' + FORMAT(LoansTable."Repayment Frequency") + '",' +
//             ' "repayment_method": "' + FORMAT(LoansTable."Repayment Method") + '",' +
//             ' "loan_principal": "' + FORMAT(LoansTable."Approved Amount") + '",' +
//             ' "repayment_start_date": "' + FORMAT(LoansTable."Repayment Start Date") + '",' +
//             ' "expected_date_of_completion": "' + FORMAT(LoansTable."Expected Date of Completion") + '",' +
//             ' "disbursement_date": "' + FORMAT(LoansTable."Loan Disbursement Date") + '"' +
//           '},';
//             UNTIL LoansTable.Next = 0;
//             response := COPYSTR(response, 1, STRLEN(response) - 1);
//             // Close the JSON response structure
//             response += ' ]' +
//               ' }' +
//             '}';

//             EXIT;
//         END else if LoansTable.Find('-') = false then begin
//             response := '{' +
//                                       ' "status":"01",' +
//                                       ' "StatusDescription": "No Active Loans Found",' +
//                  '}';
//             EXIT;
//         end;
//     END;
// }
