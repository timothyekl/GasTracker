class GasPurchase
  include DataMapper::Resource

  property :id, Serial
  property :timestamp, DateTime
  property :gallons, Float
  property :miles, Float
end
