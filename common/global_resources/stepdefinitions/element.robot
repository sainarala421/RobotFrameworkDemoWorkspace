*** Keywords ***
#==========================================================#
#                     GIVEN | WHEN | THEN
#==========================================================#
User Clicks "${e_ELEMENT}"
    Focus And Click Element "${ ${e_ELEMENT} }"

User Clicks "${e_ELEMENT}" Via jQuery
    JQuery Click Element "${ ${e_ELEMENT} }"

User Clicks "${e_SOURCE}" "${e_TARGET_PAGE_NAME}" Link
    [Documentation]    This keyword is for clicking a link that matches the text ${e_TARGET_PAGE_NAME}
    Focus And Click Element "${ ${e_SOURCE}_LINK } > a:contains("${e_TARGET_PAGE_NAME}")"

User Clicks "${e_SOURCE}" "${e_TARGET_PAGE_NAME}" Menu
    [Documentation]    This keyword is for clicking a link that matches the text ${e_TARGET_PAGE_NAME}
    ${t_elementIsDropdownMenu}=    Element "${e_SOURCE}" "${e_TARGET_PAGE_NAME.mainmenu}" Is A Dropdown Menu
    ${t_sourceLink} =    Run Keyword If    ${t_elementIsDropdownMenu}
    ...    Replace String    ${e_SOURCE}    Main    Sub
    ...    ELSE    Set Variable    ${e_SOURCE}
    ${t_submenuHref} =    Run Keyword If    ${t_elementIsDropdownMenu}
    ...    Get Element "${${t_sourceLink}_LINK}" Attribute "href" Containing Text "${e_TARGET_PAGE_NAME.submenu}"
    ...    ELSE    Get Element "${${t_sourceLink}_LINK}" Attribute "href" Containing Text "${e_TARGET_PAGE_NAME.mainmenu}"
    ${t_submenuHref} =    Run Keyword If    ${t_elementIsDropdownMenu}
    ...    Fetch From Right    ${t_submenuHref}    ://

    Run Keyword If    ${t_elementIsDropdownMenu}    Run Keywords
    ...    Focus And Click Element "${${e_SOURCE}_LINK} > a:contains("${e_TARGET_PAGE_NAME.mainmenu}")"
    ...    AND    Focus And Click Element "${${e_TARGET_PAGE_NAME.mainmenu}_MENU_ID} a[href*="${t_submenuHref}"]"
    ...    ELSE    Focus And Click Element "${${e_SOURCE}_LINK} > a:contains("${e_TARGET_PAGE_NAME.mainmenu}")"

#==========================================================#
#                     INTERNAL KEYWORDS
#==========================================================#
JQuery Focus Element "${e_ELEMENT}"
    [Documentation]    Triggers focus event using jQuery
    Load jquery For jquery Elements    ${e_ELEMENT}
    ${t_element}=    Remove Element Locator Type    ${e_ELEMENT}
    ${t_jQueryExecutedSuccessfully} =    Run Keyword And Return Status
    ...    Execute Javascript    document.querySelector('${t_element}').focus();
    Run Keyword Unless    ${t_jQueryExecutedSuccessfully}
    ...    Execute Javascript    jQuery('${t_element}').focus();

JQuery Blur Element "${e_ELEMENT}"
    [Documentation]    Triggers blur event using jQuery
    Load jquery For jquery Elements    ${e_ELEMENT}
    ${t_element}=    Remove Element Locator Type    ${e_ELEMENT}
    Execute Javascript    jQuery('${t_element}').blur();

JQuery Click Element "${e_ELEMENT}"
    [Documentation]    Clicking an element using jQuery
    Load jquery For jquery Elements    ${e_ELEMENT}
    ${t_element}=    Remove Element Locator Type    ${e_ELEMENT}
    # ${t_jQueryExecutedSuccessfully} =    Run Keyword And Return Status
    # ...    Execute Javascript    document.querySelector('${t_element}').click();
    # Run Keyword Unless    ${t_jQueryExecutedSuccessfully}
    # ...    Execute Javascript    jQuery('${t_element}').click();
    Run And Wait Until Keyword Succeeds    Execute Javascript    jQuery('${t_element}').click();

