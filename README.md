Robot Framework Test Suites Demo
======================================

This repository contains the Robot Framework Demo workspace. The following topics are covered:

  - `Demo1_Basic` - robot framework scripts using the keywords from libraries
  - `Demo2_Refactored` - separation of variables, keywords into different .robot files and creation of higer level keywords
  - `Demo3_Composite` - creation of sub directories for variables
  - `Demo4_Extended` - extending robot framework for jenkins, report portal, docker-selenium. added option for headless chrome test exection and creation of higher level keywords

Directory Structure
-------------------
`common` contains custom Robot Framework libraries and keywords that will be
used by the test suites.

`DockerFiles` contains the docker compose file for docker-selenium

`JenkinsFiles` contains the Jenkins file using declarative pipeline syntax for test execution in parallel

`common\custom_libraries` contains the custom libraries

`common\global_resources` contains the step definitions, test data and global reusable keywords

`Demo4_Extended` contains the workspace for the composite and extended robot framework for http://automationpractice.com

`Demo4_Extended\src\demo\resources` contains the keywords specific for Demo4_Extended

For more information on the directory structure, especially how tests are
organized within the `src` directory.

Setup
-----
Clone this repository to your local directory.
Open a terminal and cd to `RobotFrameworkDemoWorkspace` where setup.py is located.
Run the following in the terminal:

```bash
pip install -e .
```

Running Tests
-------------

Include the `argument_file.txt` found at the top-level directory for non-changing arguments on run time. 
To run a particular test suite:

```bash
pybot --argumentfile argument_file.robot --variable BROWSER:chrome --variable BASE_URL:http://automationpractice.com --variable REMOTE_URL:False --suite AddProductToCartTest .
```

Tests may also be filtered using tags defined in a test suite's `Default Tags`
setting table:
```bash
pybot -A argument_file.robot -v BASE_URL:http://automationpractice.com -v BROWSER:chrome -v REMOTE_URL:False -v HEADLESS_CHROME:True -i REGRESSION .
```
Running Tests : Headless Chrome
-------------------------------
Running in Headless Chrome.
Set `HEADLESS_CHROME` to `True`.
```bash
pybot -A argument_file.robot -v BASE_URL:http://automationpractice.com -v BROWSER:chrome -v REMOTE_URL:False -v HEADLESS_CHROME:True -i LoginTest .
```

Running in non-headless Chrome.
Set `HEADLESS_CHROME` to `False`.
```bash
pybot -A argument_file.robot -v BASE_URL:http://automationpractice.com -v BROWSER:chrome -v REMOTE_URL:False -v HEADLESS_CHROME:False -i DataDrivenLoginTest .
```

Or remove the variable `HEADLESS_CHROME`
```bash
pybot -A argument_file.robot -v BASE_URL:http://automationpractice.com -v BROWSER:chrome -v REMOTE_URL:False -i DataDrivenLoginTest .
```
Running Tests : Other browsers
------------------------------
Running tests in `firefox` or other browsers, update the `BROWSER` value to the applicable browser.
```bash
pybot -A argument_file.robot -v BASE_URL:http://automationpractice.com -v BROWSER:firefox -v REMOTE_URL:False -i DataDrivenLoginTest .
```
Running Tests : Selenium Grid
-----------------------------
Running tests in Selenium Grid, set `REMOTE_URL` to `TRUE` or remove the `REMOTE_URL` variable.
NOTE: Run selenium grid first.
```bash
docker-compose -f DockerFiles/docker-compose.yml up
```
Then run the script on Remote URL using the following script.
```bash
pybot -A argument_file.robot -v BASE_URL:http://automationpractice.com -v BROWSER:firefox -v REMOTE_URL:True -i DataDrivenLoginTest .
```
Or
```bash
pybot -A argument_file.robot -v BASE_URL:http://automationpractice.com -v BROWSER:firefox -i DataDrivenLoginTest .
```
