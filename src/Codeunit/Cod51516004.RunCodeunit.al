#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516004 "RunCodeunit"
{

    trigger OnRun()
    begin
        Runn;
    end;

    var
        PostAtm: Codeunit "POST ATM Transactions";


    procedure Runn()
    begin
        PostAtm.Run;
        //PostGomobile.RUN;
        //CODEUNIT.RUN(51516003)
    end;
}

