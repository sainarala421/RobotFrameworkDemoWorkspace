*** Keywords ***
Open Browser To "${BASE_URL}"
    Run Keyword If    ${HEADLESS_CHROME}
    ...    Run Keywords    Create Chrome Webdriver
    ...    AND    Go To    ${BASE_URL}
    ...    ELSE
    ...    Run Keywords    Setup Desired Capabilities
    ...    AND    Open Browser    ${BASE_URL}    browser=${BROWSER}
    ...    alias=${ALIAS}    remote_url=${REMOTE_URL}
    ...    desired_capabilities=${DESIRED_CAPABILITIES}
    Set Selenium Speed    ${SELENIUM_SPEED}

Create Chrome Webdriver
    Set Headless Chrome
    Run Keyword If    '${REMOTE_URL}' != '${EMPTY}'
    ...    Create Webdriver    Remote    command_executor=${REMOTE_URL}    alias=${ALIAS}    desired_capabilities=${CHROME_OPTIONS}
    ...    ELSE
    ...    Create Webdriver    Chrome   alias=${ALIAS}    chrome_options=${CHROME_OPTIONS}

Get Chrome Test Environment Details
    [Documentation]    This test is for logging the test environment details.
    ...    Note: this is currently for chrome browser only
    ${t_extendedS2Library} =    Get Library Instance    ExtendedSelenium2Library
    ${t_capabilities} =    Set Variable    ${t_extendedS2Library._current_browser().capabilities}
    Set Suite Documentation    [TEST ENVIRONMENT]:    append = True
    Set Suite Documentation    Chromedriver Version: ${t_capabilities['chrome']['chromedriverVersion']};    append = True
    Set Suite Documentation    Browser: ${t_capabilities['browserName']};    append = True
    Set Suite Documentation    Browser Version: ${t_capabilities['version']};    append = True
    Set Suite Documentation    Platform: ${t_capabilities['platform']};    append = True
    Log    Capabilities: ${t_capabilities}
