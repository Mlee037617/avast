
*** Keywords ***

Wait And Input Text
    [Arguments]  ${xpath}  ${text}  ${timeout}=${post_pause}
    Wait Until Element Is Visible  ${xpath}  timeout=${timeout}
    Input Text  xpath=${xpath}  ${text}

Launch Browser
    [Arguments]  ${browser}=${default_browser}  ${max_window}=${True}
    ${alias}=  Generate Random String
    Create Webdriver  ${browser}  alias=${alias}
    Run Keyword If  ${max_window}  Maximize Browser Window
    [Return]  ${alias}

