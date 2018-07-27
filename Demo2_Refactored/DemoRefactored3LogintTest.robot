*** Settings ***
Documentation    Login Test sample script using Selenium2Library
Library          Selenium2Library
Test Teardown    Close Browser

*** Variables ***
${username}             abc@234.com
${validPassword}        Test@123
${invalidPassword}      Test@123Invalid
${browser}              chrome

# CONSTANTS
${AUTOMATION_PRACTICE_HOME}    http://automationpractice.com
${LOGIN_BUTTON}                css=a.login
${EMAIL_TEXTFIELD}             id=email
${PASSWORD_TEXTFIELD}          id=passwd
${SUBMIT_LOGIN_BUTTON}         id=SubmitLogin
${USER_DASHBOARD_URI}          index.php?controller=my-account
${INVALID_LOGIN_ALERT}         css=.center_column > .alert-danger


*** Keywords ***
User Opens "${PAGE_URI}" Page
    Open Browser    ${ ${PAGE_URI} }    ${browser}

User Clicks "${LOCATOR}"
    Wait Until Keyword Succeeds    5x    2s
    ...    Click Element    ${ ${LOCATOR} }

User Inputs Text "${TEXT}" In "${LOCATOR}" Text Field
    Wait Until Keyword Succeeds    5x    2s
    ...    Input Text    ${ ${LOCATOR} TEXTFIELD }    ${TEXT}

User Should Be Forwarded To "${PAGE_URI}" PAGE
    Wait Until Keyword Succeeds    5x    2s
    ...    Location Should Contain    ${ ${PAGE_URI} }

The "${LOCATOR}" Should Be Visible
    Wait Until Keyword Succeeds    5x    2s
    ...    Element Should Be Visible    ${ ${LOCATOR} }

*** Test Cases
Valid Login
    Given User Opens "Automation Practice Home" Page
    When User Clicks "Login Button"
    And User Inputs Text "${username}" In "Email" Text Field
    And User Inputs Text "${validPassword}" In "Password" Text Field
    And User Clicks "Submit Login Button"
    Then User Should Be Forwarded To "User Dashboard URI" Page

Invalid Login
    Given User Opens "Automation Practice Home" Page
    When User Clicks "Login Button"
    And User Inputs Text "${username}" In "Email" Text Field
    And User Inputs Text "${invalidPassword}" In "Password" Text Field
    And User Clicks "Submit Login Button"
    Then The "Invalid Login Alert" Should Be Visible
