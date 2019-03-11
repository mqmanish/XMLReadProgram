codeunit 50500 "XML Read Demo"
{
    trigger OnRun()
    begin

    end;

    procedure ReadFile()
    var
        RespnseTxt: Text;
        XMLResponseContent: Text;
        XMLDocResponse: XmlDocument;
        XMLInstream: InStream;
        lXMLResponse: XmlDocument;
        xmlNodeList1: XmlNodeList;
        xmlNodeList2: XmlNodeList;
        xmlNodeList3: XmlNodeList;
        xmlNodeList4: XmlNodeList;
        xmldomElem1: XmlElement;
        xmldomElem2: XmlElement;
        xmldomElem3: XmlElement;
        xmldomElem4: XmlElement;
        xmldomElem5: XmlElement;
        xmlNode1: XmlNode;
        xmlNode2: XmlNode;
        xmlNode3: XmlNode;
        xmlNode4: XmlNode;
        NodeCount: Integer;
        i: Integer;
    begin
        
        if UploadIntoStream('Select XML file', '', 'XML files (*.XML)|*.XML|All files (*.*)|*.*', RespnseTxt, XMLInstream) then begin
            CustomerXML.DeleteAll();
            CustomerXML.Reset();

            CLEAR(RespnseTxt);
            XMLDomMgt.LoadXMLDocumentFromInStream(XMLInstream, lXMLResponse);
            lXMLResponse.WriteTo(RespnseTxt);
            XMLResponseContent := XMLDomMgt.RemoveNamespaces(RespnseTxt);
            XMLDomMgt.LoadXMLDocumentFromText(XMLResponseContent, XMLDocResponse);
            //Write message for Checking execution
            //Message(XMLResponseContent);

            xmlNodeList1 := XMLDocResponse.GetDescendantElements('Customer');
            NodeCount := xmlNodeList1.Count();

            FOR i := 1 TO xmlNodeList1.Count() DO BEGIN

                if xmlNodeList1.Get(i, xmlNode1) then //Customer
                    xmldomElem1 := xmlNode1.AsXmlElement();
                if not xmldomElem1.IsEmpty() and xmldomElem1.HasElements() then begin
                    //Message('%1',xmldomElem1.LocalName());
                    xmlNodeList2 := xmldomElem1.GetChildNodes();
                    If xmlNodeList2.get(1, xmlNode2) then //CustomerAuthentication
                        xmldomElem2 := xmlNode2.AsXmlElement();
                    if not xmldomElem2.IsEmpty() and xmldomElem2.HasElements() then begin
                        xmlNodeList3 := xmldomElem2.GetChildNodes();
                        if xmlNodeList3.get(1, xmlNode3) then begin //No
                            xmldomElem3 := xmlNode3.AsXmlElement();
                            if Evaluate(CustNo, xmldomElem3.InnerText()) then
                                Evaluate(CustNo, xmldomElem3.InnerText());
                        END;
                        if xmlNodeList3.get(2, xmlNode3) then begin //Name
                            xmldomElem3 := xmlNode3.AsXmlElement();
                            if Evaluate(CustName, xmldomElem3.InnerText()) then
                                Evaluate(CustName, xmldomElem3.InnerText());
                        END;
                    END;

                    clear(xmlNode2);
                    clear(xmldomElem2);
                    If xmlNodeList2.get(2, xmlNode2) then //CustomerData
                        xmldomElem2 := xmlNode2.AsXmlElement();
                    if not xmldomElem2.IsEmpty() and xmldomElem2.HasElements() then begin
                        xmlNodeList3 := xmldomElem2.GetChildNodes();
                        if xmlNodeList3.get(1, xmlNode3) then begin //Balance
                            xmldomElem3 := xmlNode3.AsXmlElement();
                            if Evaluate(CustBalance, xmldomElem3.InnerText()) then
                                Evaluate(CustBalance, xmldomElem3.InnerText());
                        END;
                        if xmlNodeList3.get(2, xmlNode3) then begin //SalespersonCode
                            xmldomElem3 := xmlNode3.AsXmlElement();
                            if Evaluate(CustSP, xmldomElem3.InnerText()) then
                                Evaluate(CustSP, xmldomElem3.InnerText());
                        END;
                        if xmlNodeList3.get(3, xmlNode3) then  //Contacts
                            xmldomElem4 := xmlNode3.AsXmlElement();
                        if not xmldomElem4.IsEmpty() and xmldomElem4.HasElements() then begin
                            xmlNodeList4 := xmldomElem4.GetChildNodes();
                            if xmlNodeList4.get(1, xmlNode4) then begin //Contact 
                                xmldomElem5 := xmlNode4.AsXmlElement();
                                if Evaluate(CustCont, xmldomElem5.InnerText()) then
                                    Evaluate(CustCont, xmldomElem5.InnerText());
                                //Message('%1..%2', xmldomElem5.LocalName(), xmldomElem5.InnerText());
                            end;
                        end;
                    end
                end;
                InsertCustomerData();
                ClearVariables();
            End;
        end;
    end;

    local procedure ClearVariables()
    begin
        CLEAR(CustNo);
        CLEAR(CustSP);
        CLEAR(CustName);
        CLEAR(CustCont);
        CLEAR(CustBalance);
    end;

    local procedure InsertCustomerData()
    begin
        CustomerXML.Init();
        CustomerXML."No." := CustNo;
        CustomerXML.Name := CustName;
        CustomerXML.ContactName := CustName;
        CustomerXML.Balance := CustBalance;
        CustomerXML.SalespersonCode := custsp;
        CustomerXML.Insert();
        Color := Color::Green;
    end;

    var
        CustomerXML: Record CustomerXML;
        XMLDomMgt: Codeunit "XML DOM Mgt.";
        CustNo: Code[20];
        CustSP: Code[10];
        Color : Option "Red","Green";
        CustName: Text[100];
        CustCont: Text[100];
        CustBalance: Decimal;

}