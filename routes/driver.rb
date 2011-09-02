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

  post '/delete/driver' do
    driver_id = params[:id].to_i
    if driver_id.to_s != params[:id]
      return {:success => false, :error => "Could not parse driver ID", :value => params[:id]}.to_json
    end

    driver = Driver.first(:id => driver_id)
    if driver.nil?
      return {:success => false, :error => "Could not find driver", :value => driver_id}.to_json
    end

    purchase_count = driver.purchases.count
    driver.purchases.destroy
    driver.destroy

    if params[:redirect].nil?
      return {:success => true, :message => "Removed driver #{driver_id} and #{purchase_count} purchases"}.to_json
    else
      redirect params[:redirect]
    end
  end
end
