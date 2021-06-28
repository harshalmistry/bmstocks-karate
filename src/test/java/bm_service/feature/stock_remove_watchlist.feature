Feature: Tests for Stock remove watchlist stocks

    Background: Define URL
        Given url 'http://localhost:5000/api/stocks/'

    Scenario: Add stock to watchlist success
        And request { id:"9999", "userId": 99999, "stockName": "IDEA.NS" }
        When method Post
        * print response
        * def uploadStatusCode = responseStatus
        Then assert responseStatus == 201 || responseStatus == 409

    Scenario: remove stock from watchlist success
        Given param userId = 99999
        When method Get
        And status 200
        * print response
        * def stockId = response[0].id;

        Given path '' + stockId
        Given method Delete
        And status 200

        Given param userId = 99999
        When method Get
        And status 200
        And match response == '#[0]'

    Scenario: remove invalid stock from watchlist
        Given path '' + 34424242
        Given method Delete
        And status 500
        And match response.errors[0] contains '34424242 exists'

        