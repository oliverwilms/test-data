Class dc.iris.tests Extends %UnitTest.TestCase
{

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

}
