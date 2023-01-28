Class dc.iris.testdata
{

ClassMethod order(
	pQuantity1 As %Integer = 1,
	pQuantity2 As %Integer = 1) As %Status
{
	Set tSC = ##class(dc.iris.facture).TestProductDefined()
	If $$$ISERR(tSC) {
		Write $System.Status.GetErrorText(tSC),!
		Quit tSC
	}
	Set tOrder = ##class(dc.iris.order).newOrder("Adam Ant")
	Write tOrder,!
	Set tSC = ##class(dc.iris.orderline).processNewLine(tOrder,1,pQuantity1)
	If $$$ISERR(tSC) {
		Write $System.Status.GetErrorText(tSC),!
		Quit tSC
	}
	Set tSC = ##class(dc.iris.orderline).processNewLine(tOrder,2,pQuantity2)
	If $$$ISERR(tSC) {
		Write $System.Status.GetErrorText(tSC),!
		Quit tSC
	}
	Quit $$$OK
}

}
