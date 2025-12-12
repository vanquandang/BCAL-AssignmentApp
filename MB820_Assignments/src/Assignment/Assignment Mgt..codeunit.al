codeunit 50200 "Assignment Mgt."
{
    Subtype = Normal;

    trigger OnRun()
    begin

    end;

    procedure Complete(var Assignment: Record Assignment)
    begin
        // A lot of functionality
        // Simulate long running procedure
        Sleep(200);

        Assignment.Status := Assignment.Status::Completed;
        Assignment.Modify();
    end;

    procedure InProgress(var Assignment: Record Assignment)
    begin
        // A lot of functionality
        // Simulate long running procedure
        Sleep(200);

        Assignment.Status := Assignment.Status::"In Progress";
        Assignment.Modify();
    end;

    procedure InsertAssignment(UserId: Integer; Title: Text[100]; Description: Text)
    var
        Assignment: Record Assignment;
    begin
        Assignment.Init();
        Assignment.Validate("User Id", UserId);
        Assignment.Validate(Title, Title);
        Assignment.Validate(Description, CopyStr(Description, 1, MaxStrLen(Assignment.Description)));
        Assignment.Insert(true);
    end;

    procedure InsertAssignment(UserId: Integer; Title: Text[100]; Description: Text; APIId: Integer; Completed: Boolean)
    var
        Assignment: Record Assignment;
    begin
        // Optimize
        Assignment.SetRange("API Id", APIId);
        if not Assignment.IsEmpty() then
            exit;

        Assignment.Init();
        Assignment.Validate("User Id", UserId);
        Assignment.Validate(Title, Title);
        Assignment.Validate(Description, CopyStr(Description, 1, MaxStrLen(Assignment.Description)));

        Assignment.Validate("API Id", APIId);
        if Completed then
            Assignment.Validate(Status, Assignment.Status::Completed)
        else
            Assignment.Validate(Status, Assignment.Status::Incomplete);

        Assignment.Insert(true);
    end;

    procedure ExportAssignmentsToAzure()
    var
        ExportAssignments: XmlPort "Export Assignments";
        TempBlob: Codeunit "Temp Blob";
        ExternalFileStorage: Codeunit "External File Storage";
        OStream: OutStream;
        IStream: Instream;
    begin
        TempBlob.CreateOutStream(OStream);
        ExportAssignments.SetDestination(OStream);
        ExportAssignments.Export();

        TempBlob.CreateInStream(IStream);
        ExternalFileStorage.Initialize(Enum::"File Scenario"::Default);
        ExternalFileStorage.CreateFile('Assignments.csv', IStream);
    end;

    procedure QueryReadFunction()
    var
        // Assignment: Record Assignment;
        // Customer: Record Customer;
        AssignmentCustomerQuery: Query AssignmentCustomerQuery;
        CustomerList: List of [Text];
    begin
        // if Assignment.FindSet() then
        //     repeat
        //         if Customer.Get(Assignment."Customer No.") then
        //             if not CustomerList.Contains(Customer.Name) then
        //                 CustomerList.Add(Customer.Name);

        //     until Assignment.Next() = 0;

        if AssignmentCustomerQuery.Open() then
            while AssignmentCustomerQuery.Read() do begin
                if not CustomerList.Contains(AssignmentCustomerQuery.Name) then
                    CustomerList.Add(AssignmentCustomerQuery.Name);

            end;
    end;


    procedure VerifyAssignmentSetup()
    var
        AssignmentSetup: Record "Assignment Setup";
        NoSeries: Record "No. Series";
        NoSeriesErrorInfo: ErrorInfo;
    begin
        AssignmentSetup.InsertIfNotExist();
        if not NoSeries.Get(AssignmentSetup."Assignment Nos.") then begin
            NoSeriesErrorInfo.Title := 'The No Series does not exist';
            NoSeriesErrorInfo.Message := 'The No. Series for Assignments, have not been setup on the Assignment Setup page.';

            NoSeriesErrorInfo.AddAction('Go to Assignment Setup', Codeunit::"Assignment Setup Error Mgt.", 'OpenAssignmentSetup');
            Error(NoSeriesErrorInfo);
        end;
    end;


    // OnAfterReleaseSalesDoc
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReleaseSalesDoc, '', false, false)]
    local procedure "Release Sales Document_OnAfterReleaseSalesDoc"(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var LinesWereModified: Boolean; SkipWhseRequestOperations: Boolean)
    begin
        InsertAssignment(0, StrSubstNo('Post Sales Doc %1', SalesHeader."No."), StrSubstNo('Remember to actually post the Sales %1 %2', SalesHeader."Document Type", SalesHeader."No."));
    end;

}