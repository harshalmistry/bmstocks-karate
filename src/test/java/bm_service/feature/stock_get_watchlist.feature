Feature: Tests for Stock get watchlist stocks

    Background: Define URL
        Given url stocksUrl

    Scenario: Add stock to watchlist success
        And request { "userId": 99999, "stockName": "IDEA.NS" }
        When method Post
        * def uploadStatusCode = responseStatus
        Then assert responseStatus == 201 || responseStatus == 409

    Scenario: Get watchlist stock
        Given param userId = 99999
        When method Get
        And status 200
        And match response == '#[1]'
        And match response[0].current == '#number'
        And match response[0].twoWeeksGain == '#number'
        And match response[0].stockName == 'IDEA.NS'
        And match response[0].todayGain == '#number'
        And match response[0].threeWeeksGain == '#number'
        And match response[0].id == '#number'
        And match response[0].lastWeekGain == '#number'
        And match response[0].monthGain == '#number'

    Scenario: Get watchlist stock invalid userId
        Given param userId = -1
        When method Get
        And status 400
        And match response.errors[0] contains 'Please provide valid userId'
