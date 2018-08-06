*** Settings ***
Documentation        [DEMO] This test suite should test the login functionality of the automation practice website
Default Tags         HomePageAvailabilityTest    Demo    AVAILABILITY    HIGH
Force Tags           REGRESSION
Test Setup           Run Keywords    Open Browser To "${BASE_URL}"
...                  AND    Set Test Documentation    Test Case: ${TEST NAME}
Suite Teardown       Run Keywords    Log Environment Details In Suite Documentation
...                  AND    Close All Browsers
Resource             ${GLOBAL_RESOURCES_FILE_PATH}libraries.robot
Resource             ${DEMO4_VARIABLE_DIR}demo_home_page_constants.robot

*** Test Cases ***
Home Page Availability
    Given User Is In "Automation Practice Home" Page
    Then The "Home Page" Elements Should Be Loaded Successfully
