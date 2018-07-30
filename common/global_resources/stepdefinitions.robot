*** Keywords ***
#==========================================================#
#                     GIVEN | WHEN | THEN
#==========================================================#
Get Current Page's Url
    [Documentation]    This keyword gets the current page's url after switching of browsers
    ${t_pagetUrl} =    Get location
    Set Global Variable    ${g_PAGE_URL}    ${t_pagetUrl}

User Has Selected Browser "${e_BROWSER_ALIAS}"
    [Documentation]    This keyword is for switching browser window.
    ...    It accepts ALIAS as an argument.
    Switch Browser    ${e_BROWSER_ALIAS}

User Reloads Page
    [Documentation]    This keyword reloads the page
    Reload Page

Get Browser Instance Window Identifier
    [Documentation]    Gets the window title of the focused window
    ${t_getWindowTitle} =    Get Window Titles
    Execute Javascript    function setWindowFocus() {var window = document.title("${t_getWindowTitle}")}; window.focus();

Browser Cookie Should Not Be Empty
    [Documentation]    This keyword is used for checking if the cookie is not empty after login in
    [Arguments]    ${p_cookieName}
    ${t_cookieValue} =    Get Cookie Value    ${p_cookieName}
    ${t_isNotEmpty} =    Run Keyword and Return Status    Should Not Be Empty    ${t_cookieValue}
    Run Keyword Unless    ${t_isNotEmpty}    Capture Page Screenshot
    Should Be True    ${t_isNotEmpty}

User Clicks Element "${e_ELEMENT}"
    [Documentation]    This keyword focuses on an element before it clicks on it.
    Wait Until Keyword Succeeds    ${TIMEOUT}    ${INTERVAL}
    ...    JQuery Focus Element "${e_ELEMENT}"
    Run And Wait Until Keyword Succeeds
    ...    Click Element    ${e_ELEMENT}

User Inputs Text "${e_TEXT}" On Field "${e_ELEMENT}"
    Wait Until Keyword Succeeds    ${TIMEOUT}    ${INTERVAL}
    ...    JQuery Focus Element "${e_ELEMENT}"
    Run And Wait Until Keyword Succeeds
    ...    Input Text    ${${e_ELEMENT}}    ${e_TEXT}

User Selects "${e_TEXT}" From List By Label In "${e_ELEMENT}" Field
    Wait Until Keyword Succeeds    ${TIMEOUT}    ${INTERVAL}
    ...    JQuery Focus Element "${e_ELEMENT}"
    Run And Wait Until Keyword Succeeds
    ...    Select From List By Label    ${${e_ELEMENT}}    ${e_TEXT}

User Inputs Password "${e_TEXT}" On Field "${e_ELEMENT}"
    Wait Until Keyword Succeeds    ${TIMEOUT}    ${INTERVAL}
    ...    JQuery Focus Element "${e_ELEMENT}"
    Run And Wait Until Keyword Succeeds
    ...    Input Password    ${${e_ELEMENT}}    ${e_TEXT}

User Inputs Text On Focused Field
    [Documentation]  This user Keyword will execute when field are having problems on inputting.
    ...   ${p_locator}=  input field
    ...   ${p_inputText}= input text
    ...   ${p_targetlLocatorForTab}=  next element/locator that will trigger the tab key
    [Arguments]    ${p_locator}    ${p_inputText}    ${p_targetlLocatorForTab}
    JQuery Focus Element "${p_locator}"
    Input Text    ${p_locator}    ${p_inputText}
    Run Keyword And Ignore Error    Press Key    ${p_targetlLocatorForTab}    \\09
    Run Keyword And Ignore Error    Blur Element    ${p_locator}

Scroll To Page Location
    [Documentation]    This keyword is used for scrolling the window to a specified x and y offset.
    [Arguments]    ${p_xAxis}    ${p_yAxis}
    Execute Javascript    window.scrollTo(${p_xAxis},${p_yAxis});

Wait Until Element "${e_ELEMENT}" Is "${e_VISIBILITY}"
    [Documentation]    This keyword is used to wait for an element to become not visible
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

User Uploads A File
    [Arguments]    ${p_uploadContainer}    ${p_fileName}
    ${new_FileDirectory}=    Replace String   ${CURDIR}   CommonResources    TestData${/}Images${/}
    Log   ${new_FileDirectory}
    Choose File    ${p_uploadContainer}    ${new_FileDirectory}${p_fileName}

