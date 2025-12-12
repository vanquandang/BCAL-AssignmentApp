codeunit 50204 "Custom EDoc Impl." implements "E-Document"
{

    var
        EDocPEPPOLBIS30: Codeunit "EDoc PEPPOL BIS 3.0";

    procedure Check(
        var SourceDocumentHeader: RecordRef;
        EDocumentService: Record "E-Document Service";
        EDocumentProcessingPhase: Enum "E-Document Processing Phase")
    var
        SalesHeader: Record "Sales Header";
    begin
        case SourceDocumentHeader.Number of
            Database::"Sales Header":
                begin
                    SourceDocumentHeader.SetTable(SalesHeader);
                    SalesHeader.TestField("Your Reference");
                end;
        end;

        EDocPEPPOLBIS30.Check(SourceDocumentHeader, EDocumentService, EDocumentProcessingPhase);
    end;

    procedure Create(
        EDocumentService: Record "E-Document Service";
        var EDocument: Record "E-Document";
        var SourceDocumentHeader: RecordRef;
        var SourceDocumentLines: RecordRef;
        var TempBlob: Codeunit "Temp Blob")
    begin
        EDocPEPPOLBIS30.Create(EDocumentService, EDocument, SourceDocumentHeader, SourceDocumentLines, TempBlob);
    end;

    procedure CreateBatch(
        EDocumentService: Record "E-Document Service";
        var EDocuments: Record "E-Document";
        var SourceDocumentHeaders: RecordRef;
        var SourceDocumentsLines: RecordRef;
        var TempBlob: Codeunit "Temp Blob")
    begin
        EDocPEPPOLBIS30.CreateBatch(EDocumentService, EDocuments, SourceDocumentHeaders, SourceDocumentsLines, TempBlob);
    end;

    procedure GetBasicInfoFromReceivedDocument(
        var EDocument: Record "E-Document";
        var TempBlob: Codeunit "Temp Blob");
    begin
        EDocPEPPOLBIS30.GetBasicInfoFromReceivedDocument(EDocument, TempBlob);
    end;

    // 5) Turn imported blob into an actual BC document
    procedure GetCompleteInfoFromReceivedDocument(
        var EDocument: Record "E-Document";
        var CreatedDocumentHeader: RecordRef;
        var CreatedDocumentLines: RecordRef;
        var TempBlob: Codeunit "Temp Blob")
    begin
        EDocPEPPOLBIS30.GetCompleteInfoFromReceivedDocument(EDocument, CreatedDocumentHeader, CreatedDocumentLines, TempBlob);
    end;

}
