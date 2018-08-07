Robot Framework Test Suites Demo
======================================

This repository contains our entire Robot Framework Demo workspace
the covering the following:

  - Basic - bare bones robot framework script
  - Refactored - separating the variables, keywords into different .robot files
  - Composite - creating sub directories for variables, custom libraries and creating argument file to contain the variables
  - Extended - extending robot framework for jenkins, report portal, docker-selenium

Directory Structure
-------------------
`common` contains custom Robot Framework libraries and keywords that will be
used by the test suites.

`externals` contains extensions for external libraries by for the development /
deployment workflow but not by Robot Framework itself.

`src` contains the actual Robot Framework test suites.

`test_runner` contains helper scripts for running the test suites.

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

Tests must be invoked to include the `argument_file.txt` found at the
top-level directory. To run a particular test suite:

```bash
pybot --argumentfile argument_file.robot --variable BROWSER:chrome --variable BASE_URL:http://automationpractice.com --variable REMOTE_URL:False --suite AddProductToCartTest -d Results .
```

Tests may also be filtered using tags defined in a test suite's `Default Tags`
setting table:
```bash
pybot --argumentfile argument_file.robot -v BASE_URL:http://automationpractice.com -v BROWSER:chrome -v REMOTE_URL:False -v HEADLESS_CHROME:True -i REGRESSION -d Results .
```
Running in Headless Chrome.
Set HEADLESS_CHROME to True
```bash
pybot --argumentfile argument_file.robot -v BASE_URL:http://automationpractice.com -v BROWSER:chrome -v REMOTE_URL:False -v HEADLESS_CHROME:True -i LoginTest -d Results .
```

Running in non-headless Chrome.
Set HEADLESS_CHROME to False.
```bash
pybot --argumentfile argument_file.robot -v BASE_URL:http://automationpractice.com -v BROWSER:chrome -v REMOTE_URL:False -v HEADLESS_CHROME:False -i DataDrivenLoginTest -d Results .
```

Or remove the variable HEADLESS_CHROME
```bash
pybot --argumentfile argument_file.robot -v BASE_URL:http://automationpractice.com -v BROWSER:chrome -v REMOTE_URL:False -i DataDrivenLoginTest -d Results .
```

Running tests in firefox or other browsers, update the BROWSER value to the applicable browser.
```bash
pybot --argumentfile argument_file.robot -v BASE_URL:http://automationpractice.com -v BROWSER:firefox -v REMOTE_URL:False -i DataDrivenLoginTest -d Results .
```

Running tests in Selenium Grid, set REMOTE_URL to TRUE or remove the REMOTE_URL variable.
NOTE: Run selenium grid first.
```bash
docker-compose -f DockerFiles/docker-compose.yml up
```
Then run the script on Remote URL using the followng script.
```bash
pybot --argumentfile argument_file.robot -v BASE_URL:http://automationpractice.com -v BROWSER:firefox -v REMOTE_URL:True -i DataDrivenLoginTest -d Results .
```
Or
```bash
pybot --argumentfile argument_file.robot -v BASE_URL:http://automationpractice.com -v BROWSER:firefox -i DataDrivenLoginTest -d Results .
```
