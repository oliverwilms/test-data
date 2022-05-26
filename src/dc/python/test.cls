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

ClassMethod MaxQuantity() As %String
{
  Set maxq = ""
  Try {
    Set td = ##class(%SYS.Python).Import("test-data")
    Set file = $System.Util.ManagerDirectory()_"data/QuantityOnHandSync.csv"
    Set maxq = td.maxqty(file)
  }
  Catch exp {
    IF 1=exp.%IsA("%Exception.SystemException") {
      WRITE "System exception",!
      WRITE "Name: ",$ZCVT(exp.Name,"O","HTML"),!
      WRITE "Location: ",exp.Location,!
      WRITE "Code: "
    }
    ELSEIF 1=exp.%IsA("%Exception.SQL") {
      WRITE "SQL exception",!
      WRITE "SQLCODE: "
    }
    ELSEIF 1=exp.%IsA("%Exception.StatusException") {
      WRITE "%Status exception",!
      DO $SYSTEM.Status.DisplayError(exp.AsStatus())
    }
    ELSEIF 1=exp.%IsA("%Exception.General") {
      WRITE "General ObjectScript exception",!
      WRITE "Name: ",$ZCVT(exp.Name,"O","HTML"),!
      WRITE "Code: "
    }
    ELSE { WRITE "Some other type of exception",! }
    WRITE exp.Code,!
    WRITE "Data: ",exp.Data,!     
  }
  Return maxq
}

ClassMethod Source() As %String
{
  Set sc = $$$OK
  Set td = ##class(%SYS.Python).Import("test-data")
  Set source = td.source()
  Return source
}

ClassMethod Target() As %String
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
