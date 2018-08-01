*** Keywords ***
#==========================================================#
#                     ELEMENT
#==========================================================#
# Then: should be used for Then statements
The "${e_ELEMENTS_LIST}" Elements Should Be Loaded Successfully
    [Documentation]    This keyword is used for asserting that the core elements of a page is visible.
    List Of Elements "@{${e_ELEMENTS_LIST}_CORE_ELEMENTS_LIST}" Should Be "Visible"

# Given: should be used for Given statements
The "${e_ELEMENTS_LIST}" Elements Are Loaded Successfully
    The "${e_ELEMENTS_LIST}" Elements Should Be Loaded Successfully

# Given: should be used for Given statements
The "${e_ELEMENT}" Is "${e_VISIBILITY}"
    Wait Until Element "${${e_ELEMENT}}" Is "${e_VISIBILITY}"

# Then: should be used for Then statements
The "${e_ELEMENT}" Should Be "${e_VISIBILITY}"
    Wait Until Element "${${e_ELEMENT}}" Is "${e_VISIBILITY}"

Wait Until Element "${e_ELEMENT}" Is "${e_VISIBILITY}"
    [Documentation]    This keyword is used to wait for an element to become not visible
    Load jquery For jquery Elements    ${e_ELEMENT}
    ${t_visibility} =    Convert To Lowercase    ${e_VISIBILITY}
    Run Keyword If    '${t_visibility}' == 'visible'
    ...    Run And Wait Until Keyword Succeeds    Element Should Be Visible    ${e_ELEMENT}
    ...    ELSE    Run And Wait Until Keyword Succeeds    Element Should Not Be Visible    ${e_ELEMENT}

List Of Elements "${e_ELEMENTS_LIST}" Should Be "${e_VISIBILITY}"
    [Documentation]    This keyword accepts pre-created list of elements or a number of elements separated by a comma as an argument and
    ...    iterates to check if the element is visible
    ...    Argument Example:
    ...    pre-created list of elements: @{t_listOfElements}
    ...    elements separated by comma: ${ELEMENT_1},${ELEMENT_2},${ELEMENT_3},${ELEMENT_4},${ELEMENT_5},${ELEMENT_6},${ELEMENT_7}
    ${t_isCount} =    Get Length    ${e_ELEMENTS_LIST}
    @{t_createdListOfElements} =    Run Keyword If    ${t_isCount} == 1    Split String    @{e_ELEMENTS_LIST}    ,
    @{t_listOfElements}=    Run Keyword If    ${t_isCount} == 1    Set Variable    @{t_createdListOfElements}
    ...    ELSE    Set Variable    @{e_ELEMENTS_LIST}
    : FOR    ${element}    IN    @{t_listOfElements}
    \    Wait Until Element "${element}" Is "${e_VISIBILITY}"

#==========================================================#
#                     PAGE
#==========================================================#
User Should Be Redirected To "${e_TARGET_PAGE_NAME}" Page
    ${t_isURLExtension} =    Run Keyword And Return Status
    ...    Variable Should Exist    ${${e_TARGET_PAGE_NAME}_URL_EXT}
    ${t_isURL} =    Run Keyword And Return Status
    ...    Variable Should Exist    ${${e_TARGET_PAGE_NAME}_URL}
    ${t_isLink} =    Run Keyword And Return Status
    ...    Variable Should Exist    ${${e_TARGET_PAGE_NAME}_LINK}

    ${t_prefix} =    Set Variable If
    ...    ${t_isURLExtension}    URL_EXT
    ...    ${t_isURL}    URL
    ...    ${t_isLink}    LINK

    ${t_listOfOpenWindows} =    List Windows
    ${t_numberOfOpenWindows} =    Get Length    ${t_listOfOpenWindows}
    :FOR    ${t_windows}    IN RANGE    0    ${t_numberOfOpenWindows}
    \    Select Window    @{t_listOfOpenWindows}[${t_windows}]
    \    ${t_locationIsCorrect} =    Run Keyword And Return Status
    ...    Wait Until Keyword Succeeds    10s    2s    Location Should Contain    ${${e_TARGET_PAGE_NAME}_${t_prefix}}
    \    Exit For Loop If    ${t_locationIsCorrect}
    Should Be True    ${t_locationIsCorrect}    msg=Target page "${e_TARGET_PAGE_NAME}" is not loaded.
    Log Location
