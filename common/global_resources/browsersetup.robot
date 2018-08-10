*** Keywords ***
#=================================================#
#                    BEFORE                       #
#=================================================#
Open Browser To "${BASE_URL}"
    ${REMOTE_URL}=     Set Variable If     '${REMOTE_URL}' == 'False'
    ...    ${EMPTY}    ${REMOTE_URL}

    Run Keyword If    ${HEADLESS_CHROME} and '${BROWSER.lower()}' == 'chrome'
    ...    Run Keywords    Create Headless Chrome Webdriver
    ...    AND    Go To    ${BASE_URL}
    ...    ELSE    Run Keywords
    ...    Comment    Keyword for non-headless browsers.
    ...    AND    Setup Desired Capabilities
    ...    AND    Open Browser    ${BASE_URL}    browser=${BROWSER}    alias=${ALIAS}    remote_url=${REMOTE_URL}
    ...    desired_capabilities=${s_DESIRED_CAPABILITIES}

    Comment    Set Selenium Speed and Maximize browser.
    Set Selenium Speed    ${SELENIUM_SPEED}
    Setup Default Browser Window Size

    Comment    Record the test environment details.
    Run Keyword And Ignore Error    Get Test Environment Details

Open Browser Instance "${e_NEW_ALIAS}" To "${BASE_URL}"
    Set Suite Variable    ${ALIAS}    ${e_NEW_ALIAS}
    Open Browser To "${BASE_URL}"

Create Headless Chrome Webdriver
    [Documentation]    Create the chrome webdriver for headless chrome.
    Set Headless Chrome Options
    Comment    Set chrome options value.
    ${t_chromeOptions}=     Run Keyword If    '${REMOTE_URL}' == 'False'
    ...    Call Method     ${s_CHROME_OPTIONS}    to_capabilities
    ...    ELSE    Set Variable    ${s_CHROME_OPTIONS}

    Comment    Set remoteURL value.
    ${t_remoteURL}=     Set Variable If     '${REMOTE_URL}' == 'False'
    ...    ${EMPTY}    ${REMOTE_URL}

    Run Keyword If    '${t_remoteURL}' == '${EMPTY}'    Run Keywords
    ...    Comment    Non-remote headless test execution.
    ...    AND    Create Webdriver    Chrome   alias=${ALIAS}    chrome_options=${s_CHROME_OPTIONS}
    ...    ELSE    Run Keywords
    ...    Comment    Remote headless test execution.
    ...    AND    Create Webdriver    Remote    command_executor=${t_remoteURL}    alias=${ALIAS}
    ...    desired_capabilities=${s_CHROME_OPTIONS}

Set Headless Chrome Options
    [Documentation]    Add chrome arguments for headless and no sandbox.
    @{t_chromeArguments}=    Create List    --disable-infobars    --headless    --disable-gpu    --no-sandbox
    ${t_chromeOptions}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    : FOR    ${t_chromeOption}    IN    @{t_chromeArguments}
    \    Call Method    ${t_chromeOptions}    add_argument    ${t_chromeOption}
    Set Suite Variable    ${s_CHROME_OPTIONS}    ${t_chromeOptions}
    Log    ${s_CHROME_OPTIONS}

Setup Default Browser Window Size
    Set Window Size    ${DESKTOP_BROWSER_WIDTH}    ${DESKTOP_BROWSER_HEIGHT}

#=================================================#
#                   LOGGING                       #
#=================================================#
Log Console Errors
    [Documentation]    Use this keyword to run on keyword failure.
    Run Keyword And Ignore Error    Capture Page Screenshot
    ${t_logs}=    Get Browser Logs
    ${t_logs}=    Remove Duplicates    ${t_logs}
    Log    ${t_logs}

Get Browser Host IP
    ${t_host_ip} =     Execute Async JavaScript
    ...    var callback = arguments[arguments.length -1];
    ...    fetch('//ipapi.co/json/').then(response=>response.json()).then(data => callback(data.ip));
    Set Suite Variable    ${s_BROWSER_HOST_IP}    ${t_host_ip}

Get Test Environment Details
    [Documentation]    This test is for logging the test environment details.
    ${t_extendedS2Library} =    Get Library Instance    ExtendedSelenium2Library
    ${t_windowWidth}    ${windowLength}    Get Window Size
    ${t_envDictionary}=    Create Dictionary    window size = ${t_windowWidth} x ${windowLength}
    ${t_capabilities} =    Set Variable    ${t_extendedS2Library._current_browser().capabilities}

    Comment    Get the browser capabilities and assign to dictionary.
    :FOR    ${key}    IN    @{t_capabilities.keys()}
    \    Set To Dictionary    ${t_envDictionary}    ${key}=${t_capabilities["${key}"]}
    \    Log    ${key}=${t_capabilities["${key}"]}
    Set Suite Variable    ${ENVIRONMENT_DETAILS}    ${t_envDictionary}

    Run Keyword If    ${g_IS_SAUCELABS}    Run Keywords
    ...    Comment    Get Session ID / Job ID for SauceLabs
    ...    AND    Set Suite Variable    ${s_JOB_ID}    ${t_capabilities["webdriver.remote.sessionid"]}

Log Environment Details In Suite Documentation
    ${envVarDictionaryExists} =    Run Keyword And Return Status
    ...    Variable Should Exist    @{ENVIRONMENT_DETAILS}
    ${t_emptyDictionary}=    Create Dictionary    ${EMPTY}=${EMPTY}
    ${t_envDictionary}=    Set Variable If    ${envVarDictionaryExists}
    ...    ${ENVIRONMENT_DETAILS}    ${t_emptyDictionary}
    # Append test environment details to suite documentation.
    Set Suite Documentation    * * * * * * TEST ENVIRONMENT DETAILS * * * * * *    append = True
    Set Suite Documentation    Browser Alias: ${ALIAS};    append = True
    :FOR    ${key}    IN    @{t_envDictionary}
    \    Set Suite Documentation    ${key} : ${t_envDictionary["${key}"]};    append = True

Document Window Size
    ${t_windowWidth}    ${windowLength}    Get Window Size
    Set Suite Documentation    Window Size: ${t_windowWidth} x ${windowLength};    append = True

Get "${e_RUN_TYPE}" Result
    Set Suite Variable    ${s_${e_RUN_TYPE}_STATUS}    ${${e_RUN_TYPE} STATUS}
    Log    ${s_${e_RUN_TYPE}_STATUS}
