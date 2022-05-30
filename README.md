## test-data
This is an app to create test-data, possibly lots of test-data.

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation ZPM

```
zpm "install test-data"
```

## Installation docker

Clone/git pull the repo into any local directory

```
git clone https://github.com/oliverwilms/test-data.git
```

Open the terminal in this directory and run:

```
docker-compose build
```

3. Run the IRIS container with your project:

```
docker-compose up -d
```

## Online Demo
You can find online demo here - [Management Portal](https://test-data.demo.community.intersystems.com/csp/sys/UtilHome.csp)

[webterminal](https://test-data.demo.community.intersystems.com/terminal/)


## test-data Unit Tests

Open IRIS terminal:

```
docker-compose exec iris iris session iris
```

The first command needs to be run once
```
Set ^UnitTestRoot="/opt/unittests"
```

This app utilizes a specific directory for UnitTests. The directory name, in this case test-data, is the name for a suite of tests and is also a child of the directory specified by ^UnitTestRoot. Running Manager.RunTest(“test-data”) runs all of the tests stored in the test-data directory.
Since we are using .cls files rather than XML files, we must supply the /loadudl qualifier to RunTest.
```
Do ##class(%UnitTest.Manager).RunTest("test-data","/loadudl")
```

```
===============================================================================
Directory: /opt/unittests/test-data/
===============================================================================
  test-data begins ...
Load of directory started on 05/29/2022 01:37:35 '*.xml;*.XML;*.cls;*.mac;*.int;
*.inc;*.CLS;*.MAC;*.INT;*.INC'

Loading file /opt/unittests/test-data/tests.cls as udl

Compilation started on 05/29/2022 01:37:35 with qualifiers '/loadudl'
Compiling class dc.iris.tests
Compiling routine dc.iris.tests.1
Compilation finished successfully in 0.057s.

Load finished successfully.

    dc.iris.tests begins ...
      TestDemo() begins ...
        LogMessage:0 RecordMap_FixedWidth* files before.
        AssertEquals:TestProductDefined (passed)
        LogMessage:tMakeFilesQuantity = 2
        AssertEquals:MakeFiles (passed)
        LogMessage:2 RecordMap_FixedWidth* files after 15 seconds.
        AssertEquals:FixedWidth Files count (passed)
        LogMessage:Duration of execution: 15.082821 sec.
      TestDemo passed
      TestDemo2() begins ...
        LogMessage:0 output_DE* files before.
        AssertEquals:TestProductDefined (passed)
        LogMessage:tMakeFilesQuantity = 2
        AssertEquals:Manufacture (passed)
        LogMessage:2 output_DE* files after 15 seconds.
        AssertEquals:Files count (passed)
        LogMessage:Duration of execution: 15.079037 sec.
      TestDemo2 passed
    dc.iris.tests passed
  test-data passed

Use the following URL to view the result:
http://127.0.0.1:57700/csp/sys/%25UnitTest.Portal.Indices.cls?Index=1&$NAMESPACE=USER
All PASSED
```

## How test-data is created

![screenshot](https://github.com/oliverwilms/bilder/blob/main/test-data.png)

The dc_iris.products table controls the test data creation. I used to copy a sample file for testing. The downside was I could only have one copy. The first product gets created by executing MakeFile. It copies a sample file and renames the copy to a unique filename allowing the process to be repeated as many times as the number of files you want to create. The sample file contains delimited data. The copies are placed in the TargetPath. I use a DTL to transform a delimited record into fixed width record and also update the SSN data field.

The second product executes RunScript. It utilizes a shell script that creates a new test file. I use a BPL to update certain records in the test file.

## UnitTest explained

TestDemo counts the files matching RecordMap_FixedWidth* before calling MakeFile with parameter 2 to create two files. The unit test waits 15 seconds to allow the Interoperability Production to complete and it counts the files matching RecordMap_FixedWidth* to confirm the desired number of files have been added.

TestDemo2 counts the files matching output_DE* before calling the shell script with parameter 2 to create two DE* files. There is a BPL that updates the stream representing DE files. The stream gets saved into a file named output_DE*. Within streamProcess BPL I use Python to get a maximum value for Quantity from a CSV file:
```
set q=##class(dc.python.test).MaxQuantity()
```
## Order some test-data

If you want to order 5 files of the first type and 6 files of the second type, enter the command below in IRIS terminal:

```
w ##class(dc.iris.testdata).order(5,6)
```

```
irisowner@52ca366da3d4:/opt/transform/practice$ ls -ltr
total 44
-rwxrw-r--. 1 irisowner irisowner 346 May 30 00:49 RecordMap_FixedWidth_Output_from_RecordMap_Delimited_Sample.txt_2022-05-30_00.49.43.731
-rwxrw-r--. 1 irisowner irisowner 346 May 30 00:49 RecordMap_FixedWidth_Output_from_RecordMap_Delimited_Sample.txt_2022-05-30_00.49.43.731_a1
-rwxrw-r--. 1 irisowner irisowner 346 May 30 00:49 RecordMap_FixedWidth_Output_from_RecordMap_Delimited_Sample.txt_2022-05-30_00.49.43.731_a2
-rwxrw-r--. 1 irisowner irisowner 346 May 30 00:49 RecordMap_FixedWidth_Output_from_RecordMap_Delimited_Sample.txt_2022-05-30_00.49.43.732
-rwxrw-r--. 1 irisowner irisowner 346 May 30 00:49 RecordMap_FixedWidth_Output_from_RecordMap_Delimited_Sample.txt_2022-05-30_00.49.43.732_a1
-rwxrw-r--. 1 irisowner irisowner 346 May 30 00:49 output_DEMO-00123510001_2022-05-30_00.49.48.178
-rwxrw-r--. 1 irisowner irisowner 346 May 30 00:49 output_DEMO-00317850002_2022-05-30_00.49.48.186
-rwxrw-r--. 1 irisowner irisowner 346 May 30 00:49 output_DEMO-00150150003_2022-05-30_00.49.48.192
-rwxrw-r--. 1 irisowner irisowner 346 May 30 00:49 output_DEMO-00066470004_2022-05-30_00.49.48.198
-rwxrw-r--. 1 irisowner irisowner 346 May 30 00:49 output_DEMO-00048760005_2022-05-30_00.49.48.205
-rwxrw-r--. 1 irisowner irisowner 346 May 30 00:49 output_DEMO-00167540006_2022-05-30_00.49.48.212
```
