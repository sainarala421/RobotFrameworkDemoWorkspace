*** Variables ***
#=================================================#
#                TIMEOUT / WAIT                   #
#=================================================#
${TIMEOUT}                10x
${INTERVAL}               3s
${INTERNAL_TIMEOUT}       10s
${INTERNAL_INTERVAL}      2s
${SELENIUM_SPEED}         0.5
${ALIAS}                  browser1
${REMOTE_URL}             http://localhost:4444/wd/hub
${HEADLESS_CHROME}        False

#=================================================#
#                 URL EXTENSTIONS                 #
#=================================================#
${BASE_URL}                             http://automationpractice.com/index.php
${AUTOMATION_PRACTICE_HOME_URL}         ${BASE_URL}

#=================================================#
#                 GLOBAL CONSTANTS                #
#=================================================#
${HEADLESS}             ${FALSE}

#=================================================#
#                 DESIRED CAPABILITIES            #
#=================================================#
${PLATFORM}             ANY
${NATIVE_EVENTS}        ${FALSE}
${ALERT_BEHAVIOUR}      dismiss

#=================================================#
#                 DEFAULT BROWSER SIZE            #
#=================================================#
${DESKTOP_BROWSER_WIDTH}     1366
${DESKTOP_BROWSER_HEIGHT}    768