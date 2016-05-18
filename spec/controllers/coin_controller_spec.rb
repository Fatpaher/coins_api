require 'rails_helper'

describe CoinsController do
  describe 'POST set' do
    it 'create coins and set their quantity' do
      coins =  {
        'coins' => [
          {
            'value' => 10,
            'count' => 2
          }
        ]
      }.to_json

      request_headers = {
        'Accept' => Mime::JSON,
        'Content-Type' => Mime::JSON.to_s
      }

      post 'set', coins, request_headers

      expect(response.status).to eq 201
      expect(response.content_type).to eq Mime::JSON
    end
  end
end
