*** Keywords ***
#==========================================================#
#                     GIVEN | WHEN | THEN
#==========================================================#
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

User Has Navigated To "${e_PAGE_NAME}" Page
    [Documentation]    Keyword that navigates to a certain page. Accepts a url as an argument.
    ${url}=    Run Keyword And Return Status    Should Contain    ${${e_PAGE_NAME}_URL_EXT}    ${${g_BASE_URL}_BASE_URL}
    Run Keyword Unless    ${url}    Verify Hostname Contains Http    ${${e_PAGE_NAME}_URL_EXT}
    Log Location

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

Scroll To Page Location
    [Documentation]    This keyword is used for scrolling the window to a specified x and y offset.
    [Arguments]    ${p_xAxis}    ${p_yAxis}
    Execute Javascript    window.scrollTo(${p_xAxis},${p_yAxis});

#==========================================================#
#                     INTERNAL KEYWORDS
#==========================================================#
Verify Hostname Contains Http
    [Documentation]    Verifies if the hostname contains http
    [Arguments]    ${p_url}
    ${index}=    Run Keyword And Return Status    Should Contain    ${p_url}    http
    Run Keyword If    ${index}    Go To    ${p_url}    ELSE    Go To    ${${g_BASE_URL}_BASE_URL}${p_url}

Set Default Selenium Speed
    [Documentation]    This keyword sets the selenium speed to execute
    ...    commands based on Get Default Selenium Speed which is called in
    ...    Browser Is Launched keyword
    Set Selenium Speed    .5

Run And Wait Until Keyword Succeeds
    [Documentation]    This keyword is used in waiting for an element to be visible within the global timeout and interval
   [Arguments]    ${p_keyword}    ${p_arg1}=No Operation    ${p_arg2}=No Operation
   ${isEqual}=    Run Keyword And Return Status    Should Be Equal As Strings    ${p_arg2}    No Operation
   # Run Keyword If     '${p_arg2}' == 'No Operation'
   Run Keyword If    ${isEqual}
   ...    Wait Until Keyword Succeeds    ${TIMEOUT}    ${INTERVAL}    ${p_keyword}    ${p_arg1}
   ...    ELSE
   ...    Wait Until Keyword Succeeds    ${TIMEOUT}    ${INTERVAL}    ${p_keyword}    ${p_arg1}    ${p_arg2}

Generate Date Time With Milliseconds
    [Documentation]    This keyword generates date time with milliseconds
    ...    removing all special characters from the string and getting the 3rd to the 17th character
    ${t_dateTime} =    Evaluate    str(datetime.datetime.now()).translate(None, ':-. ')    datetime
    Set Global Variable    ${g_TIME_SUFFIX}    ${t_dateTime[2:17]}

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
