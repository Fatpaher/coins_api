class ExchangeController < ActionController::Base
  def change
    sum = JSON.load(params[:sum])
    exchange = Exchange.first
    coins_hash = hash_of_coins(exchange.coins)
    coins_changed = CoinExchanger.new(coins_hash).exchange(sum)

    Coin.transaction do
      reduce_coins(exchange, coins_changed)

      render json: coins_changed, status: 201
    end

  rescue CoinExchanger::NotEnoughCoins
    render json: 'Not Enough Coins', status: 412
  end

  private

    def hash_of_coins(list_of_coins)
      coins_hash = Hash.new(0)
      list_of_coins.each do |i|
        coins_hash[i.value] = i.count
      end
      coins_hash
    end

    def reduce_coins(exchange, coins_hash)
      coins_hash.each do |key, value|
        coin = exchange.coins.find_by(value: key)
        coin.count -= value
        coin.save!
      end
    end
end
