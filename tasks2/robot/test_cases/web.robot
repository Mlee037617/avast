*** Settings ***
Library  SeleniumLibrary  timeout=10s
Library  String
Variables  ../vars/var.py
Resource  ../keywords/web_keywords.robot

*** Variables ***
${web}  demoqa
${default_browser}  Chrome
${get_pause}  3s
${post_pause}  10s

*** Test Cases ***
Negative Test
    [tags]  negative
    [Setup]  Launch Browser
    Go To  ${base_url}[${web}]
    Wait Until Page Contains  ${texts}[home_page][title]
    Submit Form
    Page Should Contain  ${texts}[home_page][title]
    [Teardown]  Close Browser

Submit With Required Fields Test
    [tags]  required
    [Setup]  Launch Browser
    Go To  ${base_url}[${web}]
    Wait Until Page Contains  ${texts}[home_page][title]
    Fill Required Fields
    Submit Form
    Wait Until Page Contains  ${texts}[home_page][msgs][success]
    [Teardown]  Close Browser

Incorrect Mobile Number Format
    [tags]  negative  incorrect_mobile_format
    [Setup]  Launch Browser
    Go To  ${base_url}[${web}]
    Wait Until Page Contains  ${texts}[home_page][title]
    Fill Required Fields  incorrect_num_format=${True}
    Submit Form
    Wait Until Page Does Not Contain  ${texts}[home_page][msgs][success]
    [Teardown]  Close Browser

Incorrect Mobile Number Length
    [tags]  negative  incorrect_mobile_len
    [Setup]  Launch Browser
    Go To  ${base_url}[${web}]
    Wait Until Page Contains  ${texts}[home_page][title]
    Fill Required Fields  num_len=5
    Submit Form
    Wait Until Page Does Not Contain  ${texts}[home_page][msgs][success]
    [Teardown]  Close Browser

Long Name Test
    [tags]  long_name
    [Setup]  Launch Browser
    Go To  ${base_url}[${web}]
    Wait Until Page Contains  ${texts}[home_page][title]
    Fill Required Fields  long_name=${True}
    Submit Form
    Wait Until Page Contains  ${texts}[home_page][msgs][success]
    [Teardown]  Close Browser

*** Keywords ***
Fill Required Fields
    [Arguments]  ${num_len}=10  ${gender}=male  ${long_name}=${False}  ${incorrect_num_format}=${False}
    ${first_name}=  Generate Random String
    IF  ${long_name}
        ${first_name}=  Generate Random String  1024
    END
    Wait And Input Text  ${xpaths}[required_fields][texts][first_name]  ${first_name}
    ${last_name}=  Generate Random String
    Wait And Input Text  ${xpaths}[required_fields][texts][last_name]  ${last_name}
    ${nums}=  Generate Random String  ${num_len}  [NUMBERS]
    IF  ${incorrect_num_format}
        ${nums}=  Generate Random String  ${num_len}  [LETTERS]
    END
    Wait And Input Text  ${xpaths}[required_fields][nums][mobile]  ${nums}
    Execute Java Script  document.getElementById("${ids}[radios][gender][${gender}]").checked = true