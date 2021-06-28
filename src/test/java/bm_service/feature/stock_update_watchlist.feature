Feature: Tests for Stock update watchlist stock

    Background: Define URL
        Given url 'http://localhost:5000/api/stocks'

    Scenario: Add stock to watchlist success
        And request { id:"9999", "userId": 99999, "stockName": "IDEA.NS" }
        When method Post
        * print response
        * def uploadStatusCode = responseStatus
        Then assert responseStatus == 201 || responseStatus == 409

    Scenario: Update stock note success
        Given param userId = 99999
        When method Get
        And status 200
        * print response
        * def stockId = response[0].id;
        
        Given path '' + stockId
        And request { "userId": "99999", "stockName": "IDEA.NS", "userNote": "buy 10 stocks after week"}
        Given method Put
        And status 200

        Given param userId = 99999
        When method Get
        And status 200
        * print response
        And match response[0].userNote == 'buy 10 stocks after week'