Class dc.iris.dtl Extends Ens.DataTransformDTL [ DependsOn = (Demo.RecordMap.Map.Delimited.Record, Demo.RecordMap.Map.FixedWidth.Record) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Demo.RecordMap.Map.Delimited.Record' targetClass='Demo.RecordMap.Map.FixedWidth.Record' create='new' language='objectscript' >
<annotation>Create new fixed width record with unique SSN from delimited record</annotation>
<assign value='source.%Source' property='target.%Source' action='set' />
<assign value='source.PersonID' property='target.PersonID' action='set' />
<assign value='source.FirstName' property='target.FirstName' action='set' />
<assign value='source.MiddleInitial' property='target.MiddleInitial' action='set' />
<assign value='source.LastName' property='target.LastName' action='set' />
<assign value='source.DateOfBirth' property='target.DateOfBirth' action='set' />
<assign value='##class(dc.iris.ssn).GetNextSSN()' property='target.SSN' action='set' />
<assign value='source.HomeAddress.StreetLine1' property='target.HomeAddress.StreetLine1' action='set' />
<assign value='source.HomeAddress.City' property='target.HomeAddress.City' action='set' />
<assign value='source.HomeAddress.State' property='target.HomeAddress.State' action='set' />
<assign value='source.HomeAddress.ZipCode' property='target.HomeAddress.ZipCode' action='set' />
</transform>
}

}
