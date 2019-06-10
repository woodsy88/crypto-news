class CryptosController < ApplicationController
  before_action :set_crypto, only: [:edit, :show, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :destroy]
  
  def index

    require 'net/http'
    require 'json' 

    @cryptos = Crypto.all
    @current_user_cryptos = current_user.cryptos

    # coin market data
    @coin_url = 'https://api.coinmarketcap.com/v1/ticker/'
    @coin_uri = URI (@coin_url)
    @coin_response = Net::HTTP.get(@coin_uri)
    @lookup_cryptos = JSON.parse(@coin_response)    
  end

  def new
    @crypto = Crypto.new
  end

  def show

    require 'net/http'
    require 'json' 

    # coin market data
    @coin_url = 'https://api.coinmarketcap.com/v1/ticker/'
    @coin_uri = URI (@coin_url)
    @coin_response = Net::HTTP.get(@coin_uri)
    @all_coins = JSON.parse(@coin_response)  

  end

  def create
    @crypto = Crypto.new(crypto_params)
    @crypto.user_id = current_user.id
    @crypto.symbol = @crypto.symbol.upcase


		if @crypto.save
			redirect_to cryptos_path, notice: 'Your crypto was created successfully'
		else
			render :new
		end
  end

  def edit
    authorize @crypto
  end

  def update
    authorize @crypto
    if @crypto.update(crypto_params)
      redirect_to cryptos_path, notice: 'Your crypto was updated successfully'
    else
      render :edit, notice: 'there was a problem'    
    end    
  end

  def destroy
    @crypto.destroy
    respond_to do |format|
        format.html { redirect_to cryptos_url, notice: 'crypto deleted' }
    end          
  end


  private

  def crypto_params
    params.require(:crypto).permit(
                                  :symbol,
                                  :cost_per,
                                  :amount_owned,
                                  :user_id
    )
  end

  def set_crypto
    @crypto = Crypto.find(params[:id])
  end
end
