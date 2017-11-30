# Common Workflow Language on Galaxy

The aim is to implement a subset of CWL (Common Workflow Language) on a fork of Galaxy.
This is an alpha version.

First, local tests are done.


## Installation steps :

Installation steps are:

* Check python and cwl version
* Git clone Galaxy code
* Start Galaxy
* Test CWL tools

### Check versions and start Galaxy


```
$ python -V
Python 2.7.10
$ git clone https://github.com/common-workflow-language/galaxy.git
```

Galaxy code is now available. We have now to checkout cwl version.

```
$ cd galaxy/
$ git checkout cwl-1.0
Déjà sur 'cwl-1.0'
Votre branche est à jour avec 'origin/cwl-1.0'.
```

Then we can start Galaxy thanks to runs.sh file:

```
$ GALAXY_RUN_WITH_TEST_TOOLS=1 sh run.sh
Initializing config/migrated_tools_conf.xml from migrated_tools_conf.xml.sample
Initializing config/shed_tool_conf.xml from shed_tool_conf.xml.sample
Initializing config/shed_tool_data_table_conf.xml from shed_tool_data_table_conf.xml.sample
Initializing config/shed_data_manager_conf.xml from shed_data_manager_conf.xml.sample
Initializing tool-data/shared/ucsc/builds.txt from builds.txt.sample
Initializing tool-data/shared/ucsc/manual_builds.txt from manual_builds.txt.sample
Initializing static/welcome.html from welcome.html.sample
Fetching https://pypi.python.org/packages/source/v/virtualenv/virtualenv-13.1.2.tar.gz
```

At the end of the installation, STDOUT message gives us the PID process of Galaxy and the URL adress to open Galaxy (localhost):

```
Starting server in PID 5769.
serving on http://127.0.0.1:8080
```

### Test CWL tools in Galaxy


CWL test tools can be seen in the tool panel. ???


Question : where are CWL tools ?

```
$ find . -type f -name "*cwl*"
./doc/source/lib/galaxy.tools.cwl.rst
./lib/galaxy/tools/expressions/cwlNodeEngine.js
./lib/galaxy/tools/parser/cwl.py
./lib/galaxy/tools/parser/cwl.pyc
./lib/galaxy/tools/cwl/cwltool_deps.py
./lib/galaxy/tools/cwl/cwltool_deps.pyc
./.git/logs/refs/heads/cwl-1.0
./.git/refs/heads/cwl-1.0


$ ls test/unit/tools/cwl_tools/v1.0
```


[CWL test tools on Galaxy tool panel](images/cwltools.jpg)

### Tests in command line

* Test 1:

```
cd galaxy/
$ ./run_tests.sh -api test/api/test_tools_cwl.py
```

Tests results:

```
galaxy.jobs.handler INFO 2017-11-30 12:05:15,880 job handler stop queue stopped
Testing complete. HTML report is in "./run_api_tests.html".
```
run_api_tests.html file is empty !


* Test 2:

```
cd galaxy/
./run_tests.sh -api test/api/test_workflows_cwl.py
```

Result : Testing complete. HTML report is in "./run_api_tests.html".

[Run API tests 2](images/run_api_tests.png)

* Test 3

```
cd galaxy/
./run_tests.sh -api test/api/test_cwl_conformance_v1_0.py
```

Result : Testing complete. HTML report is in "./run_api_tests.html".

[Run API tests 3](images/test3.png)

## Issues :


* Impossible to find CWL tools in Galaxy tool menu.
* Tests in command line : tests run, but no log files.



## Run CWL jobs in Docker containers (not tested yet)

First add a Docker destination in the job configuration file (config/job_conf.xml) 


```
<?xml version="1.0"?>
<!-- minimal docker job conf, see https://github.com/apetkau/galaxy-hackathon-2014
     for more information on running Galaxy jobs within Docker.
-->
<job_conf>
    <plugins>
        <plugin id="local" type="runner" load="galaxy.jobs.runners.local:LocalJobRunner" workers="4"/>
    </plugins>
    <handlers>
        <handler id="main"/>
    </handlers>
    <destinations>
        <destination id="local" runner="local">
             <param id="docker_enabled">true</param>
             <!-- set following value to false to not use sudo to execute docker commands. -->
             <param id="docker_sudo">true</param>
        </destination>
    </destinations>
</job_conf>
```

Source : [CWL in Docker GitHub Pages](https://gist.github.com/jmchilton/3997fa471d1b4c556966)

## Documentation :

1 - Implement a subset of the Common Workflow Language. #47
Source : [GitHub Pages](https://github.com/common-workflow-language/galaxy/pull/47) 

2 - Issues:
https://github.com/common-workflow-language/galaxy/issues


## ToolDog to generate CWL template for Galaxy (not tested yet) :

ToolDog (TOOL DescriptiOn Generator) aims to generate XML template for Galaxy or CWL from the description of tools from Bio.tools.
Source : [ToolDog GitHub Pages](https://github.com/bio-tools/ToolDog)

Requirements : jupyter + Docker

