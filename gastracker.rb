require 'sinatra/base'

require 'haml'
require 'sass'
require 'json'

require 'data_mapper'
Dir.glob('./models/*.rb').each { |f| require f }

class GasTracker < Sinatra::Base
  configure do
    set :sessions, true

    DataMapper.setup(:default, "sqlite:database/development.db")
    DataMapper.auto_upgrade!
    DataMapper.finalize
  end

  get '/' do 
    @purchase = GasPurchase.create(
      :timestamp => Time.new,
      :gallons => 8.3,
      :miles => 250.0
    )
    @purchase.save

    haml :index
  end

  run! if app_file == $0
end

require './routes/purchase.rb'
