page 50202 "Assignment Setup"
{
    PageType = Card;
    ApplicationArea = Basic, Suite;
    UsageCategory = Administration;
    SourceTable = "Assignment Setup";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Assignment Nos."; Rec."Assignment Nos.")
                {
                    ToolTip = 'Specifies the value of the Assignment Nos. field.', Comment = '%';
                }
                field("Assignment Nos. 2"; Rec."Assignment Nos. 2")
                {
                    ToolTip = 'Specifies the value of the Assignment Nos. 2 field.', Comment = '%';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}