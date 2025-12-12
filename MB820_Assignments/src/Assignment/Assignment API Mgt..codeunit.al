codeunit 50201 "Assignment API Mgt."
{
    // Access = Internal;
    procedure GetAssignmentsFromAPI()
    var
        myInt: Integer;
    begin

    end;

    procedure POSTAssignmentsToAPI()
    var
        myInt: Integer;
    begin

    end;

    [NonDebuggable] //Not allowing other devs to see
    internal procedure GetAccessToken(): SecretText;
    var
        APIKeyText: Text;
        AccessToken: Text;
    begin
        APIKeyText := APIKey();
        //Do smth with OAuth
        AccessToken := 'smth from OAuth';
        exit(AccessToken);
    end;

    [NonDebuggable]
    local procedure APIKey(): Text;
    var
        myInt: Integer;
    begin
        exit('some-very-important-api-key-095121974');
    end;

}