page 50110 "XML Test Page"
{
    PageType = Card;
    Caption = 'XML Test Page';
    actions
    {
        area(processing)
        {
            action("Create Soap Message")
            {
                Caption = 'Read XML File';
                ApplicationArea = All;
                Image = XMLFile;
                trigger OnAction()
                var
                    XMLRead: codeunit 50500;
                begin
                    XMLRead.ReadFile();
                end;
            }
        }
    }
}