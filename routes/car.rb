class GasTracker
  post '/get/cars' do
    Car.all.to_json
  end
  
  post '/get/car/:id' do
    Car.first(:id => params[:id]).to_json
  end
end
