enumextension 50200 "EDoc Format Ext" extends "E-Document Format"
{
    value(50200; "Custom PEPPOL")
    {
        Caption = 'Custom PEPPOL';
        Implementation = Microsoft.eServices.EDocument."E-Document" = "Custom EDoc Impl.";
    }
}