class CoinExchanger
  class NotEnoughCoins < StandardError; end

  def initialize(start_coins)
    @start_coins = start_coins.dup
  end

  def exchange(sum)
    result_coins = Hash.new(0)
    @start_coins.keys.each do |coin_value|
      result_coins[coin_value] = 0
    end

    @start_coins.keys.sort.reverse!.each do |coin_value|
      while sum >= coin_value
        if sum >= coin_value && @start_coins[coin_value] > 0
          sum -= coin_value
          result_coins[coin_value] += 1
          @start_coins[coin_value] -= 1
        else
          break
        end
      end
    end
    raise NotEnoughCoins if sum > 0
    result_coins
  end
end
