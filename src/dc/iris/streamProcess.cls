/// business process to process a stream
Class dc.iris.streamProcess Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='450' >
<trace name='request' value='request' xpos='200' ypos='250' />
<call name='Passthrough Operation' target='Passthrough Operation' async='1' xpos='200' ypos='350' >
<request type='Ens.Request' >
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
