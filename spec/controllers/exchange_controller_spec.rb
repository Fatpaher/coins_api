require 'rails_helper'

describe ExchangeController do
  describe 'POST change' do
    let(:sum) { { 'sum' => 8 } }
    let(:request_headers) do
      {
        'Accept' => Mime::JSON,
        'Content-Type' => Mime::JSON.to_s
      }
    end

    context 'when there is enough coins' do
      it 'changes specify sum with coins in stock' do
        create :coin

        post 'change', sum, request_headers

        expect(response.status).to eq 201
        expect(response.content_type).to eq Mime::JSON
      end

      it 'returns coin.value => coin.count json' do
        coin_value = 2
        coin_count = 10
        create :coin, value: coin_value, count: coin_count

        post 'change', sum, request_headers

        body = JSON.parse(response.body)

        expect(body).to eq(coin_value.to_s => 4)
      end

      it 'decrise amount of coins' do
        coin = create :coin, value: 2, count: 10

        post 'change', sum, request_headers
        coin.reload

        expect(coin.count).to eq(6)
      end
    end

    context 'when there is no enough coins' do
      it 'returns an error' do
        create :coin, value: 2, count: 2

        post 'change', sum, request_headers

        expect(response.body).to eq('Not Enough Coins')
      end

      it 'returns 412 status' do
        create :coin, value: 2, count: 2

        post 'change', sum, request_headers

        expect(response.status).to eq 412
      end

      it 'don\'t, reduce amount of coins' do
        coin = create :coin, value: 2, count: 2

        post 'change', sum, request_headers
        coin.reload

        expect(coin.count).to eq(2)
      end
    end
  end
end
