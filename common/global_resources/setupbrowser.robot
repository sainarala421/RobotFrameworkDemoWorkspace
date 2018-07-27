*** Keywords ***
#=================================================#
#                    BEFORE                       #
#=================================================#
Open Browser To "${BASE_URL}"
    ${REMOTE_URL}=     Set Variable If     '${REMOTE_URL}' == 'False'
    ...    ${EMPTY}    ${REMOTE_URL}

    Run Keyword If    ${HEADLESS_CHROME}
    ...    Run Keywords    Create Chrome Webdriver
    ...    AND    Go To    ${BASE_URL}
    ...    ELSE    Run Keywords
    ...    Setup Desired Capabilities
    ...    AND    Open Browser    ${BASE_URL}    browser=${BROWSER}    alias=${ALIAS}    remote_url=${REMOTE_URL}
    ...    desired_capabilities=${DESIRED_CAPABILITIES}
    Set Selenium Speed    ${SELENIUM_SPEED}

Open Browser Instance "${e_NEW_ALIAS}" To "${BASE_URL}"
    Set Suite Variable    ${ALIAS}    ${e_NEW_ALIAS}
    Open Browser To "${BASE_URL}"

Create Chrome Webdriver
    ${REMOTE_URL}=     Set Variable If     '${REMOTE_URL}' == 'False'
    ...    ${EMPTY}    ${REMOTE_URL}
    Set Headless Chrome
    Run Keyword If    '${REMOTE_URL}' == ''
    ...    Create Webdriver    Chrome   alias=${ALIAS}    chrome_options=${CHROME_OPTIONS}
    ...    ELSE
    ...    Create Webdriver    Remote    command_executor=${REMOTE_URL}    alias=${ALIAS}
    ...    desired_capabilities=${CHROME_OPTIONS}

Set Headless Chrome
    @{t_chromeArguments}=    Create List    --disable-infobars    --headless    --disable-gpu    --no-sandbox
    ${t_chromeOptions}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    : FOR    ${t_chromeOption}    IN    @{t_chromeArguments}
    \    Call Method    ${t_chromeOptions}    add_argument    ${t_chromeOption}

    ${t_chromeOptions}=     Run Keyword If    '${REMOTE_URL}' == 'False'
    ...    Call Method     ${t_chromeOptions}    to_capabilities
    ...    ELSE    Set Variable    ${t_chromeOptions}

    Set Suite Variable    ${CHROME_OPTIONS}    ${t_chromeOptions}
    Log    ${CHROME_OPTIONS}

#=================================================#
#                    AFTER                        #
#=================================================#
Get Environment Details And Close All Browsers
    Get Test Environment Details
    Close All Browsers

#=================================================#
#                         LOGGING                 #
#=================================================#
Log Console Errors
    [Documentation]    Use this keyword to run on keyword failure.
    Capture Page Screenshot
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
    ...    Note: this is currently for chrome browser only
    ${t_extendedS2Library} =    Get Library Instance    ExtendedSelenium2Library

    # Append test environment details to suite documentation.
    Set Suite Documentation    * * * * * * TEST ENVIRONMENT DETAILS    append = True
    Set Suite Documentation    [ Browser Alias: ${ALIAS} ]    append = True
    ${t_capabilities} =    Set Variable    ${t_extendedS2Library._current_browser().capabilities}
    :FOR    ${key}    IN    @{t_capabilities.keys()}
    \    Set Suite Documentation    [ ${key} : ${t_capabilities["${key}"]} ]    append = True
