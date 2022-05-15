Class dc.iris.tests Extends %UnitTest.TestCase
{

Method TestAdd()
{
 do $$$AssertEquals(##class(MyPackage.TestMe).Add(2,2),4, "Test Add(2,2)=4")
 do $$$AssertNotEquals(##class(MyPackage.TestMe).Add(2,2),5,"Test Add(2,2)'=5")
}

}
