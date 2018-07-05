*** Settings ***
Library           ExtendedSelenium2Library    timeout=60    block_until_page_ready=${false}    run_on_failure=Log Console Errors
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

*** Keywords ***
Log Console Errors
    Capture Page Screenshot
    ${t_logs}=    Get Browser Logs
    ${t_logs}=    Remove Duplicates    ${t_logs}
    Log    ${t_logs}
