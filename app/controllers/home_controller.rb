class HomeController < ApplicationController
  
  def index
    require 'net/http'
    require 'json'
  
    
    #News Data
    # create url to call
    @url = 'https://min-api.cryptocompare.com/data/v2/news/?lang=EN'
    @uri = URI(@url)
    # pass url to get response in jSON
    @response = Net::HTTP.get(@uri)
    # parse the json response into a ruby hash
    @news = JSON.parse(@response)

    #Price Data
    @prices_url = 'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,XRP,BCH,EOS,LTC,ADA,XLM,MIOTA,USDT,TRX&tsyms=USD'
    @prices_uri = URI(@prices_url)
    @prices_response = Net::HTTP.get(@prices_uri)
    @prices = JSON.parse(@prices_response)

    # coin market data

    @coin_url = 'https://api.coinmarketcap.com/v1/ticker/'
    @coin_uri = URI (@coin_url)
    @coin_response = Net::HTTP.get(@coin_uri)
    @coins = JSON.parse(@coin_response)
    @my_coins = ["BTC", "XRP", "ADA", "XLM", "STEEM",]

  end

  def prices
    require 'net/http'
    require 'json'

  # if @symbol 
    if params[:sym].present?
      @symbol = params[:sym]
      # api only accepts upcase search queries
      @symbol = @symbol.upcase

      #Price Data
      @quote_url = 'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=' + @symbol + '&tsyms=USD'
      @quote_uri = URI(@quote_url)
      @quote_response = Net::HTTP.get(@quote_uri)
      @quote = JSON.parse(@quote_response)
    else
      redirect_to root_path, notice: 'please enter a crypto currency to search'
    end
  end

  def lookup
    require 'net/http'
    require 'json'
    
    @coin_url = 'https://api.coinmarketcap.com/v1/ticker/'
    @coin_uri = URI (@coin_url)
    @coin_response = Net::HTTP.get(@coin_uri)
    @lookup_coin = JSON.parse(@coin_response)

    @symbol = params[:sym]
    if @symbol
      @symbol = @symbol.upcase
    end


    if @symbol == ""
      @symbol = "please enter a currency"
    end

  end


   
end
