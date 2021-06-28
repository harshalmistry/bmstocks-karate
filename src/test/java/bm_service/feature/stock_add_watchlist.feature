Feature: Tests for Stock add to watchlist

    Background: Define URL
        Given url stocksUrl

    Scenario: Add stock to watchlist success
        And request { "userId": 99999, "stockName": "IDEA.NS" }
        When method Post
        * def uploadStatusCode = responseStatus
        Then assert responseStatus == 201 || responseStatus == 409

    Scenario: Add stock to watchlist invalid userId
        And request { "userId": -1, "stockName": "IDEA.NS" }
        When method Post
        Then status 400
        And match response.errors[0] == 'Please provide valid userId'

    Scenario: Add stock to watchlist empty userId
        And request { "userId": "", "stockName": "IDEA.NS" }
        When method Post
        Then status 400
        And match response.errors[0] == 'Please provide valid userId'

    Scenario: Add stock to watchlist missing userId
        And request { "stockName": "IDEA.NS" }
        When method Post
        Then status 400
        And match response.errors[0] == 'Please provide valid userId'

    Scenario: Add stock to watchlist empty stockName
        And request { "userId": 99999, "stockName": "" }
        When method Post
        Then status 400
        And match response.errors[0] == 'Please provide stockName'

    Scenario: Add stock to watchlist missing stockName
        And request { "userId": 99999 }
        When method Post
        Then status 400
        And match response.errors[0] == 'Please provide stockName'

    Scenario: Add stock to watchlist empty body values
        And request { "userId": "", "stockName": "" }
        When method Post
        Then status 400
        And match response.errors == '#[2]'

    Scenario: Add stock to watchlist empty body 
        And request { }
        When method Post
        Then status 400
        And match response.errors == '#[2]'