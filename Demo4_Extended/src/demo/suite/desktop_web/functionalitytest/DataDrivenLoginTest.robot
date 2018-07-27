*** Settings ***
Documentation        [DEMO] This suite should test the login functionality of the automation practice website
Default Tags         DataDrivenLoginTest    Demo    FUNCTIONALITY    HIGH
Force Tags           REGRESSION
Suite Teardown       Get Environment Details And Close All Browsers
Resource             ${GLOBAL_RESOURCES_FILE_PATH}libraries.robot
Resource             ${DEMO4_VARIABLE_DIR}demo_login_page_constants.robot
Resource             ${DEMO4_PAGERESOURCE_DIR}demo_login_page_templates.robot
Test Template        User Login In Using "${e_CREDENTIAL_TYPE}" Username "${e_USERNAME}" And Password "${e_PASSWORD}"

*** Variables ***
${username}             abc@234.com
${validpassword}        Test@123
${invalidpassword}      Test@123Invalid

*** Test Cases ***     Credential Type    Username       Password
Valid User Login       Valid              ${username}    ${validpassword}
Invalid User Login     Invalid            ${username}    ${invalidpassword}
