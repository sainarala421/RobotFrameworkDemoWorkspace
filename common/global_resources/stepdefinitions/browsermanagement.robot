*** Keywords ***
#==========================================================#
#                     GIVEN | WHEN | THEN
#==========================================================#
# Page redirection keywords
User Is In "${e_PAGE_NAME}" Page
    [Documentation]    This keyword asserts that the url value of the page is correct, otherwise, Go To keyword is executed.
    User Has Navigated To "${e_PAGE_NAME}" Page

User Navigates To "${e_PAGE_NAME}" Page
    [Documentation]    Keyword that navigates to a certain page. Accepts a url as an argument.
    User Has Navigated To "${e_PAGE_NAME}" Page

User Has Navigated To "${e_PAGE_NAME}" Page
    [Documentation]    Keyword that navigates to a certain page. Accepts a url as an argument.
    Comment    Check if URI is a base url or a url extenstion
    ${t_isURLExtension} =    Run Keyword And Return Status
    ...    Variable Should Exist    ${${e_PAGE_NAME}_URL_EXT}
    ${t_isURL} =    Run Keyword And Return Status
    ...    Variable Should Exist    ${${e_PAGE_NAME}_URL}
    ${t_urlFinal}=    Set Variable If    ${t_isURLExtension}
    ...    ${${e_PAGE_NAME}_URL_EXT}    ${${e_PAGE_NAME}_URL}

    Comment    Check if the url is the exact URI
    ${status}    ${value}=    Run Keyword And Ignore Error
    ...    Run Keyword If    ${t_isURLExtension}
    ...    Location Should Contain    ${t_urlFinal}
    ...    ELSE    Location Should Be    ${t_urlFinal}

    Comment    Go to the specified URI
    Run Keyword Unless    '${status}' == 'PASS'    Verify Hostname Contains Http    ${t_urlFinal}
    User Should Be Redirected To "${e_PAGE_NAME}" Page

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
