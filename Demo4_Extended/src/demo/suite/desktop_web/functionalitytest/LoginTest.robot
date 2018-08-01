*** Settings ***
Documentation        [DEMO] This test suite should test the login functionality of the automation practice website
Default Tags         LoginTest    Demo    FUNCTIONALITY    HIGH
Force Tags           REGRESSION
Test Setup           Set Test Documentation    Test Case: ${TEST NAME}
Test Teardown        Close Browser
Suite Teardown       Run Keywords    Log Environment Details In Suite Documentation
...                  AND    Close All Browsers
Resource             ${GLOBAL_RESOURCES_FILE_PATH}libraries.robot
Resource             ${DEMO4_VARIABLE_DIR}demo_login_page_constants.robot

*** Variables ***
${username}             abc@234.com
${validpassword}        Test@123
${invalidpassword}      Test@123Invalid

*** Test Cases ***
Valid User Login
    Given Open Browser To "${BASE_URL}"
    When User Clicks "Sign In Button"
    And User Inputs Text "${username}" On Field "Email Text Field"
    And User Inputs Password "${validpassword}" On Field "Password Text Field"
    And User Clicks "Submit Login Button"
    Then User Should Be Redirected To "User Dashboard" Page

Invalid User Login
    Given Open Browser To "${BASE_URL}"
    When User Clicks "Sign In Button"
    And User Inputs Text "${username}" On Field "Email Text Field"
    And User Inputs Password "${invalidpassword}" On Field "Password Text Field"
    And User Clicks "Submit Login Button"
    Then The "Authentication Failed Alert" Should Be "Visible"
