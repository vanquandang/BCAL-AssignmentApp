codeunit 50202 "Assignment Installer"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        AssignmentSetup: Record "Assignment Setup";
    begin
        if not AssignmentSetup.Get() then begin
            AssignmentSetup.Init();
            AssignmentSetup.Insert(true);
        end;
    end;
}