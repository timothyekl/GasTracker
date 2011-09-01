class GasTracker
  post '/get/drivers' do
    Driver.all.to_json
  end
  
  post '/get/driver/:id' do
    Driver.first(:id => params[:id]).to_json
  end
end
