*** Settings ***
Documentation        [DEMO] This test suite should test the end to end test of ordering via Bank Transfer
Default Tags         OrderAndPayByBankEndToEndTest    Demo    FUNCTIONALITY    HIGH
Force Tags           REGRESSION
Test Setup           Run Keywords    Open Browser To "${BASE_URL}"
...                  AND    Set Test Documentation    Test Case: ${TEST NAME}
Test Teardown        Close Browser
Suite Teardown       Run Keywords    Log Environment Details In Suite Documentation
...                  AND    Close All Browsers
Resource             ${GLOBAL_RESOURCES_FILE_PATH}libraries.robot
Resource             ${DEMO4_VARIABLE_DIR}demo_home_page_constants.robot
Resource             ${DEMO4_PAGERESOURCE_DIR}demo_login_page_keywords.robot
Resource             ${DEMO4_PAGERESOURCE_DIR}demo_product_cart_keywords.robot

*** Test Cases ***
Guest User Product Cart Addition Of Item
    Given User Is In "Automation Practice Home" Page
    When User Adds A "$26.00" "Printed Dress" In "Home Page Popular" Product
    And User Clicks "Continue Shopping Button"
    When User Adds A "$26.00" "Printed Dress" In "Home Page Bestsellers" Product
    And User Clicks "Continue Shopping Button"
    When User Adds A "$16.40" "Printed Chiffon Dress" In "Home Page Popular" Product
    And User Clicks "Continue Shopping Button"
    # To be continued...