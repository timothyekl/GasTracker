class GasTracker
  post '/get/purchases' do
    GasPurchase.all.to_json
  end
  
  post '/get/purchase/:id' do
    GasPurchase.first(:id => params[:id]).to_json
  end

  post '/add/purchase' do
    begin
      timestamp = DateTime.parse(params[:timestamp])
    rescue ArgumentError
      return {:success => false, :error => "Could not parse timestamp string"}.to_json
    end

    gallons = params[:gallons].to_f
    if gallons.to_s != params[:gallons]
      return {:success => false, :error => "Could not parse gallons"}.to_json
    end

    miles = params[:miles].to_f
    if miles.to_s != params[:miles]
      return {:success => false, :error => "Could not parse miles"}.to_json
    end

    cost = params[:cost].to_f
    if cost.to_s != params[:cost]
      return {:success => false, :error => "Could not parse cost"}.to_json
    end

    car_id = params[:car].to_i
    if car_id.to_s != params[:car]
      return {:success => false, :error => "Could not parse car ID"}.to_json
    end
    car = Car.first(:id => car_id)
    if car.nil?
      return {:success => false, :error => "Could not find car with ID %{id}" % {:id => car_id}}.to_json
    end

    driver_id = params[:driver].to_i
    if driver_id.to_s != params[:driver]
      return {:success => false, :error => "Could not parse driver ID"}.to_json
    end
    driver = Driver.first(:id => driver_id)
    if driver.nil?
      return {:success => false, :error => "Could not find driver with ID %{id}" % {:id => driver_id}}.to_json
    end

    purchase = GasPurchase.create(
      :timestamp => timestamp,
      :gallons => gallons,
      :miles => miles,
      :cost => cost,
      :car => car,
      :driver => driver
    )
    if purchase.save
      if params[:redirect] == nil
        return {:success => true}.to_json
      else
        redirect params[:redirect]
      end
    else
      return {:success => false, :error => "Could not save new purchase object"}.to_json
    end
  end
end
