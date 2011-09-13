require 'gruff'

class GasTracker

  get '/stats' do
    haml :stats
  end

  get '/graph/gas_cost_over_time.png' do
    g = Gruff::Line.new
    g.title = "Gas cost over time"

    cost_data = Purchase.all.map{|p| p.cost_per_gallon}

    g.data("Cost", cost_data)
    
    path = './tmp/gas_cost_over_time.png'
    g.write(path)
    send_file path, :type => "image/png", :disposition => "inline"
  end

end
