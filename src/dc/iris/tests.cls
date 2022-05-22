Class dc.iris.tests Extends %UnitTest.TestCase
{

ClassMethod Go() As %Status
{
	Set ^UnitTestRoot="/opt/unittests"
	Set tSC = ##class(%UnitTest.Manager).RunTest("test-data","/loadudl")
	Quit tSC
}

Method TestDemo()
{
	Set tDir = "/opt/transform/practice"
	Set tFilesDelimited = "RecordMap_Delimited_*"
	Set tFilesFixedWidth = "RecordMap_FixedWidth*"
	Set tCountDelimBefore = ##class(dc.iris.util).FilesCount(tDir,tFilesDelimited)
	Set tCountFixedBefore = ##class(dc.iris.util).FilesCount(tDir,tFilesFixedWidth)
	Set tSC = ##class(dc.iris.facture).TestProductDefined()
	Do $$$AssertEquals(tSC,1, "TestProductDefined")
	Set tMakeFilesQuantity = 2
	Set tSC = ##class(dc.iris.facture).MakeFiles(tMakeFilesQuantity)
	Do $$$AssertEquals(tSC,1, "MakeFiles")
	// Allow time to transform file(s)
	Hang 1
	Set tCountDelimAfter = ##class(dc.iris.util).FilesCount(tDir,tFilesDelimited)
	Set tCountFixedAfter = ##class(dc.iris.util).FilesCount(tDir,tFilesFixedWidth)
	Do $$$AssertEquals(tCountFixedAfter,(tCountFixedBefore+tMakeFilesQuantity),"FixedWidth Files count")
}

Method TestDemo2()
{
	Set tDir = "/opt/transform/practice"
	Set tFilesDemo2 = "DE*"
	Set tCountBefore = ##class(dc.iris.util).FilesCount(tDir,tFilesDemo2)
	Set tSC = ##class(dc.iris.facture).TestProductDefined()
	Do $$$AssertEquals(tSC,1, "TestProductDefined")
	Set tMakeFilesQuantity = 2
	Set tSC = ##class(dc.iris.facture).Manufacture(2,tMakeFilesQuantity)
	Do $$$AssertEquals(tSC,1, "Manufacture")
	// Allow time to transform file(s)
	Hang 1
	Set tCountAfter = ##class(dc.iris.util).FilesCount(tDir,tFilesDemo2)
	Do $$$AssertEquals(tCountAfter,(tCountBefore+tMakeFilesQuantity),"Files count")
}

}
