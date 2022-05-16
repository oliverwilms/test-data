Class Demo.RecordMap.Production Extends Ens.Production [ ProcedureBlock ]
{

XData ProductionDefinition
{
<Production Name="Demo.RecordMap.Production" LogGeneralTraceEvents="false">
  <Description>Sample Production to illustrate a simple input/output transformation using generated RecordMaps. NOTE: The source file, RecordMap.Delimited.Input.txt, and a sample output file, RecordMap.Delimited.Output.txt, should be located in [install_dir]/dev/RecordMap/.</Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Delimited.RecordMap.FileService" Category="" ClassName="EnsLib.RecordMap.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="File service to process files containing delimited records" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="RecordMap">Demo.RecordMap.Map.Delimited</Setting>
    <Setting Target="Host" Name="TargetConfigNames">FixedWidth.RecordMap.FileOperation</Setting>
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Adapter" Name="FilePath">C:\Practice\in\</Setting>
    <Setting Target="Adapter" Name="FileSpec">RecordMap_Delimited_*</Setting>
    <Setting Target="Adapter" Name="ArchivePath">C:\Practice\out</Setting>
  </Item>
  <Item Name="FixedWidth.RecordMap.FileOperation" Category="" ClassName="EnsLib.RecordMap.Operation.FileOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="File operation to write data out into fixed width records" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Filename">RecordMap_FixedWidth_Output.txt</Setting>
    <Setting Target="Host" Name="RecordMap">Demo.RecordMap.Map.FixedWidth</Setting>
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Adapter" Name="FilePath">C:\Practice\out\</Setting>
  </Item>
</Production>
}

}
