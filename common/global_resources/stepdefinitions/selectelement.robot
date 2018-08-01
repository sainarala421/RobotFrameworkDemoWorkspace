*** Keywords ***
#==========================================================#
#                     GIVEN | WHEN | THEN
#==========================================================#
User Selects "${e_TEXT}" From List By Label In "${e_ELEMENT}" Field
    Run And Wait Until Keyword Succeeds
    ...    JQuery Focus Element "${e_ELEMENT}"
    Run And Wait Until Keyword Succeeds
    ...    Select From List By Label    ${${e_ELEMENT}}    ${e_TEXT}
