@Smoke
Feature: Account Testing

Background: Setup Test Generate Token
* def calltoken = callonce read('GenerateToken.feature')
* def token = calltoken.response.token

Given url "https://tek-insurance-api.azurewebsites.net"

#Create Account
Scenario: End to End Account testing
* def dataGenerator = Java.type('api.data.GenerateData')
* def autoEmail = dataGenerator.getEmail()
Given path "/api/accounts/add-primary-account"
And header Authorization = "Bearer " + token
And request
"""
{
"email": "#(autoEmail)",
"firstName": "Massouda",
"lastName": "Afzali","title": "Ms.",
"gender": "FEMALE","maritalStatus": "MARRIED",
"employmentStatus": "Jobless",
"dateOfBirth": "1985-02-08"
}
"""
When method post
Then status 201
Then print response
And assert response.email == autoEmail

#Add Address
Given path "/api/accounts/add-account-address"
And header Authorization = "Bearer " + token
And param primaryPersonId = response.id
And request
"""
{

"addressType": "TownHouse",
"addressLine1": "736 Rieply street",
"city": "Alexandria",
"state": "VA",
"postalCode": "22784",
"countryCode": "string",
"current": true
}
"""
When method post
Then status 201
Then print response
And assert response.addressType == "TownHouse"

#Add Phone
Given path "/api/accounts/add-account-phone"
And header Authorization = "Bearer " + token
And param primaryPersonId = response.id
And request
"""
{

"phoneNumber": "279-866-3087",
"phoneExtension": "101",
"phoneTime": "Morning",
"phoneType": "cell"
}
"""
When method post
Then status 201
Then print response
And assert response.phoneNumber == "279-866-3087"

#Add Car
Given path "/api/accounts/add-account-car"
And header Authorization = "Bearer " + token
And param primaryPersonId = response.id
And request
"""
{

"make": "Toyota",
"model": "Sieana",
"year": "2000",
"licensePlate": "VA234"
}
"""
When method post
Then status 201
Then print response
And assert response.make == "Toyota"

#Get Account
Given path "/api/accounts/get-account"
And param primaryPersonId = 7486
And header Authorization = "Bearer " + token
When method get
Then status 200
And print response
And assert response.primaryPerson.id == 7486