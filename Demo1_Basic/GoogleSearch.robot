*** Settings ***
Library    Selenium2Library

*** Test Cases
Search Google Test
    Open Browser    https://www.google.com    chrome
    Input Text    id=lst-ib    Robot Framework
    Click Element    css=input[value="Google Search"]
