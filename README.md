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
You can find online demo here - [demo](https://test-data.demo.community.intersystems.com/csp/sys/UtilHome.csp)

## How to work with it

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
====================================
Directory: /opt/unittests/test-data/
====================================
  test-data begins ...
Load of directory started on 05/26/2022 01:57:03 '*.xml;*.XML;*.cls;*.mac;*.int;
*.inc;*.CLS;*.MAC;*.INT;*.INC'

Loading file /opt/unittests/test-data/tests.cls as udl

Compilation started on 05/26/2022 01:57:03 with qualifiers '/loadudl'
Compiling class dc.iris.tests
Compiling routine dc.iris.tests.1
Compilation finished successfully in 0.034s.

Load finished successfully.

    dc.iris.tests begins ...
      TestDemo() begins ...
        LogMessage:0 RecordMap_FixedWidth* files before.
        AssertEquals:TestProductDefined (passed)
        LogMessage:tMakeFilesQuantity = 2
        AssertEquals:MakeFiles (passed)
        LogMessage:2 RecordMap_FixedWidth* files after 15 seconds.
        AssertEquals:FixedWidth Files count (passed)
        LogMessage:Duration of execution: 15.085652 sec.
      TestDemo passed
      TestDemo2() begins ...
        LogMessage:0 DE* files before.
        AssertEquals:TestProductDefined (passed)
        LogMessage:tMakeFilesQuantity = 2
        AssertEquals:Manufacture (passed)
        LogMessage:2 DE* files after 1 second.
        AssertEquals:Files count (passed)
        LogMessage:Duration of execution: 1.081378 sec.
      TestDemo2 passed
    dc.iris.tests passed
  test-data passed

Use the following URL to view the result:
http://127.0.0.1:57700/csp/sys/%25UnitTest.Portal.Indices.cls?Index=1&$NAMESPACE=USER
All PASSED
```

I use Python to get a maximum value for Quantity from a CSV file:
```
USER>set q=##class(dc.python.test).MaxQuantity()

```
