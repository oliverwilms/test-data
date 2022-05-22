Class Demo.RecordMap.Production Extends Ens.Production [ ProcedureBlock ]
{

XData ProductionDefinition
{
<Production Name="Demo.RecordMap.Production" LogGeneralTraceEvents="true">
  <Description>Sample Production to illustrate a simple input/output transformation using generated RecordMaps. NOTE: The source file, RecordMap.Delimited.Input.txt, and a sample output file, RecordMap.Delimited.Output.txt, should be located in [install_dir]/dev/RecordMap/.</Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Delimited.RecordMap.FileService" Category="" ClassName="EnsLib.RecordMap.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="File service to process files containing delimited records" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="RecordMap">Demo.RecordMap.Map.Delimited</Setting>
    <Setting Target="Host" Name="TargetConfigNames">BPL</Setting>
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Adapter" Name="FilePath">/opt/transform/practice</Setting>
    <Setting Target="Adapter" Name="FileSpec">RecordMap_Delimited_*</Setting>
  </Item>
  <Item Name="BPL" Category="" ClassName="dc.iris.bpl" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="FixedWidth.RecordMap.FileOperation" Category="" ClassName="EnsLib.RecordMap.Operation.FileOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="File operation to write data out into fixed width records" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Filename">RecordMap_FixedWidth_Output_from_%f</Setting>
    <Setting Target="Host" Name="RecordMap">Demo.RecordMap.Map.FixedWidth</Setting>
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Adapter" Name="FilePath">/opt/transform/practice</Setting>
  </Item>
  <Item Name="Demo2 File Service" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/opt/transform/practice</Setting>
    <Setting Target="Adapter" Name="FileSpec">DE*</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Stream Process</Setting>
  </Item>
  <Item Name="Passthrough Operation" Category="" ClassName="EnsLib.File.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Stream Process" Category="" ClassName="dc.iris.streamProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
</Production>
}

}
