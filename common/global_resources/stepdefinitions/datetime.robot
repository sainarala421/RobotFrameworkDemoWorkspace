*** Keywords ***
Generate Date Time With Milliseconds
    [Documentation]    This keyword generates date time with milliseconds
    ...    removing all special characters from the string and getting the 3rd to the 17th character
    ${t_dateTime} =    Evaluate    str(datetime.datetime.now()).translate(None, ':-. ')    datetime
    Set Global Variable    ${g_TIME_SUFFIX}    ${t_dateTime[2:17]}