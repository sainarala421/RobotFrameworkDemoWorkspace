*** Keywords ***
Setup Desired Capabilities
    ${t_browser}=    Set Variable If
    ...    '${BROWSER}' == 'chrome' or '${BROWSER}' == 'ch'    CHROME
    ...    '${BROWSER}' == 'safari'    SAFARI
    ...    '${BROWSER}' == 'firefox' or '${BROWSER}' == 'ff'    FIREFOX
    ...    '${BROWSER}' == 'internetexplorer' or '${BROWSER}' == 'ie'    INTERNETEXPLORER

    &{t_dcDictionary}=    Create Dictionary
    ${t_defaultCapabilities}=    Evaluate   sys.modules['selenium.webdriver'].DesiredCapabilities.${t_browser}
    ...    sys, selenium.webdriver
    &{t_dcDictionary}=   Copy Dictionary   ${t_defaultCapabilities}

    # Non-IE
    Run Keyword If    '${BROWSER}' != 'internetexplorer' or '${BROWSER}' != 'ie'
    ...    Set To Dictionary    ${t_dcDictionary}
    ...    platform=${PLATFORM}
    ...    nativeEvents=${NATIVE_EVENTS}
    ...    unexpectedAlertBehaviour=${ALERT_BEHAVIOUR}

    Set Suite Variable    ${DESIRED_CAPABILITIES}    &{t_dcDictionary}
    Log    ${DESIRED_CAPABILITIES}
