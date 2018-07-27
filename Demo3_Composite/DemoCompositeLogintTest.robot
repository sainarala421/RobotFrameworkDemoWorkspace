*** Settings ***
Documentation    Login Test sample script using Selenium2Library
Library          Selenium2Library
Test Teardown    Close Browser
Resource         login_page_constants.robot
Resource         login_page_keywords.robot

*** Variables ***
${username}             abc@234.com
${validPassword}        Test@123
${invalidPassword}      Test@123Invalid

*** Test Cases
Valid Login
    Given User Opens "Automation Practice Home" Page
    When User Clicks "Login Button"
    And User Inputs Text "${username}" In "Email" Text Field
    And User Inputs Text "${validPassword}" In "Password" Text Field
    And User Clicks "Submit Login Button"
    Then User Should Be Forwarded To "User Dashboard URI" Page

Invalid Login
    Given User Opens "Automation Practice Home" Page
    When User Clicks "Login Button"
    And User Inputs Text "${username}" In "Email" Text Field
    And User Inputs Text "${invalidPassword}" In "Password" Text Field
    And User Clicks "Submit Login Button"
    Then The "Invalid Login Alert" Should Be Visible
