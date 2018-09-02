class HomeController < ApplicationController
  
  def index
    require 'net/http'
    require 'json'
    
    #News Data
    # create url to call
    @url = 'https://min-api.cryptocompare.com/data/v2/news/?lang=EN'
    @uri = URI(@url)
    # pass url to get response
    @response = Net::HTTP.get(@uri)
    # parse the response
    @news = JSON.parse(@response)

    #Price Data
    @prices_url = 'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,XRP,BCH,EOS,LTC,ADA,XLM,MIOTA,USDT,TRX&tsyms=USD'
    @prices_uri = URI(@prices_url)
    @prices_response = Net::HTTP.get(@prices_uri)
    @prices = JSON.parse(@prices_response)

  end

  def prices
  end
end
