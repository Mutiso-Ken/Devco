// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Table 51516292 "Account App Signatories"
// {

//     fields
//     {
//         field(1;"Account No";Code[20])
//         {
//             NotBlank = true;
//             TableRelation = "Accounts Applications Details"."No.";
//         }
//         field(2;Names;Text[50])
//         {
//             NotBlank = true;
//         }
//         field(3;"Date Of Birth";Date)
//         {
//         }
//         field(4;"Staff/Payroll";Code[20])
//         {
//         }
//         field(5;"ID No.";Code[50])
//         {
//         }
//         field(6;Signatory;Boolean)
//         {
//         }
//         field(7;"Must Sign";Boolean)
//         {
//         }
//         field(8;"Must be Present";Boolean)
//         {
//         }
//         field(9;Picture;Blob)
//         {
//             Caption = 'Picture';
//             SubType = Bitmap;
//         }
//         field(10;Signature;Blob)
//         {
//             Caption = 'Signature';
//             SubType = Bitmap;
//         }
//         field(11;"Expiry Date";Date)
//         {
//         }
//         field(12;"BOSA No.";Code[30])
//         {
//             TableRelation = Customer."No.";
//         }
//         field(13;"Email Address";Text[50])
//         {
//         }
//         field(14;"Send SMS";Boolean)
//         {
//         }
//         field(15;"Mobile Phone No.";Code[50])
//         {
//         }
//     }

//     keys
//     {
//         key(Key1;"Account No",Names)
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }
// }

