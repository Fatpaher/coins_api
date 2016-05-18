require 'rails_helper'

describe CoinExchanger do
  context 'when sum is 17' do
    it 'put calculatings eq [0, 0, 0, 10, 0, 0]' do
      coins = CoinExchanger.new(
        1 => 1,
        2 => 1,
        5 => 1,
        10 => 1,
        25 => 1,
        50 => 1
      )
      expect(coins.exchange(17)).to eq(
        1 => 0,
        2 => 1,
        5 => 1,
        10 => 1,
        25 => 0,
        50 => 0
      )
    end
    describe "when u don't have enough coins " do
      it 'raise error' do
        coins = CoinExchanger.new(
          1 => 1,
          2 => 1,
          5 => 1,
          10 => 1,
          25 => 1,
          50 => 1
        )
        expect do
          coins.exchange(100)
        end.to raise_error(CoinExchanger::NotEnoughCoins)
      end
    end
  end
end
