*** Settings ***

Library           String
Library           OperatingSystem
Library           DatabaseLibrary
Variables         ../TestData/Variables.py

*** Keywords ***
#DB part to be implemented when access is provided
afterSuite
#    Connect To Database  
#    Execute delete sql script
#    Disconnect From Database
     Close All Browsers

#DB part to be implemented when access is provided
beforeSuite
#    Connect To Database  
#    Execute Insert Sql Script 
#    Disconnect From Database
    Append To Environment Variable    PATH    ${CURDIR}/../ExternalComponents/
	${chrome_options}=		Run Keyword if		'${BROWSER}'=='chrome' or '${BROWSER}'=='googlechrome'		Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
	Run Keyword If    '${BROWSER}'=='chrome' or '${BROWSER}'=='googlechrome'	Run Keywords     
	...		Call Method    ${chrome_options}    add_argument    --disable-cache	
  	...     AND    Create Webdriver    Chrome      chrome_options=${chrome_options}
    Maximize Browser Window
    Go To    ${URL}


beforeTest
    :FOR     ${i}    IN RANGE    5
    \   Reload Page
    \   Sleep  3s
    \   Set Browser Implicit Wait   3s
    \   ${result}=  Run Keyword And Return Status  Element Should Be Visible    xpath=//div[@class='nav-icon']
#    \   ${title}=  Get Window Titles
#    \   ${verify}=  Set Variable  ${PAGE_TITLE}
#    \   ${result2}=  Convert to string    ${title[0]}
#    \   ${response}=  Should Be Equal  ${verify}  ${result2} 
    \   Run Keyword If  ${result}  Exit For Loop 
    Run Keyword If  ${result}    Log  Home Page Load OK!
