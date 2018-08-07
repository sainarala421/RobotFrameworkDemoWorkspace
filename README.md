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

Prerequisites
--------------
- [Python 2.7](https://www.python.org/download/releases/2.7/)
- `Web browsers. Note the supported web driver version for web drivers`

Optional Applications
--------------
- [Jenkins war file](https://jenkins.io/download/)
- [Java](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
- [Report Portal](http://reportportal.io/)
- [Docker](https://www.docker.com/)
- [docker-Selenium](https://github.com/SeleniumHQ/docker-selenium)
- `git repository for your code`

Environment Setup
-----------------
Note: This setup is for mac or ubuntu. For windows, kindly setup these values in Environment Variables
1. Update `bashrc` or `bash_profile`
```bash
sudo nano ~/.bash_profile
```
2. Add the following in the bash_profile
```bash
# Jenkins
export JENKINWARFILE="/etc/jenkinswarfile"
export PATH=$PATH:$JENKINWARFILE

# Java
export JAVA_HOME_8_X64="/usr/bin/java"
export PATH=$PATH:$JAVA_HOME_8_X64
```
3. Save the changes.

Webdriver Setup
-----------------
Note: This setup is for MacOS or Ubuntu. For windows, kindly setup these values in Environment Variables.
1. Download the web drivers
- [Chromedriver](http://chromedriver.chromium.org/)
- [Firefox](https://github.com/mozilla/geckodriver/releases)
2. Extract the files in a local directory then run the following scripts:
```bash
# Chmod to executable file
chmod +x ~/Downloads/chromedriver

# Move the file from Downloads folder to share folder
sudo mv -f ~/Downloads/chromedriver /usr/local/share/chromedriver

# Create a symlink
sudo ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver
```

3. Do the same steps for geckodriver

4. Add the following in the bash_profile
```bash
# Web drivers
export CHROMEDRIVER="/usr/local/bin/chromedriver"
export PATH=$PATH:$CHROMEDRIVER

export GECKODRIVER="/usr/local/bin/geckodriver"
export PATH=$PATH:$GECKODRIVER
```

Installation using pip
----------------------
Clone this repository to your local directory.
Open a terminal and cd to `RobotFrameworkDemoWorkspace` where setup.py is located.
Run the following in the terminal:

```bash
pip install -e .
```

Running Tests
-------------
Source your bash_profile via the following script in the terminal.
```bash
source ~/.bash_profile
```

Include the `argument_file.txt` found at the top-level directory for non-changing arguments on run time. 
To run a particular test suite, using the same terminal where the bash_profile was sourced, run the following:
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

Feel free to reverse engineer and refactor! :+1:
------------------------------------------------

