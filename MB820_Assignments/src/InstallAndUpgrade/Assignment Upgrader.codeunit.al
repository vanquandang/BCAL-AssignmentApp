codeunit 50203 "Assignment Upgrader"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        AssignmentSetup: Record "Assignment Setup";
    begin
        if not AssignmentSetup.Get() then begin
            AssignmentSetup.Init();
            AssignmentSetup.Insert(true);
        end;
        AssignmentSetup."Assignment Nos. 2" := AssignmentSetup."Assignment Nos.";
        AssignmentSetup.Modify(true);
    end;





    #region UpgradeAssignmentSetupWithNoSeries2Field
    internal procedure UpgradeAssignmentSetupWithNoSeries2Field()
    var
        UpgradeTag: Codeunit "Upgrade Tag";
        AssignmentSetup: Record "Assignment Setup";
    begin
        if UpgradeTag.HasUpgradeTag(ReturnAssignmentSetupWithNoSeries2FieldUpgradeTag()) then
            exit;

        if not AssignmentSetup.Get() then begin
            AssignmentSetup.Init();
            AssignmentSetup.Insert(true);
        end;

        AssignmentSetup."Assignment Nos. 2" := AssignmentSetup."Assignment Nos.";
        AssignmentSetup.Modify(true);

        UpgradeTag.SetUpgradeTag(ReturnAssignmentSetupWithNoSeries2FieldUpgradeTag());
    end;

    #region 
    internal procedure ReturnAssignmentSetupWithNoSeries2FieldUpgradeTag(): Text[250]
    begin
        exit('Prefix-ID-AssignmentSetupWithNoSeries2Field-20251210')
    end;
    #endregion ReturnAssignmentSetupWithNoSeries2FieldUpgradeTag

    #endregion UpgradeAssignmentSetupWithNoSeries2Field
}