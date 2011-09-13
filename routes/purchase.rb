class GasTracker
  get '/purchases' do
    conds = {}

    car_id = params[:car].to_i
    if !car_id.nil? && car_id.to_s == params[:car]
      car = Car.first(:id => car_id)
      if !car.nil?
        conds[:car] = car
      end
    end

    driver_id = params[:driver].to_i
    if !driver_id.nil? && driver_id.to_s == params[:driver]
      driver = Driver.first(:id => driver_id)
      if !driver.nil?
        conds[:driver] = driver
      end
    end

    @purchases = Purchase.all(:conditions => conds)

    haml :purchases
  end

  post '/get/purchases' do
    Purchase.all(:order => [ :timestamp.desc ]).to_json
  end
  
  post '/get/purchase/:id' do
    Purchase.first(:id => params[:id]).to_json
  end

  post '/add/purchase' do
    begin
      timestamp = DateTime.parse(params[:timestamp])
    rescue ArgumentError
      return {:success => false, :error => "Could not parse timestamp string", :value => params[:timestamp]}.to_json
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

    purchase = Purchase.create(
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

  post '/delete/purchase' do
    purchase_id = params[:id].to_i
    if purchase_id.to_s != params[:id]
      return {:success => false, :error => "Could not parse purchase ID", :value => purchase_id}
    end

    purchase = Purchase.first(:id => purchase_id)
    if !purchase.destroy
      return {:success => false, :error => "Could not destroy purchase", :value => purchase_id}
    end

    if params[:redirect].nil?
      return {:success => true}
    else
      redirect params[:redirect]
    end
  end
end
