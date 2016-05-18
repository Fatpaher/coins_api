class CoinsController < ActionController::Base
  def set
    coins = JSON.load(request.raw_post)
    exchange = Exchange.first || Exchange.create

    coins['coins'].each do
      new_coin = exchange.coins.new
      new_coin.save!
    end
    render nothing: :true, json: :ok, status: 201
  end
end
