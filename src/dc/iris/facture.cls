Class dc.iris.facture
{

ClassMethod DefineProduct() As %Status
{
	Set tSC = ##class(dc.iris.product).%DeleteExtent()
	Set oProduct = ##class(dc.iris.product).%New()
	Set oProduct.ClassName = "dc.iris.product"
	Set oProduct.MethodName = "MakeFile"
	Set oProduct.SampleFile = "/opt/irisbuild/data/RecordMap_Delimited_Sample.txt"
	Set oProduct.Name = "Demo"
	Set oProduct.WorkFile = "/tmp/workfile."_oProduct.Name
	Set oProduct.WorkPath = ##class(%File).GetDirectory(oProduct.WorkFile)
	Set oProduct.TargetPath = "/opt/transform/practice/"
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

ClassMethod MakeFiles(pQuantity As %Integer = 1) As %Status
{
	If ($Get(pProductId) = "") Set pProductId = ..GetProductId()
	Set oProduct = ##class(dc.iris.product).%OpenId(pProductId)
	If ($IsObject(oProduct) = 0) {
		Set tSC = $$$ERROR($$$GeneralError,"No product defined")
		Quit tSC
	}
	Set tClassName = oProduct.ClassName
	Set tClassMethod = oProduct.MethodName
	For tCount = 1:1:pQuantity {
		Write tCount,!
		Set tReturn = $ClassMethod(tClassName,tClassMethod,oProduct)
		Continue
	}
	Set oProduct = ""
	Quit $$$OK
}

ClassMethod TestProductDefined() As %Status
{
	If ($Get(pProductId) = "") Set pProductId = ..GetProductId()
	Set oProduct = ##class(dc.iris.product).%OpenId(pProductId)
	If ($IsObject(oProduct) = 0) {
		Set tSC = ##class(dc.iris.facture).DefineProduct()
		Quit tSC
	}
	Quit $$$OK
}

}
