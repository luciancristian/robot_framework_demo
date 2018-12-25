*** Settings ***

Suite Setup       beforeSuite
Suite Teardown    afterSuite
Test Setup        beforeTest
Library           Selenium2Library
Resource          ../Resource/CommonFunctions.robot
Library           DatabaseLibrary
Variables         ../TestData/Variables.py
Variables         ../Locators/Elements.py
Variables         ../TestData/DataInputs.py

*** Test Cases ***
01_Verify_trending_article
    Comment    **********Step 1**********
    Element Should Be Visible  ${RecentArticles}
    Element Should Be Visible  ${ArticlesTitle1}
    ${trending_now}=  Get Text  ${ArticlesTitle2}
    Should Be Equal as Strings  ${trending_now}  Trending Now
    ${rowcount}=    Get Matching Xpath Count  ${RecentArticles }/div
    Should be True  ${rowcount}>0
    : FOR    ${item}    IN RANGE    1    ${rowcount}+1
    \   ${url}=  Get Element Attribute  ${RecentArticles}/div[${item}]/a@href
    \   Click Element  ${RecentArticles}/div[${item}]
    \   Sleep  2s
    \   ${url_current}=   Get Location
    \   Should Be Equal As Strings  ${url}  ${url_current}
    \   Go Back
    \   Sleep  2s
    
#    also random version could be used for only one article 
#    ${random_item}=  Evaluate  random.sample(range(1, ${rowcount}),1)  random
#    ${url}=  Get Element Attribute  xpath=//div[contains(@class,'recent-articles-section row')]/div${random_item}/a@href
#    Click Element  //div[contains(@class,'recent-articles-section row')]/div${random_item}
#    Sleep  2s
#    ${url_current}=   Get Location
#    Should Be Equal As Strings  ${url}  ${url_current}

02_Select_language
    Comment    **********Step 1**********
    ${rowcount}=    Get Matching Xpath Count    ${CountrySelectDropdown}
    : FOR    ${item}    IN RANGE    1    ${rowcount}+1
    \    
    \    Click Element  ${CountrySelectDropdown}[${item}]
    \    ${result}=  Get Text  ${CountrySelectDropdown}[${item}]
    \    ${url}=  Get Element Attribute  ${CountrySelectDropdown}[${item}]@value
    \    ${url}=  Catenate   SEPARATOR=  ${url}   /
    \    Click Element  ${CountrySelectDropdown}[${item}]
    \    Sleep  2s
    \    ${url_current}=   Get Location
    \    Should Be Equal As Strings  ${url}  ${url_current}
    \    ${response}=  RunKeyword And Return Status  Element Should Be Visible  ${MenuOpen}
    \    Run Keyword If  not ${response}  Exit For Loop 
    
