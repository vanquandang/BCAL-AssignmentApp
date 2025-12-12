report 50200 "Print Assignments"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = WordLayout;

    dataset
    {
        dataitem(Assignment; Assignment)
        {
            RequestFilterFields = Status;

            column(No_Assignment; "No.")
            {
            }
            column(Status_Assignment; Status)
            {
            }
            column(Title_Assignment; Title)
            {
            }
            column(UserId_Assignment; "User Id")
            {
            }
            column(CategoryCode_Assignment; "Category Code")
            {
            }
        }
    }

    rendering
    {
        layout(WordLayout)
        {
            Type = Word; //CTRL + SHIFT + B , to build and generate teh docx file
            LayoutFile = './src/Exports/Layouts/PrintAssignments.docx';
        }
    }

    var
        StatusFilterVar: Enum "Assignment Status";

}