# robot_framework_demo

Please have python installed on computer (pip included!) be sure to have them in system environment variables(C:\Python27\Scripts for windows!)
Install robotframework package:
pip install robotframework
Install Selenium2Library for robotframework:
pip install robotframework-selenium2library
Install Selenium Library because Selenium2Library has some dependencies in it:
pip install -U selenium


Project structure:

FunctionalTesting
	-DBScripts (future use when DB connection will be used)
	-ExternalComponents (webdriver repository, also can be included extensions/profiles)
	-Locators (since it is just a case study I ve put all the locators into one file, but as a best practice page object model should be used and every page should have its own file)
	-Resource directory with reusable keywords (afterSuite/beforeSuite/beforeTest/DBinsert/delete when available)
	-Results directory - html/xml/png resulted after suites run
	-TestData - if hybrid framework wants to be used - keyword driven together with data driver this folder/files can be used as a data generator / Here the syntax is so simple that no real programming is needed. For example, MY_VAR = 'my value' creates a variable ${MY_VAR} with the specified text as the value.
	Also variable files can have a special get_variables (or getVariables) method that returns variables as a mapping. Because the method can take arguments this approach is very flexible.
	-TestSuites - where are the suites located
	
If robot.bat file is in path the two suites can be started using:
robot -d C:\work\TrivFunctionalTesting\Results C:\work\TrivFunctionalTesting\TestSuites\01-Suite_SDET_Task1.r
obot C:\work\TrivFunctionalTesting\TestSuites\02-Suite_SDET_Task1.robot

or if you are in TestSuites folder:

robot -d ../Results 01-Suite_SDET_Task1.robot 02-Suite_SDET_Task1.robot

Using a linux machine the command to start suites in a headless environment would be(x virtual display server)(should be entered in TestSuites folder):
xvfb-run -n 2 '--server-args=-screen 0, 1920x1080x24' robot -d ../Results --include All ''

If emails are not updated every run some tests will fail as the application does not return succed after subscription with an already used email.

Also TestCase 02_Select_language from 02-Suite_SDET_Task1.robot FAILS as I think it is a DEFECT for SUOMI language as it is the only one with https link : https://magazine.trivago.fi goes to browser as https//magazine.trivago.fi and is not loaded ... it should be made as http as other languages?



TC 5.1:

01_Verify_trending_article
The most important part of the site as the user is entering are the articles used to suggest future destinations so verification of 
all the trending articles is crucial. Verification is done by a test case discovering on page the section of the articles and click on each wait for article to load(verify common element) verify url is 
the one from DOM and press back button to come back to magazine.  Also a test case to verify random articles can be made.

02_Select_language
Another crucial use case I consider is to verify site magazine can be changed regarding language/location.
So for this I have made a loop in which I verify every local specific magazine version is available and can be changed between.


I've chosen this 2 test cases as they are important to make visitors wanna spend some money on a trip and trending articles with a local version of the trivago magazine can help:
1.thru suggestions
2.being cultural closer to the visitor (language, location, events)



