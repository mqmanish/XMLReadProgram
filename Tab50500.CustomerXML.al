table 50500 CustomerXML
{
    DataClassification = AccountData;
    Caption = 'CustomerXML';
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = AccountData;
            Caption = 'No.';
        }
        field(2; Name; Text[100])
        {
            DataClassification = AccountData;
            Caption = 'Name';
        }
        field(3; Balance; Decimal)
        {
            DataClassification = AccountData;
            Caption = 'Balance';
        }
        field(4; SalespersonCode; Code[10])
        {
            DataClassification = AccountData;
            Caption = 'SalespersonCode';
        }
        field(5; ContactName; Text[100])
        {
            DataClassification = AccountData;
            Caption = 'Contact Name';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}