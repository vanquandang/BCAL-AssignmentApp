table 50200 "Assignment"
{
    DataClassification = CustomerContent;
    Caption = 'Assignment';
    DataCaptionFields = "No.", "Title";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Number';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    AssignmentSetup.InsertIfNotExist();
                    NoSeries.TestManual(AssignmentSetup."Assignment Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "User ID"; Integer)
        {
            DataClassification = EndUserPseudonymousIdentifiers;
            Caption = 'User ID';
        }
        field(3; "Title"; Text[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Title';
        }
        field(4; "Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(5; "Customer No."; Code[20])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(6; "Category Code"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Category Code';
        }
        field(7; Status; Enum "Assignment Status")
        {
            DataClassification = SystemMetadata;
            Caption = 'Status';
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(9; "API Id"; Integer)
        {
            DataClassification = SystemMetadata;
            Editable = false;
            Caption = 'API Id';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(StatusKey; Status)
        {
            // MaintainSqlIndex = false;
        }
        key(APIIDKey; "API Id")
        {
            MaintainSiftIndex = false;
            MaintainSqlIndex = true;
        }
    }

    var
        AssignmentSetup: Record "Assignment Setup";
        NoSeries: Codeunit "No. Series";
        AssignmentMtg: Codeunit "Assignment Mgt.";


    procedure AssistEdit() Result: Boolean
    begin
        AssignmentSetup.Reset();
        AssignmentSetup.InsertIfNotExist();

        AssignmentSetup.TestField("Assignment Nos.");
        if NoSeries.LookupRelatedNoSeries(AssignmentSetup."Assignment Nos.", xRec."No. Series", "No. Series") then begin
            "No." := NoSeries.GetNextNo("No. Series");
            exit(true);
        end;
    end;


    trigger OnInsert()
    var
        Assignment: Record Assignment;
    begin
        if "No." = '' then begin
            AssignmentSetup.InsertIfNotExist();
            AssignmentSetup.TestField("Assignment Nos.");
            if NoSeries.AreRelated(AssignmentSetup."Assignment Nos.", xRec."No. Series") then
                "No. Series" := xRec."No. Series"
            else
                "No. Series" := AssignmentSetup."Assignment Nos.";
            "No." := NoSeries.GetNextNo("No. Series");

            Assignment.ReadIsolation(IsolationLevel::ReadUncommitted);
            Assignment.SetLoadFields("No.");
            while Assignment.Get("No.") do
                "No." := NoSeries.GetNextNo("No. Series");

        end;
    end;

    procedure SetCompleted()
    begin
        AssignmentMtg.Complete(Rec);
    end;

    procedure SetInProgress()
    begin
        AssignmentMtg.InProgress(Rec);
    end;
}