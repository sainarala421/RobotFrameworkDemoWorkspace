*** Settings ***
Documentation        [DEMO] This suite should test the login functionality of the automation practice website
Default Tags         LoginTest    Demo    FUNCTIONALITY    HIGH
Force Tags           REGRESSION
# Suite Setup          Launch "Countdown Listens" Home Page
# Suite Teardown       Close All Browsers
Resource             ${GLOBAL_RESOURCES_FILE_PATH}libraries.robot

*** Test Cases ***
Valid User Login
    Given Open Browser To "${BASE_URL}"
    Close All Browsers