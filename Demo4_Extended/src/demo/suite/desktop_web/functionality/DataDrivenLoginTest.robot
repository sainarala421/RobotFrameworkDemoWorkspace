*** Settings ***
Documentation        [DEMO] This test suite should test the login functionality of the automation practice website
Default Tags         DataDrivenLoginTest    Demo    FUNCTIONALITY    HIGH
Force Tags           REGRESSION
Test Setup           Run Keywords    Open Browser To "${BASE_URL}"
...                  AND    Set Test Documentation    Test Case: ${TEST NAME}
Test Teardown        Close Browser
Suite Teardown       Run Keywords    Log Environment Details In Suite Documentation
...                  AND    Close All Browsers
Resource             ${GLOBAL_RESOURCES_FILE_PATH}libraries.robot
Resource             ${DEMO4_PAGERESOURCE_DIR}demo_login_page_keywords.robot
Test Template        User Login Using "${e_CREDENTIAL_TYPE}" Username "${e_USERNAME}" And Password "${e_PASSWORD}"

*** Variables ***
${username}             abc@234.com
${validpassword}        Test@123
${invalidpassword}      Test@123Invalid

*** Test Cases ***          Credential Type    Username        Password
Valid User Login            Valid              ${username}     ${validpassword}
Invalid Password            Invalid            ${username}     ${invalidpassword}
Invalid Email               Invalid            abc@2345.com    ${validpassword}
Invalid Email Format        Invalid            abc@234         ${validpassword}
Blank Email                 Invalid            ${EMPTY}        ${validpassword}
Blank Password              Invalid            ${username}     ${EMPTY}
Blank Email And Password    Invalid            ${EMPTY}        ${EMPTY}
