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

  post '/get/purchases' do
    GasPurchase.all.to_json
  end

  post '/get/purchase/:id' do
    GasPurchase.first(:id => params[:id]).to_json
  end
  
  run! if app_file == $0
end
