class Iex < ApplicationRecord
  def self.client 
    logger_instance = Logger.new(STDOUT)
    IEX::Api::Client.new(
      publishable_token: ENV['iex_pub_token'],
      secret_token: ENV['iex_secret_token'],
      endpoint: 'https://cloud.iexapis.com/v1',
      logger: logger_instance
    )
  end

  def self.most_active_stocks
    self.client.stock_market_list(:mostactive, {listLimit: 10})
  end
end
