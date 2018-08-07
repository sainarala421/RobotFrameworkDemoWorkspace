Robot Framework Test Suites Demo
======================================

This repository contains the Robot Framework Demo workspace. The following topics are covered:

Demo Directory | Description
-------------- | -------------
`Demo1_Basic`  | robot framework scripts using the keywords from libraries
`Demo2_Refactored` | variables and keywords into Variables and Keywords sections respectively
`Demo3_Composite` | separation of variables, keywords into different .robot files and creation of higer level keywords
`Demo4_Extended` | extending robot framework for jenkins, report portal, docker-selenium. added option for headless chrome test exection and creation of higher level keywords

Directory Structure
-------------------
Directory | Description
-------------- | -------------
`common` | contains custom Robot Framework libraries and keywords that will be used by the test suites.
`DockerFiles` | contains the docker compose file for docker-selenium
`JenkinsFiles` | contains the Jenkins file using declarative pipeline syntax for test execution in parallel
`common\custom_libraries` | contains the custom libraries
`common\global_resources` | contains the step definitions, test data and global reusable keywords
`Demo4_Extended` | contains the workspace for the composite and extended robot framework for http://automationpractice.com
`Demo4_Extended\src\demo\resources` | contains the keywords specific for Demo4_Extended
`Demo4_Extended\src\demo\resources` | contains the test suites for Demo4_Extended
`Demo4_Extended\src\demo\suite\availability` | test suites with test cases for checking pages' availability
`Demo4_Extended\src\demo\suite\functionality` | test suites with test cases checking pages' functionality
`Demo4_Extended\src\demo\suite\endtoend` | test suites with end to end test cases
`Results` | directory for report and logs, created on run time

File | Description
-------------- | -------------
`setup.py` | prerequisite installation files
`gitignore` | list of files to be ignored for git
`argument_file.robot` | run time arguments
`README.md` | read me file

Prerequisites
--------------
- [x] [Python 2.7](https://www.python.org/download/releases/2.7/)
- [x] [Git](https://git-scm.com/)
- [x] [Sublime Text 2](https://www.sublimetext.com/2) or any text editor
- [x] `Web browsers. Note the supported web browser version for web drivers`

Optional Applications
---------------------
- [ ]  :octocat: `git repository for your code`
- [ ] [Jenkins war file](https://jenkins.io/download/)
- [ ] [Java](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
- [ ] [Report Portal](http://reportportal.io/)
- [ ] [Docker](https://www.docker.com/)
- [ ] [docker-Selenium](https://github.com/SeleniumHQ/docker-selenium)

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
# Edit bash_profile
sudo nano ~/.bash_profile
```
```bash
# Web drivers
export CHROMEDRIVER="/usr/local/bin/chromedriver"
export PATH=$PATH:$CHROMEDRIVER

export GECKODRIVER="/usr/local/bin/geckodriver"
export PATH=$PATH:$GECKODRIVER
```
5. Save the changes to bash_profile.

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

Jenkins Setup (Optional)
------------------------
Note: This setup is for mac or ubuntu. For windows, kindly setup these values in Environment Variables
1. Download [Jenkins war file](https://jenkins.io/download/).
2. Extract and move war file to `/etc/jenkinswarfile` directory.
```bash
sudo mv -f ~/Downloads/jenkins.war /etc/jenkinswarfile
```
3. Update `bashrc` or `bash_profile`
```bash
sudo nano ~/.bash_profile
```
4. Add the following in the bash_profile
```bash
# Jenkins
export JENKINWARFILE="/etc/jenkinswarfile"
export PATH=$PATH:$JENKINWARFILE
# Java
export JAVA_HOME_8_X64="/usr/bin/java"
export PATH=$PATH:$JAVA_HOME_8_X64
```
5. Save the changes to bash_profile.
6. Run Jenkins. Use any available port
```bash
java -jar jenkins.war --httpPort=9090
```
7. Open http://localhost:9090, then create a `Pipeline`. Go to `New Item` > `Pipeline`.
8. Enter a name in the `Enter an item name` textfield then click `OK`.
9. Scroll down and select `Pipeline script from scm` as Definition in the `Pipeline` section.
10. Select `Git` in the `SCM` field.
11. Fillout the `Repository URL` with your git workspace uri. 
For this example: `https://github.com/enhanceTAfrancis/RobotFrameworkDemoWorkspace.git`.
12. Fillout the Credentials field with your github credentials.
13. Fillout the `Script Path` text field. For this example: `JenkinsFiles/pipelinetestrunner`.
14. Click Save.
15. `Build` the pipeline you created. The build will initially fail.
16. Rerun the build, and the build button should now be `Build with Parameters`.
17. Click `Build`

Docker-Selenium Setup
---------------------
1. Install [Docker](https://www.docker.com/)
2. Clone the docker-selenium repo.
```bash
git clone https://github.com/SeleniumHQ/docker-selenium.git
```

3. Build the images. cd to the `docker-selenium` directory, then run: 
```bash
VERSION=local make build
```
4. Display all docker images and take note of the created images:
```bash
docker image ls
```
5. Run the hubs and nodes. cd to the `RobotFrameworkDemoWorkspace\DockerFiles`.
```bash
docker-compose -f docker-compose.yml up
```

Sublime Text 2 Setup for RobotFramework
---------------------------------------
Prerequisite: Sublime Text 2 is installed
1. Go to https://packagecontrol.io/installation 
2. Download [Package Control.sublime-package](https://packagecontrol.io/Package%20Control.sublime-package)
3. Click the `Preferences > Browse Packages…` menu
4. Browse up a folder and then into the `Installed Packages/` folder
5. Copy `Package Control.sublime-package` to `Installed Packages/` folder
6. Restart `Sublime Text 2`
7. Click on `Preferences > Package Control` menu
8. Type `Install Package` then select `Install Package` from the list.
Wait for the installation to complete.
9. After installation, another list will be displayed. Type `Robot
Framework Assistant` and press Enter.
10. Restart Sublime.
11. `Robot Framework` Menu should be visible.

Feel free to reverse engineer and refactor! :rocket:
----------------------------------------------------

