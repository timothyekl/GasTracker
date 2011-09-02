class GasTracker
  get '/drivers' do
    haml :drivers
  end

  post '/get/drivers' do
    Driver.all.to_json
  end
  
  post '/get/driver/:id' do
    Driver.first(:id => params[:id]).to_json
  end

  post '/add/driver' do
    name = params[:name]

    driver = Driver.create(
        :name => name
    )
    if !driver.save
      return {:success => false, :error => "Could not save driver"}.to_json
    end
    
    if params[:redirect].nil?
      return {:success => true}.to_json
    else
      redirect params[:redirect]
    end
  end
end