# Page redirection keywords
User Is In "${e_PAGE_NAME}" Page
    [Documentation]    This keyword asserts that the url value of the page is correct, otherwise, Go To keyword is executed.
    ${t_extURL}    ${t_isPageUrl}=    User Is Forwarded To "${e_PAGE_NAME}" Page
    Run Keyword Unless    ${t_isPageUrl}    Go To    ${${g_BASE_URL}_BASE_URL}${t_extURL}
    Log Location

User Is Forwarded To "${e_PAGE_NAME}" Page
    [Documentation]    This keyword asserts that the url value of the target page is correct.
    ${t_extURL}=    Set Variable If    '${e_PAGE_NAME}' == 'Lifehacks Home' or '${e_PAGE_NAME}' == 'Lifehacks'
    ...    ${EMPTY}    ${${e_PAGE_NAME}_URL_EXT}
    ${r_isPageUrl} =    Run Keyword And Return Status    Location Should Contain    ${t_extURL}
    [Return]    ${t_extURL}    ${r_isPageUrl}
    Log Location

User Goes To "${e_PAGE_NAME}" Page
    [Documentation]    Keyword that navigates to a certain page. Accepts a url as an argument.
    ${url}=    Run Keyword And Return Status    Should Contain    ${${e_PAGE_NAME}_URL_EXT}    ${${g_BASE_URL}_BASE_URL}
    Run Keyword Unless    ${url}    Verify Hostname Contains Http    ${${e_PAGE_NAME}_URL_EXT}
    Log Location

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

User Has Navigated To "${e_PAGE_NAME}" Page
    [Documentation]    Keyword that navigates to a certain page. Accepts a url as an argument.
    ${url}=    Run Keyword And Return Status    Should Contain    ${${e_PAGE_NAME}_URL_EXT}    ${${g_BASE_URL}_BASE_URL}
    Run Keyword Unless    ${url}    Verify Hostname Contains Http    ${${e_PAGE_NAME}_URL_EXT}
    Log Location

# Then: should be used for Then statements
The "${e_ELEMENTS_LIST}" Elements Should Be Loaded Successfully
    [Documentation]    This keyword is used for asserting that the core elements of a page is visible.
    Load JQuery Tool
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

User Launches The Lifehacks Home Page
    Launch Lifehacks Home Page

User Clicks The Element "${e_ELEMENT}"
    Focus And Click Element "${${e_ELEMENT}}"

User Clicks "${e_ELEMENT_NAME}" "${e_ELEMENT_TYPE}"
    Focus And Click Element "${${e_ELEMENT_NAME} ${e_ELEMENT_TYPE}}"

User Clicks The Element "${e_ELEMENT}" Via jQuery
    JQuery Click Element "${${e_ELEMENT}}"

User Clicks "${e_SOURCE}" "${e_TARGET_PAGE_NAME}" Link
    [Documentation]    This keyword is for clicking a link that matches the text ${e_TARGET_PAGE_NAME}
    Focus And Click Element "${${e_SOURCE}_LINK} > a:contains("${e_TARGET_PAGE_NAME}")"

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
Verify Hostname Contains Http
    [Documentation]    Verifies if the hostname contains http
    [Arguments]    ${p_url}
    ${index}=    Run Keyword And Return Status    Should Contain    ${p_url}    http
    Run Keyword If    ${index}    Go To    ${p_url}    ELSE    Go To    ${${g_BASE_URL}_BASE_URL}${p_url}

JQuery Focus Element "${e_ELEMENT}"
    [Documentation]    Triggers focus event using jQuery
    ${t_element}=    Remove Element Locator Type    ${e_ELEMENT}
    ${t_jQueryExecutedSuccessfully} =    Run Keyword And Return Status
    ...    Execute Javascript    document.querySelector('${t_element}').focus();
    Run Keyword Unless    ${t_jQueryExecutedSuccessfully}
    ...    Execute Javascript    jQuery('${t_element}').focus();

JQuery Blur Element "${e_ELEMENT}"
    [Documentation]    Triggers blur event using jQuery
    ${t_element}=    Remove Element Locator Type    ${e_ELEMENT}
    Execute Javascript    jQuery('${t_element}').blur();

JQuery Click Element "${e_ELEMENT}"
    [Documentation]    Clicking an element using jQuery
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

Set Default Selenium Speed
    [Documentation]    This keyword sets the selenium speed to execute
    ...    commands based on Get Default Selenium Speed which is called in
    ...    Browser Is Launched keyword
    Set Selenium Speed    .5

