require 'data_mapper'
Dir.glob('./models/*.rb').each { |f| require f }
DataMapper.setup(:default, "sqlite::memory:")
DataMapper.auto_upgrade!
DataMapper.finalize

@car = Car.create(:description => "Demo car")
@car.save
@driver = Driver.create(:name => "Demo driver")
@driver.save
@purchase = Purchase.create(:miles => 263.4, :cost => 32.3, :gallons => 9.5, :timestamp => DateTime.now, :car => @car, :driver => @driver)
@purchase.save

require 'uri'
require 'net/http'
def post(uri, data = {})
  res = Net::HTTP.post_form(URI.parse(uri), data)
  return res.body
end
