Class dc.python.test
{

ClassMethod HelloWorld() As %Status
{
  Set sc = $$$OK
  Set b = ##class(%SYS.Python).Import("builtins")
  Do b.print("Hello world")
  Return sc
}

ClassMethod Today() As %Status
{
  Set sc = $$$OK
  Set dt = ##class(%SYS.Python).Import("datetime")
  write dt.date.today().isoformat()
  Return sc
}

ClassMethod MaxQuantity() As %Status
{
  Set sc = $$$OK
  Set td = ##class(%SYS.Python).Import("test-data")
  Set file = $System.Util.ManagerDirectory()_"data/QuantityOnHandSync.csv"
  Set maxq = td.maxqty(file)
  Return maxq
}

ClassMethod Source() As %Status
{
  Set sc = $$$OK
  Set td = ##class(%SYS.Python).Import("test-data")
  Set source = td.source()
  Return source
}

ClassMethod Target() As %Status
{
  Set sc = $$$OK
  Set td = ##class(%SYS.Python).Import("test-data")
  Set target = td.target()
  Return target
}

/// Titanic
ClassMethod TitanicMeanAge() As %Status
{
    Set sc = $$$OK
    set tt=##class(%SYS.Python).Import("sample")
    set path=$System.Util.ManagerDirectory()_"data/titanic.csv"
    write "mean age="_tt.meanage(path)
    Return sc
}

}
