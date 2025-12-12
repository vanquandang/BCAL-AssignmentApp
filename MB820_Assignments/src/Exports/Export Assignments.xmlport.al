xmlport 50200 "Export Assignments"
{
    Format = VariableText;
    FieldSeparator = ';';
    FieldDelimiter = '"';
    Direction = Export;

    schema
    {
        textelement(Root)
        {
            tableelement(Assignment; Assignment)
            {
                fieldattribute(No_; Assignment."No.")
                {
                }

                fieldelement(UserId; Assignment."User Id")
                {

                }
                fieldelement(CategoryCode; Assignment."Category Code")
                {
                }
                fieldelement(Status; Assignment.Status)
                {
                }
                fieldelement(Title; Assignment.Title)
                {
                    MinOccurs = Zero;
                }

            }
        }
    }
}