Remove Element Locator Type
    [Documentation]    This keyword will remove the Element locator type and return just the value of the locator
    [Arguments]    ${p_element}
    ${t_newElement}=    Remove String Using Regexp    ${p_element}    ^.*?=
    ${r_removeHTMLElement}=    Set Variable    ${t_newElement}
    [Return]    ${r_removeHTMLElement}

Get Matching Locator "${e_ELEMENT_CLASS_LOCATOR}" Count
    [Documentation]   This keyword will count all possible elements in the page using jQuery length.
    ...    Do not use ID since it will only return 1 result. Use class as argument.
    ${t_plainElementLocator}=    Remove Element Locator Type    ${e_ELEMENT_CLASS_LOCATOR}
    ${r_elementCount}    Execute Javascript   return jQuery('${t_plainElementLocator}').length
    Log   ${r_elementCount}
    [Return]    ${r_elementCount}

Element "${e_SOURCE}" "${e_TARGET_PAGE_NAME}" Is A Dropdown Menu
    ${t_element}=    Remove Element Locator Type    ${${e_SOURCE}_LINK}
    ${t_elementMenuIndicator} =    Execute Javascript   return jQuery('${t_element} > a:contains("${e_TARGET_PAGE_NAME}") + script').text()
    Log    ${t_elementMenuIndicator}
    ${r_elementIsDropdown} =    Run Keyword And Return Status
    ...    Should Contain    ${t_elementMenuIndicator}    vbmenu_register
    [Return]    ${r_elementIsDropdown}

Get Element "${e_ELEMENT}" Attribute "${e_ATTRIBUTE}" Containing Text "${e_TEXT}"
    ${t_element} =    Remove Element Locator Type    ${e_ELEMENT}
    ${r_elementAttribute} =     Execute Javascript    return jQuery('${t_element} a').filter(function(index){return $(this).text() === "${e_TEXT}";}).attr("${e_ATTRIBUTE}")
    [Return]    ${r_elementAttribute}

#==========================================================#
#                  INTERNAL
#==========================================================#
Focus And Click Element "${e_ELEMENT}"
    [Documentation]    This keyword focus on an element before it clicks on it.
    JQuery Focus Element "${e_ELEMENT}"
    Click Element    ${e_ELEMENT}

Wait For Element Status To Change
    [Documentation]    This keyword is used to wait for a certain element or functionality to
    ...    reflect in enhancedev. It accepts keywords with one argument or two.
    [Arguments]    ${p_keyword}=${EMPTY}    ${p_element}=${EMPTY}   ${p_value}=${EMPTY}
    : FOR    ${iteration}    IN RANGE   5
    \    ${t_isStatusChanged} =    Run Keyword And Return Status
    ...    Wait Until Keyword Succeeds    10s    2s
    ...    Run Keyword If    '${p_value}'!='${EMPTY}'
    ...    Run Keyword    ${p_keyword}    ${p_element}    ${p_value}
    ...    ELSE    Run Keyword    ${p_keyword}    ${p_element}
    \    Exit For Loop If    ${t_isStatusChanged}
    \    Reload Page
    Run Keyword Unless    ${t_isStatusChanged}    Fail    "The status has not changed!"

