page 50201 "Assignment Card"
{
    PageType = Card;
    ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = "Assignment";

    Caption = 'Assignment Card';
    RefreshOnActivate = true;

    AboutTitle = 'About Assignment details';
    AboutText = 'Find the specific details of the *assignment*, as well as controlling smth customer.', Comment = '%';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Status; Rec.Status)
                {
                    ToolTip = 'Selection of the current Status of the assignment.', Comment = '%';

                    AboutTitle = 'Status';
                    AboutText = 'The status indicates where in the workflow the assignment currently is.';

                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Number field.', Comment = '%';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit() then
                            CurrPage.Update();
                    end;
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'A short description of the assignment.', Comment = '%';

                    AboutTitle = 'Title';
                    AboutText = 'The title will be a shorthand reference, describing the assignment';
                }
                field("Category Code"; Rec."Category Code")
                {
                    ToolTip = 'Specifies the value of the Category Code field.', Comment = '%';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';

                    AboutTitle = 'User ID';
                    AboutText = 'The User ID indicates which user is currentlz responsible for the assignment';
                }

            }
            group(MetaData)
            {
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Complete)
            {
                Caption = 'Completed';
                ApplicationArea = All;
                Image = Approval;

                trigger OnAction()
                begin
                    Rec.SetCompleted();
                end;
            }

            action(InProgress)
            {
                Caption = 'In Progress';
                ApplicationArea = All;
                Image = WorkCenterLoad;

                trigger OnAction()
                begin
                    Rec.SetInProgress();
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        AssignmentMgt: Codeunit "Assignment Mgt.";
    begin
        AssignmentMgt.VerifyAssignmentSetup();
    end;
}