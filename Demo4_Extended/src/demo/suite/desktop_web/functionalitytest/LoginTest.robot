*** Settings ***
Documentation        [DEMO] This suite should test the login functionality of the automation practice website
Default Tags         LoginTest    Demo    FUNCTIONALITY    HIGH
Force Tags           REGRESSION
Suite Teardown       Get Environment Details And Close All Browsers
Resource             ${GLOBAL_RESOURCES_FILE_PATH}libraries.robot
Resource             ${DEMO4_VARIABLE_DIR}demo_login_page_constants.robot

*** Test Cases ***
Valid User Login
    Given Open Browser To "${BASE_URL}"
    When User Clicks "Sign In" "Button"
