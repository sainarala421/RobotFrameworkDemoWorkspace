*** Variables ***
# Remote Host


*** Keywords ***
Setup Desired Capabilities
    ${t_browser}=    Set Variable If
    ...    '${BROWSER}' == 'chrome' or '${BROWSER}' == 'ch'    CHROME
    ...    '${BROWSER}' == 'safari'    SAFARI
    ...    '${BROWSER}' == 'firefox' or '${BROWSER}' == 'ff'    FIREFOX
    ...    '${BROWSER}' == 'internetexplorer' or '${BROWSER}' == 'ie'    INTERNETEXPLORER

    ${t_dcDictionary}=    Create Dictionary

    ${t_defaultCapabilities}=    Evaluate   sys.modules['selenium.webdriver'].DesiredCapabilities.${t_browser}    sys, selenium.webdriver
    ${t_dcDictionary}=   Copy Dictionary   ${t_defaultCapabilities}

    # Non-IE
    Run Keyword If    '${BROWSER}' != 'internetexplorer' or '${BROWSER}' != 'ie'
    ...    Set To Dictionary    ${t_dcDictionary}
    ...    platform=${PLATFORM}
    ...    nativeEvents=${NATIVE_EVENTS}
    ...    unexpectedAlertBehaviour=${ALERT_BEHAVIOUR}

    # Headless Chrome
    # Run Keyword If    ${HEADLESS_CHROME}
    # ...    Run Keywords
    # ...    Set Headless Chrome
    # ...    AND    Set To Dictionary    ${t_dcDictionary}
    # ...    chrome_options=${CHROME_OPTIONS}

    Set Suite Variable    ${DESIRED_CAPABILITIES}    ${t_dcDictionary}
    Log    ${t_dcDictionary}

Set Headless Chrome
    ${t_chromeOptions}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${t_chromeOptions}    add_argument    headless
    Call Method    ${t_chromeOptions}    add_argument    disable-gpu
    # ${t_chromeOptions}=     Call Method     ${t_chromeOptions}    to_capabilities
    Set Suite Variable    ${CHROME_OPTIONS}    ${t_chromeOptions}
    Log    ${CHROME_OPTIONS}