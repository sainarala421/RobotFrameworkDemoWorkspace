*** Settings ***
Documentation    Login Test sample script using Selenium2Library
Library          Selenium2Library
Test Teardown    Close Browser

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

*** Keywords ***
User Opens Page
    [Arguments]    ${BASE_URL}
    Open Browser    ${BASE_URL}    ${browser}

User Clicks Element
    [Arguments]    ${LOCATOR}
    Wait Until Keyword Succeeds    5x    2s
    ...    Click Element    ${LOCATOR}

User Inputs Text
    [Arguments]    ${LOCATOR}    ${TEXT}
    Wait Until Keyword Succeeds    5x    2s
    ...    Input Text    ${LOCATOR}    ${TEXT}

User Should Be Forwarded To Page
    [Arguments]    ${PAGE_URI}
    Wait Until Keyword Succeeds    5x    2s
    ...    Location Should Contain    ${PAGE_URI}

Page Element Should Be Visible
    [Arguments]    ${LOCATOR}
    Wait Until Keyword Succeeds    5x    2s
    ...    Element Should Be Visible    ${LOCATOR}

*** Test Cases
Valid Login
    Given User Opens Page    ${baseUrl}
    When User Clicks Element    ${loginButton}
    And User Inputs Text    ${emailField}    ${username}
    And User Inputs Text    ${passwordField}    ${validPassword}
    And User Clicks Element    ${submitLoginButton}
    Then User Should Be Forwarded To Page    ${userDashboardPage}

Invalid Login
    Given User Opens Page    ${baseUrl}
    When User Clicks Element    ${loginButton}
    And User Inputs Text    ${emailField}    ${username}
    And User Inputs Text    ${passwordField}    ${invalidPassword}
    And User Clicks Element    ${submitLoginButton}
    Then Page Element Should Be Visible    ${invalidLoginAlert}