Run And Wait Until Keyword Succeeds
    [Documentation]    This keyword is used in waiting for an element to be visible within the global timeout and interval
   [Arguments]    ${p_keyword}    ${p_arg1}    ${p_arg2}=No Operation
   ${isEqual}=  Run Keyword And Return Status    Should Be Equal As Strings    ${p_arg2}    No Operation
   # Run Keyword If     '${p_arg2}' == 'No Operation'
   Run Keyword If    ${isEqual}
   ...    Wait Until Keyword Succeeds    ${TIMEOUT}    ${INTERVAL}    ${p_keyword}    ${p_arg1}
   ...    ELSE
   ...    Wait Until Keyword Succeeds    ${TIMEOUT}    ${INTERVAL}    ${p_keyword}    ${p_arg1}    ${p_arg2}

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

Generate Date Time With Milliseconds
    [Documentation]    This keyword generates date time with milliseconds
    ...    removing all special characters from the string and getting the 3rd to the 17th character
    ${t_dateTime} =    Evaluate    str(datetime.datetime.now()).translate(None, ':-. ')    datetime
    Set Global Variable    ${g_TIME_SUFFIX}    ${t_dateTime[2:17]}

Load JQuery Tool
    Execute Javascript    ${CURDIR}/load_jquery.js

#==========================================================#
#                  SETUP AND TEARDOWN
#==========================================================#
Wait For Web Page Load To Complete
    Execute Javascript    jQuery(document).ready(function($){
    ...    alert("Web Page Is Ready!")
    ...    });
    Run Keyword And Ignore Error    Dismiss Alert
    Capture Page Screenshot

Wait Until AngularJS Is Loaded
   ${retval}=    Execute Async JavaScript
   ...    var callback = arguments[arguments.length - 1];
   ...    function answer(){callback("loaded");};
   ...    angular.getTestability('${ANGULAR_CONTAINER}').whenStable(answer);
   Should Be Equal   ${retval}    loaded

Focus And Click Element "${e_ELEMENT}"
    [Documentation]    This keyword focus on an element before it clicks on it.
    Run And Wait Until Keyword Succeeds    Element Should Be Visible    ${e_ELEMENT}
    JQuery Focus Element "${e_ELEMENT}"
    Click Element    ${e_ELEMENT}

#==========================================================#
#                     FLNDEV HELPERS
#==========================================================#
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
    ${t_linksCount}=    Get Matching Xpath Count    ${${e_ELEMENT_NAME}_${e_ELEMENT_TYPE}}//a
    Comment    Log links count
    Log    ${t_linksCount}
    Comment    Create a list to store link texts
    @{t_linkItemsAnchorText}    Create List
    @{t_linkItemsURL}    Create List
    Comment    Loop through all links and store links value that has length more than 1 character
    : FOR    ${INDEX}    IN RANGE    1    ${t_linksCount}-1
    \    Log    ${INDEX}
    \    ${t_linkAnchorText}=    Get Text    xpath=(${${e_ELEMENT_NAME}_${e_ELEMENT_TYPE}}//a)[${INDEX}]
    \    ${t_linkURL}=    Get Element Attribute    xpath=(${${e_ELEMENT_NAME}_${e_ELEMENT_TYPE}}//a)[${INDEX}]@href
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

#==============================================================#
#                         GLOBAL TEST TEMPLATES
#==============================================================#
# Guest User Has Successfully Visited "${e_TARGET_PAGE}" Page Through "${e_SOURCE_PAGE}"
#     [Documentation]    This template tests the link and its associated page's section.
#     Given User Is In "${e_SOURCE_PAGE}" Page
#     When User Clicks "${e_TARGET_PAGE}" "Link"
#     Then User Should Be Redirected To "${e_TARGET_PAGE}" Page

Guest User Has Successfully Visited "${e_TARGET_PAGE}" Page Through "${e_NAV_TYPE}" From "${e_SOURCE_PAGE}"
    [Documentation]    This template tests the link and its associated page's section.
    ${t_menu_type} =    Set Variable If     '${e_NAV_TYPE}' == 'Main Menu'
    ...    ${EMPTY}    ${e_NAV_TYPE}
    Given User Is In "${e_SOURCE_PAGE}" Page
    When User Clicks "${e_TARGET_PAGE} ${t_menu_type}" "Link"
    Then User Should Be Redirected To "${e_TARGET_PAGE}" Page
