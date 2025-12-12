query 50200 "AssignmentCustomerQuery"
{
    QueryType = Normal;

    elements
    {
        dataitem(Assignment; Assignment)
        {
            column(No; "No.")
            {
            }
            column(Title; Title)
            {
            }
            column(Status; Status)
            {
            }
            column(UserId; "User Id")
            {
            }
            column(CategoryCode; "Category Code")
            {

            }

            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = Assignment."Customer No.";
                SqlJoinType = LeftOuterJoin;

                column(Name; Name)
                {

                }
            }
        }
    }
}