#===========================================#
#               Link Checker                #
#===========================================#
#*************** WHEN **********************#
User Gets All Links From "${e_ELEMENT_NAME}" "${e_ELEMENT_TYPE}"
    [Documentation]    This When statement gets all the a href from the specified xpath parent element
    ...    Note that the argument locator must be a parent xpath.
    Comment    Count the umber Of Links on the Page
    ${t_linksCount}=    Get Matching Xpath Count    ${ ${e_ELEMENT_NAME}_${e_ELEMENT_TYPE} }//a
    Comment    Log links count
    Log    ${t_linksCount}
    Comment    Create a list to store link texts
    @{t_linkItemsAnchorText}    Create List
    @{t_linkItemsURL}    Create List
    Comment    Loop through all links and store links value that has length more than 1 character
    : FOR    ${INDEX}    IN RANGE    1    ${t_linksCount}-1
    \    Log    ${INDEX}
    \    ${t_linkAnchorText}=    Get Text    xpath=(${ ${e_ELEMENT_NAME}_${e_ELEMENT_TYPE} }//a)[${INDEX}]
    \    ${t_linkURL}=    Get Element Attribute    xpath=( ${${e_ELEMENT_NAME}_${e_ELEMENT_TYPE} }//a)[${INDEX}]@href
    \    Log    ${t_linkAnchorText}
    \    Log    ${t_linkURL}
    # \    ${t_linkURLlength}    Get Length    ${t_linkURL}
    \    Run Keyword Unless    '${t_linkURL}' == '${EMPTY}' or '${t_linkURL}' == '${None}'     Run Keywords
    ...    Append To List    ${t_linkItemsURL}    ${t_linkURL}
    ...    AND    Append To List    ${t_linkItemsAnchorText}    ${t_linkAnchorText}
    Set Suite Variable    ${s_LINK_ITEMS_URL}    ${t_linkItemsURL}
    Set Suite Variable    ${s_LINK_ITEMS_ANCHOR_TEXT}    ${t_linkItemsAnchorText}

#*************** THEN **********************#
Links Should Not Return An Error
    [Documentation]    This Then statement performs get request on the given URI using the base URL
    ...    This keyword should be used as an assertion or when statement for User Gets All Links From "${e_ELEMENT_NAME}" "${e_ELEMENT_TYPE}"
    Log Many    ${s_LINK_ITEMS_URL}
    Remove Values From List    ${s_LINK_ITEMS_URL}    javascript:void(0)
    ${t_linkItemsLength}    Get Length    ${s_LINK_ITEMS_URL}
    Comment    Loop through the links list and perform a Get Request on the link URI
    @{t_errorMessages}    Create List
    :FOR    ${INDEX}    IN range    ${t_linkItemsLength}
    \    Log    Anchor Text: ${s_LINK_ITEMS_ANCHOR_TEXT[${INDEX}]}; URL Info: ${s_LINK_ITEMS_URL[${INDEX}]}
    \    Log To Console    ${\n} Anchor Text: ${s_LINK_ITEMS_ANCHOR_TEXT[${INDEX}]}; URL Info: ${s_LINK_ITEMS_URL[${INDEX}]}
    \    ${t_base_url} =    Get Regexp Matches    ${s_LINK_ITEMS_URL[${INDEX}]}    ${BASE_URL_REGEX}
    \    User Creates "${t_base_url[0]}" Global Session
    \    ${t_uri} =    Remove String Using Regexp    ${s_LINK_ITEMS_URL[${INDEX}]}    ${BASE_URL_REGEX}
    \    ${t_flag}    ${t_response}
    ...    Run Keyword And Ignore Error
    ...    Get Request    gafLoginSession    ${t_uri}
    \    ${t_responseCode}    Run Keyword And Return Status
    ...    Run Keyword If    '${t_flag}'=='PASS'
    ...    Should Be Equal As Strings    ${t_response.status_code}    200
    \    Run Keyword Unless    ${t_responseCode}
    ...    Append To List    ${t_errorMessages}    error :${s_LINK_ITEMS_URL[${INDEX}]} | ${t_response.status_code}
    \    Delete All Sessions
    Comment    Assert that there is no error message on get requests on links
    ${t_checkErrorMessage} =    Run Keyword And Return Status    Lists Should Be Equal    ${t_errorMessages}    ${EMPTY}
    Run Keyword Unless    ${t_checkErrorMessage}    Fail    Link \ assertion Failed with msg:\n@{t_errorMessages}

