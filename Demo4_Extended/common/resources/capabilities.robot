*** Variables ***
${BROWSER}              chrome
${PLATFORM}             WINDOWS
${NATIVE_EVENTS}        ${FALSE}
${ALERT_BEHAVIOUR}      dismiss

*** Keywords ***
Setup Desired Capabilities
    ${t_DefaultDC}=    Evaluate   sys.modules['selenium.webdriver'].DesiredCapabilities.FIREFOX    sys, selenium.webdriver
    ${DC}=   Copy Dictionary   ${t_DefaultDC}
    Set To Dictionary    ${DC}
    ...    platform=${PLATFORM}
    ...    nativeEvents=${NATIVE_EVENTS}
    ...    unexpectedAlertBehaviour=${ALERT_BEHAVIOUR}
    Log    ${DC}
    Set Suite Variable    ${DESIRED_CAPABILITY}    ${DC}
