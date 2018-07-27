*** Keywords ***
#==================================#
#           GIVEN STATEMENTS       #
#==================================#
User Opens "${PAGE_URI}" Page
    Open Browser    ${ ${PAGE_URI} }    ${BROWSER}

#==================================#
#           WHEN STATEMENTS        #
#==================================#
User Clicks "${LOCATOR}"
    Wait Until Keyword Succeeds    5x    2s
    ...    Click Element    ${ ${LOCATOR} }

User Inputs Text "${TEXT}" In "${LOCATOR}" Text Field
    Wait Until Keyword Succeeds    5x    2s
    ...    Input Text    ${ ${LOCATOR} TEXTFIELD }    ${TEXT}

User Should Be Forwarded To "${PAGE_URI}" PAGE
    Wait Until Keyword Succeeds    5x    2s
    ...    Location Should Contain    ${ ${PAGE_URI} }

#==================================#
#           THEN STATEMENTS        #
#==================================#
The "${LOCATOR}" Should Be Visible
    Wait Until Keyword Succeeds    5x    2s
    ...    Element Should Be Visible    ${ ${LOCATOR} }
