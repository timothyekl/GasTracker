require 'sinatra/base'

require 'haml'
require 'sass'
require 'json'

require 'data_mapper'
Dir.glob('./helpers/*.rb').each { |f| require f }
Dir.glob('./models/*.rb').each { |f| require f }

class GasTracker < Sinatra::Base
  configure do
    set :sessions, true
    set :public, File.dirname(__FILE__) + "/public"
    set :prefixed_redirects, true

    DataMapper.setup(:default, "sqlite:database/development.db")
    DataMapper.auto_upgrade!
    DataMapper.finalize

    if Car.all.length == 0
      puts "Creating default car"
      car = Car.create(:description => "Default car")
      car.save
    end

    if Driver.all.length == 0
      puts "Creating default driver"
      driver = Driver.create(:name => "Default driver")
      driver.save
    end
  end

  get '/' do 
    redirect '/purchases'
  end

  run! if app_file == $0
end

Dir.glob('./routes/*.rb').each { |f| require f }
