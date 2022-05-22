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
	Do ..LogMessage(tCountFixedBefore_" "_tFilesFixedWidth_" files before.")
	Set tSC = ##class(dc.iris.facture).TestProductDefined()
	Do $$$AssertEquals(tSC,1, "TestProductDefined")
	Set tMakeFilesQuantity = 2
	Do ..LogMessage("tMakeFilesQuantity = "_tMakeFilesQuantity)
	Set tSC = ##class(dc.iris.facture).MakeFiles(tMakeFilesQuantity)
	Do $$$AssertEquals(tSC,1, "MakeFiles")
	// Allow time to transform file(s)
	// Call Interval = 5
	// File Access Timeout = 2
	Hang 15
	Set tCountDelimAfter = ##class(dc.iris.util).FilesCount(tDir,tFilesDelimited)
	Set tCountFixedAfter = ##class(dc.iris.util).FilesCount(tDir,tFilesFixedWidth)
	Do ..LogMessage(tCountFixedAfter_" "_tFilesFixedWidth_" files after 15 seconds.")
	Do $$$AssertEquals(tCountFixedAfter,(tCountFixedBefore+tMakeFilesQuantity),"FixedWidth Files count")
}

Method TestDemo2()
{
	Set tDir = "/opt/transform/practice"
	Set tFilesDemo2 = "DE*"
	Set tCountBefore = ##class(dc.iris.util).FilesCount(tDir,tFilesDemo2)
	Do ..LogMessage(tCountBefore_" "_tFilesDemo2_" files before.")
	Set tSC = ##class(dc.iris.facture).TestProductDefined()
	Do $$$AssertEquals(tSC,1, "TestProductDefined")
	Set tMakeFilesQuantity = 2
	Do ..LogMessage("tMakeFilesQuantity = "_tMakeFilesQuantity)
	Set tSC = ##class(dc.iris.facture).Manufacture(2,tMakeFilesQuantity)
	Do $$$AssertEquals(tSC,1, "Manufacture")
	// Allow time to transform file(s)
	Hang 1
	Set tCountAfter = ##class(dc.iris.util).FilesCount(tDir,tFilesDemo2)
	Do ..LogMessage(tCountAfter_" "_tFilesDemo2_" files after 1 second.")
	Do $$$AssertEquals(tCountAfter,(tCountBefore+tMakeFilesQuantity),"Files count")
}

}
