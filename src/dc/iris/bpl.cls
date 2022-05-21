/// business process to transform delimited recordmap record into fixed width recordmap record
Class dc.iris.bpl Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='450' >
<transform name='dtl' class='dc.iris.dtl.cls' source='request' target='response' xpos='200' ypos='250' />
<call name='FixedWidth FileOperation' target='FixedWidth.RecordMap.FileOperation' async='1' xpos='200' ypos='350' >
<request type='Demo.RecordMap.Map.FixedWidth.Record' >
<assign property="callrequest" value="response" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
