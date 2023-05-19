Feature: API Test Security Section
	
	Background: Setp Request URL
	 Given url "https://tek-insurance-api.azurewebsites.net"
   And path "/api/token"
	
	@Test
  Scenario: Create token with valid username and password.
    #prepare request
    And request {"username": "supervisor","password": "tek_supervisor"}
    #Send request
    When method post
    #Validating response
    Then status 200
    And print response
    
    
    
 
    Scenario: Validate token with invalid username 
    #prepare request
    And request {"username": "supervisorr","password": "tek_supervisor"}
    #Send request
    When method post
    #Validating response
    Then status 400
    And print response
    And assert response.errorMessage == "User not found"
    
    
    Scenario: Validate token with invalid password
     #prepare request
    And request {"username": "supervisor","password": "tek_supervisorr"}
    #Send request
    When method post
    #Validating response
    Then status 400
    And print response
    And assert response.errorMessage== "Password Not Matched"
    And assert response.httpStatus== "BAD_REQUEST"
