class GasTracker
  get '/cars' do
    haml :cars
  end

  post '/get/cars' do
    Car.all.to_json
  end
  
  post '/get/car/:id' do
    Car.first(:id => params[:id]).to_json
  end

  post '/add/car' do
    description = params[:description]

    car = Car.create(
        :description => description
    )
    if !car.save
      return {:success => false, :error => "Could not save car"}.to_json
    end
    
    if params[:redirect].nil?
      return {:success => true}.to_json
    else
      redirect params[:redirect]
    end
  end

  post '/delete/car' do
    car_id = params[:id].to_i
    if car_id.to_s != params[:id]
      return {:success => false, :error => "Could not parse car ID", :value => params[:id]}.to_json
    end

    car = Car.first(:id => car_id)
    if car.nil?
      return {:success => false, :error => "Could not find car", :value => car_id}.to_json
    end

    purchase_count = car.purchases.count
    car.purchases.destroy
    car.destroy

    if params[:redirect].nil?
      return {:success => true, :message => "Removed car #{car_id} and #{purchase_count} purchases"}.to_json
    else
      redirect params[:redirect]
    end
  end
end
