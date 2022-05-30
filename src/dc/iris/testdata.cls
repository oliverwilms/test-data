Class dc.iris.testdata
{

ClassMethod order(
	pQuantity1 As %Integer = 1,
	pQuantity2 As %Integer = 1) As %Status
{
	Set tSC = $$$OK
	Set tOrder = ##class(dc.iris.order).newOrder("Adam Ant")
	Write tOrder,!
	Set tSC = ##class(dc.iris.orderline).processNewLine(tOrder,1,pQuantity1)
	Write $System.Status.GetErrorText(tSC)
	If $$$ISERR(tSC) Quit tSC
	Set tSC = ##class(dc.iris.orderline).processNewLine(tOrder,2,pQuantity2)
	Write $System.Status.GetErrorText(tSC)
	If $$$ISERR(tSC) Quit tSC
	Quit tSC
}

}
