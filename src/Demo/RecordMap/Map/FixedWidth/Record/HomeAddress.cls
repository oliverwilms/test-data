/// This class defines the structure of the HomeAddress portion of the record.
Class Demo.RecordMap.Map.FixedWidth.Record.HomeAddress Extends (%SerialObject, %XML.Adaptor) [ Inheritance = right, ProcedureBlock ]
{

Parameter RECORDMAPGENERATED = 1;

Property StreetLine1 As %String(MAXLEN = 30);

Property City As %String(MAXLEN = 25);

Property State As %String(MAXLEN = 2);

Property ZipCode As %String(MAXLEN = 5);

Storage Default
{
<Data name="HomeAddressState">
<Value name="1">
<Value>StreetLine1</Value>
</Value>
<Value name="2">
<Value>City</Value>
</Value>
<Value name="3">
<Value>State</Value>
</Value>
<Value name="4">
<Value>ZipCode</Value>
</Value>
</Data>
<State>HomeAddressState</State>
<StreamLocation>^Demo.RecordMapA535.HomeAddressS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
