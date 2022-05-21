Class dc.iris.util
{

ClassMethod ExecuteQueryOneValue(
	pQuery As %String,
	ByRef pResult As %String) As %Status
{
	Set pResult = ""
	Set rs = ##class(%ResultSet).%New()
	Set tSC = rs.Prepare(pQuery)
	If $$$ISOK(tSC) {
		Set tSC = rs.Execute()
		If $$$ISOK(tSC), rs.Next() Set pResult = rs.GetData(1)
	}
	Do rs.Close()
	Set rs = ""
	Quit tSC
}

ClassMethod FilesCount(
	pFilePath As %String = "",
	pWildcards As %String = "*",
	pIncludeDirs As %Boolean = 0) As %Integer
{
	Set $ZT="Trap",tSC=$$$OK
	do {
		Set tFilesCount = 0
		Set tResultSet=##class(%ResultSet).%New("%File:FileSet")
		Set tSC=tResultSet.Execute(pFilePath,pWildcards,"Type",pIncludeDirs)  Quit:$$$ISERR(tSC)
		While 0'=tResultSet.Next() {
			Set tFilesCount = tFilesCount + 1
		}
	} while (0)
Exit
	Quit tFilesCount
Trap
	Set $ZT="",tSC=$$$ERROR($$$GeneralError,"FileSet Error")
	Quit -1
}

/// Get a list of files in the directory configured by FilePath.
/// The filenames are returned in a %ListOfDataTypes object. Each entry in the list is
/// a semicolon-separated string containing: Filename;Type;Size;DateCreated;DateModified;FullPathName
ClassMethod FileSet(
	Output pFileList As %ListOfDataTypes,
	pFilePath As %String = "",
	pWildcards As %String = "*",
	pIncludeDirs As %Boolean = 0) As %Status
{
	Set $ZT="Trap",tSC=$$$OK
	do {
		Kill pFileList Set pFileList=##class(%ListOfDataTypes).%New()
		Set tResultSet=##class(%ResultSet).%New("%File:FileSet")
		Set tSC=tResultSet.Execute(pFilePath,pWildcards,"Type",pIncludeDirs)  Quit:$$$ISERR(tSC)
		While 0'=tResultSet.Next() {
			#; PathName;Type;Size;DateCreated;DateModified;Name
			Set tSC = pFileList.Insert(tResultSet.GetData(6)_";="_tResultSet.GetData(2)_";"_tResultSet.GetData(3)_";created="_tResultSet.GetData(4)_";modified="_tResultSet.GetData(5)_";"_tResultSet.GetData(1))  Quit:$$$ISERR(tSC)
		}
	} while (0)
Exit
	Quit tSC
Trap
	Set $ZT="",tSC=$$$ERROR($$$GeneralError,"FileSet Error")
	Goto Exit
}

}
