*** Keywords ***
Update SauceLabs Job For Passing Tests
    Comment    Update SauceLabs Job to for passing test cases.
    ${t_testStatus} =    Set Variable If    '${TEST STATUS}'=='PASS'
    ...    true    None
    Run Keyword If    ${g_IS_SAUCELABS}
    ...    Update Saucelabs Test Result    ${s_JOB_ID}    ${t_testStatus}
    ...    %{SAUCE_USERNAME}    %{SAUCE_ACCESS_KEY}
