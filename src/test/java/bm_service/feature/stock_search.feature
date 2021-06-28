Feature: Tests for Stock search

    Background: Define URL
        Given url stocksUrl

    Scenario: Search stock success
        Given path 'SBICARD.NS'
        When method Get
        Then status 200
        And match response == {"yearLow": '#number',"previousClose":'#number',"stockName":"SBICARD.NS","lastAccessTime":"#notnull","price":'#number',"id":0,"userId":0,"yearHigh":'#number',"open":'#number'}
    

    Scenario: Search empty stock name
        Given path ''
        When method Get
        Then status 400

    Scenario: Search invalid stock name
        Given path 'ADSFAFFAFAS'
        When method Get
        Then status 404
        And match response.errors[0] == 'No stock found for - ADSFAFFAFAS'