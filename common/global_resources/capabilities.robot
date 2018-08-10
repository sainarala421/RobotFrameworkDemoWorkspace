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
    Comment    Assign these capabilities for non-IE
    Run Keyword If    '${BROWSER}' != 'internetexplorer' or '${BROWSER}' != 'ie'
    ...    Set To Dictionary    ${t_dcDictionary}
    ...    platform=${PLATFORM}
    ...    nativeEvents=${NATIVE_EVENTS}
    ...    unexpectedAlertBehaviour=${ALERT_BEHAVIOUR}

    Comment    Assign sauce credentials in capabilities for sauce labs test execution
    ${t_isSauceLabs}=    Run Keyword And Return Status
    ...    Should Contain    ${REMOTE_URL.lower()}    saucelabs.com
    Run Keyword If    ${t_isSauceLabs}    Run Keywords
    ...    Set To Dictionary    ${t_dcDictionary}
    ...    username=%{SAUCE_USERNAME}
    ...    accesskey=%{SAUCE_ACCESS_KEY}
    ...    build=@{TEST TAGS}[0]
    ...    tags=@{TEST TAGS}
    ...    AND    Log    '@{TEST TAGS}'
    Set Global Variable    ${g_IS_SAUCELABS}    ${t_isSauceLabs}
    Set Suite Variable    ${s_DESIRED_CAPABILITIES}    &{t_dcDictionary}
    Log    ${s_DESIRED_CAPABILITIES}
