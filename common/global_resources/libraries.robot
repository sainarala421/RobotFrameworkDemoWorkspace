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
Resource          setupbrowser.robot
Resource          stepdefinitions.robot
