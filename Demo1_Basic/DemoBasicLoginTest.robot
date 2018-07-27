*** Settings ***
Documentation    Login Test sample script using Selenium2Library
Library    Selenium2Library

*** Test Cases
Valid Login
    Open Browser    http://automationpractice.com    chrome
    Click Element    css=a.login
    Input Text    id=email    abc@234.com
    Input Text    id=passwd    Test@123
    Click Element    id=SubmitLogin
    Location Should Contain    index.php?controller=my-account

Invalid Login
    Open Browser    http://automationpractice.com    chrome
    Click Element    css=a.login
    Input Text    id=email    abc@234.com
    Input Text    id=passwd    Test@123Invalid
    Click Element    id=SubmitLogin
    Element Should Be Visible    css=.center_column > .alert-danger
