*** Settings ***
Library           Selenium2Library
#Library           AppiumLibrary
Library           String
#Library           Collections
#Library           OperatingSystem
Library           ./pythonlibs/compare_string.py

# elements
Resource          ./elements/CommonElements.robot
Resource          ./elements/HomePage.robot
Resource          ./elements/BuyPage.robot
# keywords
Resource          ./keywords/common/CommonUtils.robot
Resource          ./keywords/common/CommonUtils.robot
Resource          ./keywords/function/AddtoCart.robot

#config
Variables         ./config_${env}.yaml

#variable
Resource          ./variables/Common.robot
Resource          ./variables/API.robot

