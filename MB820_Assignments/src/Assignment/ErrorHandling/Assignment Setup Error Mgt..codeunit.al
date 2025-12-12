codeunit 50206 "Assignment Setup Error Mgt."
{

    procedure OpenAssignmentSetup(NoSeriesErrorInfo: ErrorInfo)

    var
        AssignmentSetup: Page "Assignment Setup";
    begin
        AssignmentSetup.RunModal();
    end;
}