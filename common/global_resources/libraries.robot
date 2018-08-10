*** Settings ***
Library           ExtendedSelenium2Library    timeout=60
...               block_until_page_ready=${false}
...               run_on_failure=Log Console Errors
Library           OperatingSystem
Library           Collections
Library           String
Library           DateTime
Library           XvfbRobot
Library           HttpLibrary.HTTP
Resource          capabilities.robot
Resource          constants.robot
Resource          filepaths.robot
Resource          libraries.robot
Resource          browsersetup.robot
Resource          saucelabs.robot
Resource          stepdefinitions${/}assertions.robot
Resource          stepdefinitions${/}browsermanagement.robot
Resource          stepdefinitions${/}datetime.robot
Resource          stepdefinitions${/}element.robot
Resource          stepdefinitions${/}formelement.robot
Resource          stepdefinitions${/}selectelement.robot
Resource          stepdefinitions${/}jquerytool.robot

#Custom Libraries
Library           ${CUSTOM_LIBRARIES_DIR}etc${/}saucelabskeywords.py
Library           ${CUSTOM_LIBRARIES_DIR}etc${/}canonicalpath.py