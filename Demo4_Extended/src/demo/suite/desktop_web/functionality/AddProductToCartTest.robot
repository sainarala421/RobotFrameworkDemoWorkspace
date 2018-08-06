*** Settings ***
Documentation        [DEMO] This test suite should test the login functionality of the automation practice website
Default Tags         AddProductToCart    Demo    FUNCTIONALITY    HIGH
Force Tags           REGRESSION
Test Setup           Run Keywords    Open Browser To "${BASE_URL}"
...                  AND    Set Test Documentation    Test Case: ${TEST NAME}
Test Teardown        Close Browser
Suite Teardown       Run Keywords    Log Environment Details In Suite Documentation
...                  AND    Close All Browsers
Resource             ${GLOBAL_RESOURCES_FILE_PATH}libraries.robot
Resource             ${DEMO4_PAGERESOURCE_DIR}demo_product_cart_keywords.robot
Resource             ${DEMO4_VARIABLE_DIR}demo_home_page_constants.robot
Resource             ${DEMO4_VARIABLE_DIR}demo_product_cart_constants.robot

*** Variables ***
${productCount}    10

*** Test Cases ***
Guest User Product Cart
    Given User Is In "Automation Practice Home" Page
    When User Adds "${productCount}" "Home Page Popular Menu" Products To Cart
    Then "Shopping Cart Quantity" Should Contain The Value "${productCount}"
