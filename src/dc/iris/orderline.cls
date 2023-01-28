Class dc.iris.orderline Extends %Persistent
{

Property order As %Integer;

Property product As %String;

Property quantity As %Integer;

Property tsBegin As %String;

Property tsDone As %String;

ClassMethod beginLine(pId As %String = "") As %Status
{
	Set tNOW = $NOW()
	Set oLine = ..%OpenId(pId)
	If (0 = $IsObject(oLine)) {
		Set tMsg = "pId = "_pId
		Set tSC = $$$ERROR($$$GeneralError,"Error #1 in beginLine: "_tMsg)
		Quit tSC
	}
	Set oLine.tsBegin = tNOW
	Set tSC = oLine.%Save()
	If $$$ISERR(tSC) Quit tSC
	Set tProduct = oLine.product
	Set tQuantity = oLine.quantity
	Set tSC = ##class(dc.iris.facture).Manufacture(tProduct,tQuantity)
	If $$$ISERR(tSC) Quit tSC
	Set tNOW = $NOW()
	Set oLine = ..%OpenId(pId)
	If (0 = $IsObject(oLine)) {
		Set tSC = $$$ERROR($$$GeneralError,"Error #2 in beginLine")
		Quit tSC
	}
	Set oLine.tsDone = tNOW
	Set tSC = oLine.%Save()
	If $$$ISERR(tSC) Quit tSC
	Quit tSC
}

ClassMethod newLine(
	pOrder As %String = "",
	pProduct As %String = "",
	pQuantity As %Integer = 1) As %String
{
	Set oLine = ..%New()
	Set oLine.order = pOrder
	Set oLine.product = pProduct
	Set oLine.quantity = pQuantity
	Set tSC = oLine.%Save()
	If $$$ISERR(tSC) {
		Set tError = $SYSTEM.Status.GetErrorText(tSC)
		Write tError,!
		Quit ""
	}
	Set tID = oLine.%Id()
	Quit tID
}

ClassMethod processNewLine(
	pOrder As %String = "",
	pProduct As %String = "",
	pQuantity As %Integer = 1) As %Status
{
	Set tLine1 = ##class(dc.iris.orderline).newLine(pOrder,pProduct,pQuantity)
	Set tSC = ##class(dc.iris.orderline).beginLine(tLine1)
	Quit tSC
}

Storage Default
{
<Data name="orderlineDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>order</Value>
</Value>
<Value name="3">
<Value>product</Value>
</Value>
<Value name="4">
<Value>quantity</Value>
</Value>
<Value name="5">
<Value>tsBegin</Value>
</Value>
<Value name="6">
<Value>tsDone</Value>
</Value>
</Data>
<DataLocation>^dc.iris.orderlineD</DataLocation>
<DefaultData>orderlineDefaultData</DefaultData>
<IdLocation>^dc.iris.orderlineD</IdLocation>
<IndexLocation>^dc.iris.orderlineI</IndexLocation>
<StreamLocation>^dc.iris.orderlineS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
