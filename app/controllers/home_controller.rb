class HomeController < ApplicationController
  
  def index
    require 'net/http'
    require 'json'
    
    # create url to call
    @url = 'https://min-api.cryptocompare.com/data/v2/news/?lang=EN'
    @uri = URI(@url)
    # pass url to get response
    @response = Net::HTTP.get(@uri)
    # parse the response
    @news = JSON.parse(@response)

  end

  def prices
  end
end
