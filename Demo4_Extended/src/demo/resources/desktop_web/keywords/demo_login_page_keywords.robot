*** Settings ***
Documentation     Resource file for login page.
Resource          ${DEMO4_VARIABLE_DIR}demo_login_page_constants.robot

*** Keywords ***
#==================================#
#          TEST TEMPLATES          #
#==================================#
User Login Using "${e_CREDENTIAL_TYPE}" Username "${e_USERNAME}" And Password "${e_PASSWORD}"
    [Documentation]    This template is used for login tests using different login credentials
    Given User Is In "Automation Practice Home" Page
    When User Clicks "Sign In Button"
    And User Inputs Text "${e_USERNAME}" On Field "Email Text Field"
    And User Inputs Password "${e_PASSWORD}" On Field "Password Text Field"
    And User Clicks "Submit Login Button"

    Run Keyword If    '${e_CREDENTIAL_TYPE.lower()}' == 'valid'
    ...    User Should Be Redirected To "User Dashboard" Page
    ...    ELSE
    ...    The "Authentication Failed Alert" Should Be "Visible"
