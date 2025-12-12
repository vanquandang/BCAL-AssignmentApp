codeunit 50205 "JsonPlaceholder Mgt."
{

    procedure GetTodos()
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        Content: HttpContent;
        ResponseString: Text;
        TestString: Text;
        JArray: JsonArray;
        JObject: JsonObject;
        JToken: JsonToken;
        ResultToken: JsonToken;

        UserId: Integer;
        Id: Integer;
        Title: Text;
        Completed: Boolean;
        AssignmentMgt: Codeunit "Assignment Mgt.";
    begin
        if not Client.Get('https://jsonplaceholder.typicode.com/todos', ResponseMessage) then
            Error('Could not reach todos-api, try again later');

        Content := ResponseMessage.Content();
        Content.ReadAs(ResponseString);

        JArray.ReadFrom(ResponseString);
        foreach JToken in JArray do begin
            JObject := JToken.AsObject();

            // JObject.WriteTo(TestString);
            // Error(TestString);


            // if JObject.SelectToken('userId', ResultToken) then
            //     UserId := ResultToken.AsValue().AsInteger()
            // else
            //     UserId := 0;

            // if JObject.SelectToken('id', ResultToken) then
            //     Id := ResultToken.AsValue().AsInteger()
            // else
            //     Id := 0;

            // if JObject.SelectToken('title', ResultToken) then
            //     Title := ResultToken.AsValue().AsText()
            // else
            //     Title := '';

            // if JObject.SelectToken('completed', ResultToken) then
            //     Completed := ResultToken.AsValue().AsBoolean()
            // else
            //     Completed := false;
            // Completed := 1 = 1 ? true : false;

            UserId := JObject.SelectToken('userId', ResultToken) ? ResultToken.AsValue().AsInteger() : 0;
            Id := JObject.SelectToken('id', ResultToken) ? ResultToken.AsValue().AsInteger() : 0;
            Title := JObject.SelectToken('title', ResultToken) ? ResultToken.AsValue().AsText() : '';
            Completed := JObject.SelectToken('completed', ResultToken) ? ResultToken.AsValue().AsBoolean() : false;

            AssignmentMgt.InsertAssignment(UserId, Title, StrSubstNo('%1 created by %2, at: %3', Title, UserId, Today()), Id, Completed);

        end;
    end;

    // procedure POSTTodos()
    // var
    //     Client: HttpClient;
    //     RequestMessage: HttpRequestMessage;
    //     ResponseMessage: HttpResponseMessage;
    //     Content: HttpContent;
    //     RequestHeaders: HttpHeaders;
    //     ContentHeaders: HttpHeaders;
    //     ResponseString: Text;
    //     JToken: JsonToken;
    //     PageToken: JsonToken;
    // begin
    //     RequestMessage.SetRequestUri('https://jsonplaceholder.typicode.com/todos');
    //     Content := RequestMessage.Content;

    //     Content.WriteFrom('{"first": 1, "second": 2}');
    //     Content.GetHeaders(ContentHeaders);
    //     if ContentHeaders.Contains('Content-type') then
    //         ContentHeaders.Remove('Content-type');

    //     ContentHeaders.Add('Content-Type', 'application/json');

    //     // RequestMessage.Content(Content);
    //     // RequestHeaders.Add('Content-Type', 'application/json')

    //     if not Client.Send(RequestMessage, ResponseMessage) then
    //         Error('Something broke');

    //     Content := ResponseMessage.Content;
    //     Content.ReadAs(ResponseString);

    //     JToken.ReadFrom(ResponseString);
    //     if JToken.SelectToken('nextPage', PageToken) then
    //         RerunTheParseFunction();
    // end;
}