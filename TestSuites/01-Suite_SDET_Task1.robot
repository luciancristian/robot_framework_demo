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
01_Search_a_destination
    Comment    **********Step 1**********
    Click Element    ${SearchDestination}
    Input Text    ${SearchInput}     ${DestinationCountryValue}
    #here wanted to click on search icon but it does not work 
    #Click Element    xpath=//div[@class='search-icon input-search-icon']
    #press enter key for submit searched location
    Press Key    ${SearchInput}    \\13
    Comment    **********Step 2 verification**********
    ${search_results}=  Get Text  ${SearchResultsTitle}
    Should Match Regexp  ${search_results}  \\d+\\s+Search Results
    ${count}=    Get Matching Xpath Count    ${SearchResultsSection}
    Should Be True    ${count} > 0

02_Fill_contact_form
    Comment    **********Step 1**********
    Click Element  ${Contact}
    ${handle}=  Select Window   NEW 
    Input Text  ${ContactMessage}  ${ContactMessageValue}
    Input Text  ${ContactName}  ${ContactNameValue}
    Input Text  ${ContactEmail}  ${ContactEmailValue}
    Click Element  ${ConfirmBox}
    Click Element  ${ContactSubmit}
    Comment    **********Step 2 - verification**********
    ${url_contact}=  Set Variable  ${CONTACT_PAGE_URL}
    ${url}=   Get Location
    Should Be Equal As Strings  ${url}  ${url_contact}
    Element Should Be Visible  ${ContactResponse}
    ${message}=  Get Text  ${ContactResponse}
    ${message}=  Convert to string    ${message}
    ${message_verification}=  Set Variable  ${MESSAGE_SENT_SUCCESSFULLY}
    ${message_verification}=  Convert to string  ${message_verification}
    Should Be Equal  ${message}  ${message_verification}
    Comment    **********Step 3 get back to initial tab**********
    Select Window  trivago Magazine
    
03_Subscribe_Newsletter
    Comment    **********Step 1**********
    Element should be visible  ${NewsletterSubmit}
    Input Text  ${NewsletterEmail}  ${NewsletterEmailValue}
    Click Element  ${NewsletterSubmit}
    Sleep  4s
    Comment    **********Step 2 verification**********
    #Stale Element Wait    xpath=//div[@class='container-wide']/p[@class='submitted h1']    20s
    Element Should be visible  ${NewsletterResponse}
    ${message}=  Get Text  ${NewsletterResponseText}
    ${message}=  Convert to string    ${message}
    ${message_verification}=  Set Variable  ${EMAIL_SUBSCRIBE_MESSAGE}
    ${message_verification}=  Convert to string  ${message_verification}
    Should Be Equal  ${message}  ${message_verification}

04_Navigate_destination_top_left
    Comment    **********Step 1**********
    Wait Until Keyword Succeeds     3 times         2s      Click Element  ${MenuOpen}
    ${rowcount}=    Get Matching Xpath Count    ${DestinationContainer}
    : FOR    ${item}    IN RANGE    1    ${rowcount}
    \    ${status}    Get Text    ${DestinationContainer}/div[${item}]${DestinationSingle}
    \    ${status}=  Convert to string  ${status}
    \    Run Keyword If  '${status}'=='${LocationSearchValue}'  Click Element  ${DestinationContainer}/div[${item}]${DestinationSingle}
    \    Sleep  2s
    Comment    **********Step 2 verification**********
    ${url_northeast}=  Set Variable  ${NORTHEAST_URL}
    Sleep  2s
    ${url}=   Get Location
    Should Be Equal As Strings  ${url}  ${url_northeast}
