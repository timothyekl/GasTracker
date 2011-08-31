class GasTracker
  post '/get/purchases' do
    GasPurchase.all.to_json
  end
  
  post '/get/purchase/:id' do
    GasPurchase.first(:id => params[:id]).to_json
  end
end
