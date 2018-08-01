*** Keywords ***
#==========================================================#
#                     GIVEN | WHEN | THEN
#==========================================================#
User Inputs Text "${e_TEXT}" On Field "${e_ELEMENT}"
    JQuery Focus Element "${e_ELEMENT}"
    Run And Wait Until Keyword Succeeds
    ...    Input Text    ${${e_ELEMENT}}    ${e_TEXT}

User Inputs Password "${e_TEXT}" On Field "${e_ELEMENT}"
    JQuery Focus Element "${e_ELEMENT}"
    Run And Wait Until Keyword Succeeds
    ...    Input Password    ${${e_ELEMENT}}    ${e_TEXT}

Upload A File
    [Arguments]    ${p_uploadContainer}    ${p_fileName}
    ${t_canPath} =    Get Canonical Path    ${TEST_DATA_DIR}
    Set Global Variable    ${TEST_DATA_DIR}    ${t_canPath}
    Log    ${TEST_DATA_DIR}
    #Choose File    ${p_uploadContainer}    ${TEST_DATA_DIR}/images/${p_fileName}
