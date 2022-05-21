## test-data
This is an app to create test-data, possibly lots of test-data.

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation ZPM

```
USER>zpm "install test-data"
```

## Installation docker

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/oliverwilms/test-data.git
```

Open the terminal in this directory and run:

```
$ docker-compose build
```

3. Run the IRIS container with your project:

```
$ docker-compose up -d
```

## How to work with it

Open IRIS terminal:

```
$ docker-compose exec iris iris session iris
USER>
```

The first command needs to be run once
```
USER>Set ^UnitTestRoot="/opt/unittests"
```

This app utilizes a specific directory for UnitTests
```
USER>Do ##class(%UnitTest.Manager).RunTest("test-data","/loadudl")
```

Another example shows how to work with files and use pandas and numpy libs. 
It calculates the mean age of Titanic passengers:

```
USER>d ##class(dc.python.test).TitanicMeanAge()
mean age=29.69911764705882

```
