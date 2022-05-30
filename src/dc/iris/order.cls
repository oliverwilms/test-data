Class dc.iris.order Extends %Persistent
{

Property customer As %String;

ClassMethod newOrder(pCustomer As %String) As %String
{
	Set oOrder = ..%New()
	Set oOrder.customer = pCustomer
	Set tSC = oOrder.%Save()
	If $$$ISERR(tSC) Quit ""
	Set tID = oOrder.%Id()
	Quit tID
}

Storage Default
{
<Data name="orderDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>customer</Value>
</Value>
</Data>
<DataLocation>^dc.iris.orderD</DataLocation>
<DefaultData>orderDefaultData</DefaultData>
<IdLocation>^dc.iris.orderD</IdLocation>
<IndexLocation>^dc.iris.orderI</IndexLocation>
<StreamLocation>^dc.iris.orderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
