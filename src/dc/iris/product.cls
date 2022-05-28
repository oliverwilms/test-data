Include Ensemble

Class dc.iris.product Extends %Persistent
{

Property Name As %String;

Property ClassName As %String;

Property MethodName As %String;

Property SampleFile As %String;

Property TargetPath As %String;

/// Filename may avoid processing early before FileRename
Property WorkFile As %String;

Property WorkPath As %String;

/// Transform the given filename <var>pFilename</var> according the the timestamp and uniqueness construction specification string <var>pSpec</var>.
/// The <var>pSpec</var> argument consists of literal characters and zero or more format codes. A format code is preceded by a
/// percent sign (%); characters that are not part of a format code are output unchanged.<br/>
/// Timestamp format codes are documented in the method <var>FormatDateTime()</var> in class <class>Ens.Util.Time</class> <br/>.
/// In addition the following filename-related enhancements are supported: <br/>
/// <ul>
/// <li>In the final output string, spaces (' ') are replaced by underbars ('_'), slashes ('/') replaced by hyphens ('-') and colons (':') replaced by dots ('.'), except on VMS 
///  where both slashes ('/') and colons (':') are instead replaced by hyphens ('-').</li>
/// <li>The <var>pFilename</var> input argument is stripped of the characters (|,?,\,/,:,[,],&lt;,&gt;,&amp;,,,;,NUL,BEL,TAB,CR,LF) before being
///  inserted as replacement text for the %f and %F format codes.</li>
/// <li>The additional format code '+' is supported to guarantee filename uniqueness by incrementing a counter string.
/// This additional code is supported in the following forms, where nn is an alphanumeric counter string of 0 or more characters: <br/>
///  <ul>
///  <li>%+(nn) -  If <var>pLocal</var> is true, increment <var>nn</var> until the generated filename does not exist in the target directory specified by <var>pDirectory</var> </li>
///  <li>%#+(nn) - If <var>pLocal</var> is true, increment <var>nn</var> omitting leading non-significant 0/a characters </li>
///  <li>%!+(nn) - If <var>pLocal</var> is true, only use <var>nn</var> if the base filename already exists </li>
///  <li>%#!+(nn) or %!#+(nn) - If <var>pLocal</var> is true, omit <var>nn</var> if the filename without it does not exist already, otherwise use <var>nn</var> but omit leading non-significant 0/a characters within it </li>
///  <li>%$+(nn) - increment <var>nn</var> without testing for existence of the resulting filename; if <var>pLocal</var> is true then re-increment while the resulting filename exists </li>
///  <li>%#$+(nn) or %$#+(nn) - increment <var>nn</var> regardless without testing for existence, omitting leading non-significant 0/a characters </li>
/// <br/>
/// Thus the '#' character means to output only the rightmost significant (non-zero,non- a/A) alphanumeric characters, the '!' means to only use <var>nn</var> if needed to
/// create a unique local filename, and '$' means to increment <var>nn</var> for each call regardless of the local filesystem.
/// The '$' form can be used to generate a series of filenames on a local or remote filesystem. This form relies on a counter variable in $$$EnsStaticAppData("Ens.Util.File:CreateTimestamp").
/// <br/>
/// The counter string <var>nn</var> may also contain non-alphanumeric characters. If these are present they are output unchanged as literal characters.
/// To ensure a unique filename, first the filename including string <var>nn</var> is checked for existence, and if that already exists the string is incremented in its rightmost alphanumeric character first.
/// Digits are incremented in the range 0-9, and alphabetic characters are incremented in the ranges a-z and A-Z. If the entire range represented by nn is exhausted, additional digits/letters will be prepended as needed.</li>
/// </ul>
/// For example, the string %F_%Q_%!#+(.a1) means the input filename is returned with a timestamp appended, and if a file like that already exists then .1 is
/// further appended, and if that also exists already then .2 is appended, and so on, up to .9, then to .a1, then up to .z9, and beyond that to .az1 and so on.
/// Only one '%+' format code is supported in a given format spec string. <br/>
/// The timestamp string returned always reflects the current time, converted to the timezone specified using the %K format code.
/// 
ClassMethod CreateTimestamp(
	pFilename As %String = "",
	pSpec As %String = "%f_%Q",
	pIsVMS As %Boolean = {$$$isVMS},
	pDirectory As %String = "",
	pLocal As %Boolean = 1) As %String
{
#define countable(%c)  ((($A(%c)>=$A(0))&&($A(%c)<=$A(9)))||(($A(%c)>=$A("a"))&&($A(%c)<=$A("z")))||(($A(%c)>=$A("A"))&&($A(%c)<=$A("Z"))))

	Set:""=pDirectory pLocal=0 ; must have a directory to check local file existence
	Set tf=$TR(pFilename,"|?\/:[]<>&,;"_$C(0,7,9,10,13))
	Set ts=$TR(##class(Ens.Util.Time).FormatDateTime(pSpec,tf), "/ :", "-_"_$S(pIsVMS:"-",1:"."))
	If pIsVMS { ; replace with hyphen all but last dot in final 4 chars of filename
		Set $P(ts,".",1,$L(ts,".")-1)=$TR($P(ts,".",1,$L(ts,".")-1),".","-") ; leave only last dot
		Set:$E(ts,1,*-4)["." ts=$TR(ts,".","-") ; replace it too if it's not in the last 4 chars
	}
	#; Find the first '+' code
	Set pp=1,tFound=""  For { Set pp=$F(ts,"%",pp)  Quit:'pp
		Set (tFound,tType,tStrip)=""  For pc=pp:1 { Set c=$E(ts,pc)
			If c = "!"   { Quit:$L(tType)  Set tType="!" }
			ElseIf c="$" { Quit:$L(tType)  Set tType="$" }
			ElseIf c="#" { Quit:tStrip  Set tStrip=1 }
			ElseIf c="+" { If tFound { Set tFound=0  Quit } Set tFound=1, nn="" }
			ElseIf c="(" && tFound { Set p2=$F(ts,")",pc)  If 'p2 { Set tFound=0 } Else { Set p2=p2-1, pp=pp-1, nn=$E(ts,pc+1,p2-1) } Quit }
			Else { Set:tFound p2=pc-1, pp=pp-1, nn=""  Quit }
		}
		Quit:tFound
		Set pp=pc
	}
	Set m=pDirectory_ts
 	Quit:'tFound m

	Set pp=pp+$L(pDirectory), pc=p2+$L(pDirectory) ; positions of starting percent and close paren

	#; If $ mode, do filesystem-ignoring increment
	If "$"=tType {
		Set hh=$$hash(pDirectory_pSpec_$S(pSpec?.E1"%".1"$"1(1"f",1"F").E:pFilename,1:""))
		Set tso="" For { Set tso=$O($$$EnsStaticAppData("Ens.Util.File:CreateTimestamp",hh,tso))  Quit:""=tso  Kill:tso'=ts $$$EnsStaticAppData("Ens.Util.File:CreateTimestamp",hh,tso) } ; garbage collect old timestamps
		Set cso=$G($$$EnsStaticAppData("Ens.Util.File:CreateTimestamp",hh,ts))
 		Set cs=$S(""=cso:$S(tStrip:$$strip(nn), $$any(nn):nn, 1:$$incr(nn,0,"")), 1:$$incr(nn,tStrip,cso)), tFilePath=m, $E(tFilePath,pp,pc)=cs
		Set $$$EnsStaticAppData("Ens.Util.File:CreateTimestamp",hh,ts)=cs
		Quit tFilePath
	}
	Quit:'pLocal m

	#; Increment nn to avoid duplicate filenames in the local filesystem
	#; note that competing jobs can still receive colliding filenames because this code tests for existence but does not prevent another caller from constructing the same filename
	Set tFilePath=m
	Set cs=$S("!"=tType:"", tStrip:$$strip(nn), $$any(nn):nn, 1:$$incr(nn,0,"")), $E(tFilePath,pp,pc)=cs
 ;w:1 "trying "_cs_":"_tFilePath,!
	While ##class(%File).Exists(tFilePath) {
 		Set cs=$S(""=cs:$S(tStrip:$$strip(nn), $$any(nn):nn, 1:$$incr(nn,0,"")), 1:$$incr(nn,tStrip,cs)), tFilePath=m, $E(tFilePath,pp,pc)=cs
 ;w:1 "trying "_cs_":"_tFilePath,!
	}
	Quit tFilePath

hash(s)
	Quit $S($L(s)<=230:s, 1:$E(s,1,220)_".x"_$$$NUM($ZHex($ZCRC($E(s,221,*),7)),8))

strip(num)
	Set onum="", lastc=0, any=0
	Set ll=$L(num)  For ipos=1:1:ll { Set cc=$E(num,ipos)
		If any||$Case(cc,"a":0,"A":0,"0":0,:1) Set onum=onum_cc  Set:$$$countable(cc) any=1  Continue
		Set:'any lastc=$L(onum)_"|"_cc
	}
	Quit:'any&&'lastc onum_"1"
	Set:'any $E(onum,+lastc)=$E(onum,+lastc)_$P(lastc,"|",2)
	Quit onum

any(num) ; see if 'num' string contains any countable characters
	Set any=0, ll=$L(num)  For ipos=1:1:ll { Set cc=$E(num,ipos)
		If $$$countable(cc) Set any=1  Quit
	}
	Quit any

incr(spec,stripflag,prev)
	Set:""=prev prev=$S(stripflag:$$strip(spec),1:spec)
	
	#; find first countable char in spec
	Set next=prev
	Set ls=$L(spec)  For i1st=1:1:ls+1 { Set c1=$E(spec,i1st) Quit:$$$countable(c1) }

	#; working back from the end, increment countable chars until no carry needed
 	Set carry=1,c1=0,ln=$L(next),is=ls
	For i1=ln:-1:i1st-1 { Set c1=$E(next,i1)
		If '$$$countable(c1) {
			Set c2=$E(spec,is)
			Continue:'$$$countable(c2)
			Set:+c2=c2 c2=1
			Set carry=0, $E(next,i1)=c1_c2
			Quit
		}
		Set c1=$C($A(c1)+1), c1=$Case(c1,":":0,"{":"a","[":"A",:c1), $E(next,i1)=c1, carry=$Case(c1,0:1,"a":1,"A":1,:0)
		Quit:'carry
		Set is=is-1
	}
	Set:carry $E(next,i1st)=$Case(c1,"a":"a","A":"A",:1)_$E(next,i1st)
	Quit next
}

ClassMethod GetFileRename(
	pFilename As %String,
	pSpec As %String,
	pIsVMS As %Boolean,
	pDirectory As %String,
	pLocal As %Boolean) As %String
{
	#; Override to use FilePath as pDirectory in case %+ file existence-checking is called for
	Set:'$D(pDirectory)#2 pDirectory = ..GetWorkPath()
	//Set tFileRename = ##class(Ens.Util.File).CreateTimestamp(.pFilename,.pSpec,.pIsVMS,pDirectory,.pLocal)
	Set tFileRename = ..CreateTimestamp(.pFilename,.pSpec,.pIsVMS,pDirectory,.pLocal)
	Quit tFileRename
}

ClassMethod GetWorkPath() As %String
{
	Quit "/tmp/"
}

ClassMethod MakeFile(pProduct) As %Status
{
	Set tSC = $$$OK
	Set oProduct = $Get(pProduct)
	If ($IsObject(oProduct) = 0) {
		Set oProduct = ##class(dc.iris.product).%OpenId(pProduct)
	}
	If ($IsObject(oProduct) = 0) {
		Set tSC = $$$ERROR($$$GeneralError,"No product defined")
		Quit tSC
	}
	Set tSampleFile = oProduct.SampleFile
	Set tExist = ##class(%File).Exists(tSampleFile)
	If (tExist = 0) {
		Set tSC = $$$ERROR($$$GeneralError,tSampleFile_" does not exist")
		Quit tSC
	}
	Set tWorkFile = oProduct.WorkFile
	Set tWorkPath = oProduct.WorkPath
	Set tExist = ##class(%File).DirectoryExists(tWorkPath)
	If (tExist = 0) {
		Set tSC = $$$ERROR($$$GeneralError,tWorkPath_" is not a directory")
		Quit tSC
	}
	Set tTargetPath = oProduct.TargetPath
	If (tTargetPath = "") Set tTargetPath = tWorkPath
	Set tExist = ##class(%File).DirectoryExists(tTargetPath)
	If (tExist = 0) {
		Set tSC = $$$ERROR($$$GeneralError,tTargetPath_" is not a directory")
		Quit tSC
	}
	Set tSampleFilename = ##class(%File).GetFilename(tSampleFile)
	If (tWorkFile = "") Set tWorkFile = tWorkPath_tSampleFilename
	/*
	If (tSampleFile = tWorkFile) {
		Set tWorkFile = tWorkPath_"COPY_"_tSampleFilename
	}
	*/
	Set tBool = ##class(%File).CopyFile(tSampleFile,tWorkFile)
	If (tBool = 0) {
		Set tSC = $$$ERROR($$$GeneralError,"Unable to copy file")
		Quit tSC
	}
	Set tSpec = "%f_%Q%!+(_a1)"
	Set tTarget = ..GetFileRename(tSampleFilename,tSpec,,tTargetPath)
	Set tRename = ##class(%File).Rename(tWorkFile,tTarget)
	If (tRename = 0) {
		Set tSC = $$$ERROR($$$GeneralError,"Unable to rename file")
		Quit tSC
	}
	Quit tSC
}

ClassMethod MakeFiles(
	pProduct,
	pQuantity) As %Status
{
	Set tSC = $$$OK
	Set pQuantity = $Get(pQuantity,1)
	For ii = 1:1:pQuantity {
		Set tSC = ..MakeFile($Get(pProduct))
	}
	Quit tSC
}

ClassMethod RunScript(
	pProduct,
	pQuantity) As %Status
{
	Set tSC = $$$OK
	Set oProduct = $Get(pProduct)
	If ($IsObject(oProduct) = 0) {
		Set oProduct = ##class(dc.iris.product).%OpenId(oProduct)
	}
	If ($IsObject(oProduct) = 0) {
		Set tSC = $$$ERROR($$$GeneralError,"No product defined")
		Quit tSC
	}
	//Set pCmd = "/irisrun/repo/demo.sh"  // This does NOT work in Online Demo
	Set pCmd = "/opt/irisbuild/demo.sh"
	Set pNumberOfFiles = $Get(pQuantity,1)
	Set pRandom = "random"
	Set pOutput = "/opt/transform/practice/"
	Set pTemplate = "/usr/irissys/mgr/data/"
	Set args=4
 	Set args(1) = pNumberOfFiles
	Set args(2) = pRandom
 	Set args(3) = pOutput
 	Set args(4) = pTemplate
	Set tReturn = $ZF(-100,"/SHELL",pCmd,.args)
	Quit tSC
}

Storage Default
{
<Data name="productDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>ClassName</Value>
</Value>
<Value name="4">
<Value>MethodName</Value>
</Value>
<Value name="5">
<Value>SampleFile</Value>
</Value>
<Value name="6">
<Value>WorkFile</Value>
</Value>
<Value name="7">
<Value>WorkPath</Value>
</Value>
<Value name="8">
<Value>TargetPath</Value>
</Value>
</Data>
<DataLocation>^dc.iris.productD</DataLocation>
<DefaultData>productDefaultData</DefaultData>
<ExtentSize>1</ExtentSize>
<IdLocation>^dc.iris.productD</IdLocation>
<IndexLocation>^dc.iris.productI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="ClassName">
<AverageFieldSize>17</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="MethodName">
<AverageFieldSize>10</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="Name">
<AverageFieldSize>6</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="SampleFile">
<AverageFieldSize>52</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="TargetPath">
<AverageFieldSize>26</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="WorkFile">
<AverageFieldSize>20</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="WorkPath">
<AverageFieldSize>7</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^dc.iris.productS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
