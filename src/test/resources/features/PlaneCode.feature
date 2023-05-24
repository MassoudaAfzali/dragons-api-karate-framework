@Regression
Feature: Plan Code Feature

Background: Setup api tests and get token 

* def calltoken = callonce read('GenerateToken.feature')

* def token = calltoken.response.token
Given url "https://tek-insurance-api.azurewebsites.net"

Scenario: Get all plan code api
Given path "/api/plans/get-all-plan-code"
And header Authorization = "Bearer " + token
When method get
Then status 200
And print response


