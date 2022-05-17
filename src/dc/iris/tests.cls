Class dc.iris.tests Extends %UnitTest.TestCase
{

Method TestDemo()
{
	Set tSC = ##class(dc.iris.facture).TestProductDefined()
	Do $$$AssertEquals(tSC,1, "TestProductDefined")
	Set tSC = ##class(dc.iris.facture).MakeFiles()
	Do $$$AssertEquals(tSC,1, "MakeFiles")
 //do $$$AssertNotEquals(##class(MyPackage.TestMe).Add(2,2),5,"Test Add(2,2)'=5")
}

}
