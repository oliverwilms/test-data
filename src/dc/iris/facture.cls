Class dc.iris.facture
{

ClassMethod DefineProduct() As %Status
{
	Set tSC = ##class(dc.iris.product).%DeleteExtent()
	Set oProduct = ##class(dc.iris.product).%New()
	Set oProduct.ClassName = "dc.iris.product"
	Set oProduct.MethodName = "MakeFiles"
	Set oProduct.SampleFile = "/opt/irisbuild/data/RecordMap_Delimited_Sample.txt"
	Set tExists = ##class(%Library.File).Exists(oProduct.SampleFile)
	If (0 = tExists) {
		Set oProduct.SampleFile = $ZU(12)_"data/RecordMap_Delimited_Sample.txt"
	}
	Set oProduct.Name = "Demo"
	Set oProduct.WorkFile = "/tmp/workfile."_oProduct.Name
	Set oProduct.WorkPath = ##class(%File).GetDirectory(oProduct.WorkFile)
	Set oProduct.TargetPath = "/opt/transform/practice/"
	Set tSC = oProduct.%Save()
	Quit tSC
}

ClassMethod DefineProductScript(
	pName As %String = "Demo2",
	pDebug As %Integer = 0) As %Status
{
	Set pQuery = "SELECT ID from dc_iris.product WHERE Name = '?'"
	Set pQuery = $Replace(pQuery,"?",pName)
	Write:pDebug pQuery,!
	Set tSC = ##class(dc.iris.util).ExecuteQueryOneValue(pQuery,.oProduct)
	Write:pDebug tSC,!
	Set oProduct = ##class(dc.iris.product).%OpenId(oProduct)
	If ($IsObject(oProduct) = 0) Set oProduct = ##class(dc.iris.product).%New()
	Do:pDebug $System.OBJ.Dump(oProduct)
	Set oProduct.ClassName = "dc.iris.product"
	Set oProduct.MethodName = "RunScript"
	Set oProduct.RunCmd = "/opt/irisbuild/demo.sh"
	Set pRandom = "random"
	Set pOutput = "/opt/transform/practice/"
	Set pTemplate = "/usr/irissys/mgr/data/"
 	Set oProduct.RunParam1 = "$Qty"
	Set oProduct.RunParam2 = pRandom
 	Set oProduct.RunParam3 = pOutput
 	Set oProduct.RunParam4 = pTemplate
	Set oProduct.Name = pName
	//Set oProduct.TargetPath = "/opt/transform/practice/"
	Set tSC = oProduct.%Save()
	Quit tSC
}

ClassMethod GetProductId() As %String
{
	Quit 1
}

ClassMethod GetWorkPath() As %String
{
	Quit "/tmp/"
}

ClassMethod MakeFiles(
	pQuantity As %Integer = 1,
	pDebug As %Integer = 0) As %Status
{
	Set tSC = $$$OK
	If ($Get(pProductId) = "") Set pProductId = ..GetProductId()
	Set oProduct = ##class(dc.iris.product).%OpenId(pProductId)
	If ($IsObject(oProduct) = 0) {
		Set tSC = $$$ERROR($$$GeneralError,"No product defined")
		Quit tSC
	}
	Set tClassName = oProduct.ClassName
	Set tClassMethod = oProduct.MethodName
	Set tSC = $ClassMethod(tClassName,tClassMethod,oProduct,pQuantity)
	Set oProduct = ""
	Quit tSC
}

ClassMethod Manufacture(
	pProductId As %String = 2,
	pQuantity As %Integer = 1,
	pDebug As %Integer = 0) As %Status
{
	Set tSC = $$$OK
	If ($Get(pProductId) = "") Set pProductId = ..GetProductId()
	Set oProduct = ##class(dc.iris.product).%OpenId(pProductId)
	If ($IsObject(oProduct) = 0) {
		Set tSC = $$$ERROR($$$GeneralError,"No product defined")
		Quit tSC
	}
	Set tClassName = oProduct.ClassName
	Set tClassMethod = oProduct.MethodName
	Set tSC = $ClassMethod(tClassName,tClassMethod,oProduct,pQuantity)
	Set oProduct = ""
	Quit tSC
}

ClassMethod TestProductDefined() As %Status
{
	Set tSC = ..TestProductDefined1()
	If $$$ISERR(tSC) {
		Write $System.Status.GetErrorText(tSC)
		Quit tSC
	}
	Set tSC = ..TestProductDefined2()
	If $$$ISERR(tSC) {
		Write $System.Status.GetErrorText(tSC)
		Quit tSC
	}
	Quit $$$OK
}

ClassMethod TestProductDefined1() As %Status
{
	If ($Get(pProductId) = "") Set pProductId = ..GetProductId()
	Set oProduct = ##class(dc.iris.product).%OpenId(pProductId)
	If ($IsObject(oProduct) = 0) {
		Set tSC = ##class(dc.iris.facture).DefineProduct()
		Quit tSC
	}
	Quit $$$OK
}

ClassMethod TestProductDefined2() As %Status
{
	Set tSC = ..DefineProductScript()
	Quit tSC
}

}
