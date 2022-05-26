/// business process to process a stream
Class dc.iris.streamProcess Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='Position' type='%Integer' initialexpression='0' instantiate='0' />
<property name='Count' type='%Integer' instantiate='0' />
<property name='Delim' type='%String' initialexpression='$Char(10)' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='String' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='9999' />
</parameters>
</property>
<property name='Record' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='4999' />
</parameters>
</property>
</context>
<sequence xend='200' yend='850' >
<assign name="response" property="response" value="request" action="set" xpos='200' ypos='250' />
<assign name="response.Stream.Rewind()" property="tSC" value="response.Stream.Rewind()" action="set" xpos='200' ypos='350' />
<assign name="String" property="context.String" value="request.Stream.Read(.len,.sc)" action="set" xpos='200' ypos='450' />
<assign name="Count" property="context.Count" value="$Length(context.String,context.Delim)" action="set" xpos='200' ypos='550' />
<while name='(Position &lt; Count)' condition='(context.Position &lt; context.Count)' xpos='200' ypos='650' xend='200' yend='1300' >
<assign name="Increment Position" property="context.Position" value="context.Position+1" action="set" xpos='200' ypos='250' />
<assign name="Record" property="context.Record" value="$Piece(context.String,context.Delim,context.Position)" action="set" xpos='200' ypos='350' />
<switch name='Segment Type' xpos='200' ypos='550' xend='200' yend='1000' >
<case condition='$Piece(context.Record,"^",1)="LIN"' name='LIN' >
<assign name="tQty" property="tQty" value="##class(dc.python.test).MaxQuantity()" action="set" xpos='335' ypos='700' >
<annotation><![CDATA[Use Python to get this value]]></annotation>
</assign>
<assign name="Record" property="context.Record" value="$Piece(context.Record,&quot;^&quot;,1,4)_&quot;^&quot;_tQty_&quot;^&quot;_$Piece(context.Record,&quot;^&quot;,6,*)" action="set" xpos='335' ypos='900' />
</case>
<default name='default' />
</switch>
<assign name="response.Stream.Write" property="tSC" value="response.Stream.Write(context.Record_context.Delim)" action="set" xpos='200' ypos='1200' />
</while>
<call name='Passthrough Operation' target='Passthrough Operation' async='1' xpos='200' ypos='750' >
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
