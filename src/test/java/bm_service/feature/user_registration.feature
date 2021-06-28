Feature: Tests for User registration

    Background: Define URL
        Given url 'http://localhost:5100/api/users/register'

    @ignore
    #  (to check this scenario) Remove @ignore tag and update email to some random email, which is not registered 
    Scenario: Register success
        And request { "email": "er.harshalmistry112@gmail.com", "password": "password" ,"dob": "1989-10-22"}
        When method Post
        Then status 201


    Scenario: Register dupliate user
        And request { "email": "er.harshalmistry@gmail.com", "password": "password" ,"dob": "1989-10-22"}
        When method Post
        Then status 409

    Scenario: Register missing dob
        And request { "email": "er.harshalmistry@gmail.com", "password": "password"}
        When method Post
        Then status 400
        And match response.errors[0] == 'Please provide DateOfBirth'

    Scenario: Register missing password
        And request { "email": "er.harshalmistry@gmail.com", "dob": "1989-10-22"}
        When method Post
        Then status 400
        And match response.errors[0] == 'Please provide password'

    Scenario: Register missing email
        And request {  "password": "password", "dob": "1989-10-22"}
        When method Post
        Then status 400
        And match response.errors[0] == 'Please provide email'

    Scenario: Register all empty fields
        And request { "email": "", "password": "", "dob": ""}
        When method Post
        Then status 400

    @ignore
    #  (to check this scenario) Remove @ignore tag and change dob to future date
    Scenario: Register future dob
        # Always change dob to future date 
        And request { "email": "er.harshalmistry1@gmail.com", "password": "password" ,"dob": "2021-06-27"}
        When method Post
        Then status 400
        And match response.errors[0] == 'DateOfBirth must be past value'
    
    Scenario: Register 8 char passwrod
        # Always change dob to future date 
        And request { "email": "er.harshalmistry1@gmail.com", "password": "1234567" ,"dob": "1989-10-22"}
        When method Post
        Then status 400
        And match response.errors[0] == 'Password must be 8 characters long'
        