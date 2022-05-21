Class dc.iris.ssn
{

/// Return unique SSN in order
ClassMethod GetNextSSN() As %String
{
	Set tNumeric = $Increment(^dcSSN)
	Set temp = 1000000000 + tNumeric
	Set tSSN = $Extract(temp,2,4)_"-"_$Extract(temp,5,6)_"-"_$Extract(temp,7,10)
	Quit tSSN
}

}
