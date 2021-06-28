Feature: Tests for User login

    Background: Define URL
        Given url 'http://localhost:5100/api/users/authenticate'

    Scenario: Login success
        And request { "email": "er.harshalmistry@gmail.com", "password": "password"}
        When method Post
        Then status 200

    Scenario: Login no user 
        And request { "email": "a@a.com", "password": "12345678"}
        When method Post
        Then status 404
        And match response.errors[0] == 'No User found for  - a@a.com'

    Scenario: Login empty body 
        And request {}
        When method Post
        Then status 400
        And match response.errors == '#[2]'

    Scenario: Login missing password field
        And request { "email": "er.harshalmistry@gmail.com"}
        When method Post
        Then status 400
        And match response.errors[0] == 'Please provide password'

    Scenario: Login missing email field
        And request { "password": "password"}
        When method Post
        Then status 400
        And match response.errors[0] == 'Please provide email'

    Scenario: Login invalid email
        And request { "email": "gmail.com", "password": "password"}
        When method Post
        Then status 400
        And match response.errors[0] == 'Please provide valid email'
    
    Scenario: Login empty values
        And request { "email": "", "password": ""}
        When method Post
        Then status 400