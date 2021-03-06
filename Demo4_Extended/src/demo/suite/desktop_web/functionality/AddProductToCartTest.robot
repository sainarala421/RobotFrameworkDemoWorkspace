*** Settings ***
Documentation        [DEMO] This test suite should test the login functionality of the automation practice website
Force Tags           AddProductToCartTest    REGRESSION    Demo    FUNCTIONALITY    HIGH
Test Setup           Run Keywords    Open Browser To "${BASE_URL}"
...                  AND    Set Test Documentation    Test Case: ${TEST NAME}
Test Teardown        Run Keywords    Close Browser
...                  AND    Update SauceLabs Job For Passing Tests
Suite Teardown       Run Keywords    Log Environment Details In Suite Documentation
...                  AND    Close All Browsers
Resource             ${GLOBAL_RESOURCES_FILE_PATH}libraries.robot
Resource             ${DEMO4_VARIABLE_DIR}demo_home_page_constants.robot
Resource             ${DEMO4_PAGERESOURCE_DIR}demo_login_page_keywords.robot
Resource             ${DEMO4_PAGERESOURCE_DIR}demo_product_cart_keywords.robot

*** Variables ***
${username}         abc@234.com
${validpassword}    Test@123
${productCount}     5

*** Test Cases ***
Guest User Product Cart Addition Of Item
    [Tags]    GuestUser
    Given User Is In "Automation Practice Home" Page
    When User Adds "${productCount}" Random "Home Page Popular" Products To Cart
    Then "Shopping Cart Quantity" Should Contain The Value "${productCount}"

Logged In User Product Cart Addition Of Item
    [Tags]    LoggedInUser
    Given User Login Using "Valid" Username "${username}" And Password "${validpassword}"
    And User Navigates To "Automation Practice Home" Page
    When User Adds "${productCount}" Random "Home Page Popular" Products To Cart
    Then "Shopping Cart Quantity" Should Contain The Value "${productCount}"
