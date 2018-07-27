*** Settings ***
Documentation    Login Test sample script using Selenium2Library
Library          Selenium2Library

*** Variables ***
${baseUrl}              http://automationpractice.com
${browser}              chrome
${loginButton}          css=a.login
${emailField}           id=email
${passwordField}        id=passwd
${submitLoginButton}    id=SubmitLogin
${userDashboardPage}    index.php?controller=my-account
${invalidLoginAlert}    css=.center_column > .alert-danger
${username}             abc@234.com
${validPassword}        Test@123
${invalidPassword}      Test@123Invalid

*** Test Cases
Valid Login
    Open Browser    ${baseUrl}    ${browser}
    Click Element    ${loginButton}
    Input Text    ${emailField}    ${username}
    Input Text    ${passwordField}    ${validPassword}
    Click Element    ${submitLoginButton}
    Location Should Contain    ${userDashboardPage}
    [Teardown]    Close Browser

Invalid Login
    Open Browser    ${baseUrl}    ${browser}
    Click Element    ${loginButton}
    Input Text    ${emailField}    ${username}
    Input Text    ${passwordField}    ${invalidPassword}
    Click Element    ${submitLoginButton}
    Element Should Be Visible    ${invalidLoginAlert}
    [Teardown]    Close Browser
