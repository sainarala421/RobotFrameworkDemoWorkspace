*** Variables ***
#=================================================#
#                TIMEOUT / WAIT                   #
#=================================================#
${TIMEOUT}                10x
${INTERVAL}               3s
${INTERNAL_TIMEOUT}       10s
${INTERNAL_INTERVAL}      2s
${SELENIUM_SPEED}         0.5
${ALIAS}                  browser_instance_1
${REMOTE_URL}             http://localhost:4444/wd/hub

#=================================================#
#                 URL EXTENSTIONS                 #
#=================================================#
${BASE_URL}                             http://automationpractice.com
${AUTOMATION_PRACTICE_HOME_PAGE_URL}    ${BASE_URL}


#=================================================#
#                 GLOBAL CONSTANTS                #
#=================================================#
${HEADLESS}                             ${FALSE}

#=================================================#
#                 DESIRED_CAPABILITIES            #
#=================================================#
${PLATFORM}             ANY
${NATIVE_EVENTS}        ${FALSE}
${ALERT_BEHAVIOUR}      dismiss