*** Keywords ***
Load jquery For jquery Elements
    [Arguments]    ${p_element}
    ${t_isJquerySelector} =    Run Keyword And Return Status     Should Contain    ${p_element}    jquery
    Run Keyword If   ${t_isJquerySelector}    Load JQuery

Load JQuery
    Execute Javascript    ${CURDIR}${/}load_jquery.js
